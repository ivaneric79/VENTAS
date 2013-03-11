// --------------------------------------------------------------------------
// Archivo del Proyecto Ventas
// P�gina del proyecto: http://sourceforge.net/projects/ventas
// --------------------------------------------------------------------------
// Este archivo puede ser distribuido y/o modificado bajo lo terminos de la
// Licencia P�blica General versi�n 2 como es publicada por la Free Software
// Fundation, Inc.
// --------------------------------------------------------------------------

unit Cajas;

interface

uses
  SysUtils, Types, Classes, QGraphics, QControls, QForms, QDialogs,
  QStdCtrls, QMenus, QTypes, QcurrEdit, QGrids, QDBGrids, Inifiles, QButtons;

type
  TfrmCajas = class(TForm)
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
    txtTicket: TEdit;
    mnuMenu: TMainMenu;
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
    Label3: TLabel;
    txtFactura: TEdit;
    Label4: TLabel;
    txtNota: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    txtNombre: TEdit;
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
  frmCajas: TfrmCajas;

implementation

uses dm;

{$R *.xfm}

procedure TfrmCajas.FormShow(Sender: TObject);
begin
    btnCancelarClick(Sender);
end;

procedure TfrmCajas.RecuperaConfig;
var
    iniArchivo : TIniFile;
    sIzq, sArriba : String;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'config.ini');

    with iniArchivo do begin
        //Recupera la posici�n Y de la ventana
        sArriba := ReadString('Cajas', 'Posy', '');

        //Recupera la posici�n X de la ventana
        sIzq := ReadString('Cajas', 'Posx', '');

        if (Length(sIzq) > 0) and (Length(sArriba) > 0) then begin
            Left := StrToInt(sIzq);
            Top := StrToInt(sArriba);
        end;
        Free;
    end;
end;

procedure TfrmCajas.btnCancelarClick(Sender: TObject);
begin
    sModo := 'Consulta';
    LimpiaDatos;
    Listar;
    ActivaControles;
    Height := 220;
    btnInsertar.SetFocus;
end;

procedure TfrmCajas.LimpiaDatos;
begin
    txtNombre.Clear;
    txtCaja.Value := 0;
    txtTicket.Clear;
    txtNota.Clear;
    txtFactura.Clear;
end;

procedure TfrmCajas.Listar;
var
    sBM : String;
begin
    with dmDatos.qryListados do begin
        sBM := dmDatos.cdsCliente.Bookmark;

        dmDatos.cdsCliente.Active := false;
        Close;
        SQL.Clear;
        SQL.Add('SELECT numero, nombre, serieticket, serienota, seriefactura FROM cajas ORDER BY numero');
        Open;
        dmDatos.cdsCliente.Active := true;

        dmDatos.cdsCliente.FieldByName('numero').DisplayLabel := 'Caja';
        dmDatos.cdsCliente.FieldByName('nombre').DisplayLabel := 'Nombre';
        dmDatos.cdsCliente.FieldByName('numero').DisplayWidth := 6;
        dmDatos.cdsCliente.FieldByName('nombre').DisplayWidth := 13;
        dmDatos.cdsCliente.FieldByName('serieticket').Visible := false;
        dmDatos.cdsCliente.FieldByName('serienota').Visible := false;
        dmDatos.cdsCliente.FieldByName('seriefactura').Visible := false;
        txtRegistros.Value := dmDatos.cdsCliente.RecordCount;
        try
            dmDatos.cdsCliente.Bookmark := sBM;
        except
            txtRegistros.Value := txtRegistros.Value;
        end;
    end;
    RecuperaDatos;
end;

procedure TfrmCajas.ActivaControles;
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
        txtTicket.ReadOnly := False;
        txtTicket.TabStop := True;
        txtFactura.ReadOnly := False;
        txtFactura.TabStop := True;
        txtNota.ReadOnly := False;
        txtNota.TabStop := True;
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
        txtTicket.ReadOnly := true;
        txtTicket.TabStop := false;
        txtFactura.ReadOnly := true;
        txtFactura.TabStop := false;
        txtNota.ReadOnly := true;
        txtNota.TabStop := false;
    end;
end;

procedure TfrmCajas.RecuperaDatos;
begin
    with dmDatos.cdsCliente do begin
        if(Active) then begin
            iClave := FieldByName('numero').AsInteger;
            txtCaja.Value := FieldByName('numero').AsInteger;
            txtNombre.Text := Trim(FieldByName('Nombre').AsString);
            txtTicket.Text := Trim(FieldByName('serieticket').AsString);
            txtNota.Text := Trim(FieldByName('serienota').AsString);
            txtFactura.Text := Trim(FieldByName('seriefactura').AsString);
        end;
    end;
