unit datoscfd;

interface

uses
  SysUtils, Types, Classes, Variants, QTypes, QGraphics, QControls, QForms, 
  QDialogs, QStdCtrls,IniFiles, QButtons ;

type
  Tdcfd = class(TForm)
    rfc: TEdit;
    usuario: TEdit;
    password: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure BitBtn2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dcfd: Tdcfd;

implementation

{$R *.xfm}

procedure Tdcfd.BitBtn2Click(Sender: TObject);
var
iniArchivo : TIniFile;
begin
iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'config.ini');
 with iniArchivo do begin
    WriteString('CFDI', 'RFC', rfc.Text);
        WriteString('CFDI', 'CUENTA', usuario.Text);
        WriteString('CFDI', 'PASSWORD', password.Text);
        free;
        end;

        close;

end;

procedure Tdcfd.FormCreate(Sender: TObject);
var
iniArchivo : TIniFile;
    sValor : String;
begin
   iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'config.ini');
    with iniArchivo do begin
    sValor := ReadString('CFDI', 'RFC', '');
         if (Length(sValor) > 0) then
            rfc.Text := sValor;
                 sValor := ReadString('CFDI', 'CUENTA', '');
         if (Length(sValor) > 0) then
            usuario.Text := sValor;
             sValor := ReadString('CFDI', 'PASSWORD', '');
         if (Length(sValor) > 0) then
            password.Text := sValor;
              Free;
            end;
end;

end.
