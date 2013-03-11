// --------------------------------------------------------------------------
// Archivo del Proyecto Ventas  
// Página del proyecto: http://sourceforge.net/projects/ventas
// --------------------------------------------------------------------------
// Este archivo puede ser distribuido y/o modificado bajo lo terminos de la
// Licencia Pública General versión 2 como es publicada por la Free Software
// Fundation, Inc.
// --------------------------------------------------------------------------

unit XCobrar;

interface

uses
  SysUtils, Types, Classes, Variants, QTypes, QGraphics, QControls, QForms,
  QDialogs, QStdCtrls, QGrids, QDBGrids, QComCtrls, QMenus, QExtCtrls, Math,
  QcurrEdit, QButtons, DB, IniFiles;

type
  TfrmXCobrar = class(TForm)
    pgeGeneral: TPageControl;
    tabDatos: TTabSheet;
    tabBusqueda: TTabSheet;
    grdListado: TDBGrid;
    grpCliente: TGroupBox;
    grpBuscar: TGroupBox;
    chkEstatus: TCheckBox;
    chkCliente: TCheckBox;
    chkNoComp: TCheckBox;
    chkFecha: TCheckBox;
    txtClienteBusq: TEdit;
    cmbEstatus: TComboBox;
    lblDesdeComp: TLabel;
    lblHastaComp: TLabel;
    txtCompFin: TcurrEdit;
    txtCompIni: TcurrEdit;
    chkComprobante: TCheckBox;
    cmbComprobante: TComboBox;
    rdgOrden: TRadioGroup;
    Label1: TLabel;
    pnlJuego: TPanel;
    pnlNoInventariable: TPanel;
    pnlNormal: TPanel;
    Label25: TLabel;
    Label24: TLabel;
    Label23: TLabel;
    btnBuscar: TBitBtn;
    btnSeleccionar: TBitBtn;
    btnLimpiar: TBitBtn;
    btnSalir: TBitBtn;
    Label26: TLabel;
    txtRegistros: TcurrEdit;
    Label4: TLabel;
    txtCliente: TEdit;
    GroupBox1: TGroupBox;
    grdCuentas: TStringGrid;
    chkVencim: TCheckBox;
    txtDiaVenIni: TEdit;
    txtMesVenIni: TEdit;
    txtAnioVenIni: TEdit;
    lblDiagVenMes1: TLabel;
    lblDiagVenDia1: TLabel;
    txtDiaVenFin: TEdit;
    txtMesVenFin: TEdit;
    txtAnioVenFin: TEdit;
    lblDiagVenMes2: TLabel;
    lblDiagVenDia2: TLabel;
    lblAlVen: TLabel;
    btnAbono: TBitBtn;
    btnCancelar: TBitBtn;
    MainMenu1: TMainMenu;
    Archivo1: TMenuItem;
    Pagos1: TMenuItem;
    Bsqueda1: TMenuItem;
    Buscar1: TMenuItem;
    Avanzaregistro1: TMenuItem;
    Retrocederegistro1: TMenuItem;
    N1: TMenuItem;
    Seleccionar1: TMenuItem;
    Fichas1: TMenuItem;
    Bsqueda2: TMenuItem;
    Cuentasporcobrar1: TMenuItem;
    grpCredito: TGroupBox;
    Label11: TLabel;
    txtPlazo: TcurrEdit;
    Label12: TLabel;
    txtInteres: TcurrEdit;
    Label13: TLabel;
    txtIntMorat: TcurrEdit;
    Label16: TLabel;
    Label17: TLabel;
    txtMonto: TcurrEdit;
    Label15: TLabel;
    txtApagar: TcurrEdit;
    Label9: TLabel;
    txtCantInteres: TcurrEdit;
    Label14: TLabel;
    txtCantIntMorat: TcurrEdit;
    Label28: TLabel;
    txtComprobante: TEdit;
    Label29: TLabel;
    txtPagos: TEdit;
    Label2: TLabel;
    Label8: TLabel;
    txtProximoPago: TEdit;
    Label3: TLabel;
    txtFecha: TEdit;
    Label5: TLabel;
    txtPagado: TcurrEdit;
    pnlEstatus: TPanel;
    Reportes1: TMenuItem;
    CobranzaGeneral1: TMenuItem;
    txtNumero: TcurrEdit;
    txtAnioFin: TEdit;
    lblDiagMes2: TLabel;
    txtMesFin: TEdit;
    lblDiagDia2: TLabel;
    txtDiaFin: TEdit;
    lblAl: TLabel;
    txtAnioIni: TEdit;
    lblDiagMes1: TLabel;
    txtMesIni: TEdit;
    lblDiagDia1: TLabel;
    txtDiaIni: TEdit;
    Limpiar1: TMenuItem;
    N2: TMenuItem;
    mnuConsultaDocumento: TMenuItem;
    BitBtn1: TBitBtn;
    procedure btnBuscarClick(Sender: TObject);
    procedure chkClienteClick(Sender: TObject);
    procedure chkFechaClick(Sender: TObject);
    procedure chkNoCompClick(Sender: TObject);
    procedure chkEstatusClick(Sender: TObject);
    procedure chkComprobanteClick(Sender: TObject);
    procedure btnSeleccionarClick(Sender: TObject);
    procedure btnSalirClick(Sender: TObject);
    procedure Salta(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure RecuperaDatos;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);    
    procedure grdCuentasDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure btnAbonoClick(Sender: TObject);
    procedure chkVencimClick(Sender: TObject);
    procedure Cuentasporcobrar1Click(Sender: TObject);
    procedure Bsqueda2Click(Sender: TObject);
    procedure Avanzaregistro1Click(Sender: TObject);
    procedure Retrocederegistro1Click(Sender: TObject);
    procedure grdListadoDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure btnCancelarClick(Sender: TObject);
    procedure grdCuentasClick(Sender: TObject);
    procedure CobranzaGeneral1Click(Sender: TObject);
    procedure btnLimpiarClick(Sender: TObject);
    procedure txtAnioIniExit(Sender: TObject);
    procedure txtAnioVenIniExit(Sender: TObject);
    procedure txtAnioFinExit(Sender: TObject);
    procedure txtAnioVenFinExit(Sender: TObject);
    procedure txtDiaIniExit(Sender: TObject);
    procedure mnuConsultaDocumentoClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    sCliente, sCredito, sImporte, sInteres, sInteresMorat, sComentario, sBM : string;
    sEstatus, sFechaPago, sTipoPago, sTipoInteres : string;
    rInteresDiario, rTipoPlazo, rInteresMorat, rInteresAnual, rPlazos : real;

    bAbono : boolean;

    function VerificaDatos : boolean;
    function VerificaFechas(sFecha : string) : boolean;
    procedure IniCuentas;
    procedure RecuperaPagos;
    procedure RecuperaConfig;
    procedure Rellena(Sender: TObject);
  public
    { Public declarations }
  end;

