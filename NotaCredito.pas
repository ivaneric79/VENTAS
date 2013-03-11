// --------------------------------------------------------------------------
// Archivo del Proyecto Ventas
// Página del proyecto: http://sourceforge.net/projects/ventas
// --------------------------------------------------------------------------
// Este archivo puede ser distribuido y/o modificado bajo lo terminos de la
// Licencia Pública General versión 2 como es publicada por la Free Software
// Fundation, Inc.
// --------------------------------------------------------------------------

unit NotaCredito;

interface

uses
  SysUtils, Types, Classes, Variants, QTypes, QGraphics, QControls, QForms,
  QDialogs, QStdCtrls, QComCtrls, QMenus, QButtons, QGrids, QDBGrids,
  QcurrEdit, QExtCtrls, IniFiles, rpcompobase, rpclxreport, DB;

type
  TfrmNotaCredito = class(TForm)
    pgeGeneral: TPageControl;
    MainMenu1: TMainMenu;
    mnuArchivo: TMenuItem;
    mnuInsertar: TMenuItem;
    mnuEliminar: TMenuItem;
    mnuImprimir: TMenuItem;
    N3: TMenuItem;
    mnuGuardar: TMenuItem;
    mnuCancelar: TMenuItem;
    N2: TMenuItem;
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
    mnuNotaCred: TMenuItem;
    mnuBusqueda: TMenuItem;
    tabDatos: TTabSheet;
    tabBusqueda: TTabSheet;
    grdListado: TDBGrid;
    btnBuscar: TBitBtn;
    btnSeleccionar: TBitBtn;
    btnLimpiar: TBitBtn;
    Label17: TLabel;
    txtRegistros: TcurrEdit;
    rdgOrden: TRadioGroup;
    btnInsertar: TBitBtn;
    btnEliminar: TBitBtn;
    btnGuardar: TBitBtn;
    btnCancelar: TBitBtn;
    grpCriterios: TGroupBox;
    grpDevolucion: TGroupBox;
    txtDevNumero: TcurrEdit;
    Label2: TLabel;
    lblCajaDev: TLabel;
    txtCajaDev: TcurrEdit;
    grpCliente: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    txtNombre: TEdit;
    txtRFC: TEdit;
    Label11: TLabel;
    cmbCategorias: TComboBox;
    grpDomicilio: TGroupBox;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label12: TLabel;
    txtCalle: TEdit;
    txtColonia: TEdit;
    txtLocalidad: TEdit;
    txtEstado: TEdit;
    txtCP: TEdit;
    Label32: TLabel;
    txtTelefono: TEdit;
    Label14: TLabel;
    txtCelular: TEdit;
    Label33: TLabel;
    txtCorreo: TEdit;
    grpImportes: TGroupBox;
    txtTotal: TcurrEdit;
    Label1: TLabel;
    txtDevFecha: TEdit;
    Label3: TLabel;
    chkFecha: TCheckBox;
    txtDiaIni: TEdit;
    lblDiagDia1: TLabel;
    txtMesIni: TEdit;
    lblDiagMes1: TLabel;
    txtAnioIni: TEdit;
    lblAl: TLabel;
    txtDiaFin: TEdit;
    lblDiagDia2: TLabel;
    txtMesFin: TEdit;
    lblDiagMes2: TLabel;
    txtAnioFin: TEdit;
    chkNoNota: TCheckBox;
    lblDesdeNota: TLabel;
    txtNotaIni: TcurrEdit;
    lblHastaNota: TLabel;
    txtNotaFin: TcurrEdit;
    txtClienteBusq: TEdit;
    chkCliente: TCheckBox;
    grpNotaCredito: TGroupBox;
    txtNotaNumero: TcurrEdit;
    Label4: TLabel;
    Label18: TLabel;
    pnlNormal: TPanel;
    Label25: TLabel;
    Label23: TLabel;
    pnlJuego: TPanel;
    pnlNoInventariable: TPanel;
    Label24: TLabel;
    txtNotaFecha: TEdit;
    pnlEstatus: TPanel;
    btnImprimir: TBitBtn;
    rptComprobante: TCLXReport;
    chkEstatus: TCheckBox;
    cmbEstatusBusq: TComboBox;
    N5: TMenuItem;
    mnuSalir: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnBuscarClick(Sender: TObject);
    procedure chkFechaClick(Sender: TObject);
    procedure chkNoNotaClick(Sender: TObject);
    procedure chkClienteClick(Sender: TObject);
    procedure rdgOrdenClick(Sender: TObject);
    procedure btnLimpiarClick(Sender: TObject);
    procedure txtAnioIniExit(Sender: TObject);
    procedure txtAnioFinExit(Sender: TObject);
    procedure txtDiaIniExit(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure grdListadoDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure txtDevNumeroExit(Sender: TObject);
    procedure btnInsertarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnEliminarClick(Sender: TObject);
    procedure grdListadoEnter(Sender: TObject);
    procedure grdListadoExit(Sender: TObject);
    procedure txtNotaIniExit(Sender: TObject);
    procedure txtRFCExit(Sender: TObject);
    procedure btnSeleccionarClick(Sender: TObject);
    function RecuperaNumNota: integer;
    procedure btnGuardarClick(Sender: TObject);
    procedure mnuAvanzaClick(Sender: TObject);
    procedure mnuRetrocedeClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure chkEstatusClick(Sender: TObject);
    procedure mnuSalirClick(Sender: TObject);
    procedure mnuNotaCredClick(Sender: TObject);
    procedure mnuBusquedaClick(Sender: TObject);
  private

    sGlobalDev, sGlobalNotaCred, sLocalidad, sEstado, sModo : String;
    iClave, iCaja : Integer;
    sUnidades : Array [1..30] of String;
    sDecenas : Array [1..7] of String;
    sCentenas : Array [1..9] of String;

    procedure InicializaNumeros;
    function ConvNumero(rNumero:Real; bPesos :boolean):String;
    procedure RecuperaConfig;
    procedure VerificaCategs;
    procedure Rellena(Sender: TObject);
    procedure BuscaComp;
    procedure VerificaCompGlobal;
    procedure RecuperaCategs;
    procedure ActivaControles;
    procedure RecuperaDatos;
    procedure ActivaBuscar;
    function BuscaCateg(sCateg:String):String;
    procedure LimpiaDatos(sTipo : String);
    function VerificaDatos: boolean;
    function VerificaNumNota: boolean;
    function VerificaDev: boolean;
    procedure GuardaDatos;
    procedure  Colores(sTipo : String);
  public
    bSeleccion : boolean;
    sTipo, sNota, sCaja : String;
  end;

var
  frmNotaCredito: TfrmNotaCredito;

implementation

uses dm;

{$R *.xfm}

procedure TfrmNotaCredito.FormCreate(Sender: TObject);
begin
    RecuperaConfig;
end;

procedure TfrmNotaCredito.RecuperaConfig;
var
    iniArchivo : TIniFile;
    sIzq, sArriba, sValor : String;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) +'config.ini');

    with iniArchivo do begin
        //Recupera la posición Y de la ventana
        sArriba := ReadString('NotaCredito', 'Posy', '');

        //Recupera la posición X de la ventana
        sIzq := ReadString('NotaCredito', 'Posx', '');

        if (Length(sIzq) > 0) and (Length(sArriba) > 0) then begin
            Left := StrToInt(sIzq);
            Top := StrToInt(sArriba);
        end;

        //Recupera el valor de los botones de radio de orden
        sValor := ReadString('NotaCredito', 'Orden', '');
        if (Length(sValor) > 0) then
            rdgOrden.ItemIndex := StrToInt(sValor);

        //Recupera la {ultima ficha que se seleccionó
        sValor := ReadString('NotaCredito', 'Ficha', '');
        if (Length(sValor) > 0) then
            pgeGeneral.ActivePageIndex := StrToInt(sValor);

        //Recupera el número de caja
        sValor := ReadString('Config', 'Caja', '');
        if (Length(sValor) > 0) then
            iCaja := StrToInt(sValor)
        else
            iCaja := 1;
        txtCajaDev.Value := iCaja;
        Free;

    end;
