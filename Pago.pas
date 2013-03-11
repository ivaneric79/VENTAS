// --------------------------------------------------------------------------
// Archivo del Proyecto Ventas 
// Página del proyecto: http://sourceforge.net/projects/ventas
// --------------------------------------------------------------------------
// Este archivo puede ser distribuido y/o modificado bajo lo terminos de la
// Licencia Pública General versión 2 como es publicada por la Free Software
// Fundation, Inc.
// --------------------------------------------------------------------------

unit Pago;

interface

uses
  {$IFDEF MSWINDOWS}
      Windows,ShellApi,
  {$ENDIF}
  SysUtils, Types, Classes, QGraphics, QControls, QForms, QDialogs,
  QStdCtrls, QButtons, QcurrEdit, QGrids, IniFiles, QExtCtrls, Math,
  QMenus, QTypes;

type
  TfrmPago = class(TForm)
    grpPago: TGroupBox;
    Label1: TLabel;
    txtImporte: TcurrEdit;
    cmbTipo: TComboBox;
    Label2: TLabel;
    txtTotal: TcurrEdit;
    lblReferencia: TLabel;
    txtReferencia: TEdit;
    grpCredito: TGroupBox;
    Label4: TLabel;
    txtPagos: TcurrEdit;
    Label5: TLabel;
    txtPlazo: TcurrEdit;
    Label6: TLabel;
    txtInteres: TcurrEdit;
    Label7: TLabel;
    txtIntMorat: TcurrEdit;
    Label8: TLabel;
    Label10: TLabel;
    grpPagos: TGroupBox;
    Label11: TLabel;
    txtMonto: TcurrEdit;
    Label12: TLabel;
    txtParcialidades: TcurrEdit;
    Label13: TLabel;
    txtUltimoPago: TcurrEdit;
    Label14: TLabel;
    txtIntereses: TcurrEdit;
    Label15: TLabel;
    Label16: TLabel;
    txtFPrimerPago: TEdit;
    txtFUltimoPago: TEdit;
    Label3: TLabel;
    Panel1: TPanel;
    btnAceptar: TBitBtn;
    btnCancelar: TBitBtn;
    grdTipo: TStringGrid;
    grdListaPagos: TStringGrid;
    grpNotaCredito: TGroupBox;
    Label9: TLabel;
    txtNumeroNota: TcurrEdit;
    Label17: TLabel;
    txtImporteNota: TcurrEdit;
    lblCaja: TLabel;
    txtCaja: TcurrEdit;
    btnNotaCredito: TBitBtn;
    grdPagos: TStringGrid;
    CheckBox1: TCheckBox;
    PopupMenu1: TPopupMenu;
    O11: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure btnAceptarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure txtEngancheExit(Sender: TObject);
    procedure txtImporteExit(Sender: TObject);
    procedure grdListaPagosDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure txtNumeroNotaExit(Sender: TObject);
    procedure btnNotaCreditoClick(Sender: TObject);
    procedure cmbTipoSelect(Sender: TObject);
    procedure O11Click(Sender: TObject);


  private
    sPuertoCajon, sCajon, sCodigo, sNotaCred, sNotaCredGlobal : String;

    procedure CargaTipos;
    procedure RecuperaConfig;
    function VerificaDatos:boolean;
    function VerificaImporte:boolean;
    function ConvierteCodigos(sCodigos : String): String;
    function GetToken(sCadena, sSeparador: String; iToken: Integer): String;
    function GetTokenCount(Cadena,Separador:string):integer;
    procedure CalculaCredito;
    function VerificaDescuentos:boolean;
    function VerificaEnganche(rEngancheMinimo : real):boolean;
    procedure LimpiaDatos;
    function NotaCreditoRepetida: boolean;
    procedure ImporteFoco;
  public
    lstDescNoAcept : TStringList;
    sTipoOper : String;
    rCambio, rTotal, rLimiteCredito, rDescuentos : real;
    bfiscal,bAceptar, bLimiteCred : boolean;
    iCont, iCliente : integer;
    dteFecha : TDateTime;
    tipoc:string;
  

    procedure AbreCajon;
  end;

