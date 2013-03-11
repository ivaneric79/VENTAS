// --------------------------------------------------------------------------
// Archivo del Proyecto Ventas 
// Página del proyecto: http://sourceforge.net/projects/ventas
// --------------------------------------------------------------------------
// Este archivo puede ser distribuido y/o modificado bajo lo terminos de la
// Licencia Pública General versión 2 como es publicada por la Free Software
// Fundation, Inc.
// --------------------------------------------------------------------------

unit Clientes;

interface

uses
  SysUtils, Types, Classes, QGraphics, QControls, QForms, QStdCtrls, QExtCtrls,
  QDBGrids, QButtons, QcurrEdit, QComCtrls, QMenus, Inifiles, QGrids, QTypes,
  StrUtils;

type
  TfrmClientes = class(TForm)
    pgeGeneral: TPageControl;
    tabDatos: TTabSheet;
    grpCliente: TGroupBox;
    Label2: TLabel;
    Label4: TLabel;
    txtNombre: TEdit;
    txtRFC: TEdit;
    btnInsertar: TBitBtn;
    btnEliminar: TBitBtn;
    btnModificar: TBitBtn;
    btnGuardar: TBitBtn;
    btnCancelar: TBitBtn;
    tabBusqueda: TTabSheet;
    pnlNombre: TPanel;
    Label20: TLabel;
    txtNombreBusq: TEdit;
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
    mnuProved: TMenuItem;
    mnuBusqueda: TMenuItem;
    N5: TMenuItem;
    Domicilio1: TMenuItem;
    Contacto1: TMenuItem;
    Movimientos1: TMenuItem;
    Label26: TLabel;
    txtFecha: TEdit;
    Label11: TLabel;
    cmbCategorias: TComboBox;
    pgeDatos: TPageControl;
    tabContacto: TTabSheet;
    grpDomicilio: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label12: TLabel;
    txtCalle: TEdit;
    txtColonia: TEdit;
    txtLocalidad: TEdit;
 
    txtCP: TEdit;
    Label13: TLabel;
    txtContacto: TEdit;
    Label32: TLabel;
    txtTelContacto: TEdit;
    Label1: TLabel;
    txtCelContacto: TEdit;
    Label33: TLabel;
    txtCorreoContacto: TEdit;
    tabEmpresa: TTabSheet;
    grpEmpresa: TGroupBox;
    Label16: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    txtCalleEmp: TEdit;
    txtColoniaEmp: TEdit;
    txtLocalidadEmp: TEdit;
    txtEstadoEmp: TEdit;
    txtCpEmp: TEdit;
    Label25: TLabel;
    txtEmpresa: TEdit;
    Label15: TLabel;
    txtRfcEmp: TEdit;
    Label34: TLabel;
    txtTelEmp: TEdit;
    Label35: TLabel;
    txtFaxEmp: TEdit;
    Label36: TLabel;
    txtCorreoEmp: TEdit;
    tabCondiciones: TTabSheet;
    grpCondiciones: TGroupBox;
    Label27: TLabel;
    txtCreden: TEdit;
    txtDescuento: TcurrEdit;
    Label28: TLabel;
    Label29: TLabel;
    txtDia: TEdit;
    txtMes: TEdit;
    txtAnio: TEdit;
    Label30: TLabel;
    Label31: TLabel;
    Label9: TLabel;
    txtPrecio: TcurrEdit;
    tabMovimientos: TTabSheet;
    grpVenta: TGroupBox;
    Movimientos2: TMenuItem;
    Label10: TLabel;
    txtFechVent: TEdit;
    Label37: TLabel;
    txtImporte: TcurrEdit;
    txtHoraVent: TEdit;
    Label14: TLabel;
    Label38: TLabel;
    txtAcumulado: TcurrEdit;
    grpCredito: TGroupBox;
    Label47: TLabel;
    txtCredito: TcurrEdit;
    Label3: TLabel;
    txtSaldo: TcurrEdit;
    Label39: TLabel;
    txtDisponible: TcurrEdit;
    txtComprobante: TEdit;
    Label40: TLabel;
    Label41: TLabel;
    txtNumero: TcurrEdit;
    txtCaja: TcurrEdit;
    Label42: TLabel;
    grpNotas: TGroupBox;
    txtNotaCredito: TcurrEdit;
    Label44: TLabel;
    grdNotaCredito: TStringGrid;
    slestado: TComboBox;
    nexterior1: TLabel;
    ninterior1: TLabel;
     nexterior: TEdit;
     ninterior: TEdit;
    procedure FormShow(Sender: TObject);
    procedure rdgBuscarClick(Sender: TObject);
    procedure btnInsertarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnModificarClick(Sender: TObject);
    procedure btnGuardarClick(Sender: TObject);
    procedure btnBuscarClick(Sender: TObject);
    procedure btnSeleccionarClick(Sender: TObject);
    procedure btnEliminarClick(Sender: TObject);
    procedure btnLimpiarClick(Sender: TObject);
    procedure grdListadoEnter(Sender: TObject);
    procedure grdListadoExit(Sender: TObject);
    procedure mnuProvedClick(Sender: TObject);
    procedure mnuBusquedaClick(Sender: TObject);
    procedure Domicilio1Click(Sender: TObject);
    procedure Contacto1Click(Sender: TObject);
    procedure Movimientos1Click(Sender: TObject);
    procedure Movimientos2Click(Sender: TObject);
    procedure mnuAvanzaClick(Sender: TObject);
    procedure mnuRetrocedeClick(Sender: TObject);
    procedure pgeGeneralChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Salta(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure Salir1Click(Sender: TObject);
    procedure rdgOrdenClick(Sender: TObject);
    procedure txtCreditoExit(Sender: TObject);
    procedure txtAnioExit(Sender: TObject);
    procedure txtDiaExit(Sender: TObject);
    procedure Rellena(Sender: TObject);
    procedure txtCredenExit(Sender: TObject);
 
    private
    sModo, sLocalidad, sEstado:String;

    procedure RecuperaConfig;
    procedure VerificaCategs;
    procedure LimpiaDatos;
    procedure RecuperaCategs;
    procedure ActivaControles;
    procedure Colores(sTipo : String);
    procedure ActivaBuscar;
    procedure GuardaDatos;
    procedure RecuperaDatos;
    procedure CargaMovimientos;
    function VerificaDatos:boolean;
    function ClaveCateg(sCateg:String):Integer;
    function BuscaCateg(sCateg:String):String;
    function VerificaFechas(sFecha:string):boolean;
    function VerificaCreden:boolean;
    function VerificaRfc : boolean;
    function VerificaNombre : boolean;
    procedure ConvierteComillas(Sender : TWidgetControl);
  public
    bGuardar : boolean;
    iClave, iPrecio : integer;
    sTipo, sNombre : String;
    rDescuento : real;
  end;

var
  frmClientes: TfrmClientes;

implementation

uses dm, ClientesBusq, Funciones;

{$R *.xfm}

procedure TfrmClientes.FormShow(Sender: TObject);
begin
    bGuardar := false;

    VerificaCategs;
    LimpiaDatos;
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
        rdgBuscarClick(Sender);
    end
    else
        btnInsertar.Click;    
    ActivaBuscar;
end;

procedure TfrmClientes.RecuperaConfig;
var
    iniArchivo : TIniFile;
    sIzq, sArriba, sValor : String;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) +'config.ini');

    with iniArchivo do begin
        //Recupera la posición Y de la ventana
        sArriba := ReadString('Clientes', 'Posy', '');

        //Recupera la posición X de la ventana
        sIzq := ReadString('Clientes', 'Posx', '');

        if (Length(sIzq) > 0) and (Length(sArriba) > 0) then begin
            Left := StrToInt(sIzq);
            Top := StrToInt(sArriba);
        end;

        //Recupera el valor de los botones de radio de buscar
        sValor := ReadString('Clientes', 'Buscar', '');
        if (Length(sValor) > 0) then
            rdgBuscar.ItemIndex := StrToInt(sValor);

        //Recupera el valor de los botones de radio de orden
        sValor := ReadString('Clientes', 'Orden', '');
        if (Length(sValor) > 0) then
            rdgOrden.ItemIndex := StrToInt(sValor);

        //Recupera la {ultima ficha que se seleccionó
        sValor := ReadString('Clientes', 'Ficha', '');
        if (Length(sValor) > 0) then
            pgeDatos.ActivePageIndex := StrToInt(sValor);

        Free;
    end;
