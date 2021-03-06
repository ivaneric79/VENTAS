// --------------------------------------------------------------------------
// Archivo del Proyecto Ventas 
// P�gina del proyecto: http://sourceforge.net/projects/ventas
// --------------------------------------------------------------------------
// Este archivo puede ser distribuido y/o modificado bajo lo terminos de la
// Licencia P�blica General versi�n 2 como es publicada por la Free Software
// Fundation, Inc.
// --------------------------------------------------------------------------

unit AcercaDe;

interface

uses
  SysUtils, Types, Classes, QGraphics, QControls, QForms, QDialogs,
  QStdCtrls, QExtCtrls, QComCtrls, IniFiles, ShellApi, Windows;

type
  TfrmAcercaDe = class(TForm)
    grpTitulo: TGroupBox;
    Label8: TLabel;
    Label9: TLabel;
    pnlAceptar: TPanel;
    btnAceptar: TButton;
    Image2: TImage;
    procedure btnAceptarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure RecuperaConfig;
    procedure FormShow(Sender: TObject);
    procedure Label5Click(Sender: TObject);
    procedure Label5MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Label5MouseLeave(Sender: TObject);
    procedure Label4Click(Sender: TObject);
    procedure Label4MouseLeave(Sender: TObject);
    procedure Label4MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

const
  URL_VENTAS = 'http://ventas.sourceforge.net';
  URL_SSINF = 'http://ssinf.com.mx';

var
  frmAcercaDe: TfrmAcercaDe;

implementation

{$R *.xfm}

procedure TfrmAcercaDe.btnAceptarClick(Sender: TObject);
begin
    Close;
end;

procedure TfrmAcercaDe.FormClose(Sender: TObject; var Action: TCloseAction);
var
    iniArchivo : TIniFile;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'config.ini');
    with iniArchivo do begin
      // Registra la posici�n y de la ventana
      WriteString('Acercade', 'Posy', IntToStr(Top));

      // Registra la posici�n X de la ventana
      WriteString('Acercade', 'Posx', IntToStr(Left));

      Free;
    end;
end;

procedure TfrmAcercaDe.RecuperaConfig;
var
    iniArchivo : TIniFile;
    sIzq, sArriba : String;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'config.ini');
    with iniArchivo do begin
      //Recupera la posici�n Y de la ventana
      sArriba := ReadString('Acercade', 'Posy', '');

      //Recupera la posici�n X de la ventana
      sIzq := ReadString('Acercade', 'Posx', '');

      if (Length(sIzq) > 0) and (Length(sArriba) > 0) then begin
        Left := StrToInt(sIzq);
        Top := StrToInt(sArriba);
      end;
      Free;
    end;
end;

procedure TfrmAcercaDe.FormShow(Sender: TObject);
begin
    RecuperaConfig;
end;

procedure TfrmAcercaDe.Label5Click(Sender: TObject);
var
    szUrlVentas: array[0..255] of char;
begin
  //  Label5.Cursor := crHourGlass;
  //  StrPCopy(szUrlVentas, URL_VENTAS);
  //  {$IFDEF LINUX}
  //      Libc.system(PChar('konqueror "' + URL_VENTAS + '"&'));
  //  {$ENDIF}
   // {$IFDEF MSWINDOWS}
    //  ShellExecute(0, 'open', szUrlVentas, nil, nil, SW_SHOWNORMAL);
    //{$ENDIF}
end;

procedure TfrmAcercaDe.Label5MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
   // Label5.Cursor := crHandPoint;
   // Label5.Font.Style := [fsUnderline];
end;

procedure TfrmAcercaDe.Label5MouseLeave(Sender: TObject);
begin
//    Label5.Font.Style := [];
end;

procedure TfrmAcercaDe.Label4Click(Sender: TObject);
var
    szUrlSSI: array[0..255] of char;
begin
//    Label5.Cursor := crHourGlass;
//    StrPCopy(szUrlSSI, URL_SSINF);
//    {$IFDEF LINUX}
//        Libc.system(PChar('konqueror "' + URL_VENTAS + '"&'));
//    {$ENDIF}
//    {$IFDEF MSWINDOWS}
//        ShellExecute(0, 'open', szUrlSSI, nil, nil, SW_SHOWNORMAL);
//    {$ENDIF}
end;

procedure TfrmAcercaDe.Label4MouseLeave(Sender: TObject);
begin
//    Label4.Font.Style := [];
end;

procedure TfrmAcercaDe.Label4MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
//    Label4.Cursor := crHandPoint;
//    Label4.Font.Style := [fsUnderline];
end;

end.
