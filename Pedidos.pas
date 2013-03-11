// --------------------------------------------------------------------------
// Archivo del Proyecto Ventas
// Página del proyecto: http://sourceforge.net/projects/ventas
// --------------------------------------------------------------------------
// Este archivo puede ser distribuido y/o modificado bajo lo terminos de la
// Licencia Pública General versión 2 como es publicada por la Free Software
// Fundation, Inc.
// --------------------------------------------------------------------------

unit Pedidos;

interface

uses
  SysUtils, Types, Classes, Variants, QTypes, QGraphics, QControls, QForms,
  QDialogs, QStdCtrls, QGrids, QDBGrids, QButtons, QExtCtrls, QcurrEdit,
  Inifiles, DB;

type
  TfrmPedidos = class(TForm)
    grdListado: TDBGrid;
    grpBusqueda: TGroupBox;
    chkCliente: TCheckBox;
    txtCliente: TEdit;
    chkPedido: TCheckBox;
    chkFecha: TCheckBox;
    txtDiaIni: TEdit;
    txtMesIni: TEdit;
    txtAnioIni: TEdit;
    lblDiagMes1: TLabel;
    lblDiagDia1: TLabel;
    btnBuscar: TBitBtn;
    btnSeleccionar: TBitBtn;
    btnLimpiar: TBitBtn;
    rdgOrden: TRadioGroup;
    txtPedido: TcurrEdit;
    txtRegistros: TcurrEdit;
    txtDiaFin: TEdit;
    txtMesFin: TEdit;
    txtAnioFin: TEdit;
    lblDiagMes2: TLabel;
    lblDiagDia2: TLabel;
    lblAl: TLabel;
    Label1: TLabel;
    procedure btnBuscarClick(Sender: TObject);
    procedure chkClienteClick(Sender: TObject);
    procedure chkFechaClick(Sender: TObject);
    procedure chkPedidoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnLimpiarClick(Sender: TObject);
    procedure Salta(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnSeleccionarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FClaveVenta : integer;

    function VerificaDatos: boolean;
    procedure RecuperaConfig;
  public
    property ClaveVenta: integer read FClaveVenta;
  end;

var
  frmPedidos: TfrmPedidos;

implementation

uses dm;

{$R *.xfm}

procedure TfrmPedidos.btnBuscarClick(Sender: TObject);
begin
    if(VerificaDatos) then begin
        dmDatos.cdsCliente.Active := false;
        with dmDatos.qryListados do begin
            Close;
            SQL.Clear;
            SQL.Add('SELECT c.venta, c.caja, c.numero, l.nombre, c.fecha, v.hora, v.iva, v.total ');
            SQL.Add('FROM comprobantes c LEFT JOIN clientes l ON c.cliente = l.clave');
            SQL.Add('LEFT JOIN ventas v ON c.venta = v.clave WHERE c.tipo = ''P'' AND v.estatus = ''A''');
            if(chkCliente.Checked) then
                SQL.Add('AND c.cliente IN (SELECT clave FROM clientes WHERE nombre LIKE ''%' + txtCliente.Text + '%'')');
            if(chkFecha.Checked) then begin
                SQL.Add('AND c.fecha >= ''' + txtMesIni.Text + '/' + txtDiaIni.Text + '/' + txtAnioIni.Text + '''');
                SQL.Add('AND c.fecha <= ''' + txtMesFin.Text + '/' + txtDiaFin.Text + '/' + txtAnioFin.Text + '''');
            end;
            if(chkPedido.Checked) then
                SQL.Add('AND c.numero = ' + txtPedido.Text);
            case rdgOrden.ItemIndex of
                0: SQL.Add('ORDER BY l.nombre, c.numero');
                1: SQL.Add('ORDER BY c.fecha, c.numero');
                2: SQL.Add('ORDER BY c.numero');
            end;
            Open;

            with dmDatos.cdsCliente do begin
                Active := true;

                txtRegistros.Value := RecordCount;

                FieldByName('caja').DisplayLabel := 'Caja';
                FieldByName('caja').DisplayWidth := 4;
                FieldByName('numero').DisplayLabel := 'Remisión';
                FieldByName('numero').DisplayWidth := 8;
                FieldByName('nombre').DisplayLabel := 'Cliente';
                FieldByName('nombre').DisplayWidth := 35;
                FieldByName('fecha').DisplayLabel := 'Fecha';
                FieldByName('fecha').DisplayWidth := 10;
                FieldByName('hora').DisplayLabel := 'Hora';
                FieldByName('hora').DisplayWidth := 7;
              //  FieldByName('estatus').DisplayLabel := 'Estatus';
              //  FieldByName('estatus').DisplayWidth := 7;
              //  FieldByName('subtotal').DisplayLabel := 'Subtotal';
              //  FieldByName('subtotal').DisplayWidth := 10;
              //  (FieldByName('subtotal') as TNumericField).DisplayFormat := '#,##0.00';
                FieldByName('iva').DisplayLabel := 'I.V.A.';
                FieldByName('iva').DisplayWidth := 10;
                (FieldByName('iva') as TNumericField).DisplayFormat := '#,##0.00';
                FieldByName('total').DisplayLabel := 'Total';
                FieldByName('total').DisplayWidth := 10;
                (FieldByName('total') as TNumericField).DisplayFormat := '#,##0.00';
              //  FieldByName('cliente').Visible := false;
              //  FieldByName('usuario').Visible := false;
                FieldByName('venta').Visible := False;
            end;

            grdListado.SetFocus;
        end;
    end;
end;

procedure TfrmPedidos.chkClienteClick(Sender: TObject);
begin
    txtCliente.Visible := chkCliente.Checked;
    if(chkCliente.Checked) then
        txtCliente.SetFocus;
end;

procedure TfrmPedidos.chkFechaClick(Sender: TObject);
begin
    txtDiaIni.Visible := chkFecha.Checked;
    txtMesIni.Visible := chkFecha.Checked;
    txtAnioIni.Visible := chkFecha.Checked;
    lblDiagDia1.Visible := chkFecha.Checked;
    lblDiagMes1.Visible := chkFecha.Checked;
    txtDiaFin.Visible := chkFecha.Checked;
    txtMesFin.Visible := chkFecha.Checked;
    txtAnioFin.Visible := chkFecha.Checked;
    lblDiagDia2.Visible := chkFecha.Checked;
    lblDiagMes2.Visible := chkFecha.Checked;
    lblAl.Visible := chkFecha.Checked;
    if(txtDiaIni.Visible) then
        txtDiaIni.SetFocus;
end;

procedure TfrmPedidos.chkPedidoClick(Sender: TObject);
begin
    txtPedido.Visible := chkPedido.Checked;
    if(chkPedido.Checked) then
        txtPedido.SetFocus;
end;

procedure TfrmPedidos.FormShow(Sender: TObject);
begin
    RecuperaConfig;

    chkClienteClick(Sender);
    chkFechaClick(Sender);
    chkPedidoClick(Sender);

    if(dmDatos.cdsCliente.Active) then
        txtRegistros.Value := dmDatos.cdsCliente.RecordCount;
end;

function TfrmPedidos.VerificaDatos: boolean;
var
    dteFecha: TDateTime;
begin
    Result:= true;
    if(not TryStrToDate(txtDiaIni.Text + '/' + txtMesIni.Text + '/' + txtAnioIni.Text, dteFecha)) and (chkfecha.Checked) then begin
        Application.MessageBox('Introduzca una fecha inicial válida','Error',[smbOk]);
        txtDiaIni.SetFocus;
        Result:= false;
    end
    else
        if(not TryStrToDate(txtDiaFin.Text + '/' + txtMesFin.Text + '/' + txtAnioFin.Text, dteFecha)) and (chkfecha.Checked) then begin
            Application.MessageBox('Introduzca una fecha final válida','Error',[smbOk]);
            txtDiaFin.SetFocus;
            Result:= false;
        end;
end;

procedure TfrmPedidos.btnLimpiarClick(Sender: TObject);
begin
    txtCliente.Clear;
    txtDiaIni.Clear;
    txtMesIni.Clear;
    txtAnioIni.Clear;
    txtDiaFin.Clear;
    txtMesFin.Clear;
    txtAnioFin.Clear;
    txtPedido.Value:= 0;
end;

procedure TfrmPedidos.Salta(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
    {Inicio (36), Fin (35), Izquierda (37), derecha (39), arriba (38), abajo (40)}
    if(Key >= 30) and (Key <= 122) and (Key <> 35) and (Key <> 36) and not ((Key >= 37) and (Key <= 40)) then
        if( Length((Sender as TEdit).Text) = (Sender as TEdit).MaxLength) then
            SelectNext(Sender as TWidgetControl, true, true);
end;

procedure TfrmPedidos.btnSeleccionarClick(Sender: TObject);
begin
    if(txtRegistros.Value > 0) then
    begin
        FClaveVenta:= dmDatos.cdsCliente.FieldByName('venta').AsInteger;
        ModalResult:= mrOk;
    end;
end;

procedure TfrmPedidos.FormClose(Sender: TObject; var Action: TCloseAction);
var
    iniArchivo : TIniFile;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'config.ini');
    with iniArchivo do begin
        // Registra la posición y de la ventana
        WriteString('Pedidos', 'Posy', IntToStr(Top));

        // Registra la posición X de la ventana
        WriteString('Pedidos', 'Posx', IntToStr(Left));

        //Registra el valor de los botones de radio de orden
        WriteString('Pedidos', 'Orden', IntToStr(rdgOrden.ItemIndex));

        if(chkCliente.Checked) then
            WriteString('Pedidos', 'Cliente', 'S')
        else
            WriteString('Pedidos', 'Cliente', 'N');

        if(chkFecha.Checked) then
            WriteString('Pedidos', 'Fecha', 'S')
        else
            WriteString('Pedidos', 'Fecha', 'N');

        if(chkPedido.Checked) then
            WriteString('Pedidos', 'Pedido', 'S')
        else
            WriteString('Pedidos', 'Pedido', 'N');

        Free;
   end;
   dmDatos.qryListados.Close;
   dmDatos.cdsCliente.Active := false;
end;

procedure TfrmPedidos.RecuperaConfig;
var
    iniArchivo : TIniFile;
    sIzq, sArriba, sValor : String;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'config.ini');

    with iniArchivo do begin
        //Recupera la posición Y de la ventana
        sArriba := ReadString('Pedidos', 'Posy', '');

        //Recupera la posición X de la ventana
        sIzq := ReadString('Pedidos', 'Posx', '');

        if (Length(sIzq) > 0) and (Length(sArriba) > 0) then begin
            Left := StrToInt(sIzq);
            Top := StrToInt(sArriba);
        end;

        //Recupera el valor de los botones de radio de orden
        sValor := ReadString('Pedidos', 'Orden', '');

        if (Length(sValor) > 0) then
            rdgOrden.ItemIndex := StrToInt(sValor);

        sValor := ReadString('Pedidos', 'Cliente', '');
        if (sValor = 'S') then
            chkCliente.Checked := true
        else
            chkCliente.Checked := false;

        sValor := ReadString('Pedidos', 'Fecha', '');
        if (sValor = 'S') then
            chkFecha.Checked := true
        else
            chkFecha.Checked := false;

        sValor := ReadString('Pedidos', 'Pedido', '');
        if (sValor = 'S') then
            chkPedido.Checked := true
        else
            chkPedido.Checked := false;
        Free;
    end;
end;

end.
