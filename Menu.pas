// --------------------------------------------------------------------------
// Archivo del Proyecto Ventas   
// Página del proyecto: http://sourceforge.net/projects/ventas
// --------------------------------------------------------------------------
// Este archivo puede ser distribuido y/o modificado bajo lo terminos de la
// Licencia Pública General versión 2 como es publicada por la Free Software
// Fundation, Inc.
// --------------------------------------------------------------------------
// I.S.C. Bismarck Sierra Ibarra (Administrador del proyecto)
// L.I. Andrés Velasco Gordillo (Desarrollador)
// D.S. Josué Fuentes Gutiérrez (Desarrollador)
// A.T. Alexandre Oliveira Campioni (Desarrollador)
//
// Colaboradores:
// David Miranda Zapata
// Mario Ahumada Sandoval
// Werner E. Goedecke R.
// Dario Gomez Candia
// Luis Antonio Gutierrez B.
//---------------------------------------------------------------------------

unit MENU;

interface

uses
  SysUtils, Types, Classes, QGraphics, QControls, QForms, QDialogs,
  QStdCtrls, QMenus, QTypes, IniFiles, QExtCtrls, QcurrEdit, DB, QComCtrls;

type
  TfrmMenu = class(TForm)
    mnuMenu: TMainMenu;
    mnuModulos: TMenuItem;
    mnuActualizador: TMenuItem;
    mnuCompras: TMenuItem;
    mnuDescuentos: TMenuItem;
    mnuVentas: TMenuItem;
    mnuCatalogos: TMenuItem;
    mnuArticulos: TMenuItem;
    mnuCategorias: TMenuItem;
    mnuClientes: TMenuItem;
    mnuDeptos: TMenuItem;
    mnuProveedores: TMenuItem;
    mnuTiposPago: TMenuItem;
    mnuReportes: TMenuItem;
    mnuCatArtRep: TMenuItem;
    mnuRepCatalogos: TMenuItem;
    mnuRepCatCli: TMenuItem;
    mnuRepCompras: TMenuItem;
    mnuCorte: TMenuItem;
    mnuRepCatDeptos: TMenuItem;
    mnuCompFiscal: TMenuItem;
    mnuOperaciones: TMenuItem;
    mnuRepCatProv: TMenuItem;
    mnuRepVentas: TMenuItem;
    mnuConsultas: TMenuItem;
    mnuConsCompras: TMenuItem;
    mnuConsVentas: TMenuItem;
    mnuSeguridad: TMenuItem;
    mnuCambiaPassword: TMenuItem;
    mnuCambiaUsuario: TMenuItem;
    N2: TMenuItem;
    Permisos1: TMenuItem;
    mnuSistema: TMenuItem;
    mnuBaseDato: TMenuItem;
    mnuConfig: TMenuItem;
    N3: TMenuItem;
    mnuEmpresa: TMenuItem;
    N1: TMenuItem;
    mnuInicializar: TMenuItem;
    N4: TMenuItem;
    mnuImportar: TMenuItem;
    mnuExportar: TMenuItem;
    mnuMSalir: TMenuItem;
    mnuSalir: TMenuItem;
    mnuCatArt: TMenuItem;
    mnuCatCli: TMenuItem;
    mnuCatProv: TMenuItem;
    mnuAreasVenta: TMenuItem;
    mnuRepInventario: TMenuItem;
    mnuTicket: TMenuItem;
    mnuReimprimir: TMenuItem;
    pnlAccesos: TPanel;
    Image1: TImage;
    pnlImagen: TPanel;
    imgLogo: TImage;
    Panel2: TPanel;
    mnuRepCatCat: TMenuItem;
    mnuTicketsDia: TMenuItem;
    mnuCajas: TMenuItem;
    mnuRepAjustes: TMenuItem;
    mnuRepPedidos: TMenuItem;
    mnuAyuda: TMenuItem;
    mnuAcercade: TMenuItem;
    mnuXCobrar: TMenuItem;
    mnuXPagar: TMenuItem;
    mnuRepComprobantes: TMenuItem;
    mnuInventarios: TMenuItem;
    mnuGastos: TMenuItem;
    mnuCatGastos: TMenuItem;
    mnuVendedores: TMenuItem;
    mnuCatVendedores: TMenuItem;
    mnuNotasCredito: TMenuItem;
    stbBarra: TStatusBar;
    mnuUnidades: TMenuItem;
    mnuRepUnidades: TMenuItem;
    Existencias1: TMenuItem;
    Retiros1: TMenuItem;
    CFDI1: TMenuItem;
    FacturaGeneral2: TMenuItem;
    CFDIEmitidos1: TMenuItem;
    ConfigCuenta1: TMenuItem;
    procedure mnuSalirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Permisos1Click(Sender: TObject);
    procedure mnuCambiaUsuarioClick(Sender: TObject);
    procedure mnuCambiaPasswordClick(Sender: TObject);
    procedure mnuBaseDatoClick(Sender: TObject);
    procedure mnuDeptosClick(Sender: TObject);
    procedure mnuProveedoresClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure mnuCatArtClick(Sender: TObject);
    procedure mnuCatCliClick(Sender: TObject);
    procedure mnuCatProvClick(Sender: TObject);
    procedure mnuArticulosClick(Sender: TObject);
    procedure mnuEmpresaClick(Sender: TObject);
    procedure mnuActualizadorClick(Sender: TObject);
    procedure mnuClientesClick(Sender: TObject);
    procedure mnuVentasClick(Sender: TObject);
    procedure mnuDescuentosClick(Sender: TObject);
    procedure mnuTiposPagoClick(Sender: TObject);
    procedure mnuAreasVentaClick(Sender: TObject);
    procedure mnuTicketClick(Sender: TObject);
    procedure mnuExportarClick(Sender: TObject);
    procedure mnuCorteClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure mnuInicializarClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure mnuConfigClick(Sender: TObject);
    procedure mnuComprasClick(Sender: TObject);
    procedure mnuConsVentasClick(Sender: TObject);
    procedure mnuImportarClick(Sender: TObject);
    procedure mnuReimprimirClick(Sender: TObject);
    procedure mnuRepCatCatClick(Sender: TObject);
    procedure mnuRepCatDeptosClick(Sender: TObject);
    procedure mnuRepCatCliClick(Sender: TObject);
    procedure mnuRepCatProvClick(Sender: TObject);
    procedure mnuCatArtRepClick(Sender: TObject);
    procedure mnuConsComprasClick(Sender: TObject);
    procedure mnuCompFiscalClick(Sender: TObject);
    procedure mnuRepVentasClick(Sender: TObject);
    procedure mnuOperacionesClick(Sender: TObject);
    procedure mnuRepComprasClick(Sender: TObject);
    procedure mnuTicketsDiaClick(Sender: TObject);
    procedure mnuCajasClick(Sender: TObject);
    procedure mnuRepAjustesClick(Sender: TObject);
    procedure mnuRepPedidosClick(Sender: TObject);
    procedure mnuAcercadeClick(Sender: TObject);
    procedure mnuXCobrarClick(Sender: TObject);
    procedure mnuRepComprobantesClick(Sender: TObject);
    procedure mnuXPagarClick(Sender: TObject);
    procedure mnuInventariosClick(Sender: TObject);
    procedure mnuGastosClick(Sender: TObject);
    procedure mnuCatGastosClick(Sender: TObject);
    procedure mnuVendedoresClick(Sender: TObject);
    procedure mnuCatVendedoresClick(Sender: TObject);
    procedure mnuNotasCreditoClick(Sender: TObject);
    procedure stbBarraClick(Sender: TObject);
    procedure mnuUnidadesClick(Sender: TObject);
    procedure mnuRepUnidadesClick(Sender: TObject);
    procedure Existencias1Click(Sender: TObject);
    procedure Retiros1Click(Sender: TObject);
    procedure FacturaGeneral1Click(Sender: TObject);
    procedure EmisindeCFDI1Click(Sender: TObject);
    procedure FacturaGeneral2Click(Sender: TObject);
    procedure CFDIEmitidos1Click(Sender: TObject);
    procedure ConfigCuenta1Click(Sender: TObject);
  private
    sUsuario, sNombreUsuario, sEmpresa : String;
    iUsuario : integer;
    bEntrada : boolean;

    procedure Menus(bActivar : boolean);
    function ActivaConex:boolean;
    procedure CreaAdmin;
    procedure UsuarioEntra;
    procedure DespliegaEmpresa;
    procedure CreaAreaVenta;
    procedure RecuperaLogo;
    function ConectaBase:boolean;
    procedure CreaTipoPago;
    function VerificaConfig:boolean;
    procedure CreaCaja;
    function VerificaConfigVentas:boolean;
  public

  end;