end;

procedure TfrmCajas.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
    iniArchivo : TIniFile;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'config.ini');
    with iniArchivo do begin
        // Registra la posici�n y de la ventana
        WriteString('Cajas', 'Posy', IntToStr(Top));

        // Registra la posici�n X de la ventana
        WriteString('Cajas', 'Posx', IntToStr(Left));
        Free;
    end;
    dmDatos.qryListados.Close;
    dmDatos.cdsCliente.Active := false;
end;

procedure TfrmCajas.btnInsertarClick(Sender: TObject);
begin
    limpiaDatos;
    sModo := 'Insertar';
    Height := 358;
    ActivaControles;
    txtCaja.SetFocus;
end;

procedure TfrmCajas.btnGuardarClick(Sender: TObject);
begin
    if(VerificaDatos) then begin
        GuardaDatos;
        btnCancelarClick(Sender);
    end;
end;
function TfrmCajas.VerificaDatos:boolean;
var
    bRegreso : boolean;
begin
    btnGuardar.SetFocus;
    bRegreso := true;
    if(Length(txtNombre.Text) = 0) then begin
        Application.MessageBox('Introduce el nombre de la caja','Error',[smbOK],smsCritical);
        txtNombre.SetFocus;
        bRegreso := false;
    end
    else if(not VerificaIntegridad) then
        bRegreso := false;

    Result := bRegreso;
end;

function TfrmCajas.VerificaIntegridad:boolean;
var
    bRegreso : boolean;
begin
    bRegreso := true;

    with dmDatos.qryConsulta do begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT numero FROM cajas WHERE numero = ' + FloatToStr(txtCaja.Value));
        Open;

        if(not Eof) and ((sModo = 'Insertar') or ((FieldByName('numero').AsInteger <> iClave) and
            (sModo = 'Modificar'))) then begin
            bRegreso := false;
            Application.MessageBox('La caja ya existe','Error',[smbOK],smsCritical);
            txtNombre.SetFocus;
        end;
        Close;
    end;
    Result := bRegreso;
end;

procedure TfrmCajas.GuardaDatos;
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
            SQL.Add('INSERT INTO cajas (numero, nombre, serieticket, serienota, seriefactura, fecha_umov) VALUES(');
            SQL.Add('''' + txtCaja.Text + ''',''' + txtNombre.Text + ''',');
            SQL.Add('''' + txtTicket.Text + ''',''' + txtNota.Text + ''',');
            SQL.Add('''' + txtFactura.Text + ''',''' + FormatDateTime('mm/dd/yyyy hh:nn:ss',Now) + ''')');
            ExecSQL;
            Close;
        end;
    end
    else begin
        with dmDatos.qryModifica do begin
            Close;
            SQL.Clear;
            SQL.Add('UPDATE cajas SET nombre = ''' + txtNombre.Text + ''',');
            SQL.Add('numero = ' + FloatToStr(txtCaja.Value) + ', serieticket = ''' + txtTicket.Text + ''',');
            SQL.Add('serienota = ''' + txtNota.Text + ''', seriefactura = ''' + txtFactura.Text + ''',');
            SQL.Add('fecha_umov = ''' + FormatDateTime('mm/dd/yyyy hh:nn:ss',Now) + '''');
            SQL.Add('WHERE numero = ' + IntToStr(iClave));
            ExecSQL;
            Close;
        end;
    end;
end;

procedure TfrmCajas.btnEliminarClick(Sender: TObject);
begin
    if(Application.MessageBox('Se eliminar� la caja seleccionada','Eliminar',[smbOK]+[smbCancel]) = smbOK) then begin
        with dmDatos.qryModifica do begin
            Close;
            SQL.Clear;
            SQL.Add('DELETE FROM cajas WHERE numero = ' + dmDatos.cdsCliente.FieldByName('numero').AsString);
            ExecSQL;
            Close;
        end;
        btnCancelarClick(Sender);
    end;
end;

procedure TfrmCajas.btnModificarClick(Sender: TObject);
begin
    if(txtRegistros.Value > 0) then begin
        sModo := 'Modificar';
        RecuperaDatos;
        ActivaControles;
        Height := 358;
        txtCaja.SetFocus;
    end;
end;

procedure TfrmCajas.Salir1Click(Sender: TObject);
begin
    Close;
end;

procedure TfrmCajas.mnuAvanzaClick(Sender: TObject);
begin
    dmDatos.cdsCliente.Next;
end;

procedure TfrmCajas.mnuRetrocedeClick(Sender: TObject);
begin
    dmDatos.cdsCliente.Prior;
end;

procedure TfrmCajas.FormCreate(Sender: TObject);
begin
    RecuperaConfig;
end;

end.
