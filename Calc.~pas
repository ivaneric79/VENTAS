// --------------------------------------------------------------------------
// Archivo del Proyecto Ventas
// Página del proyecto: http://sourceforge.net/projects/ventas
// --------------------------------------------------------------------------
// Este archivo puede ser distribuido y/o modificado bajo lo terminos de la
// Licencia Pública General versión 2 como es publicada por la Free Software
// Fundation, Inc.
// --------------------------------------------------------------------------

unit Calc;

interface

uses
  SysUtils, Types, Classes, Variants, QTypes, QGraphics, QForms, Math,
  QDialogs, QStdCtrls, QButtons, QMenus, QGrids, QExtCtrls, IniFiles, QClipBrd,
  QControls;

const
  MaxDigitos = 18;

type
  TfrmCalculadora = class(TForm)
    MainMenu1: TMainMenu;
    mnuEdicion: TMenuItem;
    mnuCopiar: TMenuItem;
    mnuPegar: TMenuItem;
    mnuConfiguracion: TMenuItem;
    mnuDecimales: TMenuItem;
    mnuRedondear: TMenuItem;
    N1: TMenuItem;
    mnuTruncar: TMenuItem;
    mnuLineas: TMenuItem;
    mnuAyuda: TMenuItem;
    mnuAcercade: TMenuItem;
    ppmContextual: TPopupMenu;
    Copiar1: TMenuItem;
    Pegar1: TMenuItem;
    N3: TMenuItem;
    mnuInsertar1: TMenuItem;
    mnuEliminar1: TMenuItem;
    N4: TMenuItem;
    mnuInsertar: TMenuItem;
    mnuEliminar: TMenuItem;
    pnlNumeros: TPanel;
    btnUtilizar: TBitBtn;
    btnRetroceso: TBitBtn;
    btn7: TBitBtn;
    btn8: TBitBtn;
    btn9: TBitBtn;
    btn4: TBitBtn;
    btn1: TBitBtn;
    btn5: TBitBtn;
    btn6: TBitBtn;
    btn2: TBitBtn;
    btn3: TBitBtn;
    btnDivision: TBitBtn;
    btnMultiplicacion: TBitBtn;
    btnRaiz: TBitBtn;
    btnPorcentaje: TBitBtn;
    btnResta: TBitBtn;
    btnInverso: TBitBtn;
    btnSuma: TBitBtn;
    btnIgual: TBitBtn;
    btnLimpiar: TBitBtn;
    btnCancelar: TBitBtn;
    btn0: TBitBtn;
    btnSigno: TBitBtn;
    btnPunto: TBitBtn;
    grdCalculo: TStringGrid;
    procedure BotonNumericoClick(Sender: TObject);
    procedure btnSignoClick(Sender: TObject);
    procedure btnRetrocesoClick(Sender: TObject);
    procedure btnLimpiarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var wKey: Word;
      Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure mnuDecimalesClick(Sender: TObject);
    procedure mnuCopiarClick(Sender: TObject);
    procedure mnuPegarClick(Sender: TObject);
    procedure mnuRedondearClick(Sender: TObject);
    procedure btnUtilizarClick(Sender: TObject);
    procedure mnuLineasClick(Sender: TObject);
    procedure Resultado(Sender: TObject);
    procedure btnUtilizarEnter(Sender: TObject);
    procedure Operadores(Sender : TObject);
    procedure grdCalculoDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure btnPuntoClick(Sender: TObject);
    procedure btnPorcentajeClick(Sender: TObject);
    procedure btnInversoClick(Sender: TObject);
    procedure btnRaizClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure grdCalculoMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure mnuEliminar1Click(Sender: TObject);
    procedure mnuInsertar1Click(Sender: TObject);
  private
    sModo  : string;
    iVisor, iDecimales : Integer;
    procedure Visualiza(iRen : integer);
    procedure RecuperaConfig;
    procedure Inicializa;
    procedure Calcula;
    function Rellena(sTexto : String; iCantidad : Integer; sAlineacion : String):String;
  public
    bUtilizar : Boolean;
    eResultado : Extended;
  end;

var
  frmCalculadora : TfrmCalculadora;

implementation

{$R *.xfm}

procedure TfrmCalculadora.BotonNumericoClick(Sender: TObject);
var
    cCar : WideChar;
    bCorrecto : boolean;
    iDecimal, iTam : integer;
