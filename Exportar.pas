// --------------------------------------------------------------------------
// Archivo del Proyecto Ventas  
// Página del proyecto: http://sourceforge.net/projects/ventas
// --------------------------------------------------------------------------
// Este archivo puede ser distribuido y/o modificado bajo lo terminos de la
// Licencia Pública General versión 2 como es publicada por la Free Software
// Fundation, Inc.
// --------------------------------------------------------------------------

unit Exportar;

interface

uses
  SysUtils, Types, Classes, QGraphics, QControls, QForms, QDialogs,
  QStdCtrls, QButtons, QComCtrls, DBClient, IniFiles, SciZipFile;

type
  TfrmExportar = class(TForm)
    grpDatos: TGroupBox;
    chkArticulos: TCheckBox;
    btnExportar: TBitBtn;
    btnCancelar: TBitBtn;
    grpRuta: TGroupBox;
    txtRuta: TEdit;
    Label1: TLabel;
    btnDir: TBitBtn;
    grpAvance: TGroupBox;
    lblTabla: TLabel;
    chkClientes: TCheckBox;
    chkProveedores: TCheckBox;
    chkDepartamentos: TCheckBox;
    chkCategorias: TCheckBox;
    chkAreasVenta: TCheckBox;
    chkTiposPago: TCheckBox;
    chkUsuarios: TCheckBox;
    chkTicket: TCheckBox;
    chkEmpresa: TCheckBox;
    chkDescuentos: TCheckBox;
    chkVentas: TCheckBox;
    txtDiaVentaIni: TEdit;
    txtMesVentaIni: TEdit;
    txtAnioVentaIni: TEdit;
    lbl2: TLabel;
    lbl1: TLabel;
    txtDiaVentaFin: TEdit;
    txtMesVentaFin: TEdit;
    txtAnioVentaFin: TEdit;
    lbl4: TLabel;
    lbl3: TLabel;
    lblAl: TLabel;
    chkCompras: TCheckBox;
    txtDiaCompraIni: TEdit;
    txtMesCompraIni: TEdit;
    txtAnioCompraIni: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    txtDiaCompraFin: TEdit;
    txtMesCompraFin: TEdit;
    txtAnioCompraFin: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    chkCajas: TCheckBox;
    ChkVendedores: TCheckBox;
    chkInventario: TCheckBox;
    txtDiaInvIni: TEdit;
    txtMesInvIni: TEdit;
    txtAnioInvIni: TEdit;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    txtDiaInvFin: TEdit;
    Label10: TLabel;
    txtMesInvFin: TEdit;
    Label11: TLabel;
    txtAnioInvFin: TEdit;
    chkUnidades: TCheckBox;
    procedure btnExportarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure chkArticulosClick(Sender: TObject);
    procedure chkVentasClick(Sender: TObject);
    procedure Salta(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnDirClick(Sender: TObject);
    procedure txtRutaExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure chkComprasClick(Sender: TObject);
    procedure txtAnioVentaIniExit(Sender: TObject);
    procedure txtAnioVentaFinExit(Sender: TObject);
    procedure txtAnioCompraIniExit(Sender: TObject);
    procedure txtAnioCompraFinExit(Sender: TObject);
    procedure txtDiaVentaIniExit(Sender: TObject);
    procedure Rellena(Sender: TObject);
    procedure chkInventarioClick(Sender: TObject);
    procedure txtAnioInvIniExit(Sender: TObject);
    procedure txtAnioInvFinExit(Sender: TObject);

  private
    iIndice : integer;
    zipArchivo : TZipFile;
    StrStream : TStringStream;

    function VerificaDatos:boolean;
    procedure ExportaAreasVenta;
    procedure ExportaArticulos;
    procedure ExportaInventario;
    procedure ExportaJuegos;
    procedure RecuperaConfig;
    procedure ExportaClientes;
    procedure ExportaProveedores;
    procedure ExportaDepartamentos;
    procedure ExportaCategorias;
    procedure ExportaUnidades;
    procedure ExportaTiposPago;
    procedure ExportaUsuarios;
    procedure ExportaTicket;
    procedure ExportaEmpresa;
    procedure ExportaDescuentos;
    procedure ExportaCajas;
    function VerificaFechas(sFecha : string):boolean;
    procedure ExportaVentas;
    procedure ExportaVentasDet;
    procedure ExportaVentasPago;
    procedure ExportaNotasCredito;
    procedure ExportaComprobantes;
    procedure ExportaCompras;
    procedure ExportaComprasDet;
    procedure ExportaComprasPago;
    procedure ExportaCodigos;
    procedure ExportaVendedores;
    procedure ExportaCtsXCobrar;
    procedure ExportaInventario2;
  public
  end;

var
  frmExportar: TfrmExportar;

implementation

uses dm;

{$R *.xfm}

procedure TfrmExportar.btnExportarClick(Sender: TObject);
begin
    zipArchivo := TZipFile.Create ;
    iIndice := 0;

    if(VerificaDatos) then begin
        if(chkAreasVenta.Checked) then
            ExportaAreasVenta;
        if(chkArticulos.Checked) and ((not chkVentas.Checked) or (not chkCompras.Checked) )  then
            ExportaArticulos;
        if(chkCajas.Checked) then
            ExportaCajas;
        if(chkClientes.Checked) and (not chkVentas.Checked) then
            ExportaClientes;
        if(chkProveedores.Checked) and (not chkArticulos.Checked) then
            ExportaProveedores;
        if(chkDepartamentos.Checked) and (not chkArticulos.Checked) then
            ExportaDepartamentos;
        if(chkCategorias.Checked) and (not chkArticulos.Checked) then
            ExportaCategorias;
        if(chkUnidades.Checked) and (not chkArticulos.Checked) then
            ExportaUnidades;
        if(chkTiposPago.Checked) then
            ExportaTiposPago;
        if(chkUsuarios.Checked) and ( (not chkVentas.Checked) or (not chkCompras.Checked) ) then
            ExportaUsuarios;
        if(chkTicket.Checked) then
            ExportaTicket;
        if(chkEmpresa.Checked) then
            ExportaEmpresa;
        if(chkDescuentos.Checked) then
            ExportaDescuentos;
        if(chkVendedores.Checked) and (not chkVentas.Checked) then
            ExportaVendedores;
        if(chkVentas.Checked) then begin
            ExportaArticulos;
            ExportaClientes;
            ExportaUsuarios;
            ExportaVentas;
            ExportaVentasDet;
            ExportaVentasPago;
            ExportaNotasCredito;
            ExportaComprobantes;
            ExportaVendedores;
            ExportaCtsXCobrar;
        end;
        if(chkCompras.Checked) then begin
            ExportaArticulos;
            ExportaUsuarios;
            ExportaCompras;
            ExportaComprasDet;
            ExportaComprasPago;
        end;
        if(chkInventario.Checked) then
            ExportaInventario2;
        zipArchivo.SaveToFile(txtRuta.Text + 'ventas' + FormatDateTime('mmdd',Date) + '.zip');
        zipArchivo.Free;

        Application.MessageBox('Proceso terminado','Exportar',[smbOk]);
    end
end;

function TfrmExportar.VerificaDatos:boolean;
var
    dteFechaIni, dteFechaFin : TDateTime;
begin
    Result := true;
    if(Length(txtRuta.Text) > 0) then begin
        if(not DirectoryExists(txtRuta.Text)) then
            ForceDirectories(txtRuta.Text);
        if(not DirectoryExists(txtRuta.Text)) then begin
            Application.MessageBox('No se puede crear el directorio','Error',[smbOk]);
            txtRuta.SetFocus;
            Result := false;
        end;
        if(chkVentas.Checked) then begin
            if (not VerificaFechas(txtDiaVentaIni.Text + '/' + txtMesVentaIni.Text + '/' + txtAnioVentaIni.Text)) then begin
                Application.MessageBox('Introduce un fecha inicial válida para las ventas','Error',[smbOK],smsCritical);
                txtDiaVentaIni.SetFocus;
                Result := false;
            end
            else if (not VerificaFechas(txtDiaVentaFin.Text + '/' + txtMesVentaFin.Text + '/' + txtAnioVentaFin.Text)) then begin
                Application.MessageBox('Introduce un fecha final válida para las ventas','Error',[smbOK],smsCritical);
                txtDiaVentaFin.SetFocus;
                Result := false;
            end;
         end;
         if(chkVentas.Checked) and (Result) then begin
            dteFechaIni := StrToDate(txtDiaVentaIni.Text + '/' + txtMesVentaIni.Text + '/' + txtAnioVentaIni.Text);
            dteFechaFin := StrToDate(txtDiaVentaFin.Text + '/' + txtMesVentaFin.Text + '/' + txtAnioVentaFin.Text);
            if(dteFechaIni > dteFechaFin) then begin
                Application.MessageBox('La fecha final debe ser mayor o igual que la fecha inicial','Error',[smbOK],smsCritical);
                txtDiaVentaIni.SetFocus;
                Result := false;
            end;
         end;
         if (chkCompras.Checked) and (Result) then begin
            if (not VerificaFechas(txtDiaCompraIni.Text + '/' + txtMesCompraIni.Text + '/' + txtAnioCompraIni.Text)) then begin
                Application.MessageBox('Introduce un fecha inicial válida para las compras','Error',[smbOK],smsCritical);
                txtDiaCompraIni.SetFocus;
                Result := false;
            end
            else if (not VerificaFechas(txtDiaCompraFin.Text + '/' + txtMesCompraFin.Text + '/' + txtAnioCompraFin.Text)) then begin
                Application.MessageBox('Introduce un fecha final válida para las compras','Error',[smbOK],smsCritical);
                txtDiaCompraFin.SetFocus;
                Result := false;
            end;
         end;
         if(chkVentas.Checked) and (Result) then begin
            dteFechaIni := StrToDate(txtDiaVentaIni.Text + '/' + txtMesVentaIni.Text + '/' + txtAnioVentaIni.Text);
            dteFechaFin := StrToDate(txtDiaVentaFin.Text + '/' + txtMesVentaFin.Text + '/' + txtAnioVentaFin.Text);
            if(dteFechaIni > dteFechaFin) then begin
                Application.MessageBox('La fecha final debe ser mayor o igual que la fecha inicial','Error',[smbOK],smsCritical);
                txtDiaVentaIni.SetFocus;
                Result := false;
            end;
         end;
    end
    else begin
        Application.MessageBox('Introduce la ruta','Error',[smbOk]);
        txtRuta.SetFocus;
        Result := false;
    end;
end;

procedure TfrmExportar.ExportaAreasVenta;
begin
    lblTabla.Caption := 'Áreas de venta';
    lblTabla.Refresh;

    with dmDatos.qryImExportar do begin
        dmDatos.cdsImExportar.Active := false;
        Close;
        SQL.Clear;
        SQL.Add('SELECT nombre, caja, fecha_umov FROM areasventa ORDER BY nombre');
        Open;
        dmDatos.cdsImExportar.Active := true;

        zipArchivo.AddFile('areasventa.xml');
        strStream := TStringStream.Create('');
        dmDatos.cdsImExportar.SaveToStream(strStream,dfxml);
        zipArchivo.Data[iIndice] := strStream.DataString;
        Inc(iIndice);


        dmDatos.cdsImExportar.Active := false;
        Close;
        StrStream.Free;
    end;
end;

procedure TfrmExportar.ExportaArticulos;
begin
    ExportaJuegos;
    ExportaProveedores;
    ExportaDepartamentos;
    ExportaCategorias;
    ExportaInventario;
    ExportaCodigos;
    ExportaUnidades;
end;

procedure TfrmExportar.ExportaInventario;
begin
    lblTabla.Caption := 'Artículos';
    lblTabla.Refresh;

    with dmDatos.qryImExportar do begin
        dmDatos.cdsImExportar.Active := false;
        Close;
        SQL.Clear;
        SQL.Add('SELECT o.codigo, a.desc_corta, a.desc_larga, a.precio1, a.precio2,');
        SQL.Add('a.precio3, a.precio4, a.ult_costo, costoprom,  a.desc_auto, a.existencia,');
        SQL.Add('a.minimo, a.maximo, a.estatus, c.nombre AS categoria,');
        SQL.Add('d.nombre AS departamento, a.tipo, a.proveedor1, a.proveedor2,');
        SQL.Add('a.iva, a.fecha_cap, a.fecha_umov, a.estatus, a.existencia, a.fiscal FROM articulos a ');
        SQL.Add('LEFT JOIN codigos o ON o.articulo = a.clave AND o.tipo = ''P''');
        SQL.Add('LEFT JOIN categorias c ON a.categoria = c.clave');
        SQL.Add('AND c.tipo = ''A'' LEFT JOIN departamentos d ON a.departamento = d.clave ORDER BY o.codigo');
        Open;
        dmDatos.cdsImExportar.Active := true;

        zipArchivo.AddFile('articulos.xml');
        strStream := TStringStream.Create('');
        dmDatos.cdsImExportar.SaveToStream(strStream,dfxml);
        zipArchivo.Data[iIndice] := strStream.DataString;
        Inc(iIndice);

        dmDatos.cdsImExportar.Active := false;
        Close;
        StrStream.Free;
    end;
end;

procedure TfrmExportar.ExportaCodigos;
begin
    lblTabla.Caption := 'Códigos';
    lblTabla.Refresh;

    with dmDatos.qryImExportar do begin
        dmDatos.cdsImExportar.Active := false;
        Close;
        SQL.Clear;
        SQL.Add('SELECT o.codigo AS primario, c.codigo AS alterno FROM codigos c');
        SQL.Add('LEFT JOIN codigos o ON c.articulo = o.articulo AND o.tipo = ''P''');
        SQL.Add('WHERE c.tipo = ''S''');
        Open;
        dmDatos.cdsImExportar.Active := true;

        zipArchivo.AddFile('codigos.xml');
        strStream := TStringStream.Create('');
        dmDatos.cdsImExportar.SaveToStream(strStream,dfxml);
        zipArchivo.Data[iIndice] := strStream.DataString;
        Inc(iIndice);

        dmDatos.cdsImExportar.Active := false;
        Close;
        StrStream.Free;
    end;
end;

procedure TfrmExportar.ExportaJuegos;
begin
    lblTabla.Caption := 'Juegos';
    lblTabla.Refresh;

    with dmDatos.qryImExportar do begin
        dmDatos.cdsImExportar.Active := false;
        Close;
        SQL.Clear;
        SQL.Add('SELECT c.codigo AS juego, o.codigo, j.cantidad, j.precio');
        SQL.Add('FROM juegos j LEFT JOIN codigos c ON j.clave = c.articulo AND c.tipo = ''P''');
        SQL.Add('LEFT JOIN codigos o ON j.articulo = o.articulo ORDER BY c.codigo, o.codigo');
        Open;
        dmDatos.cdsImExportar.Active := true;

        zipArchivo.AddFile('juegos.xml');
        strStream := TStringStream.Create('');
        dmDatos.cdsImExportar.SaveToStream(strStream,dfxml);
        zipArchivo.Data[iIndice] := strStream.DataString;
        Inc(iIndice);

        dmDatos.cdsImExportar.Active := false;
        Close;
        StrStream.Free;
    end;
end;

procedure TfrmExportar.ExportaClientes;
begin
    lblTabla.Caption := 'Clientes';
    lblTabla.Refresh;

    with dmDatos.qryImExportar do begin
        dmDatos.cdsImExportar.Active := false;
        Close;
        SQL.Clear;
        SQL.Add('SELECT nombre, rfc, calle, colonia, localidad, estado,');
        SQL.Add('cp, ecorreo, descuento, telefono, credencial, vencimcreden,');
        SQL.Add('limitecredito, ultimacompra, contacto, empresa, rfcemp,');
        SQL.Add('calleemp, coloniaemp, localidademp, estadoemp, cpemp,');
        SQL.Add('correoemp, celular, faxemp, telemp, fechacap, fechaumov,');
        SQL.Add('precio, categoria FROM clientes');
        Open;
        dmDatos.cdsImExportar.Active := true;

        zipArchivo.AddFile('clientes.xml');
        strStream := TStringStream.Create('');
        dmDatos.cdsImExportar.SaveToStream(strStream,dfxml);
        zipArchivo.Data[iIndice] := strStream.DataString;
        Inc(iIndice);

        dmDatos.cdsImExportar.Active := false;
        Close;
        StrStream.Free;
    end;
end;

procedure TfrmExportar.ExportaProveedores;
begin
    lblTabla.Caption := 'Proveedores';
    lblTabla.Refresh;

    with dmDatos.qryImExportar do begin
        dmDatos.cdsImExportar.Active := false;
        Close;
        SQL.Clear;
        SQL.Add('SELECT p.clave, p.rfc, p.nombre, p.calle, p.colonia, p.cp,');
        SQL.Add('p.localidad, p.estado, p.encargado, p.fax, p.ecorreo, p.nombrefiscal,');
        SQL.Add('p.fecha_cap, p.telefono, p.fecha_umov, c.nombre AS categoria');
        SQL.Add('FROM proveedores p LEFT JOIN categorias c');
        SQL.Add('ON p.categoria = c.clave AND c.tipo = ''P'' ORDER BY p.nombre');
        Open;
        dmDatos.cdsImExportar.Active := true;

        zipArchivo.AddFile('proveedores.xml');
        strStream := TStringStream.Create('');
        dmDatos.cdsImExportar.SaveToStream(strStream,dfxml);
        zipArchivo.Data[iIndice] := strStream.DataString;
        Inc(iIndice);

        dmDatos.cdsImExportar.Active := false;
        Close;
        StrStream.Free;
    end;
end;

procedure TfrmExportar.ExportaDepartamentos;
begin
    lblTabla.Caption := 'Departamentos';
    lblTabla.Refresh;

    with dmDatos.qryImExportar do begin
        dmDatos.cdsImExportar.Active := false;
        Close;
        SQL.Clear;
        SQL.Add('SELECT nombre, fecha_umov FROM departamentos ORDER BY nombre');
        Open;
        dmDatos.cdsImExportar.Active := true;

        zipArchivo.AddFile('departamentos.xml');
        strStream := TStringStream.Create('');
        dmDatos.cdsImExportar.SaveToStream(strStream,dfxml);
        zipArchivo.Data[iIndice] := strStream.DataString;
        Inc(iIndice);

        dmDatos.cdsImExportar.Active := false;
        Close;
        StrStream.Free;
    end;
end;

procedure TfrmExportar.ExportaCajas;
begin
    lblTabla.Caption := 'Cajas';
    lblTabla.Refresh;

    with dmDatos.qryImExportar do begin
        dmDatos.cdsImExportar.Active := false;
        Close;
        SQL.Clear;
        SQL.Add('SELECT numero, nombre, serieticket, serienota, seriefactura, fecha_umov FROM cajas ORDER BY numero');
        Open;
        dmDatos.cdsImExportar.Active := true;

        zipArchivo.AddFile('cajas.xml');
        strStream := TStringStream.Create('');
        dmDatos.cdsImExportar.SaveToStream(strStream,dfxml);
        zipArchivo.Data[iIndice] := strStream.DataString;
        Inc(iIndice);

        dmDatos.cdsImExportar.Active := false;
        Close;
        StrStream.Free;
    end;
end;

procedure TfrmExportar.ExportaCategorias;
begin
    lblTabla.Caption := 'Categorias';
    lblTabla.Refresh;

    with dmDatos.qryImExportar do begin
        dmDatos.cdsImExportar.Active := false;
        Close;
        SQL.Clear;
        SQL.Add('SELECT nombre, tipo, cuenta, fecha_umov FROM categorias ORDER BY nombre');
        Open;
        dmDatos.cdsImExportar.Active := true;

        zipArchivo.AddFile('categorias.xml');
        strStream := TStringStream.Create('');
        dmDatos.cdsImExportar.SaveToStream(strStream,dfxml);
        zipArchivo.Data[iIndice] := strStream.DataString;
        Inc(iIndice);

        dmDatos.cdsImExportar.Active := false;
        Close;
        StrStream.Free;
    end;
end;

procedure TfrmExportar.ExportaUnidades;
begin
    lblTabla.Caption := 'Unidades';
    lblTabla.Refresh;

    with dmDatos.qryImExportar do begin
        dmDatos.cdsImExportar.Active := false;
        Close;
        SQL.Clear;
        SQL.Add('SELECT nombre, tipo, fecha_umov FROM unidades ORDER BY nombre');
        Open;
        dmDatos.cdsImExportar.Active := true;

        zipArchivo.AddFile('unidades.xml');
        strStream := TStringStream.Create('');
        dmDatos.cdsImExportar.SaveToStream(strStream,dfxml);
        zipArchivo.Data[iIndice] := strStream.DataString;
        Inc(iIndice);

        dmDatos.cdsImExportar.Active := false;
        Close;
        StrStream.Free;
    end;
end;

procedure TfrmExportar.ExportaTiposPago;
begin
    lblTabla.Caption := 'Tipos de pago';
    lblTabla.Refresh;

    with dmDatos.qryImExportar do begin
        dmDatos.cdsImExportar.Active := false;
        Close;
        SQL.Clear;
        SQL.Add('SELECT nombre, abrircajon, referencia, fecha_umov, modo,');
        SQL.Add('pagos, plazo, interes, enganche, montominimo, aplica, ');
        SQL.Add('intmoratorio, tipointeres, tipoplazo FROM tipopago ORDER BY nombre');
        Open;
        dmDatos.cdsImExportar.Active := true;

        zipArchivo.AddFile('tipospago.xml');
        strStream := TStringStream.Create('');
        dmDatos.cdsImExportar.SaveToStream(strStream,dfxml);
        zipArchivo.Data[iIndice] := strStream.DataString;
        Inc(iIndice);

        dmDatos.cdsImExportar.Active := false;
        Close;
        StrStream.Free;
    end;
end;

procedure TfrmExportar.ExportaUsuarios;
begin
    lblTabla.Caption := 'Usuarios';
    lblTabla.Refresh;

    with dmDatos.qryImExportar do begin
        dmDatos.cdsImExportar.Active := false;
        Close;
        SQL.Clear;
        SQL.Add('SELECT login, contra, nombre, calle, colonia, cp,');
        SQL.Add('localidad, estado, telefono, fecha_cap, fecha_umov, descuento');
        SQL.Add('FROM usuarios ORDER BY login');
        Open;
        dmDatos.cdsImExportar.Active := true;

        zipArchivo.AddFile('usuarios.xml');
        strStream := TStringStream.Create('');
        dmDatos.cdsImExportar.SaveToStream(strStream,dfxml);
        zipArchivo.Data[iIndice] := strStream.DataString;
        Inc(iIndice);

        dmDatos.cdsImExportar.Active := false;
        Close;
        StrStream.Free;

        dmDatos.cdsImExportar.Active := false;
        Close;
        SQL.Clear;
        SQL.Add('SELECT u.login, p.menu, p.opciones, p.permiso FROM permisos p');
        SQL.Add('LEFT JOIN usuarios u ON p.usuario = u.clave ORDER BY u.login, p.menu');
        Open;
        dmDatos.cdsImExportar.Active := true;

        zipArchivo.AddFile('permisos.xml');
        strStream := TStringStream.Create('');
        dmDatos.cdsImExportar.SaveToStream(strStream,dfxml);
        zipArchivo.Data[iIndice] := strStream.DataString;
        Inc(iIndice);

        dmDatos.cdsImExportar.Active := false;
        Close;
        StrStream.Free;

        dmDatos.cdsImExportar.Active := false;
        Close;
        SQL.Clear;
        SQL.Add('SELECT u.login, p.clave, p.adicional FROM privilegios p');
        SQL.Add('LEFT JOIN usuarios u ON p.usuario = u.clave ORDER BY u.login, p.clave');
        Open;
        dmDatos.cdsImExportar.Active := true;

        zipArchivo.AddFile('privilegios.xml');
        strStream := TStringStream.Create('');
        dmDatos.cdsImExportar.SaveToStream(strStream,dfxml);
        zipArchivo.Data[iIndice] := strStream.DataString;
        Inc(iIndice);

        dmDatos.cdsImExportar.Active := false;
        Close;
        StrStream.Free;
    end;
end;

procedure TfrmExportar.ExportaTicket;
begin
    lblTabla.Caption := 'Ticket';
    lblTabla.Refresh;

    with dmDatos.qryImExportar do begin
        dmDatos.cdsImExportar.Active := false;
        Close;
        SQL.Clear;
        SQL.Add('SELECT nivel, renglon, texto FROM ticket ORDER BY nivel, renglon');
        Open;
        dmDatos.cdsImExportar.Active := true;

        zipArchivo.AddFile('ticket.xml');
        strStream := TStringStream.Create('');
        dmDatos.cdsImExportar.SaveToStream(strStream,dfxml);
        zipArchivo.Data[iIndice] := strStream.DataString;
        Inc(iIndice);

        dmDatos.cdsImExportar.Active := false;
        Close;
        StrStream.Free;
    end;
end;

procedure TfrmExportar.ExportaEmpresa;
begin
    lblTabla.Caption := 'Empresa';
    lblTabla.Refresh;

    with dmDatos.qryImExportar do begin
        dmDatos.cdsImExportar.Active := false;
        Close;
        SQL.Clear;
        SQL.Add('SELECT * FROM empresa');
        Open;
        dmDatos.cdsImExportar.Active := true;

        zipArchivo.AddFile('empresa.xml');
        strStream := TStringStream.Create('');
        dmDatos.cdsImExportar.SaveToStream(strStream,dfxml);
        zipArchivo.Data[iIndice] := strStream.DataString;
        Inc(iIndice);

        dmDatos.cdsImExportar.Active := false;
        Close;
        StrStream.Free;
    end;
end;

procedure TfrmExportar.ExportaDescuentos;
begin
    lblTabla.Caption := 'Descuentos';
    lblTabla.Refresh;

    with dmDatos.qryImExportar do begin
        dmDatos.cdsImExportar.Active := false;
        Close;
        SQL.Clear;
        SQL.Add('SELECT d.fechaini, d.fechafin, o.codigo, p.nombre AS departamento,');
        SQL.Add('c.nombre AS categoria, d.total, d.cantidad, d.porcentaje, d.volumen');
        SQL.Add('FROM descuentos d LEFT JOIN codigos o ON d.articulo = o.codigo AND tipo = ''P''');
        SQL.Add('LEFT JOIN departamentos p ON d.departamento = p.clave');
        SQL.Add('LEFT JOIN categorias c ON d.categoria = c.clave');
        SQL.Add('ORDER BY d.fechaini, d.fechafin');
        Open;
        dmDatos.cdsImExportar.Active := true;

        zipArchivo.AddFile('descuentos.xml');
        strStream := TStringStream.Create('');
        dmDatos.cdsImExportar.SaveToStream(strStream,dfxml);
        zipArchivo.Data[iIndice] := strStream.DataString;
        Inc(iIndice);

        dmDatos.cdsImExportar.Active := false;
        Close;
        StrStream.Free;
    end;
end;

procedure TfrmExportar.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
    iniArchivo : TIniFile;
    i : integer;
begin

    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'config.ini');

    with iniArchivo do begin
        // Registra la posición y de la ventana
        WriteString('Exportar', 'Posy', IntToStr(Top));

        // Registra la posición X de la ventana
        WriteString('Exportar', 'Posx', IntToStr(Left));

        for i := 0 to grpDatos.ControlCount - 1do
            if (grpDatos.Controls[i] is TCheckBox) then
                if((grpDatos.Controls[i] as TCheckBox).Checked) then
                    WriteString('Exportar', grpDatos.Controls[i].Name, 'S')
                else
                    WriteString('Exportar', grpDatos.Controls[i].Name, 'N');

        // Registra la ruta de exportación
        WriteString('Exportar', 'Ruta', txtRuta.Text);

        // Registra la fecha inicial de las ventas
        WriteString('Exportar', 'VentasIni', txtDiaVentaIni.Text + txtMesVentaIni.Text + txtAnioVentaIni.Text);

        // Registra la fecha final de las ventas
        WriteString('Exportar', 'VentasFin', txtDiaVentaFin.Text + txtMesVentaFin.Text + txtAnioVentaFin.Text);

        Free;
    end;
