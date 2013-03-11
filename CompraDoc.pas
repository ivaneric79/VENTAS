// --------------------------------------------------------------------------
// Archivo del Proyecto Ventas
// Página del proyecto: http://sourceforge.net/projects/ventas
// --------------------------------------------------------------------------
// Este archivo puede ser distribuido y/o modificado bajo lo terminos de la
// Licencia Pública General versión 2 como es publicada por la Free Software
// Fundation, Inc.
// --------------------------------------------------------------------------

unit CompraDoc;

interface

uses
  SysUtils, Types, Classes, QGraphics, QControls, QForms, QDialogs,
  QStdCtrls, QButtons, QcurrEdit, IniFiles, QExtCtrls;

type
  TfrmCompraDoc = class(TForm)
    grpDocumento: TGroupBox;
    txtClaveProv: TcurrEdit;
    Label1: TLabel;
    txtDescProv: TEdit;
    Label2: TLabel;
    txtDocumento: TEdit;
    Label29: TLabel;
    txtDia: TEdit;
    txtMes: TEdit;
    txtAnio: TEdit;
    Label30: TLabel;
    Label31: TLabel;
    chkIva: TCheckBox;
    Panel1: TPanel;
    btnAceptar: TBitBtn;
    btnCancelar: TBitBtn;
    pnlClientes: TPanel;
    procedure FormShow(Sender: TObject);
    procedure btnAceptarClick(Sender: TObject);
    procedure txtClaveProvKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Salta(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Rellena(Sender: TObject);
    procedure txtAnioExit(Sender: TObject);
    procedure pnlClientesClick(Sender: TObject);
  private
    function VerificaDatos:boolean;
    function VerificaFechas(sFecha : string):boolean;
    procedure RecuperaConfig;
    procedure BuscaProv;
  public
    sClave, sDocumento, sNombreProv, sFecha, sIva, sTitulo : String;
    bCaptura : boolean;
  end;

var
  frmCompraDoc: TfrmCompraDoc;

implementation

uses ProveedBusq, dm;

{$R *.xfm}

procedure TfrmCompraDoc.FormShow(Sender: TObject);
begin
    Caption := sTitulo;

    chkIva.Enabled := bCaptura;

    if(bCaptura) then begin
        grpDocumento.Height := 145;
        Height := 202
    end
    else begin
        grpDocumento.Height := 108;
        Height := 168;
    end;

    txtClaveProv.Clear;
    txtDescProv.Clear;
    txtDocumento.Clear;
    txtDia.Clear;
    txtMes.Clear;
    txtAnio.Clear;
    txtClaveProv.SetFocus;
end;

procedure TfrmCompraDoc.btnAceptarClick(Sender: TObject);
begin
    if(VerificaDatos) then  begin
        sClave := txtClaveProv.Text;
        sDocumento := txtDocumento.Text;
        sNombreProv := txtDescProv.Text;
        sFecha := txtDia.Text + '/' + txtMes.Text + '/' + txtAnio.Text;
        if(chkIva.Checked) then
            sIva := 'S'
        else
            sIva := 'N';
        ModalResult := mrOK;
    end;
end;

function TfrmCompraDoc.VerificaDatos:boolean;
var
    bRegreso : boolean;
begin
    btnAceptar.SetFocus;
    bRegreso := true;
    if(txtClaveProv.Value < 1) then begin
        Application.MessageBox('Introduce la clave del proveedor','Error',[smbOK],smsCritical);
        txtClaveProv.SetFocus;
        bRegreso:=false;
    end
    else if(Length(txtDocumento.Text) = 0) then begin
        Application.MessageBox('Introduce el número de documento','Error',[smbOK],smsCritical);
        txtDocumento.SetFocus;
        bRegreso := false;
    end
    else if(Length(txtDescProv.Text) = 0) then begin
        Application.MessageBox('Introduce un proveedor válido','Error',[smbOK],smsCritical);
        txtDocumento.SetFocus;
        bRegreso := false;
    end
    else if(not VerificaFechas(txtDia.Text + '/' + txtMes.Text + '/' + txtAnio.Text)) then
        bRegreso := false;
    Result := bRegreso;
end;

procedure TfrmCompraDoc.txtClaveProvKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    //Si la tecla que se oprimió es la F9
    if(Key = 4152) then begin
        BuscaProv;
    end
    else if(Length(txtClaveProv.Text) > 0) then begin
        with dmDatos.qryModifica do begin
            Close;
            SQL.Clear;
            SQL.Add('SELECT nombre FROM proveedores WHERE clave = ' + txtClaveProv.Text);
            Open;
            txtDescProv.Text := Trim(FieldByName('nombre').AsString);
            Close;
        end;
    end
    else begin
        sClave := 'null';
        txtDescProv.Text := '';
    end;
end;

procedure TfrmCompraDoc.BuscaProv;
begin
    with TFrmProveedBusq.Create(Self) do
    try
        if(ShowModal = mrOk) then begin
            txtClaveProv.Text := sClave;
            txtDescProv.Text := sNombre;
        end;
        txtClaveProv.SetFocus;
    finally
        Free;
    end;
end;

procedure TfrmCompraDoc.Salta(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    {Inicio (36), Fin (35), Izquierda (37), derecha (39), arriba (38), abajo (40)}
    if(Key >= 30) and (Key <= 122) and (Key <> 35) and (Key <> 36) and not ((Key >= 37) and (Key <= 40)) then
        if( Length((Sender as TEdit).Text) = (Sender as TEdit).MaxLength) then
            SelectNext(Sender as TWidgetControl, true, true);
end;

function TfrmCompraDoc.VerificaFechas(sFecha : string):boolean;
var
   dteFecha : TDateTime;
begin
    Result := true;
    if(not TryStrToDate(txtDia.Text + '/' + txtMes.Text + '/' + txtAnio.Text,dteFecha)) then begin
        Application.MessageBox('Introduce una fecha válida','Error',[smbOK],smsCritical);
        txtDia.SetFocus;
        Result := false;
    end;
end;

procedure TfrmCompraDoc.RecuperaConfig;
var
    iniArchivo : TIniFile;
    sIzq, sArriba, sValor : String;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'config.ini');

    with iniArchivo do begin
        //Recupera la posición Y de la ventana
        sArriba := ReadString('CompraDoc', 'Posy', '');

        //Recupera la posición X de la ventana
        sIzq := ReadString('CompraDoc', 'Posx', '');
        if (Length(sIzq) > 0) and (Length(sArriba) > 0) then begin
            Left := StrToInt(sIzq);
            Top := StrToInt(sArriba);
        end;

        //Recupera el IVA
        sValor := ReadString('CompraDoc', 'IVA', '');
        if (sValor = 'S') then
            chkIva.Checked := true
        else
            chkIva.Checked := false;

        Free;
    end;
end;

procedure TfrmCompraDoc.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
    iniArchivo : TIniFile;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) +'config.ini');
    with iniArchivo do begin
        // Registra la posición y de la ventana
        WriteString('CompraDoc', 'Posy', IntToStr(Top));

        // Registra la posición X de la ventana
        WriteString('CompraDoc', 'Posx', IntToStr(Left));

        // Registra el IVA
        if(chkIva.Checked) then
            WriteString('CompraDoc', 'IVA', 'S')
        else
            WriteString('CompraDoc', 'IVA', 'N');

        Free;
    end;
end;

procedure TfrmCompraDoc.FormCreate(Sender: TObject);
begin
    RecuperaConfig;
end;

procedure TfrmCompraDoc.Rellena(Sender: TObject);
var
    i : integer;
begin
    for i := Length((Sender as TEdit).Text) to (Sender as TEdit).MaxLength - 1 do
        (Sender as TEdit).Text := '0' + (Sender as TEdit).Text;
end;

procedure TfrmCompraDoc.txtAnioExit(Sender: TObject);
begin
    (Sender as TEdit).Text := Trim((Sender as TEdit).Text);
    if(Length((Sender as TEdit).Text) < 4) and (Length((Sender as TEdit).Text) > 0) then
        (Sender as TEdit).Text := IntToStr(StrToInt((Sender as TEdit).Text) + 2000);
end;

procedure TfrmCompraDoc.pnlClientesClick(Sender: TObject);
begin
    BuscaProv;
end;

end.