end;

procedure TfrmNotaCredito.FormShow(Sender: TObject);
begin
    bSeleccion := false;
    VerificaCategs;
    LimpiaDatos('Todo');
    VerificaCompGlobal;

    btnLimpiar.Click;
    RecuperaCategs;

    with dmDatos.qryModifica do begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT localidad, estado FROM empresa');
        Open;

        sLocalidad := Trim(FieldByName('localidad').AsString);
        sEstado := Trim(FieldByName('estado').AsString);
        Close;
    end;
    sModo := 'Consulta';
    ActivaControles;

    if(sTipo <> 'Captura') then begin
        pgeGeneral.ActivePage := tabBusqueda;
        tabDatos.TabVisible := false;
        mnuFichas.Enabled := false;
        mnuArchivo.Enabled := false;
        btnBuscarClick(Sender);
        mnuSalir.Enabled := true;
    end;
    ActivaBuscar;
end;

procedure TfrmNotaCredito.VerificaCategs;
begin
    with dmDatos.qryConsulta do begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT nombre FROM categorias WHERE tipo = ''C'' ORDER BY nombre');
        Open;

        cmbCategorias.Items.Clear;
        while (not Eof) do begin
            cmbCategorias.Items.Add(Trim(FieldByName('nombre').AsString));
            Next;
        end;
        Close;
        cmbCategorias.ItemIndex := 0;
    end;
end;

procedure TfrmNotaCredito.LimpiaDatos(sTipo : String);
begin
    if(sTipo <> 'Devoluciòn') then begin
        txtNotaNumero.Value := 0;
        txtNotaFecha.Clear;
        txtDevNumero.Value := 0;
        txtCajaDev.Value := 0;
    end;
    txtRFC.Clear;
    txtDevFecha.Clear;
    txtNombre.Clear;
    txtCalle.Clear;
    txtColonia.Clear;
    txtCP.Clear;
    txtLocalidad.Clear;
    txtEstado.Clear;
    txtTelefono.Clear;
    txtCelular.Clear;
    txtCorreo.Clear;
    txtTotal.Value := 0;
end;

procedure TfrmNotaCredito.btnBuscarClick(Sender: TObject);
var
    sBM: string;
