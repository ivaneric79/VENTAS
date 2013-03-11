// --------------------------------------------------------------------------
// Archivo del Proyecto Ventas     
// Página del proyecto: http://sourceforge.net/projects/ventas
// --------------------------------------------------------------------------
// Este archivo puede ser distribuido y/o modificado bajo lo terminos de la
// Licencia Pública General versión 2 como es publicada por la Free Software
// Fundation, Inc.
// --------------------------------------------------------------------------

unit Tipospago;

interface

uses
  SysUtils, Types, Classes, QGraphics, QControls, QForms, QDialogs, IniFiles,
  QStdCtrls, QMenus, QTypes, QcurrEdit, QGrids, QDBGrids, QButtons;

type
  TfrmTipoPago = class(TForm)
    btnInsertar: TBitBtn;
    btnEliminar: TBitBtn;
    btnModificar: TBitBtn;
    gddListado: TDBGrid;
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
    btnGuardar: TBitBtn;
    btnCancelar: TBitBtn;
    grpCategoria: TGroupBox;
    Label1: TLabel;
    txtNombre: TEdit;
    Label3: TLabel;
    cmbReferencia: TComboBox;
    Label2: TLabel;
    cmbCajon: TComboBox;
    txtRegistros: TcurrEdit;
    Label6: TLabel;
    grpCredito: TGroupBox;
    Label4: TLabel;
    cmbModo: TComboBox;
    txtPagos: TcurrEdit;
    Label5: TLabel;
    txtPlazo: TcurrEdit;
    Label7: TLabel;
    Label8: TLabel;
    txtInteres: TcurrEdit;
    Label9: TLabel;
    txtEnganche: TcurrEdit;
    Label11: TLabel;
    txtMontoMinimo: TcurrEdit;
    Label13: TLabel;
    txtIntMorat: TcurrEdit;
    Label14: TLabel;
    Label12: TLabel;
    chkCompras: TCheckBox;
    chkVentas: TCheckBox;
    Label16: TLabel;
    cmbTipoPlazo: TComboBox;
    cmbTipoInteres: TComboBox;
    Label10: TLabel;
    procedure FormShow(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnInsertarClick(Sender: TObject);
    procedure btnModificarClick(Sender: TObject);
    procedure btnEliminarClick(Sender: TObject);
    procedure btnGuardarClick(Sender: TObject);
    procedure mnuAvanzaClick(Sender: TObject);
    procedure mnuRetrocedeClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure cmbModoChange(Sender: TObject);
    procedure Salir1Click(Sender: TObject);
  private
    iClave : integer;
    sModo : String;

    procedure RecuperaConfig;
    procedure LimpiaDatos;
    procedure Listar;
    procedure ActivaControles;
    procedure RecuperaDatos;
    procedure GuardaDatos;
    function VerificaDatos:boolean;
    function VerificaNombre:boolean;
  public
    { Public declarations }
  end;

var
  frmTipoPago: TfrmTipoPago;

implementation

uses dm;

{$R *.xfm}

procedure TfrmTipoPago.FormShow(Sender: TObject);
begin
    btnCancelarClick(Sender);
end;

procedure TfrmTipoPago.RecuperaConfig;
var
    iniArchivo : TIniFile;
    sIzq, sArriba : String;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) +'config.ini');

    with iniArchivo do begin
        //Recupera la posición Y de la ventana
        sArriba := ReadString('Tipopago', 'Posy', '');

        //Recupera la posición X de la ventana
        sIzq := ReadString('Tipopago', 'Posx', '');

        if (Length(sIzq) > 0) and (Length(sArriba) > 0) then begin
            Left := StrToInt(sIzq);
            Top := StrToInt(sArriba);
        end;
        Free;
    end;
end;

procedure TfrmTipoPago.btnCancelarClick(Sender: TObject);
begin
    sModo := 'Consulta';
    LimpiaDatos;
    Listar;
    ActivaControles;
    Height := 240;
    btnInsertar.SetFocus;
end;

procedure TfrmTipoPago.LimpiaDatos;
begin
    txtNombre.Clear;
    cmbCajon.ItemIndex := 0;
    cmbReferencia.ItemIndex := 0;
    txtPagos.Value := 0;
    txtPlazo.Value := 0;
    txtEnganche.Value := 0;
    txtMontoMinimo.Value := 0;
    txtInteres.Value := 0;
    txtIntMorat.Value := 0;
end;

procedure TfrmTipoPago.Listar;
var
    sBM : String;
