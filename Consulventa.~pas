// --------------------------------------------------------------------------
// Archivo del Proyecto Ventas
// Página del proyecto: http://sourceforge.net/projects/ventas
// --------------------------------------------------------------------------
// Este archivo puede ser distribuido y/o modificado bajo lo terminos de la
// Licencia Pública General versión 2 como es publicada por la Free Software
// Fundation, Inc.
// --------------------------------------------------------------------------

unit Consulventa;

interface

uses
  SysUtils, Types, Classes, QGraphics, QControls, QForms, QDialogs, DB,
  QStdCtrls, QcurrEdit, QComCtrls, QButtons, QGrids, QExtCtrls, QDBGrids,
  QMenus, QTypes, IniFiles;

type
  TfrmVentasConsulta = class(TForm)
    pgeGeneral: TPageControl;
    tabDatos: TTabSheet;
    tabBusqueda: TTabSheet;
    GroupBox1: TGroupBox;
    txtCaja: TEdit;
    txtCliente: TEdit;
    txtUsuario: TEdit;
    txtFechaCap: TEdit;
    txtAreaVenta: TEdit;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    btnBuscar: TBitBtn;
    btnSeleccionar: TBitBtn;
    btnLimpiar: TBitBtn;
    txtRegistros: TcurrEdit;
    Label26: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    pnlActiva: TPanel;
    pnlCancelada: TPanel;
    grpCriterios: TGroupBox;
    chkCaja: TCheckBox;
    chkTipoPago: TCheckBox;
    chkEstatus: TCheckBox;
    chkCliente: TCheckBox;
    chkUsuario: TCheckBox;
    chkNoComp: TCheckBox;
    chkFecha: TCheckBox;
    chkArticulo: TCheckBox;
    chkArea: TCheckBox;
    txtUsuarioBusq: TEdit;
    txtClienteBusq: TEdit;
    cmbEstatus: TComboBox;
    cmbTipoPago: TComboBox;
    txtCajaIni: TcurrEdit;
    lblDesdeComp: TLabel;
    lblHastaComp: TLabel;
    txtCompFin: TcurrEdit;
    txtCompIni: TcurrEdit;
    cmbArea: TComboBox;
    txtArticulo: TEdit;
    chkComprobante: TCheckBox;
    cmbComprobante: TComboBox;
    txtDiaIni: TEdit;
    txtMesIni: TEdit;
    txtAnioIni: TEdit;
    lblDiagMes1: TLabel;
    lblDiagDia1: TLabel;
    txtDiaFin: TEdit;
    txtMesFin: TEdit;
    txtAnioFin: TEdit;
    lblDiagMes2: TLabel;
    lblDiagDia2: TLabel;
    lblAl: TLabel;
    chkTotal: TCheckBox;
    txtTotalIni: TcurrEdit;
    grdListado: TDBGrid;
    Label12: TLabel;
    txtHora: TEdit;
    lblHastaCaja: TLabel;
    txtCajaFin: TcurrEdit;
    lblDesdeCaja: TLabel;
    lblEntreTotal: TLabel;
    txtTotalFin: TcurrEdit;
    lblYTotal: TLabel;
    MainMenu1: TMainMenu;
    Archivo1: TMenuItem;
    Salir1: TMenuItem;
    mnuConsulta: TMenuItem;
    mnuAvanza: TMenuItem;
    mnuRetrocede: TMenuItem;
    N1: TMenuItem;
    mnuBuscar: TMenuItem;
    N4: TMenuItem;
    mnuLimpiar: TMenuItem;
    mnuSeleccionar: TMenuItem;
    mnuFichas: TMenuItem;
    mnuDatos: TMenuItem;
    mnuBusqueda: TMenuItem;
    rdgOrden: TRadioGroup;
    Label14: TLabel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    grdDetalleVenta: TStringGrid;
    TabSheet2: TTabSheet;
    grdTipoPago: TStringGrid;
    grdComprobante: TStringGrid;
    Importes: TGroupBox;
    txtSubtotal: TcurrEdit;
    txtIva: TcurrEdit;
    txtTotal: TcurrEdit;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    txtRedondeo: TcurrEdit;
    Label13: TLabel;
    pnlEstatus: TPanel;
    chkVendedor: TCheckBox;
    txtVendedorBusq: TEdit;
    txtVendedor: TEdit;
    Label2: TLabel;
    pedido: TCheckBox;
    PopupMenu2: TPopupMenu;
    F1: TMenuItem;
    ped: TLabel;
    procedure btnBuscarClick(Sender: TObject);
    procedure chkAreaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure chkArticuloClick(Sender: TObject);
    procedure chkCajaClick(Sender: TObject);
    procedure chkClienteClick(Sender: TObject);
    procedure chkEstatusClick(Sender: TObject);
    procedure chkFechaClick(Sender: TObject);
    procedure chkNoCompClick(Sender: TObject);
    procedure chkComprobanteClick(Sender: TObject);
    procedure chkTipoPagoClick(Sender: TObject);
    procedure chkUsuarioClick(Sender: TObject);
    procedure chkTotalClick(Sender: TObject);
    procedure btnSeleccionarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Salta(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnLimpiarClick(Sender: TObject);
    procedure grdDetalleVentaDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure grdTipoPagoDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure grdComprobanteDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure Salir1Click(Sender: TObject);
    procedure mnuAvanzaClick(Sender: TObject);
    procedure mnuRetrocedeClick(Sender: TObject);
    procedure grdListadoDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure pgeGeneralChange(Sender: TObject);
    procedure mnuDatosClick(Sender: TObject);
    procedure mnuBusquedaClick(Sender: TObject);
    procedure rdgOrdenClick(Sender: TObject);
    procedure txtAnioIniExit(Sender: TObject);
    procedure txtAnioFinExit(Sender: TObject);
    procedure txtDiaIniExit(Sender: TObject);
    procedure chkVendedorClick(Sender: TObject);
    procedure grdListadoEnter(Sender: TObject);
    procedure grdListadoExit(Sender: TObject);
    procedure F1Click(Sender: TObject);
  private
        iClave: Integer;
        procedure RecuperaAreas;
        procedure RecuperaTipoPago;
        procedure RecuperaDatos;
        function VerificaFechas(sFecha : string):boolean;
        function VerificaDatos : boolean;
        procedure IniRejillas;
        procedure RecuperaConfig;
        procedure Rellena(Sender: TObject);
  public
    { Public declarations }
  end;

var
  frmVentasConsulta: TfrmVentasConsulta;

implementation

uses dm;

{$R *.xfm}

procedure TfrmVentasConsulta.btnBuscarClick(Sender: TObject);
var
c,p,tp:string;
t:Extended;

begin
 if(pedido.Checked) then begin

 p:= QuotedStr('T') +','+QuotedStr('N')+','+QuotedStr('C')+','+QuotedStr('F');

 end
 else
 begin
  p:= QuotedStr('T')+','+QuotedStr('N')+','+QuotedStr('C')+','+QuotedStr('F')+','+QuotedStr('P');
 end;


    if(VerificaDatos) then begin
        dmDatos.cdsCliente.Active := false;
        with dmDatos.qryListados do begin
            Close;
            SQL.Clear;
            SQL.Add('SELECT  tipo, caja, numero, fecha, hora, estatus, total-iva AS subtotal,');
            SQL.Add('iva, total, cliente, usuario, v.clave FROM ventas v, comprobantes x  WHERE 1 = 1 and COMPROBANTES.venta = ventas.clave and tipo IN ('+ p +')');


            if(chkArea.Checked) then
                SQL.Add('AND areaventa IN (SELECT clave FROM areasventa WHERE nombre = ''' + cmbArea.Text + ''')');
            if(chkArticulo.Checked) then begin
                SQL.Add('AND v.clave IN(SELECT d.venta FROM ventasdet d');
                SQL.Add('LEFT JOIN articulos a ON d.articulo = a.clave WHERE');
                SQL.Add('a.desc_larga LIKE ''%' + txtArticulo.Text + '%'')');
            end;

              if(pedido.Checked) then begin
                SQL.Add('AND v.clave IN (SELECT venta FROM comprobantes ');
                SQL.Add('WHERE tipo <> ''P'')');

            end;

            if(chkCaja.Checked) then begin
                SQL.Add('AND caja >= ' + FloatToStr(txtCajaIni.Value));
                SQL.Add('AND caja <= ' + FloatToStr(txtCajaFin.Value));
            end;
            if(chkCliente.Checked) then
                SQL.Add('AND cliente IN (SELECT clave FROM clientes WHERE nombre LIKE ''%' + txtClienteBusq.Text + '%'')');
            if(chkEstatus.Checked) then
                SQL.Add('AND estatus = ''' + Copy(cmbEstatus.Text,1,1) + '''');
            if(chkFecha.Checked) then begin
                SQL.Add('AND fecha >= ''' + txtMesIni.Text + '/' + txtDiaIni.Text + '/' + txtAnioIni.Text + '''');
                SQL.Add('AND fecha <= ''' + txtMesFin.Text + '/' + txtDiaFin.Text + '/' + txtAnioFin.Text + '''');
            end;
            if(chkNoComp.Checked) then begin

                SQL.Add('AND v.clave IN (SELECT venta FROM comprobantes WHERE numero >= ' + FloatToStr(txtCompIni.Value));
                SQL.Add('AND numero <= ' + FloatToStr(txtCompFin.Value) + ')');
            end;
            if(chkComprobante.Checked) then begin
            if(pedido.Checked) then begin
                 c := Copy(cmbComprobante.Text,1,1);
                 if (c = 'P')then
                 begin
                 c:= '';
                 end;
                SQL.Add('AND v.clave IN (SELECT venta FROM comprobantes ');
                SQL.Add('WHERE tipo = ''' + c + ''')');
                end
                else
                begin
                SQL.Add('AND v.clave IN (SELECT venta FROM comprobantes ');
                SQL.Add('WHERE tipo = ''' + Copy(cmbComprobante.Text,1,1) + ''')');

                end;
            end;
            if(chkTipoPago.Checked) then begin
                SQL.Add('AND v.clave IN (SELECT p.venta FROM ventaspago p LEFT JOIN tipopago t ON p.tipopago = t.clave');
                SQL.Add('WHERE t.nombre = ''' + cmbTipoPago.Text + ''')');
            end;
            if(chkUsuario.Checked) then
                SQL.Add('AND usuario IN (SELECT clave FROM usuarios WHERE nombre LIKE ''%' + txtUsuarioBusq.Text + '%'')');
            if(chkTotal.Checked) then begin
                SQL.Add('AND total >= ' + FloatToStr(txtTotalIni.Value));
                SQL.Add('AND total <= ' + FloatToStr(txtTotalFin.Value));
            end;
            if(chkVendedor.Checked) then
                SQL.Add('AND vendedor IN (SELECT clave FROM vendedores WHERE nombre LIKE ''%' + txtVendedorBusq.Text + '%'')');

            case rdgOrden.ItemIndex of
                0: SQL.Add('ORDER BY caja, fecha, hora');
                1: SQL.Add('ORDER BY numero, caja');
                2: SQL.Add('ORDER BY fecha, hora');
                3: SQL.Add('ORDER BY hora, fecha');
                4: SQL.Add('ORDER BY estatus, fecha, hora');
                5: SQL.Add('ORDER BY total');
            end;
            Open;
        end;

    //    with dmDatos.qryListados do begin
  //      while(not dmDatos.qryListados.Eof) do begin

         // p:= FieldByName('tipo').AsString;
         //  tp:= FieldByName('total').AsString;
       //    t := StrToFloat(tp);



        //   Next;
       //    end;

      //  end;

        with dmDatos.cdsCliente do begin
            Active := true;

            txtRegistros.Value := RecordCount;

            FieldByName('caja').DisplayLabel := 'Caja';
            FieldByName('caja').DisplayWidth := 4;
            FieldByName('numero').DisplayLabel := 'Remisión';
            FieldByName('numero').DisplayWidth := 8;
            FieldByName('fecha').DisplayLabel := 'Fecha';
            FieldByName('fecha').DisplayWidth := 9;
            FieldByName('hora').DisplayLabel := 'Hora';
            FieldByName('hora').DisplayWidth := 11;
            FieldByName('estatus').DisplayLabel := 'Estatus';
            FieldByName('estatus').DisplayWidth := 7;
            FieldByName('subtotal').DisplayLabel := 'Subtotal';
            FieldByName('subtotal').DisplayWidth := 10;
            (FieldByName('subtotal') as TNumericField).DisplayFormat := '#,##0.00';
            FieldByName('iva').DisplayLabel := 'I.V.A.';
            FieldByName('iva').DisplayWidth := 10;
            (FieldByName('iva') as TNumericField).DisplayFormat := '#,##0.00';
            FieldByName('total').DisplayLabel := 'Total';
            FieldByName('total').DisplayWidth := 10;
            (FieldByName('total') as TNumericField).DisplayFormat := '#,##0.00';
            FieldByName('cliente').Visible := false;
            FieldByName('usuario').Visible := false;
            FieldByName('clave').Visible := False;
        end;

        if(pgeGeneral.ActivePage = tabBusqueda) then
            grdListado.SetFocus;
    end;
end;

function TfrmVentasConsulta.VerificaDatos : boolean;
begin
    btnBuscar.SetFocus;
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
end;

procedure TfrmVentasConsulta.chkAreaClick(Sender: TObject);
begin
    if(chkArea.Checked) then begin
        cmbArea.Visible := true;
        cmbArea.SetFocus;
        cmbArea.ItemIndex := 0;
    end
    else
        cmbArea.Visible := false;
end;

procedure TfrmVentasConsulta.RecuperaAreas;
begin
    with dmDatos.qryConsulta do begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT nombre FROM areasventa ORDER BY nombre');
        Open;
        cmbArea.Items.Clear;
        while (not Eof) do begin
            cmbArea.Items.Add(Trim(FieldByName('nombre').AsString));
            Next;
        end;
        Close;
    end;
end;

procedure TfrmVentasConsulta.RecuperaTipoPago;
begin
    with dmDatos.qryConsulta do begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT nombre FROM tipopago ORDER BY nombre');
        Open;

        cmbTipoPago.Items.Clear;
        while(not Eof) do begin
            cmbTipoPago.Items.Add(Trim(FieldByName('nombre').AsString));
            Next;
        end;
        Close;
    end;
end;

procedure TfrmVentasConsulta.FormShow(Sender: TObject);
begin
    RecuperaConfig;
    RecuperaAreas;
    RecuperaTipoPago;
    IniRejillas;
end;

procedure TfrmVentasConsulta.chkArticuloClick(Sender: TObject);
begin
   if(chkArticulo.Checked) then begin
        txtArticulo.Visible := true;
        txtArticulo.SetFocus;
    end
    else
        txtArticulo.Visible:=False;
end;

procedure TfrmVentasConsulta.chkCajaClick(Sender: TObject);
begin
     if(chkCaja.Checked) then begin
        lblDesdeCaja.Visible := true;
        lblHastaCaja.Visible := true;
        txtCajaIni.Visible := true;
        txtCajaFin.Visible := true;
        txtCajaIni.SetFocus;
    end
    else begin
        lblDesdeCaja.Visible := false;
        lblHastaCaja.Visible := false;
        txtCajaIni.Visible := false;
        txtCajaFin.Visible := false;
    end;
end;

procedure TfrmVentasConsulta.chkClienteClick(Sender: TObject);
begin
   if(chkcliente.Checked) then begin
        txtClienteBusq.Visible := true;
        txtClienteBusq.SetFocus;
    end
    else
        txtClienteBusq.Visible := false;
end;

procedure TfrmVentasConsulta.chkEstatusClick(Sender: TObject);
begin
    if(chkEstatus.Checked) then begin
        cmbEstatus.Visible := true;
        if(cmbEstatus.ItemIndex = -1) then
            cmbEstatus.ItemIndex := 0;
        cmbEstatus.SetFocus;
    end
    else
        cmbEstatus.Visible := false;
end;

procedure TfrmVentasConsulta.chkFechaClick(Sender: TObject);
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

procedure TfrmVentasConsulta.chkNoCompClick(Sender: TObject);
begin
    if(chkNoComp.Checked) then begin
        txtCompIni.Visible:=True;
        txtCompfin.Visible:=True;
        lblDesdeComp.Visible:=True;
        lblHastaComp.visible:=True;
        txtCompIni.SetFocus;
    end
    else begin
        txtCompIni.Visible:=False;
        txtCompfin.Visible:=False;
        lblDesdeComp.Visible:=False;
        lblHastaComp.visible:=False;
    end;
end;

procedure TfrmVentasConsulta.chkComprobanteClick(Sender: TObject);
begin
    if(chkComprobante.Checked) then begin
        cmbComprobante.Visible:=True;
        if(cmbComprobante.ItemIndex = -1) then
            cmbComprobante.ItemIndex := 0;
        cmbComprobante.SetFocus;
    end
    else
        cmbComprobante.Visible:=False;
end;

procedure TfrmVentasConsulta.chkTipoPagoClick(Sender: TObject);
begin
    if(chkTipoPago.Checked) then begin
        cmbTipoPago.Visible := true;
        if(cmbTipoPago.ItemIndex = -1) then
            cmbTipoPago.ItemIndex := 0;
        cmbTipoPago.SetFocus;
    end
    else
        cmbTipoPago.Visible := false;
end;

procedure TfrmVentasConsulta.chkUsuarioClick(Sender: TObject);
begin
    if(chkUsuario.Checked) then begin
        txtUsuarioBusq.Visible := true;
        txtUsuarioBusq.SetFocus;
    end
    else
        txtUsuarioBusq.Visible:=False;
end;

procedure TfrmVentasConsulta.chkTotalClick(Sender: TObject);
begin
     if(chkTotal.Checked) then begin
        lblEntreTotal.Visible := true;
        lblYTotal.Visible := true;
        txtTotalIni.Visible := true;
        txtTotalFin.Visible := true;
        txtTotalIni.SetFocus;
    end
    else begin
        lblEntreTotal.Visible := false;
        lblYTotal.Visible := false;
        txtTotalIni.Visible := false;
        txtTotalFin.Visible := false;
    end;
end;

procedure TfrmVentasConsulta.btnSeleccionarClick(Sender: TObject);
begin
    if (txtRegistros.Value > 0) then
        RecuperaDatos;
end;

procedure TfrmVentasConsulta.RecuperaDatos;
var
    sTipo : String;
    iCliente, iUsuario, iCont, iAreaVenta, iVendedor :Integer;
begin
        iClave := dmDatos.cdsCliente.FieldByName('clave').AsInteger;
        with dmDatos.qryConsulta do begin
            Close;
            SQL.Clear;
            SQL.Add('SELECT * FROM ventas WHERE clave = ' + IntToStr(iClave));
            Open;
            if(not Eof) then begin
                pgeGeneral.ActivePageIndex := 0;
                txtCaja.Text:= FieldByName('caja').AsString;
                if(FieldByName('estatus').AsString = 'A') then begin
                    pnlEstatus.Caption := 'ACTIVA';
                    pnlEstatus.Color := $00DCBFA5;
                end
                else if(FieldByName('estatus').AsString = 'C') then begin
                    pnlEstatus.Caption := 'CANCELADA';
                    pnlEstatus.Color := $0099A7F7;
                end
                else begin
                    pnlEstatus.Caption := 'UTILIZADA';
                    pnlEstatus.Color := $0099A7F7;
                end;
                txtFechaCap.Text := FieldByName('fecha').AsString;
                txtHora.Text := FieldByName('hora').AsString;
                txtIva.Value := FieldByName('iva').AsFloat;
                txtTotal.Value := FieldByName('total').AsFloat;
                txtSubtotal.Value := FieldByName('total').AsFloat - FieldByName('iva').AsFloat;
                iCliente := FieldByName('cliente').AsInteger;
                iUsuario := FieldByName('usuario').AsInteger;
                iAreaVenta := FieldByName('areaventa').AsInteger;
                iVendedor := FieldByName('vendedor').AsInteger;                

                Close;
                SQL.Clear;
                SQL.Add('SELECT nombre FROM clientes WHERE clave = ' + IntToStr(iCliente));
                Open;
                txtCliente.Text := Trim(FieldByName('nombre').AsString);

                Close;
                SQL.Clear;
                SQL.Add('SELECT nombre FROM usuarios WHERE clave = ' + IntToStr(iUsuario));
                Open;
                txtUsuario.Text := Trim(FieldByName('nombre').AsString);

                Close;
                SQL.Clear;
                SQL.Add('SELECT nombre FROM areasVenta WHERE clave = ' + IntToStr(iAreaVenta));
                Open;
                txtAreaVenta.Text := Trim(FieldByName('nombre').AsString);

                Close;
                SQL.Clear;
                SQL.Add('SELECT nombre FROM vendedores WHERE clave = ' + IntToStr(iVendedor));
                Open;
                txtVendedor.Text := Trim(FieldByName('nombre').AsString);

                Close;
                SQL.Clear;
                SQL.Add('SELECT t.nombre, v.importe, v.referencia FROM ventaspago v LEFT JOIN tipopago t ON v.tipopago = t.clave WHERE v.venta = ' + IntToStr(iClave));
                Open;

                iCont := 0;
                while not Eof do begin
                    Inc(iCont);
                    grdTipoPago.RowCount:= iCont+1;
                    grdTipoPago.Cells[0,iCont] := Trim(FieldByName('nombre').AsString);

                    grdTipoPago.Cells[1,iCont] := FloatToStr(FieldByName('importe').AsFloat);
                    grdTipoPago.Cells[2,iCont] := Trim(FieldByName('referencia').AsString);
                    Next;
                end;

                Close;
                SQL.Clear;
                SQL.Add('SELECT tipo, numero, estatus FROM comprobantes WHERE venta = ' + IntToStr(iClave));
                Open;

                iCont := 0;
                while(not Eof) do begin
                    sTipo := FieldByName('tipo').AsString;
                    if (sTipo = 'N') then
                        sTipo := 'NOTA'
                    else if (sTipo = 'F') then
                        sTipo := 'FACTURA'
                    else if (sTipo = 'C') then
                        sTipo := 'COTIZACION'
                    else if (sTipo = 'A') then
                        sTipo := 'AJUSTE'
                    else if (sTipo = 'T') then
                        sTipo := 'TICKET'
                    else if (sTipo = 'D') then
                        sTipo := 'DEVOLUCION'
                    else if (sTipo = 'P') then
                        sTipo := 'PEDIDO';
                    Inc(iCont);
                    grdComprobante.RowCount := iCont + 1;
                    grdComprobante.Cells[0,iCont] := sTipo;
                    grdComprobante.Cells[1,iCont] := FieldByName('numero').AsString;
                    if ( FieldByName('estatus').AsString ='A') then
                        grdComprobante.Cells[2,iCont] := 'Activa'
                    else
                      if( FieldByName('estatus').AsString ='A') then
                        grdComprobante.Cells[2,iCont] := 'Cancelada'
                      else
                        grdComprobante.Cells[2,iCont] := 'Utilizada';
                    Next;
                end;

                Close;
                SQL.Clear;
                SQL.Add('SELECT d.cantidad, d.precio, d.descuento, a.desc_larga FROM ventasdet d');
                SQL.Add('LEFT JOIN articulos a ON d.articulo = a.clave WHERE d.juego = 0 AND d.venta = ' + IntToStr(iClave) + ' ORDER BY d.orden');
                Open;

                iCont := 0;
                while(not Eof) do begin
                    Inc(iCont);
                    grdDetalleVenta.RowCount := iCont + 1;
                    grdDetalleVenta.Cells[0,iCont] := FieldByName('cantidad').AsString;
                    grdDetalleVenta.Cells[1,iCont] := FieldByName('desc_larga').AsString;
                    grdDetalleVenta.Cells[2,iCont] := FieldByName('precio').AsString;
                    grdDetalleVenta.Cells[3,iCont] := FieldByName('descuento').AsString;
                    grdDetalleVenta.Cells[4,iCont] := FloatToStr( FieldByName('cantidad').AsFloat *
                                                      FieldByName('precio').AsFloat *
                                                      (1 - FieldByName('descuento').AsFloat / 100) );
                    Next;
                end;
                Close;
            end
//            else
//                LimpiaDatos;
    end;
end;

procedure TfrmVentasConsulta.FormClose(Sender: TObject; var Action: TCloseAction);
var
    iniArchivo : TIniFile;
begin
    dmDatos.qryListados.Close;
    dmDatos.cdsCliente.Active := false;

    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'config.ini');
    with iniArchivo do begin
        // Registra la posición y de la ventana
        WriteString('ConsulVenta', 'Posy', IntToStr(Top));

        // Registra la posición X de la ventana
        WriteString('ConsulVenta', 'Posx', IntToStr(Left));

        //Registra el valor de los botones de radio de orden
        WriteString('ConsulVenta', 'Orden', IntToStr(rdgOrden.ItemIndex));

        //Registra la ultima ficha que se seleccionó
        WriteString('ConsulVenta', 'Ficha', IntToStr(pgeGeneral.ActivePageIndex));

        Free;
   end;
end;

function TfrmVentasConsulta.VerificaFechas(sFecha : string) : boolean;
var
   dteFecha : TDateTime;
begin
   Result:=true;
   if(not TryStrToDate(sFecha,dteFecha)) then 
      Result:=false;
end;

procedure TfrmVentasConsulta.Salta(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    {Inicio (36), Fin (35), Izquierda (37), derecha (39), arriba (38), abajo (40)}
    if(Key >= 30) and (Key <= 122) and (Key <> 35) and (Key <> 36) and not ((Key >= 37) and (Key <= 40)) then
        if( Length((Sender as TEdit).Text) = (Sender as TEdit).MaxLength) then
            SelectNext(Sender as TWidgetControl, true, true);
end;

procedure TfrmVentasConsulta.IniRejillas;
begin
    grdTipoPago.RowCount := 2;
    grdTipoPago.ColWidths[0] := 170;
    grdTipoPago.ColWidths[1] := 70;
    grdTipoPago.ColWidths[2] := 130;
    grdTipoPago.Cells[0,0] := 'Tipo de pago';
    grdTipoPago.Cells[1,0] := 'Importe';
    grdTipoPago.Cells[2,0] := 'Referencia';
    grdTipoPago.Cells[0,1] := '';
    grdTipoPago.Cells[1,1] := '';
    grdTipoPago.Cells[2,1] := '';

    grdComprobante.RowCount := 2;
    grdComprobante.ColWidths[0] := 120;
    grdComprobante.ColWidths[1] := 70;
    grdComprobante.ColWidths[2] := 60;
    grdComprobante.Cells[0,0] := 'Comprobante';
    grdComprobante.Cells[1,0] := 'Número';
    grdComprobante.Cells[2,0] := 'Estatus';
    grdComprobante.Cells[0,1] := '';
    grdComprobante.Cells[1,1] := '';
    grdComprobante.Cells[2,1] := '';

    grdDetalleVenta.RowCount := 2;
    grdDetalleVenta.ColWidths[0] := 38;
    grdDetalleVenta.ColWidths[1] := 210;
    grdDetalleVenta.ColWidths[2] := 65;
    grdDetalleVenta.ColWidths[3] := 42;
    grdDetalleVenta.ColWidths[4] := 72;
    grdDetalleVenta.Cells[0,0] := 'Cant.';
    grdDetalleVenta.Cells[1,0] := 'Artículo';
    grdDetalleVenta.Cells[2,0] := 'Precio';
    grdDetalleVenta.Cells[3,0] := 'Desc.';
    grdDetalleVenta.Cells[4,0] := 'Importe';
    grdDetalleVenta.Cells[0,1] := '';
    grdDetalleVenta.Cells[1,1] := '';
    grdDetalleVenta.Cells[2,1] := '';
    grdDetalleVenta.Cells[3,1] := '';
    grdDetalleVenta.Cells[4,1] := '';
end;

procedure TfrmVentasConsulta.btnLimpiarClick(Sender: TObject);
begin
    txtArticulo.Clear;
    txtCajaIni.Value := 1;
    txtCajaFin.Value := 1;
    txtClienteBusq.Clear;
    txtDiaIni.Clear;
    txtMesIni.Clear;
    txtAnioIni.Clear;
    txtDiaFin.Clear;
    txtMesFin.Clear;
    txtAnioFin.Clear;
    txtCompIni.Value := 1;
    txtCompFin.Value := 1;
    txtUsuarioBusq.Clear;
end;

procedure TfrmVentasConsulta.grdDetalleVentaDrawCell(Sender: TObject; ACol,
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
            (Sender as TStringGrid).Canvas.TextOut(Round(i),Rect.Top+2,sCad);
        end;
        if(ACol > 1) and (ARow > 0) then begin
            sCad := FormatFloat('#,##0.00',StrToFloat(sCad));
            i := Rect.Right-(Sender as TStringGrid).Canvas.TextWidth(sCad + ' ');
            (Sender as TStringGrid).Canvas.FillRect(Rect);
            (Sender as TStringGrid).Canvas.TextOut(Round(i),Rect.Top + 2,sCad);
        end;
    end;
end;

procedure TfrmVentasConsulta.grdTipoPagoDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var
    sCad : String;
    i : real;
begin
    sCad := (Sender as TStringGrid).Cells[ACol,ARow];
    if(Length(sCad) > 0) then begin
        if(ARow = 0) then begin
            i := Rect.Left + (Rect.Right - Rect.Left) / 2 - (Sender as TStringGrid).Canvas.TextWidth(sCad) / 2;
            (Sender as TStringGrid).Canvas.FillRect(Rect);
            (Sender as TStringGrid).Canvas.TextOut(Round(i),Rect.Top+2,sCad);
        end;
        if(ACol = 1) and (ARow > 0) then begin
            sCad := FormatFloat('#,##0.00',StrToFloat(sCad));
            i := Rect.Right-(Sender as TStringGrid).Canvas.TextWidth(sCad + ' ');
            (Sender as TStringGrid).Canvas.FillRect(Rect);
            (Sender as TStringGrid).Canvas.TextOut(Round(i),Rect.Top + 2,sCad);
        end;
    end;
end;

procedure TfrmVentasConsulta.grdComprobanteDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var
    sCad : String;
    i : real;
begin
    sCad := (Sender as TStringGrid).Cells[ACol,ARow];
    if(Length(sCad) > 0) then begin
        if(ARow = 0) or (ACol > 0) then
            i := Rect.Left + (Rect.Right - Rect.Left) / 2 - (Sender as TStringGrid).Canvas.TextWidth(sCad) / 2
        else
            i := Rect.Left;

        if((Sender as TStringGrid).Cells[2,ARow] = 'C') then
            (Sender as TStringGrid).Canvas.Font.Color := clRed
        else
            (Sender as TStringGrid).Canvas.Font.Color := clBlue;
        (Sender as TStringGrid).Canvas.FillRect(Rect);
        (Sender as TStringGrid).Canvas.TextOut(Round(i),Rect.Top+2,sCad);

    end;
end;

procedure TfrmVentasConsulta.Salir1Click(Sender: TObject);
begin
    Close;
end;

procedure TfrmVentasConsulta.mnuAvanzaClick(Sender: TObject);
begin
    with dmDatos.cdsCliente do begin
        if(Active) then begin
            Next;
            if(pgeGeneral.ActivePage <> tabBusqueda) then
                RecuperaDatos;
        end;
    end;
end;

procedure TfrmVentasConsulta.mnuRetrocedeClick(Sender: TObject);
begin
    with dmDatos.cdsCliente do begin
        if(Active) then begin
            Prior;
            if(pgeGeneral.ActivePage <> tabBusqueda) then
                RecuperaDatos;
        end;
    end;
end;

procedure TfrmVentasConsulta.grdListadoDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
    if(dmDatos.cdsCliente.FieldByName('estatus').AsString = 'A') then
        (Sender as TDBGrid).Canvas.Brush.Color := $00DCBFA5
    else
        (Sender as TDBGrid).Canvas.Brush.Color := $0099A7F7;
    (Sender as TDBGrid).Canvas.FillRect(Rect);
    (Sender as TDBGrid).DefaultDrawColumnCell(Rect,DataCol,Column,State);

end;

procedure TfrmVentasConsulta.pgeGeneralChange(Sender: TObject);
begin
    if(pgeGeneral.ActivePage <> tabBusqueda) then begin
        mnuBuscar.Enabled := false;
        mnuLimpiar.Enabled := false;
        mnuSeleccionar.Enabled := false;
    end
    else begin
        mnuBuscar.Enabled := true;
        mnuLimpiar.Enabled := true;
        mnuSeleccionar.Enabled := true;
       
    end;
end;

procedure TfrmVentasConsulta.mnuDatosClick(Sender: TObject);
begin
    pgeGeneral.ActivePage := tabDatos;
end;

procedure TfrmVentasConsulta.mnuBusquedaClick(Sender: TObject);
begin
    pgeGeneral.ActivePage := tabBusqueda;
end;

procedure TfrmVentasConsulta.RecuperaConfig;
var
    iniArchivo : TIniFile;
    sIzq, sArriba, sValor : String;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'config.ini');

    with iniArchivo do begin
        //Recupera la posición Y de la ventana
        sArriba := ReadString('ConsulVenta', 'Posy', '');

        //Recupera la posición X de la ventana
        sIzq := ReadString('ConsulVenta', 'Posx', '');

        if (Length(sIzq) > 0) and (Length(sArriba) > 0) then begin
            Left := StrToInt(sIzq);
            Top := StrToInt(sArriba);
        end;

        //Recupera el valor de los botones de radio de orden
        sValor := ReadString('ConsulVenta', 'Orden', '');

        if (Length(sValor) > 0) then
            rdgOrden.ItemIndex := StrToInt(sValor);

        //Recupera la ultima ficha que se seleccionó
        sValor := ReadString('ConsulVenta', 'Ficha', '');
        if (Length(sValor) > 0) then
            pgeGeneral.ActivePageIndex := StrToInt(sValor);

        Free;
    end;
end;

procedure TfrmVentasConsulta.rdgOrdenClick(Sender: TObject);
begin
    if(dmDatos.cdsCliente.Active) then
        btnBuscar.Click;
end;

procedure TfrmVentasConsulta.txtAnioIniExit(Sender: TObject);
begin
    txtAnioIni.Text := Trim(txtAnioIni.Text);
    if(Length(txtAnioIni.Text) < 4) and (Length(txtAnioIni.Text) > 0) then
        txtAnioIni.Text := IntToStr(StrToInt(txtAnioIni.Text) + 2000);
end;

procedure TfrmVentasConsulta.txtAnioFinExit(Sender: TObject);
begin
    txtAnioFin.Text := Trim(txtAnioFin.Text);
    if(Length(txtAnioFin.Text) < 4) and (Length(txtAnioFin.Text) > 0) then
        txtAnioFin.Text := IntToStr(StrToInt(txtAnioFin.Text) + 2000);
end;

procedure TfrmVentasConsulta.Rellena(Sender: TObject);
var
    i : integer;
begin
    for i := Length((Sender as TEdit).Text) to (Sender as TEdit).MaxLength - 1 do
        (Sender as TEdit).Text := '0' + (Sender as TEdit).Text;
end;

procedure TfrmVentasConsulta.txtDiaIniExit(Sender: TObject);
begin
    Rellena(Sender);
end;

procedure TfrmVentasConsulta.chkVendedorClick(Sender: TObject);
begin
    if(chkVendedor.Checked) then begin
        txtVendedorBusq.Visible := true;
        txtVendedorBusq.SetFocus;
    end
    else
        txtVendedorBusq.Visible:=False;
end;

procedure TfrmVentasConsulta.grdListadoEnter(Sender: TObject);
begin
    btnSeleccionar.Default := true;
    btnBuscar.Default := false;
end;

procedure TfrmVentasConsulta.grdListadoExit(Sender: TObject);
begin
    btnBuscar.Default := true;
    btnSeleccionar.Default := false;
end;

procedure TfrmVentasConsulta.F1Click(Sender: TObject);
begin
if (pedido.Checked = true) then
begin
 ped.Visible:= true;
pedido.Checked:= false;
end
else
begin

ped.Visible:= false;
pedido.Checked:= true;
end;
end;

end.