end;

procedure TfrmClientes.VerificaCategs;
begin
    with dmDatos.qryModifica do begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT * FROM categorias WHERE tipo = ''C''');
        Open;

        if(Eof) then begin
            Close;
            SQL.Clear;
            SQL.Add('INSERT INTO categorias (nombre, tipo, fecha_umov, cuenta) VALUES');
            SQL.Add('(''DEFAULT'',''C'',''' + FormatDateTime('mm/dd/yyyy',Date) + ''','''')');
            ExecSQL;
        end;
        Close;
    end;
end;

procedure TfrmClientes.LimpiaDatos;
begin
    txtRFC.Clear;
    txtFecha.Clear;
    txtNombre.Clear;
    txtCalle.Clear;
    txtColonia.Clear;
    txtCP.Clear;
    txtLocalidad.Clear;
   // slestado.Clear;
    txtContacto.Clear;
    txtTelContacto.Clear;
    txtFaxemp.Clear;
    txtCelContacto.Clear;
    txtCorreoContacto.Clear;
    txtCalleEmp.Clear;
    txtColoniaEmp.Clear;
    txtCpEmp.Clear;
    txtLocalidadEmp.Clear;
    txtEstadoEmp.Clear;
    txtCorreoEmp.Clear;
    txtCreden.Clear;
    txtDescuento.Value := 0;
    txtCredito.Value := 0;
    txtDia.Clear;
    txtMes.Clear;
    txtAnio.Clear;
    txtPrecio.Value := 0;
    txtRFCEmp.Clear;
    txtEmpresa.Clear;
    txtTelEmp.Clear;
end;

procedure TfrmClientes.RecuperaCategs;
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