begin
    bCorrecto := true;

    iDecimal := Pos(DecimalSeparator, grdCalculo.Cells[2,grdCalculo.Row]);
    iTam := Length(grdCalculo.Cells[2,grdCalculo.Row]);

    if(iDecimal > 0) then
        if(iTam - iDecimal = iDecimales) then
            bCorrecto := false;

    if(bCorrecto) then begin
        grdCalculo.Cells[2,grdCalculo.Row] := Trim(grdCalculo.Cells[2,grdCalculo.Row]);
        cCar := (Sender as TBitBtn).Caption[1];
        if(grdCalculo.Cells[2,grdCalculo.Row] <> '0') then
            grdCalculo.Cells[2,grdCalculo.Row] := Trim(grdCalculo.Cells[2,grdCalculo.Row]) + cCar
        else
            grdCalculo.Cells[2,grdCalculo.Row] := cCar;
        Visualiza(grdCalculo.Row);
        Calcula;
    end;
end;

procedure TfrmCalculadora.Visualiza(iRen : integer);
var
    eNumero : Extended;
    iDecimal, iTam : integer;
begin
    grdCalculo.Cells[2,iRen] := Trim(grdCalculo.Cells[2,iRen]);
    iTam := Length(grdCalculo.Cells[2,iRen]);
    if(iTam > 0) then begin
        if(TryStrToFloat(grdCalculo.Cells[2,iRen],eNumero)) then begin
            iDecimal := Pos(DecimalSeparator, grdCalculo.Cells[2,iRen]);

            if(iDecimal > 0) then
                //Si los decimales son más que los permitidos, se reducen
                if(iTam - iDecimal > iDecimales) then begin
                    eNumero := StrToFloat(grdCalculo.Cells[2,iRen]);
                    if(sModo = 'R') then
                        grdCalculo.Cells[2,iRen] := Format('%0.' + IntToStr(iDecimales) + 'f', [eNumero])
                    else begin
                        eNumero := Int(eNumero * Power(10,iDecimales));
                        eNumero := eNumero / Power(10,iDecimales);
                        grdCalculo.Cells[2,iRen] := Format('%0.' + IntToStr(iDecimales) + 'f', [eNumero]);
                    end;
                end;

            grdCalculo.Cells[2,iRen] := Rellena(grdCalculo.Cells[2,iRen], 18,'I');
        end;
    end
end;

function TfrmCalculadora.Rellena(sTexto : String; iCantidad : Integer; sAlineacion : String):String;
var
    sResult : String;
    i, iEsp : Integer;
begin
    if(Length(sTexto) > iCantidad) then
        sResult := Copy(sTexto,1,iCantidad)
    else begin
        sResult := sTexto;
        iEsp := iCantidad - Length(sTexto);
        for i := 1 to iEsp do begin
            if(sAlineacion = 'D')  then
                sResult := sResult + ' ';
            if(sAlineacion = 'I')  then
                sResult := ' ' + sResult;
            if(sAlineacion = '0')  then
                sResult := '0' + sResult;
        end;
    end;
    Rellena := sResult
end;

procedure TfrmCalculadora.btnSignoClick(Sender: TObject);
var
    rNumero : Extended;
begin
    if(grdCalculo.Cells[0,grdCalculo.Row] <> '=') then begin
        rNumero := StrToFloat(grdCalculo.Cells[2,grdCalculo.Row]);
        rNumero := rNumero * -1;
        grdCalculo.Cells[2,grdCalculo.Row] := FloatToStr(rNumero);
        Visualiza(grdCalculo.Row);
        Calcula;
    end;
end;

procedure TfrmCalculadora.btnRetrocesoClick(Sender: TObject);
begin
    // Si hay operando
    if(Length(grdCalculo.Cells[2,grdCalculo.Row]) > 0) then begin
        grdCalculo.Cells[2,grdCalculo.Row] := Copy(grdCalculo.Cells[2,grdCalculo.Row], 1, Length(grdCalculo.Cells[2,grdCalculo.Row]) - 1);
        Visualiza(grdCalculo.Row);
    end
    else begin
        // Si hay operador
        if(grdCalculo.Cells[0,grdCalculo.Row] <> '') then
            grdCalculo.Cells[0,grdCalculo.Row] := '';
    end;
    Calcula;
end;

procedure TfrmCalculadora.btnLimpiarClick(Sender: TObject);
begin
    grdCalculo.Cells[0,grdCalculo.Row] := '';
    grdCalculo.Cells[2,grdCalculo.Row] := '';
    Calcula;
end;

procedure TfrmCalculadora.FormKeyDown(Sender: TObject; var wKey: Word;
  Shift: TShiftState);
begin
    // Si la tecla es igual a Intro o enter
    if (wKey = 4100) or (wKey = 4101) then begin
      wKey := 0;
      Resultado(btnIgual);
    end
end;