var
  frmMenu: TfrmMenu;

implementation

uses Acceso, dm, Permisos, Contrasenia, BaseDato, Categorias, Departamentos,
  Proveedores, Articulos, empresa, Actualizador, Clientes, venta,
  Descuentos, Tipospago, AreasVenta, Ticket, AreasVentaBusq, Exportar,
  Corte, Reportesvarios, Inicializar, Config, Compras, Consulventa,
  Importar, Reimprimir, ConsulCompra, ReportesVentas, Fecha, ReportesArticulos,
  ReportesCompras, Cajas, Acercade, XCobrar, XPagar, ReportesComprob, Inventario,
  gastos, Vendedores, NotaCredito, Unidades, fgeneral, datoscfd;

{$R *.xfm}

procedure TfrmMenu.mnuSalirClick(Sender: TObject);
begin
    Close;

end;

procedure TfrmMenu.FormShow(Sender: TObject);
var
    iniArchivo: TIniFile;
begin
    if(ConectaBase) then begin
        mnuCambiaUsuarioClick(Sender);
        if(bEntrada) then begin
            DespliegaEmpresa;
            if(not VerificaConfig) then begin
                Application.MessageBox('Esta es la primera vez que se entra al sistema, ' +
                                           #10 + 'establezca los parámetros iniciales en Sistema->Configuración','Configuración',[smbOk],smsInformation);
                Menus(false);
                mnuConfig.Enabled := true;
                mnuConfig.Visible := true;
            end
        end
        else
            Close;

        iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'config.ini');
        with iniArchivo do
        begin
           if(ReadString('Menu', 'Ventana', '') = 'M') then
           begin
              Top := 0;
              Left := 0;
              Self.WindowState := wsMaximized
           end
           else
              Self.WindowState := wsNormal;
           Free;
        end;
    end;