var
  frmXCobrar: TfrmXCobrar;

implementation

uses ClientesBusq, dm, xAbono, ReportesXCobrar;

{$R *.xfm}

procedure TfrmXCobrar.FormShow(Sender: TObject);
begin
    IniCuentas;
    RecuperaConfig;
    grdCuentasClick(Sender);
end;

procedure TfrmXCobrar.btnBuscarClick(Sender: TObject);
begin
   if(VerificaDatos) then begin
        dmDatos.cdsCliente1.Active := false;
        with dmDatos.qryListados1 do begin
            Close;
            SQL.Clear;
            SQL.Add('SELECT x.clave, c.clave AS cli_clave, c.nombre AS cliente,');
            SQL.Add('x.importe, x.pagado, x.proximopago, x.estatus, x.venta FROM xcobrar x LEFT JOIN');
            SQL.Add('clientes c ON x.cliente = c.clave LEFT JOIN ventas v ON');
            SQL.Add('x.venta = v.clave WHERE 1 = 1');

            if(chkCliente.Checked) then
                SQL.Add('AND x.cliente IN (SELECT clave FROM clientes WHERE nombre LIKE ''%' + txtClienteBusq.Text + '%'')');
            if(chkEstatus.Checked) then
                SQL.Add('AND x.estatus = ''' + Copy(cmbEstatus.Text,1,1) + '''');
            if(chkFecha.Checked) then begin
                SQL.Add('AND v.fecha >= ''' + txtMesIni.Text + '/' + txtDiaIni.Text + '/' + txtAnioIni.Text + '''');
                SQL.Add('AND v.fecha <= ''' + txtMesFin.Text + '/' + txtDiaFin.Text + '/' + txtAnioFin.Text + '''');
            end;
            if(chkVencim.Checked) then begin
                SQL.Add('AND x.proximopago >= ''' + txtMesVenIni.Text + '/' + txtDiaVenIni.Text + '/' + txtAnioVenIni.Text + '''');
                SQL.Add('AND x.proximopago <= ''' + txtMesVenFin.Text + '/' + txtDiaVenFin.Text + '/' + txtAnioVenFin.Text + '''');
            end;
            if(chkNoComp.Checked) then begin
                SQL.Add('AND x.venta IN (SELECT venta FROM comprobantes WHERE numero >= ' + FloatToStr(txtCompIni.Value));
                SQL.Add('AND numero <= ' + FloatToStr(txtCompFin.Value) + ')');
            end;
            if(chkComprobante.Checked) then begin
                SQL.Add('AND x.venta IN (SELECT venta FROM comprobantes ');
                SQL.Add('WHERE tipo = ''' + Copy(cmbComprobante.Text,1,1) + ''')');
            end;

            case rdgOrden.ItemIndex of
              0 : SQL.Add('ORDER BY c.nombre, x.proximopago');
              1 : SQL.Add('ORDER BY x.proximopago, c.nombre');
              2 : SQL.Add('ORDER BY x.estatus, v.fecha, v.hora');
             end;
             Open;
        end;

        with dmDatos.cdsCliente1 do begin
            Active := true;

            txtRegistros.Value := RecordCount;

            FieldByName('clave').Visible := false;
            FieldByName('cli_clave').Visible := false;
            FieldByName('venta').Visible := false;
            FieldByName('cliente').DisplayLabel := 'Cliente';
            FieldByName('cliente').DisplayWidth := 38;
            FieldByName('importe').DisplayLabel := 'Importe';
            FieldByName('importe').DisplayWidth := 10;
            (FieldByName('importe') as TNumericField).DisplayFormat := '#,##0.00';
            FieldByName('pagado').DisplayLabel := 'Pagado';
            FieldByName('pagado').DisplayWidth := 10;
            (FieldByName('pagado') as TNumericField).DisplayFormat := '#,##0.00';
            FieldByName('proximopago').DisplayLabel := 'Prox. pago';
            FieldByName('proximopago').DisplayWidth := 10;
            FieldByName('estatus').DisplayLabel := 'Estatus';

            try
                Bookmark := sBM;
            except
                txtRegistros.Value := txtRegistros.Value;
            end;
        end;

        if (pgeGeneral.ActivePage = tabBusqueda) then
            grdListado.SetFocus;
    end;
end;

function TfrmXCobrar.VerificaDatos : boolean;
begin
    Result := true;
    if(chkFecha.Checked) then begin
        if(not VerificaFechas(txtDiaIni.Text + '/' + txtMesIni.Text + '/' + txtAnioIni.Text)) then begin
            Application.MessageBox('Introduce una fecha válida','Error',[smbOK],smsCritical);
            txtDiaIni.SetFocus;
            Result := false;
        end
        else if(not VerificaFechas(txtDiaFin.Text + '/' + txtMesFin.Text + '/' + txtAnioFin.Text)) then begin
            Application.MessageBox('Introduce una fecha válida','Error',[smbOK],smsCritical);
            txtDiaFin.SetFocus;
            Result := false;
        end;
    end;
    if (chkVencim.Checked) and (Result) then begin
        if(not VerificaFechas(txtDiaVenIni.Text + '/' + txtMesVenIni.Text + '/' + txtAnioVenIni.Text)) then begin
            Application.MessageBox('Introduce una fecha válida','Error',[smbOK],smsCritical);
            txtDiaVenIni.SetFocus;
            Result := false;
        end
        else if(not VerificaFechas(txtDiaVenFin.Text + '/' + txtMesVenFin.Text + '/' + txtAnioVenFin.Text)) then begin
            Application.MessageBox('Introduce una fecha válida','Error',[smbOK],smsCritical);
            txtDiaVenFin.SetFocus;
            Result := false;
        end;
    end;
end;

function TfrmXCobrar.VerificaFechas(sFecha : string) : boolean;
var
   dteFecha : TDateTime;
begin
   Result:=true;
   if(not TryStrToDate(sFecha,dteFecha)) then begin
      Result:=false;
   end;
end;

procedure TfrmXCobrar.chkClienteClick(Sender: TObject);
begin
   if(chkCliente.Checked) then begin
        txtClienteBusq.Visible := true;
        if pgeGeneral.ActivePage = tabBusqueda then
            txtclienteBusq.SetFocus;
    end
    else
        txtClienteBusq.Visible := false;
end;

procedure TfrmXCobrar.chkFechaClick(Sender: TObject);
begin
    if(chkFecha.Checked) then begin
        txtDiaIni.Visible := true;
        txtMesIni.Visible := true;
        txtAnioIni.Visible := true;
        lblDiagDia1.Visible := true;
        lblDiagMes1.Visible := true;
        txtDiaFin.Visible := true;
        txtMesFin.Visible := true;
        txtAnioFin.Visible := true;
        lblDiagDia2.Visible := true;
        lblDiagMes2.Visible := true;
        lblAl.Visible := true;
        if pgeGeneral.ActivePage = tabBusqueda then
            txtDiaIni.SetFocus;
    end
    else begin
        txtDiaIni.Visible := false;
        txtMesIni.Visible := false;
        txtAnioIni.Visible := false;
        lblDiagDia1.Visible := false;
        lblDiagMes1.Visible := false;
        txtDiaFin.Visible := false;
        txtMesFin.Visible := false;
        txtAnioFin.Visible := false;
        lblDiagDia2.Visible := false;
        lblDiagMes2.Visible := false;
        lblAl.Visible := false;
    end;
end;

procedure TfrmXCobrar.chkNoCompClick(Sender: TObject);
begin
    if(chkNoComp.Checked) then begin
        txtCompIni.Visible:=True;
        txtCompfin.Visible:=True;
        lblDesdeComp.Visible:=True;
        lblHastaComp.visible:=True;
        if pgeGeneral.ActivePage = tabBusqueda then
            txtCompIni.SetFocus;
    end
    else begin
        txtCompIni.Visible:=False;
        txtCompfin.Visible:=False;
        lblDesdeComp.Visible:=False;
        lblHastaComp.visible:=False;
    end;
end;

procedure TfrmXCobrar.chkEstatusClick(Sender: TObject);
begin
    if(chkEstatus.Checked) then begin
        cmbEstatus.Visible := true;
        if(cmbEstatus.ItemIndex = -1) then
            cmbEstatus.ItemIndex := 0;
        if pgeGeneral.ActivePage = tabBusqueda then
            cmbEstatus.SetFocus;
    end
    else
        cmbEstatus.Visible := false;

end;

procedure TfrmXCobrar.chkComprobanteClick(Sender: TObject);
begin
    if(chkComprobante.Checked) then begin
        cmbComprobante.Visible:=True;
        if(cmbComprobante.ItemIndex = -1) then
            cmbComprobante.ItemIndex := 0;
        if pgeGeneral.ActivePage = tabBusqueda then
            cmbComprobante.SetFocus;
    end
    else
        cmbComprobante.Visible:=False;
end;

procedure TfrmXCobrar.btnSeleccionarClick(Sender: TObject);
begin
    if (txtRegistros.Value > 0) then
        RecuperaDatos;
end;

procedure TfrmXCobrar.btnSalirClick(Sender: TObject);
begin
    Close;
end;

procedure TfrmXCobrar.Salta(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
    {Inicio (36), Fin (35), Izquierda (37), derecha (39), arriba (38), abajo (40)}
    if(Key >= 30) and (Key <= 122) and (Key <> 35) and (Key <> 36) and not ((Key >= 37) and (Key <= 40)) then
        if( Length((Sender as TEdit).Text) = (Sender as TEdit).MaxLength) then
            SelectNext(Sender as TWidgetControl, true, true);
end;

procedure TfrmXCobrar.RecuperaDatos;
var
    rTotal : Real;
begin
    sCredito := dmDatos.cdsCliente1.FieldByName('clave').AsString;
    sEstatus := dmDatos.cdsCliente1.FieldByName('estatus').AsString;
    sBM := dmDatos.cdsCliente1.Bookmark;
    with dmDatos.qryConsulta do begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT c.clave AS cli_clave, c.nombre, x.*, o.tipo, o.numero AS num, o.fecha');
        SQL.Add('FROM xcobrar x LEFT JOIN clientes c ON x.cliente = c.clave');
        SQL.Add('LEFT JOIN comprobantes o ON x.venta = o.venta WHERE x.clave = ' + sCredito);
        SQL.Add('AND o.estatus = ''A''');
        Open;
        
        if(not Eof) then begin
            pgeGeneral.ActivePageIndex := 0;
            sCliente := FieldByName('cli_clave').AsString;
            txtCliente.Text:= Trim(FieldByName('nombre').AsString);
            txtComprobante.Text := FieldByName('tipo').AsString;
            txtNumero.Value := FieldByName('num').AsInteger;
            txtFecha.Text := FormatDateTime('dd/mm/yyyy',FieldByName('fecha').AsDateTime);
            txtPagos.Text := FieldByName('numpago').AsString;
            txtPlazo.Value := FieldByName('plazo').AsFloat;
            txtInteres.Value := FieldByName('interes').AsFloat;
            txtIntMorat.Value := FieldByName('intmoratorio').AsFloat;
            txtPagado.Value := FieldByName('pagado').AsFloat;
            txtMonto.Value := FieldByName('importe').AsFloat;
            txtProximoPago.Text := FormatDateTime('dd/mm/yyyy',FieldByName('proximopago').AsDateTime);
            rTipoPlazo := FieldByName('tipoplazo').AsFloat;
            sTipoInteres := FieldByName('tipointeres').AsString;

            if(FieldByName('estatus').AsString <> 'P') then begin
                if(sTipoInteres = 'S') then begin
                    // interes simple

                    rInteresDiario := txtInteres.Value * 12 / rTipoPlazo / 100;
                    txtCantInteres.Value := txtMonto.Value * rInteresDiario * (Date - StrToDate(txtFecha.Text));
                    if (txtCantInteres.Value < 0) then
                        txtCantInteres.Value := 0;

                    rInteresMorat :=  txtIntMorat.Value * 12 / rTipoPlazo / 100;
                    txtCantIntMorat.Value :=  txtMonto.Value * rInteresMorat * (Date - StrToDate(txtProximoPago.Text));
                    if (txtCantIntMorat.Value < 0) then
                        txtCantIntMorat.Value := 0;
                end else
                begin
                    // interes compuesto

                    // Interes  ------------------------------------------
                    // Plazos (en el menor unidad de tiempo: días, y después convierto en períodos meses)
                    rPlazos := (Date - StrToDate(txtFecha.Text)) / rTipoPlazo * 12;
                    if(rPlazos < 0) then
                        rPlazos := 0;

                    // Tasa Anual interes
                    rInteresAnual :=  txtInteres.Value * 12 / 100 / 12;

                    rTotal := txtMonto.Value * Power(1 + rInteresAnual, rPlazos);
                    txtCantInteres.Value := rTotal - txtMonto.Value;
                    if (txtCantInteres.Value < 0) then
                        txtCantInteres.Value := 0;

                    // Interes Moratorio ---------------------------------
                    // Plazos (en el menor unidad de tiempo: días, y después convierto en períodos meses)
                    rPlazos := (Date - StrToDate(txtProximoPago.Text)) / rTipoPlazo * 12;
                    if(rPlazos < 0) then
                        rPlazos := 0;

                    // Tasa Anual interes Moratorio
                    rInteresAnual :=  txtIntMorat.Value * 12 / 100 / 12;

                    rTotal := (txtMonto.Value + txtCantInteres.Value) * Power(1 + rInteresAnual, rPlazos);
                    txtCantIntMorat.Value := rTotal - (txtMonto.Value + txtCantInteres.Value);
                    if (txtCantIntMorat.Value < 0) then
                        txtCantIntMorat.Value := 0;
                end;

                btnAbono.Enabled := true;
            end
            else begin
                txtCantInteres.Value := FieldByName('cantinteres').AsFloat;
                txtCantIntMorat.Value :=  FieldByName('cantintmorat').AsFloat;
                btnAbono.Enabled := false;
            end;
            txtCantInteres.Value := Trunc(txtCantInteres.Value * 100) / 100;
            txtCantIntMorat.Value := Trunc(txtCantIntMorat.Value * 100) / 100;

            txtAPagar.Value := txtMonto.Value + txtCantInteres.Value + txtCantIntMorat.Value - txtPagado.Value;

            if(txtComprobante.Text = 'F') then
                txtComprobante.Text := 'FACTURA'
            else if(txtComprobante.Text = 'N') then
                txtComprobante.Text := 'NOTA'
            else if(txtComprobante.Text = 'T') then
                txtComprobante.Text := 'TICKET';

            if(FieldByName('estatus').AsString = 'A') then begin
                pnlEstatus.Caption := 'ACTIVA';
                pnlEstatus.Color := $00BFCAB7;
                btnAbono.Enabled := True;
                btnCancelar.Enabled := True;
            end
            else if(FieldByName('estatus').AsString = 'C') then begin
                pnlEstatus.Caption := 'CANCELADA';
                pnlEstatus.Color := $0099A7F7;
                btnAbono.Enabled := False;
                btnCancelar.Enabled := False;
            end
            else if(FieldByName('estatus').AsString = 'P') then begin
                pnlEstatus.Caption := 'PAGADA';
                pnlEstatus.Color := $00DCBFA5;
                btnAbono.Enabled := False;
                btnCancelar.Enabled := True;
            end;
        end;
        Close;
    end;
    RecuperaPagos;
