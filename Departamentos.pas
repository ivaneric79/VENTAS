// --------------------------------------------------------------------------
// Archivo del Proyecto Ventas
// Página del proyecto: http://sourceforge.net/projects/ventas
// --------------------------------------------------------------------------
// Este archivo puede ser distribuido y/o modificado bajo lo terminos de la
// Licencia Pública General versión 2 como es publicada por la Free Software
// Fundation, Inc.
// --------------------------------------------------------------------------

unit Departamentos;

interface

uses
  SysUtils, Types, Classes, QGraphics, QControls, QForms, QDialogs,
  QStdCtrls, QGrids, QDBGrids, QExtCtrls, QComCtrls, QButtons, QMenus,
  QTypes, Inifiles, QcurrEdit;

type
  TfrmDepartamentos = class(TForm)
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
    grpDepartamento: TGroupBox;
    Label1: TLabel;
    txtNombre: TEdit;
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
    function VerificaIntegridad:boolean;
    procedure GuardaDatos;
    procedure RecuperaConfig;
    procedure RecuperaDatos;
    procedure Listar;
  public
  end;

var
  frmDepartamentos: TfrmDepartamentos;

implementation

uses dm;

{$R *.xfm}

procedure TfrmDepartamentos.btnInsertarClick(Sender: TObject);
begin
    LimpiaDatos;
    sModo := 'Insertar';
    Height := 300;
    ActivaControles;
    txtNombre.SetFocus;
end;

procedure TfrmDepartamentos.LimpiaDatos;
begin
    txtNombre.Clear;
end;

procedure TfrmDepartamentos.ActivaControles;
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


        txtNombre.ReadOnly := false;
        txtNombre.TabStop := true;
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

        txtNombre.ReadOnly := true;
        txtNombre.TabStop := false;
    end;
end;

procedure TfrmDepartamentos.btnEliminarClick(Sender: TObject);
begin
    if(Application.MessageBox('Se eliminará el departamento seleccionado','Eliminar',[smbOK]+[smbCancel]) = smbOK) then begin
        with dmDatos.qryModifica do begin
            Close;
            SQL.Clear;
            SQL.Add('DELETE FROM departamentos WHERE clave = ' + dmDatos.cdsCliente.FieldByName('clave').AsString);
            ExecSQL;
            Close;
        end;
        btnCancelarClick(Sender);
    end;
end;

procedure TfrmDepartamentos.btnCancelarClick(Sender: TObject);
begin
    sModo := 'Consulta';
    LimpiaDatos;
    Listar;
    ActivaControles;
    Height := 224;
    btnInsertar.SetFocus;
end;

procedure TfrmDepartamentos.btnGuardarClick(Sender: TObject);
begin
    if(VerificaDatos) then begin
        GuardaDatos;
        btnCancelarClick(Sender);
    end;
end;

function TfrmDepartamentos.VerificaDatos:boolean;
var
    bRegreso : boolean;
begin
    bRegreso := true;
    if(Length(txtNombre.Text) = 0) then begin
        Application.MessageBox('Introduce el nombre del departamento','Error',[smbOK],smsCritical);
        txtNombre.SetFocus;
        bRegreso := false;
    end
    else if(not VerificaIntegridad) then
        bRegreso := false;

    Result := bRegreso;
end;

function TfrmDepartamentos.VerificaIntegridad:boolean;
var
    bRegreso : boolean;
begin
    bRegreso := true;

    with dmDatos.qryConsulta do begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT * FROM departamentos WHERE nombre = ''' + txtNombre.Text + '''');
        Open;

        if(not Eof) and ((sModo = 'Insertar') or
            ((FieldByName('clave').AsInteger <> iClave) and
            (sModo = 'Modificar'))) then begin
            bRegreso := false;
            Application.MessageBox('El departamento ya existe','Error',[smbOK],smsCritical);
            txtNombre.SetFocus;
        end;
        Close;
    end;
    Result := bRegreso;
end;

