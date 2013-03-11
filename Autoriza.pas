// --------------------------------------------------------------------------
// Archivo del Proyecto Ventas
// Página del proyecto: http://sourceforge.net/projects/ventas
// --------------------------------------------------------------------------
// Este archivo puede ser distribuido y/o modificado bajo lo terminos de la
// Licencia Pública General versión 2 como es publicada por la Free Software
// Fundation, Inc.
// --------------------------------------------------------------------------

unit Autoriza;

interface

uses
  SysUtils, Types, Classes, QGraphics, QControls, QForms, QDialogs,
  QStdCtrls, QButtons, Inifiles;

type
  TfrmAutoriza = class(TForm)
    grpAcceso: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    txtUsuario: TEdit;
    txtContra: TEdit;
    btnAceptar: TBitBtn;
    btnCancelar: TBitBtn;
    memComentario: TMemo;
    Label3: TLabel;
    procedure btnAceptarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Salta(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
  private
    sNombreAutoriza, sNomUsuario : String;

    procedure GuardaBitacora;
    function VerificaUsuario : boolean;
    procedure RecuperaConfig;
  public
    bAutorizacion : boolean;
    sUsuarioAutoriza, sTipoAutoriza, sMensaje : String;
    iUsuario : integer;

    function VerificaAutoriza(iUsuario : integer; sTipo : String) : boolean;
  end;

var
  frmAutoriza: TfrmAutoriza;

implementation

uses Permisos, dm;

{$R *.xfm}

procedure TfrmAutoriza.btnAceptarClick(Sender: TObject);
begin
    if(VerificaUsuario) then begin
        bAutorizacion := true;
        GuardaBitacora;
        Close;
    end;
end;

procedure TfrmAutoriza.GuardaBitacora;
var
    iArch : integer;
    szBuffer: array[0..300] of Char;
    sArchivo, sDatos : String;
begin
    sArchivo := ExtractFilePath(ParamStr(0))+'bitacora.txt';
    if(not FileExists(sArchivo)) then
        iArch := FileCreate(sArchivo)
    else
        iArch := FileOpen(sArchivo,fmOpenReadWrite);

    FileSeek(iArch, 0, 2);
    sDatos := 'Fecha: ' + FormatDateTime('dd/mm/yyyy hh:nn:ss',Now) + ', ';
    sDatos := sDatos + 'Autorización: ' + sNombreAutoriza + ', Detalle: ' + sMensaje;
    sDatos := sDatos + ', Usuario: ' + sNomUsuario;
    sDatos := sDatos + ', Comentario: ' + memComentario.Text +#13+#10;
    StrPCopy(szBuffer,sDatos);
    FileWrite(iArch, szBuffer,Length(sDatos));

    FileClose(iArch);
end;

function TfrmAutoriza.VerificaUsuario : boolean;
var
    bAcceso : boolean;
    sContra : String;
begin
    bAcceso := true;
    with dmDatos.qryConsulta do begin
        // Busca el usuario especificado
        Close;
        SQL.Clear;
        SQL.Add('SELECT * FROM usuarios WHERE login = ''' + txtUsuario.Text + '''');
        Open;

        if(not Eof) then begin
            sContra := Trim(FieldByName('contra').AsString);
            with TFrmPermisos.Create(Self) do
            try
                sContra := DesEncripta(sContra);
            finally
                Free;
            end;

            if sContra = txtContra.Text then begin
                sUsuarioAutoriza := FieldByName('clave').AsString;
                sNomUsuario := Trim(FieldByName('nombre').AsString);

                Close;
                SQL.Clear;
                SQL.Add('SELECT * FROM privilegios WHERE usuario = ' + sUsuarioAutoriza);
                SQL.Add('AND clave = ''' + sTipoAutoriza + '''');
                Open;

                if(Eof) then begin
                    Application.MessageBox('No se cuenta con los privilegios suficientes','Error',[smbOK]);
                    txtUsuario.SetFocus;
                    txtUsuario.SelectAll;
                    bAcceso := false;
                end;
            end
            else begin
                Application.MessageBox('Contraseña o nombre de usuario incorrecto','Error',[smbOK]);
                txtContra.SetFocus;
                txtContra.SelectAll;
                bAcceso := false;
            end;
        end
        else begin
            Application.MessageBox('Usuario no registrado','Error',[smbOK]);
            txtUsuario.SetFocus;
            txtUsuario.SelectAll;
            bAcceso := false;
        end;
        Close;
    end;
    Result := bAcceso;
end;

function TfrmAutoriza.VerificaAutoriza(iUsuario : integer; sTipo : String) : boolean;
begin
    with dmDatos.qryConsulta do begin
        // Busca el usuario especificado
        Close;
        SQL.Clear;
        SQL.Add('SELECT * FROM privilegios WHERE usuario = ' + IntToStr(iUsuario));
        SQL.Add('AND clave = ''' + sTipo + '''');
        Open;

        if(not Eof) then
            bAutorizacion := true
        else
            bAutorizacion := false;
    end;
    Result := bAutorizacion;
end;


procedure TfrmAutoriza.FormShow(Sender: TObject);
begin
    bAutorizacion := false;
    with TFrmPermisos.Create(Self) do
    try
        sNombreAutoriza := BuscaAutoriza(sTipoAutoriza);
    finally
        Free;
    end;
    Caption := 'Autorización - ' + sNombreAutoriza;
    txtContra.Clear;
    if(Length(txtUsuario.Text) = 0) then
        txtUsuario.SetFocus
    else
        txtContra.SetFocus;
end;

procedure TfrmAutoriza.RecuperaConfig;
var
    iniArchivo : TIniFile;
    sIzq, sArriba : String;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'config.ini');

    with iniArchivo do begin
        //Recupera la posición Y de la ventana
        sArriba := ReadString('Autoriza', 'Posy', '');

        //Recupera la posición X de la ventana
        sIzq := ReadString('Autoriza', 'Posx', '');

        if (Length(sIzq) > 0) and (Length(sArriba) > 0) then begin
            Left := StrToInt(sIzq);
            Top := StrToInt(sArriba);
        end;

        Free;
    end;
end;

procedure TfrmAutoriza.FormClose(Sender: TObject; var Action: TCloseAction);
  var iniArchivo : TIniFile;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'config.ini');
    with iniArchivo do begin
        // Registra la posición y de la ventana
        WriteString('Autoriza', 'Posy', IntToStr(Top));

        // Registra la posición X de la ventana
        WriteString('Autoriza', 'Posx', IntToStr(Left));

        Free;
    end;
end;

procedure TfrmAutoriza.Salta(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    {Inicio (36), Fin (35), Izquierda (37), derecha (39), arriba (38), abajo (40)}
    if(Key >= 30) and (Key <= 122) and (Key <> 35) and (Key <> 36) and not ((Key >= 37) and (Key <= 40)) then
        if( Length((Sender as TEdit).Text) = (Sender as TEdit).MaxLength) then
            SelectNext(Sender as TWidgetControl, true, true);
end;

procedure TfrmAutoriza.FormCreate(Sender: TObject);
begin
    RecuperaConfig;
end;

end.