begin
    with dmDatos.qryListados do begin
        sBM := dmDatos.cdsCliente.Bookmark;

        dmDatos.cdsCliente.Active := false;
        Close;
        SQL.Clear;
        SQL.Add('SELECT clave, nombre, abrircajon, referencia, modo, aplica,');
        SQL.Add('pagos, plazo, enganche, montominimo, interes,');
        SQL.Add('intmoratorio, tipointeres, tipoplazo FROM tipopago ORDER BY nombre');
        Open;
        dmDatos.cdsCliente.Active := true;

        txtRegistros.Value := dmDatos.cdsCliente.RecordCount;
        dmDatos.cdsCliente.FieldByName('clave').Visible := false;
        dmDatos.cdsCliente.FieldByName('nombre').DisplayLabel := 'Nombre';
        dmDatos.cdsCliente.FieldByName('abrircajon').DisplayLabel := 'Abrir cajón';
        dmDatos.cdsCliente.FieldByName('referencia').DisplayLabel := 'Referencia';
        dmDatos.cdsCliente.FieldByName('modo').DisplayLabel := 'Modo de pago';
        dmDatos.cdsCliente.FieldByName('modo').DisplayWidth := 18;
        dmDatos.cdsCliente.FieldByName('pagos').Visible := false;
        dmDatos.cdsCliente.FieldByName('plazo').Visible := false;
        dmDatos.cdsCliente.FieldByName('enganche').Visible := false;
        dmDatos.cdsCliente.FieldByName('montominimo').Visible := false;
        dmDatos.cdsCliente.FieldByName('interes').Visible := false;
        dmDatos.cdsCliente.FieldByName('intmoratorio').Visible := false;
        dmDatos.cdsCliente.FieldByName('tipointeres').Visible := false;
        dmDatos.cdsCliente.FieldByName('aplica').Visible := false;
        dmDatos.cdsCliente.FieldByName('tipoplazo').Visible := false;
        try
            dmDatos.cdsCliente.Bookmark := sBM;
        except
            btnInsertar.SetFocus;
        end;
    end;
    RecuperaDatos;
end;

procedure TfrmTipoPago.ActivaControles;
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
        cmbReferencia.Enabled := true;
        cmbcajon.Enabled := true;
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
        cmbReferencia.Enabled := false;
        cmbCajon.Enabled := false;
    end;
end;

procedure TfrmTipoPago.RecuperaDatos;
var
    sAplica, sModo : string;
begin
    with dmDatos.cdsCliente do begin
        if(Active) then begin
            iClave := FieldByName('Clave').AsInteger;
            txtNombre.Text := Trim(FieldByName('nombre').AsString);
            if(FieldByName('referencia').AsString = 'S') then
                cmbReferencia.ItemIndex := 0
            else
                cmbReferencia.ItemIndex := 1;

            if(FieldByName('abrircajon').AsString = 'S') then
                cmbCajon.ItemIndex := 0
            else
                cmbCajon.ItemIndex := 1;

            sAplica := FieldByName('aplica').AsString;
            if(Pos('V',sAplica) > 0) then
                chkVentas.Checked := true
            else
                chkVentas.Checked := false;

            if(Pos('C',sAplica) > 0) then
                chkCompras.Checked := true
            else
                chkCompras.Checked := false;
            sModo := Trim(FieldByName('modo').AsString);
            if(sModo = 'CREDITO') then begin
                cmbModo.ItemIndex := 1;
                txtPagos.Value := FieldByName('pagos').AsInteger;
                txtPlazo.Value := FieldByName('plazo').AsInteger;
                txtEnganche.Value := FieldByName('enganche').AsFloat;
                txtMontoMinimo.Value := FieldByName('montominimo').AsFloat;
                txtInteres.Value := FieldByName('interes').AsFloat;
                txtIntMorat.Value := FieldByName('intmoratorio').AsFloat;
                if(FieldByName('tipointeres').AsString = 'S') then
                    cmbTipoInteres.ItemIndex := 0
                else
                    cmbTipoInteres.ItemIndex := 1;
                if(FieldByName('tipoplazo').AsInteger = 360) then
                    cmbTipoPlazo.ItemIndex := 0
                else
                    cmbTipoPlazo.ItemIndex := 1;
            end
            else if(sModo = 'CONTADO') then
                cmbModo.ItemIndex := 0
            else
                cmbModo.ItemIndex := 2;

            cmbModoChange(cmbModo);
        end;
    end;
end;

procedure TfrmTipoPago.btnInsertarClick(Sender: TObject);
begin
    LimpiaDatos;
    sModo := 'Insertar';
    Height := 326;
    ActivaControles;
    cmbModoChange(cmbModo);
    txtNombre.SetFocus;
end;