var
  frmPago: TfrmPago;

implementation

uses dm, MENU, notacredito;

{$R *.xfm}

procedure TfrmPago.FormShow(Sender: TObject);
begin
    grdPagos.RowCount := 1;
    lstDescNoAcept := TStringList.Create;

    CargaTipos;

    with dmDatos.qryConsulta do begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT SUM(importe-pagado) AS saldo FROM xcobrar WHERE estatus = ''A'' AND cliente = ' + IntToStr(iCliente));
        Open;
        rLimiteCredito := rLimitecredito - FieldByName('saldo').AsFloat;
        Close;
    end;

    txtTotal.Value := rTotal;
    txtImporte.Value := rTotal;
    LimpiaDatos;
    bAceptar := false;

    iCont := -1;

    txtImporte.SelectAll;
    ImporteFoco;

    grdListaPagos.Visible := false;
    grdListaPagos.Cells[0,0] := 'Pago';
    grdListaPagos.Cells[1,0] := 'Importe';
    grdListaPagos.ColWidths[0] := 115;
    grdListaPagos.ColWidths[1] := 60;

    cmbTipoSelect(Sender);
end;

procedure TfrmPago.CargaTipos;
var
    i : integer;
    sPago, sPagoCompras : String;
begin
    with dmDatos.qryConsulta do begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT * FROM tipopago t LEFT JOIN descuentospago p ON t.clave = p.tipopago');
        SQL.Add('WHERE aplica LIKE ''%' + sTipoOper + '%'' ORDER BY nombre');
        Open;

        cmbTipo.Items.Clear;
        grdTipo.RowCount := 1;
        i := grdTipo.RowCount;
        while(not Eof) do begin
            grdTipo.RowCount := i;
            cmbTipo.Items.Add(Trim(FieldByName('nombre').AsString));
            grdTipo.Cells[0,i-1] := Trim(FieldByName('clave').AsString);
            grdTipo.Cells[1,i-1] := Trim(FieldByName('nombre').AsString);
            grdTipo.Cells[2,i-1] := Trim(FieldByName('abrircajon').AsString);
            grdTipo.Cells[3,i-1] := Trim(FieldByName('referencia').AsString);
            grdTipo.Cells[4,i-1] := Trim(FieldByName('modo').AsString);
            grdTipo.Cells[5,i-1] := Trim(FieldByName('pagos').AsString);
            grdTipo.Cells[6,i-1] := Trim(FieldByName('plazo').AsString);
            grdTipo.Cells[7,i-1] := Trim(FieldByName('enganche').AsString);
            if(Length(grdTipo.Cells[7,i-1]) = 0) then
                grdTipo.Cells[7,i-1] := '0';
            grdTipo.Cells[8,i-1] := Trim(FieldByName('montominimo').AsString);
            grdTipo.Cells[9,i-1] := Trim(FieldByName('interes').AsString);
            grdTipo.Cells[10,i-1] := Trim(FieldByName('intmoratorio').AsString);
            grdTipo.Cells[11,i-1] := Trim(FieldByName('tipointeres').AsString);
            grdTipo.Cells[12,i-1] := Trim(FieldByName('tipoplazo').AsString);
            if(FieldByName('tipopago').AsInteger > 0) and (rDescuentos > 0) then // Si el tipo de pago no es aceptado en descuento
                lstDescNoAcept.Add(grdTipo.Cells[1,i-1]);

            Inc(i);
            Next;
        end;

        // Recupera el pago por defecto
        Close;
        SQL.Clear;
        SQL.Add('SELECT pagodef, pagocompras, notacredglobal FROM config');
        Open;
        sPago := FieldByName('pagodef').AsString;
        sPagoCompras := FieldByName('pagocompras').AsString;
        sNotaCredGlobal := FieldByName('notacredglobal').AsString;
        if(sNotaCredGlobal = 'S') then begin
            txtCaja.Enabled := false;
            txtCaja.Visible := false;
            lblCaja.Visible := false;
        end
        else begin
            txtCaja.Enabled := true;
            txtCaja.Visible := true;
            lblCaja.Visible := true;
        end;
        Close;

        cmbTipo.ItemIndex := 0;
        for i := 0 to grdTipo.RowCount - 1 do
            if(sTipoOper = 'V') then begin
                if(grdTipo.Cells[0,i] = sPago) then begin
                    cmbTipo.ItemIndex := i;
                    break;
                end;
            end
            else
                if(grdTipo.Cells[0,i] = sPagoCompras) then begin
                    cmbTipo.ItemIndex := i;
                    break;
                end;
    end;
   