begin
    with dmDatos.qryListados do begin
        sBM := dmDatos.cdsCliente.Bookmark;
        dmDatos.cdsCliente.Active := false;

        Close;
        SQL.Clear;

        SQL.Add('SELECT n.numero, n.fecha, n.clave, c.nombre as Cliente,');
        SQL.Add('n.importe, n.estatus, n.caja FROM notascredito n ');
        SQL.Add('LEFT JOIN clientes c ON n.cliente = c.clave WHERE 1 = 1');

        if(chkNoNota.Checked) then begin
            SQL.Add(' AND n.numero >= ' + FloatToStr(txtNotaIni.Value));
            SQL.Add(' AND n.numero <= ' + FloatToStr(txtNotaFin.Value));
        end;

        if(chkFecha.Checked) then begin
            SQL.Add('AND n.fecha >= ''' + txtMesIni.Text + '/' + txtDiaIni.Text + '/' + txtAnioIni.Text + '''');
            SQL.Add('AND n.fecha <= ''' + txtMesFin.Text + '/' + txtDiaFin.Text + '/' + txtAnioFin.Text + '''');
        end;

        if(chkCliente.Checked) then
            SQL.Add('AND c.nombre LIKE ''%' + txtClienteBusq.Text + '%'' ');

        if(chkEstatus.Checked) then
            SQL.Add('AND n.estatus = ''' + Copy(cmbEstatusBusq.Text,1,1) + '''');
            
        case rdgOrden.ItemIndex of
            0: SQL.Add('ORDER BY n.numero');
            1: SQL.Add('ORDER BY n.fecha');
            2: SQL.Add('ORDER BY c.nombre');
        end;

        Open;
        dmDatos.cdsCliente.Active := true;

        dmDatos.cdsCliente.FieldByName('clave').Visible := false;
        dmDatos.cdsCliente.FieldByName('numero').DisplayLabel := 'Nota crédito';
        dmDatos.cdsCliente.FieldByName('numero').DisplayWidth := 8;
        dmDatos.cdsCliente.FieldByName('fecha').DisplayLabel := 'Fecha';
        dmDatos.cdsCliente.FieldByName('importe').DisplayLabel := 'Importe';
        dmDatos.cdsCliente.FieldByName('importe').DisplayWidth := 8;
        (dmDatos.cdsCliente.FieldByName('importe') as TNumericField).DisplayFormat := '#,##0.00';
        dmDatos.cdsCliente.FieldByName('cliente').DisplayLabel := 'Cliente';
        dmDatos.cdsCliente.FieldByName('cliente').DisplayWidth := 35;
        dmDatos.cdsCliente.FieldByName('estatus').DisplayLabel := 'Estatus';
        dmDatos.cdsCliente.FieldByName('caja').DisplayLabel := 'Caja';

        txtRegistros.Value := dmDatos.cdsCliente.RecordCount;
        try
            dmDatos.cdsCliente.Bookmark := sBM;
        except
            txtRegistros.Value := txtRegistros.Value;
        end;

        if(pgeGeneral.ActivePage = tabBusqueda) then
            grdListado.SetFocus;
    end;
end;


procedure TfrmNotaCredito.chkFechaClick(Sender: TObject);
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

procedure TfrmNotaCredito.chkNoNotaClick(Sender: TObject);
begin
    if(chkNoNota.Checked) then begin
        txtNotaIni.Visible:=True;
        txtNotaFin.Visible:=True;
        lblDesdeNota.Visible:=True;
        lblHastaNota.visible:=True;
        txtNotaIni.SetFocus;
    end
    else begin
        txtNotaIni.Visible:=False;
        txtNotaFin.Visible:=False;
        lblDesdeNota.Visible:=False;
        lblHastaNota.visible:=False;
    end;
end;

procedure TfrmNotaCredito.chkClienteClick(Sender: TObject);
begin
    if(chkCliente.Checked) then begin
        txtClienteBusq.Visible := true;
        txtClienteBusq.SetFocus;
    end
    else
        txtClienteBusq.Visible := false;
end;

procedure TfrmNotaCredito.rdgOrdenClick(Sender: TObject);
begin
    if(dmDatos.cdsCliente.Active) then
        btnBuscar.Click;
end;

procedure TfrmNotaCredito.btnLimpiarClick(Sender: TObject);
begin
    txtClienteBusq.Clear;
    txtDiaIni.Clear;
    txtMesIni.Clear;
    txtAnioIni.Clear;
    txtDiaFin.Clear;
    txtMesFin.Clear;
    txtAnioFin.Clear;
    txtNotaIni.Value := 1;
    txtNotaFin.Value := 1;
end;

procedure TfrmNotaCredito.txtAnioIniExit(Sender: TObject);
begin
    txtAnioIni.Text := Trim(txtAnioIni.Text);
    if(Length(txtAnioIni.Text) < 4) and (Length(txtAnioIni.Text) > 0) then
        txtAnioIni.Text := IntToStr(StrToInt(txtAnioIni.Text) + 2000);
end;

procedure TfrmNotaCredito.txtAnioFinExit(Sender: TObject);
begin
    txtAnioFin.Text := Trim(txtAnioFin.Text);
    if(Length(txtAnioFin.Text) < 4) and (Length(txtAnioFin.Text) > 0) then
        txtAnioFin.Text := IntToStr(StrToInt(txtAnioFin.Text) + 2000);
end;

procedure TfrmNotaCredito.txtDiaIniExit(Sender: TObject);
begin
    Rellena(Sender);
end;

procedure TfrmNotaCredito.Rellena(Sender: TObject);
var
    i : integer;
begin
    for i := Length((Sender as TEdit).Text) to (Sender as TEdit).MaxLength - 1 do
        (Sender as TEdit).Text := '0' + (Sender as TEdit).Text;
end;

procedure TfrmNotaCredito.FormClose(Sender: TObject;   var Action: TCloseAction);
var
      iniArchivo : TIniFile;
begin
    dmDatos.qryListados.Close;
    dmDatos.cdsCliente.Active := false;

    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'config.ini');
    with iniArchivo do begin
        // Registra la posición y de la ventana
        WriteString('NotaCredito', 'Posy', IntToStr(Top));

        // Registra la posición X de la ventana
        WriteString('NotaCredito', 'Posx', IntToStr(Left));

        //Registra el valor de los botones de radio de orden
        WriteString('NotaCredito', 'Orden', IntToStr(rdgOrden.ItemIndex));

        //Registra la ultima ficha que se seleccionó
        WriteString('NotaCredito', 'Ficha', IntToStr(pgeGeneral.ActivePageIndex));

        Free;
   end;
end;
procedure TfrmNotaCredito.grdListadoDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
    if dmDatos.cdsCliente.FieldByName('estatus').AsString ='A' then
        grdListado.Canvas.Brush.Color := $00BFCAB7;
    if dmDatos.cdsCliente.FieldByName('estatus').AsString ='C' then
        grdListado.Canvas.Brush.Color := $0099A7F7;
    if dmDatos.cdsCliente.FieldByName('estatus').AsString ='U' then
        grdListado.Canvas.Brush.Color := $00DCBFA5;
        
    grdListado.Canvas.FillRect(Rect);
    grdListado.DefaultDrawColumnCell(Rect,DataCol,Column,State);
end;

procedure TfrmNotaCredito.txtDevNumeroExit(Sender: TObject);
begin
    BuscaComp;
end;

procedure TfrmNotaCredito.BuscaComp;
begin
    if(sModo = 'Insertar') then
        if(dmDatos.sqlBase.Connected) then begin
            with dmDatos.qryModifica do begin
                Close;
                SQL.Clear;
                SQL.Add('SELECT v.clave AS venta, l.rfc, l.nombre, l.calle, l.colonia,');
                SQL.Add('l.localidad, l.estado, l.cp, l.telefono, l.celular, l.ecorreo,');
                SQL.Add('v.clave AS venta, v.total, c.clave AS clavecomp, c.fecha, c.caja FROM comprobantes c');
                SQL.Add('LEFT JOIN clientes l ON c.cliente = l.clave LEFT JOIN ventas v');
                SQL.Add('ON c.venta = v.clave');
                SQL.Add('WHERE c.tipo = ''D''');
                SQL.Add('AND c.numero = ' + FormatFloat('0',txtDevNumero.Value));
                SQL.Add('AND c.estatus = ''A''');
                if(sGlobalDev <> 'S') then
                    SQL.Add('AND c.caja = ' + FormatFloat('0',txtCajaDev.Value));
                Open;
                if(not Eof) then begin
                    txtRfc.Text := Trim(FieldByName('rfc').AsString);
                    txtNombre.Text := Trim(FieldByName('nombre').AsString);
                    txtCalle.Text := Trim(FieldByName('calle').AsString);
                    txtColonia.Text := Trim(FieldByName('colonia').AsString);
                    txtLocalidad.Text := Trim(FieldByName('localidad').AsString);
                    txtEstado.Text := Trim(FieldByName('estado').AsString);
                    txtCp.Text := Trim(FieldByName('cp').AsString);
                    txtTelefono.Text := Trim(FieldByName('telefono').AsString);
                    txtCelular.Text := Trim(FieldByName('celular').AsString);
                    txtCorreo.Text := Trim(FieldByName('ecorreo').AsString);
                    txtCajaDev.Value := FieldByName('caja').AsInteger;
                    txtTotal.Value := FieldByName('total').AsFloat;
                    txtDevFecha.Text := FormatDateTime('dd/mm/yyyy',FieldByName('fecha').AsDateTime);
                end
                else begin
                    LimpiaDatos('Devoluciòn');
                end;
                Close;
            end;
        end;