procedure TfrmTipoPago.btnModificarClick(Sender: TObject);
begin
    if(txtRegistros.Value > 0) then begin
        sModo := 'Modificar';
        Height := 326;
        RecuperaDatos;
        ActivaControles;
        txtNombre.SetFocus;
    end;
end;

procedure TfrmTipoPago.btnEliminarClick(Sender: TObject);
begin
    if(Application.MessageBox('Se eliminará el tipo de pago seleccionado','Eliminar',[smbOK]+[smbCancel],smsWarning) = smbOK) then begin
        with dmDatos.qryModifica do begin
            Close;
            SQL.Clear;
            SQL.Add('DELETE FROM tipopago WHERE clave = ' + dmDatos.cdsCliente.FieldByName('clave').AsString);
            ExecSQL;
            Close;
        end;
        btnCancelarClick(Sender);
    end;
end;

procedure TfrmTipoPago.btnGuardarClick(Sender: TObject);
begin
    if(VerificaDatos) then begin
        GuardaDatos;
        btnCancelarClick(Sender);
    end;
end;

function TfrmTipoPago.VerificaDatos:boolean;
var
    bRegreso : boolean;
begin
    bRegreso := true;
    btnGuardar.SetFocus;
    if(Length(txtNombre.Text) = 0) then begin
        Application.MessageBox('Introduce el nombre del tipo de pago','Error',[smbOK],smsCritical);
        txtNombre.SetFocus;
        bRegreso := false;
    end
    else if(not chkVentas.Checked) and (not chkCompras.Checked) then begin
        Application.MessageBox('Seleccione donde se aplicará este tipo de pago (ventas y/o compras)','Error',[smbOK],smsCritical);
        chkCompras.SetFocus;
        bRegreso := false;
    end
    else if(not VerificaNombre) then
        bRegreso := false
    else if(cmbModo.Text = 'CREDITO') and (txtPagos.Value = 0) then begin
        Application.MessageBox('Introduce el número de pagos','Error',[smbOK],smsCritical);
        txtPagos.SetFocus;
        bRegreso := false;
    end
    else if(cmbModo.Text = 'CREDITO') and (txtPlazo.Value = 0) then begin
        Application.MessageBox('Introduce los días de plazo','Error',[smbOK],smsCritical);
        txtPlazo.SetFocus;
        bRegreso := false;
    end
    else if(cmbModo.Text = 'CREDITO') and (txtEnganche.Value > 99.99) then begin
        Application.MessageBox('El enganche no puede superar del 99.99%','Error',[smbOK],smsCritical);
        txtEnganche.SetFocus;
        bRegreso := false;
    end
    else if(cmbModo.Text = 'CREDITO') and (txtInteres.Value > 99.99) then begin
        Application.MessageBox('El interés no puede superar del 99.99%','Error',[smbOK],smsCritical);
        txtInteres.SetFocus;
        bRegreso := false;
    end
    else if(cmbModo.Text = 'CREDITO') and (txtIntMorat.Value > 99.99) then begin
        Application.MessageBox('El interés moratorio no puede superar del 99.99%','Error',[smbOK],smsCritical);
        txtIntMorat.SetFocus;
        bRegreso := false;
    end;

    Result := bRegreso;
end;

function TfrmTipoPago.VerificaNombre:boolean;
var
    bRegreso : boolean;
begin
    bRegreso := true;

    with dmDatos.qryConsulta do begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT * FROM tipopago WHERE nombre = ''' + txtNombre.Text + '''');
        Open;

        if(not Eof) and ((sModo = 'Insertar') or
            ((FieldByName('clave').AsInteger <> iClave) and
            (sModo = 'Modificar'))) then begin
            bRegreso := false;
            Application.MessageBox('El tipo de pago ya existe','Error',[smbOK],smsCritical);
            txtNombre.SetFocus;
        end;
        Close;
     end;
    Result := bRegreso;
end;

procedure TfrmTipoPago.GuardaDatos;
var
    sAplica : String;
