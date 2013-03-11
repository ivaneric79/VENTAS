// --------------------------------------------------------------------------
// Archivo del Proyecto Ventas     
// Página del proyecto: http://sourceforge.net/projects/ventas
// --------------------------------------------------------------------------
// Este archivo puede ser distribuido y/o modificado bajo lo terminos de la
// Licencia Pública General versión 2 como es publicada por la Free Software
// Fundation, Inc.
// --------------------------------------------------------------------------

unit Cliente;

interface

uses
  SysUtils, Types, Classes, QGraphics, QControls, QForms, QDialogs,
  QStdCtrls, QExtCtrls, QButtons, Inifiles, QMenus, QTypes, StrUtils;


type
  TfrmCliente = class(TForm)
    grpCliente: TGroupBox;
    Label15: TLabel;
    txtRfc: TEdit;
    Label16: TLabel;
    txtCalle: TEdit;
    Label22: TLabel;
    txtLocalidad: TEdit;
    Celular: TLabel;
    txtCelular: TEdit;
    Label36: TLabel;
    txtCorreo: TEdit;
    Label23: TLabel;
    Label34: TLabel;
    txtTelefono: TEdit;
    Label21: TLabel;
    txtColonia: TEdit;
    Label24: TLabel;
    txtCp: TEdit;
    Label25: TLabel;
    txtNombre: TEdit;
    btnCancelar: TBitBtn;
    btnAceptar: TBitBtn;
    pnlClientes: TPanel;
    ppmMenu: TPopupMenu;
    mnuClientes: TMenuItem;
   


    nexterior: TEdit;
    ninterior: TEdit;
    slestado: TComboBox;
    label1: TLabel;
    Label2: TLabel;
   
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnAceptarClick(Sender: TObject);
    procedure txtRfcExit(Sender: TObject);
    procedure mnuClientesClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure RecuperaConfig;
    procedure RecuperaDatos;
    procedure LimpiaDatos;
    procedure GuardaDatos;
    function VerificaDatos:boolean;
    procedure ConvierteComillas(Sender : TWidgetControl);
  public
    bAceptar : boolean;
    iCliente, iPrecio : Integer;
    sCliente, sCreden : String;
    rDescuento, rLimiteCredito : real;
    dteFechaVencim : TDateTime;
  end;
                           
var
  frmCliente: TfrmCliente;

implementation

uses dm, ClientesBusq;

{$R *.xfm}

procedure TfrmCliente.FormShow(Sender: TObject);
begin
    bAceptar := false;
    txtRfc.SetFocus;
    if(iCliente > 0) then
        RecuperaDatos
    else
        LimpiaDatos;
end;


procedure TfrmCliente.RecuperaConfig;
var
    iniArchivo : TIniFile;
    sIzq, sArriba : String;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) +'config.ini');

    with iniArchivo do begin
        //Recupera la posición Y de la ventana
        sArriba := ReadString('Cliente', 'Posy', '');

        //Recupera la posición X de la ventana
        sIzq := ReadString('Cliente', 'Posx', '');

        if (Length(sIzq) > 0) and (Length(sArriba) > 0) then begin
            Left := StrToInt(sIzq);
            Top := StrToInt(sArriba);
        end;

        Free;
    end;
end;

procedure TfrmCliente.RecuperaDatos;
begin
     with dmDatos.qryModifica do begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT * FROM clientes WHERE clave = ' + IntToStr(iCliente));
        Open;

        txtRfc.Text := Trim(FieldByName('rfc').AsString);
        txtNombre.Text := Trim(FieldByName('nombre').AsString);
        txtCalle.Text := Trim(FieldByName('calle').AsString);
        txtColonia.Text := Trim(FieldByName('colonia').AsString);
        txtLocalidad.Text := Trim(FieldByName('localidad').AsString);
      //  txtEstado.Text := Trim(FieldByName('estado').AsString);
          nexterior.Text:= Trim(FieldByName('nexterior').AsString);
          ninterior.Text:= Trim(FieldByName('ninterior').AsString);
         txtCorreo.Text:=  Trim(FieldByName('ecorreo').AsString);
        slestado.Text := Trim(FieldByName('estado').AsString);
        txtCp.Text := Trim(FieldByName('cp').AsString);
        txtTelefono.Text := Trim(FieldByName('telefono').AsString);
        txtCelular.Text := Trim(FieldByName('celular').AsString);
        rDescuento := FieldByName('descuento').AsFloat;
        iPrecio := FieldByName('precio').AsInteger;
        sCreden := Trim(FieldByName('credencial').AsString);
        dteFechaVencim := FieldByName('vencimcreden').AsDateTime;
        rLimiteCredito := FieldByName('limitecredito').AsFloat;
        Close;
    end;
