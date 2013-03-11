// --------------------------------------------------------------------------
// Archivo del Proyecto Ventas
// Página del proyecto: http://sourceforge.net/projects/ventas
// --------------------------------------------------------------------------
// Este archivo puede ser distribuido y/o modificado bajo lo terminos de la
// Licencia Pública General versión 2 como es publicada por la Free Software
// Fundation, Inc.
// --------------------------------------------------------------------------

unit Acceso;

interface

uses
  SysUtils, Types, Classes, QGraphics, QControls, QForms, QDialogs,
  QStdCtrls, QButtons, IniFiles;

type
  TfrmAcceso = class(TForm)
    grpAcceso: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    txtUsuario: TEdit;
    txtContra: TEdit;
    btnAceptar: TBitBtn;
    btnCancelar: TBitBtn;
    chkRecordar: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure btnAceptarClick(Sender: TObject);
    procedure Salta(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure txtUsuarioKeyPress(Sender: TObject; var Key: Char);
  private
    procedure RecuperaConfig;
    function VerificaDatos: Boolean;
  public
    bAcceso : boolean;
    sNombreUsuario, sUsuario : String;
    iUsuario : integer;
  end;

var
  frmAcceso: TfrmAcceso;

implementation

uses dm, Permisos, Funciones;

{$R *.xfm}

procedure TfrmAcceso.FormShow(Sender: TObject);
begin
    RecuperaConfig;

    bAcceso := false;
    txtContra.Clear;
    if(Length(txtUsuario.Text) > 0) then
        txtContra.SetFocus
    else
        txtUsuario.SetFocus;
end;

procedure TfrmAcceso.btnAceptarClick(Sender: TObject);
var
    sContraDes : String;
begin
    if(not VerificaDatos) then
      Exit;

    with dmDatos.qryConsulta do begin
        // Busca el usuario especificado
        Close;
        SQL.Clear;
        SQL.Add('SELECT * FROM usuarios WHERE login = ''' + txtUsuario.Text + '''');
        Open;

        if (not Eof) then begin
            with TFrmPermisos.Create(Self) do
            try
                sContraDes := DesEncripta(Trim(FieldByName('contra').AsString));
            finally
                free;
            end;

            // Compara la contraseña escrita con la registrada en la tabla de usuarios
            if(sContraDes = txtContra.Text) then begin
                sUsuario := txtUsuario.Text;
                iUsuario := FieldByName('clave').AsInteger;
                sNombreUsuario := FieldByName('nombre').AsString;
                bAcceso := true;
                Close;
                Self.Close;
            end
            else begin
                Application.MessageBox('Contraseña incorrecta','Error',[smbOK]);
                txtContra.SetFocus;
                txtContra.SelectAll;
            end;
        end
        else begin
            Application.MessageBox('Usuario no registrado','Error',[smbOK]);
            txtUsuario.SetFocus;
            txtUsuario.SelectAll;
        end;
        Close;
    end;
end;

function TfrmAcceso.VerificaDatos: Boolean;
begin
    Result := True;
    if(Length(txtUsuario.Text) =  0) then
    begin
      Application.MessageBox('Introduzca el usuario', 'Error', [smbOK], smsWarning);
      txtUsuario.SetFocus;      
      Result := False;
    end
    else
    if(Length(txtContra.Text) =  0) then
    begin
      Application.MessageBox('Introduzca su contraseña', 'Error', [smbOK], smsWarning);
      txtContra.SetFocus;
      Result := False;
    end
    else
end;

procedure TfrmAcceso.Salta(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
    {Inicio (36), Fin (35), Izquierda (37), derecha (39), arriba (38), abajo (40)}
    if(Key >= 30) and (Key <= 122) and (Key <> 35) and (Key <> 36) and not ((Key >= 37) and (Key <= 40)) then
        if( Length((Sender as TEdit).Text) = (Sender as TEdit).MaxLength) then
            SelectNext(Sender as TWidgetControl, true, true);
end;

procedure TfrmAcceso.FormClose(Sender: TObject; var Action: TCloseAction);
var
     iniArchivo : TIniFile;
begin

    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'config.ini');
    with iniArchivo do begin
        // Registra la posición y de la ventana
        WriteString('Acceso', 'Posy', IntToStr(Top));

        // Registra la posición X de la ventana
        WriteString('Acceso', 'Posx', IntToStr(Left));

        if(chkRecordar.Checked) then begin
            WriteString('Acceso', 'Recordar', 'S');
            WriteString('Acceso', 'Usuario', txtUsuario.Text);
        end
        else begin
            WriteString('Acceso', 'Recordar', 'N');
            WriteString('Acceso', 'Usuario', '');
        end;
        Free;
    end;
end;

procedure TfrmAcceso.RecuperaConfig;
var
    iniArchivo : TIniFile;
    sIzq, sArriba, sValor : String;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'config.ini');

    with iniArchivo do begin
        //Recupera la posición Y de la ventana
        sArriba := ReadString('Acceso', 'Posy', '');

        //Recupera la posición X de la ventana
        sIzq := ReadString('Acceso', 'Posx', '');
        if (Length(sIzq) > 0) and (Length(sArriba) > 0) then begin
            Left := StrToInt(sIzq);
            Top := StrToInt(sArriba);
        end;

        //Recupera el ultimo usuario que accedio
        sValor := ReadString('Acceso', 'Recordar', '');
        if (sValor = 'S') then begin
            chkRecordar.Checked := true;
            txtUsuario.Text := RemoverCaracteresEsp(ReadString('Acceso', 'Usuario', ''));
        end
        else
            chkRecordar.Checked := false;

        Free;
    end;
end;

procedure TfrmAcceso.txtUsuarioKeyPress(Sender: TObject; var Key: Char);
begin
   if (not (Key in ['A'..'Z', '0'..'9', #8, #9, #13])) then
      Key:= #0;
end;

end.
