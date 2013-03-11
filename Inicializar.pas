// --------------------------------------------------------------------------
// Archivo del Proyecto Ventas
// P�gina del proyecto: http://sourceforge.net/projects/ventas
// --------------------------------------------------------------------------
// Este archivo puede ser distribuido y/o modificado bajo lo terminos de la
// Licencia P�blica General versi�n 2 como es publicada por la Free Software
// Fundation, Inc.
// --------------------------------------------------------------------------

unit Inicializar;

interface

uses
  SysUtils, Types, Classes, QGraphics, QControls, QForms, QDialogs,
  QStdCtrls, QButtons, IniFiles;

type
  TfrmInicializa = class(TForm)
    grpDatos: TGroupBox;
    chkComprobantes: TCheckBox;
    chkProveedores: TCheckBox;
    chkUsuarios: TCheckBox;
    chkTiposPago: TCheckBox;
    chkAreasVenta: TCheckBox;
    chkDescuentos: TCheckBox;
    chkVentas: TCheckBox;
    chkDepartamentos: TCheckBox;
    chkCompras: TCheckBox;
    chkClientes: TCheckBox;
    chkCategorias: TCheckBox;
    chkExistencias: TCheckBox;
    chkArticulos: TCheckBox;
    chkVentasPendientes: TCheckBox;
    chkCortes: TCheckBox;
    chkRetiros: TCheckBox;
    btnAceptar: TBitBtn;
    btnCancelar: TBitBtn;
    chkEmpresa: TCheckBox;
    chkCajas: TCheckBox;
    chkTicket: TCheckBox;
    txtDiaIni: TEdit;
    txtMesIni: TEdit;
    txtAnioIni: TEdit;
    lblDiagDia1: TLabel;
    lblDiagMes1: TLabel;
    txtDiaFin: TEdit;
    txtMesFin: TEdit;
    txtAnioFin: TEdit;
    lblDiagDia2: TLabel;
    lblDiagMes2: TLabel;
    lblAl: TLabel;
    chkXCobrar: TCheckBox;
    chkXPagar: TCheckBox;
    chkInventario: TCheckBox;
    procedure btnAceptarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure chkVentasClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Salta(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure txtAnioIniExit(Sender: TObject);
    procedure txtAnioFinExit(Sender: TObject);
    procedure txtDiaIniExit(Sender: TObject);
  private
    procedure IniArticulos;
    procedure IniExistencias;
    procedure IniCategorias;
    procedure IniClientes;
    procedure IniCompras;
    procedure IniDepartamentos;
    procedure IniProveedores;
    procedure IniUsuarios;
    procedure IniAreasVenta;
    procedure IniDescuentos;
    procedure IniVentas;
    procedure IniVentasPendientes;
    procedure RecuperaConfig;
    procedure IniComprobantes;
    procedure IniRetiros;
    procedure IniTiposPago;
    procedure IniCortes;
    procedure IniEmpresa;
    procedure IniCajas;
    procedure IniTicket;
    procedure IniXCobrar;
    procedure IniXPagar;
    function VerificaDatos:boolean;
    function VerificaFechas(sFecha : string):boolean;
    procedure Rellena(Sender: TObject);
    procedure IniInventario;
  public
  end;

var
  frmInicializa: TfrmInicializa;

implementation

uses dm;

{$R *.xfm}

procedure TfrmInicializa.btnAceptarClick(Sender: TObject);
begin
    if(VerificaDatos) then
        if(Application.MessageBox('Advertencia: esta operaci�n es irreversible, �Deseas continuar?','Inicializar',[smbOK]+[smbCancel],smsWarning) = smbOK) then begin
            if(chkAreAsVenta.Checked) then
                IniAreasVenta;
            if(chkArticulos.Checked) then
                IniArticulos;
            if(chkExistencias.Checked) then
                IniExistencias;
            if(chkCajas.Checked) then
                IniCajas;
            if(chkCategorias.Checked) then
                IniCategorias;
            if(chkClientes.Checked) then
                IniClientes;
            if(chkCompras.Checked) then
                IniCompras;
            if(chkComprobantes.Checked) then
                IniComprobantes;
            if(chkCortes.Checked) then
                IniCortes;
            if(chkDescuentos.Checked) then
                IniDescuentos;
            if(chkDepartamentos.Checked) then
                IniDepartamentos;
            if(chkEmpresa.Checked) then
                IniEmpresa;
            if(chkProveedores.Checked) then
                IniProveedores;
            if(chkRetiros.Checked) then
                IniRetiros;
            if(chkUsuarios.Checked) then
                IniUsuarios;
            if(chkTicket.Checked) then
                IniTicket;
            if(chkTiposPago.Checked) then
                IniTiposPago;
            if(chkVentas.Checked) then
                IniVentas;
            if(chkVentasPendientes.Checked) then
                IniVentaspendientes;
            if(chkXCobrar.Checked) then
                IniXCobrar;
            if(chkXPagar.Checked) then
                IniXPagar;
            if(chkInventario.Checked) then
                IniInventario;
            Application.MessageBox('Finaliz� la operaci�n','Inicializar');
        end;
end;

procedure TfrmInicializa.IniArticulos;
begin
    with dmDatos.qryModifica do begin
        Close;
        SQL.Clear;
        SQL.Add('DELETE FROM articulos');
        ExecSQL;
        Close;
    end;
end;

procedure TfrmInicializa.IniExistencias;
begin
    with dmDatos.qryModifica do begin
        Close;
        SQL.Clear;
        SQL.Add('UPDATE articulos SET existencia = 0');
        ExecSQL;
        Close;
    end;
end;

procedure TfrmInicializa.IniInventario;
begin
    with dmDatos.qryModifica do begin
        Close;
        SQL.Clear;
        SQL.Add('DELETE FROM inventario');
        ExecSQL;
        Close;
    end;
end;

procedure TfrmInicializa.IniCajas;
begin
    with dmDatos.qryModifica do begin
        Close;
        SQL.Clear;
        SQL.Add('DELETE FROM cajas');
        ExecSQL;
        Close;
    end;
end;

procedure TfrmInicializa.IniCategorias;
begin
    with dmDatos.qryModifica do begin
        Close;
        SQL.Clear;
        SQL.Add('DELETE FROM categorias');
        ExecSQL;
        Close;
    end;
end;

procedure TfrmInicializa.IniClientes;
begin
    with dmDatos.qryModifica do begin
        Close;
        SQL.Clear;
        SQL.Add('DELETE FROM clientes');
        ExecSQL;
        Close;
    end;
end;

procedure TfrmInicializa.IniCompras;
begin
    with dmDatos.qryModifica do begin
        Close;
        SQL.Clear;
        SQL.Add('DELETE FROM compras');
        ExecSQL;
        Close;
    end;
end;

procedure TfrmInicializa.IniComprobantes;
begin
    with dmDatos.qryModifica do begin
        Close;
        SQL.Clear;
        SQL.Add('DELETE FROM comprobantes');
        ExecSQL;
        Close;
    end;
end;

procedure TfrmInicializa.IniDepartamentos;
begin
    with dmDatos.qryModifica do begin
        Close;
        SQL.Clear;
        SQL.Add('DELETE FROM departamentos');
        ExecSQL;
        Close;
    end;
end;

procedure TfrmInicializa.IniEmpresa;
begin
    with dmDatos.qryModifica do begin
        Close;
        SQL.Clear;
        SQL.Add('DELETE FROM empresa');
        ExecSQL;
        Close;
    end;
end;

procedure TfrmInicializa.IniRetiros;
begin
    with dmDatos.qryModifica do begin
        Close;
        SQL.Clear;
        SQL.Add('DELETE FROM retiros');
        ExecSQL;
        Close;
    end;
end;

procedure TfrmInicializa.IniTiposPago;
begin
    with dmDatos.qryModifica do begin
        Close;
        SQL.Clear;
        SQL.Add('DELETE FROM tipopago');
        ExecSQL;
        Close;
    end;
end;

procedure TfrmInicializa.IniProveedores;
begin
    with dmDatos.qryModifica do begin
        Close;
        SQL.Clear;
        SQL.Add('DELETE FROM proveedores');
        ExecSQL;
        Close;
    end;
end;
procedure TfrmInicializa.IniUsuarios;
begin
    with dmDatos.qryModifica do begin
        Close;
        SQL.Clear;
        SQL.Add('DELETE FROM usuarios');
        ExecSQL;
        Close;
    end;
end;
procedure TfrmInicializa.IniAreasVenta;
begin
    with dmDatos.qryModifica do begin
        Close;
        SQL.Clear;
        SQL.Add('DELETE FROM areasventa');
        ExecSQL;
        Close;
    end;
end;

procedure TfrmInicializa.IniDescuentos;
begin
    with dmDatos.qryModifica do begin
        Close;
        SQL.Clear;
        SQL.Add('DELETE FROM descuentos');
        ExecSQL;
        Close;
    end;
end;

procedure TfrmInicializa.IniVentas;
begin
    with dmDatos.qryModifica do begin
        Close;
        SQL.Clear;
        SQL.Add('DELETE FROM ventas WHERE fecha >= ''' + txtMesIni.Text + '/' + txtDiaIni.Text + '/' + txtAnioIni.Text + '''');
        SQL.Add('AND fecha <= ''' + txtMesFin.Text + '/' + txtDiaFin.Text + '/' + txtAnioFin.Text + '''');
        ExecSQL;
        Close;
    end;
end;

procedure TfrmInicializa.IniTicket;
begin
    with dmDatos.qryModifica do begin
        Close;
        SQL.Clear;
        SQL.Add('DELETE FROM ticket');
        ExecSQL;
        Close;
    end;
end;

procedure TfrmInicializa.IniVentasPendientes;
begin
    with dmDatos.qryModifica do begin
        Close;
        SQL.Clear;
        SQL.Add('DELETE FROM ventasareas');
        ExecSQL;
        Close;
    end;
end;

procedure TfrmInicializa.IniCortes;
begin
    with dmDatos.qryModifica do begin
        Close;
        SQL.Clear;
        SQL.Add('DELETE FROM cortes');
        ExecSQL;
        Close;
    end;
end;

procedure TfrmInicializa.IniXCobrar;
begin
    with dmDatos.qryModifica do begin
        Close;
        SQL.Clear;
        SQL.Add('DELETE FROM xcobrar');
        ExecSQL;
        Close;
    end;
end;

procedure TfrmInicializa.IniXPagar;
begin
    with dmDatos.qryModifica do begin
        Close;
        SQL.Clear;
        SQL.Add('DELETE FROM xpagar');
        ExecSQL;
        Close;
    end;
end;

procedure TfrmInicializa.FormClose(Sender: TObject;
  var Action: TCloseAction);
  var
     iniArchivo : TIniFile;
begin

    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'config.ini');
    with iniArchivo do begin
        // Registra la posici�n y de la ventana
        WriteString('Inicializa', 'Posy', IntToStr(Top));

        // Registra la posici�n X de la ventana
        WriteString('Inicializa', 'Posx', IntToStr(Left));

        Free;
    end;
end;

procedure TfrmInicializa.RecuperaConfig;
var
    iniArchivo : TIniFile;
    sIzq, sArriba : String;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'config.ini');

    with iniArchivo do begin
        //Recupera la posici�n Y de la ventana
        sArriba := ReadString('Inicializa', 'Posy', '');

        //Recupera la posici�n X de la ventana
        sIzq := ReadString('Inicializa', 'Posx', '');

        if (Length(sIzq) > 0) and (Length(sArriba) > 0) then begin
            Left := StrToInt(sIzq);
            Top := StrToInt(sArriba);
        end;
        Free;
    end;
end;

procedure TfrmInicializa.FormCreate(Sender: TObject);
begin
    RecuperaConfig;
end;

procedure TfrmInicializa.chkVentasClick(Sender: TObject);
begin
    if(chkVentas.Checked) then begin
        lblDiagDia1.Visible := true;
        lblDiagMes1.Visible := true;
        lblDiagDia2.Visible := true;
        lblDiagMes2.Visible := true;
        lblAl.Visible := true;

        txtDiaIni.Visible := true;
        txtMesIni.Visible := true;
        txtAnioIni.Visible := true;
        txtDiaFin.Visible := true;
        txtMesFin.Visible := true;
        txtAnioFin.Visible := true;
        txtDiaIni.SetFocus;
    end
    else begin
        lblDiagDia1.Visible := false;
        lblDiagMes1.Visible := false;
        lblDiagDia2.Visible := false;
        lblDiagMes2.Visible := false;
        lblAl.Visible := false;

        txtDiaIni.Visible := false;
        txtMesIni.Visible := false;
        txtAnioIni.Visible := false;
        txtDiaFin.Visible := false;
        txtMesFin.Visible := false;
        txtAnioFin.Visible := false;
    end;
end;

procedure TfrmInicializa.FormShow(Sender: TObject);
begin
    chkVentasClick(Sender);
end;

function TfrmInicializa.VerificaDatos:boolean;
var
    dteFechaIni, dteFechaFin : TDateTime;
begin
    Result := true;
    if(chkVentas.Checked) then begin
        if (not VerificaFechas(txtDiaIni.Text + '/' + txtMesIni.Text + '/' + txtAnioIni.Text)) then begin
            Application.MessageBox('Introduce un fecha inicial v�lida para las ventas','Error',[smbOK],smsCritical);
            txtDiaIni.SetFocus;
            Result := false;
        end
        else if (not VerificaFechas(txtDiaFin.Text + '/' + txtMesFin.Text + '/' + txtAnioFin.Text)) then begin
            Application.MessageBox('Introduce un fecha final v�lida para las ventas','Error',[smbOK],smsCritical);
            txtDiaFin.SetFocus;
            Result := false;
        end;
        if(Result) then begin
            dteFechaIni := StrToDate(txtDiaIni.Text + '/' + txtMesIni.Text + '/' + txtAnioIni.Text);
            dteFechaFin := StrToDate(txtDiaFin.Text + '/' + txtMesFin.Text + '/' + txtAnioFin.Text);
            if(dteFechaIni > dteFechaFin) then begin
                Application.MessageBox('La fecha final debe ser mayor o igual que la fecha inicial','Error',[smbOK],smsCritical);
                txtDiaIni.SetFocus;
                Result := false;
            end;
        end;
    end;
end;

function TfrmInicializa.VerificaFechas(sFecha : string):boolean;
var
   dteFecha : TDateTime;
begin
   Result:=true;
   if(not TryStrToDate(sFecha,dteFecha)) then 
      Result:=false;
end;

procedure TfrmInicializa.Salta(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    {Inicio (36), Fin (35), Izquierda (37), derecha (39), arriba (38), abajo (40)}
    if(Key >= 30) and (Key <= 122) and (Key <> 35) and (Key <> 36) and not ((Key >= 37) and (Key <= 40)) then
        if( Length((Sender as TEdit).Text) = (Sender as TEdit).MaxLength) then
            SelectNext(Sender as TWidgetControl, true, true);
end;

procedure TfrmInicializa.txtAnioIniExit(Sender: TObject);
begin
    txtAnioIni.Text := Trim(txtAnioIni.Text);
    if(Length(txtAnioIni.Text) < 4) and (Length(txtAnioIni.Text) > 0) then
        txtAnioIni.Text := IntToStr(StrToInt(txtAnioIni.Text) + 2000);
end;

procedure TfrmInicializa.txtAnioFinExit(Sender: TObject);
begin
    txtAnioFin.Text := Trim(txtAnioFin.Text);
    if(Length(txtAnioFin.Text) < 4) and (Length(txtAnioFin.Text) > 0) then
        txtAnioFin.Text := IntToStr(StrToInt(txtAnioFin.Text) + 2000);
end;

procedure TfrmInicializa.txtDiaIniExit(Sender: TObject);
begin
    Rellena(Sender)
end;
procedure TfrmInicializa.Rellena(Sender: TObject);
var
    i : integer;
begin
    for i := Length((Sender as TEdit).Text) to (Sender as TEdit).MaxLength - 1 do
        (Sender as TEdit).Text := '0' + (Sender as TEdit).Text;
end;

end.