end;

procedure TfrmPago.CalculaCredito;
var
    rPagos, rTotal, rInteresDiario : real;
    // para calculo del intereses compuestos
    rPlazos, rInteresAnual : Real;
begin
    if(grdTipo.Cells[4,cmbTipo.ItemIndex] = 'CREDITO') then begin  // Si el tipo de pago es crédito
        if(grdTipo.Cells[11,cmbTipo.ItemIndex] = 'S') then begin
            // Intereses simple
            txtMonto.Value := txtImporte.Value;
            rInteresDiario := txtInteres.Value * 12 / StrToFloat(grdTipo.Cells[12,cmbTipo.ItemIndex]);
            txtIntereses.Value := txtMonto.Value * rInteresDiario * txtPlazo.Value * txtPagos.Value / 100;
            rTotal := txtMonto.Value + txtIntereses.Value;

            rPagos := Trunc(rTotal / txtPagos.Value * 100) / 100;
            txtParcialidades.Value := rPagos;
            txtUltimoPago.Value := rPagos + rTotal - rPagos * txtPagos.Value;
            txtFUltimoPago.Text := FormatDateTime('dd/mm/yyyy',dteFecha + txtPlazo.Value * (txtPagos.Value));
            txtFPrimerPago.Text := FormatDateTime('dd/mm/yyyy',dteFecha + txtPlazo.Value);
        end else
        begin
            // Intereses compuesto
            txtMonto.Value := txtImporte.Value;

            // Plazos (en el menor unidad de tiempo: días, y después convierto en períodos meses)
            rPlazos := (txtPlazo.Value * txtPagos.Value) / StrToFloat(grdTipo.Cells[12,cmbTipo.ItemIndex]) * 12;

            // Tasa Anual
            rInteresAnual := txtInteres.Value * 12 / 100 / 12;
            // Ejemplo:
            // Interes mensual de 5% serán: 5 * 12 / 100 / 12 = (0.05) de tasa anual

            // Formula base del interes compuesto
            //
            // FV = PV * (1 + i) ^ t
            //
            // FV = valor futuro
            // PV = valor actual
            // i = tasa de interes anual
            // t = tiempo em cualquer unidad (años, meses o días)
            //
            // NOTA: Si en lugar de años, se utilizan meses, es necesario dividir
            // por 12. Así, 3 meses (pagos con plaro de 30 días) serán (3/12) años.
            //
            //       Si en lugar de años, se utilizan días, se divide por 365 (o 360). Así,
            // 75 días (3 pagos con plazos de 25 días) serán (75/365) anõs.
            //

            rTotal := txtMonto.Value * Power(1 + rInteresAnual, rPlazos);
            txtIntereses.Value := rTotal - txtMonto.Value;

            rPagos := Trunc(rTotal / txtPagos.Value * 100) / 100;
            txtParcialidades.Value := rPagos;
            txtUltimoPago.Value := rPagos + rTotal - rPagos * txtPagos.Value;
            txtFUltimoPago.Text := FormatDateTime('dd/mm/yyyy',dteFecha + txtPlazo.Value * (txtPagos.Value));
            txtFPrimerPago.Text := FormatDateTime('dd/mm/yyyy',dteFecha + txtPlazo.Value);
        end;
    end;
end;

procedure TfrmPago.btnAceptarClick(Sender: TObject);
var
    i : integer;