end;

procedure TfrmCliente.LimpiaDatos;
begin
    txtRfc.Clear;
    txtNombre.Clear;
    txtCalle.Clear;
    txtColonia.Clear;
    txtLocalidad.Clear;
  //  txtEstado.Clear;
  ninterior.Clear;
  nexterior.Clear;
  //slestado.Clear;
    txtCp.Clear;
    txtTelefono.Clear;
    txtCelular.Clear;
    txtCorreo.Clear;
end;

procedure TfrmCliente.FormClose(Sender: TObject; var Action: TCloseAction);
var
    iniArchivo : TIniFile;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) +'config.ini');
    with iniArchivo do begin
        // Registra la posición y de la ventana
        WriteString('Cliente', 'Posy', IntToStr(Top));

        // Registra la posición X de la ventana
        WriteString('Cliente', 'Posx', IntToStr(Left));
        Free;
    end;
end;

procedure TfrmCliente.btnAceptarClick(Sender: TObject);
begin
    if(VerificaDatos) then begin
        GuardaDatos;
        sCliente := txtNombre.Text;
        bAceptar := true;
        Close;
    end;
end;

function TfrmCliente.VerificaDatos:boolean;
var
    bRegreso : boolean;
begin
    ConvierteComillas(grpCliente);
    bRegreso := true;
    if(Length(txtNombre.Text) = 0) then begin
        Application.MessageBox('Introduce el nombre del cliente','Error',[smbOK],smsCritical);
        txtNombre.SetFocus;
        bRegreso := false;
    end;
     Result := bRegreso;
end;

procedure TfrmCliente.ConvierteComillas(Sender : TWidgetControl);
var
    i : integer;
    sTexto : String;