end;

procedure TfrmExportar.RecuperaConfig;
var
    iniArchivo : TIniFile;
    sIzq, sArriba, sValor: String;
    i : integer;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'config.ini');

    with iniArchivo do begin
        //Recupera la posición Y de la ventana
        sArriba := ReadString('Exportar', 'Posy', '');

        //Recupera la posición X de la ventana
        sIzq := ReadString('Exportar', 'Posx', '');

        if (Length(sIzq) > 0) and (Length(sArriba) > 0) then begin
            Left := StrToInt(sIzq);
            Top := StrToInt(sArriba);
        end;

        //Recupera la ruta de exportación
        sValor := ReadString('Exportar', 'Ruta', '');
        if (Length(sValor) > 0) then
            txtRuta.Text := sValor;

        for i := 0 to grpDatos.ControlCount - 1 do
            if (grpDatos.Controls[i] is TCheckBox) then begin
                sValor := ReadString('Exportar', grpDatos.Controls[i].Name, '');
                if(sValor = 'S') then
                    (grpDatos.Controls[i] as TCheckBox).Checked := true;
        end;


        //Recupera la fecha inicial de ventas
        sValor := ReadString('Exportar', 'VentasIni', '');
        if (Length(sValor) > 0) then begin
            txtDiaVentaIni.Text := Copy(sValor,1,2);
            txtMesVentaIni.Text := Copy(sValor,3,2);
            txtAnioVentaIni.Text := Copy(sValor,5,4);
        end;

        //Recupera la fecha final de ventas
        sValor := ReadString('Exportar', 'VentasFin', '');
        if (Length(sValor) > 0) then begin
            txtDiaVentaFin.Text := Copy(sValor,1,2);
            txtMesVentaFin.Text := Copy(sValor,3,2);
            txtAnioVentaFin.Text := Copy(sValor,5,4);
        end;

        Free;
    end;
