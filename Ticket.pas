// --------------------------------------------------------------------------
// Archivo del Proyecto Ventas
// P�gina del proyecto: http://sourceforge.net/projects/ventas
// --------------------------------------------------------------------------
// Este archivo puede ser distribuido y/o modificado bajo lo terminos de la
// Licencia P�blica General versi�n 2 como es publicada por la Free Software
// Fundation, Inc.
// --------------------------------------------------------------------------

unit Ticket;

interface

uses
  SysUtils, Types, Classes, QGraphics, QControls, QForms, QDialogs,
  QStdCtrls, IniFiles, QButtons;

type
  TfrmTicket = class(TForm)
    memFinal: TMemo;
    btnCancelar: TBitBtn;
    btnGuardar: TBitBtn;
    btnIzq: TBitBtn;
    btnCent: TBitBtn;
    btnDer: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    memCabecera: TMemo;
    grpVariables: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    procedure FormShow(Sender: TObject);
    procedure btnGuardarClick(Sender: TObject);
    procedure btnIzqClick(Sender: TObject);
    procedure btnDerClick(Sender: TObject);
    procedure btnCentClick(Sender: TObject);
    procedure memCabeceraExit(Sender: TObject);
    procedure memFinalExit(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    sUltimoFoco : String;
    procedure Alinea(sModo:String);
    function  AlineaIzq(sCadena : String):String;
    function  AlineaDer(sCadena : String):String;
    function  AlineaCentro(sCadena : String):String;

    procedure RecuperaConfig;
  public
    { Public declarations }
  end;

var
  frmTicket: TfrmTicket;

implementation

uses dm;

{$R *.xfm}

procedure TfrmTicket.FormShow(Sender: TObject);
begin
    with dmDatos.qryModifica do begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT nivel, renglon, texto FROM ticket ORDER BY nivel, renglon');
        Active := true;
        memCabecera.Clear;
        memFinal.Clear;
        while not (EOF) do begin
            if(FieldByName('nivel').AsInteger = 1) then
                memCabecera.Lines.Add(FieldByName('texto').AsString)
            else
                memFinal.Lines.Add(FieldByName('texto').AsString);
            Next;
        end;
        Close;
    end;
end;

procedure TfrmTicket.btnGuardarClick(Sender: TObject);
var
    sTexto : String;
    i : Integer;
begin
    with dmDatos.qryModifica do begin
        if(memCabecera.GetTextLen = 0) then begin
            Application.MessageBox('Introduce los datos del encabezado del ticket','Error',[smbOK],smsCritical);
            memCabecera.SetFocus;
        end else begin
            Close;
            SQL.Clear;
            SQL.Add('DELETE FROM ticket');
            ExecSQL;
            Close;
            for i := 0 to memCabecera.Lines.Count - 1 do begin
                if(Length(memCabecera.Lines.Strings[i]) > 0) then
                    sTexto := memCabecera.Lines.Strings[i]
                else
                    sTexto := ' ';
                Close;
                SQL.Clear;
                SQL.Add('INSERT INTO ticket (nivel, renglon, texto) VALUES( ');
                SQL.Add('1,' + IntToStr(i) + ',''' + sTexto + ''')');
                ExecSQL;
                Close;
            end;

            for i := 0 to memFinal.Lines.Count - 1 do begin
                if(Length(memFinal.Lines.Strings[i]) > 0) then
                    sTexto := memFinal.Lines.Strings[i]
                else
                    sTexto := ' ';

                Close;
                SQL.Clear;
                SQL.Add('INSERT INTO ticket (nivel, renglon, texto) VALUES( ');
                SQL.Add('2,' + IntToStr(i) + ',''' + sTexto + ''')');
                ExecSQL;
                Close;
            end;
            application.MessageBox('Los datos se guardaron con exito','Aviso');
            Close;
        end;
    end;
end;

procedure TfrmTicket.btnIzqClick(Sender: TObject);
begin
    Alinea('IZQUIERDA');
end;

procedure TfrmTicket.Alinea(sModo:String);
var
    i, iLineas, iCant, iCantIni, iInicio, iFin : integer;
    memAlinear :TMemo;
begin
    if(sUltimoFoco = 'Cabecera') then
        memAlinear := memCabecera
    else
        memAlinear := memFinal;
    iCant := -1;
    iLineas := memAlinear.Lines.Count;
    iInicio := memAlinear.SelStart;
    if(memAlinear.SelLength > 0) then
        iFin := iInicio + memAlinear.SelLength-1
    else
        iFin := iInicio;
    for i:= 0 to iLineas - 1 do begin
        iCantIni := iCant + 1;
        iCant := iCantIni + Length(memAlinear.Lines[i]) + 1;
        if(iInicio >= iCantIni) and (iInicio < iCant) then
            iInicio := iCantIni;
        if(iFin >= iCantIni) and (iFin <= iCant) then
            iFin := iCant;
        if(iCant >= iInicio) and (iCant <= iFin) then begin
            if(sModo = 'IZQUIERDA') then
                memAlinear.Lines[i] := AlineaIzq(memAlinear.Lines[i]);
            if(sModo = 'CENTRO') then
                memAlinear.Lines[i] := AlineaCentro(memAlinear.Lines[i]);
            if(sModo = 'DERECHA') then
                memAlinear.Lines[i] := AlineaDer(memAlinear.Lines[i]);
        end;
    end;
end;

function TfrmTicket.AlineaCentro(sCadena : String):String;
var
    iPos, i : integer;
    sEspacios : String;
begin
    sCadena := Trim(sCadena);
    iPos := 19 - (Length(sCadena)) div 2 ;
    for i:= 0 to iPos do
        sEspacios := sEspacios + ' ';
    result := sEspacios + sCadena;
end;

function TfrmTicket.AlineaIzq(sCadena : String):String;
begin
    sCadena := Trim(sCadena);
    result := sCadena;
end;

function TfrmTicket.AlineaDer(sCadena : String):String;
var
    iPos, i : integer;
    sEspacios : String;
begin
    sCadena := Trim(sCadena);
    iPos := 39 - (Length(sCadena));
    for i:= 0 to iPos do
        sEspacios := sEspacios + ' ';
    result := sEspacios + sCadena;
end;

procedure TfrmTicket.btnDerClick(Sender: TObject);
begin
    Alinea('DERECHA');
end;

procedure TfrmTicket.btnCentClick(Sender: TObject);
begin
    Alinea('CENTRO');
end;

procedure TfrmTicket.memCabeceraExit(Sender: TObject);
begin
    sUltimoFoco := 'Cabecera';
end;

procedure TfrmTicket.memFinalExit(Sender: TObject);
begin
    sUltimoFoco := 'Final'  ;
end;

procedure TfrmTicket.btnCancelarClick(Sender: TObject);
begin
    Close;
end;

procedure TfrmTicket.RecuperaConfig;
var
    iniArchivo : TIniFile;
    sIzq, sArriba : String;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) +'config.ini');

    with iniArchivo do begin
        //Recupera la posici�n Y de la ventana
        sArriba := ReadString('Ticket', 'Posy', '');

        //Recupera la posici�n X de la ventana
        sIzq := ReadString('Ticket', 'Posx', '');

        if (Length(sIzq) > 0) and (Length(sArriba) > 0) then begin
            Left := StrToInt(sIzq);
            Top := StrToInt(sArriba);
        end;
    end;
end;

procedure TfrmTicket.FormClose(Sender: TObject; var Action: TCloseAction);
  var iniArchivo : TIniFile;
begin
    dmDatos.qryListados1.Close;
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) +'config.ini');
    with iniArchivo do begin
        // Registra la posici�n y de la ventana
        WriteString('Ticket', 'Posy', IntToStr(Top));

        // Registra la posici�n X de la ventana
        WriteString('Ticket', 'Posx', IntToStr(Left));

        Free;
    end;
end;

procedure TfrmTicket.FormCreate(Sender: TObject);
begin
    RecuperaConfig;
end;

end.