begin


    btnAceptar.SetFocus;
    if (VerificaDatos) then begin
        Inc(iCont);
        grdPagos.RowCount := iCont + 1;

        grdPagos.Cells[0,iCont] := grdTipo.Cells[0,cmbTipo.ItemIndex]; // Clave del tipo de pago
        if(txtImporte.Value > txtTotal.Value) then
            grdPagos.Cells[1,iCont] := FloatToStr(txtTotal.Value)      // Importe
        else
            grdPagos.Cells[1,iCont] := FloatToStr(txtImporte.Value);

        grdPagos.Cells[2,iCont] := txtReferencia.Text;                 // Referencia
        grdPagos.Cells[3,iCont] := grdTipo.Cells[2,cmbTipo.ItemIndex]; // Abrir cajón
        grdPagos.Cells[4,iCont] := grdTipo.Cells[4,cmbTipo.ItemIndex]; // Credito
        if(grdPagos.Cells[4,iCont] = 'CREDITO') then begin // si es Credito
            grdPagos.Cells[1,iCont] := FloatToStr(txtMonto.Value);

            grdPagos.Cells[5,iCont] := grdTipo.Cells[5,cmbTipo.ItemIndex]; // Pagos
            grdPagos.Cells[6,iCont] := grdTipo.Cells[6,cmbTipo.ItemIndex]; // Plazo
            grdPagos.Cells[7,iCont] := FormatDateTime('dd/mm/yyyy',StrToDate(txtFPrimerPago.Text));  // Fecha de primer pago
            grdPagos.Cells[8,iCont] := grdTipo.Cells[9,cmbTipo.ItemIndex]; // Interes
            grdPagos.Cells[9,iCont] := grdTipo.Cells[10,cmbTipo.ItemIndex]; // Interes moratorio
            grdPagos.Cells[10,iCont] := grdTipo.Cells[11,cmbTipo.ItemIndex]; // Tipo Interes
            grdPagos.Cells[11,iCont] := grdTipo.Cells[12,cmbTipo.ItemIndex]; // Tipo de plazo
            grdPagos.Cells[12,iCont] := FloatToStr(txtParcialidades.Value); // Monto de las Parcialidad*es
            grdPagos.Cells[13,iCont] := FloatToStr(txtMonto.Value + txtIntereses.Value); // Monto total con intereses
        end;
        if(grdPagos.Cells[4,iCont] = 'NOTA DE CREDITO') then begin // si es Nota de crédito
            grdPagos.Cells[5,iCont] := FloatToStr(txtNumeroNota.Value); // Número de nota de credito
            grdPagos.Cells[6,iCont] := sNotaCred; // Clave de nota de credito
        end;

        grdListaPagos.RowCount := iCont + 2;
        grdListaPagos.Cells[0,iCont + 1] := cmbTipo.Text;
        grdListaPagos.Cells[1,iCont + 1] := grdPagos.Cells[1,iCont];

        txtTotal.Value := StrToFloat(FormatFloat('0.00',txtTotal.Value - txtImporte.Value));
        txtImporte.Value := txtTotal.Value;

      

        if(txtTotal.Value <= 0) then begin // Si ya se cubrió el total, cierra la ventana
            for i := 0 to grdPagos.RowCount - 1 do
                if(grdPagos.Cells[3,i] = 'S') then begin
                    AbreCajon;
                    break;
                end;
            grdListaPagos.Visible := false;
            bAceptar := true;
    
               bfiscal := CheckBox1.Checked;

            Close;
        end;
        LimpiaDatos;
    end;
end;