end;

// -----------------------------------------------------------------
// Funcion: ActivaConex
// Objetivo: Recuperar los datos de conexión a la base de datos y
//           activar o desactivar los menús según el resultado de la
//           conexión
// Regresa: bRegreso (falso o verdadero)
//          falso: si no se conectó a la base de datos
//          verdadero: si se conectó a la base de datos
// -----------------------------------------------------------------
function TfrmMenu.ActivaConex:boolean;
var
    sServidor, sUsuario, sContra, sBase : String;
    bRegreso : boolean;
    iniArchivo : TIniFile;
begin
    bRegreso := false;

    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'config.ini');
    with iniArchivo do begin
        sServidor := ReadString('BaseDato', 'Servidor', '');
        sUsuario := ReadString('BaseDato', 'Usuario', '');
        with TFrmPermisos.Create(Self) do
        try
            sContra := DesEncripta(ReadString('BaseDato', 'Contra', ''));
        finally
            Free;
        end;
        sBase := ReadString('BaseDato', 'Base', '');
        Free;
    end;
    if(Length(sBase) > 0) then begin
        if(not dmDatos.ConectaInter(sServidor, sBase, sUsuario, sContra)) then begin
            Application.MessageBox('No se puede conectar con la base de datos','Error',[smbOK]);
            Menus(false);
            mnuBaseDato.Enabled := true;
            mnuBaseDato.Visible := true;
        end
        else
            bRegreso := true;
    end
    else begin
        Menus(false);
        mnuBaseDato.Enabled := true;
        mnuBaseDato.Visible := true;
    end;
    ActivaConex := bRegreso;
end;

// ------------------------------------------------------------------
// Procedimiento: Menus
// Objetivo: Activar o desactivar los menús
// Parámetros: bActivar (verdadero para activar, falso para desactivar)
// ------------------------------------------------------------------
procedure TfrmMenu.Menus(bActivar : boolean);
var
    i, j: Integer;
begin
    for i:=0 to mnuMenu.Items.Count - 3 do begin
        for j:=0 to mnuMenu.Items[i].Count - 1 do begin
            mnuMenu.Items[i].Items[j].Enabled := bActivar;
            mnuMenu.Items[i].Items[j].Visible := bActivar;
        end;
        mnuMenu.Items[i].Enabled := bActivar;
        mnuMenu.Items[i].Visible := bActivar;
    end;
    mnuSalir.Enabled := true;
    mnuSalir.Visible := true;
    if(not bActivar) then begin
        mnuSistema.Enabled := true;
        mnuSistema.Visible := true;
    end;
end;

// --------------------------------------------------------------------
// Procedimiento: CreaAdmin
// Objetivo: Verifica que exista el usuario ADMIN, si no existe lo crea
// --------------------------------------------------------------------
procedure TfrmMenu.CreaAdmin;
var
    i, j, iInc, iAcceso, iNivel: Integer;
    bCrear : boolean;
    sContra, sClave : String;