end;

procedure TfrmExportar.chkArticulosClick(Sender: TObject);
begin
    if(chkArticulos.Checked) then begin
        chkProveedores.Checked := true;
        chkDepartamentos.Checked := true;
        chkCategorias.Checked := true;
        chkUnidades.Checked := true;
        chkProveedores.Enabled := false;
        chkDepartamentos.Enabled := false;
        chkCategorias.Enabled := false;
        chkUnidades.Enabled := false;
    end
    else begin
        chkProveedores.Checked := false;
        chkDepartamentos.Checked := false;
        chkCategorias.Checked := false;
        chkUnidades.Checked := false;
        chkProveedores.Enabled := true;
        chkDepartamentos.Enabled := true;
        chkCategorias.Enabled := true;
        chkUnidades.Enabled := true;
    end;
end;

function TfrmExportar.VerificaFechas(sFecha : string):boolean;
var
   dteFecha : TDateTime;
begin
   Result:=true;
   if(not TryStrToDate(sFecha,dteFecha)) then begin
      Result:=false;
   end;
end;

procedure TfrmExportar.ExportaVentas;
var
    sFechaIni, sFechaFin : String;
begin
    lblTabla.Caption := 'Ventas';
    lblTabla.Refresh;

    sFechaIni := txtMesVentaIni.Text + '/' + txtDiaVentaIni.Text + '/' + txtAnioVentaIni.Text;
    sFechaFin := txtMesVentaFin.Text + '/' + txtDiaVentaFin.Text + '/' + txtAnioVentaFin.Text;

    with dmDatos.qryImExportar do begin
        dmDatos.cdsImExportar.Active := false;
        Close;
        SQL.Clear;
        SQL.Add('SELECT v.caja, v.numero, v.iva, v.total, v.cambio,');
        SQL.Add('v.redondeo, v.estatus, c.nombre AS cliente, u.login, v.fecha, v.hora,');
        SQL.Add('a.nombre AS area, t.caja AS cajaref, t.fecha AS fecharef,');
        SQL.Add('t.hora AS horaref FROM ventas v LEFT JOIN clientes c ON v.cliente = c.clave');
        SQL.Add('LEFT JOIN usuarios u ON v.usuario = u.clave LEFT ');
        SQL.Add('JOIN areasventa a ON v.areaventa = a.clave');
        SQL.Add('LEFT JOIN ventas t ON t.clave = v.ventaref');
        SQL.Add('WHERE v.fecha >= ''' + sFechaIni + ''' AND ');
        SQL.Add('v.fecha <= ''' + sFechaFin + '''');
        SQL.Add('ORDER BY v.fecha, v.hora');
        Open;
        dmDatos.cdsImExportar.Active := true;

        zipArchivo.AddFile('ventas.xml');
        strStream := TStringStream.Create('');
        dmDatos.cdsImExportar.SaveToStream(strStream,dfxml);
        zipArchivo.Data[iIndice] := strStream.DataString;
        Inc(iIndice);

        dmDatos.cdsImExportar.Active := false;
        Close;
        StrStream.Free;
    end;
end;

procedure TfrmExportar.ExportaVentasDet;
var
    sFechaIni, sFechaFin : String;
begin
    lblTabla.Caption := 'Detalle ventas';
    lblTabla.Refresh;

    sFechaIni := txtMesVentaIni.Text + '/' + txtDiaVentaIni.Text + '/' + txtAnioVentaIni.Text;
    sFechaFin := txtMesVentaFin.Text + '/' + txtDiaVentaFin.Text + '/' + txtAnioVentaFin.Text;

    with dmDatos.qryImExportar do begin
        dmDatos.cdsImExportar.Active := false;
        Close;
        SQL.Clear;
        SQL.Add('SELECT v.caja, v.fecha, v.hora, d.orden, o.codigo, d.cantidad, ');
        SQL.Add('d.iva, d.precio, d.descuento, d.juego, d.devolucion, d.ventareforden, d.fiscal');
        SQL.Add('FROM ventas v RIGHT JOIN ventasdet d ON ');
        SQL.Add('v.clave = d.venta LEFT JOIN codigos  o ON d.articulo = o.articulo AND o.tipo =''P'' ');
        SQL.Add('WHERE v.fecha >= ''' + sFechaIni + ''' AND ');
        SQL.Add('v.fecha <= ''' + sFechaFin + ''' ORDER BY d.venta, d.orden');
        Open;
        dmDatos.cdsImExportar.Active := true;

        zipArchivo.AddFile('ventasdet.xml');
        strStream := TStringStream.Create('');
        dmDatos.cdsImExportar.SaveToStream(strStream,dfxml);
        zipArchivo.Data[iIndice] := strStream.DataString;
        Inc(iIndice);

        dmDatos.cdsImExportar.Active := false;
        Close;
        StrStream.Free;
    end;
end;

procedure TfrmExportar.ExportaVentasPago;
var
    sFechaIni, sFechaFin : String;
begin
    lblTabla.Caption := 'Pago ventas';
    lblTabla.Refresh;

    sFechaIni := txtMesVentaIni.Text + '/' + txtDiaVentaIni.Text + '/' + txtAnioVentaIni.Text;
    sFechaFin := txtMesVentaFin.Text + '/' + txtDiaVentaFin.Text + '/' + txtAnioVentaFin.Text;

    with dmDatos.qryImExportar do begin
        dmDatos.cdsImExportar.Active := false;
        Close;
        SQL.Clear;
        SQL.Add('SELECT v.caja, v.fecha, v.hora, t.nombre, p.importe, p.referencia,');
        SQL.Add('p.orden, n.numero AS notacredito, n.caja AS cajanotacred');
        SQL.Add('FROM ventaspago p LEFT JOIN ventas v ON p.venta = v.clave ');
        SQL.Add('LEFT JOIN tipopago t ON p.tipopago = t.clave ');
        SQL.Add('LEFT JOIN notascredito n ON p.notacredito = n.clave');
        SQL.Add('WHERE v.fecha >= ''' + sFechaIni + ''' AND v.fecha <= ''' + sFechaFin + '''');
        Open;
        dmDatos.cdsImExportar.Active := true;

        zipArchivo.AddFile('ventaspago.xml');
        strStream := TStringStream.Create('');
        dmDatos.cdsImExportar.SaveToStream(strStream,dfxml);
        zipArchivo.Data[iIndice] := strStream.DataString;
        Inc(iIndice);

        dmDatos.cdsImExportar.Active := false;
        Close;
        StrStream.Free;
    end;
end;

procedure TfrmExportar.ExportaNotasCredito;
var
    sFechaIni, sFechaFin : String;
begin
    lblTabla.Caption := 'Notas de crédito';
    lblTabla.Refresh;

    sFechaIni := txtMesVentaIni.Text + '/' + txtDiaVentaIni.Text + '/' + txtAnioVentaIni.Text;
    sFechaFin := txtMesVentaFin.Text + '/' + txtDiaVentaFin.Text + '/' + txtAnioVentaFin.Text;

    with dmDatos.qryImExportar do begin
        dmDatos.cdsImExportar.Active := false;
        Close;
        SQL.Clear;
        SQL.Add('SELECT n.numero, n.fecha, n.importe, n.estatus, n.caja, c.nombre AS cliente,');
        SQL.Add('b.numero AS numcomprob, b.caja AS cajacomprob FROM notascredito n LEFT JOIN clientes c ON n.cliente = c.clave');
        SQL.Add('LEFT JOIN comprobantes b ON n.comprobante = b.clave ORDER BY n.numero');
        Open;
        dmDatos.cdsImExportar.Active := true;

        zipArchivo.AddFile('notascredito.xml');
        strStream := TStringStream.Create('');
        dmDatos.cdsImExportar.SaveToStream(strStream,dfxml);
        zipArchivo.Data[iIndice] := strStream.DataString;
        Inc(iIndice);

        dmDatos.cdsImExportar.Active := false;
        Close;
        StrStream.Free;
    end;
end;

procedure TfrmExportar.ExportaComprobantes;
var
    sFechaIni, sFechaFin : String;
begin
    lblTabla.Caption := 'Comprobantes';
    lblTabla.Refresh;

    sFechaIni := txtMesVentaIni.Text + '/' + txtDiaVentaIni.Text + '/' + txtAnioVentaIni.Text;
    sFechaFin := txtMesVentaFin.Text + '/' + txtDiaVentaFin.Text + '/' + txtAnioVentaFin.Text;

    with dmDatos.qryImExportar do begin
        dmDatos.cdsImExportar.Active := false;
        Close;
        SQL.Clear;
        SQL.Add('SELECT v.caja, v.fecha, v.hora, c.tipo, c.numero, l.nombre AS cliente, ');
        SQL.Add('c.fecha, c.estatus, c.caja FROM ventas v RIGHT JOIN comprobantes c ON ');
        SQL.Add('v.clave = c.venta LEFT JOIN clientes l ON c.cliente = l.clave ');
        SQL.Add('WHERE v.fecha >= ''' + sFechaIni + ''' AND ');
        SQL.Add('v.fecha <= ''' + sFechaFin + ''' ORDER BY c.tipo, c.numero, c.estatus');
        Open;
        dmDatos.cdsImExportar.Active := true;

        zipArchivo.AddFile('comprobantes.xml');
        strStream := TStringStream.Create('');
        dmDatos.cdsImExportar.SaveToStream(strStream,dfxml);
        zipArchivo.Data[iIndice] := strStream.DataString;
        Inc(iIndice);

        dmDatos.cdsImExportar.Active := false;
        Close;
        StrStream.Free;
    end;
end;

procedure TfrmExportar.chkVentasClick(Sender: TObject);
begin
    if(chkVentas.Checked) then begin
        chkArticulos.Checked := true;
        chkArticulos.Enabled := false;
        txtDiaVentaIni.Visible := true;
        txtMesVentaIni.Visible := true;
        txtAnioVentaIni.Visible := true;
        txtDiaVentaFin.Visible := true;
        txtMesVentaFin.Visible := true;
        txtAnioVentaFin.Visible := true;
        txtDiaVentaIni.SetFocus;
    end
    else begin
        chkArticulos.Enabled := true;
        txtDiaVentaIni.Visible := false;
        txtMesVentaIni.Visible := false;
        txtAnioVentaIni.Visible := false;
        txtDiaVentaFin.Visible := false;
        txtMesVentaFin.Visible := false;
        txtAnioVentaFin.Visible := false;
    end;
end;

procedure TfrmExportar.Salta(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    {Inicio (36), Fin (35), Izquierda (37), derecha (39), arriba (38), abajo (40)}
    if(Key >= 30) and (Key <= 122) and (Key <> 35) and (Key <> 36) and not ((Key >= 37) and (Key <= 40)) then
        if( Length((Sender as TEdit).Text) = (Sender as TEdit).MaxLength) then
            SelectNext(Sender as TWidgetControl, true, true);
end;

procedure TfrmExportar.btnDirClick(Sender: TObject);
var
    sDir: WideString;
begin
    if(SelectDirectory('Seleccionar directorio','',sDir)) then begin
        txtRuta.Text := sDir;
        txtRutaExit(Sender);
    end;
    btnDir.SetFocus;
end;

procedure TfrmExportar.txtRutaExit(Sender: TObject);
var
    sDirSep : String;
begin
    {$IFDEF MSWINDOWS}
        sDirSep:='\';
    {$ENDIF}
    {$IFDEF LINUX}
        sDirSep:='/';
    {$ENDIF}
    txtRuta.Text := Trim(txtRuta.Text);
    if(Copy(txtRuta.Text,Length(txtRuta.Text),1) <> sDirSep) then
        txtRuta.Text := txtRuta.Text + sDirSep;
end;

procedure TfrmExportar.FormCreate(Sender: TObject);
begin
    RecuperaConfig;
end;

procedure TfrmExportar.chkComprasClick(Sender: TObject);
begin
    if(chkCompras.Checked) then begin
        txtDiaCompraIni.Visible := true;
        txtMesCompraIni.Visible := true;
        txtAnioCompraIni.Visible := true;
        txtDiaCompraFin.Visible := true;
        txtMesCompraFin.Visible := true;
        txtAnioCompraFin.Visible := true;
        txtDiaCompraIni.SetFocus;
    end
    else begin
        txtDiaCompraIni.Visible := false;
        txtMesCompraIni.Visible := false;
        txtAnioCompraIni.Visible := false;
        txtDiaCompraFin.Visible := false;
        txtMesCompraFin.Visible := false;
        txtAnioCompraFin.Visible := false;
    end;
end;

procedure TfrmExportar.ExportaCompras;
var
    sFechaIni, sFechaFin : String;
begin
    lblTabla.Caption := 'Compras';
    lblTabla.Refresh;

    sFechaIni := txtMesCompraIni.Text + '/' + txtDiaCompraIni.Text + '/' + txtAnioCompraIni.Text;
    sFechaFin := txtMesCompraFin.Text + '/' + txtDiaCompraFin.Text + '/' + txtAnioCompraFin.Text;

    with dmDatos.qryImExportar do begin
        dmDatos.cdsImExportar.Active := false;
        Close;
        SQL.Clear;
        SQL.Add('SELECT c.documento, c.fecha, c.estatus, c.caja, c.fecha_cap, c.iva, c.total, ');
        SQL.Add('p.clave, u.login, c.descuento, c.tipo FROM compras c LEFT JOIN proveedores p ON');
        SQL.Add('c.proveedor = p.clave LEFT JOIN usuarios u ON c.usuario = u.clave');
        SQL.Add('WHERE c.fecha >= ''' + sFechaIni + ''' AND ');
        SQL.Add('c.fecha <= ''' + sFechaFin + '''');
        Open;
        dmDatos.cdsImExportar.Active := true;

        zipArchivo.AddFile('compras.xml');
        strStream := TStringStream.Create('');
        dmDatos.cdsImExportar.SaveToStream(strStream,dfxml);
        zipArchivo.Data[iIndice] := strStream.DataString;
        Inc(iIndice);

        dmDatos.cdsImExportar.Active := false;
        Close;
        StrStream.Free;
    end;
end;

procedure TfrmExportar.ExportaComprasDet;
var
    sFechaIni, sFechaFin : String;
begin
    lblTabla.Caption := 'Detalle compras';
    lblTabla.Refresh;

    sFechaIni := txtMesCompraIni.Text + '/' + txtDiaCompraIni.Text + '/' + txtAnioCompraIni.Text;
    sFechaFin := txtMesCompraFin.Text + '/' + txtDiaCompraFin.Text + '/' + txtAnioCompraFin.Text;

    with dmDatos.qryImExportar do begin
        dmDatos.cdsImExportar.Active := false;
        Close;
        SQL.Clear;
        SQL.Add('SELECT c.documento, c.fecha, c.estatus, c.caja, c.fecha_cap, d.orden, o.codigo,');
        SQL.Add('d.cantidad, d.iva, d.costo, d.descuento, d.fiscal FROM compras c RIGHT JOIN comprasdet d ON ');
        SQL.Add('c.clave = d.compra LEFT JOIN articulos a ON d.articulo = a.clave ');
        SQL.Add('LEFT JOIN codigos o ON o.articulo = a.clave AND o.tipo = ''P''');
        SQL.Add('WHERE c.fecha >= ''' + sFechaIni + ''' AND ');
        SQL.Add('c.fecha <= ''' + sFechaFin + ''' ORDER BY d.compra, d.orden');
        Open;
        dmDatos.cdsImExportar.Active := true;

        zipArchivo.AddFile('comprasdet.xml');
        strStream := TStringStream.Create('');
        dmDatos.cdsImExportar.SaveToStream(strStream,dfxml);
        zipArchivo.Data[iIndice] := strStream.DataString;
        Inc(iIndice);

        dmDatos.cdsImExportar.Active := false;
        Close;
        StrStream.Free;
    end;
end;

procedure TfrmExportar.ExportaComprasPago;
var
    sFechaIni, sFechaFin : String;
begin
    lblTabla.Caption := 'Pago compras';
    lblTabla.Refresh;

    sFechaIni := txtMesCompraIni.Text + '/' + txtDiaCompraIni.Text + '/' + txtAnioCompraIni.Text;
    sFechaFin := txtMesCompraFin.Text + '/' + txtDiaCompraFin.Text + '/' + txtAnioCompraFin.Text;

    with dmDatos.qryImExportar do begin
        dmDatos.cdsImExportar.Active := false;
        Close;
        SQL.Clear;
        SQL.Add('SELECT c.documento, c.fecha, c.estatus, c.caja, c.fecha_cap, t.nombre,');
        SQL.Add('p.importe, p.referencia FROM compraspago p LEFT JOIN compras c ON p.compra = c.clave ');
        SQL.Add('LEFT JOIN tipopago t ON p.tipopago = t.clave ');
        SQL.Add('WHERE c.fecha >= ''' + sFechaIni + ''' AND c.fecha <= ''' + sFechaFin + '''');
        Open;
        dmDatos.cdsImExportar.Active := true;

        zipArchivo.AddFile('compraspago.xml');
        strStream := TStringStream.Create('');
        dmDatos.cdsImExportar.SaveToStream(strStream,dfxml);
        zipArchivo.Data[iIndice] := strStream.DataString;
        Inc(iIndice);

        dmDatos.cdsImExportar.Active := false;
        Close;
        StrStream.Free;
    end;
end;

procedure TfrmExportar.txtAnioVentaIniExit(Sender: TObject);
begin
    txtAnioVentaIni.Text := Trim(txtAnioVentaIni.Text);
    if(Length(txtAnioVentaIni.Text) < 4) and (Length(txtAnioVentaIni.Text) > 0) then
        txtAnioVentaIni.Text := IntToStr(StrToInt(txtAnioVentaIni.Text) + 2000);
end;

procedure TfrmExportar.txtAnioVentaFinExit(Sender: TObject);
begin
     txtAnioVentaFin.Text := Trim(txtAnioVentaFin.Text);
    if(Length(txtAnioVentaFin.Text) < 4) and (Length(txtAnioVentaFin.Text) > 0) then
        txtAnioVentaFin.Text := IntToStr(StrToInt(txtAnioVentafin.Text) + 2000);
end;

procedure TfrmExportar.txtAnioCompraIniExit(Sender: TObject);
begin
    txtAnioCompraIni.Text := Trim(txtAnioCompraIni.Text);
    if(Length(txtAnioCompraIni.Text) < 4) and (Length(txtAnioCompraIni.Text) > 0) then
        txtAnioCompraIni.Text := IntToStr(StrToInt(txtAnioCompraIni.Text) + 2000);
end;

procedure TfrmExportar.txtAnioCompraFinExit(Sender: TObject);
begin
    txtAnioCompraFin.Text := Trim(txtAnioCompraFin.Text);
    if(Length(txtAnioCompraFin.Text) < 4) and (Length(txtAnioCompraFin.Text) > 0) then
        txtAnioCompraFin.Text := IntToStr(StrToInt(txtAnioCompraFin.Text) + 2000);
end;

procedure TfrmExportar.txtDiaVentaIniExit(Sender: TObject);
begin
    Rellena(Sender);
end;
procedure TfrmExportar.Rellena(Sender: TObject);
var
    i : integer;
begin
    for i := Length((Sender as TEdit).Text) to (Sender as TEdit).MaxLength - 1 do
        (Sender as TEdit).Text := '0' + (Sender as TEdit).Text;
end;

procedure TfrmExportar.ExportaVendedores;
begin
    lblTabla.Caption := 'Vendedores';
    lblTabla.Refresh;

    with dmDatos.qryImExportar do begin
        dmDatos.cdsImExportar.Active := false;
        Close;
        SQL.Clear;
        SQL.Add('SELECT v.clave, v.rfc, v.nombre, v.calle, v.colonia, v.cp,');
        SQL.Add('v.localidad, v.estado, v.fax, v.ecorreo,');
        SQL.Add('v.fecha_cap, v.telefono, v.fecha_umov, c.nombre AS categoria');
        SQL.Add('FROM vendedores v LEFT JOIN categorias c');
        SQL.Add('ON v.categoria = c.clave AND c.tipo = ''V'' ORDER BY v.nombre');
        Open;
        dmDatos.cdsImExportar.Active := true;

        zipArchivo.AddFile('Vendedores.xml');
        strStream := TStringStream.Create('');
        dmDatos.cdsImExportar.SaveToStream(strStream,dfxml);
        zipArchivo.Data[iIndice] := strStream.DataString;
        Inc(iIndice);

        dmDatos.cdsImExportar.Active := false;
        Close;
        StrStream.Free;
    end;
end;

procedure TfrmExportar.ExportaCtsXCobrar;
var
    sFechaIni, sFechaFin : String;
begin
    lblTabla.Caption := 'Xcobrar';
    lblTabla.Refresh;

    sFechaIni := txtMesVentaIni.Text + '/' + txtDiaVentaIni.Text + '/' + txtAnioVentaIni.Text;
    sFechaFin := txtMesVentaFin.Text + '/' + txtDiaVentaFin.Text + '/' + txtAnioVentaFin.Text;

    with dmDatos.qryImExportar do begin
        dmDatos.cdsImExportar.Active := false;
        Close;
        SQL.Clear;
        SQL.Add('SELECT x.importe, x.plazo, x.interes, x.intmoratorio,');
        SQL.Add('x.proximopago,x.tipointeres,x.tipoplazo,x.plazo,x.estatus, x.orden,');
        SQL.Add('c.nombre as Cliente, x.fecha, x.numpago, x.cantintmorat,');
        SQL.Add('x.cantinteres,x.pagado, v.hora, v.caja FROM xcobrar x LEFT JOIN');
        SQL.Add('clientes c ON x.cliente = c.clave LEFT JOIN ventas v ON');
        SQL.Add('x.venta = v.clave ');
        SQL.Add('WHERE x.fecha >= ''' + sFechaIni + ''' AND x.fecha <= ''' + sFechaFin + '''');

        Open;

        dmDatos.cdsImExportar.Active := true;

        zipArchivo.AddFile('XCobrar.xml');
        strStream := TStringStream.Create('');
        dmDatos.cdsImExportar.SaveToStream(strStream,dfxml);
        zipArchivo.Data[iIndice] := strStream.DataString;
        Inc(iIndice);

        dmDatos.cdsImExportar.Active := false;
        Close;
        StrStream.Free;
    end;

    lblTabla.Caption := 'Xcobrar pagos';
    lblTabla.Refresh;

    with dmDatos.qryImExportar do begin

        SQL.Clear;
        SQL.Add('SELECT xc.orden, xc.fecha as FechaV, v.hora, v.caja, x.numero,x.fecha,x.importe,x.interes, x.interesmorat,');
        SQL.Add('t.nombre as tipopago, x.comentario FROM xcobrarpagos x LEFT JOIN tipopago t ON x.tipopago = t.clave');
        SQL.Add('LEFT JOIN xCobrar xc ON x.xcobrar = xc.clave LEFT JOIN ventas v ON xc.venta = v.clave');
        SQL.Add('WHERE xc.fecha >= ''' + sFechaIni + ''' AND xc.fecha <= ''' + sFechaFin + '''');
        Open;

        dmDatos.cdsImExportar.Active := true;
        zipArchivo.AddFile('XCobrarPagos.xml');
        strStream := TStringStream.Create('');
        dmDatos.cdsImExportar.SaveToStream(strStream,dfxml);
        zipArchivo.Data[iIndice] := strStream.DataString;
        Inc(iIndice);

        dmDatos.cdsImExportar.Active := false;
        Close;
        StrStream.Free;
    end;
end;

procedure TfrmExportar.ExportaInventario2;
var
    sFechaIni, sFechaFin : String;
begin
    lblTabla.Caption := 'Inventario';
    lblTabla.Refresh;

    sFechaIni := txtMesInvIni.Text + '/' + txtDiaInvIni.Text + '/' + txtAnioInvIni.Text;
    sFechaFin := txtMesInvFin.Text + '/' + txtDiaInvFin.Text + '/' + txtAnioInvFin.Text;

    with dmDatos.qryImExportar do begin
        dmDatos.cdsImExportar.Active := false;
        Close;
        SQL.Clear;
        SQL.Add('SELECT fecha, aplicado, descrip FROM inventario ');
        SQL.Add('WHERE fecha >= ''' + sFechaIni + ''' AND fecha <= ''' + sFechaFin + '''');

        Open;

        dmDatos.cdsImExportar.Active := true;

        zipArchivo.AddFile('Inventario.xml');
        strStream := TStringStream.Create('');
        dmDatos.cdsImExportar.SaveToStream(strStream,dfxml);
        zipArchivo.Data[iIndice] := strStream.DataString;
        Inc(iIndice);

        dmDatos.cdsImExportar.Active := false;
        Close;
        StrStream.Free;
    end;

    lblTabla.Caption := 'InventarioDet';
    lblTabla.Refresh;

    with dmDatos.qryImExportar do begin

        SQL.Clear;
        SQL.Add('SELECT o.codigo, i.cantidad, i.existencia, i.juego, i.cantjuego, ');
        SQL.add(' inv.Fecha, inv.Descrip FROM inventdet i');
        SQL.Add(' LEFT JOIN codigos o  ON o.articulo = i.articulo AND o.tipo = ''P''');
        SQL.Add(' LEFT JOIN inventario inv ON i.inventario = inv.clave');
        SQL.Add(' WHERE inv.fecha >= ''' + sFechaIni + ''' AND inv.fecha <= ''' + sFechaFin + '''');
        Open;

        dmDatos.cdsImExportar.Active := true;
        zipArchivo.AddFile('InventDet.xml');
        strStream := TStringStream.Create('');
        dmDatos.cdsImExportar.SaveToStream(strStream,dfxml);
        zipArchivo.Data[iIndice] := strStream.DataString;
        Inc(iIndice);

        dmDatos.cdsImExportar.Active := false;
        Close;
        StrStream.Free;
    end;
end;




procedure TfrmExportar.chkInventarioClick(Sender: TObject);
begin
    if(chkInventario.Checked) then begin
        txtDiaInvIni.Visible := true;
        txtMesInvIni.Visible := true;
        txtAnioInvIni.Visible := true;
        txtDiaInvFin.Visible := true;
        txtMesInvFin.Visible := true;
        txtAnioInvFin.Visible := true;
        txtDiaInvIni.SetFocus;
    end
    else begin
        txtDiaInvIni.Visible := false;
        txtMesInvIni.Visible := false;
        txtAnioInvIni.Visible := false;
        txtDiaInvFin.Visible := false;
        txtMesInvFin.Visible := false;
        txtAnioInvFin.Visible := false;
    end;
end;

procedure TfrmExportar.txtAnioInvIniExit(Sender: TObject);
begin
    txtAnioInvIni.Text := Trim(txtAnioInvIni.Text);
    if(Length(txtAnioInvIni.Text) < 4) and (Length(txtAnioInvIni.Text) > 0) then
        txtAnioInvIni.Text := IntToStr(StrToInt(txtAnioInvIni.Text) + 2000);
end;

procedure TfrmExportar.txtAnioInvFinExit(Sender: TObject);
begin
    txtAnioInvFin.Text := Trim(txtAnioInvFin.Text);
    if(Length(txtAnioInvFin.Text) < 4) and (Length(txtAnioInvFin.Text) > 0) then
        txtAnioInvFin.Text := IntToStr(StrToInt(txtAnioInvfin.Text) + 2000);

end;

end.