end;

procedure TfrmXCobrar.RecuperaPagos;
var
    i : integer;
begin
    with dmDatos.qryConsulta do begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT x.*, t.nombre FROM xcobrarpagos x LEFT JOIN tipopago t ON x.tipopago = t.clave');
        SQL.Add('WHERE x.xcobrar = ' + sCredito + ' ORDER BY x.numero');
        Open;

        i := 1;
        grdCuentas.RowCount := i + 1;
        grdCuentas.Cells[0,1] := '';
        grdCuentas.Cells[1,1] := '';
        grdCuentas.Cells[2,1] := '';
        grdCuentas.Cells[3,1] := '';
        grdCuentas.Cells[4,1] := '';

        while(not Eof) do begin
            grdCuentas.RowCount := i + 1;
            grdCuentas.Cells[0,i] := FieldByName('numero').AsString;
            grdCuentas.Cells[1,i] := FieldByName('fecha').AsString;
            grdCuentas.Cells[2,i] := FieldByName('importe').AsString;
            grdCuentas.Cells[3,i] := FieldByName('nombre').AsString;
            grdCuentas.Cells[4,i] := FieldByName('comentario').AsString;
            Inc(i);
            Next;
        end;
        Close;
        grdCuentasClick(Self);
    end;
end;

procedure TfrmXCobrar.IniCuentas;
begin
    grdCuentas.RowCount := 2;
    grdCuentas.Cells[0,0] := 'Número';
    grdCuentas.Cells[1,0] := 'Fecha';
    grdCuentas.Cells[2,0] := 'Importe';
    grdCuentas.Cells[3,0] := 'Tipo de pago';
    grdCuentas.Cells[4,0] := 'Comentario';

    grdCuentas.ColWidths[0] := 50;
    grdCuentas.ColWidths[1] := 70;
    grdCuentas.ColWidths[2] := 70;
    grdCuentas.ColWidths[3] := 110;
    grdCuentas.ColWidths[4] := 320;