procedure TfrmDepartamentos.GuardaDatos;
begin
    if(sModo = 'Insertar') then begin
        with dmDatos.qryModifica do begin
            Close;
            SQL.Clear;
            SQL.Add('INSERT INTO departamentos (nombre, fecha_umov) VALUES(');
            SQL.Add('''' + txtNombre.Text + ''',');
            SQL.Add(''''+ FormatDateTime('mm/dd/yyyy hh:nn:ss',Now) + ''')');
            ExecSQL;
            Close;
        end;
    end
    else begin
        with dmDatos.qryModifica do begin
            Close;
            SQL.Clear;
            SQL.Add('UPDATE departamentos SET nombre = ''' + txtNombre.Text + ''',');
            SQL.Add('fecha_umov = ''' + FormatDateTime('mm/dd/yyyy hh:nn:ss',Now) + '''');
            SQL.Add('WHERE clave = ' + IntToStr(iClave));
            ExecSQL;
            Close;
        end;
    end;
end;

procedure TfrmDepartamentos.btnModificarClick(Sender: TObject);
begin
    if(txtRegistros.Value > 0) then begin
        sModo := 'Modificar';
        RecuperaDatos;
        ActivaControles;
        Height := 300;
        txtNombre.SetFocus;
    end;
end;

procedure TfrmDepartamentos.FormShow(Sender: TObject);
begin
    btnCancelarClick(Sender);
end;

procedure TfrmDepartamentos.RecuperaConfig;
var
    iniArchivo : TIniFile;
    sIzq, sArriba : String;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) +'config.ini');

    with iniArchivo do begin
        //Recupera la posición Y de la ventana
        sArriba := ReadString('Departamentos', 'Posy', '');

        //Recupera la posición X de la ventana
        sIzq := ReadString('Departamentos', 'Posx', '');

        if (Length(sIzq) > 0) and (Length(sArriba) > 0) then begin
            Left := StrToInt(sIzq);
            Top := StrToInt(sArriba);
        end;
        Free;
    end;
end;

procedure TfrmDepartamentos.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
    iniArchivo : TIniFile;
begin
    dmDatos.cdsCliente.Active := false;
    dmDatos.qryListados.Close;
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) +'config.ini');
    with iniArchivo do begin
        // Registra la posición y de la ventana
        WriteString('Departamentos', 'Posy', IntToStr(Top));

        // Registra la posición X de la ventana
        WriteString('Departamentos', 'Posx', IntToStr(Left));
        Free;
    end;
end;

procedure TfrmDepartamentos.RecuperaDatos;
begin
    with dmDatos.cdsCliente do begin
        if(Active) then begin
            iClave := FieldByName('Clave').AsInteger;
            txtNombre.Text := Trim(FieldByName('nombre').AsString);
        end;
    end;
end;

procedure TfrmDepartamentos.Listar;
var
    sBM : String;
begin
    with dmDatos.qryListados do begin
        sBM := dmDatos.cdsCliente.Bookmark;

        dmDatos.cdsCliente.Active := false;
        Close;
        SQL.Clear;
        SQL.Add('SELECT clave, nombre FROM departamentos ORDER BY nombre');
        Open;
        dmDatos.cdsCliente.Active := true;

        dmDatos.cdsCliente.FieldByName('clave').Visible := false;
        dmDatos.cdsCliente.FieldByName('nombre').DisplayLabel := 'Departamento';
        txtRegistros.Value := dmDatos.cdsCliente.RecordCount;
        try
            dmDatos.cdsCliente.Bookmark := sBM;
        except
            txtRegistros.Value := txtRegistros.Value;
        end;
    end;
    RecuperaDatos;
end;

procedure TfrmDepartamentos.Salir1Click(Sender: TObject);
begin
    Close;
end;

procedure TfrmDepartamentos.mnuAvanzaClick(Sender: TObject);
begin
    dmDatos.cdsCliente.Next;
end;

procedure TfrmDepartamentos.mnuRetrocedeClick(Sender: TObject);
begin
    dmDatos.cdsCliente.Prior;
end;

procedure TfrmDepartamentos.Salta(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    {Inicio (36), Fin (35), Izquierda (37), derecha (39), arriba (38), abajo (40)}
    if(Key >= 30) and (Key <= 122) and (Key <> 35) and (Key <> 36) and not ((Key >= 37) and (Key <= 40)) then
        if( Length((Sender as TEdit).Text) = (Sender as TEdit).MaxLength) then
            SelectNext(Sender as TWidgetControl, true, true);
end;

procedure TfrmDepartamentos.FormCreate(Sender: TObject);
begin
    RecuperaConfig;
end;

end.
