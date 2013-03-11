// --------------------------------------------------------------------------
// Archivo del Proyecto Ventas
// Página del proyecto: http://sourceforge.net/projects/ventas
// --------------------------------------------------------------------------
// Este archivo puede ser distribuido y/o modificado bajo lo terminos de la
// Licencia Pública General versión 2 como es publicada por la Free Software
// Fundation, Inc.
// --------------------------------------------------------------------------

unit AreasVenta;

interface

uses
  SysUtils, Types, Classes, QGraphics, QControls, QForms, QDialogs,
  QStdCtrls, QMenus, QTypes, QcurrEdit, QGrids, QDBGrids, Inifiles, QButtons;

type
  TfrmAreasVenta = class(TForm)
    btnInsertar: TBitBtn;
    btnEliminar: TBitBtn;
    btnModificar: TBitBtn;
    btnGuardar: TBitBtn;
    btnCancelar: TBitBtn;
    gddListado: TDBGrid;
    lblRegistros: TLabel;
    txtRegistros: TcurrEdit;
    grpDatos: TGroupBox;
    Label1: TLabel;
    txtNombre: TEdit;
    MainMenu1: TMainMenu;
    Archivo1: TMenuItem;
    mnuInsertar: TMenuItem;
    mnuEliminar: TMenuItem;
    mnuModificar: TMenuItem;
    N3: TMenuItem;
    mnuGuardar: TMenuItem;
    mnuCancelar: TMenuItem;
    N2: TMenuItem;
    Salir1: TMenuItem;
    mnuConsulta: TMenuItem;
    mnuAvanza: TMenuItem;
    mnuRetrocede: TMenuItem;
    Label2: TLabel;
    txtCaja: TcurrEdit;
    procedure FormShow(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnInsertarClick(Sender: TObject);
    procedure btnGuardarClick(Sender: TObject);
    procedure btnEliminarClick(Sender: TObject);
    procedure btnModificarClick(Sender: TObject);
    procedure Salir1Click(Sender: TObject);
    procedure mnuAvanzaClick(Sender: TObject);
    procedure mnuRetrocedeClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);

    private
    sModo:String;
    iClave:Integer;

    procedure RecuperaConfig;
    procedure LimpiaDatos;
    procedure Listar;
    procedure ActivaControles;
    procedure RecuperaDatos;
    procedure GuardaDatos;

    function VerificaIntegridad:boolean;
    function  VerificaDatos:boolean;
  public
  end;

var
  frmAreasVenta: TfrmAreasVenta;

implementation

uses dm;

{$R *.xfm}

procedure TfrmAreasVenta.FormShow(Sender: TObject);
begin
    btnCancelarClick(Sender);
end;

procedure TfrmAreasVenta.RecuperaConfig;
var
    iniArchivo : TIniFile;
    sIzq, sArriba : String;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'config.ini');

    with iniArchivo do begin
        //Recupera la posición Y de la ventana
        sArriba := ReadString('AreasVenta', 'Posy', '');

        //Recupera la posición X de la ventana
        sIzq := ReadString('AreasVenta', 'Posx', '');

        if (Length(sIzq) > 0) and (Length(sArriba) > 0) then begin
            Left := StrToInt(sIzq);
            Top := StrToInt(sArriba);
        end;
        Free;
    end;
end;

procedure TfrmAreasVenta.btnCancelarClick(Sender: TObject);
begin
    sModo := 'Consulta';
    LimpiaDatos;
    Listar;
    ActivaControles;
    Height := 220;
    btnInsertar.SetFocus;
end;

procedure TfrmAreasVenta.LimpiaDatos;
begin
    txtNombre.Clear;
    txtCaja.Value:=0;
end;

procedure TfrmAreasVenta.Listar;
var
    sBM : String;
begin
    with dmDatos.qryListados do begin
        sBM := dmDatos.cdsCliente.Bookmark;

        dmDatos.cdsCliente.Active := false;
        Close;
        SQL.Clear;
        SQL.Add('SELECT clave, nombre, caja FROM AreasVenta ORDER BY nombre');
        Open;
        dmDatos.cdsCliente.Active := true;

        dmDatos.cdsCliente.FieldByName('clave').Visible := false;
        dmDatos.cdsCliente.FieldByName('nombre').DisplayLabel := 'Área de Venta';
        dmDatos.cdsCliente.FieldByName('caja').DisplayLabel := 'Caja';
        dmDatos.cdsCliente.FieldByName('nombre').DisplayWidth := 13;
        dmDatos.cdsCliente.FieldByName('caja').DisplayWidth := 6;
        txtRegistros.Value := dmDatos.cdsCliente.RecordCount;
        try
            dmDatos.cdsCliente.Bookmark := sBM;
        except
            txtRegistros.Value := txtRegistros.Value;
        end;
    end;
    RecuperaDatos;
end;

procedure TfrmAreasVenta.ActivaControles;
begin
    if( (sModo = 'Insertar') or (sModo = 'Modificar') ) then begin
        btnInsertar.Enabled := false;
        btnModificar.Enabled := false;
        btnEliminar.Enabled := false;
        mnuInsertar.Enabled := false;
        mnuModificar.Enabled := false;
        mnuEliminar.Enabled := false;


        btnGuardar.Enabled := true;
        btnCancelar.Enabled := true;
        mnuGuardar.Enabled := true;
        mnuCancelar.Enabled := true;

        mnuConsulta.Enabled := false;

        txtNombre.ReadOnly := false;
        txtNombre.TabStop := true;

        txtCaja.ReadOnly := False;
        txtCaja.TabStop := True;
    end;
    if(sModo = 'Consulta') then begin
        btnInsertar.Enabled := true;
        mnuInsertar.Enabled := true;
        if(txtRegistros.Value > 0) then begin
            btnModificar.Enabled := true;
            btnEliminar.Enabled := true;
            mnuModificar.Enabled := true;
            mnuEliminar.Enabled := true;
        end
        else begin
            btnModificar.Enabled := false;
            btnEliminar.Enabled := false;
            mnuModificar.Enabled := false;
            mnuEliminar.Enabled := false;
        end;

        btnGuardar.Enabled := false;
        btnCancelar.Enabled := false;
        mnuGuardar.Enabled := false;
        mnuCancelar.Enabled := false;

        mnuConsulta.Enabled := true;

        txtNombre.ReadOnly := true;
        txtNombre.TabStop := false;

        txtCaja.ReadOnly := true;
        txtCaja.TabStop := false;
    end;