procedure TfrmCalculadora.FormKeyPress(Sender: TObject; var Key: Char);
begin
  case UpCase(Key) of
    '+' : Operadores(btnSuma);
    '-' : Operadores(btnResta);
    '*' : Operadores(btnMultiplicacion);
    '/' : Operadores(btnDivision);
    '%' : btnPorcentajeClick(btnPorcentaje);
    'R' : btnRaizClick(btnRaiz);
    'I' : btnInversoClick(btnInverso);
    '=' : Resultado(btnIgual);
    '0'..'9' : BotonNumericoClick(FindComponent('btn' + Key));
    '_' : btnSignoClick(Sender);
    #8  : btnRetrocesoClick(Sender);
    'C' : btnLimpiarClick(Sender);
    'U' : btnUtilizarClick(Sender);
  else
    if Key = DecimalSeparator then btnPunto.Click;
  end;
end;

procedure TfrmCalculadora.RecuperaConfig;
var
    IniArchivo : TIniFile;
    sArriba, sIzq, sValor : string;
begin
    IniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName)+'config.ini');
    with iniArchivo do begin
        sArriba := ReadString('Calculadora', 'Posy', '');
        sIzq := ReadString('Calculadora', 'Posx', '');
        if (Length(sIzq) > 0) and (Length(sArriba) > 0) then begin
            Left := StrToInt(sIzq);
            Top := StrToInt(sArriba);
        end;

        sValor := ReadString('Calculadora', 'Decimales', '2');
        if (Length(sValor) > 0) then
            iDecimales := StrToInt(sValor)
        else
            iDecimales := 2;

        sModo := ReadString('Calculadora', 'Modo', '');

        sValor := ReadString('Calculadora', 'Visor', '');
        if (Length(sValor) > 0) then
            iVisor := StrToInt(sValor)
        else
            iVisor := 5;
        Height := 224 + (iVisor - 1) * 16;
        Free;
    end;
end;

procedure TfrmCalculadora.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
    iniArchivo : TIniFile;
begin
    IniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName)+'config.ini');
    with IniArchivo do begin
       WriteString('Calculadora', 'PosY', IntToStr(Top));
       WriteString('Calculadora', 'PosX', IntToStr(Left));
       WriteString('Calculadora', 'Decimales', IntToStr(iDecimales));
       WriteString('Calculadora', 'Modo', sModo);
       WriteString('Calculadora', 'Visor', IntToStr(iVisor));
       Free;
    end;
end;

procedure TfrmCalculadora.Inicializa;
begin
    bUtilizar := False;
    grdCalculo.Cells[2,grdCalculo.Row] := '0';
    Visualiza(grdCalculo.Row);
//    Width := StrToInt(FormatFloat('0',207 * Screen.Width / 800));
    grdCalculo.ColWidths[0] := StrToInt(FormatFloat('0',45 * Width / 800));
    grdCalculo.ColWidths[1] := StrToInt(FormatFloat('0',45 * Width / 800));
    grdCalculo.ColWidths[2] := StrToInt(FormatFloat('0',570 * Width / 800));
    grdCalculo.ColWidths[3] := StrToInt(FormatFloat('0',45 * Width / 800));
    grdCalculo.Font.Size := StrToInt(FormatFloat('0',39 * Width / 800));
    grdCalculo.DefaultRowHeight := StrToInt(FormatFloat('0',65 * Width / 800));
    grdCalculo.RowCount := 1;
    if sModo = 'R' then
        mnuRedondearClick(mnuRedondear)
    else
        mnuRedondearClick(mnuTruncar);
end;

procedure TfrmCalculadora.FormCreate(Sender: TObject);
begin
   RecuperaConfig;
   Inicializa;
end;

procedure TfrmCalculadora.btnCancelarClick(Sender: TObject);
var
    i : integer;
begin
    for i := 0 to grdCalculo.RowCount - 1 do begin
        grdCalculo.Cells[0,i] := '';
        grdCalculo.Cells[1,i] := '';
        grdCalculo.Cells[2,i] := '';
        grdCalculo.Cells[3,i] := '';
    end;
    Inicializa;
end;

procedure TfrmCalculadora.mnuDecimalesClick(Sender: TObject);
begin
    if(InputQuery('Calculadora','Número de decimales: ', iDecimales, 0, 8, 1)) then
        Calcula;
end;

procedure TfrmCalculadora.mnuRedondearClick(Sender: TObject);
begin
    (Sender as TMenuItem).Checked := True;
    sModo := Copy((Sender as TMenuItem).Name,4,1);
    Calcula;
end;

