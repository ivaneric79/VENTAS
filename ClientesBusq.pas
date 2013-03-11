// --------------------------------------------------------------------------
// Archivo del Proyecto Ventas 
// Página del proyecto: http://sourceforge.net/projects/ventas
// --------------------------------------------------------------------------
// Este archivo puede ser distribuido y/o modificado bajo lo terminos de la
// Licencia Pública General versión 2 como es publicada por la Free Software
// Fundation, Inc.
// --------------------------------------------------------------------------

unit ClientesBusq;

interface

uses
  SysUtils, Types, Classes, QGraphics, QControls, QForms, QDialogs,
  QStdCtrls, QcurrEdit, QButtons, QExtCtrls, QGrids, QDBGrids, Inifiles, DB;

type
  TfrmClientesBusq = class(TForm)
    pnlNombre: TPanel;
    Label20: TLabel;
    txtNombreBusq: TEdit;
    pnlClave: TPanel;
    Label18: TLabel;
    txtClaveBusq: TEdit;
    pnlRfc: TPanel;
    Label19: TLabel;
    txtRfcBusq: TEdit;
    grdListado: TDBGrid;
    rdgBuscar: TRadioGroup;
    rdgOrden: TRadioGroup;
    btnBuscar: TBitBtn;
    btnSeleccionar: TBitBtn;
    btnLimpiar: TBitBtn;
    Label17: TLabel;
    txtRegistros: TcurrEdit;
    btnCerrar: TBitBtn;
    procedure btnBuscarClick(Sender: TObject);
    procedure rdgBuscarClick(Sender: TObject);
    procedure btnSeleccionarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnLimpiarClick(Sender: TObject);
    procedure grdListadoEnter(Sender: TObject);
    procedure grdListadoExit(Sender: TObject);
    procedure Salta(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure rdgOrdenClick(Sender: TObject);
  private
    procedure RecuperaConfig;
  public
    bSelec : Boolean;
    iPrecio : integer;
    sClave, sCliente, sCreden : String;
    rDescuento, rLimiteCredito : real;
    dteFechaVencim : TDateTime;
  end;

var
  frmClientesBusq: TfrmClientesBusq;

implementation

uses dm;

{$R *.xfm}

procedure TfrmClientesBusq.btnBuscarClick(Sender: TObject);
var
    sBM: string;
begin
    with dmDatos.qryListados1 do begin
        sBM := dmDatos.cdsCliente1.Bookmark;

        dmDatos.cdsCliente1.Active := false;
        Close;
        SQL.Clear;
        SQL.Add('SELECT clave, nombre, credencial, vencimcreden, rfc, calle, colonia, cp,');
        SQL.Add('localidad, estado, telefono, ecorreo, precio, fechacap, ');
        SQL.Add('categoria, descuento, limitecredito FROM Clientes WHERE 1=1');

        case rdgBuscar.ItemIndex of
            0: if(Length(txtClaveBusq.Text) > 0) then
                SQL.Add('AND credencial = ''' + txtClaveBusq.Text + '''');
            1: SQL.Add('AND nombre LIKE ''%' + txtNombreBusq.Text + '%''');
            2: SQL.Add('AND rfc STARTING ''' + txtRfcBusq.Text + '''');
        end;

        case rdgOrden.ItemIndex of
            0:  SQL.Add('ORDER BY credencial');
            1:  SQL.Add('ORDER BY nombre');
            2:  SQL.Add('ORDER BY rfc');
        end;
        Open;
        dmDatos.cdsCliente1.Active := true;

        dmDatos.cdsCliente1.FieldByName('clave').Visible := false;
        dmDatos.cdsCliente1.FieldByName('calle').Visible := false;
        dmDatos.cdsCliente1.FieldByName('colonia').Visible := false;
        dmDatos.cdsCliente1.FieldByName('cp').Visible := false;
        dmDatos.cdsCliente1.FieldByName('localidad').Visible := false;
        dmDatos.cdsCliente1.FieldByName('estado').Visible := false;
        dmDatos.cdsCliente1.FieldByName('fechacap').Visible := false;
        dmDatos.cdsCliente1.FieldByName('categoria').Visible := false;
        dmDatos.cdsCliente1.FieldByName('nombre').DisplayLabel := 'Nombre';
        dmDatos.cdsCliente1.FieldByName('nombre').DisplayWidth := 35;
        dmDatos.cdsCliente1.FieldByName('credencial').DisplayLabel := 'Credencial';
        dmDatos.cdsCliente1.FieldByName('vencimcreden').DisplayLabel := 'Vencto Creden';
        dmDatos.cdsCliente1.FieldByName('rfc').DisplayLabel := 'RFC';
        dmDatos.cdsCliente1.FieldByName('telefono').DisplayLabel := 'Teléfono';
        dmDatos.cdsCliente1.FieldByName('ecorreo').DisplayLabel := 'Correo';
        dmDatos.cdsCliente1.FieldByName('precio').DisplayLabel := 'Precio';
        dmDatos.cdsCliente1.FieldByName('precio').DisplayWidth := 5;
        dmDatos.cdsCliente1.FieldByName('descuento').DisplayLabel := 'Descuento';
        dmDatos.cdsCliente1.FieldByName('descuento').DisplayWidth := 11;
        (dmDatos.cdsCliente1.FieldByName('descuento') as TNumericField).DisplayFormat := '#,##0.00';
        dmDatos.cdsCliente1.FieldByName('limitecredito').DisplayLabel := 'Limite crédito';
        (dmDatos.cdsCliente1.FieldByName('limitecredito') as TNumericField).DisplayFormat := '#,##0.00';

        grdListado.SetFocus;

        txtRegistros.Value := dmDatos.cdsCliente1.RecordCount;
        try
            dmDatos.cdsCliente1.Bookmark := sBM;
        except
            txtRegistros.Value := txtRegistros.Value;
        end;
        grdListado.SetFocus;
    end;
end;

procedure TfrmClientesBusq.rdgBuscarClick(Sender: TObject);
begin
    case rdgBuscar.ItemIndex of
        0: begin
            pnlNombre.Visible := false;
            pnlRfc.Visible := false;
            pnlClave.Visible := true;
            txtClaveBusq.SetFocus;
           end;
        1: begin
            pnlRfc.Visible := false;
            pnlClave.Visible := false;
            pnlNombre.Visible := true;
            txtNombreBusq.SetFocus;
           end;
        2: begin
            pnlNombre.Visible := false;
            pnlClave.Visible := false;
            pnlRfc.Visible := true;
            txtRfcBusq.SetFocus;
           end;
    end;
end;

procedure TfrmClientesBusq.btnSeleccionarClick(Sender: TObject);
begin
    if(txtRegistros.Value > 0) then begin
        bSelec := true;
        sClave := dmDatos.cdsCliente1.FieldByName('clave').AsString;
        sCliente := Trim(dmDatos.cdsCliente1.FieldByName('nombre').AsString);
        rDescuento := dmDatos.cdsCliente1.FieldByName('descuento').AsFloat;
        iPrecio := dmDatos.cdsCliente1.FieldByName('precio').AsInteger;
        sCreden := Trim(dmDatos.cdsCliente1.FieldByName('credencial').AsString);
        dteFechaVencim := dmDatos.cdsCliente1.FieldByName('vencimcreden').AsDateTime;
        rLimiteCredito := dmDatos.cdsCliente1.FieldByName('limitecredito').AsFloat;
    end;
    Close;
end;

procedure TfrmClientesBusq.FormShow(Sender: TObject);
begin
    btnLimpiar.Click;
//    btnBuscar.Click;
    bSelec := false;
    rdgBuscarClick(Sender);
end;

procedure TfrmClientesBusq.RecuperaConfig;
var
    iniArchivo : TIniFile;
    sIzq, sArriba, sValor : String;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) +'config.ini');

    with iniArchivo do begin
        //Recupera la posición Y de la ventana
        sArriba := ReadString('ClientesBusq', 'Posy', '');

        //Recupera la posición X de la ventana
        sIzq := ReadString('ClientesBusq', 'Posx', '');

        if (Length(sIzq) > 0) and (Length(sArriba) > 0) then begin
            Left := StrToInt(sIzq);
            Top := StrToInt(sArriba);
        end;

        //Recupera el valor de los botones de radio de buscar
        sValor := ReadString('ClientesBusq', 'Buscar', '');
        if (Length(sValor) > 0) then
            rdgBuscar.ItemIndex := StrToInt(sValor);

        //Recupera el valor de los botones de radio de orden
        sValor := ReadString('ClientesBusq', 'Orden', '');
        if (Length(sValor) > 0) then
            rdgOrden.ItemIndex := StrToInt(sValor);

        Free;
    end;
end;
procedure TfrmClientesBusq.FormClose(Sender: TObject; var Action: TCloseAction);
var
    iniArchivo : TIniFile;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) +'config.ini');
    with iniArchivo do begin
        // Registra la posición y de la ventana
        WriteString('ClientesBusq', 'Posy', IntToStr(Top));

        // Registra la posición X de la ventana
        WriteString('ClientesBusq', 'Posx', IntToStr(Left));

        //Registra el valor de los botones de radio de buscar
        WriteString('ClientesBusq', 'Buscar', IntToStr(rdgBuscar.ItemIndex));

        //Registra el valor de los botones de radio de orden
        WriteString('ClientesBusq', 'Orden', IntToStr(rdgOrden.ItemIndex));

        Free;
    end;
    dmDatos.qryListados1.Close;
    dmDatos.cdsCliente1.Active := false;
end;

procedure TfrmClientesBusq.btnLimpiarClick(Sender: TObject);
begin
    txtClaveBusq.Clear;
    txtNombreBusq.Clear;
    txtRfcBusq.Clear;
end;

procedure TfrmClientesBusq.grdListadoEnter(Sender: TObject);
begin
    btnBuscar.Default := false;
    btnSeleccionar.Default := true;
end;

procedure TfrmClientesBusq.grdListadoExit(Sender: TObject);
begin
    btnBuscar.Default := true;
    btnSeleccionar.Default := false;
end;

procedure TfrmClientesBusq.Salta(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    {Inicio (36), Fin (35), Izquierda (37), derecha (39), arriba (38), abajo (40)}
    if(Key >= 30) and (Key <= 122) and (Key <> 35) and (Key <> 36) and not ((Key >= 37) and (Key <= 40)) then
        if( Length((Sender as TEdit).Text) = (Sender as TEdit).MaxLength) then
            SelectNext(Sender as TWidgetControl, true, true);
end;

procedure TfrmClientesBusq.FormCreate(Sender: TObject);
begin
    RecuperaConfig;
end;

procedure TfrmClientesBusq.rdgOrdenClick(Sender: TObject);
begin
    if(dmDatos.cdsCliente1.Active) then
        btnBuscar.Click;    
end;

end.
