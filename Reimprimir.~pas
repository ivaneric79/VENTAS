// --------------------------------------------------------------------------
// Archivo del Proyecto Ventas
// Página del proyecto: http://sourceforge.net/projects/ventas
// --------------------------------------------------------------------------
// Este archivo puede ser distribuido y/o modificado bajo lo terminos de la
// Licencia Pública General versión 2 como es publicada por la Free Software
// Fundation, Inc.
// --------------------------------------------------------------------------

unit Reimprimir;

interface

uses
  SysUtils, Types, Classes, QGraphics, QControls, QForms, QDialogs,
  QStdCtrls, QcurrEdit, QButtons, IniFiles, rpcompobase, rpclxreport, math;

type
  TfrmReimprimir = class(TForm)
    GroupBox1: TGroupBox;
    cmbCompAnt: TComboBox;
    Label1: TLabel;
    txtNumeroAnt: TcurrEdit;
    Label2: TLabel;
    GroupBox2: TGroupBox;
    txtNumeroNuevo: TcurrEdit;
    Label4: TLabel;
    grpCliente: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    txtNombre: TEdit;
    txtRFC: TEdit;
    Label11: TLabel;
    cmbCategorias: TComboBox;
    grpDomicilio: TGroupBox;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label12: TLabel;
    txtCalle: TEdit;
    txtColonia: TEdit;
    txtLocalidad: TEdit;
    txtEstado: TEdit;
    txtCP: TEdit;
    Label32: TLabel;
    txtTelefono: TEdit;
    Label14: TLabel;
    txtCelular: TEdit;
    Label33: TLabel;
    txtCorreo: TEdit;
    btnImprimir: TBitBtn;
    btnCancelar: TBitBtn;
    lblCaja: TLabel;
    txtCaja: TcurrEdit;
    grpImportes: TGroupBox;
    Label15: TLabel;
    txtSubTotal: TcurrEdit;
    Label16: TLabel;
    txtTotal: TcurrEdit;
    Label17: TLabel;
    txtIva: TcurrEdit;
    rptComprobante: TCLXReport;
    Label3: TLabel;
    txtRedondeo: TcurrEdit;
    Label18: TLabel;
    txtFecha: TEdit;
    chkFactura: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure InicializaNumeros;
    function GetToken(sCadena, sSeparador: String; iToken: Integer): String;
    procedure cmbCompAntSelect(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure txtRFCExit(Sender: TObject);
    procedure chkFacturaClick(Sender: TObject);
    procedure txtNumeroAntExit(Sender: TObject);
  private
    sClaveComp, sVenta, sGlobal : String;
    sArchFactura, sArchNota, sArchCotiza, sArchAjuste, sArchDevolucion : String;

    sUnidades : Array [1..30] of String;
    sDecenas : Array [1..7] of String;
    sCentenas : Array [1..9] of String;

    procedure RecuperaCategs;
    procedure BuscaComp;
    function VerificaDatos:boolean;
    procedure GuardaDatos;
    procedure RecuperaConfig;
     procedure RecuperaIva;
    function ConvNumero(rNumero:Real; bPesos :boolean):String;
    function Rellena(sTexto : String; iCantidad : Integer; sAlineacion : String):String;
    function VerificaComp:boolean;
    procedure LimpiaDatos;
    function ConvierteCodigos(sCodigos : String): String;
    function GetTokenCount(Cadena,Separador:string):integer;
    procedure VerificaCompGlobal;
    function VerificaAutorizacion:boolean;
  public
    iUsuario : integer;
    procedure ImprimeComprobante(sComprobante, sCaja, sNumero:String);
    procedure GeneraCFD(sNumero:String);
    procedure ImprimeTicket(sCaja, sTicket, sTipo : String);
    procedure ImprimeRetiros(sCaja, sFecha, sHora : String);
    procedure ImprimeCancela(sComprobante, sCaja, sNumero:String);
  end;

var
  frmReimprimir: TfrmReimprimir;
    siva : string;
    iiva: integer;
    ivageneral: real;

implementation

uses dm, autoriza;

{$R *.xfm}

procedure TfrmReimprimir.FormShow(Sender: TObject);
begin
    RecuperaCategs;
    LimpiaDatos;

    txtNumeroAnt.SetFocus;
    cmbCompAntSelect(Sender);
end;

procedure TfrmReimprimir.VerificaCompGlobal;
begin
    if(Length(cmbCompAnt.Text) > 0) then
        with dmDatos.qryConsulta do begin
            Close;
            SQL.Clear;
            SQL.Add('SELECT ' + cmbCompAnt.Text + 'global AS global FROM config');
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

procedure TfrmReimprimir.RecuperaCategs;
begin
    with dmDatos.qryConsulta do begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT nombre FROM categorias WHERE tipo = ''C'' ORDER BY nombre');
        Open;

        cmbCategorias.Items.Clear;
        while (not Eof) do begin
            cmbCategorias.Items.Add(Trim(FieldByName('nombre').AsString));
            Next;
        end;
        Close;
        cmbCategorias.ItemIndex := 0;
    end;
end;

procedure TfrmReimprimir.BuscaComp;
begin
    if(dmDatos.sqlBase.Connected) then begin
        with dmDatos.qryModifica do begin
            Close;
            SQL.Clear;
            SQL.Add('SELECT l.rfc, l.nombre, l.calle, l.colonia, l.localidad, l.estado,');
            SQL.Add('l.cp, l.telefono, l.celular, l.ecorreo, v.clave AS venta, v.total,');
            SQL.Add('v.iva, v.redondeo, c.clave AS clavecomp, c.fecha, c.caja FROM comprobantes c');
            SQL.Add('LEFT JOIN clientes l ON c.cliente = l.clave LEFT JOIN ventas v');
            SQL.Add('ON c.venta = v.clave');
            SQL.Add('WHERE c.tipo = ''' + Copy(cmbCompAnt.Text,1,1) + '''');
            SQL.Add('AND c.numero = ' + FormatFloat('0',txtNumeroAnt.Value));
            SQL.Add('AND c.estatus = ''A''');
            if(sGlobal <> 'S') then
                SQL.Add('AND c.caja = ' + FormatFloat('0',txtCaja.Value));
            Open;
            if(not Eof) then begin
                txtRfc.Text := Trim(FieldByName('rfc').AsString);
                txtNombre.Text := Trim(FieldByName('nombre').AsString);
                txtCalle.Text := Trim(FieldByName('calle').AsString);
                txtColonia.Text := Trim(FieldByName('colonia').AsString);
                txtLocalidad.Text := Trim(FieldByName('localidad').AsString);
                txtEstado.Text := Trim(FieldByName('estado').AsString);
                txtCp.Text := Trim(FieldByName('cp').AsString);
                txtTelefono.Text := Trim(FieldByName('telefono').AsString);
                txtCelular.Text := Trim(FieldByName('celular').AsString);
                txtCorreo.Text := Trim(FieldByName('ecorreo').AsString);
                txtCaja.Value := FieldByName('caja').AsInteger;
                sVenta := FieldByName('venta').AsString;
                txtIva.Value := FieldByName('iva').AsFloat;
                txtTotal.Value := FieldByName('total').AsFloat;
                txtRedondeo.Value := FieldByName('redondeo').AsFloat;
                txtSubTotal.Value := txtTotal.Value - txtIva.Value;
                sClaveComp := FieldByName('clavecomp').AsString;
                txtFecha.Text := FormatDateTime('dd/mm/yyyy',FieldByName('fecha').AsDateTime);
            end
            else begin
                LimpiaDatos;
            end;
            Close;
        end;
    end;
end;

procedure TfrmReimprimir.btnImprimirClick(Sender: TObject);
var
    sComp : String;
begin
    btnImprimir.SetFocus;
    if(VerificaDatos) then begin
    //    if(VerificaAutorizacion) then begin
            GuardaDatos;
            if(not chkFactura.Checked) then
                sComp := cmbCompAnt.Text
            else
                sComp := 'FACTURA';
            ImprimeComprobante(sComp, txtCaja.Text, FloatToStr(txtNumeroNuevo.Value));
            Close;
        end;
  //  end;
end;

function TfrmReimprimir.VerificaDatos:boolean;
var
    bRegreso : boolean;
begin
    bRegreso := true;
    if(txtNumeroAnt.Value = 0) then begin
        Application.MessageBox('Introduce el número de comprobante erroneo','Error',[smbOK],smsCritical);
        txtNumeroAnt.SetFocus;
        bRegreso := false;
    end
    else if(txtTotal.Value = 0) then begin
        Application.MessageBox('El número de comprobante especificado no existe','Error',[smbOK],smsCritical);
        txtNumeroAnt.SetFocus;
        bRegreso := false;
    end
    else if(txtNumeroNuevo.Value = 0) then begin
        Application.MessageBox('Introduce el número de comprobante nuevo','Error',[smbOK],smsCritical);
        txtNumeroNuevo.SetFocus;
        bRegreso := false;
    end
    else if(not VerificaComp) then begin
        Application.MessageBox('El número de comprobante nuevo ya existe','Error',[smbOK],smsCritical);
        txtNumeroNuevo.SetFocus;
        bRegreso := false;
    end
    else if(Length(txtRfc.Text) = 0) and ((cmbCompAnt.Text = 'FACTURA') or (chkFactura.Checked)) then begin
        Application.MessageBox('Introduce el R.F.C. del cliente','Error',[smbOK],smsCritical);
        txtRfc.SetFocus;
        bRegreso := false;
    end
    else if(Length(txtNombre.Text) = 0) and ((cmbCompAnt.Text = 'FACTURA') or (chkFactura.Checked)) then begin
        Application.MessageBox('Introduce el nombre del cliente','Error',[smbOK],smsCritical);
        txtNombre.SetFocus;
        bRegreso := false;
    end
    else if(Length(txtCalle.Text) = 0) and ((cmbCompAnt.Text = 'FACTURA') or (chkFactura.Checked)) then begin
        Application.MessageBox('Introduce la calle del cliente','Error',[smbOK],smsCritical);
        txtCalle.SetFocus;
        bRegreso := false;
    end
    else if(Length(txtColonia.Text) = 0) and ((cmbCompAnt.Text = 'FACTURA') or (chkFactura.Checked)) then begin
        Application.MessageBox('Introduce la colonia del cliente','Error',[smbOK],smsCritical);
        txtColonia.SetFocus;
        bRegreso := false;
    end
    else if(Length(txtLocalidad.Text) = 0) and ((cmbCompAnt.Text = 'FACTURA') or (chkFactura.Checked)) then begin
        Application.MessageBox('Introduce la localidad del cliente','Error',[smbOK],smsCritical);
        txtLocalidad.SetFocus;
        bRegreso := false;
    end
    else if(Length(txtEstado.Text) = 0) and ((cmbCompAnt.Text = 'FACTURA') or (chkFactura.Checked)) then begin
        Application.MessageBox('Introduce el estado del cliente','Error',[smbOK],smsCritical);
        txtEstado.SetFocus;
        bRegreso := false;
    end
    else if(Length(txtCp.Text) = 0) and ((cmbCompAnt.Text = 'FACTURA') or (chkFactura.Checked)) then begin
        Application.MessageBox('Introduce el código postal del cliente','Error',[smbOK],smsCritical);
        txtCp.SetFocus;
        bRegreso := false;
    end;
    Result := bRegreso;
end;

function TfrmReimprimir.VerificaComp:boolean;
begin
    Result := true;
    if(txtNumeroAnt.Value <> txtNumeroNuevo.Value) then begin
        with dmDatos.qryModifica do begin
            Close;
            SQL.Clear;
            SQL.Add('SELECT numero FROM comprobantes WHERE numero = ');
            SQL.Add(FloatToStr(txtNumeroNuevo.Value) + ' AND estatus <> ''C''');
            if(not chkFactura.Checked) then
                SQL.Add('AND tipo = ''' + Copy(cmbCompAnt.Text,1,1) + '''')
            else
                SQL.Add('AND tipo = ''F''');
            SQL.Add('AND caja = ' + FloatToStr(txtCaja.Value));
            Open;

            if(not Eof) then
                Result := false;
            Close;
        end;
    end;
end;

procedure TfrmReimprimir.GuardaDatos;
var
    iCliente : integer;
    sCliente, sFecha : String;
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

        sFecha := FormatDateTime('mm/dd/yyyy',Date);
        if(Eof) and (Length(txtNombre.Text) > 0) then begin
            Close;
            SQL.Clear;
            SQL.Add('INSERT INTO clientes (rfc, nombre, calle, colonia, localidad,');
            SQL.Add('estado, cp, telefono, celular, ecorreo, fechacap, fechaumov, precio, acumulado) VALUES(');
            SQL.Add('''' + txtRfc.Text + ''',''' + txtNombre.Text + ''',');
            SQL.Add('''' + txtCalle.Text + ''',''' + txtColonia.Text + ''',');
            SQL.Add('''' + txtLocalidad.Text + ''',''' + txtEstado.Text + ''',');
            SQL.Add('''' + txtCp.Text + ''',''' + txtTelefono.Text + ''',');
            SQL.Add('''' + txtCelular.Text + ''',''' + txtCorreo.Text + ''',');
            SQL.Add('''' + sFecha + ''',''' + sFecha + ''',1,0)');
            ExecSQL;

            Close; // Busca la clave asignada por el disparador
            SQL.Clear;
            SQL.Add('SELECT clave FROM clientes WHERE nombre = ''' + txtNombre.Text + '''');
            Open;
            iCliente := FieldByName('clave').AsInteger;
        end
        else begin
            if(Length(txtNombre.Text) > 0) then begin
                iCliente := FieldByName('clave').AsInteger;
                Close;
                SQL.Clear;
                SQL.Add('UPDATE clientes SET ');
                SQL.Add('rfc = ''' + txtRfc.Text + ''',');
                SQL.Add('nombre = ''' + txtNombre.Text + ''',');
                SQL.Add('calle = ''' + txtCalle.Text + ''',');
                SQL.Add('colonia = ''' + txtColonia.Text + ''',');
                SQL.Add('localidad = ''' + txtLocalidad.Text + ''',');
                SQL.Add('estado = ''' + txtEstado.Text + ''',');
                SQL.Add('cp = ''' + txtCp.Text + ''',');
                SQL.Add('telefono = ''' + txtTelefono.Text + ''',');
                SQL.Add('celular = ''' + txtCelular.Text + ''',');
                SQL.Add('ecorreo = ''' + txtCorreo.Text + ''',');
                SQL.Add('fechaumov = ''' + sFecha + '''');
                SQL.Add('WHERE clave = ' + IntToStr(iCliente));
                ExecSQL;
            end
            else
                iCliente := -1;
        end;
        if(iCliente = - 1) then
            sCliente := 'null'
        else
            sCliente := IntToStr(iCliente);

        if(txtNumeroAnt.Value <> txtNumeroNuevo.Value) or (chkFactura.Checked) then begin
            Close;
            SQL.Clear;
            SQL.Add('INSERT INTO comprobantes (venta, tipo, numero, cliente, fecha, ');
            SQL.Add('estatus, caja) VALUES(' + sVenta + ',');
            if(chkFactura.Checked) then
                SQL.Add('''F'',')
            else
                SQL.Add('''' + Copy(cmbCompAnt.Text,1,1) + ''',');
            SQL.Add(FloatToStr(txtNumeroNuevo.Value) + ',' + sCliente + ',');
            SQL.Add('''' + Copy(txtFecha.Text,4,2) + '/' + Copy(txtFecha.Text,1,3) + Copy(txtFecha.Text,7,4) + ''',');
            SQL.Add('''A'',' + FloatToStr(txtCaja.Value) + ')');
            ExecSQL;

            Close; // Establece el estatus de cancelado al comprobante anterior
            SQL.Clear;
            SQL.Add('UPDATE comprobantes SET estatus = ''C''');
            SQL.Add('WHERE clave = ' + sClaveComp);
            ExecSQL;
        end
        else begin
            Close; // Actualiza el cliente en el comprobante
            SQL.Clear;
            SQL.Add('UPDATE comprobantes SET cliente = ' + sCliente);
            SQL.Add('WHERE clave = ' + sClaveComp);
            ExecSQL;
        end;
        Close;
    end;
end;

procedure TfrmReimprimir.RecuperaConfig;
var
    iniArchivo : TIniFile;
    sIzq, sArriba, sValor : String;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) +'config.ini');

    with iniArchivo do begin
    

        //Recupera la posición Y de la ventana
        sArriba := ReadString('Reimprimir', 'Posy', '');

        //Recupera la posición X de la ventana
        sIzq := ReadString('Reimprimir', 'Posx', '');

        if (Length(sIzq) > 0) and (Length(sArriba) > 0) then begin
            Left := StrToInt(sIzq);
            Top := StrToInt(sArriba);
        end;

        //Recupera el comprobante
        sValor := ReadString('Reimprimir', 'CompAnt', '');
        if (Length(sValor) > 0) then
            cmbCompAnt.ItemIndex := StrToInt(sValor)
        else
            cmbCompAnt.ItemIndex := 0;

        //Recupera el número de caja
        sValor := ReadString('Config', 'Caja', '');
        if (Length(sValor) > 0) then
            txtCaja.Value := StrToInt(sValor)
        else
            txtCaja.Value := 1;

        Free;
    end;
end;

procedure TfrmReimprimir.RecuperaIva;
var
    iniArchivo : TIniFile;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) +'config.ini');

    with iniArchivo do begin
         //recupera IVA general
     siva := ReadString('IVA', 'ivageneral', '');
    iiva := StrToInt(siva);
    ivageneral := iiva / 100;


        Free;
    end;
end;

procedure TfrmReimprimir.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
    iniArchivo : TIniFile;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) +'config.ini');
    with iniArchivo do begin
        // Registra la posición y de la ventana
        WriteString('Reimprimir', 'Posy', IntToStr(Top));

        // Registra la posición X de la ventana
        WriteString('Reimprimir', 'Posx', IntToStr(Left));

        // Registra el comprobante seleccionado
        WriteString('Reimprimir', 'CompAnt', IntToStr(cmbCompAnt.ItemIndex));
        Free;
    end;
end;

procedure TfrmReimprimir.ImprimeComprobante(sComprobante, sCaja, sNumero:String);
var
    rTotal : real;
    bImprimir : boolean;
    iniArchivo : TIniFile;
    sValor, sCampo, sDirReportes : String;
    ttotal,tiva: real;

begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) +'config.ini');

    sDirReportes := iniArchivo.ReadString('Reportes', 'DirReportes', '');

    if not (Length(sDirReportes) > 0) then
       sDirReportes:= ExtractFilePath(Application.ExeName)+'Reportes\';

    InicializaNumeros;

    bImprimir := true;
    with dmDatos.qryModifica do begin
        Close;
        SQL.Clear;
        if(sComprobante = 'FACTURA') then
            sCampo := 'facturaglobal'
        else if(sComprobante = 'NOTA') then
            sCampo := 'notaglobal'
        else if(sComprobante = 'TICKET') then
            sCampo := 'ticketglobal'
        else if(sComprobante = 'AJUSTE') then
            sCampo := 'ajusteglobal'
        else if(sComprobante = 'COTIZACION') then
            sCampo := 'cotizacionglobal'
        else if(sComprobante = 'DEVOLUCION') then
            sCampo := 'devolucionglobal'
        else if(sComprobante = 'PEDIDO') then
            sCampo := 'pedidoglobal';

        SQL.Add('SELECT ' + sCampo  + ' FROM config');
        Open;
        sGlobal := FieldByName(sCampo).AsString;

        Close;
        SQL.Clear;
        SQL.Add('SELECT v.total, v.redondeo FROM comprobantes c LEFT JOIN ventas v ON c.venta = v.clave');
        SQL.Add('WHERE c.tipo = ''' + Copy(sComprobante,1,1) + '''');
        SQL.Add('AND c.numero = ' + sNumero + ' AND c.estatus = ''A''');
        if(sGlobal = 'S') then
            SQL.Add('AND c.caja = ' + sCaja);
        Open;
        rTotal := FieldByName('total').AsFloat; //- FieldByName('redondeo').AsFloat;
        Close;
    end;

    
    if(sComprobante = 'TICKET') then
        ImprimeTicket(sCaja, sNumero, 'T')
    else begin
        if(sComprobante = 'FACTURA') then
         begin

         //**************************factura electronica*******************










                 ImprimeTicket(sCaja, sNumero,'F');
                 //Recupera el nombre del archivo del reporte de facturas

                  sArchFactura := sDirReportes + iniArchivo.ReadString('Reportes', 'Factura', '');
                 if (Length(sArchFactura) > 0) and (FileExists(sArchFactura)) then
                  begin
                   rptComprobante.FileName := sArchFactura;
                   //Recupera el número de copias de la factura
                   sValor := iniArchivo.ReadString('Reportes', 'CopiasFactura', '');
                   if (Length(sValor) > 0) then
                    rptComprobante.Report.Copies := StrToInt(sValor)
                   else
                    rptComprobante.Report.Copies := 1;
                   rptComprobante.Title := 'Factura ' + sNumero ;
                 end
                 else
                  begin
                    Application.MessageBox('El archivo de factura especificado no existe','Error',[smbOK],smsCritical);
                    bImprimir := false;
                  end;
         end
        else if(sComprobante = 'NOTA') then begin
        ImprimeTicket(sCaja, sNumero,'N');
          bImprimir := false;
            //Recupera el nombre del archivo del reporte de notas
            sArchNota := sDirReportes + iniArchivo.ReadString('Reportes', 'Nota', '');
            if (Length(sArchNota) > 0) and (FileExists(sArchNota)) then begin
                rptComprobante.FileName := sArchNota;
                //Recupera el número de copias de la nota
                sValor := iniArchivo.ReadString('Reportes', 'CopiasNota', '');
                if (Length(sValor) > 0) then
                    rptComprobante.Report.Copies := StrToInt(sValor)
                else
                    rptComprobante.Report.Copies := 1;
                rptComprobante.Title := 'Nota ' + sNumero;
            end
            else begin
                Application.MessageBox('El archivo de nota especificado no existe','Error',[smbOK],smsCritical);
                bImprimir := false;
            end;
        end
        else if(sComprobante = 'COTIZACION') then begin
            //Recupera el nombre del archivo del reporte de cotización
            sArchCotiza := sDirReportes + iniArchivo.ReadString('Reportes', 'Cotizacion', '');
            if (Length(sArchCotiza) > 0) and (FileExists(sArchCotiza)) then begin
                rptComprobante.FileName := sArchCotiza;
                //Recupera el número de copias de la cotización
                sValor := iniArchivo.ReadString('Reportes', 'CopiasCotiza', '');
                if (Length(sValor) > 0) then
                    rptComprobante.Report.Copies := StrToInt(sValor)
                else
                    rptComprobante.Report.Copies := 1;
                rptComprobante.Title := 'Cotización ' + sNumero;
            end
            else begin
                Application.MessageBox('El archivo de cotización especificado no existe','Error',[smbOK],smsCritical);
                bImprimir := false;
            end;
        end
        else if(sComprobante = 'AJUSTE') then begin
            //Recupera el nombre del archivo del reporte de ajuste
            sArchAjuste := sDirReportes + iniArchivo.ReadString('Reportes', 'Ajuste', '');
            if (Length(sArchAjuste) > 0) and (FileExists(sArchAjuste)) then begin
                rptComprobante.FileName := sArchAjuste;
                //Recupera el número de copias de la cotización
                sValor := iniArchivo.ReadString('Reportes', 'CopiasAjuste', '');
                if (Length(sValor) > 0) then
                    rptComprobante.Report.Copies := StrToInt(sValor)
                else
                    rptComprobante.Report.Copies := 1;
                rptComprobante.Title := 'Ajuste ' + sNumero;
            end
            else begin
                Application.MessageBox('El archivo de ajuste especificado no existe','Error',[smbOK],smsCritical);
                bImprimir := false;
            end;
        end
        else if(sComprobante = 'DEVOLUCION') then begin
        ImprimeTicket(sCaja, sNumero,'D'); //ago2011
            //Recupera el nombre del archivo del reporte de devolucion
            sArchDevolucion := sDirReportes + iniArchivo.ReadString('Reportes', 'Devolucion', '');
            if (Length(sArchDevolucion) > 0) and (FileExists(sArchDevolucion)) then begin
                rptComprobante.FileName := sArchDevolucion;
                //Recupera el número de copias de la devolucion
                sValor := iniArchivo.ReadString('Reportes', 'CopiasDevolucion', '');
                if (Length(sValor) > 0) then
                    rptComprobante.Report.Copies := StrToInt(sValor)
                else
                    rptComprobante.Report.Copies := 1;
                rptComprobante.Title := 'Devolucion ' + sNumero;
            end
            else begin
             //   Application.MessageBox('El archivo de devolución especificado no existe','Error',[smbOK],smsCritical);
                bImprimir := false;
            end;
        end
        else if(sComprobante = 'PEDIDO') then begin
            //Recupera el nombre del archivo del reporte de devolucion
            sArchDevolucion := sDirReportes + iniArchivo.ReadString('Reportes', 'Pedido', '');
            if (Length(sArchDevolucion) > 0) and (FileExists(sArchDevolucion)) then begin
                rptComprobante.FileName := sArchDevolucion;
                //Recupera el número de copias del pedido
                sValor := iniArchivo.ReadString('Reportes', 'CopiasPedido', '');
                if (Length(sValor) > 0) then
                    rptComprobante.Report.Copies := StrToInt(sValor)
                else
                    rptComprobante.Report.Copies := 1;
                rptComprobante.Title := 'Pedido ' + sNumero;
            end
            else begin
                Application.MessageBox('El archivo de pedido especificado no existe','Error',[smbOK],smsCritical);
                bImprimir := false;
            end;
        end;
        if(bImprimir) then
         begin
            rptComprobante.Report.DatabaseInfo.Items[0].SQLConnection := dmDatos.sqlBase.DataSets[0].SQLConnection;
            rptComprobante.Report.Params.ParamByName('Numero').Value:= sNumero;
            rptComprobante.Report.Params.ParamByName('Caja').Value:= sCaja;
            if(sComprobante = 'FACTURA') then begin
         //      RecuperaIva;
           //   tiva:=rTotal*(ivageneral);
           //        tiva:= RoundTo(tiva, -2);
            //       ttotal:= rTotal+tiva;

           //    rptComprobante.Report.Params.ParamByName('tiva').Value:=tiva;
           //    rptComprobante.Report.Params.ParamByName('ttotal').Value:=ttotal;
           //    rptComprobante.Report.Params.ParamByName('numerotexto').Value:= UpperCase(ConvNumero(ttotal,true)) // se quito  rTotal*1.15

               end
            else
            begin
               rptComprobante.Report.Params.ParamByName('numerotexto').Value:= UpperCase(ConvNumero(rTotal,true));
               rptComprobante.Report.Params.ParamByName('ttotal').Value:=rtotal;
            end;
           if((sComprobante <> 'FACTURA') and (sComprobante <> 'DEVOLUCION') ) then begin
            rptComprobante.Execute;
            end;
        end;
    end;
    iniArchivo.Free;
end;

procedure TfrmReimprimir.GeneraCFD(sNumero:String);
var
//datosUsuario, datosReceptor, datosCFDI, nombreEtiqueta, valorEtiqueta, cantidad,
//descripcion, valorUnitario, importe, respuesta,nombreRetencion,
//impuestoRetencion, importeRetencion,nombreTraslado, impuestoTraslado, tasaTraslado, importeTraslado: arrayofstring;
a:string;
begin

  a:='a';


end;




procedure TfrmReimprimir.ImprimeTicket(sCaja, sTicket,sTipo : String);
var
    iniArchivo : TIniFile;

    i, j, iCopias : Integer;
    iImpresora : TextFile;
    sTipoVar : Char;
    cli, sLinea, sSerie, sUsuario, sPuertoImpre, sCodigoIni, sCodigoCorta, sTel, sRfc : String;
    sCodigoFin, sVenta, sCliente, sCalle, sColonia, sLocalidad, sEstado, sCp : String;
    fPrecio, fPreciU, rTotal, rRedondeo, rCambio, rIva : Real;
    car: integer;
    cstr:string;
    partida: integer;
    vendedor:string;
    cajas: integer;


begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) +'config.ini');
    InicializaNumeros;
    //Recupera el puerto de la impresora de tickets
    sPuertoImpre := iniArchivo.ReadString('Config', 'PuertoTicket', '');
    if (Length(sPuertoImpre) = 0) then
        sPuertoImpre := 'Ticket.txt';

    //Recupera el número de copias de tickets
    sLinea := iniArchivo.ReadString('Config', 'CopiasTicket', '');
    if (Length(sLinea) > 0) then
        iCopias := StrToInt(sLinea)
    else
        iCopias := 1;

    //Recupera el codigo de inicio de la impresora
    sLinea := iniArchivo.ReadString('Config', 'IniTicket', '');
    if (Length(sLinea) > 0) then
        sCodigoIni := ConvierteCodigos(sLinea);

    //Recupera el codigo para cortar el papel
    sLinea := iniArchivo.ReadString('Config', 'CortaTicket', '');
    if (Length(sLinea) > 0) then
        sCodigoCorta := ConvierteCodigos(sLinea);

    //Recupera el codigo de inicio de la impresora
    sLinea := iniArchivo.ReadString('Config', 'FinTicket', '');
    if (Length(sLinea) > 0) then
        sCodigoFin := ConvierteCodigos(sLinea);

    for j := 1 to iCopias do begin
        Assignfile(iImpresora,sPuertoImpre); //Puerto: LPT1, COM1, etc;
        Rewrite(iImpresora);

        Writeln(iImpresora,sCodigoIni);

        with dmDatos.qryConsulta do begin
            Close;
            SQL.Clear;
            SQL.Add('SELECT serieticket FROM cajas WHERE numero = ' + sCaja);
            Open;
            sSerie := Trim(FieldByName('serieticket').AsString);

            Close;
            SQL.Clear;
            SQL.Add('SELECT v.clave, c.numero, c.fecha, v.hora, v.redondeo, v.total, v.iva, v.cambio, l.rfc, l.nombre,');
            SQL.Add('l.calle, l.colonia, l.localidad, l.estado, l.cp, l.telefono, u.login FROM comprobantes c');
            SQL.Add('LEFT JOIN ventas v ON c.venta = v.clave LEFT JOIN clientes l');
            SQL.Add('ON c.cliente = l.clave LEFT JOIN usuarios u ON v.usuario = u.clave');
            SQL.Add('WHERE c.tipo = '''+sTipo+''' AND c.numero = ' + sTicket + ' AND c.caja = ' + sCaja);
            SQL.Add('AND v.estatus = ''A'' AND c.estatus = ''A''');

            Open;


            sVenta := FieldByName('clave').AsString;
            rTotal := FieldByName('total').AsFloat;
            rIva := FieldByName('iva').AsFloat;
            rRedondeo := FieldByName('redondeo').AsFloat;
            rCambio := FieldByName('cambio').AsFloat;
            sUsuario := FieldByName('login').AsString;
            sRfc := Trim(FieldByName('rfc').AsString);
            sCliente := Trim(FieldByName('nombre').AsString);
            sCalle := Trim(FieldByName('calle').AsString);
            sColonia := Trim(FieldByName('colonia').AsString);
            sLocalidad := Trim(FieldByName('localidad').AsString);
            sCp := Trim(FieldByName('cp').AsString);
            sTel := Trim(FieldByName('telefono').AsString);

            dmDatos.qryAuxiliar1.Close;
            dmDatos.qryAuxiliar1.SQL.Clear;
            dmDatos.qryAuxiliar1.SQL.Add('SELECT * FROM ticket WHERE nivel = 1 ORDER BY nivel, renglon');
            dmDatos.qryAuxiliar1.Open;
            if (sTipo = 'F') then
            begin
                 Writeln(iImpresora,'             FACTURA');
             Writeln(iImpresora,'');
             Writeln(iImpresora,'');

            end;

            if (sTipo <> 'D') then
            begin


            while(not dmDatos.qryAuxiliar1.Eof) do begin
                sLinea := dmDatos.qryAuxiliar1.FieldByName('texto').AsString;
                i := Pos('%',sLinea);
                while(i > 0) do begin
                    sTipoVar := sLinea[i+1];
                    case sTipoVar of
                        'r', 'R' : sLinea := Copy(sLinea, 1, i-1) + sRfc + Copy(sLinea, i + 2, Length(sLinea) - i);
                        'n', 'N' : sLinea := Copy(sLinea, 1, i-1) + sCliente + Copy(sLinea, i + 2, Length(sLinea) - i);
                        'c', 'C' : sLinea := Copy(sLinea, 1, i-1) + sCalle + Copy(sLinea, i + 2, Length(sLinea) - i);
                        'o', 'O' : sLinea := Copy(sLinea, 1, i-1) + sColonia + Copy(sLinea, i + 2, Length(sLinea) - i);
                        'l', 'L' : sLinea := Copy(sLinea, 1, i-1) + sLocalidad + Copy(sLinea, i + 2, Length(sLinea) - i);
                        'e', 'E' : sLinea := Copy(sLinea, 1, i-1) + sEstado + Copy(sLinea, i + 2, Length(sLinea) - i);
                        'p', 'P' : sLinea := Copy(sLinea, 1, i-1) + sCp + Copy(sLinea, i + 2, Length(sLinea) - i);
                        't', 'T' : sLinea := Copy(sLinea, 1, i-1) + sTel + Copy(sLinea, i + 2, Length(sLinea) - i);
                        else
                            sLinea := Copy(sLinea, 1, i-1) + Copy(sLinea, i + 1, Length(sLinea) - i);
                    end;
                    i := Pos('%',sLinea);
                end;
                Writeln(iImpresora,sLinea);
                dmDatos.qryAuxiliar1.Next;
            end;
            end
            else
            begin
             Writeln(iImpresora,'           DEVOLUCION');
             Writeln(iImpresora,'');
             Writeln(iImpresora,'');

            end;
            dmDatos.qryAuxiliar1.Close;
            if(Length(sSerie) > 0) then
                Writeln(iImpresora,'CAJA: ' + Format('%02d',[StrToInt(sCaja)]) + '           ' +
                    'FOLIO: ' + Format('%05d',[StrToInt(sTicket)]) + '-' + sSerie)
            else
                Writeln(iImpresora,'CAJA: ' + Format('%02d',[StrToInt(sCaja)]) + '           ' +
                    'FOLIO: ' + Format('%05d',[StrToInt(sTicket)]));
            Writeln(iImpresora,'FECHA: ' + FormatDateTime('dd/mm/yyyy',FieldByName('fecha').AsDateTime) + '         ' +
                    'HORA: ' + FormatDateTime('hh:nn:ss',FieldByName('hora').AsDateTime));
            //nueva30 sep
            Writeln(iImpresora,'Cliente:');
            Writeln(iImpresora,sCliente);
            ///
            Writeln(iImpresora,'');
            Writeln(iImpresora,'A R T I C U L O                IMPORTE');
            Writeln(iImpresora,'----------------------------------------');

            //Close;
            //SQL.Clear;
            //SQL.Add('SELECT v.cantidad, a.desc_larga, v.precio, v.iva, v.descuento, a.tipo');
            //SQL.Add('FROM ventasdet v JOIN articulos a ON v.articulo = a.clave JOIN ');
            //SQL.Add('comprobantes c ON c.venta = v.venta WHERE c.tipo = ''T'' AND ');
            //SQL.Add('c.numero = ' + sTicket + ' AND c.estatus = ''A'' AND c.caja = ');
            //SQL.Add(sCaja + ' AND v.juego = 0');
            //Open;

            Close; 
            SQL.Clear;

            SQL.Add('SELECT v.cantidad, a.desc_larga, a.factor, a.tipo2 , v.precio, v.iva, v.descuento, a.tipo, x.comentario');
            SQL.Add('FROM ventasdet v LEFT JOIN articulos a ON v.articulo = a.clave LEFT JOIN ');
            SQL.Add('comprobantes c ON c.venta = v.venta LEFT JOIN VENTASCOMENT X ON v.comentario = x.clave WHERE c.tipo = '''+sTipo+''' AND ');
            SQL.Add('c.numero = ' + sTicket + ' AND c.caja = ');
            SQL.Add(sCaja + ' AND v.juego = 0');

            Open;

             partida:=0;
            while(not Eof) do begin
            partida:=partida+1;
                fPrecio := FieldByName('precio').AsFloat;
                // Imprime la descripción y el precio
                //sLinea := Rellena(Trim(FieldByName('desc_larga').AsString),45,'D') + '       ' + Rellena(FormatFloat('#,##0.00',fPrecio),13,'I');
                sLinea := Rellena(Trim(FieldByName('desc_larga').AsString),40,'D');
                Writeln(iImpresora,sLinea);
                if(FieldByName('comentario').AsString <> '') then
                begin
                sLinea := 'Obs: ' + Rellena(Trim(FieldByName('comentario').AsString),40,'D');
                Writeln(iImpresora,sLinea);
                end;

                //Imprime la cantidad
                if(FieldByName('cantidad').AsFloat <> 0) then begin
                    fPrecio := FieldByName('cantidad').AsFloat * FieldByName('precio').AsFloat;
                    fPreciU := FieldByName('precio').AsFloat;
                    car := length(FieldByName('Cantidad').AsString); //13/oct
                    if(FieldByName('tipo').AsInteger = 0) then
                    begin
                        if  (FieldByName('factor').Asfloat > 0) then
                           begin
                        if (FieldByName('Cantidad').Asfloat >= FieldByName('factor').Asfloat)  then
                        begin
                       cajas:=  trunc(FieldByName('Cantidad').Asfloat / FieldByName('factor').Asfloat);
                       cli := ' (' + inttostr(cajas) + ' ' + FieldByName('tipo2').AsString+ ')';

                       end;
                           end;





                       // sLinea := ' '+Rellena(FormatFloat('#,##0.00',fPreciU),13,'I')+' x ' + Rellena(FormatFloat('#,##0.00',FieldByName('Cantidad').AsFloat),6,' ') + cli +
                        //          '   ' + Rellena(FormatFloat('#,##0.00',fPrecio),17-(car+ Length(cli)),'I')
                        sLinea := ' '+Rellena(FormatFloat('#,##0.00',fPreciU),8,'I')+' x ' + Rellena(FormatFloat('#,##0.00',FieldByName('Cantidad').AsFloat),6,' ') + cli +
                                 '   ' + Rellena(FormatFloat('#,##0.00',fPrecio),21-(car+ Length(cli)),'I')
                    end
                    else
                    begin
                         if  (FieldByName('factor').Asfloat > 0) then
                           begin
                        if (FieldByName('Cantidad').Asfloat >= FieldByName('factor').Asfloat)  then
                        begin
                       cajas:=  trunc(FieldByName('Cantidad').Asfloat / FieldByName('factor').Asfloat);
                       cli := ' (' + inttostr(cajas) + ' ' + FieldByName('tipo2').AsString+ ')';

                       end;
                           end;
                        sLinea := ' '+Rellena(FormatFloat('#,##0.00',fPreciU),8,'I')+' x ' + Rellena(FormatFloat('#,##0.00',FieldByName('Cantidad').AsFloat),6,' ') + cli +
                                  '   ' + Rellena(FormatFloat('#,##0.00',fPrecio),21-(car+ Length(cli)),'I');
                    end;
                    Writeln(iImpresora,sLinea);
                    cli :='';


                end;
                if(FieldByName('descuento').AsFloat > 0) then begin
                    fPrecio := FieldByName('Cantidad').AsFloat * FieldByName('precio').AsFloat *
                                   (1 - FieldByName('descuento').AsFloat / 100);

                    sLinea := '    Desc.   ' + Rellena(FormatFloat('%00.00',FieldByName('Descuento').AsFloat),5,'0') +
                                       '%         ' + Rellena(FormatFloat('#,##0.00',fPrecio),13,'I');
                    Writeln(iImpresora,sLinea);
                end;
                Next;
            end;
            Close;
            Writeln(iImpresora,'');

  //oct 2010          Writeln(iImpresora,'          IMPORTE:   ' + Rellena(Format('%8.2n',[rTotal-rRedondeo]),13,'I'));
    //oct 2010        if(rRedondeo <> 0) then
     //oct 2010           Writeln(iImpresora,'          REDONDEO:  ' + Rellena(Format('%8.2n',[rRedondeo]),13,'I'));

       //oct 2010     Writeln(iImpresora,'           TOTAL:    ' + Rellena(Format('%8.2n',[rTotal]),13,'I'));
            //Writeln(iImpresora,'');
            //Writeln(iImpresora,'          I.V.A.:    ' + Rellena(Format('%8.2n',[rIva]),13,'I'));

            Close;
            SQL.Clear;
            SQL.Add('SELECT t.nombre, p.importe FROM ventaspago p LEFT JOIN ');
            SQL.Add('tipopago t ON p.tipopago = t.clave WHERE venta = ' + sVenta);
            Open;
            Writeln(iImpresora,'');

            while(not Eof) do begin
           //     Writeln(iImpresora,'    ' + Rellena(FieldByName('nombre').AsString,15,'I') + ': ' + Rellena(Format('%8.2n',[FieldByName('importe').AsFloat]),13,'I'));
                Next;
            end;
            Close;
           // Writeln(iImpresora,'        PARTIDAS:    ' + Rellena(inttostr(partida),13,'I'));
          //  Writeln(iImpresora,'');

            if (sTipo = 'F') then
            begin
          //  Writeln(iImpresora,'           TOTAL:    ' + Rellena(Format('%8.2n',[RoundTo(rTotal,-2)]),13,'I'));
          //  Writeln(iImpresora,'             IVA:    ' + Rellena(Format('%8.2n',[RoundTo(rTotal*0.16,-2)]),13,'I'));
         //   Writeln(iImpresora,'  IMPORTE PAGADO:    ' + Rellena(Format('%8.2n',[RoundTo(rTotal*1.16,-2) + rCambio]),13,'I'));
         //   Writeln(iImpresora,'          CAMBIO:    ' + Rellena(Format('%8.2n',[rCambio]),13,'I'));
        //    Writeln(iImpresora,'');
        //    Writeln(iImpresora,UpperCase(ConvNumero(rTotal*1.16,true)));
            end
            else
            begin
            Writeln(iImpresora,'           TOTAL:    ' + Rellena(Format('%8.2n',[rTotal]),13,'I'));
            Writeln(iImpresora,'  IMPORTE PAGADO:    ' + Rellena(Format('%8.2n',[rTotal + rCambio]),13,'I'));
            Writeln(iImpresora,'          CAMBIO:    ' + Rellena(Format('%8.2n',[rCambio]),13,'I'));
            Writeln(iImpresora,'');
            Writeln(iImpresora,UpperCase(ConvNumero(rTotal,true)));
            end;


            Writeln(iImpresora,'');
            Writeln(iImpresora,'PARTIDAS: ' + Rellena(inttostr(partida),2,'I'));

             Close;
            SQL.Clear;
            SQL.Add('SELECT VENDEDORES.NOMBRE FROM ventas  LEFT JOIN VENDEDORES   on ventas.VENDEDOR = VENDEDORES.CLAVE where ventas.CLAVE='+ sVenta);
            Open;
             vendedor := FieldByName('nombre').AsString;

             if (vendedor = '') then
             begin
             vendedor := sUsuario;
             end;

          

            Writeln(iImpresora,'');
            sLinea := 'LE ATENDIO: ' +  vendedor;
            i := 20 - Length(sLinea) div 2 + Length(sLinea);
            Writeln(iImpresora,Rellena(sLinea,i,'I'));
            Writeln(iImpresora,'');

            Close;
            SQL.Clear;
            SQL.Add('SELECT * FROM ticket WHERE nivel = 2 ORDER BY nivel, renglon');
            Open;
            while(not Eof) do begin
                Writeln(iImpresora,FieldByName('texto').AsString);
                Next;
            end;

   
            Close;

            Writeln(iImpresora,sCodigoCorta);

            Writeln(iImpresora,sCodigoFin);

            CloseFile(iImpresora);
        end;
    end;
end;

function TfrmReimprimir.ConvNumero(rNumero:Real; bPesos :boolean):String;
var
    iNumero, iDecimales, iMillon, iMil, iCentena, iDecena, iUnidad: LongInt;
    sRegreso : String;
    rTemp: real;


begin
    sRegreso := '';
    rNumero:=roundto(rNumero,-2);
    iNumero := Trunc(rNumero);
    rTemp := StrToFloat(FormatFloat('0.0000',Frac(rNumero)));
    rTemp := rTemp * 100;
 

    iDecimales :=Round(rTemp); //Trunc(rTemp);




    iMillon := iNumero div 1000000;
    iNumero := iNumero - iMillon * 1000000;
    iMil := iNumero div 1000;
    iNumero := iNumero - iMil * 1000;
    iCentena := iNumero div 100;
    iNumero := iNumero - iCentena * 100;
    iDecena := iNumero div 10;
    iNumero := iNumero - iDecena * 10;
    iUnidad := iNumero;

    if(iMillon > 0) then
        if(iMillon > 1) then
            sRegreso := ConvNumero(iMillon,false) + ' millones'
        else
            sRegreso := 'un millon';
    if(iMil > 0) then
        sRegreso := sRegreso + ' ' + ConvNumero(iMil,false) + ' mil';
    if(iCentena > 0) then
        if(iCentena = 1) and (iDecena = 0) and (iUnidad = 0) then
            sRegreso := sRegreso + ' cien'
        else
            sRegreso := sRegreso + ' ' + sCentenas[iCentena];
    if(iDecena > 0) then
        if(iDecena < 3) then
            sRegreso := sRegreso + ' ' + sUnidades[iDecena*10+iUnidad]
        else
            sRegreso := sRegreso + ' ' + sDecenas[iDecena-2];
    if(iUnidad > 0) and ((iDecena = 0) or (iDecena > 2)) then begin
        if(iDecena > 0) then
            sRegreso := sRegreso + ' y';
        sRegreso := sRegreso + ' ' + sUnidades[iUnidad];
    end;
    if(Copy(sRegreso,1,1) = ' ') then
        sRegreso := Copy(sRegreso,2,Length(sRegreso)-1);
     if(bPesos) then
        sRegreso := sRegreso + ' pesos ' + FormatFloat('00',iDecimales) + '/100 m.n.';
    Result := sRegreso;
end;

function TfrmReimprimir.Rellena(sTexto : String; iCantidad : Integer; sAlineacion : String):String;
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

procedure TfrmReimprimir.InicializaNumeros;
begin
    sUnidades[1] := 'un';
    sUnidades[2] := 'dos';
    sUnidades[3] := 'tres';
    sUnidades[4] := 'cuatro';
    sUnidades[5] := 'cinco';
    sUnidades[6] := 'seis';
    sUnidades[7] := 'siete';
    sUnidades[8] := 'ocho';
    sUnidades[9] := 'nueve';
    sUnidades[10] := 'diez';
    sUnidades[11] := 'once';
    sUnidades[12] := 'doce';
    sUnidades[13] := 'trece';
    sUnidades[14] := 'catorce';
    sUnidades[15] := 'quince';
    sUnidades[16] := 'diez y seis';
    sUnidades[17] := 'diez y siete';
    sUnidades[18] := 'diez y ocho';
    sUnidades[19] := 'diez y nueve';
    sUnidades[20] := 'veinte';
    sUnidades[21] := 'veintiun';
    sUnidades[22] := 'veintidos';
    sUnidades[23] := 'veintitres';
    sUnidades[24] := 'veinticuatro';
    sUnidades[25] := 'veinticinco';
    sUnidades[26] := 'veintiseis';
    sUnidades[27] := 'veintisiete';
    sUnidades[28] := 'veintiocho';
    sUnidades[29] := 'veintinueve';

    sDecenas[1] := 'treinta';
    sDecenas[2] := 'cuarenta';
    sDecenas[3] := 'cincuenta';
    sDecenas[4] := 'sesenta';
    sDecenas[5] := 'setenta';
    sDecenas[6] := 'ochenta';
    sDecenas[7] := 'noventa';

    sCentenas[1] := 'ciento';
    sCentenas[2] := 'doscientos';
    sCentenas[3] := 'trescientos';
    sCentenas[4] := 'cuatrocientos';
    sCentenas[5] := 'quinientos';
    sCentenas[6] := 'seiscientos';
    sCentenas[7] := 'setecientos';
    sCentenas[8] := 'ochocientos';
    sCentenas[9] := 'novecientos';
end;

procedure TfrmReimprimir.LimpiaDatos;
begin
    txtRfc.Clear;
    txtNombre.Clear;
    txtCalle.Clear;
    txtColonia.Clear;
    txtLocalidad.Clear;
    txtEstado.Clear;
    txtCp.Clear;
    txtTelefono.Clear;
    txtCelular.Clear;
    txtCorreo.Clear;
    txtIva.Value := 0;
    txtTotal.Value := 0;
    txtSubTotal.Value := 0;
    txtRedondeo.Value := 0;
end;

function TfrmReimprimir.ConvierteCodigos(sCodigos : String): String;
var
    sRegreso : String;
    n : integer;
    cByte : byte;
begin
    sRegreso := '';
    for n := 1 to GetTokenCount(sCodigos,' ') do
        try
            cByte := StrToInt(GetToken(sCodigos,' ',n));
            sRegreso := sRegreso + chr(cByte);
        except
            break;
        end;
    Result := sRegreso;
end;

function TfrmReimprimir.GetToken(sCadena, sSeparador: String; iToken: Integer): String;
var
    iPosicion: Integer;
begin
    while iToken > 1 do begin
        Delete(sCadena, 1, Pos(sSeparador,sCadena) + Length(sSeparador) - 1);
        Dec(iToken);
    end;
    iPosicion := Pos(sSeparador, sCadena);
    if iPosicion = 0 then
        Result:= sCadena
    else
        Result:= Copy(sCadena, 1, iPosicion - 1);
end;

function TfrmReimprimir.GetTokenCount(Cadena,Separador:string):integer;
var
    Posicion:integer;
begin
    Posicion := Pos(Separador,Cadena);
    Result := 1;

    if Cadena <> '' then begin
        if Posicion <> 0 then
            while Posicion <> 0 do begin
                Delete(Cadena,1,Posicion);
                Posicion := Pos(Separador,Cadena);
                Inc (Result);
            end;
        end
        else
            Result := 0;
end;

procedure TfrmReimprimir.cmbCompAntSelect(Sender: TObject);
begin
    if(cmbCompAnt.Text = 'TICKET') or (cmbCompAnt.Text = 'NOTA') then
        chkFactura.Enabled := true
    else begin
        chkFactura.Checked := false;
        chkFactura.Enabled := false;
    end;
    VerificaCompGlobal;
    BuscaComp;
end;

procedure TfrmReimprimir.FormCreate(Sender: TObject);
begin
    cmbCompAnt.Clear;
    cmbCompAnt.Items.Add('AJUSTE');
    cmbCompAnt.Items.Add('COTIZACION');
    cmbCompAnt.Items.Add('DEVOLUCION');
    cmbCompAnt.Items.Add('FACTURA');
    cmbCompAnt.Items.Add('NOTA');
    cmbCompAnt.Items.Add('PEDIDO');
    cmbCompAnt.Items.Add('TICKET');
    RecuperaConfig;
end;

procedure TfrmReimprimir.txtRFCExit(Sender: TObject);
begin
     if(Length(Trim(txtRfc.Text)) > 0) then begin
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
                txtEstado.Text := Trim(FieldByName('Estado').AsString);
                txtCp.Text := Trim(FieldByName('Cp').AsString);
                txtCelular.Text := Trim(FieldByName('Celular').AsString);
                txtCorreo.Text := Trim(FieldByName('ecorreo').AsString);
            end;
            Close;
        end;
    end;
end;

function TfrmReimprimir.VerificaAutorizacion:boolean;
var
    sTipo, sComp : String;
begin
    Result := true;
    if(not chkFactura.Checked) then begin
        sComp := cmbCompAnt.Text;
        if(cmbCompAnt.Text = 'AJUSTE') then
            sTipo := 'R01'
        else if(cmbCompAnt.Text = 'COTIZACION') then
            sTipo := 'R03'
        else if(cmbCompAnt.Text = 'FACTURA') then
            sTipo := 'R04'
        else if(cmbCompAnt.Text = 'NOTA') then
            sTipo := 'R05'
        else if(cmbCompAnt.Text = 'PEDIDO') then
            sTipo := 'R06'
        else if(cmbCompAnt.Text = 'TICKET') then
            sTipo := 'R07'
        else if(cmbCompAnt.Text = 'DEVOLUCION') then
            sTipo := 'R08';
    end
    else begin
        sComp := 'FACTURA';
        sTipo := 'R02';
    end;

    with TFrmAutoriza.Create(Self) do
    try
        if(not VerificaAutoriza(Self.iUsuario,sTipo)) then begin
            sTipoAutoriza := sTipo;
            sMensaje := '(Comprobante: ' + sComp + ')';
            iUsuario := Self.iUsuario;
            ShowModal;
            Result := bAutorizacion;
        end;
    finally
        Free;
    end;
end;

procedure TfrmReimprimir.ImprimeRetiros(sCaja, sFecha, sHora:String);
var
    iniArchivo : TIniFile;
    sArchRetiro : String;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) +'config.ini');

    //Recupera el nombre del archivo del reporte de retiros
    sArchRetiro := iniArchivo.ReadString('Reportes', 'Retiro', '');
    if (Length(sArchRetiro) > 0) and (FileExists(sArchRetiro)) then begin
        rptComprobante.FileName := sArchRetiro;
        rptComprobante.Report.Copies := 1;
        rptComprobante.Title := 'Retiro';
        rptComprobante.Report.DatabaseInfo.Items[0].SQLConnection := dmDatos.sqlBase.DataSets[0].SQLConnection;
        rptComprobante.Report.Params.ParamByName('fecha').Value:= sFecha;
        rptComprobante.Report.Params.ParamByName('hora').Value:= sHora;
        rptComprobante.Report.Params.ParamByName('caja').Value:= sCaja;
        rptComprobante.Execute;
    end
    else
        Application.MessageBox('El archivo de retiro especificado no existe','Error',[smbOK],smsCritical);
    iniArchivo.Free;
end;

procedure TfrmReimprimir.chkFacturaClick(Sender: TObject);
begin
    if(chkFactura.Checked) then begin
        with dmDatos.qryModifica do begin
            Close;
            SQL.Clear;
            SQL.Add('SELECT MAX(numero) AS factura FROM comprobantes WHERE tipo = ''F''');
            Open;
            txtNumeroNuevo.Value := FieldByName('factura').AsInteger + 1;
            Close; 
        end;
    end
    else
        txtNumeroNuevo.Value := txtNumeroAnt.Value;