procedure TfrmClientes.ActivaControles;
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

        txtRFC.ReadOnly := false;
        txtFecha.ReadOnly := true;
        txtNombre.ReadOnly := false;
        txtCalle.ReadOnly := false;
        txtColonia.ReadOnly := false;
        txtCP.ReadOnly := false;
        txtLocalidad.ReadOnly := false;
       slestado.Enabled:= true;
        txtContacto.ReadOnly := false;
        txtTelContacto.ReadOnly := false;
        txtFaxEmp.ReadOnly := false;
        txtCelContacto.ReadOnly := false;
        txtCorreoContacto.ReadOnly := false;
        txtCalleEmp.ReadOnly := false;
        txtColoniaEmp.ReadOnly := false;
        txtCpEmp.ReadOnly := false;
        txtLocalidadEmp.ReadOnly := false;
        txtEstadoEmp.ReadOnly := false;
        txtCorreoEmp.ReadOnly := false;
        txtCreden.ReadOnly := false;
        txtDescuento.ReadOnly := false;
        txtCredito.ReadOnly := false;
        txtDia.ReadOnly := false;
        txtMes.ReadOnly := false;
        txtAnio.ReadOnly := false;

        txtPrecio.ReadOnly := false;
        txtRFCEmp.ReadOnly := false;
        txtEmpresa.ReadOnly := false;
        txtTelEmp.ReadOnly := false;

        txtRFC.TabStop := true;
        txtFecha.TabStop := false;
        txtNombre.TabStop := true;
        txtCalle.TabStop := true;
        txtColonia.TabStop := true;
        txtCP.TabStop := true;
        txtLocalidad.TabStop := true;
       slestado.TabStop := true;
        txtContacto.TabStop := true;
        txtTelContacto.TabStop := true;
        txtFaxEmp.TabStop := true;
        txtCelContacto.TabStop := true;
        txtCorreoContacto.TabStop := true;
        txtCalleEmp.TabStop := true;
        txtColoniaEmp.TabStop := true;
        txtCpEmp.TabStop := true;
        txtLocalidadEmp.TabStop := true;
        txtEstadoEmp.TabStop := true;
        txtCorreoEmp.TabStop := true;
        txtCreden.TabStop := true;
        txtDescuento.TabStop := true;
        txtCredito.TabStop := true;
        txtDia.TabStop := true;
        txtMes.TabStop := true;
        txtAnio.TabStop := true;
        txtPrecio.TabStop := true;
        txtRFCEmp.TabStop := true;
        txtEmpresa.TabStop := true;
        txtTelEmp.TabStop := true;
           ninterior.Enabled:= true;
        nexterior.Enabled:= true;


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
        mnuBusqueda.Enabled := true;

        tabBusqueda.Enabled := true;

        txtRFC.ReadOnly := true;
        txtFecha.ReadOnly := true;
        txtNombre.ReadOnly := true;
        txtCalle.ReadOnly := true;
        txtColonia.ReadOnly := true;
        txtCP.ReadOnly := true;
        txtLocalidad.ReadOnly := true;
        slestado.Enabled := false;
        txtContacto.ReadOnly := true;
        txtTelContacto.ReadOnly := true;
        txtFaxEmp.ReadOnly := true;
        txtCelContacto.ReadOnly := true;
        txtCorreoContacto.ReadOnly := true;
        txtCalleEmp.ReadOnly := true;
        txtColoniaEmp.ReadOnly := true;
        txtCpEmp.ReadOnly := true;
        txtLocalidadEmp.ReadOnly := true;
        txtEstadoEmp.ReadOnly := true;
        txtCorreoEmp.ReadOnly := true;
        txtCreden.ReadOnly := true;
        txtDescuento.ReadOnly := true;
        txtCredito.ReadOnly := true;
        txtDia.ReadOnly := true;
        txtMes.ReadOnly := true;
        txtAnio.ReadOnly := true;
        txtPrecio.ReadOnly := true;
        txtRFCEmp.ReadOnly := true;
        txtEmpresa.ReadOnly := true;
        txtTelEmp.ReadOnly := true;

        txtRFC.TabStop := false;
        txtFecha.TabStop := false;
        txtNombre.TabStop := false;
        txtCalle.TabStop := false;
        txtColonia.TabStop := false;
        txtCP.TabStop := false;
        txtLocalidad.TabStop := false;
        slestado.TabStop := false;
        txtContacto.TabStop := false;
        txtTelContacto.TabStop := false;
        txtFaxemp.TabStop := false;
        txtCelContacto.TabStop := false;
        txtCorreoContacto.TabStop := false;
        txtCalleEmp.TabStop := false;
        txtColoniaEmp.TabStop := false;
        txtCpEmp.TabStop := false;
        txtLocalidadEmp.TabStop := false;
        txtEstadoEmp.TabStop := false;
        txtCorreoEmp.TabStop := false;
        txtCreden.TabStop := false;
        txtDescuento.TabStop := false;
        txtCredito.TabStop := false;
        txtDia.TabStop := false;
        txtMes.TabStop := false;
        txtAnio.TabStop := false;
        txtPrecio.TabStop := false;
        txtRFCEmp.TabStop := false;
        txtEmpresa.TabStop := false;
        txtTelEmp.TabStop := false;

        txtDia.Enabled := false;
        txtMes.Enabled := false;
        txtAnio.Enabled := false;
        ninterior.Enabled:= false;
        nexterior.Enabled:= false;

        cmbCategorias.Enabled := false;
    end;

end;

procedure TfrmClientes.Colores(sTipo : String);
begin
    if(sTipo = 'Insertar') then begin

        txtRFC.Font.Color := clWindowText;
        txtFecha.Font.Color := clBlue;
        txtNombre.Font.Color := clWindowText;
        txtCalle.Font.Color := clWindowText;
        txtColonia.Font.Color := clWindowText;
        txtCP.Font.Color := clWindowText;
        txtLocalidad.Font.Color := clWindowText;
        slestado.Font.Color := clWindowText;
        txtContacto.Font.Color := clWindowText;
        txtTelContacto.Font.Color := clWindowText;
        txtFaxEmp.Font.Color := clWindowText;
        txtCelContacto.Font.Color := clWindowText;
        txtCorreoContacto.Font.Color := clWindowText;
        txtCalleEmp.Font.Color := clWindowText;
        txtColoniaEmp.Font.Color := clWindowText;
        txtCpEmp.Font.Color := clWindowText;
        txtLocalidadEmp.Font.Color := clWindowText;
        txtEstadoEmp.Font.Color := clWindowText;
        txtCorreoEmp.Font.Color := clWindowText;
        txtCreden.Font.Color := clWindowText;
        txtDescuento.Font.Color := clWindowText;
        txtCredito.Font.Color := clWindowText;
        txtDia.Font.Color := clWindowText;
        txtMes.Font.Color := clWindowText;
        txtAnio.Font.Color := clWindowText;
        txtPrecio.Font.Color := clWindowText;
        txtRFCEmp.Font.Color := clWindowText;
        txtEmpresa.Font.Color := clWindowText;
        txtTelEmp.Font.Color := clWindowText;
        ninterior.Font.Color:= clWindowText;
        nexterior.Font.Color:= clWindowText;
    end
    else begin
        txtRFC.Font.Color    := clBlue;
        txtFecha.Font.Color  := clBlue;
        txtNombre.Font.Color := clBlue;
        txtCalle.Font.Color  := clBlue;
        txtColonia.Font.Color:= clBlue;
        txtCP.Font.Color := clBlue;
        txtLocalidad.Font.Color := clBlue;
        slestado.Font.Color := clBlue;
        txtContacto.Font.Color := clBlue;
        txtTelContacto.Font.Color := clBlue;
        txtFaxEmp.Font.Color := clBlue;
        txtCelContacto.Font.Color := clBlue;
        txtCorreoContacto.Font.Color := clBlue;
        txtCalleEmp.Font.Color := clBlue;
        txtColoniaEmp.Font.Color := clBlue;
        txtCpEmp.Font.Color := clBlue;
        txtLocalidadEmp.Font.Color := clBlue;
        txtEstadoEmp.Font.Color := clBlue;
        txtCorreoEmp.Font.Color := clBlue;
        txtCreden.Font.Color := clBlue;
        txtDescuento.Font.Color := clBlue;
        txtCredito.Font.Color := clBlue;
        txtDia.Font.Color  := clBlue;
        txtMes.Font.Color  := clBlue;
        txtAnio.Font.Color := clBlue;
        txtPrecio.Font.Color := clBlue;
        txtRFCEmp.Font.Color := clBlue;
        txtEmpresa.Font.Color := clBlue;
        txtTelEmp.Font.Color := clBlue;
        ninterior.Font.Color:= clBlue;
        nexterior.Font.Color:= clBlue;
    end;
