// --------------------------------------------------------------------------
// Archivo del Proyecto Ventas
// Página del proyecto: http://sourceforge.net/projects/ventas
// --------------------------------------------------------------------------
// Este archivo puede ser distribuido y/o modificado bajo lo terminos de la
// Licencia Pública General versión 2 como es publicada por la Free Software
// Fundation, Inc.
// --------------------------------------------------------------------------

unit Fecha;

interface

uses
  SysUtils, Types, Classes, QGraphics, QControls, QForms, QDialogs,
  QStdCtrls, QButtons, IniFiles;

type
  TfrmFecha = class(TForm)
    grpFecha: TGroupBox;
    Label29: TLabel;
    txtDia: TEdit;
    txtMes: TEdit;
    txtAnio: TEdit;
    Label30: TLabel;
    Label31: TLabel;
    btnAceptar: TBitBtn;
    btnCancelar: TBitBtn;
    al: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    procedure btnAceptarClick(Sender: TObject);
    procedure Salta(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Rellena(Sender: TObject);
    procedure txtAnioExit(Sender: TObject);
  private
    function VerificaFechas(sFecha : string):boolean;
    procedure RecuperaConfig;
    procedure RecuperaFecha;
  public
    sTitulo : String;
    dteFecha : TDateTime;
  end;

var
  frmFecha: TfrmFecha;

implementation

uses Reportesvarios;

{$R *.xfm}

procedure TfrmFecha.btnAceptarClick(Sender: TObject);
begin
    if(VerificaFechas(txtDia.Text + '/' + txtMes.Text + '/' + txtAnio.Text)) then begin
        dteFecha := StrToDate(txtDia.Text + '/' + txtMes.Text + '/' + txtAnio.Text);
        ModalResult := mrOk;
    end
    else begin
        Application.MessageBox('Introduce una fecha correcta','Error',[smbOK],smsCritical);
        txtDia.SetFocus;
    end;
end;

function TfrmFecha.VerificaFechas(sFecha : string):boolean;
var
   dteFecha : TDateTime;
begin
    Result:= true;
    if(not TryStrToDate(sFecha,dteFecha)) then
        Result := false;
end;

procedure TfrmFecha.Salta(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    {Inicio (36), Fin (35), Izquierda (37), derecha (39), arriba (38), abajo (40)}
    if(Key >= 30) and (Key <= 122) and (Key <> 35) and (Key <> 36) and not ((Key >= 37) and (Key <= 40)) then
        if( Length((Sender as TEdit).Text) = (Sender as TEdit).MaxLength) then
            SelectNext(Sender as TWidgetControl, true, true);
end;

procedure TfrmFecha.FormShow(Sender: TObject);
begin
    Caption := sTitulo;
    RecuperaFecha;
    txtDia.SetFocus;
    txtDia.SelectAll;
end;

procedure TfrmFecha.FormCreate(Sender: TObject);
begin
    RecuperaConfig;
end;

procedure TfrmFecha.RecuperaConfig;
var
    iniArchivo : TIniFile;
    sIzq, sArriba : String;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'config.ini');

    with iniArchivo do begin
        //Recupera la posición Y de la ventana
        sArriba := ReadString('Fecha', 'Posy', '');

        //Recupera la posición X de la ventana
        sIzq := ReadString('Fecha', 'Posx', '');

        if (Length(sIzq) > 0) and (Length(sArriba) > 0) then begin
            Left := StrToInt(sIzq);
            Top := StrToInt(sArriba);
        end;
    end;
end;

procedure TfrmFecha.RecuperaFecha;
var
    iniArchivo : TIniFile;
    sValor: String;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'config.ini');

    with iniArchivo do begin
        //Recupera la fecha dependiendo del título
        sValor := ReadString('Fecha', sTitulo, '');

        if (Length(sValor) > 0) then begin
            txtDia.Text := Copy(sValor,1,2);
            txtMes.Text := Copy(sValor,3,2);
            txtAnio.Text := Copy(sValor,5,4);
        end;

        Free;
    end;
end;

procedure TfrmFecha.FormClose(Sender: TObject; var Action: TCloseAction);
var
    iniArchivo : TIniFile;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'config.ini');

    with iniArchivo do begin
        // Registra la posición y de la ventana
        WriteString('Fecha', 'Posy', IntToStr(Top));

        // Registra la posición X de la ventana
        WriteString('Fecha', 'Posx', IntToStr(Left));

        // Registra la fecha dependiendo del titulo
        WriteString('Fecha', sTitulo, txtDia.Text + txtMes.Text + txtAnio.Text);

        Free;
    end;
end;

procedure TfrmFecha.Rellena(Sender: TObject);
var
    i : integer;
begin
    for i := Length((Sender as TEdit).Text) to (Sender as TEdit).MaxLength - 1 do
        (Sender as TEdit).Text := '0' + (Sender as TEdit).Text;
end;

procedure TfrmFecha.txtAnioExit(Sender: TObject);
begin
    txtAnio.Text := Trim(txtAnio.Text);
    if(Length(txtAnio.Text) < 4) and (Length(txtAnio.Text) > 0) then
        txtAnio.Text := IntToStr(StrToInt(txtAnio.Text) + 2000);
end;

end.