begin
    bCrear := false;
    with dmDatos.qryConsulta do begin
        // Busca al usuario Admin
        Close;
        SQL.Clear;
        SQL.Add('SELECT login FROM USUARIOS WHERE login = ''ADMIN''');
        Open;
        if(Eof) then
            bCrear := true;
        Close;
    end;
    if(bCrear) then begin
        with TFrmPermisos.Create(Self) do
        try
            sContra := Encripta('admin');
        finally
            Free;
        end;
        with dmDatos.qryModifica do begin
            // Si no lo encuentra inserta los datos en la tabla usuarios
            Close;
            SQL.Clear;
            SQL.Add('INSERT INTO usuarios (login, contra, nombre,');
            SQL.Add('descuento, fecha_cap, fecha_umov) VALUES(');
            SQL.Add('''ADMIN'',''' + sContra + ''',''ADMINISTRADOR'',0,');
            SQL.Add('''' + FormatDateTime('mm/dd/yyyy hh:nn:ss',Date) + ''',');
            SQL.Add('''' + FormatDateTime('mm/dd/yyyy hh:nn:ss',Date) + ''')');
            ExecSQL;

            Close;
            SQL.Clear;
            SQL.Add('SELECT clave FROM usuarios WHERE login = ''ADMIN''');
            Open;
            sClave := FieldByName('clave').AsString;
            // Revisa cuantas opciones tiene cada menú para insertarlos en la tabla de permisos
            for i := 0 to mnuMenu.Items.Count - 3 do begin
                iInc := 1;
                iAcceso := 0;
                iNivel := 0;
                for j := 0 to mnuMenu.Items[i].Count - 1 do begin
                    if(mnuMenu.Items[i].Items[j].Caption <> '-') then begin
                        iAcceso := iAcceso + iInc;
                        iInc := iInc * 2;
                        Inc(iNivel)
                    end
                end;

                // Inserta en la tabla de permisos las opciones del menu
                Close;
                SQL.Clear;
                SQL.Add('INSERT INTO permisos (usuario, menu, opciones,permiso)');
                SQL.Add('VALUES(' + sClave + ',' + IntToStr(i) + ',');
                SQL.Add(IntToStr(iNivel) + ','+ IntToStr(iAcceso) + ')');
                ExecSQL;
                Close;
            end;
            Close;
        end;
    end;
end;

// -----------------------------------------------------------------------------
// Procedimiento: UsuarioEntra
// Objetivo: Activar o desactivar las opciones del menú segú los permisos del usuario
// -----------------------------------------------------------------------------
procedure TfrmMenu.UsuarioEntra;
var
    i, j, iInc, iSuma, iNivel, iRaya : Integer;
begin
    // Recupera los permisos del usuario en la tabla de permisos y activa o
    // desactiva los menus deacuerdo a los permisos recuperados
    with dmDatos.qryConsulta do begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT * FROM permisos WHERE usuario = ' + IntToStr(iUsuario) + ' ORDER BY menu');
        Open;

        i := 0;
        while(not EOF) do begin
            iSuma := FieldByName('permiso').AsInteger;
            iInc := 1;
            iNivel := FieldByName('opciones').AsInteger;
            for j := 0 to iNivel - 2 do
                iInc := iInc * 2;
            if(FieldByName('permiso').AsInteger = 0) then begin
                mnuMenu.Items[i].Enabled := false;
                mnuMenu.Items[i].Visible := false;
            end
            else begin
                iRaya := 0;
                mnuMenu.Items[i].Enabled := true;
                mnuMenu.Items[i].Visible := true;
                for j := mnuMenu.Items[i].Count - 1 downto 0 do begin
                    if(mnuMenu.Items[i].Items[j].Caption <> '-') then begin
                        if((iInc) > 0) then
                            if((iSuma div iInc) >= 1) then begin
                                mnuMenu.Items[i].Items[j].Enabled := true;
                                mnuMenu.Items[i].Items[j].Visible := true;
                                iSuma := iSuma - iInc;
                            end
                            else begin
                                mnuMenu.Items[i].Items[j].Enabled := false;
                                mnuMenu.Items[i].Items[j].Visible := false;
                            end;
                        iInc := iInc div 2;
                    end
                    else begin
                        if(iRaya <> iSuma) then begin
                            mnuMenu.Items[i].Items[j].Enabled := true;
                            mnuMenu.Items[i].Items[j].Visible := true;
                        end;
                        iRaya := iSuma;
                    end;
                end;
            end;
            Next;
            Inc(i);
        end;
        Close;
    end;
end;

procedure TfrmMenu.Permisos1Click(Sender: TObject);
begin
    with TFrmPermisos.Create(Self) do
    try
        ShowModal;
    finally
        Free;
    end;
    frmMenu.SetFocus;
end;

// -----------------------------------------------------------------
// Procedimiento: DespliegaEmpresa;
// Objetivo: Desplegar el nombre de la empresa en la barra de título
// -----------------------------------------------------------------
procedure TfrmMenu.DespliegaEmpresa;
begin
    //Recupera el nombre de la tabla empresa
    with dmDatos.qryConsulta do begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT nombre FROM empresa');
        Open;

        sEmpresa := Trim(FieldByName('Nombre').AsString);
        Caption := 'Ventas - ' + sEmpresa;
        Close;
    end;
end;

procedure TfrmMenu.mnuCambiaUsuarioClick(Sender: TObject);
begin
    with TFrmAcceso.Create(Self) do
    try
        ShowModal;
        if bAcceso then begin
            // Recupera el nombre del usuario, login y clave de la forma frmAcceso
            Self.sNombreUsuario := sNombreUsuario;
            Self.sUsuario := sUsuario;
            Self.iUsuario := iUsuario;
            stbBarra.Panels.Items[0].Text := 'Usuario: ' + sUsuario;
            UsuarioEntra;
            bEntrada := true;
        end
        else
            bEntrada := false;
    finally
        Free;
    end;
    frmMenu.SetFocus;
end;

procedure TfrmMenu.mnuCambiaPasswordClick(Sender: TObject);
begin
    with TFrmContrasenia.Create(Self) do
    try
        txtUsuario.Text := sUsuario;
        ShowModal;
    finally
        Free;
    end;
    frmMenu.SetFocus;
end;

procedure TfrmMenu.mnuBaseDatoClick(Sender: TObject);
begin
    with TFrmBasedatos.Create(Self) do
    try
        ShowModal;
        if(bAceptar) then
            Self.FormShow(Sender);
    finally
        Free;
    end;
    frmMenu.SetFocus;
end;

procedure TfrmMenu.mnuDeptosClick(Sender: TObject);
begin
    with TFrmDepartamentos.Create(Self) do
    try
        ShowModal;
    finally
        Free;
    end;
    frmMenu.SetFocus;
end;

procedure TfrmMenu.mnuProveedoresClick(Sender: TObject);
begin
    with TfrmProveedores.Create(Self) do
    try
        ShowModal;
    finally
        Free;
    end;
    frmMenu.SetFocus;
end;

procedure TfrmMenu.FormClose(Sender: TObject; var Action: TCloseAction);
var
    iniArchivo: TIniFile;
begin
    dmDatos.DesconectaInter;
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'config.ini');
    with iniArchivo do
    begin
       if(Self.WindowState = wsMaximized) then
          WriteString('Menu', 'Ventana', 'M')
       else
          WriteString('Menu', 'Ventana', 'N');
       Free;
    end;
