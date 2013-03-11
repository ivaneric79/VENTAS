// --------------------------------------------------------------------------
// Archivo del Proyecto Ventas  
// Página del proyecto: http://sourceforge.net/projects/ventas
// --------------------------------------------------------------------------
// Este archivo puede ser distribuido y/o modificado bajo lo terminos de la
// Licencia Pública General versión 2 como es publicada por la Free Software
// Fundation, Inc.
// --------------------------------------------------------------------------

unit Importar;

interface

uses
  SysUtils, Types, Classes, QGraphics, QControls, QForms, QDialogs,
  QStdCtrls, QButtons, QComCtrls, IniFiles, SciZipFile;

type
  TfrmImportar = class(TForm)
    grpDatos: TGroupBox;
    chkArticulos: TCheckBox;
    chkClientes: TCheckBox;
    chkProveedores: TCheckBox;
    chkDepartamentos: TCheckBox;
    chkCategorias: TCheckBox;
    chkAreasVenta: TCheckBox;
    chkTiposPago: TCheckBox;
    btnImportar: TBitBtn;
    btnCancelar: TBitBtn;
    grpRuta: TGroupBox;
    txtRuta: TEdit;
    Label1: TLabel;
    btnDir: TBitBtn;
    grpAvance: TGroupBox;
    barAvance: TProgressBar;
    lblTabla: TLabel;
    chkVentas: TCheckBox;
    chkUsuarios: TCheckBox;
    chkTicket: TCheckBox;
    chkEmpresa: TCheckBox;
    chkDescuentos: TCheckBox;
    grpTipo: TGroupBox;
    rdbSincronizar: TRadioButton;
    rdbReemplazar: TRadioButton;
    chkCajas: TCheckBox;
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
    dlgAbrir: TOpenDialog;
    chkVendedores: TCheckBox;
    chkInventario: TCheckBox;
    chkCompras: TCheckBox;
    txtDiaCompraIni: TEdit;
    txtMesCompraIni: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    txtAnioCompraIni: TEdit;
    Label4: TLabel;
    txtDiaCompraFin: TEdit;
    Label5: TLabel;
    txtMesCompraFin: TEdit;
    Label6: TLabel;
    txtAnioCompraFin: TEdit;
    chkUnidades: TCheckBox;
    procedure btnImportarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure chkArticulosClick(Sender: TObject);
    procedure btnDirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure chkVentasClick(Sender: TObject);
    procedure Salta(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure txtRutaExit(Sender: TObject);
    procedure txtAnioVentaIniExit(Sender: TObject);
    procedure txtDiaVentaIniExit(Sender: TObject);
    procedure chkComprasClick(Sender: TObject);
  private
    dteFecha, dteFechaIni, dteFechaFin : TDateTime;
    zipArchivo : TZipFile;
    StrStream : TStringStream;

    function VerificaDatos:boolean;
    procedure ImportaAreasVenta;
    procedure RecuperaConfig;
    procedure ImportaArticulos;
    procedure ImportaProveedores;
    procedure ImportaCategorias;
    procedure ImportaDepartamentos;
    procedure ImportaInventario;
    procedure ImportaJuegos;
    procedure ImportaClientes;
    procedure ImportaTiposPago;
    procedure ImportaUsuarios;
    procedure ImportaTicket;
    procedure ImportaEmpresa;
    procedure ImportaDescuentos;
    procedure ImportaVentas;
    procedure ImportaDetalleVenta;
    procedure ImportaPagoVenta;
    procedure ImportaComprobantes;
    procedure ImportaCajas;
    procedure ImportaVendedores;
    procedure ImportaCtsXCobrar;
    function  VerificaFechas(sFecha : string):boolean;
    procedure ImportaCodigos;
    procedure Rellena(Sender: TObject);
    procedure ImportaNotasCredito;
    procedure ImportaInventario2;
    procedure ImportaCompras;
    procedure ImportaUnidades;
  public

  end;

var
  frmImportar: TfrmImportar;

implementation

uses dm;

{$R *.xfm}

procedure TfrmImportar.btnImportarClick(Sender: TObject);
begin
    if(VerificaDatos) then begin
        if(chkAreasVenta.Checked) then
            ImportaAreasVenta;
        if(chkArticulos.Checked) then
            ImportaArticulos;
        if(chkCategorias.Checked) and (not chkArticulos.Checked) then
            ImportaCategorias;
        if(chkDepartamentos.Checked) and (not chkArticulos.Checked) then
            ImportaDepartamentos;
        if(chkProveedores.Checked) and (not chkArticulos.Checked) then
            ImportaProveedores;
        if(chkUnidades.Checked) and (not chkArticulos.Checked) then
            ImportaUnidades;
        if(chkVendedores.Checked) then
            ImportaVendedores;
        if(chkCajas.Checked) then
            ImportaCajas;
        if(chkClientes.Checked) then
            ImportaClientes;
        if(chkTiposPago.Checked) then
            ImportaTiposPago;
        if(chkUsuarios.Checked) then
            ImportaUsuarios;
        if(chkTicket.Checked) then
            ImportaTicket;
        if(chkEmpresa.Checked) then
            ImportaEmpresa;
        if(chkDescuentos.Checked) then
            ImportaDescuentos;
        if(chkInventario.Checked) then
            ImportaInventario2;
        if(chkCompras.Checked) then begin
            ImportaCompras;
        end;
        if(chkVentas.Checked) then begin
//            ImportaVendedores;
            ImportaVentas;
            ImportaComprobantes;
            ImportaNotasCredito;
            ImportaDetalleVenta;
            ImportaPagoVenta;
            ImportaCtsXCobrar;
        end;
        Application.MessageBox('Proceso terminado','Importar',[smbOk]);
    end
end;

function TfrmImportar.VerificaDatos:boolean;
begin
    btnImportar.SetFocus;
    Result := true;
    if(not FileExists(txtRuta.Text)) then begin
        Application.MessageBox('El archivo no existe','Error',[smbOk]);
        txtRuta.SetFocus;
        Result := false;
    end
    else if(chkVentas.Checked) then begin
        if (not VerificaFechas(txtDiaVentaIni.Text + '/' + txtMesVentaIni.Text + '/' + txtAnioVentaIni.Text)) then begin
            Application.MessageBox('Introduce un fecha inicial válida para las ventas','Error',[smbOK],smsCritical);
            txtDiaVentaIni.SetFocus;
            Result := false;
        end
        else if (not VerificaFechas(txtDiaVentaFin.Text + '/' + txtMesVentaFin.Text + '/' + txtAnioVentaFin.Text)) then begin
            Application.MessageBox('Introduce un fecha final válida para las ventas','Error',[smbOK],smsCritical);
            txtDiaVentaFin.SetFocus;
            Result := false;
        end
        else begin
            dteFechaIni := StrToDate(txtDiaVentaIni.Text + '/' + txtMesVentaIni.Text + '/' + txtAnioVentaIni.Text);
            dteFechaFin := StrToDate(txtDiaVentaFin.Text + '/' + txtMesVentaFin.Text + '/' + txtAnioVentaFin.Text);
            if(dteFechaIni > dteFechaFin) then begin
                Application.MessageBox('La fecha final debe ser mayor o igual que la fecha inicial','Error',[smbOK],smsCritical);
                txtDiaVentaIni.SetFocus;
                Result := false;
            end;
        end;
    end
    else if(chkCompras.Checked) then begin
        if (not VerificaFechas(txtDiaCompraIni.Text + '/' + txtMesCompraIni.Text + '/' + txtAnioCompraIni.Text)) then begin
            Application.MessageBox('Introduce un fecha inicial válida para las compras','Error',[smbOK],smsCritical);
            txtDiaCompraIni.SetFocus;
            Result := false;
        end
        else if (not VerificaFechas(txtDiaCompraFin.Text + '/' + txtMesCompraFin.Text + '/' + txtAnioCompraFin.Text)) then begin
            Application.MessageBox('Introduce un fecha final válida para las compras','Error',[smbOK],smsCritical);
            txtDiaCompraFin.SetFocus;
            Result := false;
        end
        else begin
            dteFechaIni := StrToDate(txtDiaCompraIni.Text + '/' + txtMesCompraIni.Text + '/' + txtAnioCompraIni.Text);
            dteFechaFin := StrToDate(txtDiaCompraFin.Text + '/' + txtMesCompraFin.Text + '/' + txtAnioCompraFin.Text);
            if(dteFechaIni > dteFechaFin) then begin
                Application.MessageBox('La fecha final debe ser mayor o igual que la fecha inicial','Error',[smbOK],smsCritical);
                txtDiaCompraIni.SetFocus;
                Result := false;
            end;
        end;
    end;
end;

procedure TfrmImportar.ImportaAreasVenta;
var
    sClave, sNombre, sCaja, sFechaUMov : String;
    dteFechaMov : TDateTime;
    i : integer;
begin
    lblTabla.Caption := 'Áreas de venta';
    lblTabla.Refresh;
    for i := 0 to zipArchivo.Count do
        if (zipArchivo.Name[i] = 'areasventa.xml') then
            break;
    dmDatos.cdsImExportar.Active := false;
    StrStream := TStringStream.Create(zipArchivo.Data[i]);
    dmDatos.cdsImExportar.LoadFromStream(strStream);
    dmDatos.cdsImExportar.Active := true;
    barAvance.Max := dmDatos.cdsImExportar.RecordCount;
    barAvance.Position := 0;

    sFechaUMov := FormatDateTime('mm/dd/yyyy hh:nn:ss',Now);
    while(not (dmDatos.cdsImExportar.Eof)) do begin
        sNombre := Trim(dmDatos.cdsImExportar.FieldByName('nombre').AsString);
        sCaja := dmDatos.cdsImExportar.FieldByName('caja').AsString;
        dteFechaMov := dmDatos.cdsImExportar.FieldByName('fecha_umov').AsDateTime;
        if(Length(sCaja) = 0) then
            sCaja := 'null';

        with dmDatos.qryModifica do begin
            Close;
            SQL.Clear;
            SQL.Add('SELECT clave, fecha_umov FROM areasventa WHERE nombre = ''' + sNombre + '''');
            Open;
            if(Eof) then begin
                Close;
                SQL.Clear;
                SQL.Add('INSERT INTO areasventa (nombre, caja, fecha_umov) VALUES(');
                SQL.Add('''' + sNombre + ''',' + sCaja + ',''' + sFechaUMov + ''')');
                ExecSQL;
                Close;
            end
            else begin
                // Modifica el registro
                sClave := FieldByName('clave').AsString;
                if(dteFechaMov > FieldByName('fecha_umov').AsDateTime) or (rdbReemplazar.Checked) then begin
                    Close;
                    SQL.Clear;
                    SQL.Add('UPDATE areasventa SET nombre = ''' + sNombre + ''',');
                    SQL.Add('caja = ' + sCaja + ',');
                    SQL.Add('fecha_umov = ''' + sFechaUMov + '''');
                    SQL.Add('WHERE clave = ' + sClave);
                    ExecSQL;
                    Close;
                end
                else begin
                    Close;
                    SQL.Clear;
                    SQL.Add('UPDATE areasventa SET fecha_umov = ''' + sFechaUMov + '''');
                    SQL.Add('WHERE clave = ' + sClave);
                    ExecSQL;
                    Close;
                end;
            end;
            dmDatos.cdsImExportar.Next;
            barAvance.StepIt;
        end;
    end;
    dmDatos.cdsImExportar.Active := false;
    StrStream.Free;

    if(rdbReemplazar.Checked) then
        //Elimina todo lo que no estaba en la importación
        with dmDatos.qryModifica do begin
            Close;
            SQL.Clear;
            SQL.Add('DELETE FROM areasventa WHERE fecha_umov <> ''' + sFechaUMov + '''');
            ExecSQL;
            Close;
        end;
end;

procedure TfrmImportar.ImportaArticulos;
begin
    ImportaCategorias;
    ImportaProveedores;
    ImportaDepartamentos;
    ImportaInventario;
    ImportaCodigos;
    ImportaJuegos;
    ImportaUnidades;
end;

procedure TfrmImportar.ImportaCategorias;
var
    sClave, sNombre, sTipo, sCuenta, sFechaUMov : String;
    i : integer;
begin
    lblTabla.Caption := 'Categorías';
    lblTabla.Refresh;
    for i := 0 to zipArchivo.Count do
        if (zipArchivo.Name[i] = 'categorias.xml') then
            break;
    dmDatos.cdsImExportar.Active := false;
    StrStream := TStringStream.Create(zipArchivo.Data[i]);
    dmDatos.cdsImExportar.LoadFromStream(strStream);
    dmDatos.cdsImExportar.Active := true;
    barAvance.Max := dmDatos.cdsImExportar.RecordCount;
    barAvance.Position := 0;

    sFechaUMov := FormatDateTime('mm/dd/yyyy hh:nn:ss',Now);
    while(not (dmDatos.cdsImExportar.Eof)) do begin
        sNombre := Trim(dmDatos.cdsImExportar.FieldByName('nombre').AsString);
        sTipo := Trim(dmDatos.cdsImExportar.FieldByName('tipo').AsString);
        sCuenta := Trim(dmDatos.cdsImExportar.FieldByName('cuenta').AsString);

        with dmDatos.qryModifica do begin
            Close;
            SQL.Clear;
            SQL.Add('SELECT clave, fecha_umov FROM categorias WHERE nombre = ');
            SQL.Add('''' + sNombre + ''' AND tipo = ''' + sTipo + '''');
            Open;
            if(Eof) then begin
                Close;
                SQL.Clear;
                SQL.Add('INSERT INTO categorias (nombre, tipo, cuenta, fecha_umov) VALUES(');
                SQL.Add('''' + sNombre + ''',''' + sTipo + ''',''' + sCuenta + ''',''' + sFechaUMov + ''')');
                ExecSQL;
                Close;
            end
            else begin
                // Modifica el registro
                sClave := FieldByName('clave').AsString;

                Close;
                SQL.Clear;
                SQL.Add('UPDATE categorias SET fecha_umov = ''' + sFechaUMov + '''');
                SQL.Add('WHERE clave = ' + sClave);
                ExecSQL;
                Close;
            end;
            dmDatos.cdsImExportar.Next;
            barAvance.StepIt;
        end;
    end;
    dmDatos.cdsImExportar.Active := false;
    StrStream.Free;

    if(rdbReemplazar.Checked) then
        //Elimina todo lo que no estaba en la importación
        with dmDatos.qryModifica do begin
            Close;
            SQL.Clear;
            SQL.Add('DELETE FROM categorias WHERE fecha_umov <> ''' + sFechaUMov + '''');
            ExecSQL;
            Close;
        end;
end;

procedure TfrmImportar.ImportaUnidades;
var
    sClave, sNombre, sFechaUMov : String;
    i, iTipo : integer;
begin
    lblTabla.Caption := 'Unidades';
    lblTabla.Refresh;
    for i := 0 to zipArchivo.Count do
        if (zipArchivo.Name[i] = 'unidades.xml') then
            break;
    dmDatos.cdsImExportar.Active := false;
    StrStream := TStringStream.Create(zipArchivo.Data[i]);
    dmDatos.cdsImExportar.LoadFromStream(strStream);
    dmDatos.cdsImExportar.Active := true;
    barAvance.Max := dmDatos.cdsImExportar.RecordCount;
    barAvance.Position := 0;

    sFechaUMov := FormatDateTime('mm/dd/yyyy hh:nn:ss',Now);
    while(not (dmDatos.cdsImExportar.Eof)) do begin
        sNombre := Trim(dmDatos.cdsImExportar.FieldByName('nombre').AsString);
        iTipo := dmDatos.cdsImExportar.FieldByName('tipo').AsInteger;

        with dmDatos.qryModifica do begin
            Close;
            SQL.Clear;
            SQL.Add('SELECT clave, fecha_umov FROM unidades WHERE nombre = ');
            SQL.Add('''' + sNombre + ''' AND tipo = ' + IntToStr(iTipo));
            Open;
            if(Eof) then begin
                // obtener la nueva clave para el unidade (mas correcto el uso del generators de esa manera)
                Close;
                SQL.Clear;
                SQL.Add('SELECT CAST(GEN_ID(unidades,1) AS integer) AS Clave');
                SQL.Add('from RDB$DATABASE');
                Open;
                sClave := FieldByName('clave').AsString;

                Close;
                SQL.Clear;
                SQL.Add('INSERT INTO unidades (nombre, clave, tipo, fecha_umov) VALUES(');
                SQL.Add('''' + sNombre + ''',' + sClave + ',' + IntToStr(iTipo) + ',''' + sFechaUMov + ''')');
                ExecSQL;
                Close;
            end
            else begin
                // Modifica el registro
                sClave := FieldByName('clave').AsString;
                Close;
                SQL.Clear;
                SQL.Add('UPDATE unidades SET fecha_umov = ''' + sFechaUMov + '''');
                SQL.Add('WHERE clave = ' + sClave);
                ExecSQL;
                Close;
            end;
            dmDatos.cdsImExportar.Next;
            barAvance.StepIt;
        end;
    end;
    dmDatos.cdsImExportar.Active := false;
    StrStream.Free;

    if(rdbReemplazar.Checked) then
        //Elimina todo lo que no estaba en la importación
        with dmDatos.qryModifica do begin
            Close;
            SQL.Clear;
            SQL.Add('DELETE FROM unidades WHERE fecha_umov <> ''' + sFechaUMov + '''');
            ExecSQL;
            Close;
        end;
end;

procedure TfrmImportar.ImportaProveedores;
var
    sClave, sRfc, sNombre, sCalle, sColonia, sCp, sLocalidad, sCateg, sNombreFiscal : String;
    sEstado, sEncargado, sFax, sCorreo, sFechaCap, sTelefono, sFechaUMov : String;
    dteFechaMov : TDateTime;
    i : integer;
begin
    lblTabla.Caption := 'Proveedores';
    lblTabla.Refresh;
    for i := 0 to zipArchivo.Count do
        if (zipArchivo.Name[i] = 'proveedores.xml') then
            break;

    dmDatos.cdsImExportar.Active := false;
    StrStream := TStringStream.Create(zipArchivo.Data[i]);
    dmDatos.cdsImExportar.LoadFromStream(strStream);
    dmDatos.cdsImExportar.Active := true;
    barAvance.Max := dmDatos.cdsImExportar.RecordCount;
    barAvance.Position := 0;
    sFechaUMov := FormatDateTime('mm/dd/yyyy hh:nn:ss',Now);

    while(not (dmDatos.cdsImExportar.Eof)) do begin
        sClave := dmDatos.cdsImExportar.FieldByName('clave').AsString;
        sRfc := Trim(dmDatos.cdsImExportar.FieldByName('rfc').AsString);
        sNombre := Trim(dmDatos.cdsImExportar.FieldByName('nombre').AsString);
        sNombreFiscal := Trim(dmDatos.cdsImExportar.FieldByName('nombrefiscal').AsString);
        sCalle := Trim(dmDatos.cdsImExportar.FieldByName('calle').AsString);
        sColonia := Trim(dmDatos.cdsImExportar.FieldByName('colonia').AsString);
        sCp := Trim(dmDatos.cdsImExportar.FieldByName('cp').AsString);
        sLocalidad := Trim(dmDatos.cdsImExportar.FieldByName('localidad').AsString);
        sEstado := Trim(dmDatos.cdsImExportar.FieldByName('estado').AsString);
        sEncargado := Trim(dmDatos.cdsImExportar.FieldByName('encargado').AsString);
        sFax := Trim(dmDatos.cdsImExportar.FieldByName('fax').AsString);
        sCorreo := Trim(dmDatos.cdsImExportar.FieldByName('ecorreo').AsString);
        sFechaCap := FormatDateTime('mm/dd/yyyy',dmDatos.cdsImExportar.FieldByName('fecha_cap').AsDateTime);
        sTelefono := Trim(dmDatos.cdsImExportar.FieldByName('telefono').AsString);
        sCateg := Trim(dmDatos.cdsImExportar.FieldByName('categoria').AsString);
        dteFechaMov := dmDatos.cdsImExportar.FieldByName('fecha_umov').AsDateTime;

        with dmDatos.qryModifica do begin
            Close;
            SQL.Clear;
            SQL.Add('SELECT clave FROM categorias WHERE nombre = ''' + sCateg + ''' AND tipo = ''P''');
            Open;
            sCateg := FieldByName('clave').AsString;
            if(Length(sCateg) = 0) then
                sCateg := 'null';

            Close;
            SQL.Clear;
            SQL.Add('SELECT clave, fecha_umov FROM proveedores WHERE clave = ' + sClave);
            Open;
            if(Eof) then begin
                Close;
                SQL.Clear;
                SQL.Add('INSERT INTO proveedores (clave, rfc, nombre, nombrefiscal, calle, colonia, cp,');
                SQL.Add('localidad, estado, encargado, fax, ecorreo, fecha_cap,');
                SQL.Add('telefono, fecha_umov, categoria) VALUES(');
                SQL.Add(sClave + ',''' + sRfc + ''',''' + sNombre + ''',''' + sNombreFiscal + ''',''' + sCalle + ''',');
                SQL.Add('''' + sColonia + ''',''' + sCp + ''',''' + sLocalidad + ''',''' + sEstado + ''',');
                SQL.Add('''' + sEncargado + ''',''' + sFax + ''',''' + sCorreo + ''',');
                SQL.Add('''' + sFechaCap + ''',''' + sTelefono + ''',''' + sFechaUMov + ''',' + sCateg + ')');
                ExecSQL;
                Close;
            end
            else begin
                // Modifica el registro
                sClave := FieldByName('clave').AsString;
                if(dteFechaMov > FieldByName('fecha_umov').AsDateTime) or (rdbReemplazar.Checked) then begin
                    Close;
                    SQL.Clear;
                    SQL.Add('UPDATE proveedores SET rfc = ''' + sRfc + ''',');
                    SQL.Add('nombre = ''' + sNombre + ''',');
                    SQL.Add('nombrefiscal = ''' + sNombreFiscal + ''',');
                    SQL.Add('calle = ''' + sCalle + ''',');
                    SQL.Add('colonia = ''' + sColonia + ''',');
                    SQL.Add('cp = ''' + sCp + ''',');
                    SQL.Add('localidad = ''' + sLocalidad + ''',');
                    SQL.Add('estado = ''' + sEstado + ''',');
                    SQL.Add('encargado = ''' + sEncargado + ''',');
                    SQL.Add('fax = ''' + sFax + ''',');
                    SQL.Add('ecorreo = ''' + sCorreo + ''',');
                    SQL.Add('fecha_cap = ''' + sFechaCap + ''',');
                    SQL.Add('telefono = ''' + sTelefono + ''',');
                    SQL.Add('fecha_umov = ''' + sFechaUmov + ''',');
                    SQL.Add('categoria = ' + sCateg);
                    SQL.Add('WHERE clave = ' + sClave);
                    ExecSQL;
                    Close;
                end
                else begin
                    Close;
                    SQL.Clear;
                    SQL.Add('UPDATE proveedores SET fecha_umov = ''' + sFechaUMov + '''');
                    SQL.Add('WHERE clave = ' + sClave);
                    ExecSQL;
                    Close;
                end;
            end;
            dmDatos.cdsImExportar.Next;
            barAvance.StepIt;
        end;
    end;
    dmDatos.cdsImExportar.Active := false;
    StrStream.Free;

    if(rdbReemplazar.Checked) then
        //Elimina todo lo que no estaba en la importación
        with dmDatos.qryModifica do begin
            Close;
            SQL.Clear;
            SQL.Add('DELETE FROM proveedores WHERE fecha_umov <> ''' + sFechaUMov + '''');
            ExecSQL;
            Close;
        end;
end;

procedure TfrmImportar.ImportaDepartamentos;
var
    sClave, sNombre, sFechaUMov : String;
    i : integer;
begin
    lblTabla.Caption := 'Departamentos';
    lblTabla.Refresh;
    for i := 0 to zipArchivo.Count do
        if (zipArchivo.Name[i] = 'departamentos.xml') then
            break;

    dmDatos.cdsImExportar.Active := false;
    StrStream := TStringStream.Create(zipArchivo.Data[i]);
    dmDatos.cdsImExportar.LoadFromStream(strStream);
    dmDatos.cdsImExportar.Active := true;
    barAvance.Max := dmDatos.cdsImExportar.RecordCount;
    barAvance.Position := 0;

    sFechaUMov := FormatDateTime('mm/dd/yyyy hh:nn:ss',Now);
    while(not (dmDatos.cdsImExportar.Eof)) do begin
        sNombre := Trim(dmDatos.cdsImExportar.FieldByName('nombre').AsString);

        with dmDatos.qryModifica do begin
            Close;
            SQL.Clear;
            SQL.Add('SELECT clave FROM departamentos WHERE nombre = ''' + sNombre + '''');
            Open;
            if(Eof) then begin
                Close;
                SQL.Clear;
                SQL.Add('INSERT INTO departamentos (nombre, fecha_umov) VALUES(''' + sNombre + ''',''' + sFechaUMov + ''')');
                ExecSQL;
                Close;
            end
            else begin
                // Modifica el registro
                sClave := FieldByName('clave').AsString;

                Close;
                SQL.Clear;
                SQL.Add('UPDATE departamentos SET fecha_umov = ''' + sFechaUMov + '''');
                SQL.Add('WHERE clave = ' + sClave);
                ExecSQL;
                Close;
            end;
            dmDatos.cdsImExportar.Next;
            barAvance.StepIt;
        end;
    end;
    dmDatos.cdsImExportar.Active := false;
    StrStream.Free;

    if(rdbReemplazar.Checked) then
        //Elimina todo lo que no estaba en la importación
        with dmDatos.qryModifica do begin
            Close;
            SQL.Clear;
            SQL.Add('DELETE FROM departamentos WHERE fecha_umov <> ''' + sFechaUMov + '''');
            ExecSQL;
            Close;
        end;
end;

procedure TfrmImportar.ImportaInventario;
var
    sClave, sCodigo, sDesCorta, sDesLarga, sPrecio1, sPrecio2, sPrecio3, sPrecio4 : String;
    sUltCosto, sDescAuto, sExistencia, sMinimo, sMaximo, sFechaUMov, sCostoProm : String;
    sTipo, sCateg, sDepto, sProv1, sProv2, sIva, sFechaCap, sEstatus, sfiscal : String;
    dteFechaMov : TDateTime;
    i : integer;
begin
    lblTabla.Caption := 'Artículos';
    lblTabla.Refresh;
    for i := 0 to zipArchivo.Count do
        if (zipArchivo.Name[i] = 'articulos.xml') then
            break;

    dmDatos.cdsImExportar.Active := false;
    StrStream := TStringStream.Create(zipArchivo.Data[i]);
    dmDatos.cdsImExportar.LoadFromStream(strStream);
    dmDatos.cdsImExportar.Active := true;
    barAvance.Max := dmDatos.cdsImExportar.RecordCount;
    barAvance.Position := 0;

    sFechaUMov := FormatDateTime('mm/dd/yyyy hh:nn:ss',Now);
    while(not (dmDatos.cdsImExportar.Eof)) do begin
        sCodigo := Trim(dmDatos.cdsImExportar.FieldByName('codigo').AsString);
        sDesCorta := Trim(dmDatos.cdsImExportar.FieldByName('desc_corta').AsString);
        sDesLarga := Trim(dmDatos.cdsImExportar.FieldByName('desc_larga').AsString);
        sPrecio1 := dmDatos.cdsImExportar.FieldByName('precio1').AsString;
        sPrecio2 := dmDatos.cdsImExportar.FieldByName('precio2').AsString;
        sPrecio3 := dmDatos.cdsImExportar.FieldByName('precio3').AsString;
        sPrecio4 := dmDatos.cdsImExportar.FieldByName('precio4').AsString;
        sUltCosto := dmDatos.cdsImExportar.FieldByName('ult_costo').AsString;
        sCostoProm := dmDatos.cdsImExportar.FieldByName('costoprom').AsString;
        sDescAuto := Trim(dmDatos.cdsImExportar.FieldByName('desc_auto').AsString);
        sExistencia := dmDatos.cdsImExportar.FieldByName('existencia').AsString;
        sMinimo := dmDatos.cdsImExportar.FieldByName('minimo').AsString;
        sMaximo := dmDatos.cdsImExportar.FieldByName('maximo').AsString;
        sTipo := dmDatos.cdsImExportar.FieldByName('tipo').AsString;
        sIva := dmDatos.cdsImExportar.FieldByName('iva').AsString;
        sFechaCap := FormatDateTime('mm/dd/yyyy',dmDatos.cdsImExportar.FieldByName('fecha_cap').AsDateTime);
        sEstatus := dmDatos.cdsImExportar.FieldByName('estatus').AsString;

        sCateg := dmDatos.cdsImExportar.FieldByName('categoria').AsString;
        sDepto := dmDatos.cdsImExportar.FieldByName('departamento').AsString;
        sProv1 := dmDatos.cdsImExportar.FieldByName('proveedor1').AsString;
        sProv2 := dmDatos.cdsImExportar.FieldByName('proveedor2').AsString;
        dteFechaMov := dmDatos.cdsImExportar.FieldByName('fecha_umov').AsDateTime;
        sfiscal:= dmDatos.cdsImExportar.FieldByName('fiscal').AsString;

        with dmDatos.qryModifica do begin
            Close;
            SQL.Clear;
            SQL.Add('SELECT clave FROM categorias WHERE nombre = ''' + sCateg + '''');
            Open;
            sCateg := FieldByName('clave').AsString;
            if(Length(sCateg) = 0) then
                sCateg := 'null';
            if(Length(sExistencia) = 0) then
                sExistencia := '0';
            if(Length(sMinimo) = 0) then
                sMinimo := '0';
            if(Length(sMaximo) = 0) then
                sMaximo := '0';
            if(Length(sfiscal) = 0) then
                sfiscal := '0';
            Close;
            SQL.Clear;
            SQL.Add('SELECT clave FROM departamentos WHERE nombre = ''' + sDepto + '''');
            Open;
            sDepto := FieldByName('clave').AsString;
            if(Length(sDepto) = 0) then
                sDepto := 'null';

            if(Length(sProv1) = 0) then
                sProv1 := 'null';

            if(Length(sProv2) = 0) then
                sProv2 := 'null';

            Close;
            SQL.Clear;
            SQL.Add('SELECT a.clave, a.fecha_umov FROM articulos a WHERE a.desc_larga = ''' + sDesLarga + '''');
            Open;
            if(Eof) then begin
                Close;
                SQL.Clear;
                SQL.Add('SELECT a.clave, a.fecha_umov FROM codigos o JOIN articulos a ON o.articulo = a.clave AND o.tipo = ''P'' WHERE o.codigo = ''' + sCodigo + '''');
                Open;
            end;

            if(Eof) then begin
                Close;
                SQL.Clear;
                SQL.Add('INSERT INTO articulos (desc_corta, desc_larga,');
                SQL.Add('precio1, precio2, precio3, precio4, ult_costo, costoprom,');
                SQL.Add('desc_auto, existencia, minimo, maximo, categoria, departamento,');
                SQL.Add('tipo, proveedor1, proveedor2, iva, fecha_cap, fecha_umov,');
                SQL.Add('estatus, fiscal) VALUES(');
                SQL.Add('''' + sDesCorta + ''',''' + sDesLarga + ''',');
                SQL.Add(sPrecio1 + ',' + sPrecio2 + ',' + sPrecio3 + ',' + sPrecio4 + ',');
                SQL.Add(sUltCosto + ',' + sCostoProm + ',''' + sDescAuto + ''',');
                SQL.Add(sExistencia + ',' + sMinimo + ',' + sMaximo + ',' + sCateg + ',');
                SQL.Add(sDepto + ',''' + sTipo + ''',' + sProv1 + ',' + sProv2 + ',');
                SQL.Add(sIva + ',''' + sFechaCap + ''',''' + sFechaUMov + ''',');
                SQL.Add('''' + sEstatus + ''','+sfiscal+' )');
                ExecSQL;

                Close;
                SQL.Clear;
                SQL.Add('SELECT clave FROM articulos WHERE desc_larga = ''' + sDesLarga + '''');
                Open;
                sClave := FieldByName('clave').AsString;

                Close;
            end
            else begin
                // Modifica el registro
                sClave := FieldByName('clave').AsString;

                if(dteFechaMov > FieldByName('fecha_umov').AsDateTime) or (rdbReemplazar.Checked) then begin
                    Close;
                    SQL.Clear;
                    SQL.Add('UPDATE articulos SET');
                    SQL.Add('desc_corta = ''' + sDesCorta + ''',');
                    SQL.Add('desc_larga = ''' + sDesLarga + ''',');
                    SQL.Add('precio1 = ' + sPrecio1 + ',');
                    SQL.Add('precio2 = ' + sPrecio2 + ',');
                    SQL.Add('precio3 = ' + sPrecio3 + ',');
                    SQL.Add('precio4 = ' + sPrecio4 + ',');
                    SQL.Add('ult_costo = ' + sUltCosto + ',');
                    SQL.Add('costoprom = ' + sCostoProm + ',');
                    SQL.Add('desc_auto = ''' + sDescAuto + ''',');
                    SQL.Add('minimo = ' + sMinimo + ',');
                    SQL.Add('maximo = ' + sMaximo + ',');
                    SQL.Add('categoria = ' + sCateg + ',');
                    SQL.Add('departamento = ' + sDepto + ',');
                    SQL.Add('tipo = ''' + sTipo + ''',');
                    SQL.Add('proveedor1 = ' + sProv1 + ',');
                    SQL.Add('proveedor2 = ' + sProv2 + ',');
                    SQL.Add('iva = ' + sIva + ',');
                    SQL.Add('fecha_UMov = ''' + sFechaUMov + ''',');
                    SQL.Add('fecha_cap = ''' + sFechaCap + ''',');
                    SQL.Add('estatus = ''' + sEstatus + '''');
                    SQL.Add('WHERE clave = ' + sClave);
                    ExecSQL;
                    Close;
                end
                else begin
                    Close;
                    SQL.Clear;
                    SQL.Add('UPDATE articulos SET fecha_umov = ''' + sFechaUMov + '''');
                    SQL.Add('WHERE clave = ' + sClave);
                    ExecSQL;
                    Close;
                end;
            end;

            Close;
            SQL.Clear;
            SQL.Add('DELETE FROM codigos WHERE articulo = ' + sClave + ' OR codigo = ''' + sCodigo + '''');
            ExecSQL;

            Close;
            SQL.Clear;
            SQL.Add('INSERT INTO codigos (articulo, codigo, tipo) VALUES(');
            SQL.Add(sClave + ',''' + sCodigo + ''',''P'')');
            ExecSQL;
            Close;

            dmDatos.cdsImExportar.Next;
            barAvance.StepIt;
        end;
    end;
    dmDatos.cdsImExportar.Active := false;
    StrStream.Free;

    if(rdbReemplazar.Checked) then
        //Elimina todo lo que no estaba en la importación
        with dmDatos.qryModifica do begin
            Close;
            SQL.Clear;
            SQL.Add('DELETE FROM articulos WHERE fecha_umov <> ''' + sFechaUMov + '''');
            ExecSQL;
            Close;
        end;
end;

procedure TfrmImportar.ImportaJuegos;
var
    sJuego, sArticulo, sCantidad, sPrecio, sFechaUMov : String;
    i : integer;
begin
    lblTabla.Caption := 'Juegos';
    lblTabla.Refresh;
    for i := 0 to zipArchivo.Count do
        if (zipArchivo.Name[i] = 'juegos.xml') then
            break;

    dmDatos.cdsImExportar.Active := false;
    StrStream := TStringStream.Create(zipArchivo.Data[i]);
    dmDatos.cdsImExportar.LoadFromStream(strStream);
    dmDatos.cdsImExportar.Active := true;
    barAvance.Max := dmDatos.cdsImExportar.RecordCount;
    barAvance.Position := 0;

    sFechaUMov := FormatDateTime('mm/dd/yyyy hh:nn:ss',Now);

    with dmDatos.qryModifica do begin
        Close;
        SQL.Clear;
        SQL.Add('DELETE FROM juegos');
        ExecSQL;
        Close;
    end;

    while(not (dmDatos.cdsImExportar.Eof)) do begin
        sJuego := Trim(dmDatos.cdsImExportar.FieldByName('juego').AsString);
        sArticulo := Trim(dmDatos.cdsImExportar.FieldByName('codigo').AsString);
        sCantidad := dmDatos.cdsImExportar.FieldByName('cantidad').AsString;
        sPrecio := dmDatos.cdsImExportar.FieldByName('precio').AsString;

        with dmDatos.qryModifica do begin
            Close;
            SQL.Clear;
            SQL.Add('SELECT articulo FROM codigos WHERE codigo = ''' + sJuego + '''');
            Open;
            sJuego := FieldByName('articulo').AsString;

            Close;
            SQL.Clear;
            SQL.Add('SELECT articulo FROM codigos WHERE codigo = ''' + sArticulo + '''');
            Open;
            sArticulo := FieldByName('articulo').AsString;


            Close;
            SQL.Clear;
            SQL.Add('SELECT clave FROM juegos WHERE clave = ''' + sJuego + '''');
            SQL.Add('AND articulo = ''' + sArticulo + '''');
            Open;
            if(Eof) then begin
                Close;
                SQL.Clear;
                SQL.Add('INSERT INTO juegos (clave, articulo, cantidad, precio) VALUES(');
                SQL.Add(sJuego + ',' + sArticulo + ',' + sCantidad + ',' + sPrecio + ')');
                ExecSQL;
            end;
            Close;
            dmDatos.cdsImExportar.Next;
            barAvance.StepIt;
        end;
    end;
    dmDatos.cdsImExportar.Active := false;
    StrStream.Free;
end;

procedure TfrmImportar.ImportaCodigos;
var
    sClave, sPrimario, sAlterno : String;
    i : integer;
begin
    lblTabla.Caption := 'Códigos';
    lblTabla.Refresh;
    for i := 0 to zipArchivo.Count do
        if (zipArchivo.Name[i] = 'codigos.xml') then
            break;

    dmDatos.cdsImExportar.Active := false;
    StrStream := TStringStream.Create(zipArchivo.Data[i]);
    dmDatos.cdsImExportar.LoadFromStream(strStream);
    dmDatos.cdsImExportar.Active := true;
    barAvance.Max := dmDatos.cdsImExportar.RecordCount;
    barAvance.Position := 0;

    while(not (dmDatos.cdsImExportar.Eof)) do begin
        sPrimario := Trim(dmDatos.cdsImExportar.FieldByName('primario').AsString);
        sAlterno := Trim(dmDatos.cdsImExportar.FieldByName('alterno').AsString);

        with dmDatos.qryModifica do begin
            Close;
            SQL.Clear;
            SQL.Add('SELECT articulo FROM codigos WHERE codigo = ''' + sPrimario + '''');
            Open;
            sClave := FieldByName('articulo').AsString;

            Close;
            SQL.Clear;
            SQL.Add('INSERT INTO codigos (articulo, codigo, tipo) VALUES(');
            SQL.Add(sClave + ',''' + sAlterno + ''',''S'')');
            ExecSQL;
            Close;

            dmDatos.cdsImExportar.Next;
            barAvance.StepIt;
        end;
    end;
    dmDatos.cdsImExportar.Active := false;
    StrStream.Free;
end;

procedure TfrmImportar.ImportaClientes;
var
    sClave, sRfc, sNombre, sCalle, sColonia, sCp, sLocalidad, sCateg : String;
    sEstado, sContacto, sCelular, sCorreo, sFechaCap, sTelefono, sFechaUMov : String;
    sCredencial, sVenceCreden, sLimite, sPrecio, sDescuento  : String;
    sRfcEmp, sNombreEmp, sCalleEmp, sColoniaEmp, sCpEmp, sLocalidadEmp : String;
    sEstadoEmp, sFaxEmp, sCorreoEmp, sTelEmp : String;
    dteFechaUMov : TDateTime;
    i : integer;
begin
    lblTabla.Caption := 'Clientes';
    lblTabla.Refresh;
    for i := 0 to zipArchivo.Count do
        if (zipArchivo.Name[i] = 'clientes.xml') then
            break;

    dmDatos.cdsImExportar.Active := false;
    StrStream := TStringStream.Create(zipArchivo.Data[i]);
    dmDatos.cdsImExportar.LoadFromStream(strStream);
    dmDatos.cdsImExportar.Active := true;
    barAvance.Max := dmDatos.cdsImExportar.RecordCount;
    barAvance.Position := 0;

    sFechaUMov := FormatDateTime('mm/dd/yyyy hh:nn:ss',Now);
    while(not (dmDatos.cdsImExportar.Eof)) do begin
        sRfc := Trim(dmDatos.cdsImExportar.FieldByName('rfc').AsString);
        sNombre := Trim(dmDatos.cdsImExportar.FieldByName('nombre').AsString);
        sCalle := Trim(dmDatos.cdsImExportar.FieldByName('calle').AsString);
        sColonia := Trim(dmDatos.cdsImExportar.FieldByName('colonia').AsString);
        sCp := Trim(dmDatos.cdsImExportar.FieldByName('cp').AsString);
        sLocalidad := Trim(dmDatos.cdsImExportar.FieldByName('localidad').AsString);
        sEstado := Trim(dmDatos.cdsImExportar.FieldByName('estado').AsString);
        sCelular := Trim(dmDatos.cdsImExportar.FieldByName('celular').AsString);
        sCorreo := Trim(dmDatos.cdsImExportar.FieldByName('ecorreo').AsString);
        sContacto := Trim(dmDatos.cdsImExportar.FieldByName('contacto').AsString);
        sFechaCap := FormatDateTime('mm/dd/yyyy',dmDatos.cdsImExportar.FieldByName('fechacap').AsDateTime);
        sTelefono := Trim(dmDatos.cdsImExportar.FieldByName('telefono').AsString);
        sCateg := Trim(dmDatos.cdsImExportar.FieldByName('categoria').AsString);
        sCredencial := Trim(dmDatos.cdsImExportar.FieldByName('credencial').AsString);
        sDescuento := Trim(dmDatos.cdsImExportar.FieldByName('descuento').AsString);
        if(Length(sDescuento) = 0) then
            sDescuento := '0';
        sVenceCreden := FormatDateTime('mm/dd/yyyy',dmDatos.cdsImExportar.FieldByName('vencimcreden').AsDateTime);
        sLimite := Trim(dmDatos.cdsImExportar.FieldByName('limitecredito').AsString);
        if(Length(sLimite) = 0) then
            sLimite := '0';
        sPrecio := dmDatos.cdsImExportar.FieldByName('precio').AsString;

        sRfcEmp := Trim(dmDatos.cdsImExportar.FieldByName('rfcemp').AsString);
        sNombreEmp := Trim(dmDatos.cdsImExportar.FieldByName('empresa').AsString);
        sCalleEmp := Trim(dmDatos.cdsImExportar.FieldByName('calleemp').AsString);
        sColoniaEmp := Trim(dmDatos.cdsImExportar.FieldByName('coloniaemp').AsString);
        sCpEmp := Trim(dmDatos.cdsImExportar.FieldByName('cpemp').AsString);
        sLocalidadEmp := Trim(dmDatos.cdsImExportar.FieldByName('localidademp').AsString);
        sEstadoEmp := Trim(dmDatos.cdsImExportar.FieldByName('estadoemp').AsString);
        sTelEmp := Trim(dmDatos.cdsImExportar.FieldByName('telemp').AsString);
        sFaxEmp := Trim(dmDatos.cdsImExportar.FieldByName('faxemp').AsString);
        sCorreoEmp := Trim(dmDatos.cdsImExportar.FieldByName('correoemp').AsString);
        dteFechaUMov := dmDatos.cdsImExportar.FieldByName('fechaumov').AsDateTime;

        with dmDatos.qryModifica do begin
            Close;
            SQL.Clear;
            SQL.Add('SELECT clave FROM categorias WHERE nombre = ''' + sCateg + ''' AND tipo = ''C''');
            Open;
            sCateg := FieldByName('clave').AsString;
            if(Length(sCateg) = 0) then
                sCateg := 'null';

            Close;
            SQL.Clear;
            SQL.Add('SELECT clave, fechaumov FROM clientes WHERE nombre = ''' + sNombre + '''');
            Open;
            if(Eof) then begin
                Close;
                SQL.Clear;
                SQL.Add('INSERT INTO clientes (rfc, nombre, calle, colonia, cp,');
                SQL.Add('localidad, estado, contacto, celular, ecorreo, fechacap,');
                SQL.Add('telefono, fechaumov, categoria, precio, credencial,');
                SQL.Add('vencimcreden, limitecredito, descuento, rfcemp, empresa,');
                SQL.Add('calleemp, coloniaemp, cpemp, localidademp, estadoemp,');
                SQL.Add('faxemp, correoemp, telemp, acumulado) VALUES(');

                SQL.Add('''' + sRfc + ''',''' + sNombre + ''',''' + sCalle + ''',');
                SQL.Add('''' + sColonia + ''',''' + sCp + ''',''' + sLocalidad + ''',''' + sEstado + ''',');
                SQL.Add('''' + sContacto + ''',''' + sCelular + ''',''' + sCorreo + ''',');
                SQL.Add('''' + sFechaCap + ''',''' + sTelefono + ''',''' + sFechaUMov + ''',');
                SQL.Add(sCateg + ',' + sPrecio  + ',''' + sCredencial + ''',');
                SQL.Add('''' + sVenceCreden + ''',' + sLimite + ',' + sDescuento + ',');
                SQL.Add('''' + sRfcEmp + ''',''' + sNombreEmp + ''',');
                SQL.Add('''' + sCalleEmp + ''',''' + sColoniaEmp + ''',''' + sCpEmp + ''',');
                SQL.Add('''' + sLocalidadEmp + ''',''' + sEstadoEmp + ''',''' + sFaxEmp + ''',');
                SQL.Add('''' + sCorreoEmp + ''',''' + sTelEmp + ''',0)');
                ExecSQL;
                Close;
            end
            else begin
                // Modifica el registro
                sClave := FieldByName('clave').AsString;

                if(dteFechaUMov > FieldByName('fechaumov').AsDateTime) or (rdbReemplazar.Checked) then begin
                    Close;
                    SQL.Clear;
                    SQL.Add('UPDATE clientes SET rfc = ''' + sRfc + ''',');
                    SQL.Add('nombre = ''' + sNombre + ''',');
                    SQL.Add('calle = ''' + sCalle + ''',');
                    SQL.Add('colonia = ''' + sColonia + ''',');
                    SQL.Add('cp = ''' + sCp + ''',');
                    SQL.Add('localidad = ''' + sLocalidad + ''',');
                    SQL.Add('estado = ''' + sEstado + ''',');
                    SQL.Add('contacto = ''' + sContacto + ''',');
                    SQL.Add('celular = ''' + sCelular + ''',');
                    SQL.Add('ecorreo = ''' + sCorreo + ''',');
                    SQL.Add('fechacap = ''' + sFechaCap + ''',');
                    SQL.Add('telefono = ''' + sTelefono + ''',');
                    SQL.Add('fechaumov = ''' + sFechaUmov + ''',');
                    SQL.Add('categoria = ' + sCateg + ',');
                    SQL.Add('precio = ' + sPrecio + ',');
                    SQL.Add('credencial = ''' + sCredencial + ''',');
                    SQL.Add('vencimcreden = ''' + sVenceCreden + ''',');
                    SQL.Add('limitecredito = ' + sLimite + ',');
                    SQL.Add('descuento = ' + sDescuento + ',');
                    SQL.Add('rfcemp = ''' + sRfcEmp + ''',');
                    SQL.Add('empresa = ''' + sNombreEmp + ''',');
                    SQL.Add('calleemp = ''' + sCalleEmp + ''',');
                    SQL.Add('coloniaemp = ''' + sColoniaEmp + ''',');
                    SQL.Add('cpemp = ''' + sCpEmp + ''',');
                    SQL.Add('localidademp = ''' + sLocalidadEmp + ''',');
                    SQL.Add('estadoemp = ''' + sEstadoEmp + ''',');
                    SQL.Add('faxemp = ''' + sFaxEmp + ''',');
                    SQL.Add('telemp = ''' + sTelEmp + ''',');
                    SQL.Add('correoemp = ''' + sCorreoEmp + '''');
                    SQL.Add('WHERE clave = ' + sClave);
                    ExecSQL;
                    Close;
                end
                else begin
                    Close;
                    SQL.Clear;
                    SQL.Add('UPDATE clientes SET fechaumov = ''' + sFechaUMov + '''');
                    SQL.Add('WHERE clave = ' + sClave);
                    ExecSQL;
                    Close;
                end;
            end;
            dmDatos.cdsImExportar.Next;
            barAvance.StepIt;
        end;
    end;
    dmDatos.cdsImExportar.Active := false;
    StrStream.Free;

    if(rdbReemplazar.Checked) then
        //Elimina todo lo que no estaba en la importación
        with dmDatos.qryModifica do begin
            Close;
            SQL.Clear;
            SQL.Add('DELETE FROM clientes WHERE fechaumov <> ''' + sFechaUMov + '''');
            ExecSQL;
            Close;
        end;
end;

procedure TfrmImportar.ImportaTiposPago;
var
    sClave, sNombre, sCajon, sReferencia, sFechaUMov : String;
    sModo, sPagos, sPlazo, sInteres, sEnganche, sMontoMinimo : String;
    sAplica, sIntMorat, sTipoInteres, sTipoPlazo : String;
    dteFechaUMov : TDateTime;
    i : integer;
begin
    lblTabla.Caption := 'Tipos de pago';
    lblTabla.Refresh;
    for i := 0 to zipArchivo.Count do
        if (zipArchivo.Name[i] = 'tipospago.xml') then
            break;

    dmDatos.cdsImExportar.Active := false;
    StrStream := TStringStream.Create(zipArchivo.Data[i]);
    dmDatos.cdsImExportar.LoadFromStream(strStream);
    dmDatos.cdsImExportar.Active := true;
    barAvance.Max := dmDatos.cdsImExportar.RecordCount;
    barAvance.Position := 0;

    sFechaUMov := FormatDateTime('mm/dd/yyyy hh:nn:ss',Now);
    while(not (dmDatos.cdsImExportar.Eof)) do begin
        sNombre := Trim(dmDatos.cdsImExportar.FieldByName('nombre').AsString);
        sCajon := dmDatos.cdsImExportar.FieldByName('abrircajon').AsString;
        sReferencia := dmDatos.cdsImExportar.FieldByName('referencia').AsString;
        dteFechaUMov := dmDatos.cdsImExportar.FieldByName('fecha_umov').AsDateTime;
        sModo := Trim(dmDatos.cdsImExportar.FieldByName('modo').AsString);
        sAplica := '''' + Trim(dmDatos.cdsImExportar.FieldByName('aplica').AsString) + '''';
        if(sModo = 'CREDITO') then begin
            sPagos := dmDatos.cdsImExportar.FieldByName('pagos').AsString;
            sPlazo := dmDatos.cdsImExportar.FieldByName('plazo').AsString;
            sInteres := dmDatos.cdsImExportar.FieldByName('interes').AsString;
            sEnganche := dmDatos.cdsImExportar.FieldByName('enganche').AsString;
            sMontoMinimo := dmDatos.cdsImExportar.FieldByName('montominimo').AsString;
            sIntMorat := dmDatos.cdsImExportar.FieldByName('intmoratorio').AsString;
            sTipoInteres := '''' + Trim(dmDatos.cdsImExportar.FieldByName('tipointeres').AsString) + '''';
            sTipoPlazo := dmDatos.cdsImExportar.FieldByName('tipoplazo').AsString;
        end
        else begin
            sPagos := 'null';
            sPlazo := 'null';
            sInteres := 'null';
            sEnganche := 'null';
            sMontoMinimo := 'null';
            sIntMorat := 'null';
            sTipoInteres := 'null';
            sTipoPlazo := 'null';
        end;

        with dmDatos.qryModifica do begin
            Close;
            SQL.Clear;
            SQL.Add('SELECT clave, fecha_umov FROM tipopago WHERE nombre = ''' + sNombre + '''');
            Open;
            if(Eof) then begin
                Close;
                SQL.Clear;
                SQL.Add('INSERT INTO tipopago (nombre, abrircajon, referencia,');
                SQL.Add('fecha_umov, modo, pagos, plazo, interes, enganche,');
                SQL.Add('montominimo, aplica, intmoratorio, tipointeres, tipoplazo) VALUES(');
                SQL.Add('''' + sNombre + ''',''' + sCajon + ''',''' + sReferencia + ''',''' +sFechaUMov + ''',');
                SQL.Add('''' + sModo + ''',' + sPagos + ',' + sPlazo + ',' + sInteres + ',' + sEnganche + ',');
                SQL.Add(sMontoMinimo + ',' + sAplica + ',' + sIntMorat + ',');
                SQL.Add(sTipoInteres + ',' + sTipoPlazo + ')');
                ExecSQL;
                Close;
            end
            else begin
                // Modifica el registro
                sClave := FieldByName('clave').AsString;

                if(dteFechaUMov > FieldByName('fecha_umov').AsDateTime) or (rdbReemplazar.Checked) then begin
                    Close;
                    SQL.Clear;
                    SQL.Add('UPDATE tipopago SET nombre = ''' + sNombre + ''',');
                    SQL.Add('abrircajon = ''' + sCajon + ''',');
                    SQL.Add('referencia = ''' + sReferencia + ''',');
                    SQL.Add('fecha_umov = ''' + sFechaUMov + ''',');
                    SQL.Add('modo = ''' + sModo + ''',');
                    SQL.Add('pagos = ' + sPagos + ',');
                    SQL.Add('plazo = ' + sPlazo + ',');
                    SQL.Add('interes = ' + sInteres + ',');
                    SQL.Add('enganche = ' + sEnganche + ',');
                    SQL.Add('montominimo = ' + sMontoMinimo + ',');
                    SQL.Add('aplica = ' + sAplica + ',');
                    SQL.Add('intmoratorio = ' + sIntMorat + ',');
                    SQL.Add('tipointeres = ' + sTipoInteres + ',');
                    SQL.Add('tipoplazo = ' + sTipoPlazo);
                    SQL.Add('WHERE clave = ' + sClave);
                    ExecSQL;
                    Close;
                end
                else begin
                    Close;
                    SQL.Clear;
                    SQL.Add('UPDATE tipopago SET fecha_umov = ''' + sFechaUMov + '''');
                    SQL.Add('WHERE clave = ' + sClave);
                    ExecSQL;
                    Close;
                end;
            end;
            dmDatos.cdsImExportar.Next;
            barAvance.StepIt;
        end;
    end;
    dmDatos.cdsImExportar.Active := false;
    StrStream.Free;

    if(rdbReemplazar.Checked) then
        //Elimina todo lo que no estaba en la importación
        with dmDatos.qryModifica do begin
            Close;
            SQL.Clear;
            SQL.Add('DELETE FROM tipopago WHERE fecha_umov <> ''' + sFechaUMov + '''');
            ExecSQL;
            Close;
        end;
end;

procedure TfrmImportar.RecuperaConfig;
var
    iniArchivo : TIniFile;
    sIzq, sArriba, sValor: String;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'config.ini');

    with iniArchivo do begin
        //Recupera la posición Y de la ventana
        sArriba := ReadString('Importar', 'Posy', '');

        //Recupera la posición X de la ventana
        sIzq := ReadString('Importar', 'Posx', '');
        if (Length(sIzq) > 0) and (Length(sArriba) > 0) then begin
            Left := StrToInt(sIzq);
            Top := StrToInt(sArriba);
        end;

        //Recupera la ruta de exportación
        sValor := ReadString('Importar', 'Ruta', '');
        if (Length(sValor) > 0) then
            txtRuta.Text := sValor;

        //Recupera el tipo de importación
        sValor := ReadString('Importar', 'Tipo', '');
        if (sValor = 'S') then
            rdbSincronizar.Checked := true
        else
            rdbReemplazar.Checked := true
    end;
end;

procedure TfrmImportar.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
    iniArchivo : TIniFile;
begin
    zipArchivo.Free;

    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'config.ini');

    with iniArchivo do begin
        // Registra la posición y de la ventana
        WriteString('Importar', 'Posy', IntToStr(Top));

        // Registra la posición X de la ventana
        WriteString('Importar', 'Posx', IntToStr(Left));

        // Registra la ruta de exportación
        WriteString('Importar', 'Ruta', txtRuta.Text);

        // Registra el tipo de importación
        if(rdbSincronizar.Checked) then
            WriteString('Importar', 'Tipo', 'S')
        else
            WriteString('Importar', 'Tipo', 'R');

        Free;
    end;
end;

procedure TfrmImportar.chkArticulosClick(Sender: TObject);
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

procedure TfrmImportar.ImportaUsuarios;
var
    sLogin, sContra, sNombre, sCalle, sColonia, sCp, sLocalidad, sPermisos : String;
    sClave, sEstado, sTelefono, sFechaUMov, sFechaCap, sMenu, sOpciones: String;
    sPrivilegio, sAdicional, sDescuento : String;
    dteFechaUMov : TDateTime;
    i : integer;
begin
    lblTabla.Caption := 'Usuarios';
    lblTabla.Refresh;
    for i := 0 to zipArchivo.Count do
        if (zipArchivo.Name[i] = 'usuarios.xml') then
            break;

    dmDatos.cdsImExportar.Active := false;
    StrStream := TStringStream.Create(zipArchivo.Data[i]);
    dmDatos.cdsImExportar.LoadFromStream(strStream);
    dmDatos.cdsImExportar.Active := true;
    barAvance.Max := dmDatos.cdsImExportar.RecordCount;
    barAvance.Position := 0;

    sFechaUMov := FormatDateTime('mm/dd/yyyy',Now);
    while(not (dmDatos.cdsImExportar.Eof)) do begin
        sLogin := Trim(dmDatos.cdsImExportar.FieldByName('login').AsString);
        sContra := Trim(dmDatos.cdsImExportar.FieldByName('contra').AsString);
        sNombre := Trim(dmDatos.cdsImExportar.FieldByName('nombre').AsString);
        sCalle := Trim(dmDatos.cdsImExportar.FieldByName('calle').AsString);
        sColonia := Trim(dmDatos.cdsImExportar.FieldByName('colonia').AsString);
        sCp := Trim(dmDatos.cdsImExportar.FieldByName('cp').AsString);
        sLocalidad := Trim(dmDatos.cdsImExportar.FieldByName('localidad').AsString);
        sEstado := Trim(dmDatos.cdsImExportar.FieldByName('estado').AsString);
        sTelefono := Trim(dmDatos.cdsImExportar.FieldByName('telefono').AsString);
        sFechaCap := FormatDateTime('mm/dd/yyyy',dmDatos.cdsImExportar.FieldByName('fecha_cap').AsDateTime);
        dteFechaUMov := dmDatos.cdsImExportar.FieldByName('fecha_umov').AsDateTime;
        sDescuento := dmDatos.cdsImExportar.FieldByName('descuento').AsString;

        with dmDatos.qryModifica do begin
            Close;
            SQL.Clear;
            SQL.Add('SELECT clave, fecha_umov FROM usuarios WHERE login = ''' + sLogin + '''');
            Open;
            if(Eof) then begin
                Close;
                SQL.Clear;
                SQL.Add('INSERT INTO usuarios (login, contra, nombre, calle, colonia, cp,');
                SQL.Add('localidad, estado, telefono, fecha_cap, fecha_umov, descuento) VALUES(');

                SQL.Add('''' + sLogin + ''',''' + sContra + ''',''' + sNombre + ''',');
                SQL.Add('''' + sCalle + ''',''' + sColonia + ''',''' + sCp + ''',');
                SQL.Add('''' + sLocalidad + ''',''' + sEstado + ''',');
                SQL.Add('''' + sTelefono + ''',''' + sFechaCap + ''',');
                SQL.Add('''' + sFechaUMov + ''',' + sDescuento + ')');
                ExecSQL;
                Close;
            end
            else begin
                sClave := FieldByName('clave').AsString;

                // Modifica el registro
                if(dteFechaUMov > FieldByName('fecha_umov').AsDateTime) or (rdbReemplazar.Checked) then begin
                    Close;
                    SQL.Clear;
                    SQL.Add('UPDATE usuarios SET');
                    SQL.Add('nombre = ''' + sNombre + ''',');
                    SQL.Add('calle = ''' + sCalle + ''',');
                    SQL.Add('colonia = ''' + sColonia + ''',');
                    SQL.Add('cp = ''' + sCp + ''',');
                    SQL.Add('localidad = ''' + sLocalidad + ''',');
                    SQL.Add('estado = ''' + sEstado + ''',');
                    SQL.Add('fecha_cap = ''' + sFechaCap + ''',');
                    SQL.Add('fecha_umov = ''' + sFechaUMov + ''',');
                    SQL.Add('telefono = ''' + sTelefono + '''');
                    SQL.Add('WHERE clave = ' + sClave);
                    ExecSQL;
                    Close;
                end
                else begin
                    Close;
                    SQL.Clear;
                    SQL.Add('UPDATE usuarios SET fecha_umov = ''' + sFechaUmov + '''');
                    SQL.Add('WHERE clave = ' + sClave);
                    ExecSQL;
                    Close;
                end;
            end;
            dmDatos.cdsImExportar.Next;
            barAvance.StepIt;
        end;
    end;
    dmDatos.cdsImExportar.Active := false;
    StrStream.Free;

    with dmDatos.qryModifica do begin
        // Elimina todos los permisos de lo usuarios
        Close;
        SQL.Clear;
        SQL.Add('DELETE FROM permisos');
        ExecSQL;
        Close;
    end;

    lblTabla.Caption := 'Permisos';
    lblTabla.Refresh;
    for i := 0 to zipArchivo.Count do
        if (zipArchivo.Name[i] = 'permisos.xml') then
            break;

    dmDatos.cdsImExportar.Active := false;
    StrStream := TStringStream.Create(zipArchivo.Data[i]);
    dmDatos.cdsImExportar.LoadFromStream(strStream);
    dmDatos.cdsImExportar.Active := true;
    barAvance.Max := dmDatos.cdsImExportar.RecordCount;
    barAvance.Position := 0;
    while(not (dmDatos.cdsImExportar.Eof)) do begin
        sLogin := Trim(dmDatos.cdsImExportar.FieldByName('login').AsString);
        sMenu := dmDatos.cdsImExportar.FieldByName('menu').AsString;
        sOpciones := dmDatos.cdsImExportar.FieldByName('opciones').AsString;
        sPermisos := dmDatos.cdsImExportar.FieldByName('permiso').AsString;
        with dmDatos.qryModifica do begin
            Close;
            SQL.Clear;
            SQL.Add('SELECT clave FROM usuarios WHERE login = ''' + sLogin + '''');
            Open;
            sClave := FieldByName('clave').AsString;
            if(not Eof) then begin
                Close;
                SQL.Clear;
                SQL.Add('INSERT INTO permisos (usuario,menu,opciones,permiso) VALUES(');
                SQL.Add(sClave + ',' + sMenu + ',' + sOpciones + ',' + sPermisos + ')');
                ExecSQL;
            end;
            Close;
        end;
        dmDatos.cdsImExportar.Next;
        barAvance.StepIt;
    end;
    dmDatos.cdsImExportar.Active := false;
    StrStream.Free;

    with dmDatos.qryModifica do begin
        // Elimina todos los privilegios de lo usuarios
        Close;
        SQL.Clear;
        SQL.Add('DELETE FROM privilegios');
        ExecSQL;
        Close;
    end;

    lblTabla.Caption := 'Privilegios';
    lblTabla.Refresh;
    for i := 0 to zipArchivo.Count do
        if (zipArchivo.Name[i] = 'privilegios.xml') then
            break;

    dmDatos.cdsImExportar.Active := false;
    StrStream := TStringStream.Create(zipArchivo.Data[i]);
    dmDatos.cdsImExportar.LoadFromStream(strStream);
    dmDatos.cdsImExportar.Active := true;
    barAvance.Max := dmDatos.cdsImExportar.RecordCount;
    barAvance.Position := 0;
    while(not (dmDatos.cdsImExportar.Eof)) do begin
        sLogin := Trim(dmDatos.cdsImExportar.FieldByName('login').AsString);
        sPrivilegio := dmDatos.cdsImExportar.FieldByName('clave').AsString;
        sAdicional := dmDatos.cdsImExportar.FieldByName('adicional').AsString;
        with dmDatos.qryModifica do begin
            Close;
            SQL.Clear;
            SQL.Add('SELECT clave FROM usuarios WHERE login = ''' + sLogin + '''');
            Open;
            sClave := FieldByName('clave').AsString;
            if(not Eof) then begin
                Close;
                SQL.Clear;
                SQL.Add('INSERT INTO privilegios (usuario,clave,adicional) VALUES(');
                SQL.Add(sClave + ',''' + sPrivilegio + ''',''' + sAdicional + ''')');
                ExecSQL;
            end;
            Close;
        end;
        dmDatos.cdsImExportar.Next;
        barAvance.StepIt;
    end;
    dmDatos.cdsImExportar.Active := false;
    StrStream.Free;
end;

procedure TfrmImportar.ImportaTicket;
var
    sNivel, sRenglon, sTexto : String;
    i : integer;
begin
    lblTabla.Caption := 'Ticket';
    lblTabla.Refresh;
    for i := 0 to zipArchivo.Count do
        if (zipArchivo.Name[i] = 'ticket.xml') then
            break;

    dmDatos.cdsImExportar.Active := false;
    StrStream := TStringStream.Create(zipArchivo.Data[i]);
    dmDatos.cdsImExportar.LoadFromStream(strStream);
    dmDatos.cdsImExportar.Active := true;
    barAvance.Max := dmDatos.cdsImExportar.RecordCount;
    barAvance.Position := 0;

    with dmDatos.qryModifica do begin
        Close;
        SQL.Clear;
        SQL.Add('DELETE FROM ticket');
        ExecSQL;
        Close;
    end;

    while(not (dmDatos.cdsImExportar.Eof)) do begin
        sNivel := Trim(dmDatos.cdsImExportar.FieldByName('nivel').AsString);
        sRenglon := Trim(dmDatos.cdsImExportar.FieldByName('renglon').AsString);
        sTexto := dmDatos.cdsImExportar.FieldByName('texto').AsString;

        with dmDatos.qryModifica do begin
            Close;
            SQL.Clear;
            SQL.Add('INSERT INTO ticket (nivel, renglon, texto) VALUES( ');
            SQL.Add(sNivel + ',' + sRenglon + ',''' + sTexto + ''')');
            ExecSQL;
            Close;

            dmDatos.cdsImExportar.Next;
            barAvance.StepIt;
        end;
    end;
    dmDatos.cdsImExportar.Active := false;
    StrStream.Free;
end;

procedure TfrmImportar.ImportaEmpresa;
var
    sRfc, sNombre, sCalle, sColonia, sCp, sLocalidad : String;
    sEstado, sFax, sCorreo, sTelefono, sPagina, sFecha : String;
    i : integer;
begin
    lblTabla.Caption := 'Empresa';
    lblTabla.Refresh;
    for i := 0 to zipArchivo.Count do
        if (zipArchivo.Name[i] = 'empresa.xml') then
            break;

    dmDatos.cdsImExportar.Active := false;
    StrStream := TStringStream.Create(zipArchivo.Data[i]);
    dmDatos.cdsImExportar.LoadFromStream(strStream);
    dmDatos.cdsImExportar.Active := true;
    barAvance.Position := 0;
    with dmDatos.cdsImExportar do begin
        barAvance.Max := RecordCount;
        sRfc := Trim(FieldByName('rfc').AsString);
        sNombre := Trim(FieldByName('nombre').AsString);
        sCalle := Trim(FieldByName('calle').AsString);
        sColonia := Trim(FieldByName('colonia').AsString);
        sCp := Trim(FieldByName('cp').AsString);
        sLocalidad := Trim(FieldByName('localidad').AsString);
        sEstado := Trim(FieldByName('estado').AsString);
        sTelefono := Trim(FieldByName('telefono').AsString);
        sFax := Trim(FieldByName('fax').AsString);
        sCorreo := Trim(FieldByName('correoe').AsString);
        sFecha := FormatDateTime('mm/dd/yyyy',FieldByName('fecha').AsDateTime);
        sPagina := Trim(FieldByName('paginaweb').AsString);
    end;

    with dmDatos.qryModifica do begin
        Close;
        SQL.Clear;
        SQL.Add('DELETE FROM empresa');
        ExecSQL;
        Close;

        Close;
        SQL.Clear;
        SQL.Add('INSERT INTO empresa (rfc, nombre, calle, colonia, cp,');
        SQL.Add('localidad, estado, fax, correoe,');
        SQL.Add('fecha, telefono) VALUES(');
        SQL.Add('''' + sRfc + ''',''' + sNombre + ''',''' + sCalle + ''',');
        SQL.Add('''' + sColonia + ''',''' + sCp + ''',''' + sLocalidad + ''',''' + sEstado + ''',');
        SQL.Add('''' + sFax + ''',''' + sCorreo + ''',');
        SQL.Add('''' + sFecha + ''',''' + sTelefono + '''' + ')');
        ExecSQL;
        Close;
    end;
    dmDatos.cdsImExportar.Active := false;
    StrStream.Free;
end;

procedure TfrmImportar.ImportaDescuentos;
var
    sFechaIni, sFechaFin, sArticulo, sDepto, sCateg, sTotal, sCantidad, sPorcent, sVolumen : String;
    i : integer;
begin
    lblTabla.Caption := 'Descuentos';
    lblTabla.Refresh;
    for i := 0 to zipArchivo.Count do
        if (zipArchivo.Name[i] = 'descuentos.xml') then
            break;

    dmDatos.cdsImExportar.Active := false;
    StrStream := TStringStream.Create(zipArchivo.Data[i]);
    dmDatos.cdsImExportar.LoadFromStream(strStream);
    dmDatos.cdsImExportar.Active := true;
    barAvance.Max := dmDatos.cdsImExportar.RecordCount;
    barAvance.Position := 0;

    with dmDatos.qryModifica do begin
        Close;
        SQL.Clear;
        SQL.Add('DELETE FROM descuentos');
        ExecSQL;
        Close;
    end;

    while(not (dmDatos.cdsImExportar.Eof)) do begin
        sFechaIni := FormatDateTime('mm/dd/yyyy',dmDatos.cdsImExportar.FieldByName('fechaini').AsDateTime);
        sFechaFin := FormatDateTime('mm/dd/yyyy',dmDatos.cdsImExportar.FieldByName('fechafin').AsDateTime);
        sArticulo := Trim(dmDatos.cdsImExportar.FieldByName('codigo').AsString);
        sDepto := Trim(dmDatos.cdsImExportar.FieldByName('departamento').AsString);
        sCateg := Trim(dmDatos.cdsImExportar.FieldByName('categoria').AsString);
        sTotal := dmDatos.cdsImExportar.FieldByName('total').AsString;
        sCantidad := dmDatos.cdsImExportar.FieldByName('cantidad').AsString;
        sPorcent := dmDatos.cdsImExportar.FieldByName('porcentaje').AsString;
        sVolumen := dmDatos.cdsImExportar.FieldByName('volumen').AsString;

        with dmDatos.qryModifica do begin
            Close;
            SQL.Clear;
            SQL.Add('SELECT articulo FROM codigos WHERE codigo = ''' + sArticulo + '''');
            Open;
            if(not Eof) then
                sArticulo := FieldByName('articulo').AsString
            else
                sArticulo := 'null';

            Close;
            SQL.Clear;
            SQL.Add('SELECT clave FROM departamentos WHERE nombre = ''' + sDepto + '''');
            Open;
            if(not Eof) then
                sDepto := FieldByName('clave').AsString
            else
                sDepto := 'null';

            Close;
            SQL.Clear;
            SQL.Add('SELECT clave FROM categorias WHERE nombre = ''' + sCateg + '''');
            Open;
            if(not Eof) then
                sCateg := FieldByName('clave').AsString
            else
                sCateg := 'null';

            Close;
            SQL.Clear;
            SQL.Add('INSERT INTO descuentos (fechaini, fechafin, articulo, departamento,');
            SQL.Add('categoria, total, cantidad, porcentaje, volumen) VALUES(');
            SQL.Add('''' + sFechaIni + ''',''' + sFechaFin + ''',' + sArticulo + ',');
            SQL.Add(sDepto + ',' + sCateg + ',' + sTotal + ',' + sCantidad + ',');
            SQL.Add(sPorcent + ',' + sVolumen + ')');
            ExecSQL;
            Close;

            dmDatos.cdsImExportar.Next;
            barAvance.StepIt;
        end;
    end;
    dmDatos.cdsImExportar.Active := false;
    StrStream.Free;
end;

procedure TfrmImportar.ImportaVentas;
var
    sCaja, sNumero, sIva, sTotal, sCambio, sRedondeo, sEstatus, sCliente, sventaRef : String;
    sUsuario, sFecha, sHora, sAreaVenta, sVenta, sCajaRef, sFechaRef, sHoraRef : String;
    i : integer;
begin
    lblTabla.Caption := 'Ventas';
    lblTabla.Refresh;
    for i := 0 to zipArchivo.Count do
        if (zipArchivo.Name[i] = 'ventas.xml') then
            break;

    dmDatos.cdsImExportar.Active := false;
    StrStream := TStringStream.Create(zipArchivo.Data[i]);
    dmDatos.cdsImExportar.LoadFromStream(strStream);
    dmDatos.cdsImExportar.Active := true;
    barAvance.Max := dmDatos.cdsImExportar.RecordCount;
    barAvance.Position := 0;

    while(not (dmDatos.cdsImExportar.Eof)) do begin
        dteFecha := dmDatos.cdsImExportar.FieldByName('fecha').AsDateTime;
        if(dteFechaIni <= dteFecha) and (dteFechaFin >= dteFecha) then begin
            sFecha := FormatDateTime('mm/dd/yyyy',dmDatos.cdsImExportar.FieldByName('fecha').AsDateTime);
            sCaja := dmDatos.cdsImExportar.FieldByName('caja').AsString;
            sNumero := dmDatos.cdsImExportar.FieldByName('numero').AsString;
            sIva := dmDatos.cdsImExportar.FieldByName('iva').AsString;
            sTotal := dmDatos.cdsImExportar.FieldByName('total').AsString;
            sCambio := dmDatos.cdsImExportar.FieldByName('cambio').AsString;
            sRedondeo := dmDatos.cdsImExportar.FieldByName('redondeo').AsString;
            sEstatus := dmDatos.cdsImExportar.FieldByName('estatus').AsString;
            sCliente := dmDatos.cdsImExportar.FieldByName('cliente').AsString;
            sUsuario := dmDatos.cdsImExportar.FieldByName('login').AsString;
            sHora := FormatDateTime('hh:nn:ss',dmDatos.cdsImExportar.FieldByName('hora').AsDateTime);
            sAreaVenta := dmDatos.cdsImExportar.FieldByName('area').AsString;
            sCajaRef := dmDatos.cdsImExportar.FieldByName('cajaref').AsString;
            sFechaRef := FormatDateTime('mm/dd/yyyy',dmDatos.cdsImExportar.FieldByName('fecharef').AsDateTime);
            sHoraRef := FormatDateTime('hh:nn:ss',dmDatos.cdsImExportar.FieldByName('horaref').AsDateTime);

            with dmDatos.qryModifica do begin
                Close;
                SQL.Clear;
                SQL.Add('SELECT clave FROM clientes WHERE nombre = ''' + sCliente + '''');
                Open;
                if(not Eof) then
                        sCliente := FieldByName('clave').AsString
                else
                    sCliente := 'null';

                Close;
                SQL.Clear;
                SQL.Add('SELECT clave FROM usuarios WHERE login = ''' + sUsuario + '''');
                Open;
                if(not Eof) then
                    sUsuario := FieldByName('clave').AsString
                else
                    sUsuario := 'null';

                Close;
                SQL.Clear;
                SQL.Add('SELECT clave FROM areasventa WHERE nombre = ''' + sAreaVenta + '''');
                Open;
                if(not Eof) then
                    sAreaVenta := FieldByName('clave').AsString
                else
                    sAreaVenta := 'null';

                //Busca la venta
                Close;
                SQL.Clear;
                SQL.Add('SELECT clave FROM ventas WHERE caja = ' + sCaja + ' AND ');
                SQL.Add('fecha = ''' + sFecha + ''' AND hora = ''' + sHora + '''');
                Open;
                if(Eof) then begin

                    sVentaRef := 'null';
                    if(Length(sCajaRef) > 0) then begin
                        //Busca la venta de referencia
                        Close;
                        SQL.Clear;
                        SQL.Add('SELECT clave FROM ventas WHERE caja = ''' + sCajaRef + ''' AND ');
                        SQL.Add('fecha = ''' + sFechaRef + ''' AND hora = ''' + sHoraRef + '''');
                        Open;
                        if(not Eof) then
                            sVentaRef := FieldByName('clave').AsString;
                    end;

                    Close;
                    SQL.Clear;
                    SQL.Add('INSERT INTO ventas (caja, numero, iva, total, cambio, redondeo,');
                    SQL.Add('estatus, cliente, usuario, fecha, hora, areaventa, ventaref) VALUES(');
                    SQL.Add(sCaja + ',' + sNumero + ',' + sIva + ',' + sTotal + ',' + sCambio + ',');
                    SQL.Add(sRedondeo + ',''' + sEstatus + ''',' + sCliente + ',');
                    SQL.Add(sUsuario + ',''' + sFecha + ''',''' + sHora + ''',' + sAreaVenta + ',' + sVentaRef + ')');
                    ExecSQL;
                    Close;

                    //Recupera la clave que genera el Trigger
                    Close;
                    SQL.Clear;
                    SQL.Add('SELECT clave FROM ventas WHERE caja = ' + sCaja);
                    SQL.Add('AND fecha = ''' + sFecha + ''' AND hora = ''' + sHora + '''');
                    Open;
                    sVenta := FieldByName('clave').AsString;
                    Close;

                    if(sCliente <> 'null') then begin
                        // Guarda la última venta al cliente
                        Close;
                        SQL.Clear;
                        SQL.Add('UPDATE clientes SET ultimacompra = ' + sVenta + ',');
                        SQL.Add('acumulado = acumulado + ' + sTotal);
                        SQL.Add('WHERE clave = ' + sCliente);
                        ExecSQL;
                        Close;
                    end;
                end;
                Close;
            end;
        end;
        dmDatos.cdsImExportar.Next;
        barAvance.StepIt;
    end;
    dmDatos.cdsImExportar.Active := false;
    StrStream.Free;
end;

procedure TfrmImportar.ImportaDetalleVenta;
var
    sCaja, sFecha, sHora, sOrden, sArticulo, sCantidad, sIva, sPrecio : String;
    sDescuento, sVenta, sTipoComp, sTipoArt, sJuego, sDevolucion, sOrdenRef : String;
    i : integer;
begin
    lblTabla.Caption := 'Detalle de ventas';
    lblTabla.Refresh;
    for i := 0 to zipArchivo.Count do
        if (zipArchivo.Name[i] = 'ventasdet.xml') then
            break;

    dmDatos.cdsImExportar.Active := false;
    StrStream := TStringStream.Create(zipArchivo.Data[i]);
    dmDatos.cdsImExportar.LoadFromStream(strStream);
    dmDatos.cdsImExportar.Active := true;
    barAvance.Max := dmDatos.cdsImExportar.RecordCount;
    barAvance.Position := 0;

    while(not (dmDatos.cdsImExportar.Eof)) do begin
        dteFecha := dmDatos.cdsImExportar.FieldByName('fecha').AsDateTime;
        if(dteFechaIni <= dteFecha) and (dteFechaFin >= dteFecha) then begin
            sFecha := FormatDateTime('mm/dd/yyyy',dmDatos.cdsImExportar.FieldByName('fecha').AsDateTime);
            sCaja := dmDatos.cdsImExportar.FieldByName('caja').AsString;
            sHora := FormatDateTime('hh:nn:ss',dmDatos.cdsImExportar.FieldByName('hora').AsDateTime);
            sOrden := dmDatos.cdsImExportar.FieldByName('orden').AsString;
            sArticulo := Trim(dmDatos.cdsImExportar.FieldByName('codigo').AsString);
            sCantidad := dmDatos.cdsImExportar.FieldByName('cantidad').AsString;
            sIva := dmDatos.cdsImExportar.FieldByName('iva').AsString;
            sPrecio := dmDatos.cdsImExportar.FieldByName('precio').AsString;
            sDescuento := dmDatos.cdsImExportar.FieldByName('descuento').AsString;
            sJuego := dmDatos.cdsImExportar.FieldByName('juego').AsString;
            sDevolucion := dmDatos.cdsImExportar.FieldByName('devolucion').AsString;
            if(Length(sDevolucion) = 0) then
                sDevolucion := '0';
            sOrdenRef := dmDatos.cdsImExportar.FieldByName('ventareforden').AsString;
            if(Length(sOrdenRef) = 0) then
                sOrdenRef := 'null';

            with dmDatos.qryModifica do begin
                //Recupera la clave y el tipo de articulo
                Close;
                SQL.Clear;
                SQL.Add('SELECT a.clave, a.tipo FROM articulos a LEFT JOIN ');
                SQL.Add('codigos o ON a.clave = o.articulo WHERE o.codigo = ''' + sArticulo + '''');
                Open;
                if(not Eof) then begin
                    sArticulo := FieldByName('clave').AsString;
                    sTipoArt := FieldByName('tipo').AsString;
                end
                else
                    sArticulo := 'null';

                // Recupera la clave de la venta
                Close;
                SQL.Clear;
                SQL.Add('SELECT clave FROM ventas WHERE caja = ' + sCaja + ' AND ');
                SQL.Add('fecha = ''' + sFecha + ''' AND hora = ''' + sHora + '''');
                Open;
                if(not Eof) then begin
                    sVenta := FieldByName('clave').AsString;

                    // Recupera el tipo de comprobante
                    Close;
                    SQL.Clear;
                    SQL.Add('SELECT tipo FROM comprobantes WHERE venta = ' + sVenta + ' AND ');
                    SQL.Add('estatus = ''A''');
                    Open;
                    sTipoComp := FieldByName('tipo').AsString;

                    // Verifica que no exista el registro
                    Close;
                    SQL.Clear;
                    SQL.Add('SELECT orden FROM ventasdet WHERE venta = ' + sVenta + ' AND ');
                    SQL.Add('orden = ' + sOrden + ' AND juego = ' + sJuego);
                    Open;

                    if(Eof) then begin
                        // Si el comprobante es diferente de cotización
                        if(sTipoComp <> 'C') then begin
                            if(sArticulo <> 'null') then
                                //Cuando sea no inventariable o juego
                                if(sTipoArt <> '1') and (sTipoArt <> '2') then begin
                                    Close;
                                    SQL.Clear;
                                    SQL.Add('UPDATE articulos SET');
                                    SQL.Add('existencia = existencia - ' + sCantidad + ',');
                                    SQL.Add('ultventa = ' + sVenta);
                                    SQL.Add('WHERE clave = ' + sArticulo);
                                    ExecSQL;
                                    Close;
                                end
                                else begin
                                    Close;
                                    SQL.Clear;
                                    SQL.Add('UPDATE articulos SET ultventa = ' + sVenta);
                                    SQL.Add('WHERE clave = ' + sArticulo);
                                    ExecSQL;
                                    Close;
                                end;
                        end;
                        Close;
                        SQL.Clear;
                        SQL.Add('INSERT INTO ventasdet (venta, articulo, cantidad, iva, precio,');
                        SQL.Add('descuento, orden, juego, devolucion, ventareforden, fiscal) VALUES(');
                        SQL.Add(sVenta + ',' + sArticulo + ',');
                        SQL.Add(sCantidad + ',' + sIva + ',' + sPrecio + ',' + sDescuento + ',');
                        SQL.Add(sOrden + ',' + sJuego + ',' + sDevolucion + ',' + sOrdenRef + ')');
                        ExecSQL;
                        Close;
                    end;
                end;
                Close;
            end;
        end;
        dmDatos.cdsImExportar.Next;
        barAvance.StepIt;
    end;
    dmDatos.cdsImExportar.Active := false;
    StrStream.Free;
end;

procedure TfrmImportar.ImportaPagoVenta;
var
    sCaja, sFecha, sHora, sTipoPago, sImporte, sReferencia, sVenta, sOrden: String;
    sNotaCredito, sCajaNotaCred : String;
    i : integer;
begin
    lblTabla.Caption := 'Pago de ventas';
    lblTabla.Refresh;
    for i := 0 to zipArchivo.Count do
        if (zipArchivo.Name[i] = 'ventaspago.xml') then
            break;

    dmDatos.cdsImExportar.Active := false;
    StrStream := TStringStream.Create(zipArchivo.Data[i]);
    dmDatos.cdsImExportar.LoadFromStream(strStream);
    dmDatos.cdsImExportar.Active := true;
    barAvance.Max := dmDatos.cdsImExportar.RecordCount;
    barAvance.Position := 0;

    while(not (dmDatos.cdsImExportar.Eof)) do begin
        dteFecha := dmDatos.cdsImExportar.FieldByName('fecha').AsDateTime;
        if(dteFechaIni <= dteFecha) and (dteFechaFin >= dteFecha) then begin
            sFecha := FormatDateTime('mm/dd/yyyy',dmDatos.cdsImExportar.FieldByName('fecha').AsDateTime);
            sCaja := dmDatos.cdsImExportar.FieldByName('caja').AsString;
            sHora := FormatDateTime('hh:nn:ss',dmDatos.cdsImExportar.FieldByName('hora').AsDateTime);
            sTipoPago := dmDatos.cdsImExportar.FieldByName('nombre').AsString;
            sImporte := Trim(dmDatos.cdsImExportar.FieldByName('importe').AsString);
            sReferencia := dmDatos.cdsImExportar.FieldByName('referencia').AsString;
            sOrden := dmDatos.cdsImExportar.FieldByName('orden').AsString;
            sNotaCredito := dmDatos.cdsImExportar.FieldByName('notacredito').AsString;
            sCajaNotaCred := dmDatos.cdsImExportar.FieldByName('cajanotacred').AsString;

            with dmDatos.qryModifica do begin
                Close;
                SQL.Clear;
                SQL.Add('SELECT clave FROM ventas WHERE caja = ' + sCaja + ' AND ');
                SQL.Add('fecha = ''' + sFecha + ''' AND hora = ''' + sHora + '''');
                Open;
                if(not Eof) then begin
                    sVenta := FieldByName('clave').AsString;

                    Close;
                    SQL.Clear;
                    SQL.Add('SELECT venta FROM ventaspago WHERE venta = ' + sVenta);
                    SQL.Add('AND orden = ' + sOrden);
                    Open;

                    if(Eof) then begin
                        Close;
                        SQL.Clear;
                        SQL.Add('SELECT clave FROM tipopago WHERE nombre = ''' + sTipoPago + '''');
                        Open;
                        if(not Eof) then
                            sTipoPago := FieldByName('clave').AsString
                        else
                            sTipoPago := 'null';

                        if(Length(sNotaCredito) > 0) then begin
                            Close;
                            SQL.Clear;
                            SQL.Add('SELECT clave FROM notascredito WHERE numero = ' + sNotaCredito);
                            SQL.Add('AND estatus = ''A'' AND caja = ' + sCajaNotaCred);
                            Open;
                            if(not Eof) then
                                sNotaCredito := FieldByName('clave').AsString
                            else
                                sNotaCredito := 'null';
                        end
                        else
                            sNotaCredito := 'null';

                        Close;
                        SQL.Clear;
                        SQL.Add('INSERT INTO ventaspago (venta, tipopago, importe, referencia, orden, notacredito) VALUES(');
                        SQL.Add(sVenta + ',' + sTipoPago + ',' + sImporte + ',''' + sReferencia + ''',' + sOrden + ',' + sNotaCredito + ')');
                        ExecSQL;
                        Close;
                    end;
                end;
                Close;
            end;
        end;
        dmDatos.cdsImExportar.Next;
        barAvance.StepIt;
    end;
    dmDatos.cdsImExportar.Active := false;
    StrStream.Free;
end;

procedure TfrmImportar.ImportaComprobantes;
var
    sCaja, sTipo, sNumero, sCliente, sFecha, sHora, sEstatus, sVenta: String;
    i : integer;
begin
    lblTabla.Caption := 'Comprobantes';
    lblTabla.Refresh;
    for i := 0 to zipArchivo.Count do
        if (zipArchivo.Name[i] = 'comprobantes.xml') then
            break;

    dmDatos.cdsImExportar.Active := false;
    StrStream := TStringStream.Create(zipArchivo.Data[i]);
    dmDatos.cdsImExportar.LoadFromStream(strStream);
    dmDatos.cdsImExportar.Active := true;
    barAvance.Max := dmDatos.cdsImExportar.RecordCount;
    barAvance.Position := 0;

    while(not (dmDatos.cdsImExportar.Eof)) do begin
        dteFecha := dmDatos.cdsImExportar.FieldByName('fecha').AsDateTime;
        if(dteFechaIni <= dteFecha) and (dteFechaFin >= dteFecha) then begin
            sFecha := FormatDateTime('mm/dd/yyyy',dmDatos.cdsImExportar.FieldByName('fecha').AsDateTime);
            sCaja := dmDatos.cdsImExportar.FieldByName('caja').AsString;
            sHora := FormatDateTime('hh:nn:ss',dmDatos.cdsImExportar.FieldByName('hora').AsDateTime);
            sTipo := dmDatos.cdsImExportar.FieldByName('tipo').AsString;
            sNumero := dmDatos.cdsImExportar.FieldByName('numero').AsString;
            sCliente := dmDatos.cdsImExportar.FieldByName('cliente').AsString;
            sFecha := FormatDateTime('mm/dd/yyyy',dmDatos.cdsImExportar.FieldByName('fecha').AsDateTime);
            sEstatus := dmDatos.cdsImExportar.FieldByName('estatus').AsString;

            with dmDatos.qryModifica do begin
                Close;
                SQL.Clear;
                SQL.Add('SELECT clave FROM clientes WHERE nombre = ''' + sCliente + '''');
                Open;
                if(not Eof) then
                    sCliente := FieldByName('clave').AsString
                else
                    sCliente := 'null';

                Close;
                SQL.Clear;
                SQL.Add('SELECT clave FROM ventas WHERE caja = ' + sCaja + ' AND ');
                SQL.Add('fecha = ''' + sFecha + ''' AND hora = ''' + sHora + '''');
                Open;
                if(not Eof) then begin
                    sVenta := FieldByName('clave').AsString;

                    Close;
                    SQL.Clear;
                    SQL.Add('SELECT venta FROM comprobantes WHERE venta = ' + sVenta);
                    SQL.Add('AND tipo = ''' + sTipo + ''' AND fecha = ''' + sFecha + '''');
                    SQL.Add('AND estatus = ''' + sEstatus + '''');
                    Open;

                    if(Eof) then begin
                        Close;
                        SQL.Clear;
                        SQL.Add('INSERT INTO comprobantes (venta, tipo, numero, cliente,');
                        SQL.Add('fecha, estatus, caja) VALUES(' + sVenta + ',');
                        SQL.Add('''' + sTipo + ''',' + sNumero + ',' + sCliente + ',');
                        SQL.Add('''' + sFecha + ''',''' + sEstatus + ''',' + sCaja + ')');
                        ExecSQL;
                        Close;
                    end;
                end;
                Close;
            end;
        end;
        dmDatos.cdsImExportar.Next;
        barAvance.StepIt;
    end;
    dmDatos.cdsImExportar.Active := false;
    StrStream.Free;
end;

procedure TfrmImportar.ImportaNotasCredito;
var
    sCaja, sImporte, sNumero, sCliente, sFecha, sNumComprob, sCajaComprob : String;
    sEstatus, sComprobante: String;
    i : integer;
begin
    lblTabla.Caption := 'Notas de crédito';
    lblTabla.Refresh;
    for i := 0 to zipArchivo.Count do
        if (zipArchivo.Name[i] = 'notascredito.xml') then
            break;

    dmDatos.cdsImExportar.Active := false;
    StrStream := TStringStream.Create(zipArchivo.Data[i]);
    dmDatos.cdsImExportar.LoadFromStream(strStream);
    dmDatos.cdsImExportar.Active := true;
    barAvance.Max := dmDatos.cdsImExportar.RecordCount;
    barAvance.Position := 0;

    while(not (dmDatos.cdsImExportar.Eof)) do begin
        dteFecha := dmDatos.cdsImExportar.FieldByName('fecha').AsDateTime;
        if(dteFechaIni <= dteFecha) and (dteFechaFin >= dteFecha) then begin
            sFecha := FormatDateTime('mm/dd/yyyy',dmDatos.cdsImExportar.FieldByName('fecha').AsDateTime);
            sNumero := dmDatos.cdsImExportar.FieldByName('numero').AsString;
            sImporte := dmDatos.cdsImExportar.FieldByName('importe').AsString;
            sEstatus := dmDatos.cdsImExportar.FieldByName('estatus').AsString;
            sCaja := dmDatos.cdsImExportar.FieldByName('caja').AsString;
            sCliente := dmDatos.cdsImExportar.FieldByName('cliente').AsString;
            sNumComprob := dmDatos.cdsImExportar.FieldByName('numcomprob').AsString;
            sCajaComprob := dmDatos.cdsImExportar.FieldByName('cajacomprob').AsString;

            with dmDatos.qryModifica do begin
                Close;
                SQL.Clear;
                SQL.Add('SELECT clave FROM clientes WHERE nombre = ''' + sCliente + '''');
                Open;
                if(not Eof) then
                    sCliente := FieldByName('clave').AsString
                else
                    sCliente := 'null';

                Close;
                SQL.Clear;
                SQL.Add('SELECT clave FROM comprobantes WHERE numero = ' + sNumComprob);
                SQL.Add('AND estatus = ''A'' AND tipo = ''D'' AND caja = ' + sCajaComprob);
                Open;
                if(not Eof) then begin
                    sComprobante := FieldByName('clave').AsString;

                    Close;
                    SQL.Clear;
                    SQL.Add('SELECT clave FROM notascredito WHERE numero = ' + sNumero);
                    SQL.Add('AND estatus = ''A''  AND fecha = ''' + sFecha + '''');
                    Open;

                    if(Eof) then begin
                        Close;
                        SQL.Clear;
                        SQL.Add('INSERT INTO notascredito (numero, fecha, cliente,');
                        SQL.Add('importe, estatus, caja, comprobante) VALUES(' + sNumero + ',');
                        SQL.Add('''' + sFecha + ''',' + sCliente + ',' + sImporte + ',');
                        SQL.Add('''' + sEstatus + ''',' + sCaja + ',' + sComprobante + ')');
                        ExecSQL;
                        Close;
                    end;
                end;
                Close;
            end;
        end;
        dmDatos.cdsImExportar.Next;
        barAvance.StepIt;
    end;
    dmDatos.cdsImExportar.Active := false;
    StrStream.Free;
end;

procedure TfrmImportar.btnDirClick(Sender: TObject);
begin
    dlgAbrir.InitialDir := ExtractFilePath(txtRuta.Text);
    if(dlgAbrir.Execute) then
        txtRuta.Text := dlgAbrir.FileName;
    txtRutaExit(Sender);
end;

procedure TfrmImportar.FormCreate(Sender: TObject);
begin
    RecuperaConfig;
end;

procedure TfrmImportar.ImportaCajas;
var
    sNombre, sCaja, sSerieTicket, sSerieNota, sSerieFactura, sFechaUMov : String;
    dteFechaMov : TDateTime;
    i : integer;
begin
    lblTabla.Caption := 'Cajas';
    lblTabla.Refresh;
    for i := 0 to zipArchivo.Count do
        if (zipArchivo.Name[i] = 'cajas.xml') then
            break;

    dmDatos.cdsImExportar.Active := false;
    StrStream := TStringStream.Create(zipArchivo.Data[i]);
    dmDatos.cdsImExportar.LoadFromStream(strStream);
    dmDatos.cdsImExportar.Active := true;
    barAvance.Max := dmDatos.cdsImExportar.RecordCount;
    barAvance.Position := 0;

    sFechaUMov := FormatDateTime('mm/dd/yyyy hh:nn:ss',Now);
    while(not (dmDatos.cdsImExportar.Eof)) do begin
        sCaja := dmDatos.cdsImExportar.FieldByName('numero').AsString;
        sNombre := Trim(dmDatos.cdsImExportar.FieldByName('nombre').AsString);
        sSerieTicket := Trim(dmDatos.cdsImExportar.FieldByName('serieticket').AsString);
        sSerieNota := Trim(dmDatos.cdsImExportar.FieldByName('serienota').AsString);
        sSerieFactura := Trim(dmDatos.cdsImExportar.FieldByName('seriefactura').AsString);
        dteFechaMov := dmDatos.cdsImExportar.FieldByName('fecha_umov').AsDateTime;
        with dmDatos.qryModifica do begin
            Close;
            SQL.Clear;
            SQL.Add('SELECT numero, fecha_umov FROM cajas WHERE numero = ' + sCaja);
            Open;
            if(Eof) then begin
                Close;
                SQL.Clear;
                SQL.Add('INSERT INTO cajas (numero, nombre, serieticket, serienota, seriefactura, fecha_umov) VALUES(');
                SQL.Add(sCaja + ',''' + sNombre + ''',''' + sSerieTicket + ''',''' + sSerieNota + ''',''' + sSerieFactura + ''',''' + sFechaUMov + ''')');
                ExecSQL;
                Close;
            end
            else begin
                // Modifica el registro
                if(dteFechaMov > FieldByName('fecha_umov').AsDateTime) or (rdbReemplazar.Checked) then begin
                    Close;
                    SQL.Clear;
                    SQL.Add('UPDATE cajas SET nombre = ''' + sNombre + ''',');
                    SQL.Add('numero = ' + sCaja + ',');
                    SQL.Add('serieticket = ''' + sSerieTicket + ''',');
                    SQL.Add('serienota = ''' + sSerieNota + ''',');
                    SQL.Add('seriefactura = ''' + sSerieFactura + ''',');
                    SQL.Add('fecha_umov = ''' + sFechaUMov + '''');
                    SQL.Add('WHERE numero = ' + sCaja);
                    ExecSQL;
                    Close;
                end
                else begin
                    Close;
                    SQL.Clear;
                    SQL.Add('UPDATE cajas SET fecha_umov = ''' + sFechaUMov + '''');
                    SQL.Add('WHERE numero = ' + sCaja);
                    ExecSQL;
                    Close;
                end;
            end;
            dmDatos.cdsImExportar.Next;
            barAvance.StepIt;
        end;
    end;
    dmDatos.cdsImExportar.Active := false;
    StrStream.Free;

    if(rdbReemplazar.Checked) then
        //Elimina todo lo que no estaba en la importación
        with dmDatos.qryModifica do begin
            Close;
            SQL.Clear;
            SQL.Add('DELETE FROM cajas WHERE fecha_umov <> ''' + sFechaUMov + '''');
            ExecSQL;
            Close;
        end;
end;

function TfrmImportar.VerificaFechas(sFecha : string):boolean;
var
   dteFecha : TDateTime;
begin
   Result:=true;
   if(not TryStrToDate(sFecha,dteFecha)) then 
      Result:=false;
end;

procedure TfrmImportar.chkVentasClick(Sender: TObject);
begin
    if(chkVentas.Checked) then begin
        txtDiaVentaIni.Visible := true;
        txtMesVentaIni.Visible := true;
        txtAnioVentaIni.Visible := true;
        txtDiaVentaFin.Visible := true;
        txtMesVentaFin.Visible := true;
        txtAnioVentaFin.Visible := true;
        txtDiaVentaIni.SetFocus;
    end
    else begin
        txtDiaVentaIni.Visible := false;
        txtMesVentaIni.Visible := false;
        txtAnioVentaIni.Visible := false;
        txtDiaVentaFin.Visible := false;
        txtMesVentaFin.Visible := false;
        txtAnioVentaFin.Visible := false;
    end;
end;

procedure TfrmImportar.Salta(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
    {Inicio (36), Fin (35), Izquierda (37), derecha (39), arriba (38), abajo (40)}
    if(Key >= 30) and (Key <= 122) and (Key <> 35) and (Key <> 36) and not ((Key >= 37) and (Key <= 40)) then
        if( Length((Sender as TEdit).Text) = (Sender as TEdit).MaxLength) then
            SelectNext(Sender as TWidgetControl, true, true);

end;

procedure TfrmImportar.FormShow(Sender: TObject);
begin
    zipArchivo := TZipFile.Create ;
    txtRutaExit(Sender);
end;

procedure TfrmImportar.txtRutaExit(Sender: TObject);
var
    chkComponente : TCheckBox;
    sComponente : String;
    i : integer;
begin
    if(FileExists(txtRuta.Text)) then begin
        //Desahabilita todos las casillas de verificación
        for i := 0 to grpDatos.ControlCount - 1 do
            if (grpDatos.Controls[i] is TCheckBox) then begin
                (grpDatos.Controls[i] as TCheckBox).Enabled := false;
                (grpDatos.Controls[i] as TCheckBox).Checked := false;
            end;

        zipArchivo.LoadFromFile(txtRuta.Text);
        for i := 0 to zipArchivo.Count -1 do begin
            sComponente := 'chk' + Copy(zipArchivo.Name[i],1,Length(zipArchivo.Name[i]) - 4);
            chkComponente := (FindComponent(sComponente) as TCheckBox);
            if(chkComponente <> nil) then begin
                chkComponente.Enabled := true;
                chkComponente.Checked := true;
            end;
        end;
    end;
end;

procedure TfrmImportar.txtAnioVentaIniExit(Sender: TObject);
begin
    (Sender as TEdit).Text := Trim((Sender as TEdit).Text);
    if(Length((Sender as TEdit).Text) < 4) and (Length((Sender as TEdit).Text) > 0) then
        (Sender as TEdit).Text := IntToStr(StrToInt((Sender as TEdit).Text) + 2000);
end;

procedure TfrmImportar.txtDiaVentaIniExit(Sender: TObject);
begin
    Rellena(Sender);
end;

procedure TfrmImportar.Rellena(Sender: TObject);
var
    i : integer;
begin
    for i := Length((Sender as TEdit).Text) to (Sender as TEdit).MaxLength - 1 do
        (Sender as TEdit).Text := '0' + (Sender as TEdit).Text;
end;


procedure TfrmImportar.ImportaVendedores;
var
    sClave, sRfc, sNombre, sCalle, sColonia, sCp, sLocalidad, sCateg : String;
    sEstado, sFax, sCorreo, sFechaCap, sTelefono, sFechaUMov : String;
    dteFechaMov : TDateTime;
    i : integer;
begin
    lblTabla.Caption := 'Vendedores';
    lblTabla.Refresh;
    for i := 0 to zipArchivo.Count do
        if (zipArchivo.Name[i] = 'Vendedores.xml') then
            break;

    dmDatos.cdsImExportar.Active := false;
    StrStream := TStringStream.Create(zipArchivo.Data[i]);
    dmDatos.cdsImExportar.LoadFromStream(strStream);
    dmDatos.cdsImExportar.Active := true;
    barAvance.Max := dmDatos.cdsImExportar.RecordCount;
    barAvance.Position := 0;
    sFechaUMov := FormatDateTime('mm/dd/yyyy hh:nn:ss',Now);

    while(not (dmDatos.cdsImExportar.Eof)) do begin
        sClave := dmDatos.cdsImExportar.FieldByName('clave').AsString;
        sRfc := Trim(dmDatos.cdsImExportar.FieldByName('rfc').AsString);
        sNombre := Trim(dmDatos.cdsImExportar.FieldByName('nombre').AsString);
        sCalle := Trim(dmDatos.cdsImExportar.FieldByName('calle').AsString);
        sColonia := Trim(dmDatos.cdsImExportar.FieldByName('colonia').AsString);
        sCp := Trim(dmDatos.cdsImExportar.FieldByName('cp').AsString);
        sLocalidad := Trim(dmDatos.cdsImExportar.FieldByName('localidad').AsString);
        sEstado := Trim(dmDatos.cdsImExportar.FieldByName('estado').AsString);
        sFax := Trim(dmDatos.cdsImExportar.FieldByName('fax').AsString);
        sCorreo := Trim(dmDatos.cdsImExportar.FieldByName('ecorreo').AsString);
        sFechaCap := FormatDateTime('mm/dd/yyyy',dmDatos.cdsImExportar.FieldByName('fecha_cap').AsDateTime);
        sTelefono := Trim(dmDatos.cdsImExportar.FieldByName('telefono').AsString);
        sCateg := Trim(dmDatos.cdsImExportar.FieldByName('categoria').AsString);
        dteFechaMov := dmDatos.cdsImExportar.FieldByName('fecha_umov').AsDateTime;

        with dmDatos.qryModifica do begin
            Close;
            SQL.Clear;
            SQL.Add('SELECT clave FROM categorias WHERE nombre = ''' + sCateg + ''' AND tipo = ''V''');
            Open;
            sCateg := FieldByName('clave').AsString;
            if(Length(sCateg) = 0) then
                sCateg := 'null';

            Close;
            SQL.Clear;
            SQL.Add('SELECT clave, fecha_umov FROM vendedores WHERE clave = ' + sClave);
            Open;
            if(Eof) then begin
                Close;
                SQL.Clear;
                SQL.Add('INSERT INTO vendedores (clave, rfc, nombre, calle, colonia, cp,');
                SQL.Add('localidad, estado, fax, ecorreo, fecha_cap,');
                SQL.Add('telefono, fecha_umov, categoria) VALUES(');
                SQL.Add(sClave + ',''' + sRfc + ''',''' + sNombre + ''',''' + sCalle + ''',');
                SQL.Add('''' + sColonia + ''',''' + sCp + ''',''' + sLocalidad + ''',''' + sEstado + ''',');
                SQL.Add('''' + sFax + ''',''' + sCorreo + ''',');
                SQL.Add('''' + sFechaCap + ''',''' + sTelefono + ''',''' + sFechaUMov + ''',' + sCateg + ')');
                ExecSQL;
                Close;
            end
            else begin
                // Modifica el registro
                sClave := FieldByName('clave').AsString;
                if(dteFechaMov > FieldByName('fecha_umov').AsDateTime) or (rdbReemplazar.Checked) then begin
                    Close;
                    SQL.Clear;
                    SQL.Add('UPDATE vendedores SET rfc = ''' + sRfc + ''',');
                    SQL.Add('nombre = ''' + sNombre + ''',');
                    SQL.Add('calle = ''' + sCalle + ''',');
                    SQL.Add('colonia = ''' + sColonia + ''',');
                    SQL.Add('cp = ''' + sCp + ''',');
                    SQL.Add('localidad = ''' + sLocalidad + ''',');
                    SQL.Add('estado = ''' + sEstado + ''',');
                    SQL.Add('fax = ''' + sFax + ''',');
                    SQL.Add('ecorreo = ''' + sCorreo + ''',');
                    SQL.Add('fecha_cap = ''' + sFechaCap + ''',');
                    SQL.Add('telefono = ''' + sTelefono + ''',');
                    SQL.Add('fecha_umov = ''' + sFechaUmov + ''',');
                    SQL.Add('categoria = ' + sCateg);
                    SQL.Add('WHERE clave = ' + sClave);
                    ExecSQL;
                    Close;
                end
                else begin
                    Close;
                    SQL.Clear;
                    SQL.Add('UPDATE vendedores SET fecha_umov = ''' + sFechaUMov + '''');
                    SQL.Add('WHERE clave = ' + sClave);
                    ExecSQL;
                    Close;
                end;
            end;
            dmDatos.cdsImExportar.Next;
            barAvance.StepIt;
        end;
    end;
    dmDatos.cdsImExportar.Active := false;
    StrStream.Free;

    if(rdbReemplazar.Checked) then
        //Elimina todo lo que no estaba en la importación
        with dmDatos.qryModifica do begin
            Close;
            SQL.Clear;
            SQL.Add('DELETE FROM proveedores WHERE fecha_umov <> ''' + sFechaUMov + '''');
            ExecSQL;
            Close;
        end;
end;

procedure TfrmImportar.ImportaCtsXCobrar;
var
    sImporte, sPlazo, sInteres, sIntMoratorio,  sProxPago, sVenta, sOrden : String;
    sTipoInteres, sTipoPlazo, sEstatus, sHora, sFechaUMov, sCaja : String;
    sCliente, sNumPago, sCantIntMorat, sPagado, sFecha, sCantInteres : String;
    sFechaV, sNumero, sTipoPago, sComentario, sClaveXCobrar : String;

    i : integer;
begin
    lblTabla.Caption := 'XCobrar';
    lblTabla.Refresh;
    for i := 0 to zipArchivo.Count do
        if (zipArchivo.Name[i] = 'XCobrar.xml') then
            break;
    dmDatos.cdsImExportar.Active := false;
    StrStream := TStringStream.Create(zipArchivo.Data[i]);
    dmDatos.cdsImExportar.LoadFromStream(strStream);
    dmDatos.cdsImExportar.Active := true;
    barAvance.Max := dmDatos.cdsImExportar.RecordCount;
    barAvance.Position := 0;

    sFechaUMov := FormatDateTime('mm/dd/yyyy hh:nn:ss',Now);
    while(not (dmDatos.cdsImExportar.Eof)) do begin

         sImporte := dmDatos.cdsImExportar.FieldByName('importe').AsString;
         sPlazo := dmDatos.cdsImExportar.FieldByName('plazo').AsString;
         sInteres := dmDatos.cdsImExportar.FieldByName('interes').AsString;
         sIntMoratorio := dmDatos.cdsImExportar.FieldByName('intmoratorio').AsString;
         sProxPago := FormatDateTime('mm/dd/yyyy',dmDatos.cdsImExportar.FieldByName('proximopago').AsDateTime);
         sTipoInteres := dmDatos.cdsImExportar.FieldByName('tipointeres').AsString;
         sTipoPlazo := dmDatos.cdsImExportar.FieldByName('tipoplazo').AsString;
         sEstatus := dmDatos.cdsImExportar.FieldByName('estatus').AsString;
         sCliente:=  dmDatos.cdsImExportar.FieldByName('cliente').AsString;
         sFecha := FormatDateTime('mm/dd/yyyy',dmDatos.cdsImExportar.FieldByName('fecha').AsDateTime);
         sNumPago := dmDatos.cdsImExportar.FieldByName('numpago').AsString;
         sCantIntMorat := dmDatos.cdsImExportar.FieldByName('cantintmorat').AsString;
         sCantInteres := dmDatos.cdsImExportar.FieldByName('cantinteres').AsString;
         sPagado := dmDatos.cdsImExportar.FieldByName('pagado').AsString;
         sHora := FormatDateTime('hh:nn:ss',dmDatos.cdsImExportar.FieldByName('hora').AsDateTime);
         sCaja:= dmDatos.cdsImExportar.FieldByName('caja').AsString;
         sOrden := dmDatos.cdsImExportar.FieldByName('Orden').AsString;

         with dmDatos.qryModifica do begin
            Close;
            SQL.Clear;
            SQL.Add('SELECT clave FROM clientes WHERE nombre = ''' + sCliente + '''');
            Open;
            if(not Eof) then
                sCliente := FieldByName('clave').AsString
            else
                sCliente := 'null';

            Close;
            SQL.Clear;
            SQL.Add('SELECT clave FROM ventas WHERE caja = ' + sCaja + ' AND ');
            SQL.Add('fecha = ''' + sFecha + ''' AND hora = ''' + sHora + '''');
            Open;
            if(not Eof) then begin
                sVenta := FieldByName('clave').AsString;
                Close;
                SQL.Clear;
                SQL.Add('SELECT orden FROM xcobrar WHERE venta = ' + sVenta + ' AND ');
                SQL.Add('orden = ' + sOrden);
                Open;

                if(Eof) then begin
                    Close;
                    SQL.Clear;
                    SQL.Add('INSERT INTO xcobrar (venta, importe, plazo, interes, intmoratorio,');
                    SQL.Add('proximopago, tipointeres, tipoplazo, estatus, cliente, fecha, numpago,');
                    SQL.Add('cantintmorat,cantinteres, pagado, orden )values (');
                    SQL.Add( sVenta +','+ sImporte +','+ sPlazo + ','+sInteres + ','+ sIntMoratorio +',');
                    SQL.Add('''' + sProxPago + ''','''+sTipoInteres+''','+ sTipoPlazo + ','''+ sEstatus+''',');
                    SQL.Add(sCliente+','''+sFecha+''','''+sNumPago+''','+ sCantIntMorat+','+sCantInteres+','+sPagado+','+sOrden+')');
                    ExecSQL;
                end;
            end;
            dmDatos.cdsImExportar.Next;
            barAvance.StepIt;
        end;
    end;

    lblTabla.Caption := 'XCobrar';
    lblTabla.Refresh;
    for i := 0 to zipArchivo.Count do
        if (zipArchivo.Name[i] = 'XCobrarPagos.xml') then
            break;
    dmDatos.cdsImExportar.Active := false;
    StrStream := TStringStream.Create(zipArchivo.Data[i]);
    dmDatos.cdsImExportar.LoadFromStream(strStream);
    dmDatos.cdsImExportar.Active := true;
    barAvance.Max := dmDatos.cdsImExportar.RecordCount;
    barAvance.Position := 0;

    while(not (dmDatos.cdsImExportar.Eof)) do begin
         sOrden := dmDatos.cdsImExportar.FieldByName('orden').AsString;
         sFechaV :=FormatDateTime('mm/dd/yyyy',dmDatos.cdsImExportar.FieldByName('fechav').AsDateTime);
         sHora := FormatDateTime('hh:nn:ss',dmDatos.cdsImExportar.FieldByName('hora').AsDateTime);
         sCaja := dmDatos.cdsImExportar.FieldByName('caja').AsString;
         sNumero :=dmDatos.cdsImExportar.FieldByName('numero').AsString;
         sFecha := FormatDateTime('mm/dd/yyyy',dmDatos.cdsImExportar.FieldByName('fecha').AsDateTime);
         sImporte := dmDatos.cdsImExportar.FieldByName('importe').AsString;
         sInteres := dmDatos.cdsImExportar.FieldByName('interes').AsString;
         sIntMoratorio := dmDatos.cdsImExportar.FieldByName('interesmorat').AsString;
         sTipoPago := dmDatos.cdsImExportar.FieldByName('tipopago').AsString;
         sComentario := dmDatos.cdsImExportar.FieldByName('comentario').AsString;

         with dmDatos.qryModifica do begin

            Close;
            SQL.Clear;
            SQL.Add('SELECT clave FROM tipopago WHERE nombre = ''' + sTipoPago + '''');
            Open;
            if(not Eof) then
                sTipoPago := FieldByName('clave').AsString
            else
                sTipoPago := 'null';

            Close;
            SQL.Clear;
            SQL.Add('SELECT clave FROM ventas WHERE caja = ' + sCaja + ' AND ');
            SQL.Add('fecha = ''' + sFechaV + ''' AND hora = ''' + sHora + '''');
            Open;
            if(not Eof) then begin
                sVenta := FieldByName('clave').AsString;

                Close;
                SQL.Clear;
                SQL.Add('SELECT clave FROM xcobrar WHERE venta = ' + sVenta + ' AND ');
                SQL.Add('orden = ' + sOrden + 'AND fecha=''' + sFechaV + '''');
                Open;

                if(not Eof) then begin
                    sClaveXCobrar := FieldByName('clave').AsString;

                    SQL.Add('SELECT xcobrar FROM xcobrarpagos WHERE xcobrar = ' + sClaveXCobrar + ' AND ');
                    SQL.Add('numero = ' + sNumero);

                    if(Eof) then  begin
                        Close;
                        SQL.Clear;
                        SQL.Add('INSERT INTO xcobrarpagos (xCobrar, numero, fecha, importe, interes, interesmorat,');
                        SQL.Add('tipopago, comentario) values(');
                        SQL.Add( sClaveXCobrar + ',' + sNumero + ','''+sFecha+''','+sImporte + ','+ sInteres+',');
                        SQL.Add( sIntMoratorio + ',' + sTipoPago +',''' +sComentario+''''+')');
                        ExecSQL;
                    end;
                end;
            end;
         end;
         dmDatos.cdsImExportar.Next;
         barAvance.StepIt;
    end;
end;



procedure TfrmImportar.ImportaInventario2;
var
    sFecha, sAplicado, sDescrip, sClave :String;
    sArticulo, sCantidad, sExistencia, sJuego, sCantJuego :String;
    i : integer;
begin
    lblTabla.Caption := 'Inventario';
    lblTabla.Refresh;
    for i := 0 to zipArchivo.Count do
        if (zipArchivo.Name[i] = 'Inventario.xml') then
            break;
    dmDatos.cdsImExportar.Active := false;
    StrStream := TStringStream.Create(zipArchivo.Data[i]);
    dmDatos.cdsImExportar.LoadFromStream(strStream);
    dmDatos.cdsImExportar.Active := true;
    barAvance.Max := dmDatos.cdsImExportar.RecordCount;
    barAvance.Position := 0;

    while(not (dmDatos.cdsImExportar.Eof)) do begin

         sDescrip := dmDatos.cdsImExportar.FieldByName('descrip').AsString;
         sAplicado:=  dmDatos.cdsImExportar.FieldByName('aplicado').AsString;
         sFecha := FormatDateTime('mm/dd/yyyy',dmDatos.cdsImExportar.FieldByName('fecha').AsDateTime);

         with dmDatos.qryModifica do begin

            Close;
            SQL.Clear;
            SQL.Add('SELECT clave FROM inventario WHERE fecha = ''' + sFecha + '''AND');
            SQL.Add('descrip = ''' + sdescrip +'''');
            Open;

            if(Eof) then begin
                Close;
                SQL.Clear;
                SQL.Add('INSERT INTO inventario (fecha, descrip, aplicado) values (');
                SQL.Add('''' + sFecha + ''','''+sDescrip+''','''+ sAplicado + ''')');
                ExecSQL;
            end;
         end;
         dmDatos.cdsImExportar.Next;
         barAvance.StepIt;
    end;

    lblTabla.Caption := 'InventDet';
    lblTabla.Refresh;
    for i := 0 to zipArchivo.Count do
        if (zipArchivo.Name[i] = 'InventDet.xml') then
            break;
    dmDatos.cdsImExportar.Active := false;
    StrStream := TStringStream.Create(zipArchivo.Data[i]);
    dmDatos.cdsImExportar.LoadFromStream(strStream);
    dmDatos.cdsImExportar.Active := true;
    barAvance.Max := dmDatos.cdsImExportar.RecordCount;
    barAvance.Position := 0;

    while(not (dmDatos.cdsImExportar.Eof)) do begin
         sDescrip := dmDatos.cdsImExportar.FieldByName('descrip').AsString;
         sFecha := FormatDateTime('mm/dd/yyyy',dmDatos.cdsImExportar.FieldByName('fecha').AsDateTime);
         sArticulo:= dmDatos.cdsImExportar.FieldByName('codigo').AsString;
         sCantidad := dmDatos.cdsImExportar.FieldByName('cantidad').AsString;
         sExistencia := dmDatos.cdsImExportar.FieldByName('existencia').AsString;
         sJuego := dmDatos.cdsImExportar.FieldByName('juego').AsString;
         sCantJuego := dmDatos.cdsImExportar.FieldByName('cantjuego').AsString;

        with dmDatos.qryModifica do begin

            Close;
            SQL.Clear;
            SQL.Add('SELECT articulo FROM codigos WHERE codigo = ''' + sArticulo + '''');
            Open;
            if(not Eof) then
                sArticulo := FieldByName('articulo').AsString
            else
                sArticulo := 'null';

            Close;
            SQL.Clear;
            SQL.Add('SELECT clave FROM inventario WHERE ');
            SQL.Add('fecha = ''' + sFecha + ''' AND Descrip = ''' + sDescrip + '''');
            Open;
            if(not Eof) then begin
                sClave := FieldByName('clave').AsString;

                Close;
                SQL.Clear;
                SQL.Add('SELECT inventario FROM inventdet WHERE inventario = ' + sClave);
                SQL.add(' AND articulo = ' +  sArticulo);
                Open;

                if(Eof) then  begin
                    Close;
                    SQL.Clear;
                    SQL.Add('INSERT INTO inventdet (inventario, articulo, cantidad, existencia, juego, cantjuego) VALUES(');
                    SQL.Add( sClave + ',' + sArticulo + ',' + sCantidad + ',' + sExistencia + ',''' + sJuego + ''',' + sCantJuego + ')');
                    ExecSQL;
                end;
            end;
         end;
         dmDatos.cdsImExportar.Next;
         barAvance.StepIt;
    end;
end;



procedure TfrmImportar.ImportaCompras;
var
    sCaja, sProveedor, sDocumento, sFecha, sIva, sTotal, sUsuario, sEstatus, sTipoPago, sImporte : String;
    sDescuento, sFechaCap, sTipo, sOrden, sCodigo, sCantidad, sCosto, sCompra, sReferencia : String;
    i: integer ;
begin
    lblTabla.Caption := 'Compras';
    lblTabla.Refresh;
    for i := 0 to zipArchivo.Count do
        if (zipArchivo.Name[i] = 'compras.xml') then
            break;
    dmDatos.cdsImExportar.Active := false;
    StrStream := TStringStream.Create(zipArchivo.Data[i]);
    dmDatos.cdsImExportar.LoadFromStream(strStream);
    dmDatos.cdsImExportar.Active := true;
    barAvance.Max := dmDatos.cdsImExportar.RecordCount;
    barAvance.Position := 0;

    dteFechaIni := StrToDate(txtDiaCompraIni.Text + '/' + txtMesCompraIni.Text + '/' + txtAnioCompraIni.Text);
    dteFechaFin := StrToDate(txtDiaCompraFin.Text + '/' + txtMesCompraFin.Text + '/' + txtAnioCompraFin.Text);

    while(not (dmDatos.cdsImExportar.Eof)) do begin
        dteFecha := dmDatos.cdsImExportar.FieldByName('fecha').AsDateTime;
        if(dteFechaIni <= dteFecha) and (dteFechaFin >= dteFecha) then begin
            sDocumento := dmDatos.cdsImExportar.FieldByName('documento').AsString;
            sFecha := FormatDateTime('mm/dd/yyyy',dmDatos.cdsImExportar.FieldByName('fecha').AsDateTime);
            sEstatus := dmDatos.cdsImExportar.FieldByName('estatus').AsString;
            sFechaCap := FormatDateTime('mm/dd/yyyy',dmDatos.cdsImExportar.FieldByName('fecha_cap').AsDateTime);
            sCaja := dmDatos.cdsImExportar.FieldByName('caja').AsString;

            sProveedor := dmDatos.cdsImExportar.FieldByName('clave').AsString;
            sIva := dmDatos.cdsImExportar.FieldByName('iva').AsString;
            sTotal := dmDatos.cdsImExportar.FieldByName('total').AsString;
            sUsuario := dmDatos.cdsImExportar.FieldByName('login').AsString;
            sDescuento := dmDatos.cdsImExportar.FieldByName('descuento').AsString;
            sTipo := dmDatos.cdsImExportar.FieldByName('tipo').AsString;

            with dmDatos.qryModifica do begin
                Close;
                SQL.Clear;
                SQL.Add('SELECT * FROM compras WHERE documento = ''' + sDocumento + ''' AND');
                SQL.Add('estatus = ''' + sEstatus + ''' AND fecha = ''' + sFecha + ''' AND');
                SQL.Add('fecha_cap = ''' + sFechaCap + ''' AND caja = ' + sCaja);
//                SQL.Add('fecha_cap = ''' + sFechaCap + ''' AND caja = ' + sCaja);
                Open;

                if(Eof) then begin
                    Close;
                    SQL.Clear;
                    SQL.Add('SELECT clave FROM usuarios WHERE login = ''' + sUsuario + '''');
                    Open;
                    if(not Eof) then
                        sUsuario := FieldByName('clave').AsString
                    else
                        sUsuario := 'null';

                    Close;
                    SQL.Clear;
                    SQL.Add('SELECT clave FROM proveedores WHERE clave = ''' + sProveedor + '''');
                    Open;
                    if(Eof) then
                        sProveedor := 'null';

                    Close;
                    SQL.Clear;
                    SQL.Add('INSERT INTO compras (caja, proveedor, documento, fecha, iva, total,');
                    SQL.Add('usuario, estatus, descuento, fecha_cap, tipo) VALUES(');
                    SQL.Add(sCaja + ',' + sProveedor + ',''' + sDocumento + ''',''' + sFecha + ''','+ sIva + ',' + sTotal + ',');
                    SQL.Add(sUsuario + ',''' + sEstatus + ''',' + sDescuento + ',''' + sFechaCap + ''',''' + sTipo + ''')');
                    ExecSQL;
                end;
            end;
         end;
         dmDatos.cdsImExportar.Next;
         barAvance.StepIt;
    end;

    lblTabla.Caption := 'Comprasdet';
    lblTabla.Refresh;
    for i := 0 to zipArchivo.Count do
        if (zipArchivo.Name[i] = 'comprasdet.xml') then
            break;
    dmDatos.cdsImExportar.Active := false;
    StrStream := TStringStream.Create(zipArchivo.Data[i]);
    dmDatos.cdsImExportar.LoadFromStream(strStream);
    dmDatos.cdsImExportar.Active := true;
    barAvance.Max := dmDatos.cdsImExportar.RecordCount;
    barAvance.Position := 0;

    while(not (dmDatos.cdsImExportar.Eof)) do begin
        sCaja := dmDatos.cdsImExportar.FieldByName('caja').AsString;
        sDocumento := dmDatos.cdsImExportar.FieldByName('documento').AsString;
        sFecha := FormatDateTime('mm/dd/yyyy',dmDatos.cdsImExportar.FieldByName('fecha').AsDateTime);
        sFechaCap := FormatDateTime('mm/dd/yyyy',dmDatos.cdsImExportar.FieldByName('fecha_cap').AsDateTime);
        sEstatus := dmDatos.cdsImExportar.FieldByName('estatus').AsString;

        sOrden := dmDatos.cdsImExportar.FieldByName('orden').AsString;
        sCodigo := dmDatos.cdsImExportar.FieldByName('codigo').AsString;
        sCantidad := dmDatos.cdsImExportar.FieldByName('cantidad').AsString;
        sIva := dmDatos.cdsImExportar.FieldByName('iva').AsString;
        sCosto := dmDatos.cdsImExportar.FieldByName('costo').AsString;
        sDescuento := dmDatos.cdsImExportar.FieldByName('descuento').AsString;

        with dmDatos.qryModifica do begin
            Close;
            SQL.Clear;
            SQL.Add('SELECT * FROM compras WHERE documento = ''' + sDocumento + ''' AND');
            SQL.Add('estatus = ''' + sEstatus + ''' AND fecha = ''' + sFecha + ''' AND');
            SQL.Add('caja = ' + sCaja + ' AND fecha_cap = ''' + sFechaCap + '''');
            Open;

            if(not Eof) then begin
                sCompra := FieldByName('clave').AsString;

                Close;
                SQL.Clear;
                SQL.Add('SELECT a.clave FROM articulos a LEFT JOIN ');
                SQL.Add('codigos o ON a.clave = o.articulo WHERE o.codigo = ''' + sCodigo + '''');
                Open;
                if(not Eof) then
                    sCodigo := FieldByName('clave').AsString
                else
                    sCodigo := 'null';

                Close;
                SQL.Clear;
                SQL.Add('SELECT orden FROM comprasdet WHERE compra = ' + sCompra + ' AND ');
                SQL.Add('orden = ' + sOrden);
                Open;

                if(Eof) then begin
                    Close;
                    SQL.Clear;
                    SQL.Add('INSERT INTO comprasdet (compra, orden, articulo, cantidad, costo, iva,');
                    SQL.Add('descuento, fiscal) VALUES(');
                    SQL.Add( sCompra + ',' + sOrden + ',' + sCodigo + ',' + sCantidad + ','+ sCosto + ',');
                    SQL.Add( sIva + ',' + sDescuento + ')');
                    ExecSQL;
                 end;
             end;

         end;
         barAvance.StepIt;
         dmDatos.cdsImExportar.Next;
    end;

    lblTabla.Caption := 'ComprasPago';
    lblTabla.Refresh;
    for i := 0 to zipArchivo.Count do
          if (zipArchivo.Name[i] = 'compraspago.xml') then
             break;
    dmDatos.cdsImExportar.Active := false;
    StrStream := TStringStream.Create(zipArchivo.Data[i]);
    dmDatos.cdsImExportar.LoadFromStream(strStream);
    dmDatos.cdsImExportar.Active := true;
    barAvance.Max := dmDatos.cdsImExportar.RecordCount;
    barAvance.Position := 0;

    while(not (dmDatos.cdsImExportar.Eof)) do begin
        sCaja := dmDatos.cdsImExportar.FieldByName('caja').AsString;
        sDocumento := dmDatos.cdsImExportar.FieldByName('documento').AsString;
        sFecha := FormatDateTime('mm/dd/yyyy',dmDatos.cdsImExportar.FieldByName('fecha').AsDateTime);
        sFechaCap := FormatDateTime('mm/dd/yyyy',dmDatos.cdsImExportar.FieldByName('fecha_cap').AsDateTime);
        sEstatus := dmDatos.cdsImExportar.FieldByName('estatus').AsString;

        sTipoPago := dmDatos.cdsImExportar.FieldByName('nombre').AsString;
        sImporte := dmDatos.cdsImExportar.FieldByName('Importe').AsString;
        sReferencia := dmDatos.cdsImExportar.FieldByName('referencia').AsString;

        with dmDatos.qryModifica do begin
            Close;
            SQL.Clear;
            SQL.Add('SELECT * FROM compras WHERE documento = ''' + sDocumento + ''' AND');
            SQL.Add('estatus = ''' + sEstatus + ''' AND fecha = ''' + sFecha + ''' AND');
            SQL.Add('caja = ' + sCaja + ' AND fecha_cap = ''' + sFechaCap + '''');
            Open;
            if(not Eof) then begin
                sCompra := FieldByName('clave').AsString;

                Close;
                SQL.Clear;
                SQL.Add('SELECT clave FROM tipopago WHERE nombre = ''' + sTipoPago + '''');
                Open;
                if(not Eof) then
                    sTipoPago := FieldByName('clave').AsString
                else
                    sTipoPago := 'null';

                Close;
                SQL.Clear;
                SQL.Add('SELECT * FROM compraspago WHERE compra = ' + sCompra );
                SQL.Add('AND tipopago = ' + sTipoPago + ' AND importe = ' + sImporte);
                Open;
                if(Eof) then begin

                    Close;
                    SQL.Clear;
                    SQL.Add('INSERT INTO compraspago (compra, tipopago, importe, referencia) values(');
                    SQL.Add( sCompra + ',' + sTipopago + ',' + sImporte + ',''' + sReferencia + ''')');
                    ExecSQL;
                end;

             end;
         end;
         barAvance.StepIt;
         dmDatos.cdsImExportar.Next;
    end;
end;

procedure TfrmImportar.chkComprasClick(Sender: TObject);
begin
    if(chkCompras.Checked) then begin
        txtDiaCompraIni.Visible := true;
        txtMesCompraIni.Visible := true;
        txtAnioCompraIni.Visible := true;
        txtDiaCompraFin.Visible := true;
        txtMesCompraFin.Visible := true;
        txtAnioCompraFin.Visible := true;
        label2.Visible:=true;
        label3.Visible:=true;
        label4.Visible:=true;
        label5.Visible:=true;
        label6.Visible:=true;
        txtDiaCompraIni.SetFocus;
    end
    else begin
        txtDiaCompraIni.Visible := false;
        txtMesCompraIni.Visible := false;
        txtAnioCompraIni.Visible := false;
        txtDiaCompraFin.Visible := false;
        txtMesCompraFin.Visible := false;
        label2.Visible:=false;
        label3.Visible:=false;
        label4.Visible:=false;
        label5.Visible:=false;
        label6.Visible:=false;
        txtAnioCompraFin.Visible := false;
    end;
end;

end.
