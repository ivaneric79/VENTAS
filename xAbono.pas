// --------------------------------------------------------------------------
// Archivo del Proyecto Ventas
// Página del proyecto: http://sourceforge.net/projects/ventas
// --------------------------------------------------------------------------
// Este archivo puede ser distribuido y/o modificado bajo lo terminos de la
// Licencia Pública General versión 2 como es publicada por la Free Software
// Fundation, Inc.
// --------------------------------------------------------------------------

unit xAbono;

interface

uses
  SysUtils, Types, Classes, Variants, QTypes, QGraphics, QControls, QForms,
  QDialogs, QStdCtrls, QcurrEdit, QButtons, IniFiles, QGrids, Math;

type
  TfrmXAbono = class(TForm)
    grpAbono: TGroupBox;
    txtImporte: TcurrEdit;
    Label1: TLabel;
    Label29: TLabel;
    txtDia: TEdit;
    txtMes: TEdit;
    txtAnio: TEdit;
    Label30: TLabel;
    Label31: TLabel;
    btnAceptar: TBitBtn;
    btnCancelar: TBitBtn;
    grpCredito: TGroupBox;
    txtImporteIni: TcurrEdit;
    Label4: TLabel;
    txtInteres: TcurrEdit;
    Label5: TLabel;
    txtIntMorat: TcurrEdit;
    Label6: TLabel;
    Label2: TLabel;
    txtComentario: TEdit;
    Label3: TLabel;
    txtAPagar: TcurrEdit;
    cmbTipo: TComboBox;
    Label7: TLabel;
    Label8: TLabel;
    txtPagado: TcurrEdit;
    procedure Salta(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure btnAceptarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure txtAnioExit(Sender: TObject);
    procedure txtDiaExit(Sender: TObject);
  private
    function VerificaDatos : boolean;
    function VerificaFechas(sFecha : string):boolean;
    function VerificaImporte : boolean;
    function VerificaFechaPago(sFechaPago : string):boolean;
    procedure CargaTipos;
    procedure RecuperaConfig;
    procedure Rellena(Sender: TObject);
  public
    rImporte, rInteres, rIntMorat, rPagado, rTipoPlazo, rImporteIni : real;
    sFecha, sFechaCredito, sProxPago, sFechaPago, sComentario, sAbrirCajon, sTipoPago, sTipoInteres : String;
    bAbono : boolean;
  end;

var
  frmXAbono: TfrmXAbono;

implementation

uses dm, Pago;

{$R *.xfm}

procedure TfrmXAbono.FormShow(Sender: TObject);
begin
    CargaTipos;
    RecuperaConfig;

    txtDia.Text := FormatDateTime('dd',Date);
    txtMes.Text := FormatDateTime('mm',Date);
    txtAnio.Text := FormatDateTime('yyyy',Date);

    txtImporteIni.Value := rImporteIni;
    txtPagado.Value := rPagado;
//    txtAPagar.Value := rImporte;
//    txtImporte.Value := txtAPagar.Value;

    txtAnioExit(Sender);
end;

procedure TfrmXAbono.CargaTipos;
begin
    with dmDatos.qryConsulta do begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT * FROM tipopago');
        SQL.Add('WHERE modo = ''CONTADO'' ORDER BY nombre');
        Open;

        cmbTipo.Items.Clear;
        while(not Eof) do begin
            cmbTipo.Items.Add(Trim(FieldByName('nombre').AsString));
            Next;
        end;
    end;
end;

procedure TfrmXAbono.btnAceptarClick(Sender: TObject);
begin
    bAbono := false;
    btnAceptar.SetFocus;
    if (VerificaDatos) then begin
        sFechaPago := txtMes.Text + '/' + txtDia.Text + '/' + txtAnio.Text;
        rImporte := txtImporte.Value;

        rInteres := txtInteres.Value;
        rIntMorat:= txtIntMorat.Value;
        sComentario := txtComentario.Text;
        with dmDatos.qryConsulta do begin
            Close;
            SQL.Clear;
            SQL.Add('SELECT clave FROM tipopago WHERE nombre = ''' + cmbTipo.Text + '''');
            Open;

            sTipoPago := FieldByName('clave').AsString;
        end;

//      if(sAbrirCajon = 'S') then
        frmPago.AbreCajon;

        bAbono := true;
        Close;
    end;
end;

function TfrmXAbono.VerificaDatos : boolean;
begin
    btnAceptar.SetFocus;
    Result := true;
    if (txtImporte.Value = 0) then begin
        Application.MessageBox('Introduce el importe','Error',[smbOK],smsCritical);
        txtImporte.SetFocus;
        Result := false;
    end
    else if (not VerificaImporte) then begin
        Application.MessageBox('El importe pagado no puede ser mayor al total a pagar','Error',[smbOK],smsCritical);
        txtImporte.SetFocus;
        Result := false;
    end
    else if (not VerificaFechas(txtDia.Text + '/' + txtMes.Text + '/' + txtAnio.Text)) then begin
        Application.MessageBox('Introduce una fecha correcta','Error',[smbOK],smsCritical);
        txtDia.SetFocus;
        Result := false;
    end
    else if (not VerificaFechaPago(txtDia.Text + '/' + txtMes.Text + '/' + txtAnio.Text)) then begin
        Result := false;
    end;
end;

function TfrmXAbono.VerificaFechas(sFecha : string) : boolean;
var
   dteFecha : TDateTime;
begin
   Result:=true;
   if(not TryStrToDate(sFecha,dteFecha)) then
      Result:=false;
end;


function TfrmXAbono.VerificaFechaPago(sFechaPago : string):boolean;
begin
    Result:= true;
    if(StrToDate(sFechaPago) < StrToDate(sFechaCredito)) then begin
        Application.MessageBox('La fecha de pago no puede ser menor a la fecha del crédito','Error',[smbOK],smsCritical);
        txtDia.SetFocus;
        Result := false;
    end
    else if(StrToDate(sFechaPago) > Date) then begin
        Application.MessageBox('La fecha de pago no puede ser mayor a la fecha actual','Error',[smbOK],smsCritical);
        txtDia.SetFocus;
        Result := false;
    end
end;

function TfrmXAbono.VerificaImporte : boolean;
begin
    Result:= true;
    if (txtImporte.Value > txtAPagar.Value) then
        Result := false;
end;

procedure TfrmXAbono.RecuperaConfig;
var
    iniArchivo : TIniFile;
    sIzq, sArriba, sValor : String;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) +'config.ini');

    with iniArchivo do begin
        //Recupera la posición Y de la ventana
        sArriba := ReadString('Abono', 'Posy', '');

        //Recupera la posición X de la ventana
        sIzq := ReadString('Abono', 'Posx', '');

        if (Length(sIzq) > 0) and (Length(sArriba) > 0) then begin
            Left := StrToInt(sIzq);
            Top := StrToInt(sArriba);
        end;

        //Recupera el último tipo de pago que se seleccionó
        sValor := ReadString('Abono', 'TipoPago', '');
        if (Length(sValor) > 0) then
            cmbTipo.ItemIndex := StrToInt(sValor)
        else
          cmbTipo.ItemIndex := 0;

        Free;
    end;
end;

procedure TfrmXAbono.FormClose(Sender: TObject; var Action: TCloseAction);
var
    iniArchivo : TIniFile;
    sValor     : String;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) +'config.ini');
    with iniArchivo do begin
        // Registra la posición y de la ventana
        WriteString('Abono', 'Posy', IntToStr(Top));

        // Registra la posición X de la ventana
        WriteString('Abono', 'Posx', IntToStr(Left));

        // Registra el último tipo de pago que se seleccionó
        sValor := ReadString('Abono', 'TipoPago', '');
        WriteString('Abono','TipoPago', IntToStr(cmbTipo.ItemIndex));
        
        Free;
    end;
end;

procedure TfrmXAbono.txtAnioExit(Sender: TObject);
var
    rIntDiario, rIntMoratDiario, rInteresAnual, rPlazos, rTotal : real;
begin
    txtAnio.Text := Trim(txtAnio.Text);
    if(Length(txtAnio.Text) < 4) and (Length(txtAnio.Text) > 0) then
        txtAnio.Text := IntToStr(StrToInt(txtAnio.Text) + 2000);

    sFecha := txtDia.Text + '/' + txtMes.Text + '/' + txtAnio.Text;
    if (VerificaFechas(sFecha)) then begin
        if(sTipoInteres = 'S') then begin
            // Intereses simple
            rIntDiario := rInteres * 12 / rTipoPlazo / 100;
            txtInteres.Value := txtImporteIni.Value * rIntDiario * (StrToDate(sFecha) - StrToDate(sFechaCredito));
            if (txtInteres.Value < 0) then
                txtInteres.Value := 0;

            rIntMoratDiario := rIntMorat * 12 / rTipoPlazo / 100;
            txtIntMorat.Value:= txtImporteIni.Value * rIntMoratDiario * (StrToDate(sFecha) - StrToDate(sProxPago) );
            if (txtIntMorat.Value < 0) then
                txtIntMorat.Value := 0;

        end else
        begin
            // Interes compuesto

            // Interes  ------------------------------------------
            // Plazos (en el menor unidad de tiempo: días, y después convierto en períodos meses)
            rPlazos := (StrToDate(sFecha) - StrToDate(sFechaCredito)) / rTipoPlazo * 12;
            if(rPlazos < 0) then
                rPlazos := 0;

            // Tasa Anual interes
            rInteresAnual :=  rInteres * 12 / 100 / 12;

            rTotal := txtImporteIni.Value * Power(1 + rInteresAnual, rPlazos);
            txtInteres.Value := rTotal - txtImporteIni.Value;
            if (txtInteres.Value < 0) then
                txtInteres.Value := 0;

            // Interes Moratorio ---------------------------------
            // Plazos (en el menor unidad de tiempo: días, y después convierto en períodos meses)
            rPlazos := (StrToDate(sFecha) - StrToDate(sProxPago)) / rTipoPlazo * 12;
            if(rPlazos < 0) then
                rPlazos := 0;

            // Tasa Anual interes Moratorio
            rInteresAnual :=  rIntMorat * 12 / 100 / 12;

            rTotal := (txtImporteIni.Value + txtInteres.Value) * Power(1 + rInteresAnual, rPlazos);
            txtIntMorat.Value:= rTotal - (txtImporteIni.Value + txtInteres.Value);
            if (txtIntMorat.Value < 0) then
                txtIntMorat.Value := 0;
        end;
        txtInteres.Value := Trunc (txtInteres.Value * 100) / 100;
        txtIntMorat.Value := Trunc (txtIntMorat.Value * 100) / 100;

        txtAPagar.Value := txtImporteIni.Value + txtInteres.Value + txtIntMorat.Value - txtPagado.Value;
        txtImporte.Value := txtAPagar.Value;

    end;
end;


procedure TfrmXAbono.Salta(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
    {Inicio (36), Fin (35), Izquierda (37), derecha (39), arriba (38), abajo (40)}
    if(Key >= 30) and (Key <= 122) and (Key <> 35) and (Key <> 36) and not ((Key >= 37) and (Key <= 40)) then
        if( Length((Sender as TEdit).Text) = (Sender as TEdit).MaxLength) then
            SelectNext(Sender as TWidgetControl, true, true);
end;

procedure TfrmXAbono.Rellena(Sender: TObject);
var
    i : integer;
begin
    for i := Length((Sender as TEdit).Text) to (Sender as TEdit).MaxLength - 1 do
        (Sender as TEdit).Text := '0' + (Sender as TEdit).Text;
end;

procedure TfrmXAbono.txtDiaExit(Sender: TObject);
begin
    Rellena(Sender);
end;

end.