begin
    for i := 0 to Sender.ControlCount - 1 do begin
        if(Sender.Controls[i] is TEdit) then begin
            sTexto := (Sender.Controls[i] as TEdit).Text;
            sTexto := AnsiReplaceStr(sTexto,'''', '´');
            sTexto := AnsiReplaceStr(sTexto,'"', '´');
            (Sender.Controls[i] as TEdit).Text := sTexto;
        end;
    end;
end;

procedure TfrmCliente.GuardaDatos;
begin
    with dmDatos.qryModifica do begin
        if(Length(txtNombre.Text)> 0) then begin
            Close;
            SQL.Clear;
            SQL.Add('SELECT clave, precio FROM clientes WHERE nombre = ''' + txtNombre.Text + '''');
            Open;
        end;
        if(Eof) then begin
            if(Length(txtRfc.Text)> 0) then begin
                Close;
                SQL.Clear;
                SQL.Add('SELECT clave, precio FROM clientes WHERE rfc = ''' + txtRfc.Text + '''');
                Open;
            end;
        end;

        if(Eof) then begin
            Close;
            SQL.Clear;
            SQL.Add('INSERT INTO clientes (nombre, rfc, calle, colonia, localidad,');
            SQL.Add('estado, cp, fechacap, fechaumov, descuento, telefono, celular, ecorreo,nexterior,ninterior,');
            SQL.Add('precio, acumulado) VALUES(');
            SQL.Add('''' + txtNombre.Text + ''',''' + txtRfc.Text +''',');
            SQL.Add('''' + txtCalle.Text + ''',''' + txtColonia.Text + ''',');
            SQL.Add('''' + txtLocalidad.Text + ''',''' + trim(slestado.Text) + ''',''' + txtCp.Text + ''',');
            SQL.Add(''''+ FormatDateTime('mm/dd/yyyy',Date) + ''',');
            SQL.Add(''''+ FormatDateTime('mm/dd/yyyy',Date) + ''',');
            SQL.Add('0,''' + txtTelefono.Text + ''',');
            SQL.Add('''' + txtCelular.Text + ''','''+ txtCorreo.Text  + ''',''' + nexterior.Text + ''',''' + ninterior.Text +''',1,0)');


            //SQL.Add('''' + txtCelular.Text + ''',1,0)');
            ExecSQL;

            Close; // Busca la clave que asigno el generador
            SQL.Clear;
            SQL.Add('SELECT clave FROM clientes WHERE nombre = ''' + txtNombre.Text + '''');
            Open;
            iCliente := FieldByName('clave').AsInteger;
            iPrecio := 1;
        end
        else begin
            iCliente := FieldByName('clave').AsInteger;
            iPrecio := FieldByName('precio').AsInteger;
            Close;
            SQL.Clear;
            SQL.Add('UPDATE clientes SET clave = ' + IntToStr(iCliente)+',');
            SQL.Add('nombre = ''' + txtNombre.Text + ''',');
            SQL.Add('rfc = ''' + txtRfc.Text + ''',');
            SQL.Add('calle = ''' + txtCalle.Text + ''',');
            SQL.Add('colonia = ''' + txtColonia.Text + ''',');
            SQL.Add('localidad = ''' + txtLocalidad.Text + ''',');
            SQL.Add('estado = ''' + trim(slestado.Text) + ''',');
            SQL.Add('cp = ''' + txtCp.Text + ''',');
            SQL.Add('telefono = ''' + txtTelefono.Text + ''',');
             SQL.Add('NEXTERIOR = ''' + nexterior.Text + ''',');
            SQL.Add('NINTERIOR = ''' + ninterior.Text + ''',');
            SQL.Add('ecorreo = ''' + txtCorreo.Text + ''',');
            SQL.Add('fechaumov = ''' + FormatDateTime('mm/dd/yyyy',Date) + ''',');
            SQL.Add('celular = ''' + txtCelular.Text + '''');
            SQL.Add('WHERE clave = ' + IntToStr(iCliente));
            ExecSQL;
        end;
        Close;
    end;
end;

procedure TfrmCliente.txtRfcExit(Sender: TObject);
begin
     if(Length(txtRfc.Text) > 0) then begin
        with dmDatos.qryModifica do begin
            Close;
            SQL.Clear;
            SQL.Add('SELECT * FROM clientes WHERE rfc STARTING ''' + txtRfc.Text + '''');
            Open;

            if(not Eof) then begin
                txtRfc.Text := Trim(FieldByName('Rfc').AsString);
                txtNombre.Text := Trim(FieldByName('Nombre').AsString);
                txtCalle.Text := Trim(FieldByName('Calle').AsString);
                txtColonia.Text := Trim(FieldByName('Colonia').AsString);
                txtLocalidad.Text := Trim(FieldByName('Localidad').AsString);
               // txtEstado.Text := Trim(FieldByName('Estado').AsString);
                nexterior.Text:= Trim(FieldByName('nexterior').AsString);
                ninterior.Text:= Trim(FieldByName('ninterior').AsString);


               slestado.Text := Trim(FieldByName('Estado').AsString);
                txtCp.Text := Trim(FieldByName('Cp').AsString);
                txtCelular.Text := Trim(FieldByName('Celular').AsString);
                txtCorreo.Text := Trim(FieldByName('ecorreo').AsString);
                rDescuento := FieldByName('descuento').AsFloat;
                sCreden := Trim(FieldByName('credencial').AsString);
                dteFechaVencim := FieldByName('vencimcreden').AsDateTime;
                rLimiteCredito := FieldByName('limitecredito').AsFloat;
                iPrecio := FieldByName('precio').AsInteger;
            end;
            Close;
        end;
    end;
end;

procedure TfrmCliente.mnuClientesClick(Sender: TObject);
begin
    with TFrmClientesBusq.Create(Self) do
    try
        ShowModal;
        if(bSelec) then begin
            iCliente := StrToInt(sClave);
            RecuperaDatos;
        end;
        txtRfc.SetFocus;
    finally
        Free;
    end;
end;

procedure TfrmCliente.FormCreate(Sender: TObject);
begin
    RecuperaConfig;
end;

end.