end;

procedure TfrmMenu.mnuCatArtClick(Sender: TObject);
begin
    with TFrmCategorias.Create(Self) do
    try
        sTipo := 'A';
        ShowModal;
    finally
        Free;
    end;
    frmMenu.SetFocus;
end;

procedure TfrmMenu.mnuCatCliClick(Sender: TObject);
begin
    with TFrmCategorias.Create(Self) do
    try
        sTipo := 'C';
        ShowModal;
    finally
        Free;
    end;
    frmMenu.SetFocus;
end;

procedure TfrmMenu.mnuCatProvClick(Sender: TObject);
begin
    with TFrmCategorias.Create(Self) do
    try
        sTipo := 'P';
        ShowModal;
    finally
        Free;
    end;
    frmMenu.SetFocus;
end;

procedure TfrmMenu.mnuArticulosClick(Sender: TObject);
begin
    with TFrmArticulos.Create(Self) do
    try
        ShowModal;
    finally
        Free;
    end;
    frmMenu.SetFocus;
end;

procedure TfrmMenu.mnuEmpresaClick(Sender: TObject);
begin
    with TFrmEmpresa.Create(Self) do
    try
        ShowModal;
        if (bCambios) then begin
            Self.sEmpresa := sNombre;
            Self.Caption := 'Ventas - ' + Self.sEmpresa;
            RecuperaLogo;
        end;
    finally
        Free;
    end;
    frmMenu.SetFocus;
end;

procedure TfrmMenu.mnuActualizadorClick(Sender: TObject);
begin
    with TFrmActualizador.Create(Self) do
    try
        ShowModal;
    finally
        Free;
    end;
    frmMenu.SetFocus;
end;

procedure TfrmMenu.mnuClientesClick(Sender: TObject);
begin
    with TFrmClientes.Create(Self) do
    try
        sTipo := 'Completo';
        ShowModal;
    finally
        Free;
    end;
    frmMenu.SetFocus;
end;

procedure TfrmMenu.mnuVentasClick(Sender: TObject);
begin
    if(VerificaConfigVentas) then begin
        with TfrmVentas.Create(Self) do
        try
            iUsuario := Self.iUsuario;
            sUsuario := Self.sUsuario;
            ShowModal;
        finally
            Free;
        end;
    end;
    frmMenu.SetFocus;
end;

function TfrmMenu.VerificaConfigVentas:boolean;
var
    iniArchivo : TIniFile;
    sCaja, sArea, sValor : String;
begin
    Result := true;
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'config.ini');

    with iniArchivo do begin
        //Recupera el número de caja
        sValor := ReadString('Config', 'Caja', '');
        if (Length(sValor) > 0) then
            sCaja := sValor
        else
            sCaja := '1';

        //Recupera el área de venta por default
        sValor := ReadString('Config', 'AreaVenta', '');
        if (Length(sValor) > 0) then
            sArea := sValor
        else
            sArea := '1';

        Free;
    end;

    with dmDatos.qryConsulta do begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT * FROM config');
        Open;
        if(Eof) then begin
            Application.MessageBox('No se ha configurado el sistema, hágalo en Sistema->Configuración','Error',[smbOK]);
            Result := false;
        end
        else begin
            Close;
            SQL.Clear;
            SQL.Add('SELECT * FROM cajas WHERE numero = ' + sCaja);
            Open;
            if(Eof) then begin
                Application.MessageBox('Número de caja incorrecto, corríjalo en Sistema->Configuración','Error',[smbOK]);
                Result := false;
            end
            else begin
                Close;
                SQL.Clear;
                SQL.Add('SELECT * FROM areasventa WHERE clave = ' + sArea);
                Open;
                if(Eof) then begin
                    Application.MessageBox('Área de venta incorrecto, corrijalo en Sistema->Configuración','Error',[smbOK]);
                    Result := false;
                end
                else begin
                    Close;
                    SQL.Clear;
                    SQL.Add('SELECT * FROM tipopago');
                    Open;
                    if(Eof) then begin
                      Application.MessageBox('Se requiere al menos un tipo de pago, corríjalo en Catálogos->Tipos de Pago','Error',[smbOK]);
                      Result := false;
                    end
                end
            end
        end;
        Close;
    end;
end;

procedure TfrmMenu.mnuDescuentosClick(Sender: TObject);
begin
    with TfrmDescuentos.Create(Self) do
    try
        ShowModal;
    finally
        Free;
    end;
    frmMenu.SetFocus;
end;

procedure TfrmMenu.mnuTiposPagoClick(Sender: TObject);
begin
    with TFrmTipoPago.Create(Self) do
    try
        ShowModal;
    finally
        Free;
    end;
    frmMenu.SetFocus;
end;

procedure TfrmMenu.mnuAreasVentaClick(Sender: TObject);
begin
    with TFrmAreasVenta.Create(Self) do
    try
        ShowModal;
    finally
        Free;
    end;
    frmMenu.SetFocus;
end;