begin
    if(chkCompras.Checked) then
        sAplica := 'C'
    else
        sAplica := '';
    if(chkVentas.Checked) then
        sAplica := sAplica + 'V';

    if(sModo = 'Insertar') then begin
        with dmDatos.qryModifica do begin
            Close;
            SQL.Clear;
            SQL.Add('INSERT INTO tipopago (nombre, referencia, abrircajon, modo,');
            SQL.Add('aplica, pagos, plazo, interes, enganche, montominimo,');
            SQL.Add('intmoratorio, tipointeres, tipoplazo, fecha_umov) VALUES(');
            SQL.Add('''' + txtNombre.Text + ''',');
            SQL.Add('''' + Copy(cmbReferencia.Text,1,1) + ''',');
            SQL.Add('''' + Copy(cmbCajon.Text,1,1) + ''',');
            SQL.Add('''' + cmbModo.Text + ''',');
            SQL.Add('''' + sAplica + ''',');
            if(cmbModo.Text = 'CREDITO') then begin
                SQL.Add(FloatToStr(txtPagos.Value) + ',');
                SQL.Add(FloatToStr(txtPlazo.Value) + ',');
                SQL.Add(FloatToStr(txtInteres.Value) + ',');
                SQL.Add(FloatToStr(txtEnganche.Value) + ',');
                SQL.Add(FloatToStr(txtMontoMinimo.Value) + ',');
                SQL.Add(FloatToStr(txtIntMorat.Value) + ',');
                if(cmbTipoInteres.ItemIndex = 0) then
                    SQL.Add('''S'',')
                else
                    SQL.Add('''C'',');
                if(cmbTipoPlazo.ItemIndex = 0) then
                    SQL.Add('360,')
                else
                    SQL.Add('365,');
            end
            else
                SQL.Add('null, null, null, null, null, null, null, 365,');
            SQL.Add('''' + FormatDateTime('mm/dd/yyyy hh:nn:ss',Now) + ''')');
            ExecSQL;
            Close;
        end;
    end
    else begin
        with dmDatos.qryModifica do begin
            Close;
            SQL.Clear;
            SQL.Add('UPDATE tipopago SET nombre = ''' + txtNombre.Text + ''',');
            SQL.Add('referencia = ''' + Copy(cmbReferencia.Text,1,1) + ''',');
            SQL.Add('abrircajon = ''' + Copy(cmbCajon.Text,1,1) + ''',');
            SQL.Add('modo = ''' + cmbModo.Text + ''',');
            SQL.Add('aplica = ''' + sAplica + ''',');
            if(cmbModo.Text = 'CREDITO') then begin
                SQL.Add('pagos = ' + FloatToStr(txtPagos.Value) +',');
                SQL.Add('plazo = ' + FloatToStr(txtPlazo.Value) +',');
                SQL.Add('interes = ' + FloatToStr(txtInteres.Value) +',');
                SQL.Add('enganche = ' + FloatToStr(txtEnganche.Value) +',');
                SQL.Add('montominimo = ' + FloatToStr(txtMontoMinimo.Value) +',');
                SQL.Add('intmoratorio = ' + FloatToStr(txtIntMorat.Value) +',');
                if(cmbTipoInteres.ItemIndex = 0) then
                    SQL.Add('tipointeres = ''S'',')
                else
                    SQL.Add('tipointeres = ''C'',');
                if(cmbTipoPlazo.ItemIndex = 0) then
                    SQL.Add('tipoplazo = 360,')
                else
                    SQL.Add('tipoplazo = 365,');
            end
            else begin
                SQL.Add('pagos = null, plazo = null, interes = null,');
                SQL.Add('enganche = null, intmoratorio = null,');
                SQL.Add('montominimo = null, tipointeres = null,');
            end;
            SQL.Add('fecha_umov = ''' + FormatDateTime('mm/dd/yyyy hh:nn:ss',Now) + '''');
            SQL.Add('WHERE clave = ' +  IntToStr(iClave));
            ExecSQL;
            Close;
        end;
    end;
end;

procedure TfrmTipoPago.mnuAvanzaClick(Sender: TObject);
begin
    dmDatos.cdsCliente.Next;
end;

procedure TfrmTipoPago.mnuRetrocedeClick(Sender: TObject);
begin
    dmDatos.cdsCliente.Prior;
end;

procedure TfrmTipoPago.FormClose(Sender: TObject;  var Action: TCloseAction);
var
    iniArchivo : TIniFile;
begin
    dmDatos.cdsCliente.Active := false;
    dmDatos.qryListados.Close;

    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) +'config.ini');
    with iniArchivo do begin
        // Registra la posición y de la ventana
        WriteString('Tipopago', 'Posy', IntToStr(Top));

        // Registra la posición X de la ventana
        WriteString('Tipopago', 'Posx', IntToStr(Left));

        Free;
    end;
end;

procedure TfrmTipoPago.FormCreate(Sender: TObject);
begin
    RecuperaConfig;
end;

procedure TfrmTipoPago.cmbModoChange(Sender: TObject);
begin
    if(cmbModo.Text <> 'CREDITO') then begin
        grpCredito.Enabled := false;
        grpCredito.Visible := false;
        Height := 330;
    end
    else begin
        grpCredito.Enabled := true;
        grpCredito.Visible := true;
        Height := 444;
    end;
end;

procedure TfrmTipoPago.Salir1Click(Sender: TObject);
begin
    Close;
end;

end.
