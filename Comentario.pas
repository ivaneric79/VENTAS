// --------------------------------------------------------------------------
// Archivo del Proyecto Ventas
// P�gina del proyecto: http://sourceforge.net/projects/ventas
// --------------------------------------------------------------------------
// Este archivo puede ser distribuido y/o modificado bajo lo terminos de la
// Licencia P�blica General versi�n 2 como es publicada por la Free Software
// Fundation, Inc.
// --------------------------------------------------------------------------

unit Comentario;

interface

uses
  SysUtils, Types, Classes, Variants, QTypes, QGraphics, QControls, QForms,
  QDialogs, QStdCtrls, QButtons, IniFiles;

type
  TfrmComentario = class(TForm)
    memComentario: TMemo;
    btnAceptar: TBitBtn;
    btnCancelar: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    procedure RecuperaConfig;
  public
    { Public declarations }
  end;

var
  frmComentario: TfrmComentario;

implementation

{$R *.xfm}

procedure TfrmComentario.FormShow(Sender: TObject);
begin
    RecuperaConfig;
end;

procedure TfrmComentario.RecuperaConfig;
var
    iniArchivo : TIniFile;
    sIzq, sArriba : String;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'config.ini');

    with iniArchivo do begin
        //Recupera la posici�n Y de la ventana
        sArriba := ReadString('Comentarios', 'Posy', '');

        //Recupera la posici�n X de la ventana
        sIzq := ReadString('Comentarios', 'Posx', '');
        if (Length(sIzq) > 0) and (Length(sArriba) > 0) then begin
            Left := StrToInt(sIzq);
            Top := StrToInt(sArriba);
        end;

        Free;
    end;
end;

procedure TfrmComentario.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
     iniArchivo : TIniFile;
begin

    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'config.ini');
    with iniArchivo do begin
        // Registra la posici�n y de la ventana
        WriteString('Comentarios', 'Posy', IntToStr(Top));

        // Registra la posici�n X de la ventana
        WriteString('Comentarios', 'Posx', IntToStr(Left));

        Free;
    end;
end;

end.