end;

procedure TfrmAreasVenta.RecuperaDatos;
begin
    with dmDatos.cdsCliente do begin
        if(Active) then begin
            iClave := FieldByName('Clave').AsInteger;
            txtNombre.Text := Trim(FieldByName('Nombre').AsString);
            txtCaja.Value := FieldByName('Caja').AsInteger;
        end;
    end;
end;

procedure TfrmAreasVenta.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
    iniArchivo : TIniFile;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'config.ini');
    with iniArchivo do begin
        // Registra la posición y de la ventana
        WriteString('AreasVenta', 'Posy', IntToStr(Top));

        // Registra la posición X de la ventana
        WriteString('AreasVenta', 'Posx', IntToStr(Left));
        Free;
    end;
    dmDatos.qryListados.Close;
    dmDatos.cdsCliente.Active := false;
end;

procedure TfrmAreasVenta.btnInsertarClick(Sender: TObject);
begin
    limpiaDatos;
    sModo := 'Insertar';
    Height := 320;
    ActivaControles;
    txtNombre.SetFocus;
end;

procedure TfrmAreasVenta.btnGuardarClick(Sender: TObject);
begin
    if(VerificaDatos) then begin
        GuardaDatos;
        btnCancelarClick(Sender);
    end;
end;
function TfrmAreasVenta.VerificaDatos:boolean;
var
    bRegreso : boolean;
begin
    btnGuardar.SetFocus;
    bRegreso := true;
    if(Length(txtNombre.Text) = 0) then begin
        Application.MessageBox('Introduce el nombre del área de venta','Error',[smbOK],smsCritical);
        txtNombre.SetFocus;
        bRegreso := false;
    end
    else if(not VerificaIntegridad) then
        bRegreso := false;

    Result := bRegreso;
end;

function TfrmAreasVenta.VerificaIntegridad:boolean;
var
    bRegreso : boolean;
begin
    bRegreso := true;

    with dmDatos.qryConsulta do begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT * FROM areasventa WHERE nombre = ''' + txtNombre.Text + '''');
        Open;

        if(not Eof) and ((sModo = 'Insertar') or
            ((FieldByName('clave').AsInteger <> iClave) and
            (sModo = 'Modificar'))) then begin
            bRegreso := false;
            Application.MessageBox('El área de venta ya existe','Error',[smbOK],smsCritical);
            txtNombre.SetFocus;
        end;
        Close;
    end;
    Result := bRegreso;
end;

procedure TfrmAreasVenta.GuardaDatos;
var
    sCaja : String;
begin
    if(txtCaja.Value = 0) then
        sCaja := 'null'
    else
        sCaja := FloatToStr(txtCaja.Value);
    if(sModo = 'Insertar') then begin
        with dmDatos.qryModifica do begin
            Close;
            SQL.Clear;
            SQL.Add('INSERT INTO areasventa (nombre, caja, fecha_umov) VALUES(');
            SQL.Add('''' + txtNombre.Text + ''',' + sCaja + ',''' + FormatDateTime('mm/dd/yyyy hh:nn:ss',Now) + ''')');
            ExecSQL;
            Close;
        end;
    end
    else begin
        with dmDatos.qryModifica do begin
            Close;
            SQL.Clear;
            SQL.Add('UPDATE areasventa SET nombre = ''' + txtNombre.Text + ''',');
            SQL.Add('caja = ' + sCaja + ', fecha_umov = ''' + FormatDateTime('mm/dd/yyyy hh:nn:ss',Now) + '''');
            SQL.Add('WHERE clave = ' + IntToStr(iClave));
            ExecSQL;
            Close;
        end;
    end;
end;

procedure TfrmAreasVenta.btnEliminarClick(Sender: TObject);
begin
    if(Application.MessageBox('Se eliminará el área de venta seleccionada','Eliminar',[smbOK]+[smbCancel]) = smbOK) then begin
        with dmDatos.qryModifica do begin
            Close;
            SQL.Clear;
            SQL.Add('DELETE FROM areasventa WHERE clave = ' + dmDatos.cdsCliente.FieldByName('clave').AsString);
            ExecSQL;
            Close;
        end;
        btnCancelarClick(Sender);
    end;
end;

procedure TfrmAreasVenta.btnModificarClick(Sender: TObject);
begin
    if(txtRegistros.Value > 0) then begin
        sModo := 'Modificar';
        RecuperaDatos;
        ActivaControles;
        Height := 320;
        txtNombre.SetFocus;
    end;
end;

procedure TfrmAreasVenta.Salir1Click(Sender: TObject);
begin
    Close;
end;

procedure TfrmAreasVenta.mnuAvanzaClick(Sender: TObject);
begin
    dmDatos.cdsCliente.Next;
end;

procedure TfrmAreasVenta.mnuRetrocedeClick(Sender: TObject);
begin
    dmDatos.cdsCliente.Prior;
end;

procedure TfrmAreasVenta.FormCreate(Sender: TObject);
begin
    RecuperaConfig;
end;

end.