end;

procedure TfrmClientes.ActivaBuscar;
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

procedure TfrmClientes.rdgBuscarClick(Sender: TObject);
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

procedure TfrmClientes.btnInsertarClick(Sender: TObject);
begin
    sModo := 'Insertar';
    pgeGeneral.ActivePage := tabDatos;
    ActivaControles;
    LimpiaDatos;
    txtFecha.Text := FormatDateTime('dd/mm/yyyy',Date);
  //  txtLocalidad.Text := sLocalidad;
 //   slestado.Text := sEstado;
    if(cmbCategorias.ItemIndex = -1) then
        cmbCategorias.ItemIndex := 0;
    txtPrecio.Value := 1;
    txtRfc.SetFocus;
end;

procedure TfrmClientes.btnCancelarClick(Sender: TObject);
begin
    sModo := 'Consulta';
    LimpiaDatos;
    if(sTipo = 'Captura') then
        Close
    else begin
        ActivaControles;
        pgeGeneral.ActivePage := tabBusqueda;
    end;
end;

procedure TfrmClientes.btnModificarClick(Sender: TObject);
begin
    if (pgeGeneral.ActivePage = tabBusqueda) then
        RecuperaDatos;
    if(Length(Trim(txtNombre.Text)) > 0) then begin
        sModo := 'Modificar';
        ActivaControles;
        pgeGeneral.ActivePageIndex := 0;
        txtRfc.SetFocus;
    end;
end;

procedure TfrmClientes.btnGuardarClick(Sender: TObject);
begin
    if(VerificaDatos) then begin
        GuardaDatos;
        if(sTipo = 'Captura') then begin
            bGuardar := true;
            sNombre := txtNombre.Text;
            rDescuento := txtDescuento.Value;
            iPrecio := Round(txtPrecio.Value);
            Close;
        end
        else begin
            sModo := 'Consulta';
            ActivaControles;
            btnBuscarClick(Sender);
            btnInsertar.SetFocus;
        end;
    end;
end;

procedure TfrmClientes.ConvierteComillas(Sender : TWidgetControl);
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

function TfrmClientes.VerificaDatos:boolean;
var
    bVerifica : boolean;
    sFecha : string;
begin
    sFecha := txtMes.Text + '/' + txtDia.Text + '/' + txtAnio.Text ;
    btnGuardar.SetFocus;
    ConvierteComillas(grpCliente);
    ConvierteComillas(grpDomicilio);
    ConvierteComillas(grpEmpresa);
    bVerifica := True;
    if(Length(txtNombre.Text) = 0) then begin
        Application.MessageBox('Introduce el nombre del cliente','Error',[smbOK],smsCritical);
        txtNombre.SetFocus;
        bVerifica := False;
    end
    else if(txtPrecio.Value < 1) or (txtPrecio.Value > 6) then begin     //modif para ajuste 28 jul 2009
        Application.MessageBox('Introduce un precio válido para el cliente (1..6)','Error',[smbOK],smsCritical);    //modif para ajuste 28 jul 2009
        pgeDatos.ActivePage := tabCondiciones;
        txtPrecio.SetFocus;
        bVerifica := False;
    end
    else if(txtDescuento.Value > 0) and (txtDescuento.Value > 100) then begin
        Application.MessageBox('Introduce un descuento válido para el cliente (1..100)','Error',[smbOK],smsCritical);
        pgeDatos.ActivePage := tabCondiciones;
        txtDescuento.SetFocus;
        bVerifica := False;
    end
    else if(Length(txtDia.Text) > 0)and (Length(txtMes.Text) > 0) and (Length(txtAnio.Text) > 0) and  (Length(txtCreden.Text) = 0) then begin
        Application.MessageBox('Introduce un número de credencial','Error',[smbOK],smsCritical);
        pgeDatos.ActivePage := tabCondiciones;
        txtCreden.SetFocus;
        bVerifica := false;
    end
    else if(not VerificaRfc) then
        bVerifica := false
    else if(not VerificaNombre) then
        bVerifica := false
    else if (not VerificaCreden) then
        bVerifica := false
    else if (not VerificaFechas(txtDia.Text + '/' + txtMes.Text + '/' + txtAnio.Text)) and (Length(txtCreden.Text) > 0) then begin
        Application.MessageBox('Introduce una fecha válida','Error',[smbOK],smsCritical);
        pgeDatos.ActivePage := tabCondiciones;
        txtDia.SetFocus;
        bVerifica := false
    end
    else if(not ValidaCorreo(txtCorreoContacto.Text)) then begin
        Application.MessageBox('Introduce un correo válido para el cliente','Error',[smbOK],smsCritical);
        pgeDatos.ActivePage := tabContacto;
        txtCorreoContacto.SetFocus;
        bVerifica := false;
    end
    else if(not ValidaCorreo(txtCorreoEmp.Text)) then begin
        Application.MessageBox('Introduce un correo válido para la empresa','Error',[smbOK],smsCritical);
        pgeDatos.ActivePage := tabEmpresa;
        txtCorreoEmp.SetFocus;
        bVerifica := false;
    end;

    Result := bVerifica;