end;

procedure TfrmReimprimir.ImprimeCancela(sComprobante, sCaja, sNumero:String);
var
    iniArchivo : TIniFile;
    sArchCancela : String;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) +'config.ini');

    with dmDatos.qryModifica do begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT v.total, v.redondeo FROM comprobantes c LEFT JOIN ventas v ON c.venta = v.clave');
        SQL.Add('WHERE c.tipo = ''' + Copy(sComprobante,1,1) + '''');
        SQL.Add('AND c.numero = ' + sNumero + ' AND c.estatus = ''A''');
        if(sGlobal = 'S') then
            SQL.Add('AND c.caja = ' + sCaja);
        Open;
        Close;
    end;
    //Recupera el nombre del archivo del reporte de cancelación
    sArchCancela := iniArchivo.ReadString('Reportes', 'Cancela', '');
    if (Length(sArchCancela) > 0) and (FileExists(sArchCancela)) then begin
        rptComprobante.FileName := sArchCancela;
        rptComprobante.Report.Copies := 1;
        rptComprobante.Title := 'Cancelación: ' + sNumero ;
        rptComprobante.Report.DatabaseInfo.Items[0].SQLConnection := dmDatos.sqlBase.DataSets[0].SQLConnection;
        rptComprobante.Report.Params.ParamByName('Numero').Value:= sNumero;
        rptComprobante.Report.Params.ParamByName('Caja').Value:= sCaja;
        rptComprobante.Report.Params.ParamByName('Comprobante').Value:= Copy(sComprobante,1,1);
        rptComprobante.Execute;
    end
    else
        Application.MessageBox('El archivo del reporte de cancelación especificado no existe','Error',[smbOK],smsCritical);
    iniArchivo.Free;
end;

procedure TfrmReimprimir.txtNumeroAntExit(Sender: TObject);
begin
    txtNumeroNuevo.Value := txtNumeroAnt.Value;
    BuscaComp;
end;



end.