procedure TfrmPago.RecuperaConfig;
var
    iniArchivo : TIniFile;
    sIzq, sArriba, sValor : String;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) +'config.ini');

    with iniArchivo do begin
        //Recupera la posición Y de la ventana
        sArriba := ReadString('Pago', 'Posy', '');

        //Recupera la posición X de la ventana
        sIzq := ReadString('Pago', 'Posx', '');

        if (Length(sIzq) > 0) and (Length(sArriba) > 0) then begin
            Left := StrToInt(sIzq);
            Top := StrToInt(sArriba);
        end;

        //Recupera el puerto a que esta conectado el cajon
        sValor := ReadString('Config', 'PuertoCajon', '');
        if (Length(sValor) > 0) then
            sPuertoCajon := sValor
        else
            sPuertoCajon := '';

        //Recupera el nombre del archivo para expulsar el cajon
        sValor := iniArchivo.ReadString('Config', 'AbrirCajon', '');
        if (Length(sValor) > 0) then
            sCodigo := ConvierteCodigos(sValor);

        //Recupera el nombre del archivo para expulsar el cajon
        sValor := ReadString('Config', 'AbreCajon', '');
        if (Length(sValor) > 0) then
            sCajon := sValor
        else
            sCajon := '';

        //Recupera el número de caja
        sValor := ReadString('Config', 'Caja', '');
        if (Length(sValor) > 0) then
            txtCaja.Value := StrToInt(sValor)
        else
            txtCaja.Value := 1;

        Free;
    end;
end;

procedure TfrmPago.FormClose(Sender: TObject; var Action: TCloseAction);
var
    iniArchivo : TIniFile;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) +'config.ini');
    with iniArchivo do begin
        // Registra la posición y de la ventana
        WriteString('Pago', 'Posy', IntToStr(Top));

        // Registra la posición X de la ventana
        WriteString('Pago', 'Posx', IntToStr(Left));
        Free;
    end;
    lstDescNoAcept.Free;
end;

function TfrmPago.VerificaDatos:boolean;
var
    rEngancheForzoso : real;
begin
    Result := true;
    rEngancheForzoso := txtImporte.Value * StrToFloat(grdTipo.Cells[7,cmbTipo.ItemIndex]) / 100;
    rEngancheForzoso := Trunc(rEngancheForzoso * 100) / 100;
    btnAceptar.SetFocus;

    if(not VerificaDescuentos) then begin
        ImporteFoco;
        Result := false;
    end
    else if(grdTipo.Cells[4,cmbTipo.ItemIndex] = 'CREDITO') and (txtImporte.Value < StrTofloat(grdTipo.Cells[9,cmbTipo.ItemIndex])) then begin
        Application.MessageBox('Para este tipo de pago el importe mínimo es de: ' + FormatFloat('$#,##0.00',StrTofloat(grdTipo.Cells[9,cmbTipo.ItemIndex])),'Error',[smbOK],smsCritical);
        txtImporte.SetFocus;
        Result := false;
    end
    else if(grdTipo.Cells[4,cmbTipo.ItemIndex] = 'CREDITO') and (iCliente = 0) and (sTipoOper = 'V') then begin
        Application.MessageBox('Para este tipo de pago se requiere introducir un cliente','Error',[smbOK],smsCritical);
        txtImporte.SetFocus;
        Result := false;
    end
    else if(grdTipo.Cells[4,cmbTipo.ItemIndex] = 'CREDITO') and (txtMonto.Value > rLimiteCredito) and (sTipoOper = 'V') and (bLimiteCred = True) then begin
        Application.MessageBox('El cliente a sobrepasado su limite de crédito','Error',[smbOK],smsCritical);
        txtImporte.SetFocus;
        Result := false;
    end
    else if(grdTipo.Cells[4,cmbTipo.ItemIndex] = 'NOTA DE CREDITO') and (txtImporteNota.Value = 0) and (sTipoOper = 'V') then begin
        Application.MessageBox('Introduce un número de nota de crédito válido','Error',[smbOK],smsCritical);
        txtNumeroNota.SetFocus;
        Result := false;
    end
    else if(not NotaCreditoRepetida) and (sTipoOper = 'V') then begin
        Application.MessageBox('El número de nota de crédito especificado ya fue tomado en cuenta para el pago, no es posible duplicar','Error',[smbOK],smsCritical);
        txtNumeroNota.SetFocus;
        Result := false;
    end
    else if(grdTipo.Cells[4,cmbTipo.ItemIndex] = 'NOTA DE CREDITO') and (txtImporteNota.Value > txtTotal.Value) and (sTipoOper = 'V') then begin
        Application.MessageBox('El importe de la nota de crédito no puede ser mayor al importe total a pagar','Error',[smbOK],smsCritical);
        txtNumeroNota.SetFocus;
        Result := false;
    end
    else if(txtImporte.Value = 0) then begin
        Application.MessageBox('Introduce el importe','Error',[smbOK],smsCritical);
        ImporteFoco;
        Result := false;
    end
    else if(Length(txtReferencia.Text) = 0) and (txtReferencia.Visible) then begin
        Application.MessageBox('Introduce la referencia del pago','Error',[smbOK],smsCritical);
        txtReferencia.SetFocus;
        Result := false;
    end
    else if(grdTipo.Cells[4,cmbTipo.ItemIndex] = 'CREDITO') and (txtTotal.Value < txtImporte.Value) then begin
        Application.MessageBox('Con este tipo de pago el importe pagado no puede ser mayor que el total','Error',[smbOK],smsCritical);
        txtImporte.SetFocus;
        Result := false;
    end
    else if(not VerificaEnganche(rEngancheForzoso)) then begin
        Application.MessageBox('Para este tipo de pago el enganche debe ser de al menos. Pague al menos: ' + Formatfloat('$#,##0.00',rEngancheforzoso) + ' con otro tipo de pago','Error',[smbOK],smsCritical);
        cmbTipo.SetFocus;
        Result := false;
    end
    else if(not VerificaImporte) then begin
        Result := false;
    end;