end;
procedure TfrmNotaCredito.VerificaCompGlobal;
begin
    with dmDatos.qryConsulta do begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT devolucionglobal AS devglobal, notacredglobal AS notaglobal FROM config');
        Open;
        sGlobalDev := FieldByName('devglobal').AsString;
        sGlobalNotaCred := FieldByName('notaglobal').AsString;
        if(sGlobalDev = 'S') then begin
            txtCajaDev.Enabled := false;
            txtCajaDev.Visible := false;
            lblCajaDev.Visible := false;
        end
        else begin
            txtCajaDev.Enabled := true;
            txtCajaDev.Visible := true;
            lblCajaDev.Visible := true;
        end;
        Close;
    end;
end;
procedure TfrmNotaCredito.RecuperaCategs;
begin
    with dmDatos.qryConsulta do begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT nombre FROM categorias WHERE tipo = ''C'' ORDER BY nombre');
        Open;

        cmbCategorias.Items.Clear;
        while (not Eof) do begin
            cmbCategorias.Items.Add(Trim(FieldByName('nombre').AsString));
            Next;
        end;
        Close;
    end;
end;

procedure TfrmNotaCredito.ActivaControles;
begin
    if( (sModo = 'Insertar') or (sModo = 'Modificar') ) then begin
        tabBusqueda.TabVisible := false;
        Colores('Insertar');

        btnInsertar.Enabled := false;
        btnImprimir.Enabled := false;
        btnEliminar.Enabled := false;

        mnuInsertar.Enabled := false;
        mnuImprimir.Enabled := false;
        mnuEliminar.Enabled := false;

        btnGuardar.Enabled := true;
        btnCancelar.Enabled := true;
        mnuGuardar.Enabled := true;
        mnuCancelar.Enabled := true;

        mnuConsulta.Enabled := false;
        mnuBusqueda.Enabled := false;

        tabBusqueda.Enabled := false;

        txtRFC.ReadOnly := false;
        txtDevFecha.ReadOnly := true;
        txtNotaFecha.ReadOnly := true;
        txtNombre.ReadOnly := false;
        txtCalle.ReadOnly := false;
        txtColonia.ReadOnly := false;
        txtCP.ReadOnly := false;
        txtLocalidad.ReadOnly := false;
        txtEstado.ReadOnly := false;
        txtTelefono.ReadOnly := false;
        txtCelular.ReadOnly := false;
        txtCorreo.ReadOnly := false;

        txtDevNumero.ReadOnly := false;
        txtNotaNumero.ReadOnly := false;

        txtRFC.TabStop := true;
        txtNotaFecha.TabStop := false;
        txtDevFecha.TabStop := false;
        txtNombre.TabStop := true;
        txtCalle.TabStop := true;
        txtColonia.TabStop := true;
        txtCP.TabStop := true;
        txtLocalidad.TabStop := true;
        txtEstado.TabStop := true;
        txtTelefono.TabStop := true;
        txtCelular.TabStop := true;
        txtCorreo.TabStop := true;


        txtNotaNumero.TabStop := true;
        txtDevNumero.TabStop := true;


        cmbCategorias.Enabled := true;
    end;
    if(sModo = 'Consulta') then begin
        tabBusqueda.TabVisible := true;
        Colores('NoInsertar');
        btnInsertar.Enabled := true;
        mnuInsertar.Enabled := true;

        if(pnlEstatus.Caption = 'ACTIVA') then begin
            btnImprimir.Enabled := true;
            btnEliminar.Enabled := true;
            mnuImprimir.Enabled := true;
            mnuEliminar.Enabled := true;
        end
        else if(pnlEstatus.Caption = 'CANCELADA') then begin
            mnuEliminar.Enabled := false;
            btnEliminar.Enabled := false;
            mnuImprimir.Enabled := false;
            btnImprimir.Enabled := false;
        end
        else if(pnlEstatus.Caption = 'UTILIZADA') then begin
            mnuEliminar.Enabled := false;
            btnEliminar.Enabled := false;
            mnuImprimir.Enabled := true;
            btnImprimir.Enabled := true;
        end;

        btnGuardar.Enabled := false;
        btnCancelar.Enabled := false;
        mnuGuardar.Enabled := false;
        mnuCancelar.Enabled := false;

        mnuConsulta.Enabled := true;
        mnuBusqueda.Enabled := true;

        tabBusqueda.Enabled := true;

        txtRFC.ReadOnly := true;
        txtNotaFecha.ReadOnly := true;
        txtDevFecha.ReadOnly := true;
        txtNombre.ReadOnly := true;
        txtCalle.ReadOnly := true;
        txtColonia.ReadOnly := true;
        txtCP.ReadOnly := true;
        txtLocalidad.ReadOnly := true;
        txtEstado.ReadOnly := true;
        txtTelefono.ReadOnly := true;
        txtCelular.ReadOnly := true;
        txtCorreo.ReadOnly := true;


        txtNotaNumero.ReadOnly := true;
        txtDevNumero.ReadOnly := true;

        txtRFC.TabStop := false;
        txtNotaFecha.TabStop := false;
        txtDevFecha.TabStop := false;
        txtNombre.TabStop := false;
        txtCalle.TabStop := false;
        txtColonia.TabStop := false;
        txtCP.TabStop := false;
        txtLocalidad.TabStop := false;
        txtEstado.TabStop := false;
        txtTelefono.TabStop := false;
        txtCelular.TabStop := false;
        txtCorreo.TabStop := false;

        txtNotaNumero.TabStop := false;
        txtDevNumero.TabStop := false;

        cmbCategorias.Enabled := false;
    end;

