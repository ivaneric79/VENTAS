// --------------------------------------------------------------------------
// Archivo del Proyecto Ventas 
// Página del proyecto: http://sourceforge.net/projects/ventas
// --------------------------------------------------------------------------
// Este archivo puede ser distribuido y/o modificado bajo lo terminos de la
// Licencia Pública General versión 2 como es publicada por la Free Software
// Fundation, Inc.
// --------------------------------------------------------------------------

unit ConsulCompra;

interface

uses
  SysUtils, Types, Classes, QGraphics, QControls, QForms, QDialogs, DB,
  QStdCtrls, QcurrEdit, QComCtrls, QButtons, QGrids, QExtCtrls, QDBGrids,
  QMenus, QTypes, IniFiles;

type
  TfrmConsulCompra = class(TForm)
    pgeGeneral: TPageControl;
    tabDatos: TTabSheet;
    tabBusqueda: TTabSheet;
    GroupBox1: TGroupBox;
    txtDocumento: TEdit;
    txtProveedor: TEdit;
    txtUsuario: TEdit;
    txtFechaCap: TEdit;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
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
    chkEstatus: TCheckBox;
    chkProveedor: TCheckBox;
    chkUsuario: TCheckBox;
    chkFecha: TCheckBox;
    chkArticulo: TCheckBox;
    txtUsuarioBusq: TEdit;
    txtProveedorBusq: TEdit;
    cmbEstatus: TComboBox;
    txtCajaBusq: TcurrEdit;
    txtArticulo: TEdit;
    rdgOrden: TGroupBox;
    rdbCaja: TRadioButton;
    rdbEstatus: TRadioButton;
    rdbProveedor: TRadioButton;
    rdbFecha: TRadioButton;
    rdbTotal: TRadioButton;
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
    rdbDocumento: TRadioButton;
    grdListado: TDBGrid;
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
    pnlEstatus: TPanel;
    chkDocumento: TCheckBox;
    txtDocumentoBusq: TEdit;
    Label2: TLabel;
    txtCaja: TEdit;
    chkTipoPago: TCheckBox;
    cmbTipoPago: TComboBox;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    grdDetalleCompra: TStringGrid;
    TabSheet2: TTabSheet;
    grdTipoPago: TStringGrid;
    GroupBox4: TGroupBox;
    txtSubtotal: TcurrEdit;
    lblsub: TLabel;
    Label6: TLabel;
    txtIva: TcurrEdit;
    txtTotal: TcurrEdit;
    Label7: TLabel;
    Label8: TLabel;
    txtFechaComp: TEdit;
    txtTipo: TEdit;
    Label9: TLabel;
    procedure btnBuscarClick(Sender: TObject);
    procedure chkFechaClick(Sender: TObject);
    procedure chkEstatusClick(Sender: TObject);
    procedure chkArticuloClick(Sender: TObject);
    procedure chkProveedorClick(Sender: TObject);
    procedure chkUsuarioClick(Sender: TObject);
    procedure chkCajaClick(Sender: TObject);
    procedure btnLimpiarClick(Sender: TObject);
    procedure btnSeleccionarClick(Sender: TObject);
    procedure Salir1Click(Sender: TObject);
    procedure chkDocumentoClick(Sender: TObject);
    procedure grdDetalleCompraDrawCell(Sender: TObject; ACol,
      ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure mnuDatosClick(Sender: TObject);
    procedure mnuBusquedaClick(Sender: TObject);
    procedure mnuAvanzaClick(Sender: TObject);
    procedure mnuRetrocedeClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure rdbDocumentoClick(Sender: TObject);
    procedure rdbEstatusClick(Sender: TObject);
    procedure rdbCajaClick(Sender: TObject);
    procedure rdbProveedorClick(Sender: TObject);
    procedure rdbFechaClick(Sender: TObject);
    procedure rdbTotalClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure txtMesIniKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure grdListadoDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure grdTipoPagoDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure txtAnioIniExit(Sender: TObject);
    procedure txtAnioFinExit(Sender: TObject);
    procedure txtDiaIniExit(Sender: TObject);
    procedure chkTipoPagoClick(Sender: TObject);
    procedure grdListadoEnter(Sender: TObject);
    procedure grdListadoExit(Sender: TObject);
    procedure grdDetalleCompraMouseUp(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);

  private
        iClave: Integer;
        sRdBuscar :String;
        procedure RecuperaDatos;
        procedure LimpiaDatos;
        procedure RecuperaConfig;
        procedure IniRejillas;
        procedure Rellena(Sender: TObject);
        function  VerificaFechas(sFecha : string) : boolean;
        function  VerificaDatos : boolean;

  public
    { Public declarations }
  end;

var
  frmConsulCompra: TfrmConsulCompra;

implementation

uses dm;

{$R *.xfm}



procedure TfrmConsulCompra.btnBuscarClick(Sender: TObject);

begin
    dmDatos.cdsCliente.Active := false;
    if(VerificaDatos) then begin
        with dmDatos.qryListados do begin
            Close;
            SQL.Clear;
            SQL.Add('SELECT clave, caja, documento, fecha, estatus, total-iva AS subtotal,');
            SQL.Add('iva, total, proveedor, usuario FROM compras WHERE 1=1');
            if(chkDocumento.Checked) then
                SQL.Add('AND documento STARTING ''' + txtDocumentoBusq.Text + '''');
            if(chkCaja.Checked) then
                SQL.Add('AND caja=' + txtCajaBusq.Text + '');
            if(chkArticulo.Checked) then
                SQL.Add('AND clave IN(SELECT d.compra FROM comprasdet d LEFT JOIN articulos a ON d.articulo=a.clave WHERE a.desc_larga LIKE ''%' + txtArticulo.Text + '%'')');
            if(chkEstatus.Checked) then
                SQL.Add('AND estatus='''+ copy(cmbEstatus.Items.Strings[cmbEstatus.ItemIndex],1,1)+ '''');
            if(chkProveedor.Checked) then
                SQL.Add('AND proveedor IN(SELECT clave FROM proveedores WHERE nombre LIKE ''%' + txtProveedorBusq.Text + '%'')');
            if(chkUsuario.Checked) then
                SQL.Add('AND usuario IN(SELECT clave FROM usuarios WHERE nombre LIKE ''%' + txtUsuarioBusq.Text + '%'')');
            if(chkFecha.Checked) then begin
                SQL.Add('AND fecha >= ''' + txtMesIni.Text + '/' + txtDiaIni.Text + '/' + txtAnioIni.Text + '''');
                SQL.Add('AND fecha <= ''' + txtMesFin.Text + '/' + txtDiaFin.Text + '/' + txtAnioFin.Text + '''');
            end;
            if(chkTipoPago.Checked) then begin
                SQL.Add('AND clave IN (SELECT p.compra FROM compraspago p LEFT JOIN tipopago t ON p.tipopago = t.clave');
                SQL.Add('WHERE t.nombre = ''' + cmbTipoPago.Text + ''')');
            end;

            if(rdbDocumento.Checked) then
                SQL.Add('ORDER BY Documento');
            if(rdbEstatus.Checked) then
                SQL.Add('ORDER BY Estatus');
            if(rdbCaja.Checked) then
                SQL.Add('ORDER BY Caja');
            if(rdbProveedor.Checked) then
                SQL.Add('ORDER BY Proveedor');
            if(rdbFecha.Checked) then
                SQL.Add('ORDER BY fecha');
            if(rdbTotal.Checked) then
                SQL.Add('ORDER BY total');

            with dmDatos.cdsCliente do begin
                Active := true;

                txtRegistros.Value := RecordCount;
                FieldByName('usuario').Visible := false;
                FieldByName('clave').Visible := False;
                FieldByName('proveedor').Visible := False;
                FieldByName('caja').DisplayLabel := 'Caja';
                FieldByName('caja').DisplayWidth := 4;
                FieldByName('documento').DisplayLabel := 'Documento';
                FieldByName('fecha').DisplayLabel := 'Fecha';
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
            end;
            Open;
            Active := true;
            dmDatos.cdsCliente.Active := true;
            txtRegistros.Value := dmDatos.cdsCliente.RecordCount;

            if(pgeGeneral.ActivePage = tabBusqueda) then
                grdListado.SetFocus;
            dmDatos.cdsCliente.Active := true;
        end;
    end;
end;

procedure TfrmConsulCompra.chkFechaClick(Sender: TObject);
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

procedure TfrmConsulCompra.chkEstatusClick(Sender: TObject);
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

procedure TfrmConsulCompra.chkArticuloClick(Sender: TObject);
begin
    if(chkArticulo.Checked) then begin
        txtArticulo.Visible := true;
        txtArticulo.SetFocus;
    end
    else
        txtArticulo.Visible:=False;
end;

procedure TfrmConsulCompra.chkProveedorClick(Sender: TObject);
begin
 if(chkProveedor.Checked) then begin
        txtProveedorBusq.Visible := true;
        txtProveedorBusq.SetFocus;
    end
    else
        txtProveedorBusq.Visible := false;
end;

procedure TfrmConsulCompra.chkUsuarioClick(Sender: TObject);
begin
    if(chkUsuario.Checked) then begin
        txtUsuarioBusq.Visible := true;
        txtUsuarioBusq.SetFocus;
    end
    else
        txtUsuarioBusq.Visible:=False;
end;

procedure TfrmConsulCompra.chkCajaClick(Sender: TObject);
begin
    if(chkCaja.Checked) then begin
        txtCajaBusq.Visible := true;
        txtCajaBusq.SetFocus;

    end
    else begin
        txtCajaBusq.Visible := false;
    end;
end;

procedure TfrmConsulCompra.btnLimpiarClick(Sender: TObject);
begin
    txtArticulo.Clear;
    txtCajaBusq.Value := 1;
    txtProveedorBusq.Clear;
    txtDiaIni.Clear;
    txtMesIni.Clear;
    txtAnioIni.Clear;
    txtDiaFin.Clear;
    txtMesFin.Clear;
    txtAnioFin.Clear;
    txtDocumento.Clear;
    txtUsuarioBusq.Clear;
end;


procedure TfrmConsulCompra.btnSeleccionarClick(Sender: TObject);
begin
    if (txtRegistros.Value > 0) then
        RecuperaDatos;
end;

procedure TfrmConsulCompra.RecuperaDatos;
var
    iProveedor,iUsuario,iCont :Integer;
    sDescrip : String;
    iCantidad,fCosto: Real;
begin
    iClave := dmDatos.cdsCliente.FieldByName('clave').AsInteger;
    with dmDatos.qryConsulta do begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT * FROM compras WHERE clave=' + IntToStr(iClave));
        Open;
        if(not Eof) then begin
            pgeGeneral.ActivePageIndex := 0;
            txtCaja.Text:=FieldByName('caja').AsString;
            txtDocumento.Text := FieldByName('documento').AsString;
            if(FieldByName('tipo').AsString = 'A') then
                txtTipo.Text := 'AJUSTE'
            else if(FieldByName('tipo').AsString = 'M') then
                txtTipo.Text := 'MERCANCIA'
            else if(FieldByName('tipo').AsString = 'G') then
                txtTipo.Text := 'GASTO';
                
            if(FieldByName('estatus').AsString = 'A') then begin
                pnlEstatus.Caption := 'ACTIVA';
                pnlEstatus.Color := $00DCBFA5;
            end
            else begin
                pnlEstatus.Caption := 'CANCELADA';
                pnlEstatus.Color := $0099A7F7;
            end;
            txtFechaCap.Text := FormatDateTime('dd/mm/yyyy', FieldByName('fecha_cap').AsDateTime);
            txtFechaComp.Text := FormatDateTime('dd/mm/yyyy', FieldByName('fecha').AsDateTime);

            txtIva.Value:= FieldByName('iva').AsFloat;
            txtTotal.Value := FieldByName('total').AsFloat;
            txtSubtotal.Value:= txtTotal.Value-txtIva.Value;
            iProveedor:=FieldByName('proveedor').AsInteger;
            iUsuario:=FieldByName('usuario').AsInteger;
            Close;

            SQL.Clear;
            SQL.Add('SELECT nombre FROM proveedores WHERE clave='+IntToStr(iProveedor));
            Open;
            txtProveedor.Text := FieldByName('nombre').AsString;

            Close;
            SQL.Clear;
            SQL.Add('SELECT nombre FROM usuarios WHERE clave='+IntToStr(iUsuario));
            Open;
            txtUsuario.Text := FieldByName('nombre').AsString;

            Close;
            SQL.Clear;
            SQL.Add('SELECT d.cantidad,d.costo,a.desc_larga FROM comprasdet');
            SQL.Add('d LEFT JOIN articulos a ON d.articulo=a.clave WHERE');
            SQL.Add('d.compra='+IntToStr(iClave)+' ORDER BY d.orden');
            Open;
            iCont:=0;
            while (not Eof) do begin
                sDescrip := FieldByName('desc_larga').AsString;
                iCantidad := FieldByName('cantidad').AsFloat;
                fCosto := FieldByName('costo').AsFloat;
                Inc(iCont);
                grdDetalleCompra.RowCount:= iCont+1;
                grdDetalleCompra.Cells[0,iCont]:=FloatToStr(iCantidad);
                grdDetalleCompra.Cells[1,iCont]:=sDescrip;
                grdDetalleCompra.Cells[2,iCont]:=FloatToStr(fCosto);
                fCosto:=fCosto*iCantidad;
                grdDetalleCompra.Cells[3,iCont]:=FloatToStr(fCosto);
                Next;
            end;

            Close;
            SQL.Clear;
            SQL.Add('SELECT t.nombre, c.importe, c.referencia FROM compraspago c LEFT JOIN tipopago t ON c.tipopago = t.clave WHERE c.compra = ' + IntToStr(iClave));
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
        end
        else
            LimpiaDatos;
    end;
end;
procedure TfrmConsulCompra.Salir1Click(Sender: TObject);
begin
    Close;
end;

procedure TfrmConsulCompra.LimpiaDatos;
begin
    txtCaja.Clear;
    txtDocumento.Clear;
    txtProveedor.Clear;
    txtUsuario.Clear;
    txtFechaCap.Clear;
    txtFechaComp.Clear;
    txtSubtotal.Clear;
    txtTotal.Clear;
    txtIva.Clear;
    pnlEstatus.Caption:='';
    grdDetalleCompra.RowCount:=2;
    grdDetalleCompra.Cells[0,1]:='';
    grdDetalleCompra.Cells[1,1]:='';
    grdDetalleCompra.Cells[2,1]:='';
    grdDetalleCompra.Cells[3,1]:='';
end;

procedure TfrmConsulCompra.chkDocumentoClick(Sender: TObject);
begin
    if(chkDocumento.Checked) then begin
        txtDocumentoBusq.Visible := true;
        txtDocumentoBusq.SetFocus;
    end
    else
        txtDocumentoBusq.Visible:=False;
end;

procedure TfrmConsulCompra.grdDetalleCompraDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
Var
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
        if(ACol > 1) and (ARow > 0) then begin
            sCad := FormatFloat('#,##0.00',StrToFloat(sCad));
            i := Rect.Right-(Sender as TStringGrid).Canvas.TextWidth(sCad+' ');
            (Sender as TStringGrid).Canvas.FillRect(Rect);
            (Sender as TStringGrid).Canvas.TextOut(Round(i),Rect.Top+2,sCad);
        end;
    end;
end;

procedure TfrmConsulCompra.mnuDatosClick(Sender: TObject);
begin
    pgeGeneral.ActivePage := tabDatos;
end;

procedure TfrmConsulCompra.mnuBusquedaClick(Sender: TObject);
begin
    pgeGeneral.ActivePage := tabBusqueda;
end;

procedure TfrmConsulCompra.mnuAvanzaClick(Sender: TObject);
begin
    with dmDatos.cdsCliente do begin
        if(Active) then begin
            Next;
            if(pgeGeneral.ActivePage <> tabBusqueda) then
                RecuperaDatos;
        end;
    end;
end;

procedure TfrmConsulCompra.mnuRetrocedeClick(Sender: TObject);
begin
    with dmDatos.cdsCliente do begin
        if(Active) then begin
            Prior;
            if(pgeGeneral.ActivePage <> tabBusqueda) then
                RecuperaDatos;
        end;
    end;
end;

procedure TfrmConsulCompra.FormClose(Sender: TObject;
  var Action: TCloseAction);
  var
    iniArchivo : TIniFile;
begin
    dmDatos.qryListados.Close;
    dmDatos.cdsCliente.Active := false;

    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'config.ini');
    with iniArchivo do begin
        // Registra la posición y de la ventana
        WriteString('ConsulCompra', 'Posy', IntToStr(Top));

        // Registra la posición X de la ventana
        WriteString('ConsulCompra', 'Posx', IntToStr(Left));

        //Registra el valor de los botones de radio de orden
        WriteString('ConsulCompra', 'Orden', sRdBuscar);

        //Registra la ultima ficha que se seleccionó
        WriteString('ConsulCompra', 'Ficha', IntToStr(pgeGeneral.ActivePageIndex));

        Free;
    end;
end;

procedure TfrmConsulCompra.FormShow(Sender: TObject);
begin
    IniRejillas;
    with dmDatos.qryConsulta do begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT nombre FROM tipopago ORDER BY nombre');
        Open;
        cmbTipoPago.Items.Clear;
        while (not Eof) do begin
            cmbTipoPago.Items.Add(Trim(FieldByName('nombre').AsString));
            Next;
        end;
        Close;
    end;
end;

procedure TfrmConsulCompra.RecuperaConfig;
var
    iniArchivo : TIniFile;
    sIzq, sArriba, sValor : String;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'config.ini');

    with iniArchivo do begin
        //Recupera la posición Y de la ventana
        sArriba := ReadString('ConsulCompra', 'Posy', '');

        //Recupera la posición X de la ventana
        sIzq := ReadString('ConsulCompra', 'Posx', '');

        if (Length(sIzq) > 0) and (Length(sArriba) > 0) then begin
            Left := StrToInt(sIzq);
            Top := StrToInt(sArriba);
        end;

        //Recupera el valor de los botones de radio de orden
        sRdBuscar := ReadString('ConsulCompra', 'Orden', '');

        if (Length(sRdBuscar) > 0) then begin
            if (sRdBuscar='D')then
                rdbDocumento.Checked:=True;
            if (sRdBuscar='E')then
                rdbEstatus.Checked:=True;
            if (sRdBuscar='C')then
                rdbCaja.Checked:=True;
            if (sRdBuscar='P')then
                rdbProveedor.Checked:=True;
            if (sRdBuscar='F')then
                rdbFecha.Checked:=True;
            if (sRdBuscar='T')then
                rdbTotal.Checked:=True;
        end;

        //Recupera la {ultima ficha que se seleccionó
        sValor := ReadString('ConsulCompra', 'Ficha', '');
        if (Length(sValor) > 0) then
            pgeGeneral.ActivePageIndex := StrToInt(sValor);
        Free;

    end;
end;
procedure TfrmConsulCompra.IniRejillas;
begin
    grdDetalleCompra.RowCount := 2;
    grdDetalleCompra.ColWidths[0] := 40;
    grdDetalleCompra.ColWidths[1] := 350;
    grdDetalleCompra.ColWidths[2] := 68;
    grdDetalleCompra.ColWidths[3] := 75;
    grdDetalleCompra.Cells[0,0] := 'Cant.';
    grdDetalleCompra.Cells[1,0] := 'Artículo';
    grdDetalleCompra.Cells[2,0] := 'Precio';
    grdDetalleCompra.Cells[3,0] := 'Importe';
    grdDetalleCompra.Cells[0,1] := '';
    grdDetalleCompra.Cells[1,1] := '';
    grdDetalleCompra.Cells[2,1] := '';
    grdDetalleCompra.Cells[3,1] := '';
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
end;

procedure TfrmConsulCompra.rdbDocumentoClick(Sender: TObject);
begin
    sRdBuscar:='D';
    btnBuscar.Click;
end;

procedure TfrmConsulCompra.rdbEstatusClick(Sender: TObject);
begin
    sRdBuscar:='E';
    btnBuscar.Click;
end;

procedure TfrmConsulCompra.rdbCajaClick(Sender: TObject);
begin
    sRdBuscar:='C';
    btnBuscar.Click;
end;

procedure TfrmConsulCompra.rdbProveedorClick(Sender: TObject);
begin
    sRdBuscar:='P';
    btnBuscar.Click;
end;

procedure TfrmConsulCompra.rdbFechaClick(Sender: TObject);
begin
    sRdBuscar:='F';
    btnBuscar.Click;
end;

procedure TfrmConsulCompra.rdbTotalClick(Sender: TObject);
begin
    sRdBuscar:='T';
    btnBuscar.Click;
end;

procedure TfrmConsulCompra.FormCreate(Sender: TObject);
begin
    Recuperaconfig;
end;

procedure TfrmConsulCompra.txtMesIniKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    {Inicio (36), Fin (35), Izquierda (37), derecha (39), arriba (38), abajo (40)}
    if(Key >= 30) and (Key <= 122) and (Key <> 35) and (Key <> 36) and not ((Key >= 37) and (Key <= 40)) then
        if( Length((Sender as TEdit).Text) = (Sender as TEdit).MaxLength) then
            SelectNext(Sender as TWidgetControl, true, true);
end;

procedure TfrmConsulCompra.grdListadoDrawColumnCell(Sender: TObject;
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

procedure TfrmConsulCompra.grdTipoPagoDrawCell(Sender: TObject; ACol,
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

procedure TfrmConsulCompra.txtAnioIniExit(Sender: TObject);
begin
    txtAnioIni.Text := Trim(txtAnioIni.Text);
    if(Length(txtAnioIni.Text) < 4) and (Length(txtAnioIni.Text) > 0) then
        txtAnioIni.Text := IntToStr(StrToInt(txtAnioIni.Text) + 2000);
end;

procedure TfrmConsulCompra.txtAnioFinExit(Sender: TObject);
begin
    txtAnioFin.Text := Trim(txtAnioFin.Text);
    if(Length(txtAnioFin.Text) < 4) and (Length(txtAnioFin.Text) > 0) then
        txtAnioFin.Text := IntToStr(StrToInt(txtAnioFin.Text) + 2000);
end;

procedure TfrmConsulCompra.txtDiaIniExit(Sender: TObject);
begin
    Rellena(Sender);
end;

procedure TfrmConsulCompra.Rellena(Sender: TObject);
var
    i : integer;
begin
    for i := Length((Sender as TEdit).Text) to (Sender as TEdit).MaxLength - 1 do
        (Sender as TEdit).Text := '0' + (Sender as TEdit).Text;
end;

function TfrmConsulCompra.VerificaFechas(sFecha : string) : boolean;
var
   dteFecha : TDateTime;
begin
   Result:=true;
   if(not TryStrToDate(sFecha,dteFecha)) then begin
      Result:=false;
   end;
end;

function TfrmConsulCompra.VerificaDatos : boolean;
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
end;

procedure TfrmConsulCompra.chkTipoPagoClick(Sender: TObject);
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

procedure TfrmConsulCompra.grdListadoEnter(Sender: TObject);
begin
    btnSeleccionar.Default:=true;
    btnBuscar.Default:=false;
end;

procedure TfrmConsulCompra.grdListadoExit(Sender: TObject);
begin
    btnSeleccionar.Default:=false;
    btnBuscar.Default:=true;
end;

procedure TfrmConsulCompra.grdDetalleCompraMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  var
  row, col: Longint;
begin
grdDetalleCompra.MouseToCell(X, Y,col, row);
//ShowMessage(grdDetalleCompra.Cells[col,row]);
  if ((col = 1) and (row > 0)) then
  begin
     if (grdDetalleCompra.Cells[col,row] <>'') then
     begin
    MessageDlg(grdDetalleCompra.Cells[col,row], mtCustom, [mbOk], 0, mbOk);
      end;
  end;
//Application.MessageBox(grdDetalleCompra.Cells[col,row],'Descripción',[smbOK],smsCustom);
end;

end.