procedure TfrmMenu.CreaAreaVenta;
begin
    //Recupera el nombre de la tabla empresa
    with dmDatos.qryModifica do begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT clave FROM areasventa');
        Open;

        if(Eof) then begin
            Close;
            SQL.Clear;
            SQL.Add('INSERT INTO areasventa (clave, nombre, caja, fecha_umov) VALUES(1,''CAJA'',');
            SQL.Add('null,''' + FormatDateTime('mm/dd/yyyy hh:nn:ss',Now) + ''')');
            ExecSQL;
        end;
        Close;
    end;
end;

procedure TfrmMenu.CreaCaja;
begin
    with dmDatos.qryModifica do begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT numero FROM cajas');
        Open;

        if(Eof) then begin
            Close;
            SQL.Clear;
            SQL.Add('INSERT INTO cajas (numero, nombre, fecha_umov) VALUES(1,''CAJA 1'',');
            SQL.Add('''' + FormatDateTime('mm/dd/yyyy hh:nn:ss',Now) + ''')');
            ExecSQL;
        end;
        Close;
    end;
end;

procedure TfrmMenu.CreaTipoPago;
begin
    //Recupera el nombre de la tabla empresa
    with dmDatos.qryModifica do begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT clave FROM tipopago');
        Open;

        if(Eof) then begin
            Close;
            SQL.Clear;
            SQL.Add('INSERT INTO tipopago (clave, nombre, abrircajon, referencia, modo, aplica, tipoplazo, fecha_umov)');
            SQL.Add('VALUES(1,''EFECTIVO'',''N'',''N'',''CONTADO'',''CV'',0,''' + FormatDateTime('mm/dd/yyyy hh:nn:ss',Now) + ''')');
            ExecSQL;
        end;
        Close;
    end;
end;

procedure TfrmMenu.mnuTicketClick(Sender: TObject);
begin
    with TFrmTicket.Create(Self) do
    try
        ShowModal;
    finally
        Free;
    end;
    frmMenu.SetFocus;
end;

procedure TfrmMenu.mnuExportarClick(Sender: TObject);
begin
    with TFrmExportar.Create(Self) do
    try
        ShowModal;
    finally
        Free;
    end;
    frmMenu.SetFocus;
end;

procedure TfrmMenu.mnuCorteClick(Sender: TObject);
begin
    with TFrmCorte.Create(Self) do
    try
        iUsuario := Self.iUsuario;
        sUsuario := Self.sUsuario;
        ShowModal;
    finally
        Free;
    end;


    frmMenu.SetFocus;
end;

procedure TfrmMenu.FormCreate(Sender: TObject);
begin
    DateSeparator := '/';
    ShortDateFormat := 'dd/mm/yyyy';
    // DecimalSeparator := ',';
end;

procedure TfrmMenu.mnuInicializarClick(Sender: TObject);
begin
    with TFrmInicializa.Create(Self) do
    try
        ShowModal;
    finally
        Free;
   end;
    frmMenu.SetFocus;
end;

procedure TfrmMenu.RecuperaLogo;
var
    fldCampo : TField;
    stStream : TSTream;
begin
    with dmDatos.qryModifica do begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT logo FROM empresa');
        Open;

        fldCampo := FieldByName('logo');
        stStream := CreateBlobStream(fldCampo, bmRead);
        imgLogo.Picture.Bitmap.LoadFromStream(stStream);
        Close;
    end;
end;

function TfrmMenu.ConectaBase:boolean;
begin
    Menus(false);
    Result := false;
    if(ActivaConex) then begin
        RecuperaLogo;
        // Si no existe el usuario admin, lo crea
        CreaAdmin;
        // Crea una caja en caso de que no existe una
        CreaCaja;
        // Crea una area  en caso de que no existe una
        CreaAreaVenta;
        CreaTipoPago;
        Result := true;
    end;
end;

procedure TfrmMenu.FormResize(Sender: TObject);
begin
    imgLogo.Left := pnlImagen.Width div 2 - 125;
    imgLogo.Top := pnlImagen.Height div 2 - 125;
end;

procedure TfrmMenu.mnuConfigClick(Sender: TObject);
begin
    with TfrmConfig.Create(Self) do
    try
        ShowModal;
    finally
        Free;
    end;
    if(VerificaConfig) then
        UsuarioEntra;
    frmMenu.SetFocus;
end;

procedure TfrmMenu.mnuComprasClick(Sender: TObject);
begin
    with TFrmCompras.Create(Self) do
    try
        iUsuario := Self.iUsuario;
        sEmpresa := Self.sEmpresa;
        ShowModal;
    finally
        Free;
    end;
    frmMenu.SetFocus;
end;

procedure TfrmMenu.mnuConsVentasClick(Sender: TObject);
begin
    with TFrmVentasConsulta.Create(Self) do
    try
        ShowModal;
    finally
        Free;
    end;
    frmMenu.SetFocus;
end;

procedure TfrmMenu.mnuImportarClick(Sender: TObject);
begin
    with TFrmImportar.Create(Self) do
    try
        ShowModal;
    finally
        Free;
    end;
    frmMenu.SetFocus;
end;

procedure TfrmMenu.mnuReimprimirClick(Sender: TObject);
begin
//    with TfrmReimprimir.Create(Self) do
//    try
        frmReimprimir.iUsuario := iUsuario;
        frmReimprimir.ShowModal;
//    finally
//        Free;
//    end;
    frmMenu.SetFocus;
end;

procedure TfrmMenu.mnuRepCatCatClick(Sender: TObject);
begin
    with TfrmReportesVarios.Create(Self) do
    try
        ImprimeCateg;
    finally
        Free;
    end;
    frmMenu.SetFocus;
end;

procedure TfrmMenu.mnuRepCatDeptosClick(Sender: TObject);
begin
    with TfrmReportesVarios.Create(Self) do
    try
        ImprimeDeptos;
    finally
        Free;
    end;
    frmMenu.SetFocus;
end;

procedure TfrmMenu.mnuRepCatCliClick(Sender: TObject);
begin
    with TfrmReportesVarios.Create(Self) do
    try
        ImprimeClientes;
    finally
        Free;
    end;
    frmMenu.SetFocus;
end;

procedure TfrmMenu.mnuRepCatProvClick(Sender: TObject);
begin
    with TfrmReportesVarios.Create(Self) do
    try
        ImprimeProveedores;
    finally
        Free;
    end;
    frmMenu.SetFocus;
end;

procedure TfrmMenu.mnuCatArtRepClick(Sender: TObject);
begin
    with TfrmReportesArticulos.Create(Self) do
    try
        ShowModal;
    finally
        Free;
    end;
    frmMenu.SetFocus;
end;

procedure TfrmMenu.mnuConsComprasClick(Sender: TObject);
begin
    with TfrmConsulCompra.Create(Self) do
    try
        ShowModal;
    finally
        Free;
    end;
    frmMenu.SetFocus;
end;

procedure TfrmMenu.mnuCompFiscalClick(Sender: TObject);
begin
    with TfrmFecha.Create(Self) do
    try
        sTitulo := 'Comprobanción Fiscal';
        if(ShowModal = mrOk) then
            with TfrmReportesVarios.Create(Self) do
            try
                ImprimeCompFiscal(txtMes.Text + '/' + txtDia.Text + '/' + txtAnio.Text);
            finally
                Free;
            end;
    finally
        Free;
    end;
    frmMenu.SetFocus;
end;

procedure TfrmMenu.mnuRepVentasClick(Sender: TObject);
begin
    with TfrmReportesVentas.Create(Self) do
    try
        ShowModal;
    finally
        Free;
    end;
    frmMenu.SetFocus;
end;

procedure TfrmMenu.mnuOperacionesClick(Sender: TObject);
begin
    with TfrmFecha.Create(Self) do
    try
        sTitulo := 'Operaciones del día';
        if(ShowModal = mrOk) then
            with TfrmReportesVarios.Create(Self) do
            try
                ImprimeOperaciones(txtMes.Text + '/' + txtDia.Text + '/' + txtAnio.Text);
            finally
                Free;
            end;
    finally
        Free;
    end;
    frmMenu.SetFocus;
end;

procedure TfrmMenu.mnuRepComprasClick(Sender: TObject);
begin
    with TfrmReportesCompras.Create(Self) do
    try
        ShowModal;
    finally
        Free;
    end;
    frmMenu.SetFocus;
end;

procedure TfrmMenu.mnuTicketsDiaClick(Sender: TObject);
begin
    with TfrmFecha.Create(Self) do
    try
        sTitulo := 'Impresión de tickets del día';
        if(ShowModal = mrOk) then
            with TfrmReportesVarios.Create(Self) do
            try
                ImprimeTicketsDelDia(txtMes.Text + '/' + txtDia.Text + '/' + txtAnio.Text);
            finally
                Free;
            end;
    finally
        Free;
    end;
    frmMenu.SetFocus;
end;


procedure TfrmMenu.mnuCajasClick(Sender: TObject);
begin
    with TfrmCajas.Create(Self) do
    try
        ShowModal;
    finally
        Free;
    end;
    frmMenu.SetFocus;
end;


procedure TfrmMenu.mnuRepAjustesClick(Sender: TObject);
begin
    with TfrmReportesVarios.Create(Self) do
    try
        ImprimeAjuste;
    finally
        Free;
    end;
    frmMenu.SetFocus;
end;

procedure TfrmMenu.mnuRepPedidosClick(Sender: TObject);
begin
    with TfrmReportesVarios.Create(Self) do
    try
        ImprimePedidos;
    finally
        Free;
    end;
    frmMenu.SetFocus;
end;

procedure TfrmMenu.mnuAcercadeClick(Sender: TObject);
begin
    with TfrmAcercaDe.Create(Self) do
    try
        ShowModal;
    finally
        Free;
    end;
    frmMenu.SetFocus;
end;

function TfrmMenu.VerificaConfig:boolean;
begin
    with dmDatos.qryModifica do begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT monedamenor FROM config');
        Open;

        if(Eof) then
            Result := false
        else
            Result := true;
        Close;
    end;
end;

procedure TfrmMenu.mnuXCobrarClick(Sender: TObject);
begin
    with TfrmXCobrar.Create(Self) do
    try
        ShowModal;
    finally
        Free;
    end;
    frmMenu.SetFocus;
end;

procedure TfrmMenu.mnuXPagarClick(Sender: TObject);
begin
    with TfrmXPagar.Create(Self) do
    try
        ShowModal;
    finally
        Free;
    end;
    frmMenu.SetFocus;
end;

procedure TfrmMenu.mnuRepComprobantesClick(Sender: TObject);
begin
    with TfrmReportesComprob.Create(Self) do
    try
        ShowModal;
    finally
        Free;
    end;
    frmMenu.SetFocus;
end;

procedure TfrmMenu.mnuInventariosClick(Sender: TObject);
begin
    with TfrmInventario.Create(Self) do
    try
        ShowModal;
    finally
        Free;
    end;
    frmMenu.SetFocus;
end;

procedure TfrmMenu.mnuGastosClick(Sender: TObject);
begin
    with TfrmGastos.Create(Self) do
    try
        ShowModal;
    finally
        Free;
    end;
    frmMenu.SetFocus;
end;

procedure TfrmMenu.mnuCatGastosClick(Sender: TObject);
begin
    with TFrmCategorias.Create(Self) do
    try
        sTipo := 'G';
        ShowModal;
    finally
        Free;
    end;
    frmMenu.SetFocus;
end;

procedure TfrmMenu.mnuVendedoresClick(Sender: TObject);
begin
    with TFrmVendedores.Create(Self) do
    try
        ShowModal;
    finally
        Free;
    end;
    frmMenu.SetFocus;
end;

procedure TfrmMenu.mnuCatVendedoresClick(Sender: TObject);
begin
    with TFrmCategorias.Create(Self) do
    try
        sTipo := 'V';
        ShowModal;
    finally
        Free;
    end;
    frmMenu.SetFocus;
end;

procedure TfrmMenu.mnuNotasCreditoClick(Sender: TObject);
begin
    with TFrmNotaCredito.Create(Self) do
    try
        sTipo := 'Captura';
        ShowModal;
    finally
        Free;
    end;
    frmMenu.SetFocus;
end;

procedure TfrmMenu.stbBarraClick(Sender: TObject);
begin
    if mnuCambiaUsuario.Enabled then
        mnuCambiaUsuario.Click;
end;

procedure TfrmMenu.mnuUnidadesClick(Sender: TObject);
begin
    with TFrmUnidades.Create(Self) do
    try
        ShowModal;
    finally
        Free;
    end;
    frmMenu.SetFocus;
end;

procedure TfrmMenu.mnuRepUnidadesClick(Sender: TObject);
begin
    with TfrmReportesVarios.Create(Self) do
    try
        ImprimeUnidades;
    finally
        Free;
    end;
    frmMenu.SetFocus;
end;

procedure TfrmMenu.Existencias1Click(Sender: TObject);
begin
  with TfrmReportesVarios.Create(Self) do
    try
        ImprimeExistencias;
    finally
        Free;
    end;
    frmMenu.SetFocus;
end;

procedure TfrmMenu.Retiros1Click(Sender: TObject);
begin
 with TfrmFecha.Create(Self) do
    try
        sTitulo := 'Impresión de Retiros del día';
        if(ShowModal = mrOk) then
            with TfrmReportesVarios.Create(Self) do
            try
                ImprimeRetirosGeneral(txtMes.Text + '/' + txtDia.Text + '/' + txtAnio.Text);
            finally
                Free;
            end;
    finally
        Free;
    end;
    frmMenu.SetFocus;
end;

procedure TfrmMenu.FacturaGeneral1Click(Sender: TObject);
begin
with Tfacgeneral.Create(Self) do
    try
        ShowModal;
    finally
        Free;
    end;
    frmMenu.SetFocus;

end;

procedure TfrmMenu.EmisindeCFDI1Click(Sender: TObject);
begin

with TfrmFecha.Create(Self) do
    try
        sTitulo := 'Operaciones del día';
        al.Visible := true;
        edit2.Visible:=true;
        edit1.Visible:=true;
        edit3.Visible:=true;
        label1.Visible:=true;
        label2.Visible:=true;
        if(ShowModal = mrOk) then
            with TfrmReportesVarios.Create(Self) do
            try
                ImprimeCFDIS(txtMes.Text + '/' + txtDia.Text + '/' + txtAnio.Text, edit1.Text + '/' + edit2.Text + '/' + edit3.Text );
            finally
                Free;
            end;
    finally
        Free;
    end;
    frmMenu.SetFocus;

end;

procedure TfrmMenu.FacturaGeneral2Click(Sender: TObject);
begin
with Tfacgeneral.Create(Self) do
    try
        ShowModal;
    finally
        Free;
    end;
    frmMenu.SetFocus;

end;

procedure TfrmMenu.CFDIEmitidos1Click(Sender: TObject);
begin
with TfrmFecha.Create(Self) do
    try
        sTitulo := 'Operaciones del día';
        al.Visible := true;
        edit2.Visible:=true;
        edit1.Visible:=true;
        edit3.Visible:=true;
        label1.Visible:=true;
        label2.Visible:=true;


        if(ShowModal = mrOk) then
            with TfrmReportesVarios.Create(Self) do
            try
                ImprimeCFDIS(txtMes.Text + '/' + txtDia.Text + '/' + txtAnio.Text, edit1.Text + '/' + edit2.Text + '/' + edit3.Text );
            finally
                Free;
            end;
    finally
        Free;
    end;
    frmMenu.SetFocus;

end;

procedure TfrmMenu.ConfigCuenta1Click(Sender: TObject);
begin
with Tdcfd.Create(Self) do
    try
        ShowModal;
    finally
        Free;
    end;
    frmMenu.SetFocus;
end;

end.