end;

function TfrmPago.VerificaEnganche(rEngancheMinimo : real):boolean;
var
    i : integer;
    rSuma : real;
begin
    Result := true;
    if(grdTipo.Cells[4,cmbTipo.ItemIndex] = 'CREDITO') then begin
        rSuma := 0;
        for i := 0 to grdPagos.RowCount - 1 do
            if(grdPagos.Cells[4,i] <> 'CREDITO') and (grdPagos.Cells[1,i] <> '') then
                rSuma := rSuma + StrToFloat(grdPagos.Cells[1,i]);
        if(rSuma < rEngancheMinimo) then
            Result := false;
    end;        
end;

function TfrmPago.VerificaDescuentos:boolean;
var
    i : integer;
    sMensaje : String;
    rSuma : real;
begin
    Result := true;
    if(rDescuentos > 0) and (lstDescNoAcept.IndexOf(cmbTipo.Items.Strings[cmbTipo.ItemIndex]) = - 1) then begin
        rSuma := 0;
        for i := 0 to grdPagos.RowCount - 1 do // Suma todos los tipos de pago iguales al seleccionado actualmente
            if(grdPagos.Cells[0,i] = grdTipo.Cells[0,cmbTipo.ItemIndex]) and (grdPagos.Cells[0,i] <> '') then
                rSuma := rSuma + StrToFloat(grdPagos.Cells[1,i]);
        rSuma := rSuma + txtImporte.Value;
        if(rTotal - rDescuentos < rSuma) then begin
            sMensaje := 'La venta contiene descuentos, se debe de pagar al menos ' +
                         FormatFloat('$#,##0.00',rDescuentos) + #10 + 'con los siguientes tipos de pago:' + #10;
            for i := 0 to lstDescNoAcept.Count - 1 do
                sMensaje := sMensaje + lstDescNoAcept.Strings[i] + #10;
            Application.MessageBox(sMensaje,'Error',[smbOk],smsCritical);
            Result := false;
        end;
    end;
end;

function TfrmPago.VerificaImporte:boolean;
begin
    Result := true;
    if(txtImporte.Value < txtTotal.Value) then begin
        if(Application.MessageBox('El importe no es suficiente para cubrir el precio total'+#13+
                                  '¿Deseas agregar otro tipo de pago?','Pago',[smbOK]+[smbCancel],smsWarning) = smbOK) then begin
            Width := 524;
            grdListaPagos.Visible := true;

            cmbTipo.SetFocus;
        end
        else begin
            ImporteFoco;
            Result := false;
        end;
    end
    else begin
        rCambio := txtImporte.Value - txtTotal.Value;
        txtImporte.Value := txtTotal.Value;
    end;
end;

