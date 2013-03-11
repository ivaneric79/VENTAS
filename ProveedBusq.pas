// --------------------------------------------------------------------------
// Archivo del Proyecto Ventas 
// P�gina del proyecto: http://sourceforge.net/projects/ventas
// --------------------------------------------------------------------------
// Este archivo puede ser distribuido y/o modificado bajo lo terminos de la
// Licencia P�blica General versi�n 2 como es publicada por la Free Software
// Fundation, Inc.
// --------------------------------------------------------------------------

unit ProveedBusq;

interface

uses
  SysUtils, Types, Classes, QGraphics, QControls, QForms, QDialogs,
  QStdCtrls, QGrids, QDBGrids, QButtons, QExtCtrls, QcurrEdit, IniFiles,
  QMenus, QTypes;

type
  TfrmProveedBusq = class(TForm)
    btnBuscar: TBitBtn;
    btnLimpiar: TBitBtn;
    btnSeleccionar: TBitBtn;
    btnSalir: TBitBtn;
    grdProveedores: TDBGrid;
    Label1: TLabel;
    txtRegistros: TcurrEdit;
    rdgBuscar: TRadioGroup;
    rdgOrden: TRadioGroup;
    pnlClave: TPanel;
    txtClaveBusq: TEdit;
    Label2: TLabel;
    pnlNombre: TPanel;
    Label3: TLabel;
    txtNombreBusq: TEdit;
    pnlRfc: TPanel;
    Label4: TLabel;
    txtRfcBusq: TEdit;
    procedure rdgBuscarClick(Sender: TObject);
    procedure btnBuscarClick(Sender: TObject);
    procedure btnLimpiarClick(Sender: TObject);
    procedure btnSeleccionarClick(Sender: TObject);
    procedure btnSalirClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure grdProveedoresEnter(Sender: TObject);
    procedure grdProveedoresExit(Sender: TObject);
    procedure Salta(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure Numero(Sender: TObject; var Key: Char);
  private
    procedure RecuperaConfig;
  public
    sClave, sNombre : String;
  end;

var
  frmProveedBusq: TfrmProveedBusq;

implementation

uses dm;

{$R *.xfm}

procedure TfrmProveedBusq.rdgBuscarClick(Sender: TObject);
begin
    case rdgBuscar.ItemIndex of
        0: begin
            pnlNombre.Visible := false;
            pnlRfc.Visible := false;
            pnlClave.Visible := true;
            pnlNombre.Enabled := false;
            pnlRfc.Enabled := false;
            pnlClave.Enabled := true;
            txtClaveBusq.SetFocus;
           end;
        1: begin
            pnlRfc.Visible := false;
            pnlClave.Visible := false;
            pnlNombre.Visible := true;
            pnlRfc.Enabled := false;
            pnlClave.Enabled := false;
            pnlNombre.Enabled := true;
            txtNombreBusq.SetFocus;
           end;
        2: begin
            pnlNombre.Visible := false;
            pnlClave.Visible := false;
            pnlRfc.Visible := true;
            pnlNombre.Enabled := false;
            pnlClave.Enabled := false;
            pnlRfc.Enabled := true;
            txtRfcBusq.SetFocus;
           end;
    end;
end;

procedure TfrmProveedBusq.btnBuscarClick(Sender: TObject);
var
    sBM : String;
begin
    with dmDatos.qryListados1 do begin
        sBM := dmDatos.cdsCliente1.Bookmark;
        dmDatos.cdsCliente1.Active := false;

        Close;
        SQL.Clear;
        SQL.Add('SELECT clave, nombre, rfc, calle, colonia, cp,');
        SQL.Add('localidad, estado, encargado, telefono, fax, ecorreo, ');
        SQL.Add('categoria, fecha_cap, fecha_umov FROM proveedores WHERE 1=1');

        if(Length(txtClaveBusq.Text) > 0) then begin
            SQL.Add('AND clave = ''' + txtClaveBusq.Text + '''');
        end;
        if(Length(txtNombreBusq.Text) > 0) then begin
            SQL.Add('AND nombre LIKE ''%' + txtNombreBusq.Text + '%''');
        end;
        if(Length(txtRfcBusq.Text) > 0) then begin
            SQL.Add('AND rfc STARTING ''' + txtRfcBusq.Text + '''');
        end;
        case rdgOrden.ItemIndex of
            0:  SQL.Add('ORDER BY clave');
            1:  SQL.Add('ORDER BY rfc');
            2:  SQL.Add('ORDER BY nombre');
        end;
        Open;

        dmDatos.cdsCliente1.Active := true;
        dmDatos.cdsCliente1.FieldByName('calle').Visible := False;
        dmDatos.cdsCliente1.FieldByName('colonia').Visible := False;
        dmDatos.cdsCliente1.FieldByName('cp').Visible := False;
        dmDatos.cdsCliente1.FieldByName('localidad').Visible := False;
        dmDatos.cdsCliente1.FieldByName('estado').Visible := False;
        dmDatos.cdsCliente1.FieldByName('fax').Visible := False;
        dmDatos.cdsCliente1.FieldByName('fecha_cap').Visible := False;
        dmDatos.cdsCliente1.FieldByName('categoria').Visible := False;
        dmDatos.cdsCliente1.FieldByName('clave').DisplayLabel := 'Clave';
        dmDatos.cdsCliente1.FieldByName('clave').DisplayWidth := 5;
        dmDatos.cdsCliente1.FieldByName('nombre').DisplayLabel := 'Nombre';
        dmDatos.cdsCliente1.FieldByName('nombre').DisplayWidth := 30;
        dmDatos.cdsCliente1.FieldByName('rfc').DisplayLabel := 'RFC';
        dmDatos.cdsCliente1.FieldByName('encargado').DisplayLabel := 'Contacto';
        dmDatos.cdsCliente1.FieldByName('encargado').DisplayWidth := 15;
        dmDatos.cdsCliente1.FieldByName('telefono').DisplayLabel := 'Tel�fono';
        dmDatos.cdsCliente1.FieldByName('ecorreo').DisplayLabel := 'Correo';
        dmDatos.cdsCliente1.FieldByName('fecha_umov').DisplayLabel := 'Ultimo movimiento';

        txtRegistros.Value := dmDatos.cdsCliente1.RecordCount;
        try
            dmDatos.cdsCliente1.Bookmark := sBM;
        except
            txtRegistros.Value := txtRegistros.Value;
        end;

        grdProveedores.SetFocus;
    end;
end;

procedure TfrmProveedBusq.btnLimpiarClick(Sender: TObject);
begin
    txtClaveBusq.Clear;
    txtNombreBusq.Clear;
    txtRfcBusq.Clear;
end;

procedure TfrmProveedBusq.btnSeleccionarClick(Sender: TObject);
begin
    if(txtRegistros.Value > 0) then begin
        sClave := dmDatos.cdsCliente1.FieldByName('clave').AsString;
        sNombre := dmDatos.cdsCliente1.FieldByName('nombre').AsString;
        ModalResult := mrOk;
    end;
end;

procedure TfrmProveedBusq.btnSalirClick(Sender: TObject);
begin
    dmDatos.qryListados1.Close;
end;

procedure TfrmProveedBusq.FormClose(Sender: TObject; var Action: TCloseAction);
var
    iniArchivo : TIniFile;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) +'config.ini');
    with iniArchivo do begin
        // Registra la posici�n y de la ventana
        WriteString('ProveedBusq', 'Posy', IntToStr(Top));

        // Registra la posici�n X de la ventana
        WriteString('ProveedBusq', 'Posx', IntToStr(Left));

        //Registra el valor de los botones de radio de buscar
        WriteString('ProveedBusq', 'Buscar', IntToStr(rdgBuscar.ItemIndex));

        //Registra el valor de los botones de radio de orden
        WriteString('ProveedBusq', 'Orden', IntToStr(rdgOrden.ItemIndex));

        Free;
    end;
    dmDatos.qryListados1.Close;
    dmDatos.cdsCliente1.Active := false;
end;

procedure TfrmProveedBusq.FormShow(Sender: TObject);
begin
    rdgBuscarClick(rdgBuscar);
    btnBuscarClick(Sender);
end;

procedure TfrmProveedBusq.grdProveedoresEnter(Sender: TObject);
begin
    btnBuscar.Default := false;
    btnSeleccionar.Default := true;
end;

procedure TfrmProveedBusq.grdProveedoresExit(Sender: TObject);
begin
    btnBuscar.Default := true;
    btnSeleccionar.Default := false;
end;

procedure TfrmProveedBusq.RecuperaConfig;
var
    iniArchivo : TIniFile;
    sIzq, sArriba, sValor : String;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) +'config.ini');

    with iniArchivo do begin
        //Recupera la posici�n Y de la ventana
        sArriba := ReadString('ProveedBusq', 'Posy', '');

        //Recupera la posici�n X de la ventana
        sIzq := ReadString('ProveedBusq', 'Posx', '');

        if (Length(sIzq) > 0) and (Length(sArriba) > 0) then begin
            Left := StrToInt(sIzq);
            Top := StrToInt(sArriba);
        end;

        //Recupera el valor de los botones de radio de buscar
        sValor := ReadString('ProveedBusq', 'Buscar', '');
        if (Length(sValor) > 0) then
            rdgBuscar.ItemIndex := StrToInt(sValor);

        //Recupera el valor de los botones de radio de orden
        sValor := ReadString('ProveedBusq', 'Orden', '');
        if (Length(sValor) > 0) then
            rdgOrden.ItemIndex := StrToInt(sValor);
    end;
end;

procedure TfrmProveedBusq.Salta(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
    {Inicio (36), Fin (35), Izquierda (37), derecha (39), arriba (38), abajo (40)}
    if(Key >= 30) and (Key <= 122) and (Key <> 35) and (Key <> 36) and not ((Key >= 37) and (Key <= 40)) then
        if( Length((Sender as TEdit).Text) = (Sender as TEdit).MaxLength) then
            SelectNext(Sender as TWidgetControl, true, true);
end;

procedure TfrmProveedBusq.FormCreate(Sender: TObject);
begin
    RecuperaConfig;
end;

procedure TfrmProveedBusq.Numero(Sender: TObject; var Key: Char);
begin
    if not (Key in ['0'..'9',#8]) then
        Key := #0;
end;

end.