end;

procedure TfrmClientes.GuardaDatos;
var
    sFecha, sFechaCred, sCateg : String;
begin
    with dmDatos.qryModifica do begin

        if(cmbCategorias.ItemIndex <> -1) then
            sCateg := IntToStr(ClaveCateg(cmbCategorias.Items.Strings[cmbCategorias.ItemIndex]))
        else
            sCateg := 'null';


        sFecha  := FormatDateTime('mm/dd/yyyy hh:nn:ss',Now);
        if(txtDia.Text <> '') and (txtMes.Text <> '') and (txtAnio.Text <> '') then
            sFechaCred := '''' + txtMes.Text + '/' + txtDia.Text + '/' + txtAnio.Text + ''''
        else
            sFechaCred := 'null';

        if(sModo = 'Insertar') then begin
            Close;
            SQL.Clear;
            SQL.Add('INSERT INTO Clientes (nombre, rfc, calle, colonia,');
            SQL.Add('localidad, estado, cp, descuento,telefono, ecorreo,');
            SQL.Add('CREDENCIAL,VENCIMCREDEN,LIMITECREDITO, fechacap, fechaumov,');
            SQL.Add('CONTACTO,EMPRESA,RFCEMP,CALLEEMP,COLONIAEMP,');
            SQL.Add('LOCALIDADEMP,ESTADOEMP,CPEMP,CORREOEMP,CELULAR,FAXEMP,');
            SQL.Add('TELEMP,CATEGORIA, precio, acumulado, NEXTERIOR,NINTERIOR) VALUES(');

            SQL.Add('''' + txtNombre.Text + ''',''' + txtRfc.Text + ''',''' + txtCalle.Text + ''',''' + txtColonia.Text + ''',');
            SQL.Add('''' + txtLocalidad.Text + ''',''' + slestado.text + ''',''' + txtCp.Text + ''',');
            SQL.Add(FloatToStr(txtDescuento.Value) + ',''' + txtTelContacto.Text + ''',''' + txtCorreoContacto.Text+''',');
            SQL.Add('''' + txtCreden.Text +''',' + sFechaCred + ',' + FloatToStr(txtCredito.Value)+',');
            SQL.Add('''' + sFecha + ''',''' + sFecha + ''',''' + txtContacto.Text + ''',''' + txtEmpresa.Text + ''','''+txtRfcEmp.Text+''',');
            SQL.Add('''' + txtCalleEmp.Text + ''',''' + txtColoniaEmp.Text + ''','''+txtLocalidadEmp.Text+''','''+txtEstadoEmp.Text+''',');
            SQL.Add('''' + txtCpEmp.Text + ''',''' + txtCorreoEmp.Text + ''',''' + txtCelContacto.Text + ''','''+txtFaxEmp.Text+''',');
            SQL.Add('''' + txtTelEmp.Text  + ''',' + sCateg + ',');
            SQL.Add(FloatToStr(txtPrecio.Value) + ', 0, '''+ nexterior.Text + ''',''' + ninterior.Text + ''')');
            ExecSQL;

            Close;
            SQL.Clear;
            SQL.Add('SELECT clave FROM clientes WHERE nombre = ''' + txtNombre.Text + '''');
            Open;

            iClave := FieldByName('clave').AsInteger;
            Close;
        end
        else begin
            Close;
            SQL.Clear;
            SQL.Add('UPDATE clientes SET nombre = ''' + txtNombre.Text + ''',');
            SQL.Add('RFC = ''' + txtRfc.Text+ ''',');
            SQL.Add('CALLE = '''+ txtCalle.Text + ''',');
            SQL.Add('COLONIA = '''+ txtColonia.Text+ ''',');
            SQL.Add('LOCALIDAD = '''+ txtLocalidad.Text + ''',');
            SQL.Add('ESTADO = '''+ slestado.text+ ''',');
            SQL.Add('CP = ''' + txtCp.Text + ''',');
            SQL.Add('DESCUENTO = '+FloatToStr(txtDescuento.Value) + ',');
            SQL.Add('TELEFONO = ''' + txtTelContacto.Text + ''',');
            SQL.Add('ECORREO = '''+ txtCorreoContacto.Text + ''',');
            SQL.Add('CREDENCIAL = ''' + txtCreden.Text + ''',');
            SQL.Add('VENCIMCREDEN = ' + sFechaCred + ',');
            SQL.Add('LIMITECREDITO =' +FloatToStr(txtCredito.Value)+ ',');
            SQL.Add('FECHACAP = '''+ sFecha + ''',');
            SQL.Add('FECHAUMOV = '''+ sFecha + ''',');
            SQL.Add('CONTACTO = '''+ txtContacto.Text+ ''',');
            SQL.Add('EMPRESA = ''' + txtEmpresa.Text+ ''',');
            SQL.Add('RFCEMP = ''' +txtRfcEmp.Text + ''',');
            SQL.Add('CALLEEMP = '''+ txtCalleEmp.Text + ''',');
            SQL.Add('COLONIAEMP = ''' + txtColoniaEmp.Text + ''',');
            SQL.Add('LOCALIDADEMP = ''' +txtLocalidadEmp.Text + ''',');
            SQL.Add('ESTADOEMP = ''' +txtEstadoEmp.Text + ''',');
            SQL.Add('CPEMP = '''+ txtCpEmp.Text+ ''',');
            SQL.Add('CORREOEMP = ''' + txtCorreoEmp.Text + ''',');
            SQL.Add('CELULAR = ''' + txtCelContacto.Text + ''',');
            SQL.Add('FAXEMP = ''' +txtFaxEmp.Text + ''',');
            SQL.Add('TELEMP = ''' + txtTelEmp.Text + ''',');
            SQL.Add('CATEGORIA = ' + sCateg + ',');

            SQL.Add('NEXTERIOR = ''' + nexterior.Text + ''',');
            SQL.Add('NINTERIOR = ''' + ninterior.Text + ''',');
            SQL.Add('precio = ' + FloatToStr(txtPrecio.Value));
            SQL.Add('WHERE clave = ' + IntToStr(iClave));
            ExecSQL;
            Close;
        end;
    end;
end;

function TfrmClientes.ClaveCateg(sCateg:String):Integer;
begin
    with dmDatos.qryModifica do begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT clave FROM categorias WHERE nombre = ''' + sCateg + '''');
        SQL.Add('AND tipo = ''C''');
        Open;

        Result := FieldByName('clave').AsInteger;
        Close;
    end;
end;

procedure TfrmClientes.btnBuscarClick(Sender: TObject);
var
    sBM: string;
begin
    with dmDatos.qryListados do begin
        sBM := dmDatos.cdsCliente.Bookmark;

        dmDatos.cdsCliente.Active := false;

        Close;
        SQL.Clear;
        SQL.Add('SELECT clave, nombre, credencial, rfc, calle, colonia, cp,');
        SQL.Add('localidad, estado, telefono, ecorreo,');
        SQL.Add('fechacap, categoria FROM clientes WHERE 1 = 1');

        case rdgBuscar.ItemIndex of
            0: if(Length(txtClaveBusq.Text) > 0) then
                SQL.Add('AND credencial = ''' + txtClaveBusq.Text + '''');
            1: SQL.Add('AND nombre LIKE ''%' + txtNombreBusq.Text + '%''');
            2: SQL.Add('AND rfc STARTING ''' + txtRfcBusq.Text + '''');
        end;

        case rdgOrden.ItemIndex of
            0:  SQL.Add('ORDER BY credencial');
            1:  SQL.Add('ORDER BY nombre');
            2:  SQL.Add('ORDER BY rfc');
        end;
        Open;
        dmDatos.cdsCliente.Active := true;

        dmDatos.cdsCliente.FieldByName('clave').Visible := false;
        dmDatos.cdsCliente.FieldByName('calle').Visible := false;
        dmDatos.cdsCliente.FieldByName('colonia').Visible := false;
        dmDatos.cdsCliente.FieldByName('cp').Visible := false;
        dmDatos.cdsCliente.FieldByName('localidad').Visible := false;
        dmDatos.cdsCliente.FieldByName('estado').Visible := false;
        dmDatos.cdsCliente.FieldByName('fechacap').Visible := false;
        dmDatos.cdsCliente.FieldByName('categoria').Visible := false;
        dmDatos.cdsCliente.FieldByName('nombre').DisplayLabel := 'Nombre';
        dmDatos.cdsCliente.FieldByName('nombre').DisplayWidth := 40;
        dmDatos.cdsCliente.FieldByName('credencial').DisplayLabel := 'Credencial';
        dmDatos.cdsCliente.FieldByName('rfc').DisplayLabel := 'RFC';
        dmDatos.cdsCliente.FieldByName('telefono').DisplayLabel := 'Teléfono';
        dmDatos.cdsCliente.FieldByName('ecorreo').DisplayLabel := 'Correo';

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

procedure TfrmClientes.btnSeleccionarClick(Sender: TObject);
begin
    if (txtRegistros.Value > 0) then begin
        sModo := 'Consulta';
        RecuperaDatos;
        ActivaBuscar;
        ActivaControles;
    end;
end;

procedure TfrmClientes.RecuperaDatos;
var
    sFechaVen, sCateg : String;
begin
    if(dmDatos.cdsCliente.Active) then
        iClave := dmDatos.cdsCliente.FieldByName('Clave').AsInteger;

    with dmDatos.qryConsulta do begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT * FROM clientes WHERE clave = ' + IntToStr(iClave));
        Open;

        if(not Eof) then begin
            pgeGeneral.ActivePageIndex := 0;
            txtNombre.Text := Trim(FieldByname('Nombre').AsString);
            txtRfc.Text := Trim(FieldByname('RFC').AsString);
            txtCalle.Text := Trim(FieldByname('CALLE').AsString);
            txtColonia.Text := Trim(FieldByname('COLONIA').AsString);
            txtLocalidad.Text := Trim(FieldByname('LOCALIDAD').AsString);
            slestado.Text := FieldByname('ESTADO').AsString;
            txtCp.text := Trim(FieldByname('CP').AsString);
            txtCorreoContacto.Text := Trim(FieldByname('Ecorreo').AsString);
            txtDescuento.Value:= FieldByname('DESCUENTO').AsFloat;
            txtTelContacto.Text:= Trim(FieldByname('TELEFONO').AsString);
            txtCreden.Text := Trim(FieldByname('CREDENCIAL' ).AsString);

            if(not FieldByname('VENCIMCREDEN').IsNull) and (Length(txtCreden.Text) > 0) then begin
                sFechaVen := FormatDateTime('dd/mm/yyyy',FieldByname('VENCIMCREDEN').AsDateTime);
                txtDia.Text:= Copy(sFechaVen,1,2);
                txtMes.Text:= Copy(sFechaVen,4,2);
                txtAnio.Text:= Copy(sFechaVen,7,4);
            end
            else begin
                txtDia.Clear;;
                txtMes.Clear;
                txtAnio.Clear;
            end;

            txtCredito.Value := FieldByname('LIMITECREDITO').AsFloat;
            txtPrecio.Value :=  FieldByname('precio').AsInteger;
            txtAcumulado.Value := FieldByname('acumulado').AsFloat;

            txtFecha.Text := FormatDateTime('dd/mm/yyyy',FieldByname('FECHACAP').AsDateTime);
            txtContacto.Text :=Trim(FieldByname('CONTACTO').AsString);
            txtEmpresa.Text := Trim(FieldByname('EMPRESA').AsString);
            txtRfcEmp.Text := Trim(FieldByname('RFCEMP').AsString);
            txtCalleEmp.Text := Trim(FieldByname('CALLEEMP').AsString);
            txtColoniaEmp.Text := Trim(FieldByname('COLONIAEMP').AsString);
            txtLocalidadEmp.Text := Trim(FieldByname('LOCALIDADEMP').AsString);
            txtEstadoEmp.Text := Trim(FieldByname('ESTADOEMP').AsString);
            txtCpEmp.Text:= Trim(FieldByname('CPEMP').AsString);
            txtCorreoEmp.Text := Trim(FieldByname('CORREOEMP').AsString);
            ninterior.Text := Trim(FieldByname('NINTERIOR').AsString);
            nexterior.Text := Trim(FieldByname('NEXTERIOR').AsString);

            txtCelContacto.Text:= Trim(FieldByname('CELULAR').AsString);
            txtFaxEmp.Text := Trim(FieldByname('FAXEMP').AsString);
            txtTelEmp.Text := Trim(FieldByname('TELEMP').AsString);
            sCateg := BuscaCateg(FieldByName('categoria').AsString);
            cmbCategorias.ItemIndex := cmbCategorias.Items.IndexOf(sCateg);

            Close;
            SQL.Clear;
            SQL.Add('SELECT SUM(importe-pagado) AS saldo FROM xcobrar WHERE estatus = ''A'' AND cliente = ' + IntToStr(iClave));
            Open;
            txtSaldo.Value := FieldByName('saldo').AsFloat;
            txtDisponible.Value := txtCredito.Value - txtSaldo.Value;
            Close;
            
            CargaMovimientos;
        end;
        Close;
    end;
end;

function TfrmClientes.BuscaCateg(sCateg:String):String;
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

procedure TfrmClientes.btnEliminarClick(Sender: TObject);
begin
    if (pgeGeneral.ActivePage = tabBusqueda) then
        RecuperaDatos;
    if(Length(Trim(txtNombre.Text)) > 0) then begin
        pgeGeneral.ActivePage := tabDatos;
        if(Application.MessageBox('Se eliminará el cliente seleccionado','Eliminar',[smbOK]+[smbCancel],smsWarning) = smbOK) then begin
            with dmDatos.qryModifica do begin
                Close;
                SQL.Clear;
                SQL.Add('DELETE FROM CLIENTES WHERE clave = ' + IntToStr(iClave));
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

procedure TfrmClientes.btnLimpiarClick(Sender: TObject);
begin
    txtClaveBusq.Clear;
    txtNombreBusq.Clear;
    txtRfcBusq.Clear;
end;

procedure TfrmClientes.grdListadoEnter(Sender: TObject);
begin
    btnBuscar.Default := false;
    btnSeleccionar.Default := true;
end;

procedure TfrmClientes.grdListadoExit(Sender: TObject);
begin
    btnBuscar.Default := true;
    btnSeleccionar.Default := false;
end;

procedure TfrmClientes.mnuProvedClick(Sender: TObject);
begin
    pgeGeneral.ActivePage := tabDatos;
    ActivaBuscar;
end;

procedure TfrmClientes.mnuBusquedaClick(Sender: TObject);
begin
    pgeGeneral.ActivePage := tabBusqueda;
    ActivaBuscar;
end;

procedure TfrmClientes.Domicilio1Click(Sender: TObject);
begin
    pgeDatos.ActivePage := tabContacto;
    ActivaBuscar;
end;

procedure TfrmClientes.Contacto1Click(Sender: TObject);
begin
    pgeDatos.ActivePage := tabEmpresa;
    ActivaBuscar;
end;

procedure TfrmClientes.Movimientos1Click(Sender: TObject);
begin
    pgeDatos.ActivePage := tabCondiciones;
    ActivaBuscar;
end;

procedure TfrmClientes.Movimientos2Click(Sender: TObject);
begin
    pgeDatos.ActivePage := tabMovimientos;
    ActivaBuscar;
end;

procedure TfrmClientes.mnuAvanzaClick(Sender: TObject);
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

procedure TfrmClientes.mnuRetrocedeClick(Sender: TObject);
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

procedure TfrmClientes.pgeGeneralChange(Sender: TObject);
begin
    ActivaBuscar;
end;

procedure TfrmClientes.FormClose(Sender: TObject;
  var Action: TCloseAction);
  var iniArchivo : TIniFile;
begin

    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) +'config.ini');
    with iniArchivo do begin
        // Registra la posición y de la ventana
        WriteString('Clientes', 'Posy', IntToStr(Top));

        // Registra la posición X de la ventana
        WriteString('Clientes', 'Posx', IntToStr(Left));

        //Registra el valor de los botones de radio de buscar
        WriteString('Clientes', 'Buscar', IntToStr(rdgBuscar.ItemIndex));

        //Registra el valor de los botones de radio de orden
        WriteString('Clientes', 'Orden', IntToStr(rdgOrden.ItemIndex));

        //Registra la ultima ficha que se seleccionó
        WriteString('Clientes', 'Ficha', IntToStr(pgeDatos.ActivePageIndex));

        Free;
    end;
    dmDatos.qryListados.Close;
    dmDatos.cdsCliente.Active := false;
end;

procedure TfrmClientes.Salta(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    {Inicio (36), Fin (35), Izquierda (37), derecha (39), arriba (38), abajo (40)}
    if(Key >= 30) and (Key <= 122) and (Key <> 35) and (Key <> 36) and not ((Key >= 37) and (Key <= 40)) then
        if( Length((Sender as TEdit).Text) = (Sender as TEdit).MaxLength) then
            SelectNext(Sender as TWidgetControl, true, true);
end;

function TfrmClientes.VerificaFechas(sFecha : string):boolean;
var
   dteFecha : TDateTime;
begin
   Result:=true;
   if(not TryStrToDate(sFecha,dteFecha)) then begin
      Result:=false;
   end;
end;


function TfrmClientes.VerificaCreden:boolean;
var
    bRegreso : boolean;
begin
    bRegreso := true;

    if(Length(txtCreden.Text) > 0) then begin
        with dmDatos.qryModifica do begin
            Close;
            SQL.Clear;
            SQL.Add('SELECT clave, credencial, nombre FROM clientes WHERE credencial = ''' + txtCreden.Text + '''');
            Open;;

            if(not Eof) and ((sModo = 'Insertar') or ((FieldByName('clave').AsInteger <> iClave) and
                     (sModo = 'Modificar'))) then begin
                bRegreso := false;
                Application.MessageBox('El número de credencial ya fue asignada a ' + Trim(FieldByName('nombre').AsString),'Error',[smbOk],smsCritical);
                txtCreden.SetFocus;
            end;
            Close;
        end;
    end;
    Result := bRegreso;
end;

function TfrmClientes.VerificaNombre : boolean;
var
    bVerifica : boolean;
begin
    bVerifica := true;

    with dmDatos.qryModifica do begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT clave FROM clientes WHERE nombre = ''' + txtNombre.Text + '''');
        Open;

        if(not Eof) and ((sModo = 'Insertar') or ((FieldByName('clave').AsInteger <> iClave) and
            (sModo = 'Modificar'))) then begin
                bVerifica := false;
                Application.MessageBox('El nombre del cliente ya existe','Error',[smbOk],smsCritical);
                txtNombre.SetFocus;
        end;
        Close;
    end;
    Result := bVerifica;
end;

function TfrmClientes.VerificaRfc : boolean;
var
    bVerifica : boolean;
begin
    bVerifica := true;

    if(Length(txtRfc.Text) > 0) then
        with dmDatos.qryModifica do begin
            Close;
            SQL.Clear;
            SQL.Add('SELECT clave, nombre FROM clientes WHERE rfc = ''' + txtRfc.Text + '''');
            Open;

            if(not Eof) and ((sModo = 'Insertar') or ((FieldByName('clave').AsInteger <> iClave) and
                (sModo = 'Modificar'))) then begin
                    bVerifica := false;
                    Application.MessageBox('El R.F.C. ya fue asiganado a ' + Trim(FieldByName('nombre').AsString),'Error',[smbOk],smsCritical);
                    txtRfc.SetFocus;
            end;
            Close;
        end;
    Result := bVerifica;
end;

procedure TfrmClientes.CargaMovimientos;
var
    sTipo : String;
begin
    with dmDatos.qryConsulta do begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT o.tipo, o.numero, o.caja, v.fecha, v.hora, v.total FROM clientes c LEFT JOIN ventas v');
        SQL.Add('ON c.ultimacompra = v.clave LEFT JOIN comprobantes o ON c.ultimacompra = o.venta');
        SQL.Add('WHERE o.estatus = ''A'' AND c.clave = ' + IntToStr(iClave));
        Open;
        if(Length(FieldByName('fecha').AsString) > 0) then begin
            sTipo := Copy(FieldByName('tipo').AsString,1,1);
            if(sTipo = 'N' ) then
                txtComprobante.Text := 'NOTA'
            else if(sTipo = 'F' ) then
                txtComprobante.Text := 'FACTURA'
            else
                txtComprobante.Text := 'TICKET';

            txtNumero.Value := FieldByName('numero').AsInteger;
            txtCaja.Value := FieldByName('caja').AsInteger;
            txtFechVent.Text := FormatDateTime('dd/mm/yyyy',FieldByName('fecha').AsDateTime);
            txtHoraVent.Text := FormatDateTime('hh:nn:ss',FieldByName('hora').AsDateTime);
            txtImporte.Value := FieldByName('total').AsFloat;
        end
        else begin
            txtComprobante.Clear;
            txtNumero.Value := 0;
            txtCaja.Value := 0;
            txtFechVent.Clear;
            txtHoraVent.Clear;
            txtImporte.Value := 0;
        end;
        Close;
    end;
end;

procedure TfrmClientes.FormCreate(Sender: TObject);
begin
    RecuperaConfig;
end;

procedure TfrmClientes.Salir1Click(Sender: TObject);
begin
    Close;
end;

procedure TfrmClientes.rdgOrdenClick(Sender: TObject);
begin
    if(dmDatos.qryListados.Active) then
        btnBuscarClick(Sender);
end;

procedure TfrmClientes.txtCreditoExit(Sender: TObject);
begin
    txtDisponible.Value := txtCredito.Value - txtSaldo.Value;
end;

procedure TfrmClientes.txtAnioExit(Sender: TObject);
begin
    txtAnio.Text := Trim(txtAnio.Text);
    if(Length(txtAnio.Text) < 4) and (Length(txtAnio.Text) > 0) then
        txtAnio.Text := IntToStr(StrToInt(txtAnio.Text) + 2000);
end;

procedure TfrmClientes.txtDiaExit(Sender: TObject);
begin
    Rellena(Sender);
end;
procedure TfrmClientes.Rellena(Sender: TObject);
var
    i : integer;
begin
    for i := Length((Sender as TEdit).Text) to (Sender as TEdit).MaxLength - 1 do
        (Sender as TEdit).Text := '0' + (Sender as TEdit).Text;
end;
procedure TfrmClientes.txtCredenExit(Sender: TObject);
begin
    if(Length(Trim(txtCreden.Text)) > 0) then begin
        txtDia.Enabled  := true;
        txtMes.Enabled  := true;
        txtAnio.Enabled := true;
        txtDia.Setfocus;
    end
    else begin
        txtDia.Text  := '';
        txtMes.Text  := '';
        txtAnio.Text  := '';
        txtDia.Enabled  := false;
        txtMes.Enabled  := false;
        txtAnio.Enabled := false;
    end;
end;

end.