procedure TfrmPago.ImporteFoco;
begin
    if(txtImporte.Enabled) then
        txtImporte.SetFocus
    else
        btnAceptar.SetFocus;
end;

procedure TfrmPago.AbreCajon;
var
    szArchivo : array[0..90] of char;
    iCajon : TextFile;
begin
    if(Length(Trim(sPuertoCajon)) > 0) then begin
        Assignfile(iCajon,sPuertoCajon); //Puerto: LPT1, COM1, etc;
        Rewrite(iCajon);
        Writeln(iCajon,sCodigo);
        CloseFile(iCajon);
    end
    else if(Length(sCajon) > 0) then begin
        {$IFDEF MSWINDOWS}
            StrPCopy(szArchivo,sCajon);
            Winexec(szArchivo,SW_HIDE);
        {$ENDIF}
    end;
end;

function TfrmPago.ConvierteCodigos(sCodigos : String): String;
var
    sRegreso : String;
    n : integer;
    cByte : byte;
begin
    sRegreso := '';
    for n := 1 to GetTokenCount(sCodigos,' ') do
        try
            cByte := StrToInt(GetToken(sCodigos,' ',n));
            sRegreso := sRegreso + chr(cByte);
        except
            break;
        end;
    Result := sRegreso;
end;

function TfrmPago.GetToken(sCadena, sSeparador: String; iToken: Integer): String;
var
    iPosicion: Integer;
begin
    while iToken > 1 do begin
        Delete(sCadena, 1, Pos(sSeparador,sCadena) + Length(sSeparador) - 1);
        Dec(iToken);
    end;
    iPosicion := Pos(sSeparador, sCadena);
    if iPosicion = 0 then
        Result:= sCadena
    else
        Result:= Copy(sCadena, 1, iPosicion - 1);
end;

function TfrmPago.GetTokenCount(Cadena,Separador:string):integer;
var
    Posicion:integer;
begin
    Posicion := Pos(Separador,Cadena);
    Result := 1;

    if Cadena <> '' then begin
        if Posicion <> 0 then
            while Posicion <> 0 do begin
                Delete(Cadena,1,Posicion);
                Posicion := Pos(Separador,Cadena);
                Inc (Result);
            end;
        end
        else
            Result := 0;
end;

procedure TfrmPago.FormCreate(Sender: TObject);
begin
    RecuperaConfig;
end;

procedure TfrmPago.txtEngancheExit(Sender: TObject);
begin
    CalculaCredito;
end;

procedure TfrmPago.txtImporteExit(Sender: TObject);
begin
    if(grdTipo.Cells[4,cmbTipo.ItemIndex] = 'CREDITO') then
        CalculaCredito;
end;

procedure TfrmPago.grdListaPagosDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var
    sCad : String;
    i : real;
begin
    sCad := (Sender as TStringGrid).Cells[ACol,ARow];
    if(Length(sCad) > 0) then begin
        if(ARow = 0) or (ACol = 0) then begin
            i := Rect.Left + (Rect.Right - Rect.Left) / 2 - (Sender as TStringGrid).Canvas.TextWidth(sCad) / 2;
            (Sender as TStringGrid).Canvas.FillRect(Rect);
            (Sender as TStringGrid).Canvas.TextOut(Round(i),Rect.Top + 2,sCad);
        end;
        if(ACol = 1) and (ARow > 0) then begin
            sCad := FormatFloat('#,##0.00',StrToFloat(sCad));

            i := Rect.Right - (Sender as TStringGrid).Canvas.TextWidth(sCad + ' ');
            (Sender as TStringGrid).Canvas.FillRect(Rect);
            (Sender as TStringGrid).Canvas.TextOut(Round(i),Rect.Top + 2,sCad);
        end;
    end;
end;

procedure TfrmPago.txtNumeroNotaExit(Sender: TObject);
begin
    with dmDatos.qryConsulta do begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT clave, importe FROM notascredito WHERE estatus = ''A'' AND numero = ' + FloatToStr(txtNumeroNota.Value));
        if(sNotaCredGlobal <> 'S') then
            SQL.Add('AND caja = ' + FormatFloat('0',txtCaja.Value));
        Open;
        txtImporteNota.Value := FieldByName('importe').AsFloat;
        txtImporte.Value := FieldByName('importe').AsFloat;
        sNotaCred := FieldByName('clave').AsString;
        Close;
    end;