procedure TfrmCalculadora.mnuCopiarClick(Sender: TObject);
begin
    ClipBoard.AsText := Trim(grdCalculo.Cells[2,grdCalculo.Row]);
end;

procedure TfrmCalculadora.mnuPegarClick(Sender: TObject);
begin
    if(grdCalculo.Cells[0,grdCalculo.Row] <> '=') then begin
        grdCalculo.Cells[2,grdCalculo.Row] := ClipBoard.AsText;
        Visualiza(grdCalculo.Row);
    end;
    Calcula;
end;

procedure TfrmCalculadora.btnUtilizarClick(Sender: TObject);
begin
    if(TryStrToFloat(grdCalculo.Cells[2,grdCalculo.Row],eResultado)) then begin
        ClipBoard.AsText := FloatToStr(eResultado);
        bUtilizar := True;
        Close;
    end;
end;

procedure TfrmCalculadora.mnuLineasClick(Sender: TObject);
begin
    if(InputQuery('Calculadora','Número de líneas de visor: ', iVisor, 1, 20)) then
        Height := 224 + (iVisor - 1) * 16;
end;

procedure TfrmCalculadora.Resultado(Sender: TObject);
begin
    if(grdCalculo.Row = grdCalculo.RowCount - 1) and (grdCalculo.Cells[0,grdCalculo.RowCount-1] <> '=')then begin
        grdCalculo.RowCount := grdCalculo.RowCount + 1;
        grdCalculo.Cells[0,grdCalculo.RowCount-1] := '=';
        grdCalculo.Row := grdCalculo.RowCount - 1;
    end;
    Calcula;
end;

procedure TfrmCalculadora.Calcula;
var
    i : integer;
    sOperador : String;
    cOper : char;
    eResultado, eOperando : Extended;
begin
    eResultado := 0;
    eOperando := 0;
    cOper := #0;
    for i := 0 to grdCalculo.RowCount - 1 do begin
        if(grdCalculo.Cells[1,i] = 'E') then
            grdCalculo.Cells[1,i] := '';
        sOperador := grdCalculo.Cells[0,i];
        if(Length(sOperador) > 0) then
            cOper := sOperador[1];
        if(cOper <> '=') then begin
            if(TryStrToFloat(grdCalculo.Cells[2,i],eOperando)) then begin

                if(grdCalculo.Cells[3,i] = '%') then
                    eOperando := eResultado * eOperando / 100

                else if(grdCalculo.Cells[3,i] = 'I') then
                    if(eOperando <> 0) then
                        eOperando := 1 / eOperando
                    else
                        grdCalculo.Cells[1,i] := 'E'
                        
                else if(grdCalculo.Cells[3,i] = 'R') then
                    if(eOperando < 0) then begin
                        grdCalculo.Cells[1,i] := 'E';
                        eOperando := 0;
                    end
                    else
                        eOperando := Sqrt(eOperando);

                case cOper of
                    #0,   // Primera cantidad
                    '+' : eResultado := eResultado + eOperando;
                    '-' : eResultado := eResultado - eOperando;
                    '/' : if(eOperando <> 0) then
                            eResultado := eResultado / eOperando
                          else begin
                            eOperando := 0;
                            grdCalculo.Cells[1,i] := 'E';
                          end;
                    '*' : eResultado := eResultado * eOperando;
                end;
            end;
        end
        else begin
            grdCalculo.Cells[2,i] := FloatToStr(eResultado);
            Visualiza(i);
        end;
    end;
    grdCalculo.SetFocus;
end;

procedure TfrmCalculadora.Operadores(Sender : TObject);
var
    cOper : WideString;
begin
    cOper := (Sender as TBitBtn).Caption[1];
    if(Length(grdCalculo.Cells[2,grdCalculo.Row]) > 0) then begin
            // Si es el último renglon y , o es el primero
            if(grdCalculo.Row = grdCalculo.RowCount - 1) and (grdCalculo.Cells[0,grdCalculo.Row] <> '') or (grdCalculo.Row = 0) then begin
                grdCalculo.RowCount := grdCalculo.RowCount + 1;
                grdCalculo.Row := grdCalculo.Row + 1;
                grdCalculo.Cells[2,grdCalculo.Row] := '0';
                Visualiza(grdCalculo.Row);
            end;
            if(grdCalculo.Row > 0) then
                grdCalculo.Cells[0,grdCalculo.Row] := cOper;
    end
    else if(grdCalculo.Row > 0) then
        grdCalculo.Cells[0,grdCalculo.Row] := cOper;
    Calcula;
end;

procedure TfrmCalculadora.btnUtilizarEnter(Sender: TObject);
begin
    grdCalculo.SetFocus;
