// --------------------------------------------------------------------------
// Archivo del Proyecto Ventas
// Página del proyecto: http://sourceforge.net/projects/ventas
// --------------------------------------------------------------------------
// Este archivo puede ser distribuido y/o modificado bajo lo terminos de la
// Licencia Pública General versión 2 como es publicada por la Free Software
// Fundation, Inc.
// --------------------------------------------------------------------------

unit VentaRecupera;

interface

uses
  SysUtils, Types, Classes, QGraphics, QControls, QForms, QDialogs,
  QStdCtrls, QGrids, QButtons, QcurrEdit, IniFiles;

type
  TfrmRecuperaVenta = class(TForm)
    grpVenta: TGroupBox;
    grdComprobante: TStringGrid;
    Label1: TLabel;
    Label2: TLabel;
    btnAceptar: TBitBtn;
    btnCancelar: TBitBtn;
    txtNumero: TcurrEdit;
    lblCaja: TLabel;
    txtCaja: TcurrEdit;
    procedure FormShow(Sender: TObject);
    procedure btnAceptarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure grdComprobanteClick(Sender: TObject);
  private
    iRenglon : integer;
    procedure RecuperaConfig;
  public
    sVenta, sVentaRef, sTitulo, sNumero, sFecha, sHora, sTotal, sTipoComp : String;
    bAjuste, bCotizacion, bDevolucion, bPedido : boolean;
  end;

var
  frmRecuperaVenta: TfrmRecuperaVenta;

implementation

uses dm, Reimprimir;

{$R *.xfm}

procedure TfrmRecuperaVenta.FormShow(Sender: TObject);
var
    i : integer;
begin
    Caption := sTitulo;

    i := 0;
    if(bAjuste) then begin
        grdComprobante.Cells[0,i] := 'AJUSTE';
        Inc(i);
    end;
    if(bCotizacion) then begin
        grdComprobante.Cells[0,i] := 'COTIZACION';
        Inc(i);
    end;
    if(bDevolucion) then begin
        grdComprobante.Cells[0,i] := 'DEVOLUCION';
        Inc(i);
    end;
    grdComprobante.Cells[0,i] := 'FACTURA';
    Inc(i);
    grdComprobante.Cells[0,i] := 'NOTA';
    Inc(i);
    if(bPedido) then begin
        grdComprobante.Cells[0,i] := 'PEDIDO';
        Inc(i);
    end;
    grdComprobante.Cells[0,i] := 'TICKET';

    if(iRenglon > i) then
        iRenglon := i;
    grdComprobante.RowCount := i + 1;
    grdComprobante.Row := iRenglon;

    txtNumero.SetFocus;

    grdComprobanteClick(Sender);
end;

procedure TfrmRecuperaVenta.btnAceptarClick(Sender: TObject);
begin
    btnAceptar.SetFocus;
    with dmDatos.qryModifica do begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT v.clave, v.fecha, v.hora, v.caja, v.total, ventaref FROM comprobantes c');
        SQL.Add('LEFT JOIN ventas v ON c.venta = v.clave WHERE c.tipo = ''' + Copy(grdComprobante.Cells[0,grdComprobante.Row],1,1) + '''');
        SQL.Add('AND c.numero = ' + FloatToStr(txtNumero.Value) + ' AND v.estatus = ''A'' AND c.estatus = ''A''');
        if(txtCaja.Visible) then
            SQL.Add('AND v.caja = ' + FloatToStr(txtCaja.Value));
        Open;

        if(not Eof) then begin
            sVenta :=  FieldByName('clave').AsString;
            sVentaRef := FieldByName('ventaref').AsString;
            sNumero := FloatToStr(txtNumero.Value);
            sFecha :=  FormatDateTime('dd/mm/yyyy',FieldByName('fecha').AsDaTeTime);
            sHora :=   FormatDateTime('hh:nn:ss',FieldByName('hora').AsDaTeTime);
            sTotal :=  FormatFloat('#,##0.00',FieldByName('total').AsFloat);
            sTipoComp := grdComprobante.Cells[0,grdComprobante.Row];

            ModalResult := mrOk;
        end
        else begin
            Application.MessageBox('La venta especificada no existe','Error',[smbOK], smsCritical);
            txtNumero.SetFocus;
        end;
        Close;
    end;
end;

procedure TfrmRecuperaVenta.RecuperaConfig;
var
    iniArchivo : TIniFile;
    sIzq, sArriba, sValor : String;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) +'config.ini');

    with iniArchivo do begin
        //Recupera la posición Y de la ventana
        sArriba := ReadString('RecuperaVenta', 'Posy', '');

        //Recupera la posición X de la ventana
        sIzq := ReadString('RecuperaVenta', 'Posx', '');

        if (Length(sIzq) > 0) and (Length(sArriba) > 0) then begin
            Left := StrToInt(sIzq);
            Top := StrToInt(sArriba);
        end;

        // Recupera el número de caja
        sValor := ReadString('Config', 'Caja', '');

        if (Length(sValor) > 0) then
            txtCaja.Value := StrToInt(sValor)
        else
            txtCaja.Value := 1;

        // Recupera la prosición del grid
        sValor := ReadString('RecuperaVenta', 'Comprobante', '');

        if (Length(sValor) > 0) then
            iRenglon := StrToInt(sValor)
        else
            iRenglon := 0;

        Free;
    end;
end;

procedure TfrmRecuperaVenta.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
    iniArchivo : TIniFile;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) +'config.ini');
    with iniArchivo do begin
        // Registra la posición y de la ventana
        WriteString('RecuperaVenta', 'Posy', IntToStr(Top));

        // Registra la posición X de la ventana
        WriteString('RecuperaVenta', 'Posx', IntToStr(Left));

        // Registra la posición del grid
        WriteString('RecuperaVenta', 'Comprobante', IntToStr(grdComprobante.Row));
        Free;
    end;
end;

procedure TfrmRecuperaVenta.FormCreate(Sender: TObject);
begin
    bAjuste := true;
    bCotizacion := true;
    bDevolucion := true;
    bPedido := true;

    RecuperaConfig;
end;

procedure TfrmRecuperaVenta.grdComprobanteClick(Sender: TObject);
var
    sGlobal : String;
begin
    with dmDatos.qryConsulta do begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT ' + grdComprobante.Cells[0,grdComprobante.Row] + 'global AS global FROM config');
        Open;
        sGlobal := FieldByName('global').AsString;
        if(sGlobal = 'S') then begin
            txtCaja.Enabled := false;
            txtCaja.Visible := false;
            lblCaja.Visible := false;
        end
        else begin
            txtCaja.Enabled := true;
            txtCaja.Visible := true;
            lblCaja.Visible := true;
        end;
        Close;
    end;
end;

end.
