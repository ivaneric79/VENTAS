// --------------------------------------------------------------------------
// Archivo del Proyecto Ventas   
// Página del proyecto: http://sourceforge.net/projects/ventas
// --------------------------------------------------------------------------
// Este archivo puede ser distribuido y/o modificado bajo lo terminos de la
// Licencia Pública General versión 2 como es publicada por la Free Software
// Fundation, Inc.
// --------------------------------------------------------------------------

unit Vendedores;

interface

uses
  SysUtils, Types, Classes, QGraphics, QControls, QForms, QDialogs,
  QStdCtrls, QMenus, QTypes, QComCtrls, QcurrEdit, QButtons, QGrids,
  QDBGrids, QExtCtrls, Inifiles, StrUtils;

type
  TfrmVendedores = class(TForm)
    pgeGeneral: TPageControl;
    tabDatos: TTabSheet;
    grpVendedor: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label9: TLabel;
    txtClave: TEdit;
    txtNombre: TEdit;
    txtRFC: TEdit;
    txtFechaCap: TEdit;
    MainMenu1: TMainMenu;
    Archivo1: TMenuItem;
    mnuInsertar: TMenuItem;
    mnuEliminar: TMenuItem;
    mnuModificar: TMenuItem;
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
    mnuVendedor: TMenuItem;
    mnuBusqueda: TMenuItem;
    pgeDatos: TPageControl;
    tabDomicilio: TTabSheet;
    grpDomicilio: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label12: TLabel;
    txtCalle: TEdit;
    txtColonia: TEdit;
    txtLocalidad: TEdit;
    txtEstado: TEdit;
    txtCP: TEdit;
    tabContacto: TTabSheet;
    grpContacto: TGroupBox;
    Label11: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    txtCorreo: TEdit;
    txtTelefono: TEdit;
    txtFax: TEdit;
    tabMovimientos: TTabSheet;
    grpCompra: TGroupBox;
    Label3: TLabel;
    txtFechaVenta: TEdit;
    Label10: TLabel;
    txtDoctoVenta: TEdit;
    Label16: TLabel;
    txtImporteVenta: TcurrEdit;
    btnInsertar: TBitBtn;
    btnEliminar: TBitBtn;
    btnModificar: TBitBtn;
    btnGuardar: TBitBtn;
    btnCancelar: TBitBtn;
    tabBusqueda: TTabSheet;
    grdListado: TDBGrid;
    rdgBuscar: TRadioGroup;
    rdgOrden: TRadioGroup;
    btnBuscar: TBitBtn;
    btnSeleccionar: TBitBtn;
    btnLimpiar: TBitBtn;
    Label17: TLabel;
    txtRegistros: TcurrEdit;
    pnlClave: TPanel;
    Label18: TLabel;
    txtClaveBusq: TEdit;
    pnlRfc: TPanel;
    Label19: TLabel;
    txtRfcBusq: TEdit;
    pnlNombre: TPanel;
    Label20: TLabel;
    txtNombreBusq: TEdit;
    N5: TMenuItem;
    Domicilio1: TMenuItem;
    Contacto1: TMenuItem;
    Movimientos1: TMenuItem;
    Label21: TLabel;
    cmbCategorias: TComboBox;
    procedure btnInsertarClick(Sender: TObject);
    procedure btnEliminarClick(Sender: TObject);
    procedure btnBuscarClick(Sender: TObject);
    procedure btnModificarClick(Sender: TObject);
    procedure btnGuardarClick(Sender: TObject);
    function VerificaClave:boolean;
    function VerificaNombre:boolean;
    procedure btnCancelarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure rdgBuscarClick(Sender: TObject);
    procedure btnSeleccionarClick(Sender: TObject);
    procedure btnLimpiarClick(Sender: TObject);
    procedure mnuVendedorClick(Sender: TObject);
    procedure mnuBusquedaClick(Sender: TObject);
    procedure Domicilio1Click(Sender: TObject);
    procedure Contacto1Click(Sender: TObject);
    procedure Movimientos1Click(Sender: TObject);
    procedure Salir1Click(Sender: TObject);
    procedure mnuAvanzaClick(Sender: TObject);
    procedure mnuRetrocedeClick(Sender: TObject);
    procedure RecuperaCategs;
    procedure Salta(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure grdListadoExit(Sender: TObject);
    procedure grdListadoEnter(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    iClave : integer;
    sModo, sLocalidad, sEstado : String;

    procedure ActivaControles;
    procedure LimpiaDatos;
    function NuevaClave:Integer;
    procedure Colores(sTipo : String);
    function VerificaDatos:boolean;
    procedure GuardaDatos;
    procedure RecuperaConfig;
    procedure ActivaBuscar;
    procedure RecuperaDatos;
    function ClaveCateg(sCateg:String):Integer;
    function BuscaCateg(sCateg:String):String;
    procedure VerificaCategs;
    procedure CargaMovimientos;
    procedure ConvierteComillas(Sender : TWidgetControl);
  public
    { Public declarations }
  end;

var
  frmVendedores: TfrmVendedores;

implementation

uses dm;

{$R *.xfm}

procedure TfrmVendedores.btnInsertarClick(Sender: TObject);
begin
    sModo := 'Insertar';
    pgeGeneral.ActivePage := tabDatos;
    ActivaControles;
    LimpiaDatos;
    txtClave.SetFocus;
    txtFechaCap.Text := FormatDateTime('dd/mm/yyyy',Date);
    txtLocalidad.Text := sLocalidad;
    txtEstado.Text := sEstado;
    iClave := NuevaClave;
    pgeGeneral.ActivePageIndex := 0;
    txtClave.Text := IntToStr(iClave);
    if(cmbCategorias.ItemIndex = -1) then
        cmbCategorias.ItemIndex := 0;
end;

procedure TfrmVendedores.ActivaControles;
begin
    if( (sModo = 'Insertar') or (sModo = 'Modificar') ) then begin
        tabBusqueda.TabVisible := false;
        Colores('Insertar');
        btnInsertar.Enabled := false;
        btnModificar.Enabled := false;
        btnEliminar.Enabled := false;
        mnuInsertar.Enabled := false;
        mnuModificar.Enabled := false;
        mnuEliminar.Enabled := false;


        btnGuardar.Enabled := true;
        btnCancelar.Enabled := true;
        mnuGuardar.Enabled := true;
        mnuCancelar.Enabled := true;

        mnuConsulta.Enabled := false;
        mnuBusqueda.Enabled := false;

        tabBusqueda.Enabled := false;

        txtClave.ReadOnly := false;
        txtClave.TabStop := true;
        txtNombre.ReadOnly := false;
        txtNombre.TabStop := true;
        txtRfc.ReadOnly := false;
        txtRfc.TabStop := true;
        txtCalle.ReadOnly := false;
        txtCalle.TabStop := true;
        txtColonia.ReadOnly := false;
        txtColonia.TabStop := true;
        txtCp.ReadOnly := false;
        txtCp.TabStop := true;
        txtLocalidad.ReadOnly := false;
        txtLocalidad.TabStop := true;
        txtEstado.ReadOnly := false;
        txtEstado.TabStop := true;
        txtTelefono.ReadOnly := false;
        txtTelefono.TabStop := true;
        txtFax.ReadOnly := false;
        txtFax.TabStop := true;
        txtCorreo.ReadOnly := false;
        txtCorreo.TabStop := true;
        cmbCategorias.Enabled := true;
    end;
    if(sModo = 'Consulta') then begin
        tabBusqueda.TabVisible := true;
        Colores('NoInsertar');
        btnInsertar.Enabled := true;
        mnuInsertar.Enabled := true;

        btnModificar.Enabled := true;
        btnEliminar.Enabled := true;
        mnuModificar.Enabled := true;
        mnuEliminar.Enabled := true;
        
        btnGuardar.Enabled := false;
        btnCancelar.Enabled := false;
        mnuGuardar.Enabled := false;
        mnuCancelar.Enabled := false;

        mnuConsulta.Enabled := true;
        mnuFichas.Enabled := true;

        tabBusqueda.Enabled := true;

        txtClave.ReadOnly := true;
        txtClave.TabStop := false;
        txtNombre.ReadOnly := true;
        txtNombre.TabStop := false;
        txtRfc.ReadOnly := true;
        txtRfc.TabStop := false;
        txtCalle.ReadOnly := true;
        txtCalle.TabStop := false;
        txtColonia.ReadOnly := true;
        txtColonia.TabStop := false;
        txtCp.ReadOnly := true;
        txtCp.TabStop := false;
        txtLocalidad.ReadOnly := true;
        txtLocalidad.TabStop := false;
        txtEstado.ReadOnly := true;
        txtEstado.TabStop := false;
        txtTelefono.ReadOnly := true;
        txtTelefono.TabStop := false;
        txtFax.ReadOnly := true;
        txtFax.TabStop := false;
        txtCorreo.ReadOnly := true;
        txtCorreo.TabStop := false;
        cmbCategorias.Enabled := false;
    end;

end;

procedure TfrmVendedores.LimpiaDatos;
begin
    txtClave.Clear;
    txtRfc.Clear;
    txtNombre.Clear;
    txtFechaCap.Clear;
    txtCalle.Clear;
    txtColonia.Clear;
    txtCp.Clear;
    txtLocalidad.Clear;
    txtEstado.Clear;
    txtTelefono.Clear;
    txtFax.Clear;
    txtCorreo.Clear;
    txtFechaVenta.Clear;
    txtDoctoVenta.Clear;
    txtImporteVenta.Value := 0;
end;

function TfrmVendedores.NuevaClave:Integer;
begin
    with dmDatos.qryModifica do begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT MAX(clave) AS clave FROM vendedores');
        Open;

        Result := FieldByName('clave').AsInteger + 1;
        Close;
    end;
end;

procedure TfrmVendedores.Colores(sTipo : String);
begin
    if(sTipo = 'Insertar') then begin
        txtClave.Font.Color := clWindowText;
        txtNombre.Font.Color := clWindowText;
        txtRfc.Font.Color := clWindowText;
        txtCalle.Font.Color := clWindowText;
        txtColonia.Font.Color := clWindowText;
        txtCp.Font.Color := clWindowText;
        txtLocalidad.Font.Color := clWindowText;
        txtEstado.Font.Color := clWindowText;
        txtTelefono.Font.Color := clWindowText;
        txtFax.Font.Color := clWindowText;
        txtCorreo.Font.Color := clWindowText;
    end
    else begin
        txtClave.Font.Color := clBlue;
        txtNombre.Font.Color := clBlue;
        txtRfc.Font.Color := clBlue;
        txtCalle.Font.Color := clBlue;
        txtColonia.Font.Color := clBlue;
        txtCp.Font.Color := clBlue;
        txtLocalidad.Font.Color := clBlue;
        txtEstado.Font.Color := clBlue;
        txtTelefono.Font.Color := clBlue;
        txtFax.Font.Color := clBlue;
        txtCorreo.Font.Color := clBlue;
    end;
end;

procedure TfrmVendedores.btnEliminarClick(Sender: TObject);
begin
    if (pgeGeneral.ActivePage = tabBusqueda) then
        RecuperaDatos;
    if(Length(Trim(txtClave.Text)) > 0) then begin
        pgeGeneral.ActivePage := tabDatos;
        if(Application.MessageBox('Se eliminará el vendedor seleccionado','Eliminar',[smbOK]+[smbCancel],smsWarning) = smbOK) then begin
            with dmDatos.qryModifica do begin
                Close;
                SQL.Clear;
                SQL.Add('DELETE FROM vendedores WHERE clave = ' + IntToStr(iClave));
                ExecSQL;
                Close;
            end;

            LimpiaDatos;
            sModo := 'Consulta';
            ActivaControles;
            btnBuscarClick(Sender);
        end;
    end;
end;

procedure TfrmVendedores.btnBuscarClick(Sender: TObject);
var
    sBM : String;
begin
    with dmDatos.qryListados do begin
        sBM := dmDatos.cdsCliente.Bookmark;

        dmDatos.cdsCliente.Active := false;

        Close;
        SQL.Clear;
        SQL.Add('SELECT clave, nombre, rfc, calle, colonia, cp, ');
        SQL.Add('localidad, estado, telefono, fax, ecorreo,');
        SQL.Add('fecha_cap, categoria FROM vendedores WHERE 1=1');

        case rdgBuscar.ItemIndex of
            0: if(Length(txtClaveBusq.Text) > 0) then
                SQL.Add('AND clave = ''' + txtClaveBusq.Text + '''');
            1: SQL.Add('AND nombre LIKE ''%' + txtNombreBusq.Text + '%''');
            2: SQL.Add('AND rfc STARTING ''' + txtRfcBusq.Text + '''');
        end;

        case rdgOrden.ItemIndex of
            0:  SQL.Add('ORDER BY clave');
            1:  SQL.Add('ORDER BY nombre');
            2:  SQL.Add('ORDER BY rfc');
        end;
        Open;
        dmDatos.cdsCliente.Active := true;
        dmDatos.cdsCliente.FieldByName('calle').Visible := False;
        dmDatos.cdsCliente.FieldByName('colonia').Visible := False;
        dmDatos.cdsCliente.FieldByName('cp').Visible := False;
        dmDatos.cdsCliente.FieldByName('localidad').Visible := False;
        dmDatos.cdsCliente.FieldByName('estado').Visible := False;
        dmDatos.cdsCliente.FieldByName('fax').Visible := False;
        dmDatos.cdsCliente.FieldByName('fecha_cap').Visible := False;
        dmDatos.cdsCliente.FieldByName('categoria').Visible := False;
        dmDatos.cdsCliente.FieldByName('clave').DisplayLabel := 'Clave';
        dmDatos.cdsCliente.FieldByName('clave').DisplayWidth := 5;
        dmDatos.cdsCliente.FieldByName('nombre').DisplayLabel := 'Nombre';
        dmDatos.cdsCliente.FieldByName('nombre').DisplayWidth := 30;
        dmDatos.cdsCliente.FieldByName('rfc').DisplayLabel := 'RFC';
        dmDatos.cdsCliente.FieldByName('telefono').DisplayLabel := 'Teléfono';
        dmDatos.cdsCliente.FieldByName('ecorreo').DisplayLabel := 'Correo';

        if(pgeGeneral.ActivePage = tabBusqueda) then
            grdListado.SetFocus;

        txtRegistros.Value := dmDatos.cdsCliente.RecordCount;
        try
            dmDatos.cdsCliente.Bookmark := sBM;
        except
            txtRegistros.Value := txtRegistros.Value;
        end;
    end;
end;

procedure TfrmVendedores.btnModificarClick(Sender: TObject);
begin
    if (pgeGeneral.ActivePage = tabBusqueda) then
        RecuperaDatos;
    if(Length(Trim(txtCLave.Text)) > 0) then begin
        pgeGeneral.ActivePage := tabDatos;
        sModo := 'Modificar';
        if (pgeGeneral.ActivePage = tabBusqueda) then
            RecuperaDatos;
        ActivaControles;
        txtClave.SetFocus;
    end;
end;

procedure TfrmVendedores.btnGuardarClick(Sender: TObject);
begin
    if(VerificaDatos) then begin
        GuardaDatos;
        sModo := 'Consulta';
        ActivaControles;
        btnBuscarClick(Sender);
        btnInsertar.SetFocus;
    end;
end;

procedure TfrmVendedores.ConvierteComillas(Sender : TWidgetControl);
var
    i : integer;
    sTexto : String;
begin
    for i := 0 to Sender.ControlCount - 1 do begin
        if(Sender.Controls[i] is TEdit) then begin
            sTexto := (Sender.Controls[i] as TEdit).Text;
            sTexto := AnsiReplaceStr(sTexto,'''', '`');
            sTexto := AnsiReplaceStr(sTexto,'"', '`');
            (Sender.Controls[i] as TEdit).Text := sTexto;
        end;
    end;
end;

function TfrmVendedores.VerificaDatos:boolean;
var
    bVerifica : Boolean;
begin
    bVerifica := True;
    ConvierteComillas(grpVendedor);
    ConvierteComillas(grpDomicilio);
    ConvierteComillas(grpContacto);
    if(Length(txtClave.Text) = 0) then begin
        txtClave.SetFocus;
        Application.MessageBox('Introduce la clave del proveedor','Error',[smbOK],smsCritical);
        bVerifica := False;
    end
    else if(Length(txtNombre.Text) = 0) then begin
        txtNombre.SetFocus;
        Application.MessageBox('Introduce el nombre del proveedor','Error',[smbOK],smsCritical);
        bVerifica := False;
    end
    else if(not VerificaClave) then
        bVerifica := false
    else if(not VerificaNombre) then
        bVerifica := false;
    Result := bVerifica;
end;

function TfrmVendedores.VerificaClave:boolean;
var
    bVerifica : Boolean;
begin
    bVerifica := true;
    with dmDatos.qryConsulta do begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT clave FROM vendedores WHERE clave = ' + txtClave.Text);
        Open;

        if(not Eof) and ((sModo = 'Insertar') or
            ((FieldByName('clave').AsInteger <> iClave) and
            (sModo = 'Modificar'))) then begin
            bVerifica := false;
            Application.MessageBox('La clave ya existe','Error',[smbOK],smsCritical);
            txtClave.SetFocus;
        end;
        Close;
    end;
    Result := bVerifica;
end;

function TfrmVendedores.VerificaNombre:boolean;
var
    bVerifica : Boolean;
begin
    bVerifica := true;

    with dmDatos.qryConsulta do begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT clave FROM vendedores WHERE nombre = ''' + txtNombre.Text + '''');
        Open;

        if(not Eof) and ((sModo = 'Insertar') or
            ((FieldByName('clave').AsInteger <> iClave) and
            (sModo = 'Modificar'))) then begin
            bVerifica := false;
            Application.MessageBox('El nombre del vendedor ya existe','Error',[smbOK],smsCritical);
            txtNombre.SetFocus;
        end;
        Close;
    end;
    Result := bVerifica;
end;

procedure TfrmVendedores.GuardaDatos;
var
    sFecha, sCateg : String;
begin
    with dmDatos.qryModifica do begin

        if(cmbCategorias.ItemIndex <> -1) then
            sCateg := IntToStr(ClaveCateg(cmbCategorias.Items.Strings[cmbCategorias.ItemIndex]))
        else
            sCateg := 'null';

        Close;
        SQL.Clear;
        sFecha := FormatDateTime('mm/dd/yyyy hh:nn:ss',Now);
        if(sModo = 'Insertar') then begin
            SQL.Add('INSERT INTO vendedores (clave, nombre, rfc, categoria, calle, colonia,');
            SQL.Add('cp, localidad, estado, telefono, fax, ecorreo,');
            SQL.Add('fecha_umov, fecha_cap) VALUES(');
            SQL.Add(txtClave.Text + ',''' + txtNombre.Text + ''',');
            SQL.Add('''' + txtRfc.Text + ''',' + sCateg + ',');
            SQL.Add('''' + txtCalle.Text + ''',''' + txtColonia.Text + ''',');
            SQL.Add('''' + txtCp.Text + ''',''' + txtLocalidad.Text + ''',');
            SQL.Add('''' + txtEstado.Text + ''',');
            SQL.Add('''' + txtTelefono.Text + ''',''' + txtFax.Text + ''',');
            SQL.Add('''' + txtCorreo.Text + ''',''' + sFecha + ''',''' + sFecha + ''')');
            ExecSQL;

            Close;
            SQL.Clear;
            SQL.Add('SELECT clave FROM vendedores WHERE nombre = ''' + txtNombre.Text + '''');
            Open;

            iClave := FieldByName('clave').AsInteger;
            Close;
        end
        else begin
            SQL.Add('UPDATE vendedores SET clave = ' + txtClave.Text + ',');
            SQL.Add('nombre = ''' + txtNombre.Text + ''',');
            SQL.Add('rfc = ''' + txtRfc.Text + ''',');
            SQL.Add('calle = ''' + txtCalle.Text + ''',');
            SQL.Add('colonia = ''' + txtColonia.Text + ''',');
            SQL.Add('cp = ''' + txtCp.Text + ''',');
            SQL.Add('localidad = ''' + txtLocalidad.Text + ''',');
            SQL.Add('estado = ''' + txtEstado.Text + ''',');
            SQL.Add('telefono = ''' + txtTelefono.Text + ''',');
            SQL.Add('fax = ''' + txtFax.Text + ''',');
            SQL.Add('fecha_umov = ''' + sFecha + ''',');
            SQL.Add('ecorreo = ''' + txtCorreo.Text + ''',');
            SQL.Add('categoria = ' + sCateg);
            SQL.Add('WHERE clave = ' + IntToStr(iClave));
            ExecSQL;
        end;
        Close;
    end;
end;

function TfrmVendedores.ClaveCateg(sCateg:String):Integer;
begin
    with dmDatos.qryModifica do begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT clave FROM categorias WHERE nombre = ''' + sCateg + '''');
        SQL.Add('AND tipo = ''V''');
        Open;

        Result := FieldByName('clave').AsInteger;
        Close;
    end;
end;

procedure TfrmVendedores.btnCancelarClick(Sender: TObject);
begin
    sModo := 'Consulta';
    LimpiaDatos;
    ActivaControles;
    pgeGeneral.ActivePage := tabBusqueda;
end;

procedure TfrmVendedores.FormShow(Sender: TObject);
begin
    VerificaCategs;
    LimpiaDatos;
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
    ActivaBuscar;
    rdgBuscarClick(Sender);
end;

procedure TfrmVendedores.RecuperaConfig;
var
    iniArchivo : TIniFile;
    sIzq, sArriba, sValor : String;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'config.ini');

    with iniArchivo do begin
        //Recupera la posición Y de la ventana
        sArriba := ReadString('Vendedores', 'Posy', '');

        //Recupera la posición X de la ventana
        sIzq := ReadString('Vendedores', 'Posx', '');

        if (Length(sIzq) > 0) and (Length(sArriba) > 0) then begin
            Left := StrToInt(sIzq);
            Top := StrToInt(sArriba);
        end;

        //Recupera el valor de los botones de radio de buscar
        sValor := ReadString('Vendedores', 'Buscar', '');
        if (Length(sValor) > 0) then
            rdgBuscar.ItemIndex := StrToInt(sValor);

        //Recupera el valor de los botones de radio de orden
        sValor := ReadString('Vendedores', 'Orden', '');
        if (Length(sValor) > 0) then
            rdgOrden.ItemIndex := StrToInt(sValor);

        //Recupera la {ultima ficha que se seleccionó
        sValor := ReadString('Vendedores', 'Ficha', '');
        if (Length(sValor) > 0) then
            pgeDatos.ActivePageIndex := StrToInt(sValor);

        //Recupera la {ultima ficha que se seleccionó
        sValor := ReadString('Vendedores', 'Ficha2', '');
        if (Length(sValor) > 0) then
            pgeGeneral.ActivePageIndex := StrToInt(sValor);

        Free;
    end;
end;

procedure TfrmVendedores.ActivaBuscar;
begin
    if(pgeGeneral.ActivePage = tabBusqueda) then begin
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

procedure TfrmVendedores.FormClose(Sender: TObject;
  var Action: TCloseAction);
  var
    iniArchivo : TIniFile;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) +'config.ini');
    with iniArchivo do begin
        // Registra la posición y de la ventana
        WriteString('Vendedores', 'Posy', IntToStr(Top));

        // Registra la posición X de la ventana
        WriteString('Vendedores', 'Posx', IntToStr(Left));

        //Registra el valor de los botones de radio de buscar
        WriteString('Vendedores', 'Buscar', IntToStr(rdgBuscar.ItemIndex));

        //Registra el valor de los botones de radio de orden
        WriteString('Vendedores', 'Orden', IntToStr(rdgOrden.ItemIndex));

        //Registra la ultima ficha que se seleccionó
        WriteString('Vendedores', 'Ficha', IntToStr(pgeDatos.ActivePageIndex));

        //Registra la ultima ficha que se seleccionó
        WriteString('Vendedores', 'Ficha2', IntToStr(pgeGeneral.ActivePageIndex));

        Free;
    end;
    dmDatos.qryListados.Close;
    dmDatos.cdsCliente.Active := false;
end;

procedure TfrmVendedores.rdgBuscarClick(Sender: TObject);
begin
    case rdgBuscar.ItemIndex of
        0: begin
            pnlNombre.Visible := false;
            pnlRfc.Visible := false;
            pnlClave.Visible := true;
            if(pgeGeneral.ActivePage = tabBusqueda) then
                txtClaveBusq.SetFocus;
           end;
        1: begin
            pnlRfc.Visible := false;
            pnlClave.Visible := false;
            pnlNombre.Visible := true;
            if(pgeGeneral.ActivePage = tabBusqueda) then
                txtNombreBusq.SetFocus;
           end;
        2: begin
            pnlNombre.Visible := false;
            pnlClave.Visible := false;
            pnlRfc.Visible := true;
            if(pgeGeneral.ActivePage = tabBusqueda) then
                txtRfcBusq.SetFocus;
           end;
    end;
end;

procedure TfrmVendedores.btnSeleccionarClick(Sender: TObject);
begin
    if (txtRegistros.Value > 0) then begin
        pgeGeneral.ActivePageIndex := 0;
        RecuperaDatos;
        ActivaBuscar;
        ActivaControles;
    end;
end;

procedure TfrmVendedores.RecuperaDatos;
var
    sCateg : String;
begin
    with dmDatos.cdsCliente do begin
        if(Active) then begin
            iClave := FieldByName('Clave').AsInteger;
            txtClave.Text := IntToStr(iClave);
            txtNombre.Text := Trim(FieldByName('nombre').AsString);
            txtRfc.Text := Trim(FieldByName('rfc').AsString);
            txtCalle.Text := Trim(FieldByName('calle').AsString);
            txtColonia.Text := Trim(FieldByName('colonia').AsString);
            txtCp.Text := Trim(FieldByName('cp').AsString);
            txtLocalidad.Text := Trim(FieldByName('localidad').AsString);
            txtEstado.Text := Trim(FieldByName('estado').AsString);
            txtTelefono.Text := Trim(FieldByName('telefono').AsString);
            txtFax.Text := Trim(FieldByName('fax').AsString);
            txtCorreo.Text := Trim(FieldByName('ecorreo').AsString);
            txtFechaCap.Text := FormatDateTime('dd/mm/yyyy',FieldByName('fecha_cap').AsDateTime);
            sCateg := BuscaCateg(FieldByName('categoria').AsString);
            cmbCategorias.ItemIndex := cmbCategorias.Items.IndexOf(sCateg);
            if(cmbCategorias.ItemIndex = -1) then
                cmbCategorias.ItemIndex := 0;
            CargaMovimientos;
        end;
    end;
end;


procedure TfrmVendedores.btnLimpiarClick(Sender: TObject);
begin
    txtClaveBusq.Clear;
    txtNombreBusq.Clear;
    txtRfcBusq.Clear;
end;

procedure TfrmVendedores.mnuVendedorClick(Sender: TObject);
begin
    pgeGeneral.ActivePage := tabDatos;
    ActivaBuscar;
end;

procedure TfrmVendedores.mnuBusquedaClick(Sender: TObject);
begin
    pgeGeneral.ActivePage := tabBusqueda;
    ActivaBuscar;
end;

procedure TfrmVendedores.Domicilio1Click(Sender: TObject);
begin
    pgeDatos.ActivePage := tabDomicilio;
end;

procedure TfrmVendedores.Contacto1Click(Sender: TObject);
begin
    pgeDatos.ActivePage := tabContacto;
end;

procedure TfrmVendedores.Movimientos1Click(Sender: TObject);
begin
    pgeDatos.ActivePage := tabMovimientos;
end;

procedure TfrmVendedores.Salir1Click(Sender: TObject);
begin
      Close;
end;

procedure TfrmVendedores.mnuAvanzaClick(Sender: TObject);
begin
    if(dmDatos.cdsCliente.Active) then begin
        dmDatos.cdsCliente.Next;
        RecuperaDatos;
    end;
end;

procedure TfrmVendedores.mnuRetrocedeClick(Sender: TObject);
begin
    if(dmDatos.cdsCliente.Active) then begin
        dmDatos.cdsCliente.Prior;
        RecuperaDatos;
    end;
end;

procedure TfrmVendedores.RecuperaCategs;
begin
    with dmDatos.qryConsulta do begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT nombre FROM categorias WHERE tipo = ''V'' ORDER BY nombre');
        Open;

        cmbCategorias.Items.Clear;
        while (not Eof) do begin
            cmbCategorias.Items.Add(Trim(FieldByName('nombre').AsString));
            Next;
        end;
        Close;
    end;
end;

function TfrmVendedores.BuscaCateg(sCateg:String):String;
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

procedure TfrmVendedores.VerificaCategs;
begin
    with dmDatos.qryModifica do begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT * FROM categorias WHERE tipo = ''V''');
        Open;

        if(Eof) then begin
            Close;
            SQL.Clear;
            SQL.Add('INSERT INTO categorias (nombre, tipo, fecha_umov, cuenta) VALUES');
            SQL.Add('(''DEFAULT'',''V'',''' + FormatDateTime('mm/dd/yyyy',Date) + ''','''')');
            ExecSQL;
        end;
        Close;
    end;
end;

procedure TfrmVendedores.Salta(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    {Inicio (36), Fin (35), Izquierda (37), derecha (39), arriba (38), abajo (40)}
    if(Key >= 30) and (Key <= 122) and (Key <> 35) and (Key <> 36) and not ((Key >= 37) and (Key <= 40)) then
        if( Length((Sender as TEdit).Text) = (Sender as TEdit).MaxLength) then
            SelectNext(Sender as TWidgetControl, true, true);
end;

procedure TfrmVendedores.grdListadoExit(Sender: TObject);
begin
    btnBuscar.Default := true;
    btnSeleccionar.Default := false;
end;

procedure TfrmVendedores.grdListadoEnter(Sender: TObject);
begin
    btnBuscar.Default := false;
    btnSeleccionar.Default := true;
end;

procedure TfrmVendedores.CargaMovimientos;
begin
    with dmDatos.qryConsulta do begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT v.fecha AS fecha, v.clave AS documento, v.total ');
        SQL.Add('FROM vendedores ve LEFT JOIN ventas v ON ve.ultventa = v.clave ');
        SQL.Add('WHERE ve.clave = ' + IntToStr(iClave));
        Open;
        if(Length(FieldByName('fecha').AsString) > 0) then begin
            txtFechaVenta.Text := FormatDateTime('dd/mm/yyyy',FieldByName('fecha').AsDateTime);
            txtDoctoVenta.Text := Trim(FieldByName('documento').AsString);
            txtImporteVenta.Value := FieldByName('total').AsFloat;
        end
        else begin
            txtFechaVenta.Clear;
            txtDoctoVenta.Clear;
            txtImporteVenta.Value := 0;
        end;
        Close;
    end;
end;

procedure TfrmVendedores.FormCreate(Sender: TObject);
begin
    RecuperaConfig;
end;

end.