end;

procedure TfrmCalculadora.grdCalculoDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var
    sCad : String;
begin
    sCad := (Sender as TStringGrid).Cells[ACol,ARow];
    if(grdCalculo.Cells[0, ARow] = '=') then begin
        (Sender as TStringGrid).Canvas.Brush.Style := bsDense1;
        (Sender as TStringGrid).Canvas.Brush.Color := clMidLight;
        (Sender as TStringGrid).Canvas.Font.Color := clBlack;
    end;
    if(grdCalculo.Cells[1, ARow] = 'E') then
        (Sender as TStringGrid).Canvas.Font.Color := clRed;
    (Sender as TStringGrid).Canvas.FillRect(Rect);
    (Sender as TStringGrid).Canvas.TextOut(Rect.Left+2,Rect.Top+2,sCad);
end;

procedure TfrmCalculadora.btnPuntoClick(Sender: TObject);
begin
    if(iDecimales > 0) then begin
        if(Trim(grdCalculo.Cells[2,grdCalculo.Row]) = '') then
            grdCalculo.Cells[2,grdCalculo.Row] := '0.'
        else if (Pos(DecimalSeparator, grdCalculo.Cells[2,grdCalculo.Row]) = 0)  then
            grdCalculo.Cells[2,grdCalculo.Row] := Trim(grdCalculo.Cells[2,grdCalculo.Row]) + DecimalSeparator;
        Visualiza(grdCalculo.Row);
        Calcula;
    end;
end;

procedure TfrmCalculadora.btnPorcentajeClick(Sender: TObject);
begin
    if(grdCalculo.Cells[0,grdCalculo.Row] <> '=') and (grdCalculo.Row > 0) then begin
        if(grdCalculo.Cells[3,grdCalculo.Row] = '%') then
            grdCalculo.Cells[3,grdCalculo.Row] := ''
        else
            grdCalculo.Cells[3,grdCalculo.Row] := '%';
        Calcula;
    end;
end;

procedure TfrmCalculadora.btnInversoClick(Sender: TObject);
begin
    if(grdCalculo.Cells[0,grdCalculo.Row] <> '=') then begin
        if(grdCalculo.Cells[3,grdCalculo.Row] = 'I') then
            grdCalculo.Cells[3,grdCalculo.Row] := ''
        else
            grdCalculo.Cells[3,grdCalculo.Row] := 'I';
        Calcula;
    end;
end;

procedure TfrmCalculadora.btnRaizClick(Sender: TObject);
begin
    if(grdCalculo.Cells[0,grdCalculo.Row] <> '=') then begin
        if(grdCalculo.Cells[3,grdCalculo.Row] = 'R') then
            grdCalculo.Cells[3,grdCalculo.Row] := ''
        else
            grdCalculo.Cells[3,grdCalculo.Row] := 'R';
        Calcula;
    end;
end;

procedure TfrmCalculadora.FormShow(Sender: TObject);
begin
    Visualiza(0);
end;

procedure TfrmCalculadora.grdCalculoMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
    grcRenglon : TGridCoord;
begin
    if(Button = mbRight) then begin
        grcRenglon := grdCalculo.MouseCoord(X, Y);
        if(grcRenglon.y >= 1) then
            grdCalculo.Row := grcRenglon.y;
    end;
end;

procedure TfrmCalculadora.mnuEliminar1Click(Sender: TObject);
var
    i : integer;
begin
    if(grdCalculo.RowCount > 1) then begin
        for i := grdCalculo.Row to grdCalculo.RowCount - 2 do
            grdCalculo.Rows[i] := grdCalculo.Rows[i + 1];
        grdCalculo.RowCount := grdCalculo.RowCount - 1;

        // Si es el primero de la lista se elimina el operador
        if(grdCalculo.Row = 0) then
            grdCalculo.Cells[0,grdCalculo.Row] := '';
        Calcula;
    end
    else begin
        grdCalculo.Cells[2,grdCalculo.Row] := '0';
        Visualiza(grdCalculo.Row);
    end;
end;

procedure TfrmCalculadora.mnuInsertar1Click(Sender: TObject);
var
    i : integer;
begin
    grdCalculo.RowCount := grdCalculo.RowCount + 1;
    for i := grdCalculo.RowCount - 1 downto grdCalculo.Row + 1 do
        grdCalculo.Rows[i] := grdCalculo.Rows[i - 1];
    if(grdCalculo.Row > 0) then
        grdCalculo.Cells[0,grdCalculo.Row] := '+';
    grdCalculo.Cells[2,grdCalculo.Row] := '0';
    Visualiza(grdCalculo.Row);
end;

end.
