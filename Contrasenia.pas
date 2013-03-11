// --------------------------------------------------------------------------
// Archivo del Proyecto Ventas
// P�gina del proyecto: http://sourceforge.net/projects/ventas
// --------------------------------------------------------------------------
// Este archivo puede ser distribuido y/o modificado bajo lo terminos de la
// Licencia P�blica General versi�n 2 como es publicada por la Free Software
// Fundation, Inc.
// --------------------------------------------------------------------------

unit Contrasenia;

interface

uses
  SysUtils, Types, Classes, QGraphics, QControls, QForms, QDialogs,
  QStdCtrls, QButtons, Inifiles;

type
  TfrmContrasenia = class(TForm)
    grpContrasenias: TGroupBox;
    Label1: TLabel;
    txtUsuario: TEdit;
    txtContra: TEdit;
    txtContraNueva: TEdit;
    Label4: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    txtContraRepite: TEdit;
    btnAceptar: TBitBtn;
    btnCancelar: TBitBtn;
    procedure btnAceptarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Salta(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure RecuperaConfig;
    procedure FormCreate(Sender: TObject);
  private
    function VerificaDatos:boolean;
    function VerificaContra:boolean;
  public
  end;

var
  frmContrasenia: TfrmContrasenia;

implementation

uses Permisos, dm;

{$R *.xfm}

procedure TfrmContrasenia.btnAceptarClick(Sender: TObject);
var
    sContra : String;
begin
    if VerificaDatos then begin
        sContra := frmPermisos.Encripta(txtContraNueva.Text);
        with dmDatos.qryModifica do begin
            Close;
            SQL.Clear;
            SQL.Add('UPDATE usuarios SET contra = ''' + sContra + ''',');
            SQL.Add('fecha_umov = ''' + FormatDateTime('mm/dd/yyyy hh:nn:ss',Now) + '''');
            SQL.Add('WHERE login = ''' + txtUsuario.Text + '''');
            ExecSQL;
            Close;
        end;
        Application.MessageBox('La contrase�a se ha cambiado con �xito','Aviso',[smbOK],smsInformation);
        Close;
    end;
end;

procedure TfrmContrasenia.FormShow(Sender: TObject);
begin
    txtContra.Clear;
    txtContraNueva.Clear;
    txtContraRepite.Clear;
    txtContra.SetFocus;
end;

// -----------------------------------------------------------------------------
// Funci�n: VerificaDatos
// Objetivo: Verificar que se introduzcan datos en los campos requeridos
//           y que no exista alg�n error en la captura de los datos
// Regresa: bVerifica (falso o verdadero)
//          Falso: si existe un error en la captura de los datos
//          Verdadero: si todos los datos est�n correctos
// -----------------------------------------------------------------------------
function TfrmContrasenia.VerificaDatos:boolean;
var
    bVerifica : Boolean;
begin
    bVerifica := True;
    if(Length(txtContra.Text) = 0) then begin
        txtContra.SetFocus;
        Application.MessageBox('Introduce la contrase�a','Error',[smbOK],smsCritical);
        bVerifica := False;
    end
    else if not VerificaContra then begin
        txtContra.SetFocus;
        Application.MessageBox('La contrase�a no es correcta','Error',[smbOK],smsCritical);
        bVerifica := False;
    end
    else if(Length(txtContraNueva.Text) = 0) then begin
        txtContraNueva.SetFocus;
        Application.MessageBox('Introduce la nueva contrase�a','Error',[smbOK],smsCritical);
        bVerifica := False;
    end
    else if(Length(txtContraRepite.Text) = 0) then begin
        txtContraRepite.SetFocus;
        Application.MessageBox('Repite la contrase�a','Error',[smbOK],smsCritical);
        bVerifica := False;
    end
    else if(Length(txtContraNueva.Text) < 6) then begin
        txtContraNueva.SetFocus;
        Application.MessageBox('La contrase�a debe de ser de al menos 6 caracteres','Error',[smbOK],smsCritical);
        bVerifica := False;
    end
    else if(txtContraNueva.Text <> txtContraRepite.Text) then begin
        txtContraNueva.SetFocus;
        Application.MessageBox('Las contrase�as no coinciden','Error',[smbOK],smsCritical);
        bVerifica := False;
    end;
    VerificaDatos := bVerifica;
end;

// -----------------------------------------------------------------------------
// Funci�n: VerificaContra
// Objetivo: Verificar que la contrase�a introducida sea igual a la registrada en
//           la base de datos
// Regresa: bVerifica (falso o verdadero)
//          Falso: si no es correcta
//          Verdadero: si es correcta
// -----------------------------------------------------------------------------
function TfrmContrasenia.VerificaContra:boolean;
var
    bRegreso : boolean;
begin
    bRegreso := true;
    with dmDatos.qryConsulta do begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT * FROM usuarios WHERE login = ''' + txtUsuario.Text + '''');
        Open;

        if frmPermisos.DesEncripta(Trim(FieldByName('contra').AsString)) <> txtContra.Text then
            bRegreso := false;
        Close;
    end;
    Result := bRegreso;
end;

procedure TfrmContrasenia.Salta(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    {Inicio (36), Fin (35), Izquierda (37), derecha (39), arriba (38), abajo (40)}
    if(Key >= 30) and (Key <= 122) and (Key <> 35) and (Key <> 36) and not ((Key >= 37) and (Key <= 40)) then
        if( Length((Sender as TEdit).Text) = (Sender as TEdit).MaxLength) then
            SelectNext(Sender as TWidgetControl, true, true);
end;

procedure TfrmContrasenia.FormClose(Sender: TObject;
  var Action: TCloseAction);
  var iniArchivo : TIniFile;
begin

    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) +'config.ini');
    with iniArchivo do begin
        // Registra la posici�n y de la ventana
        WriteString('Contrase�a', 'Posy', IntToStr(Top));

        // Registra la posici�n X de la ventana
        WriteString('Contrase�a', 'Posx', IntToStr(Left));

        Free;
    end;
end;
procedure TfrmContrasenia.RecuperaConfig;
var
    iniArchivo : TIniFile;
    sIzq, sArriba: String;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) +'config.ini');

    with iniArchivo do begin
        //Recupera la posici�n Y de la ventana
        sArriba := ReadString('Contrase�a', 'Posy', '');

        //Recupera la posici�n X de la ventana
        sIzq := ReadString('Contrase�a', 'Posx', '');

        if (Length(sIzq) > 0) and (Length(sArriba) > 0) then begin
            Left := StrToInt(sIzq);
            Top := StrToInt(sArriba);
        end;

        Free;
    end;
end;

procedure TfrmContrasenia.FormCreate(Sender: TObject);
begin
    RecuperaConfig;
end;

end.