end;
procedure TfrmNotaCredito.btnInsertarClick(Sender: TObject);
begin
    sModo := 'Insertar';
    pgeGeneral.ActivePage := tabDatos;
    ActivaControles;
    LimpiaDatos('Todo');
    txtLocalidad.Text := sLocalidad;
    txtEstado.Text := sEstado;
    if(cmbCategorias.ItemIndex = -1) then
        cmbCategorias.ItemIndex := 0;

    pnlEstatus.Caption := 'ACTIVA';
    pnlEstatus.Color := $00BFCAB7;
    
    txtNotaNumero.Value := RecuperaNumNota;
    txtNotaFecha.Text := FormatDateTime('dd/mm/yyyy',Date);
    txtNotaNumero.SetFocus;
end;

function TfrmNotaCredito.RecuperaNumNota:integer;
begin
    with dmDatos.qryModifica do begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT MAX(numero) AS numero FROM notascredito');
        if(sGlobalNotaCred = 'S') then
            SQL.Add('WHERE caja = ' + IntToStr(iCaja));
        Open;
        Result := FieldByName('numero').AsInteger + 1;
        Close;
    end;
end;

procedure TfrmNotaCredito.btnCancelarClick(Sender: TObject);
begin
    sModo := 'Consulta';
    LimpiaDatos('Todo');
    if(sTipo = 'Captura') then
        Close
    else begin
        ActivaControles;
        pgeGeneral.ActivePage := tabBusqueda;
    end;
end;

procedure TfrmNotaCredito.btnEliminarClick(Sender: TObject);
begin
    if (pgeGeneral.ActivePage = tabBusqueda) then
        RecuperaDatos;
    if( txtNotaNumero.Value > 0) then begin
        pgeGeneral.ActivePage := tabDatos;
        if(Application.MessageBox('Se cancelará la nota de crédito seleccionada','Eliminar',[smbOK]+[smbCancel],smsWarning) = smbOK) then begin
            with dmDatos.qryModifica do begin
                Close;
                SQL.Clear;
                SQL.Add('UPDATE notascredito SET estatus = ''C'' WHERE clave = ' + IntToStr(iClave));
                ExecSQL;
                Close;
            end;

//            LimpiaDatos('Todo');
            sModo := 'Consulta';
            ActivaControles;
            btnBuscarClick(Sender);
        end;
    end;
end;

procedure  TfrmNotaCredito.Colores(sTipo : String);
var
    iColor : Integer;
begin
    if(sTipo = 'Insertar') then
        iColor := clWindowText
    else
        iColor := clBlue;

    txtNotaNumero.Font.Color := iColor;
    txtDevNumero.Font.Color := iColor;
    txtNombre.Font.Color := iColor;
    txtRfc.Font.Color := iColor;
    txtCalle.Font.Color := iColor;
    txtColonia.Font.Color := iColor;
    txtCp.Font.Color := iColor;
    txtLocalidad.Font.Color := iColor;
    txtEstado.Font.Color := iColor;
    txtTelefono.Font.Color := iColor;
    txtCelular.Font.Color := iColor;
    txtCorreo.Font.Color := iColor;
end;


procedure TfrmNotaCredito.grdListadoEnter(Sender: TObject);
begin
    btnBuscar.Default := false;
    btnSeleccionar.Default := true;
end;

procedure TfrmNotaCredito.grdListadoExit(Sender: TObject);
begin
    btnBuscar.Default := true;
    btnSeleccionar.Default := false;
end;

procedure TfrmNotaCredito.txtNotaIniExit(Sender: TObject);
begin
    if(txtNotaFin.Value < txtNotaIni.Value) then
        txtNotaFin.Value := txtNotaIni.Value;
end;