end;

procedure TfrmXCobrar.grdCuentasDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var
    sCad : String;
    i : real;
begin
    sCad := (Sender as TStringGrid).Cells[ACol,ARow];
    if(Length(sCad) > 0) then begin
        if(ARow = 0) or (ACol < 2) then begin
            i := Rect.Left + (Rect.Right - Rect.Left) / 2 - (Sender as TStringGrid).Canvas.TextWidth(sCad) / 2;
            (Sender as TStringGrid).Canvas.FillRect(Rect);
            (Sender as TStringGrid).Canvas.TextOut(Round(i),Rect.Top + 2,sCad);
        end;
        if(ACol = 2) and (ARow > 0) then begin
            sCad := FormatFloat('#,##0.00',StrToFloat(sCad));

            i := Rect.Right - (Sender as TStringGrid).Canvas.TextWidth(sCad + ' ');
            (Sender as TStringGrid).Canvas.FillRect(Rect);
            (Sender as TStringGrid).Canvas.TextOut(Round(i),Rect.Top + 2,sCad);
        end;
    end;
end;

procedure TfrmXCobrar.btnAbonoClick(Sender: TObject);
var
    iNumero : integer;
    rTotalDeuda, rTotalPagos : real;
begin
    bAbono := false;
    if (sEstatus = 'A') then
        with TFrmxAbono.Create(Self) do
        try
            rImporteIni:= txtMonto.Value;
            rInteres   := Self.txtInteres.Value;
            rIntMorat  := Self.txtIntMorat.Value;
            rPagado    := Self.txtPagado.Value;
            rTipoPlazo := Self.rTipoPlazo;
            sProxPago  := Self.txtProximoPago.Text;
            sFechaCredito := Self.txtFecha.Text;
            sTipoInteres := Self.sTipoInteres;

            ShowModal;
            if (bAbono) then  begin
                Self.sFechaPago := sFechaPago;
                Self.sImporte := FloatToStr(rImporte);
                Self.sInteres := FloatToStr(rInteres);
                Self.sInteresMorat := FloatToStr(rIntMorat);
                Self.sComentario := sComentario;
                Self.sTipoPago := sTipoPago;
                Self.bAbono := true;
            end;
        finally
            Free;
        end
    else if (sEstatus = 'P') then
        Application.MessageBox('La cuenta está saldada','Abono',[smbOK],smsWarning)
    else if (sEstatus = 'C') then
        Application.MessageBox('La cuenta está cancelada','Abono',[smbOK],smsWarning);

    if(bAbono) then begin
        with dmDatos.qryConsulta do begin
            Close;
            SQL.Clear;
            SQL.Add('SELECT MAX(numero) AS numero FROM xcobrarpagos WHERE xcobrar = ' + sCredito);
            Open;
            iNumero := FieldByName('numero').AsInteger + 1;

            Close;
            SQL.Clear;
            SQL.Add('INSERT INTO xcobrarpagos (xcobrar, numero, fecha, importe, interes, interesmorat, tipopago, comentario) VALUES(');
            SQL.Add(sCredito + ',' + IntToStr(iNumero) + ',''' + sFechaPago + ''',' + sImporte + ',' + sInteres + ',' + sInteresMorat + ',' + sTipoPago + ',''' + sComentario + ''')');
            ExecSQL;

            Close;
            SQL.Clear;
            SQL.Add('UPDATE xcobrar SET pagado = pagado + ' + sImporte + ',');
            SQL.Add('cantinteres = cantinteres + ' + sInteres + ',');
            SQL.Add('cantintmorat = cantintmorat + ' + sInteresMorat);
            SQL.Add('WHERE clave = ' + sCredito);
            ExecSQL;

            rTotalDeuda := txtMonto.Value + StrToFloat(sInteres) + StrToFloat(sInteresMorat);
            rTotalPagos := StrToFloat(sImporte) + txtPagado.Value;
            if (rTotalDeuda = rTotalPagos) then begin
                Close;
                SQL.Clear;
                SQL.Add('UPDATE xcobrar SET estatus = ''P'' WHERE clave = ' + sCredito);
                ExecSQL;
                Close;
            end;
          end;
          btnBuscar.Click;
          RecuperaDatos;
    end;
    if(btnAbono.Enabled) then
        btnAbono.SetFocus;
end;

procedure TfrmXCobrar.chkVencimClick(Sender: TObject);
begin
    if(chkVencim.Checked) then begin
        txtDiaVenIni.Visible := true;
        txtMesVenIni.Visible := true;
        txtAnioVenIni.Visible := true;
        lblDiagVenDia1.Visible := true;
        lblDiagVenMes1.Visible := true;
        txtDiaVenFin.Visible := true;
        txtMesVenFin.Visible := true;
        txtAnioVenFin.Visible := true;
        lblDiagVenDia2.Visible := true;
        lblDiagVenMes2.Visible := true;
        lblAlVen.Visible := true;
        if pgeGeneral.ActivePage = tabBusqueda then
            txtDiaVenIni.SetFocus;
    end
    else begin
        txtDiaVenIni.Visible := false;
        txtMesVenIni.Visible := false;
        txtAnioVenIni.Visible := false;
        lblDiagVenDia1.Visible := false;
        lblDiagVenMes1.Visible := false;
        txtDiaVenFin.Visible := false;
        txtMesVenFin.Visible := false;
        txtAnioVenFin.Visible := false;
        lblDiagVenDia2.Visible := false;
        lblDiagVenMes2.Visible := false;
        lblAlVen.Visible := false;
    end;

end;

procedure TfrmXCobrar.Cuentasporcobrar1Click(Sender: TObject);
begin
    pgeGeneral.ActivePage := tabDatos;
end;

procedure TfrmXCobrar.Bsqueda2Click(Sender: TObject);
begin
    pgeGeneral.ActivePage := tabBusqueda;
end;

procedure TfrmXCobrar.Avanzaregistro1Click(Sender: TObject);
begin
    if(dmDatos.cdsCliente1.Active) then begin
        dmDatos.cdsCliente1.Next;
        if(pgeGeneral.ActivePage <> tabBusqueda) then
            RecuperaDatos;
    end;
end;

procedure TfrmXCobrar.Retrocederegistro1Click(Sender: TObject);
begin
    if(dmDatos.cdsCliente1.Active) then begin
        dmDatos.cdsCliente1.Prior;
        if(pgeGeneral.ActivePage <> tabBusqueda) then
            RecuperaDatos;
    end;
end;

procedure TfrmXCobrar.grdListadoDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
    if(dmDatos.cdsCliente1.FieldByName('estatus').AsString = 'A') then
        (Sender as TDBGrid).Canvas.Brush.Color := $00BFCAB7
    else
    if(dmDatos.cdsCliente1.FieldByName('estatus').AsString = 'C') then
        (Sender as TDBGrid).Canvas.Brush.Color := $0099A7F7
    else
        (Sender as TDBGrid).Canvas.Brush.Color := $00DCBFA5;

    (Sender as TDBGrid).Canvas.FillRect(Rect);
    (Sender as TDBGrid).DefaultDrawColumnCell(Rect,DataCol,Column,State);
end;

procedure TfrmXCobrar.RecuperaConfig;
var
    iniArchivo : TIniFile;
    sIzq, sArriba, sValor : String;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) +'config.ini');

    with iniArchivo do begin
        //Recupera la posición Y de la ventana
        sArriba := ReadString('XCobrar', 'Posy', '');

        //Recupera la posición X de la ventana
        sIzq := ReadString('XCobrar', 'Posx', '');

        if (Length(sIzq) > 0) and (Length(sArriba) > 0) then begin
            Left := StrToInt(sIzq);
            Top := StrToInt(sArriba);
        end;

        //Recupera la ultima ficha que se seleccionó
        sValor := ReadString('XCobrar', 'Ficha', '');
        if (Length(sValor) > 0) then
            pgeGeneral.ActivePageIndex := StrToInt(sValor);

        //Recupera las opciones de búsqueda
        sValor := ReadString('XCobrar', 'Cliente', '');
        if (Length(sValor) > 0) then begin
            chkCliente.Checked := true;
            txtClienteBusq.Text := sValor;
        end;

        sValor := ReadString('XCobrar', 'FechaIni', '');
        if (Length(sValor) > 0) then begin
            chkFecha.Checked := true;
            txtDiaIni.Text := Copy(sValor,1,2);
            txtMesIni.Text := Copy(sValor,3,2);
            txtAnioIni.Text := Copy(sValor,5,4);
        end;

        sValor := ReadString('XCobrar', 'FechaFin', '');
        if (Length(sValor) > 0) then begin
            chkFecha.Checked := true;
            txtDiaFin.Text := Copy(sValor,1,2);
            txtMesFin.Text := Copy(sValor,3,2);
            txtAnioFin.Text := Copy(sValor,5,4);
        end;

        sValor := ReadString('XCobrar', 'FechaVenIni', '');
        if (Length(sValor) > 0) then begin
            chkVencim.Checked := true;
            txtDiaVenIni.Text := Copy(sValor,1,2);
            txtMesVenIni.Text := Copy(sValor,3,2);
            txtAnioVenIni.Text := Copy(sValor,5,4);
        end;

        sValor := ReadString('XCobrar', 'FechaVenFin', '');
        if (Length(sValor) > 0) then begin
            chkVencim.Checked := true;
            txtDiaVenFin.Text := Copy(sValor,1,2);
            txtMesVenFin.Text := Copy(sValor,3,2);
            txtAnioVenFin.Text := Copy(sValor,5,4);
        end;

        sValor := ReadString('XCobrar', 'CompIni', '');
        if (Length(sValor) > 0) then begin
            chkNoComp.Checked := true;
            txtCompIni.Value:= StrToFloat(sValor);
        end;

        sValor := ReadString('XCobrar', 'CompFin', '');
        if (Length(sValor) > 0) then begin
            chkNoComp.Checked := true;
            txtCompFin.Value:= StrToFloat(sValor);
        end;

        sValor := ReadString('XCobrar', 'Estatus', '');
        if (Length(sValor) > 0) and (sValor <> '-1')then begin
            chkEstatus.Checked := true;
            cmbEstatus.ItemIndex := StrToInt(sValor);
        end;

        sValor := ReadString('XCobrar', 'Comprobante', '');
        if (Length(sValor) > 0) and (sValor <> '-1') then begin
            chkComprobante.Checked := true;
            cmbComprobante.ItemIndex := StrToInt(sValor);
        end;

        //Recupera el valor de los botones de radio de orden
        sValor := ReadString('XCobrar', 'Orden', '');
        if (Length(sValor) > 0) then
            rdgOrden.ItemIndex := StrToInt(sValor);
        
        Free;
    end;
end;

procedure TfrmXCobrar.FormClose(Sender: TObject; var Action: TCloseAction);
var
    iniArchivo : TIniFile;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) +'config.ini');
    with iniArchivo do begin
        // Registra la posición y de la ventana
        WriteString('XCobrar', 'Posy', IntToStr(Top));

        // Registra la posición X de la ventana
        WriteString('XCobrar', 'Posx', IntToStr(Left));

        //Registra el valor de los botones de radio de orden
        WriteString('XCobrar', 'Orden', IntToStr(rdgOrden.ItemIndex));

        //Registra la ultima ficha que se seleccionó
        WriteString('XCobrar', 'Ficha', IntToStr(pgeGeneral.ActivePageIndex));

        //Registra las opciones de búsqueda
        if chkCliente.Checked then
            WriteString('XCobrar', 'Cliente', txtClienteBusq.Text)
        else
            DeleteKey('XCobrar', 'Cliente');


        if chkFecha.Checked then begin
            WriteString('XCobrar', 'FechaIni', txtDiaIni.Text + txtMesIni.Text + txtAnioIni.Text);
            WriteString('XCobrar', 'FechaFin', txtDiaFin.Text + txtMesFin.Text + txtAnioFin.Text);
        end
        else begin
            DeleteKey('XCobrar', 'FechaIni');
            DeleteKey('XCobrar', 'FechaFin');
        end;


        if chkVencim.Checked then begin
            WriteString('XCobrar', 'FechaVenIni', txtDiaVenIni.Text + txtMesVenIni.Text + txtAnioVenIni.Text);
            WriteString('XCobrar', 'FechaVenFin', txtDiaVenFin.Text + txtMesVenFin.Text + txtAnioVenFin.Text);
        end
        else begin
            DeleteKey('XCobrar', 'FechaVenIni');
            DeleteKey('XCobrar', 'FechaVenFin');
        end;


        if chkNoComp.Checked then begin
            WriteString('XCobrar', 'CompIni', txtCompIni.Text );
            WriteString('XCobrar', 'CompFin', txtCompFin.Text );
        end
        else begin
            DeleteKey('XCobrar', 'CompIni');
            DeleteKey('XCobrar', 'CompFin');
        end;

        if chkEstatus.Checked then
            WriteString('XCobrar', 'Estatus', IntToStr(cmbEstatus.ItemIndex))
        else
            DeleteKey('XCobrar', 'Estatus');

        if chkComprobante.Checked then
            WriteString('XCobrar', 'Comprobante', IntToStr(cmbComprobante.ItemIndex))
        else
            DeleteKey('XCobrar', 'Comprobante');

        Free;
    end;
    dmDatos.cdsCliente1.Active := false;
    dmDatos.qryListados1.Close;
end;

procedure TfrmXCobrar.btnCancelarClick(Sender: TObject);
begin
    if (sEstatus <> 'C') then begin
        if (Application.MessageBox('¿Desea cancelar el abono seleccionado?','Cancelar',[smbOK,smbCancel], smsWarning) = smbOK) then
            with dmDatos.qryModifica do begin
                Close;
                SQL.Clear;
                SQL.Add('UPDATE xcobrar SET estatus = ''A'', pagado = pagado - ' + grdCuentas.Cells[2,grdCuentas.Row] + ',');
                SQL.Add('cantintmorat = 0, cantinteres = 0 WHERE clave = ' + sCredito);
                ExecSQL;

                Close;
                SQL.Clear;
                SQL.Add('DELETE FROM xcobrarpagos WHERE xcobrar = ' + sCredito);
                SQL.Add('AND numero = ' + grdCuentas.Cells[0,grdCuentas.Row]);
                ExecSQL;
                Close;

                btnBuscar.Click;
                RecuperaDatos;
            end;
    end;
 end;

procedure TfrmXCobrar.grdCuentasClick(Sender: TObject);
begin
    if (grdCuentas.Cells[0,grdCuentas.Row] = grdCuentas.Cells[0,grdCuentas.RowCount - 1]) and(grdCuentas.Cells[0,grdCuentas.Row] <> '') then
        btnCancelar.Enabled := True
    else
        btnCancelar.Enabled := False;
end;

procedure TfrmXCobrar.CobranzaGeneral1Click(Sender: TObject);
begin
    with TFrmReportesXCobrar.Create(Self) do
    try
        ShowModal;
    finally
        Free;
    end;
end;

procedure TfrmXCobrar.btnLimpiarClick(Sender: TObject);
var
    i : integer;
begin
    with grpBuscar do
        for i := 0 to ControlCount - 1 do begin
            if (Controls[i] is TEdit) then
                (Controls[i] as TEdit).Clear
            else
                if (Controls[i] is TComboBox) then
                    (Controls[i] as TComboBox).ItemIndex := -1
        end;
end;

procedure TfrmXCobrar.txtAnioIniExit(Sender: TObject);
begin
    txtAnioIni.Text := Trim(txtAnioIni.Text);
    if(Length(txtAnioIni.Text) < 4) and (Length(txtAnioIni.Text) > 0) then
        txtAnioIni.Text := IntToStr(StrToInt(txtAnioIni.Text) + 2000);
end;

procedure TfrmXCobrar.txtAnioVenIniExit(Sender: TObject);
begin
    txtAnioVenIni.Text := Trim(txtAnioVenIni.Text);
    if(Length(txtAnioVenIni.Text) < 4) and (Length(txtAnioVenIni.Text) > 0) then
        txtAnioVenIni.Text := IntToStr(StrToInt(txtAnioVenIni.Text) + 2000);
end;

procedure TfrmXCobrar.txtAnioFinExit(Sender: TObject);
begin
    txtAnioFin.Text := Trim(txtAnioFin.Text);
    if(Length(txtAnioFin.Text) < 4) and (Length(txtAnioFin.Text) > 0) then
        txtAnioFin.Text := IntToStr(StrToInt(txtAnioFin.Text) + 2000);
end;

procedure TfrmXCobrar.txtAnioVenFinExit(Sender: TObject);
begin
    txtAnioVenFin.Text := Trim(txtAnioVenFin.Text);
    if(Length(txtAnioVenFin.Text) < 4) and (Length(txtAnioVenFin.Text) > 0) then
        txtAnioVenFin.Text := IntToStr(StrToInt(txtAnioVenFin.Text) + 2000);
end;

procedure TfrmXCobrar.txtDiaIniExit(Sender: TObject);
begin
    Rellena(Sender);
end;

procedure TfrmXCobrar.Rellena(Sender: TObject);
var
    i : integer;
begin
    for i := Length((Sender as TEdit).Text) to (Sender as TEdit).MaxLength - 1 do
        (Sender as TEdit).Text := '0' + (Sender as TEdit).Text;
end;

procedure TfrmXCobrar.mnuConsultaDocumentoClick(Sender: TObject);
begin
//
end;

procedure TfrmXCobrar.BitBtn1Click(Sender: TObject);
begin
    close;
end;

end.
