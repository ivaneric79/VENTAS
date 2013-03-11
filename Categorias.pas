// --------------------------------------------------------------------------
// Archivo del Proyecto Ventas
// Página del proyecto: http://sourceforge.net/projects/ventas
// --------------------------------------------------------------------------
// Este archivo puede ser distribuido y/o modificado bajo lo terminos de la
// Licencia Pública General versión 2 como es publicada por la Free Software
// Fundation, Inc.
// --------------------------------------------------------------------------

unit Categorias;

interface

uses
  SysUtils, Types, Classes, QGraphics, QControls, QForms, QDialogs,
  QStdCtrls, QGrids, QDBGrids, QExtCtrls, QComCtrls, QButtons, QMenus,
  QTypes, Inifiles, QcurrEdit;

type
  TfrmCategorias = class(TForm)
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
    btnInsertar: TBitBtn;
    btnEliminar: TBitBtn;
    btnModificar: TBitBtn;
    btnGuardar: TBitBtn;
    btnCancelar: TBitBtn;
    gddListado: TDBGrid;
    lblRegistros: TLabel;
    txtRegistros: TcurrEdit;
    grpCategoria: TGroupBox;
    Label1: TLabel;
    txtCategoria: TEdit;
    Label2: TLabel;
    txtClave: TEdit;
    procedure btnInsertarClick(Sender: TObject);
    procedure btnEliminarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnGuardarClick(Sender: TObject);
    procedure btnModificarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Salir1Click(Sender: TObject);
    procedure mnuAvanzaClick(Sender: TObject);
    procedure mnuRetrocedeClick(Sender: TObject);
    procedure Salta(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
  private
    sModo : String;
    iClave : integer;

    procedure LimpiaDatos;
    procedure ActivaControles;
    function VerificaDatos:boolean;
    function VerificaCategoria:boolean;
    procedure GuardaDatos;
    procedure RecuperaConfig;
    procedure RecuperaDatos;
    procedure Listar;
  public
    sTipo : String;
  end;

var
  frmCategorias: TfrmCategorias;

implementation

uses dm;

{$R *.xfm}

procedure TfrmCategorias.btnInsertarClick(Sender: TObject);
begin
    LimpiaDatos;
    sModo := 'Insertar';
    Height := 300;
    ActivaControles;
    txtCategoria.SetFocus;
end;

procedure TfrmCategorias.LimpiaDatos;
begin
    txtCategoria.Clear;
end;

procedure TfrmCategorias.ActivaControles;
begin
    if( (sModo = 'Insertar') or (sModo = 'Modificar') ) then begin
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


        txtCategoria.ReadOnly := false;
        txtCategoria.TabStop := true;
    end;
    if(sModo = 'Consulta') then begin
        btnInsertar.Enabled := true;
        mnuInsertar.Enabled := true;
        if(txtRegistros.Value > 0) then begin
            btnModificar.Enabled := true;
            btnEliminar.Enabled := true;
            mnuModificar.Enabled := true;
            mnuEliminar.Enabled := true;
        end
        else begin
            btnModificar.Enabled := false;
            btnEliminar.Enabled := false;
            mnuModificar.Enabled := false;
            mnuEliminar.Enabled := false;
        end;

        btnGuardar.Enabled := false;
        btnCancelar.Enabled := false;
        mnuGuardar.Enabled := false;
        mnuCancelar.Enabled := false;

        mnuConsulta.Enabled := true;

        txtCategoria.ReadOnly := true;
        txtCategoria.TabStop := false;
    end;
end;

procedure TfrmCategorias.btnEliminarClick(Sender: TObject);
begin
    if(Application.MessageBox('Se eliminará la categoría seleccionada','Eliminar',[smbOK]+[smbCancel],smsWarning) = smbOK) then begin
        with dmDatos.qryModifica do begin
            Close;
            SQL.Clear;
            SQL.Add('DELETE FROM categorias WHERE clave = ' + dmDatos.cdsCliente.FieldByName('clave').AsString);
            ExecSQL;
            Close;
        end;
        btnCancelarClick(Sender);
    end;
end;

procedure TfrmCategorias.btnCancelarClick(Sender: TObject);
begin
    sModo := 'Consulta';
    LimpiaDatos;
    Listar;
    ActivaControles;
    Height := 224;
    btnInsertar.SetFocus;
end;

procedure TfrmCategorias.btnGuardarClick(Sender: TObject);
begin
    if(VerificaDatos) then begin
        GuardaDatos;
        btnCancelarClick(Sender);
    end;
end;

function TfrmCategorias.VerificaDatos:boolean;
var
    bRegreso : boolean;
begin
    bRegreso := true;
    if(Length(txtCategoria.Text) = 0) then begin
        Application.MessageBox('Introduce el nombre de la categoría','Error',[smbOK],smsCritical);
        txtCategoria.SetFocus;
        bRegreso := false;
    end
    else if(not VerificaCategoria) then
        bRegreso := false;

    Result := bRegreso;
end;

function TfrmCategorias.VerificaCategoria:boolean;
var
    bRegreso : boolean;
begin
    bRegreso := true;

    with dmDatos.qryConsulta do begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT * FROM categorias WHERE nombre = ''' + txtCategoria.Text + ''' AND tipo = ''' + sTipo + '''');
        Open;

        if(not Eof) and ((sModo = 'Insertar') or
            ((FieldByName('clave').AsInteger <> iClave) and
            (sModo = 'Modificar'))) then begin
            bRegreso := false;
            Application.MessageBox('La categoría ya existe','Error',[smbOK],smsCritical);
            txtCategoria.SetFocus;
        end;
        Close;
    end;
    Result := bRegreso;
end;

procedure TfrmCategorias.GuardaDatos;
begin
    if(sModo = 'Insertar') then begin
        with dmDatos.qryModifica do begin
            Close;
            SQL.Clear;
            SQL.Add('INSERT INTO categorias (nombre, fecha_umov, tipo, cuenta) VALUES(');
            SQL.Add('''' + txtCategoria.Text + ''','''+ FormatDateTime('mm/dd/yyyy',Date) + ''',');
            SQL.Add('''' + sTipo + ''',''' + txtClave.Text + ''')');
            ExecSQL;
            Close;
        end;
    end
    else begin
        with dmDatos.qryModifica do begin
            Close;
            SQL.Clear;
            SQL.Add('UPDATE categorias SET nombre = ''' + txtCategoria.Text + ''',');
            SQL.Add('cuenta = ''' + txtClave.Text + ''',');
            SQL.Add('fecha_umov = ''' + FormatDateTime('mm/dd/yyyy',Date) + '''');
            SQL.Add('WHERE clave = ' + IntToStr(iClave));
            ExecSQL;
            Close;
        end;
    end;
end;

procedure TfrmCategorias.btnModificarClick(Sender: TObject);
begin
    if(txtRegistros.Value > 0) then begin
        sModo := 'Modificar';
        RecuperaDatos;
        ActivaControles;
        Height := 300;
        txtCategoria.SetFocus;
    end;
end;

procedure TfrmCategorias.FormShow(Sender: TObject);
begin
    if(sTipo = 'A') then
        Caption := 'Categorías (artículos)'
    else if(sTipo = 'C') then
        Caption := 'Categorías (clientes)'
    else if(sTipo = 'P') then
        Caption := 'Categorías (proveedores)'
    else if(sTipo = 'G') then
        Caption := 'Categorías (gastos)'
     else if(sTipo = 'V') then
        Caption := 'Categorías (vendedores)';
    btnCancelarClick(Sender);
end;

procedure TfrmCategorias.RecuperaConfig;
var
    iniArchivo : TIniFile;
    sIzq, sArriba : String;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) +'config.ini');

    with iniArchivo do begin
        //Recupera la posición Y de la ventana
        sArriba := ReadString('Categorias', 'Posy', '');

        //Recupera la posición X de la ventana
        sIzq := ReadString('Categorias', 'Posx', '');

        if (Length(sIzq) > 0) and (Length(sArriba) > 0) then begin
            Left := StrToInt(sIzq);
            Top := StrToInt(sArriba);
        end;
        Free;
    end;
end;

procedure TfrmCategorias.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
    iniArchivo : TIniFile;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) +'config.ini');
    with iniArchivo do begin
        // Registra la posición y de la ventana
        WriteString('Categorias', 'Posy', IntToStr(Top));

        // Registra la posición X de la ventana
        WriteString('Categorias', 'Posx', IntToStr(Left));
        Free;
    end;
    dmDatos.qryConsulta.Close;
    dmDatos.cdsCliente.Active := false; 
end;

procedure TfrmCategorias.RecuperaDatos;
begin
    with dmDatos.cdsCliente do begin
        if(Active) then begin
            iClave := FieldByName('Clave').AsInteger;
            txtCategoria.Text := Trim(FieldByName('nombre').AsString);
            txtClave.text:= Trim(FieldByName('cuenta').AsString);
        end;
    end;
end;

procedure TfrmCategorias.Listar;
var
    sBM : String;
begin
    with dmDatos.qryListados do begin
        sBM := dmDatos.cdsCliente.Bookmark;

        dmDatos.cdsCliente.Active := false; 
        Close;
        SQL.Clear;
        SQL.Add('SELECT clave, cuenta, nombre FROM categorias WHERE tipo = ''' + sTipo + ''' ORDER BY nombre');
        Open;
        dmDatos.cdsCliente.Active := true;

        dmDatos.cdsCliente.FieldByName('clave').Visible := false;
        dmDatos.cdsCliente.FieldByName('cuenta').DisplayLabel := 'Clave';
        dmDatos.cdsCliente.FieldByName('cuenta').DisplayWidth := 5;
        dmDatos.cdsCliente.FieldByName('nombre').DisplayLabel := 'Categoría';
        dmDatos.cdsCliente.FieldByName('nombre').DisplayWidth := 20;
        txtRegistros.Value := dmDatos.cdsCliente.RecordCount;
        try
            dmDatos.cdsCliente.Bookmark := sBM;
        except
            txtRegistros.Value := txtRegistros.Value;
        end;
    end;
    RecuperaDatos;
end;

procedure TfrmCategorias.Salir1Click(Sender: TObject);
begin
    Close;
end;

procedure TfrmCategorias.mnuAvanzaClick(Sender: TObject);
begin
    dmDatos.cdsCliente.Next;
end;

procedure TfrmCategorias.mnuRetrocedeClick(Sender: TObject);
begin
    dmDatos.cdsCliente.Prior;
end;

procedure TfrmCategorias.Salta(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    {Inicio (36), Fin (35), Izquierda (37), derecha (39), arriba (38), abajo (40)}
    if(Key >= 30) and (Key <= 122) and (Key <> 35) and (Key <> 36) and not ((Key >= 37) and (Key <= 40)) then
        if( Length((Sender as TEdit).Text) = (Sender as TEdit).MaxLength) then
            SelectNext(Sender as TWidgetControl, true, true);
end;

procedure TfrmCategorias.FormCreate(Sender: TObject);
begin
    RecuperaConfig;
end;

end.