end;

procedure TfrmPago.LimpiaDatos;
begin
    txtReferencia.Clear;
    txtImporteNota.Value := 0;
    txtNumeroNota.Value := 0;
    txtPagos.Value := 0;
    txtPlazo.Value := 0;
    txtInteres.Value := 0;
    txtIntMorat.Value := 0;
    txtMonto.Value := 0;
    txtIntereses.Value := 0;
    txtParcialidades.Value := 0;
    txtUltimoPago.Value := 0;
    txtFUltimoPago.Clear;
    txtFPrimerPago.Clear;
end;

function TfrmPago.NotaCreditoRepetida: boolean;
var
    i : integer;
begin
    Result := true;
    for i := 0 to grdPagos.RowCount - 1 do begin
        if(grdPagos.Cells[4,i] = 'NOTA DE CREDITO') then
            if(grdPagos.Cells[5,i] = FloatToStr(txtNumeroNota.Value)) then begin
                Result := false;
                break;
            end;
    end;
end;

procedure TfrmPago.btnNotaCreditoClick(Sender: TObject);
begin
    with TFrmNotaCredito.Create(Self) do
    try
        sTipo := 'Consulta';
        ShowModal;
        if(bSeleccion) then begin
            Self.txtNumeroNota.Value := StrToInt(sNota);
            Self.txtCaja.Value := StrToInt(sCaja);
            txtNumeroNotaExit(Sender);
        end;
    finally
        Free;
    end;
    btnAceptar.SetFocus;
end;

procedure TfrmPago.cmbTipoSelect(Sender: TObject);
begin
    // Si pide referencia
    if(grdTipo.Cells[3,cmbTipo.ItemIndex] = 'S') then begin
        lblReferencia.Visible := true;
        txtReferencia.Visible := true;
        txtReferencia.Enabled := true;
    end
    else begin
        lblReferencia.Visible := false;
        txtReferencia.Visible := false;
        txtReferencia.Enabled := false;
    end;

    // Si es crédito
    if(grdTipo.Cells[4,cmbTipo.ItemIndex] = 'CREDITO') then begin
        grpNotaCredito.Visible := false;
        grpCredito.Visible := true;
        txtImporte.Enabled := true;
        grpPagos.Visible := true;
        txtPagos.Value := StrToInt(grdTipo.Cells[5,cmbTipo.ItemIndex]);
        txtPlazo.Value := StrToInt(grdTipo.Cells[6,cmbTipo.ItemIndex]);
        txtInteres.Value := StrToFloat(grdTipo.Cells[9,cmbTipo.ItemIndex]);
        txtIntMorat.Value := StrToFloat(grdTipo.Cells[10,cmbTipo.ItemIndex]);
        if(txtPagos.Value = 1) then
            txtParcialidades.Enabled := false
        else
            txtParcialidades.Enabled := true;
        CalculaCredito;
        Height := 354;
        Width := 524;
    end
    else begin
        grpCredito.Visible := false;
        grpPagos.Visible := false;
        if(grdTipo.Cells[4,cmbTipo.ItemIndex] = 'NOTA DE CREDITO') then begin
            grpNotaCredito.Visible := true;
            txtImporte.Value := 0;
            txtImporte.Enabled := false;
            Height := 262;
        end
        else begin
            grpNotaCredito.Visible := false;
            txtImporte.Enabled := true;
            Height := 182;
        end;
        if(grdListaPagos.Visible) then
            Width := 524
        else
            Width := 326;
    end;
end;





procedure TfrmPago.O11Click(Sender: TObject);
begin
if(tipoc = 'TICKET') then begin
if (CheckBox1.Checked = true) then
begin
frmPago.Caption:='Pago 2';
CheckBox1.Checked:= false;
end
else
begin
frmPago.Caption:='Pago';
CheckBox1.Checked:= true;
end;
end;

end;

end.
