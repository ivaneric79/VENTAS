// --------------------------------------------------------------------------
// Archivo del Proyecto Ventas
// P�gina del proyecto: http://sourceforge.net/projects/ventas
// --------------------------------------------------------------------------
// Este archivo puede ser distribuido y/o modificado bajo lo terminos de la
// Licencia P�blica General versi�n 2 como es publicada por la Free Software
// Fundation, Inc.
// --------------------------------------------------------------------------

unit Consecutivos;

interface

uses
  SysUtils, Types, Classes, Variants, QTypes, QGraphics, QControls, QForms,
  QDialogs, QStdCtrls, QButtons, QcurrEdit, QGrids, IniFiles;

type
  TfrmConsecutivos = class(TForm)
    grpConsec: TGroupBox;
    grdComprobante: TStringGrid;
    lblComprobante: TLabel;
    lblActual: TLabel;
    btnAceptar: TBitBtn;
    btnCancelar: TBitBtn;
    cmbCaja: TComboBox;
    lblCaja: TLabel;
    txtConsecActual: TcurrEdit;
    txtConsecNuevo: TcurrEdit;
    lblNuevo: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure RecuperaConsec(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnAceptarClick(Sender: TObject);
  private
    sCaja, sComprob : string;
    bModifica : boolean;
    procedure RecuperaConfig;
    procedure RecuperaCajas;
    procedure RecuperaPermisos;
    function VerificaDatos : boolean;
    procedure GuardaDatos;
  public
    iUsuario : integer;
  end;

var
  frmConsecutivos: TfrmConsecutivos;

implementation

uses dm, Autoriza;

{$R *.xfm}

procedure TfrmConsecutivos.RecuperaConfig;
var
    iniArchivo : TiniFile;
    sArriba, sIzq, sValor : string;
begin
    iniArchivo := TiniFile.Create(ExtractFilePath(Application.ExeName) + 'config.ini');

    with iniArchivo do begin
        sArriba := ReadString('Consec', 'PosY', '');
        sIzq := ReadString('Consec', 'PosX', '');

        if (Length(sArriba)>0) and (Length(sIzq)>0) then begin
            Top := StrToInt(sArriba);
            Left:= StrToInt(sIzq);
        end;

        sValor := ReadString('Consec', 'Caja', '');
        if (Length(sValor) > 0) then
            sCaja := sValor
        else
            sCaja := '0';

        sValor := ReadString('Consec', 'Comprobante', '');
        if (Length(sValor) > 0) then
            grdComprobante.Row := StrToInt(sValor)
        else
            grdComprobante.Row := 0;

        Free;
    end;
end;

procedure TfrmConsecutivos.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
    iniArchivo : TiniFile;
begin
    iniArchivo := TiniFile.Create(ExtractFilePath(Application.ExeName) + 'config.ini');

    with iniArchivo do begin
        WriteString('Consec', 'PosX', IntToStr(Left));
        WriteString('Consec', 'PosY', IntToStr(Top));
        WriteString('Consec', 'Caja', cmbCaja.Text);
        WriteString('Consec', 'Comprobante', IntToStr(grdComprobante.Row));
        Free;
    end;
end;

procedure TfrmConsecutivos.RecuperaCajas;
var
    i : integer;
begin
    with dmDatos.qryModifica do begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT numero FROM cajas ORDER BY numero');
        Open;
        i := 0;
        while(not Eof) do begin
            cmbCaja.Items.Add(Trim(FieldByName('numero').AsString));
            if(sCaja = FieldByName('numero').AsString) then
                cmbCaja.ItemIndex := i;
            Inc(i);
            Next;
        end;
        Close;
    end;
end;

procedure TfrmConsecutivos.RecuperaConsec(Sender: TObject);
begin
    with dmDatos.qryModifica do begin
       sComprob := Copy(grdComprobante.Cells[0,grdComprobante.Row],1,1);
       Close;
       SQL.Clear;
       SQL.Add('SELECT MAX(numero) AS consec FROM comprobantes WHERE tipo = '''+ sComprob +'''');
       if (Length(cmbCaja.Text)>0) then
            SQL.Add('AND Caja = ' + cmbCaja.Text);
       Open;

       txtConsecActual.Value := FieldByName('consec').AsInteger;
       if (bModifica) then
            txtConsecNuevo.Value := txtConsecActual.Value;
       Close;
    end
end;

procedure TfrmConsecutivos.RecuperaPermisos;
begin
    with TFrmAutoriza.Create(Self) do
    try
        if(not VerificaAutoriza(Self.iUsuario,'V12')) then begin
            lblNuevo.Visible := false;
            txtConsecNuevo.Visible := false;
            bModifica := false;
        end
        else begin
            lblNuevo.Visible := true;
            txtConsecNuevo.Visible := true;
            bModifica := true;
        end;
    finally
        Free;
    end
end;

procedure TfrmConsecutivos.FormShow(Sender: TObject);
begin
    RecuperaConfig;
    RecuperaCajas;
    RecuperaPermisos;
end;

procedure TfrmConsecutivos.FormCreate(Sender: TObject);
begin
    grdComprobante.Cells[0,0] := 'AJUSTE';
    grdComprobante.Cells[0,1] := 'COTIZACION';
    grdComprobante.Cells[0,2] := 'FACTURA';
    grdComprobante.Cells[0,3] := 'NOTA';
    grdComprobante.Cells[0,4] := 'TICKET';
end;

procedure TfrmConsecutivos.btnAceptarClick(Sender: TObject);
begin
    if (VerificaDatos) then 
        GuardaDatos;
    Close;
end;

function TfrmConsecutivos.VerificaDatos : boolean;
begin
    Result := true;
    if (txtConsecNuevo.Visible = True) and (txtConsecNuevo.Value = 0) then begin
        Application.MessageBox('Introduce el n�mero consecutivo nuevo','Error',[smbOK],smsCritical);
        txtConsecNuevo.SetFocus;
        Result := false;
    end
    else
    if (not bModifica) then
        Result := false;
end;

procedure TfrmConsecutivos.GuardaDatos;
begin
    with dmDatos.qryConsulta do begin
        Close;
        SQL.Clear;
        SQL.Add('INSERT INTO consecutivos(comprobante, numero, caja) VALUES(');
        SQL.Add(''''+ sComprob + ''',' + FloatToStr(txtConsecActual.Value) + ','+ cmbCaja.Text + ')');
        ExecSQL;
        Close;
    end;
end;

end.