procedure TfrmNotaCredito.txtRFCExit(Sender: TObject);
begin
     if(Length(Trim(txtRfc.Text)) > 0) then begin
        with dmDatos.qryModifica do begin
            Close;
            SQL.Clear;
            SQL.Add('SELECT * FROM clientes WHERE rfc STARTING ''' + txtRfc.Text + '''');
            Open;

            if(not Eof) then begin
                txtRfc.Text := Trim(FieldByName('Rfc').AsString);
                txtNombre.Text := Trim(FieldByName('Nombre').AsString);
                txtCalle.Text := Trim(FieldByName('Calle').AsString);
                txtColonia.Text := Trim(FieldByName('Colonia').AsString);
                txtLocalidad.Text := Trim(FieldByName('Localidad').AsString);
                txtEstado.Text := Trim(FieldByName('Estado').AsString);
                txtCp.Text := Trim(FieldByName('Cp').AsString);
                txtCelular.Text := Trim(FieldByName('Celular').AsString);
                txtCorreo.Text := Trim(FieldByName('ecorreo').AsString);
            end;
            Close;
        end;
    end;
end;

procedure TfrmNotaCredito.btnSeleccionarClick(Sender: TObject);
begin
    if (txtRegistros.Value > 0) then begin
        if(sTipo = 'Captura') then begin
            sModo := 'Consulta';
            RecuperaDatos;
            ActivaBuscar;
            ActivaControles;
        end
        else begin
            sNota := dmDatos.cdsCliente.FieldByname('numero').AsString;
            sCaja := dmDatos.cdsCliente.FieldByname('caja').AsString;
            bSeleccion := true;
            Close;
        end;
    end;
end;

procedure TfrmNotaCredito.RecuperaDatos;
var
    sCateg : String;
begin
    with dmDatos.qryConsulta do begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT n.clave, n.numero AS notacredito, n.fecha AS fechanota, n.estatus AS estatusnota,');
        SQL.Add('n.importe, o.numero AS devolucion, o.caja, o.fecha AS fechadev, c.nombre, c.rfc,');
        SQL.Add('c.calle, c.colonia, c.localidad, c.estado, c.cp, c.categoria,');
        SQL.Add('c.ecorreo, c.telefono, c.celular FROM notascredito n');
        SQL.Add('LEFT JOIN comprobantes o ON n.comprobante = o.clave LEFT JOIN clientes c');
        SQL.Add('ON n.cliente = c.clave WHERE o.tipo = ''D'' AND o.estatus = ''A''');
        SQL.Add('AND n.clave = ' + dmDatos.cdsCliente.FieldByName('clave').AsString);
        Open;

        if(not Eof) then begin
            pgeGeneral.ActivePage := tabDatos;
            iClave := FieldByname('clave').AsInteger;
            txtNotaNumero.Value := FieldByname('notacredito').AsInteger;
            txtNotaFecha.Text := FormatDateTime('dd/mm/yyyy',FieldByname('fechanota').AsDateTime);
            txtDevNumero.Value := FieldByname('devolucion').AsInteger;
            txtCajaDev.Value := FieldByname('caja').AsInteger;
            txtTotal.Value := FieldByname('importe').AsFloat;
            txtDevFecha.Text := FormatDateTime('dd/mm/yyyy',FieldByname('fechadev').AsDateTime);
            txtNombre.Text := Trim(FieldByname('Nombre').AsString);
            txtRfc.Text := Trim(FieldByname('RFC').AsString);
            txtCalle.Text := Trim(FieldByname('CALLE').AsString);
            txtColonia.Text := Trim(FieldByname('COLONIA').AsString);
            txtLocalidad.Text := Trim(FieldByname('LOCALIDAD').AsString);
            txtEstado.Text := FieldByname('ESTADO').AsString;
            txtCp.text := Trim(FieldByname('CP').AsString);
            txtCorreo.Text := Trim(FieldByname('Ecorreo').AsString);
            txtCelular.Text := Trim(FieldByname('celular').AsString);
            txtTelefono.Text:= Trim(FieldByname('TELEFONO').AsString);

            if(FieldByname('estatusnota').AsString = 'A') then begin
                pnlEstatus.Color := $00BFCAB7;
                pnlEstatus.Caption := 'ACTIVA';
            end
            else if(FieldByname('estatusnota').AsString = 'C') then begin
                pnlEstatus.Color := $0099A7F7;
                pnlEstatus.Caption := 'CANCELADA';
            end
            else begin
                pnlEstatus.Color := $00DCBFA5;
                pnlEstatus.Caption := 'UTILIZADA';
            end;


            sCateg := BuscaCateg(FieldByName('categoria').AsString);
            cmbCategorias.ItemIndex := cmbCategorias.Items.IndexOf(sCateg);
        end;
        Close;
    end;
end;

procedure TfrmNotaCredito.ActivaBuscar;
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

function TfrmNotaCredito.BuscaCateg(sCateg:String):String;
begin
    if(Length(sCateg) > 0) then
        with dmDatos.qryModifica do begin
            Close;
            SQL.Clear;
            SQL.Add('SELECT nombre FROM categorias WHERE clave = ' + sCateg);
            Open;
            sCateg := Trim(FieldByName('nombre').AsString);
            Close;
        end;
    Result := sCateg;
end;

procedure TfrmNotaCredito.btnGuardarClick(Sender: TObject);
begin
    if(VerificaDatos) then begin
        GuardaDatos;
        sModo := 'Consulta';
        ActivaControles;
        btnBuscarClick(Sender);
        btnInsertar.SetFocus;
        btnImprimirClick(Sender);
    end;
end;

procedure TfrmNotaCredito.GuardaDatos;
var
    sFecha, sCliente, sDevolucion : String;
begin
    sFecha := FormatDateTime('mm/dd/yyyy',Date);
    with dmDatos.qryModifica do begin
        Close; // Busca por RFC en la tabla de clientes
        if(Length(Trim(txtRfc.Text)) > 0) then begin
            SQL.Clear;
            SQL.Add('SELECT clave FROM clientes WHERE rfc = ''' + txtRfc.Text + '''');
            Open;
        end;
        if(Eof) or (Length(txtRfc.Text) = 0) then begin
            Close; // Si no lo encuentra por rfc lo busca por nombre
            SQL.Clear;
            SQL.Add('SELECT clave FROM clientes WHERE nombre = ''' + txtNombre.Text + '''');
            Open;
        end;
        if(Eof) and (Length(txtNombre.Text) > 0) then begin
            // Si no lo encuentra por rfc ni por nombre, lo inserta
            Close;
            SQL.Clear;
            SQL.Add('INSERT INTO clientes (rfc, nombre, calle, colonia, localidad,');
            SQL.Add('estado, cp, telefono, celular, ecorreo, fechacap, fechaumov, precio, acumulado) VALUES(');
            SQL.Add('''' + txtRfc.Text + ''',''' + txtNombre.Text + ''',');
            SQL.Add('''' + txtCalle.Text + ''',''' + txtColonia.Text + ''',');
            SQL.Add('''' + txtLocalidad.Text + ''',''' + txtEstado.Text + ''',');
            SQL.Add('''' + txtCp.Text + ''',''' + txtTelefono.Text + ''',');
            SQL.Add('''' + txtCelular.Text + ''',''' + txtCorreo.Text + ''',');
            SQL.Add('''' + sFecha + ''',''' + sFecha + ''',1,0)');
            ExecSQL;

            Close; // Busca la clave asignada por el disparador
            SQL.Clear;
            SQL.Add('SELECT clave FROM clientes WHERE nombre = ''' + txtNombre.Text + '''');
            Open;
            sCliente := FieldByName('clave').AsString;
        end
        else begin
            if(Length(txtNombre.Text) > 0) then begin
                // Si se encuentra al cliente, recupera la clave y modifica sus datos
                sCliente := FieldByName('clave').AsString;
                Close;
                SQL.Clear;
                SQL.Add('UPDATE clientes SET ');
                SQL.Add('rfc = ''' + txtRfc.Text + ''',');
                SQL.Add('nombre = ''' + txtNombre.Text + ''',');
                SQL.Add('calle = ''' + txtCalle.Text + ''',');
                SQL.Add('colonia = ''' + txtColonia.Text + ''',');
                SQL.Add('localidad = ''' + txtLocalidad.Text + ''',');
                SQL.Add('estado = ''' + txtEstado.Text + ''',');
                SQL.Add('cp = ''' + txtCp.Text + ''',');
                SQL.Add('telefono = ''' + txtTelefono.Text + ''',');
                SQL.Add('celular = ''' + txtCelular.Text + ''',');
                SQL.Add('ecorreo = ''' + txtCorreo.Text + ''',');
                SQL.Add('fechaumov = ''' + sFecha + '''');
                SQL.Add('WHERE clave = ' + sCliente);
                ExecSQL;
            end
            else
                sCliente := 'null';
        end;

        Close;
        SQL.Clear;
        SQL.Add('SELECT clave FROM comprobantes');
        SQL.Add('WHERE tipo = ''D'' AND estatus = ''A'' AND numero = ' + FormatFloat('0',txtDevNumero.Value));
        if(sGlobalDev <> 'S') then
            SQL.Add('AND caja = ' + FormatFloat('0',txtCajaDev.Value));
        Open;
        sDevolucion := FieldByName('clave').AsString;;

        Close;
        SQL.Clear;
        SQL.Add('INSERT INTO notascredito (numero, fecha, comprobante, cliente, importe, estatus, caja) VALUES(');
        SQL.Add(FloatToStr(txtNotaNumero.Value) + ',''' + FormatDateTime('mm/dd/yyyy',Date) + ''',');
        SQL.Add(sDevolucion + ',' + sCliente + ',' + FloatToStr(txtTotal.Value) + ',');
        SQL.Add('''A'',' + FloatToStr(txtCajaDev.Value) + ')');
        ExecSQL;
        Close;
    end;
end;

function TfrmNotaCredito.VerificaDatos: boolean;
begin
    Result := true;
    if(txtNotaNumero.Value = 0) then begin
        Application.MessageBox('Introduce el número de la nota de crédito','Error',[smbOK],smsCritical);
        txtNotaNumero.SetFocus;
        Result := False;
    end
    else if(not VerificaNumNota) then begin
        Application.MessageBox('El número de la nota de crédito ya existe','Error',[smbOK],smsCritical);
        txtNotaNumero.SetFocus;
        Result := False;
    end
    else if(txtDevNumero.Value = 0) then begin
        Application.MessageBox('Introduce el número de devolución que generará la nota de crédito ','Error',[smbOK],smsCritical);
        txtDevNumero.SetFocus;
        Result := False;
    end
    else if(not VerificaDev) then begin
        Application.MessageBox('Ya se generó una nota de crédito para la devolución especificada','Error',[smbOK],smsCritical);
        txtDevNumero.SetFocus;
        Result := False;
    end
    else if(txtCajaDev.Value = 0) and (txtCajaDev.Visible) then begin
        Application.MessageBox('Introduce el número de caja donde se generó la devoluciòn','Error',[smbOK],smsCritical);
        txtCajaDev.SetFocus;
        Result := False;
    end
    else if(txtTotal.Value <= 0) then begin
        Application.MessageBox('Introduce una devolución válida','Error',[smbOK],smsCritical);
        txtDevNumero.SetFocus;
        Result := False;
    end
    else if(Length(Trim(txtNombre.Text)) = 0) then begin
        Application.MessageBox('Introduce el nombre del cliente','Error',[smbOK],smsCritical);
        txtNombre.SetFocus;
        Result := False;
    end
end;

function TfrmNotaCredito.VerificaNumNota: boolean;
begin
    Result := true;
    with dmDatos.qryModifica do begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT numero FROM notascredito WHERE estatus = ''A'' AND numero = ' + FloatToStr(txtNotaNumero.Value));
        Open;

        if(not Eof) then
            Result := false;
        Close;
    end;
end;

function TfrmNotaCredito.VerificaDev: boolean;
begin
    Result := true;
    with dmDatos.qryModifica do begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT c.clave FROM comprobantes c JOIN notascredito n ON c.clave = n.comprobante');
        SQL.Add('WHERE c.numero = ' + FormatFloat('0',txtDevNumero.Value));
        if(sGlobalDev <> 'S') then
            SQL.Add('AND c.caja = ' + FormatFloat('0',txtCajaDev.Value));
        SQL.Add('AND n.estatus IN (''A'',''U'') AND c.estatus = ''A''');
        Open;

        if(not Eof) then
            Result := false;
        Close;
    end;
end;

procedure TfrmNotaCredito.mnuAvanzaClick(Sender: TObject);
begin
    with dmDatos.cdsCliente do begin
        if(Active) then begin
            Next;
            if(pgeGeneral.ActivePage <> tabBusqueda) then begin
                RecuperaDatos;
                ActivaControles;
            end;
        end;
    end;
end;

procedure TfrmNotaCredito.mnuRetrocedeClick(Sender: TObject);
begin
    with dmDatos.cdsCliente do begin
        if(Active) then begin
            Prior;
            if(pgeGeneral.ActivePage <> tabBusqueda) then begin
                RecuperaDatos;
                ActivaControles;
            end;
        end;
    end;
end;

procedure TfrmNotaCredito.btnImprimirClick(Sender: TObject);
var
    iniArchivo : TIniFile;
    sArchivo, sValor, sNumero,sCaja :String;
    bImprimir :boolean;
    rTotal : real;
begin
    btnImprimir.SetFocus;
    bImprimir := true;
        sNumero:=FloatToStr(txtDevNumero.Value);
        sCaja:= FloatToStr(txtCajaDev.Value);
        rTotal:= txtTotal.Value;

        iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) +'config.ini');
        sArchivo := iniArchivo.ReadString('Reportes', 'NotaCredito', '');

        if (Length(sArchivo) > 0) and (FileExists(sArchivo)) then begin
            rptComprobante.FileName := sArchivo;
            //Recupera el número de copias de la nota
            sValor := iniArchivo.ReadString('Reportes', 'CopiasNota', '');
            if (Length(sValor) > 0) then
               rptComprobante.Report.Copies := StrToInt(sValor)
            else
               rptComprobante.Report.Copies := 1;
            rptComprobante.Title := 'Nota de crédito ' + sNumero ;
        end
        else begin
            Application.MessageBox('El archivo de la nota de crédito especificado no existe','Error',[smbOK],smsCritical);
            bImprimir := false;
        end;

        if(bImprimir) then begin
            rptComprobante.Report.DatabaseInfo.Items[0].SQLConnection := dmDatos.sqlBase.DataSets[0].SQLConnection;
            rptComprobante.Report.Params.ParamByName('Numero').Value:= sNumero;
            rptComprobante.Report.Params.ParamByName('Caja').Value:= sCaja;
            rptComprobante.Report.Params.ParamByName('numerotexto').Value:= UpperCase(ConvNumero(rTotal,true));
            rptComprobante.Execute;
        end;
        iniArchivo.Free;
end;

function TfrmNotaCredito.ConvNumero(rNumero:Real; bPesos :boolean):String;
var
    iNumero, iDecimales, iMillon, iMil, iCentena, iDecena, iUnidad: LongInt;
    sRegreso : String;
    rTemp : real;
begin

    InicializaNumeros;
    sRegreso := '';
    iNumero := Trunc(rNumero);
    rTemp := StrToFloat(FormatFloat('0.00',Frac(rNumero)));
    rTemp := rTemp * 100;
    iDecimales := Trunc(rTemp);

    iMillon := iNumero div 1000000;
    iNumero := iNumero - iMillon * 1000000;
    iMil := iNumero div 1000;
    iNumero := iNumero - iMil * 1000;
    iCentena := iNumero div 100;
    iNumero := iNumero - iCentena * 100;
    iDecena := iNumero div 10;
    iNumero := iNumero - iDecena * 10;
    iUnidad := iNumero;

    if(iMillon > 0) then
        if(iMillon > 1) then
            sRegreso := ConvNumero(iMillon,false) + ' millones'
        else
            sRegreso := 'un millon';
    if(iMil > 0) then
        sRegreso := sRegreso + ' ' + ConvNumero(iMil,false) + ' mil';
    if(iCentena > 0) then
        if(iCentena = 1) and (iDecena = 0) and (iUnidad = 0) then
            sRegreso := sRegreso + ' cien'
        else
            sRegreso := sRegreso + ' ' + sCentenas[iCentena];
    if(iDecena > 0) then
        if(iDecena < 3) then
            sRegreso := sRegreso + ' ' + sUnidades[iDecena*10+iUnidad]
        else
            sRegreso := sRegreso + ' ' + sDecenas[iDecena-2];
    if(iUnidad > 0) and ((iDecena = 0) or (iDecena > 2)) then begin
        if(iDecena > 0) then
            sRegreso := sRegreso + ' y';
        sRegreso := sRegreso + ' ' + sUnidades[iUnidad];
    end;
    if(Copy(sRegreso,1,1) = ' ') then
        sRegreso := Copy(sRegreso,2,Length(sRegreso)-1);
     if(bPesos) then
        sRegreso := sRegreso + ' pesos ' + FormatFloat('00',iDecimales) + '/100 m.n.';
    Result := sRegreso;
end;

procedure TfrmNotaCredito.InicializaNumeros;
begin
    sUnidades[1] := 'un';
    sUnidades[2] := 'dos';
    sUnidades[3] := 'tres';
    sUnidades[4] := 'cuatro';
    sUnidades[5] := 'cinco';
    sUnidades[6] := 'seis';
    sUnidades[7] := 'siete';
    sUnidades[8] := 'ocho';
    sUnidades[9] := 'nueve';
    sUnidades[10] := 'diez';
    sUnidades[11] := 'once';
    sUnidades[12] := 'doce';
    sUnidades[13] := 'trece';
    sUnidades[14] := 'catorce';
    sUnidades[15] := 'quince';
    sUnidades[16] := 'diez y seis';
    sUnidades[17] := 'diez y siete';
    sUnidades[18] := 'diez y ocho';
    sUnidades[19] := 'diez y nueve';
    sUnidades[20] := 'veinte';
    sUnidades[21] := 'veintiun';
    sUnidades[22] := 'veintidos';
    sUnidades[23] := 'veintitres';
    sUnidades[24] := 'veinticuatro';
    sUnidades[25] := 'veinticinco';
    sUnidades[26] := 'veintiseis';
    sUnidades[27] := 'veintisiete';
    sUnidades[28] := 'veintiocho';
    sUnidades[29] := 'veintinueve';

    sDecenas[1] := 'treinta';
    sDecenas[2] := 'cuarenta';
    sDecenas[3] := 'cincuenta';
    sDecenas[4] := 'sesenta';
    sDecenas[5] := 'setenta';
    sDecenas[6] := 'ochenta';
    sDecenas[7] := 'noventa';

    sCentenas[1] := 'ciento';
    sCentenas[2] := 'doscientos';
    sCentenas[3] := 'trescientos';
    sCentenas[4] := 'cuatrocientos';
    sCentenas[5] := 'quinientos';
    sCentenas[6] := 'seiscientos';
    sCentenas[7] := 'setecientos';
    sCentenas[8] := 'ochocientos';
    sCentenas[9] := 'novecientos';
end;


procedure TfrmNotaCredito.chkEstatusClick(Sender: TObject);
begin
    if(chkEstatus.Checked) then begin
        cmbEstatusBusq.Visible := true;
        cmbEstatusBusq.SetFocus;
    end
    else
        cmbEstatusBusq.Visible := false;
end;

procedure TfrmNotaCredito.mnuSalirClick(Sender: TObject);
begin
    Close;
end;

procedure TfrmNotaCredito.mnuNotaCredClick(Sender: TObject);
begin
    pgeGeneral.ActivePage := tabDatos;
end;

procedure TfrmNotaCredito.mnuBusquedaClick(Sender: TObject);
begin
    pgeGeneral.ActivePage := tabBusqueda;
end;

end.
