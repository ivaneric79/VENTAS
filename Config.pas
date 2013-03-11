// --------------------------------------------------------------------------
// Archivo del Proyecto Ventas 
// Página del proyecto: http://sourceforge.net/projects/ventas
// --------------------------------------------------------------------------
// Este archivo puede ser distribuido y/o modificado bajo lo terminos de la
// Licencia Pública General versión 2 como es publicada por la Free Software
// Fundation, Inc.
// --------------------------------------------------------------------------

unit Config;

interface

uses
  SysUtils, Types, Classes, QGraphics, QControls, QForms, QDialogs, QStdCtrls,
  QComCtrls, QButtons, QcurrEdit, IniFiles, QImgList;

type
  TfrmConfig = class(TForm)
    pgeGeneral: TPageControl;
    tabComprobantes: TTabSheet;
    dlgAbrir: TOpenDialog;
    grpConsecutivos: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    cmbFacturaGlobal: TComboBox;
    cmbNotaGlobal: TComboBox;
    cmbTicketGlobal: TComboBox;
    cmbAjusteGlobal: TComboBox;
    cmbCotizaGlobal: TComboBox;
    btnCancelar: TBitBtn;
    tabGeneral: TTabSheet;
    grpCaja: TGroupBox;
    Label11: TLabel;
    grpRedondeo: TGroupBox;
    Label12: TLabel;
    txtMoneda: TcurrEdit;
    grpPrecio: TGroupBox;
    Label14: TLabel;
    txtPrecio: TcurrEdit;
    grpCodigos: TGroupBox;
    chkCodigo: TCheckBox;
    grpVentas: TGroupBox;
    Label15: TLabel;
    cmbAreas: TComboBox;
    tabReportesVentas: TTabSheet;
    grpCopias: TGroupBox;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    txtCopiFact: TcurrEdit;
    txtCopiNota: TcurrEdit;
    txtCopiTicket: TcurrEdit;
    txtCopiAjuste: TcurrEdit;
    txtCopiCotiza: TcurrEdit;
    tabDispositivos: TTabSheet;
    grpImpresora: TGroupBox;
    Label24: TLabel;
    txtPuertoTicket: TEdit;
    Label25: TLabel;
    Label26: TLabel;
    txtIniTicket: TEdit;
    txtCortaTicket: TEdit;
    Label27: TLabel;
    txtFinTicket: TEdit;
    grpCajon: TGroupBox;
    Label28: TLabel;
    txtPuertoCajon: TEdit;
    txtAbrirCajon: TEdit;
    Label29: TLabel;
    cmbCaja: TComboBox;
    tabDescuentos: TTabSheet;
    grpDescuentos: TGroupBox;
    lstAceptados: TListBox;
    lstNoAceptados: TListBox;
    Label62: TLabel;
    Label63: TLabel;
    btnDer: TBitBtn;
    btnIzq: TBitBtn;
    grp0: TGroupBox;
    txtArtRepCodigo: TEdit;
    btnArtRepCodigo: TBitBtn;
    txtArtRepCategoria: TEdit;
    btnArtRepCategoria: TBitBtn;
    Label46: TLabel;
    Label48: TLabel;
    Label50: TLabel;
    txtArtRepDepartamento: TEdit;
    btnArtRepDepartamento: TBitBtn;
    Label51: TLabel;
    txtArtRepDescripcion: TEdit;
    btnArtRepDescripcion: TBitBtn;
    Label52: TLabel;
    txtArtRepProveedor1: TEdit;
    btnArtRepProveedor1: TBitBtn;
    Label34: TLabel;
    txtArtRepProveedor2: TEdit;
    btnArtRepProveedor2: TBitBtn;
    grp6: TGroupBox;
    Label42: TLabel;
    txtVtaRepCorte: TEdit;
    btnVtaRepCorte: TBitBtn;
    Label43: TLabel;
    txtVtaRepCompFiscal: TEdit;
    btnVtaRepCompFiscal: TBitBtn;
    Label44: TLabel;
    txtVtaRepHora: TEdit;
    btnVtaRepHora: TBitBtn;
    Label33: TLabel;
    txtVtaRepOperacion: TEdit;
    btnVtaRepOperacion: TBitBtn;
    grp4: TGroupBox;
    grp1: TGroupBox;
    Label35: TLabel;
    Label36: TLabel;
    txtCatRepCategorias: TEdit;
    btnCatRepCategorias: TBitBtn;
    Label37: TLabel;
    txtCatRepClientes: TEdit;
    btnCatRepClientes: TBitBtn;
    Label38: TLabel;
    txtCatRepDepartamentos: TEdit;
    btnCatRepDepartamentos: TBitBtn;
    txtCatRepProveedores: TEdit;
    btnCatRepProveedores: TBitBtn;
    grp7: TGroupBox;
    Label39: TLabel;
    txtVtaRepCaja: TEdit;
    btnVtaRepCaja: TBitBtn;
    Label40: TLabel;
    txtVtaRepArea: TEdit;
    btnVtaRepArea: TBitBtn;
    txtVtaRepCodigo: TEdit;
    btnVtaRepCodigo: TBitBtn;
    txtVtaRepCategoria: TEdit;
    btnVtaRepCategoria: TBitBtn;
    Label41: TLabel;
    txtVtaRepCliente: TEdit;
    btnVtaRepCliente: TBitBtn;
    Label49: TLabel;
    Label53: TLabel;
    Label54: TLabel;
    txtVtaRepUsuario: TEdit;
    btnVtaRepUsuario: TBitBtn;
    Label56: TLabel;
    txtVtaRepDepartamento: TEdit;
    btnVtaRepDepartamento: TBitBtn;
    Label57: TLabel;
    txtVtaRepDescripcion: TEdit;
    btnVtaRepDescripcion: TBitBtn;
    Label58: TLabel;
    txtVtaRepProveedor: TEdit;
    btnVtaRepProveedor: TBitBtn;
    grp2: TGroupBox;
    lblCaja: TLabel;
    lblCategoria: TLabel;
    Label65: TLabel;
    Label66: TLabel;
    Label67: TLabel;
    Label68: TLabel;
    Label69: TLabel;
    Label70: TLabel;
    txtCmpRepCaja: TEdit;
    txtCmpRepCategoria: TEdit;
    txtCmpRepCodigo: TEdit;
    txtCmpRepDepartamento: TEdit;
    txtCmpRepDescripcion: TEdit;
    txtCmpRepDocumento: TEdit;
    txtCmpRepProveedor: TEdit;
    txtCmpRepUsuario: TEdit;
    btnCmpRepCaja: TBitBtn;
    btnCmpRepCategoria: TBitBtn;
    btnCmpRepCodigo: TBitBtn;
    btnCmpRepDepartamento: TBitBtn;
    btnCmpRepDescripcion: TBitBtn;
    btnCmpRepDocumento: TBitBtn;
    btnCmpRepProveedor: TBitBtn;
    btnCmpRepUsuario: TBitBtn;
    arbReportes: TTreeView;
    grp3: TGroupBox;
    Label2: TLabel;
    txtCmbRepFactura: TEdit;
    btnCmbRepFactura: TBitBtn;
    Label3: TLabel;
    txtCmbRepNota: TEdit;
    btnCmbRepNota: TBitBtn;
    Label10: TLabel;
    txtCmbRepAjuste: TEdit;
    btnCmbRepAjuste: TBitBtn;
    Label4: TLabel;
    txtCmbRepCotizacion: TEdit;
    btnCmbRepCotizacion: TBitBtn;
    Label64: TLabel;
    txtCmbRepRetiro: TEdit;
    btnCmbRepRetiro: TBitBtn;
    Label55: TLabel;
    txtCmbRepCancelacion: TEdit;
    btnCmbRepCancelacion: TBitBtn;
    txtVarRepCobranza: TEdit;
    Label1: TLabel;
    btnVarRepCobranza: TBitBtn;
    Label16: TLabel;
    txtVarRepPagosGenerales: TEdit;
    btnVarRepPagosGenerales: TBitBtn;
    Label17: TLabel;
    txtVarRepCreditosVencidos: TEdit;
    btnVarRepCreditosVencidos: TBitBtn;
    Label30: TLabel;
    txtVarRepPagosVencidos: TEdit;
    btnVarRepPagosVencidos: TBitBtn;
    imgImagenes: TImageList;
    btnAplicar: TBitBtn;
    btnAceptar: TBitBtn;
    Label61: TLabel;
    txtVarRepComprobantes: TEdit;
    btnVarRepComprobantes: TBitBtn;
    grp5: TGroupBox;
    txtInvRepAjuste: TEdit;
    Label45: TLabel;
    Label47: TLabel;
    txtInvRepPedidos: TEdit;
    btnInvRepAjuste: TBitBtn;
    btnInvRepPedidos: TBitBtn;
    Label31: TLabel;
    txtInvRepConteo: TEdit;
    btnInvRepConteo: TBitBtn;
    Label32: TLabel;
    cmbDevolucionGlobal: TComboBox;
    Label59: TLabel;
    txtCopiDevolucion: TcurrEdit;
    Label60: TLabel;
    txtCmbRepDevolucion: TEdit;
    btnCmbRepDevolucion: TBitBtn;
    Label71: TLabel;
    txtInvRepValor: TEdit;
    btnInvRepValor: TBitBtn;
    Label72: TLabel;
    cmbNotaCredGlobal: TComboBox;
    Label73: TLabel;
    txtCopiNotaCred: TcurrEdit;
    Label74: TLabel;
    txtCmbRepNotCred: TEdit;
    btnCmbRepNotCred: TBitBtn;
    grpCompras: TGroupBox;
    Label75: TLabel;
    cmbCompCompras: TComboBox;
    Label23: TLabel;
    cmbComprobantes: TComboBox;
    Label13: TLabel;
    cmbTipoPago: TComboBox;
    chkCantidad: TCheckBox;
    chkCodigoEnter: TCheckBox;
    cmbPagoCompras: TComboBox;
    Label76: TLabel;
    chkCantCompras: TCheckBox;
    chkEnterCompras: TCheckBox;
    cmbPedidoGlobal: TComboBox;
    Label77: TLabel;
    Label78: TLabel;
    txtCopiPedido: TcurrEdit;
    Label79: TLabel;
    txtRepPedido: TEdit;
    btnRepPedido: TBitBtn;
    chkCantidadNegativa: TCheckBox;
    Label80: TLabel;
    txtCatRepUnidades: TEdit;
    btnCatRepUnidades: TBitBtn;
    Label81: TLabel;
    txtDirReportes: TEdit;
    chkLimiteCred: TCheckBox;
    chkAgrupar: TCheckBox;
    Label82: TLabel;
    civa: TEdit;
    Label83: TLabel;
    rfc: TEdit;
    usuario: TEdit;
    password: TEdit;
    Label84: TLabel;
    Label85: TLabel;
    Label86: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnAplicarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BuscaReporte(Sender: TObject);
    procedure btnDerClick(Sender: TObject);
    procedure btnIzqClick(Sender: TObject);
    procedure arbReportesItemClick(Sender: TObject; Button: TMouseButton;
      Node: TTreeNode; const Pt: TPoint);
  private
    sCaja, sArea, sTipoPago, sPagoCompras, sComprobante, sCompCompras, sGrupoActual : string;
    procedure RecuperaConfig;
    function VerificaDatos:boolean;

    procedure GuardaDatos;
    procedure RecuperaCajas;
    procedure RecuperaAreas;
    procedure RecuperaTipoPago;
    procedure RecuperaDatos;
    procedure RecuperaComprobantes;
    function BuscaClaveArea(sNombre : String) : String;
    function BuscaClavePago(sNombre : String) : String;
    procedure RecuperaPagosDesc;
    procedure GuardaDescuentoPago;
  public
  end;

var
  frmConfig: TfrmConfig;

implementation

uses dm, funciones;

{$R *.xfm}

procedure TfrmConfig.FormShow(Sender: TObject);
begin
    RecuperaDatos;

    RecuperaCajas;
    RecuperaTipoPago;
    RecuperaAreas;
    RecuperaComprobantes;
    RecuperaPagosDesc;

    arbReportes.FullExpand;
end;

procedure TfrmConfig.FormCreate(Sender: TObject);
begin
    RecuperaConfig;
end;

procedure TfrmConfig.RecuperaConfig;
var
    iniArchivo : TIniFile;
    sIzq, sArriba, sValor : String;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'config.ini');

    with iniArchivo do begin
        //Recupera la posición Y de la ventana
        sArriba := ReadString('Config', 'Posy', '');

        //Recupera la posición X de la ventana
        sIzq := ReadString('Config', 'Posx', '');

        if (Length(sIzq) > 0) and (Length(sArriba) > 0) then begin
            Left := StrToInt(sIzq);
            Top := StrToInt(sArriba);
        end;
        //Recupera la ultima ficha que se selecciono
        sValor := ReadString('Config', 'Ficha', '');
        if (Length(sValor) > 0) then
            pgeGeneral.ActivePageIndex := StrToInt(sValor);

        //Recupera el número de caja
        sValor := ReadString('Config', 'Caja', '');
        if (Length(sValor) > 0) then
            sCaja := sValor
        else
            sCaja := '1';

        //Recupera el área de venta por defecto
        sValor := ReadString('Config', 'AreaVenta', '');
        if (Length(sValor) > 0) then
            sArea := sValor
        else
            sArea := '';

        //Recupera la cantidad
        sValor := ReadString('Config', 'Cantidad', '');
        if (sValor = 'S') then
            chkCantidad.Checked := true
        else
            chkCantidad.Checked := false;

        //Recupera la cantidad
        sValor := ReadString('Compras', 'Cantidad', '');
        if (sValor = 'S') then
            chkCantCompras.Checked := true
        else
            chkCantCompras.Checked := false;

        //Recupera la opcion de codigo con enter en ventas
        sValor := ReadString('Config', 'CodigoEnter', '');
        if (sValor = 'S') then
            chkCodigoEnter.Checked := true
        else
            chkCodigoEnter.Checked := false;

        //Recupera la opcion de codigo con enter en compras
        sValor := ReadString('Compras', 'Enter', '');
        if (sValor = 'S') then
            chkEnterCompras.Checked := true
        else
            chkEnterCompras.Checked := false;

        //Recupera la opcion de agrupar articulos
        sValor := ReadString('Config', 'Agrupar', '');
        if (sValor = 'S') then
            chkAgrupar.Checked := true
        else
            chkAgrupar.Checked := false;

        //-----------------------------------------------------------------//
        //                      REPORTES DE COMPROBANTES                   //
        //-----------------------------------------------------------------//

        //Recupera el Directorio de Reoportes
        sValor := ReadString('Reportes', 'DirReportes', '');
        if (Length(sValor) > 0) then
            txtDirReportes.Text := sValor;

        //Recupera el archivo de reporte del ajuste
        sValor := ReadString('Reportes', 'Ajuste', '');
        if (Length(sValor) > 0) then
            txtCmbRepAjuste.Text := sValor;

        //Recupera el archivo de reporte de la cotización
        sValor := ReadString('Reportes', 'Cotizacion', '');
        if (Length(sValor) > 0) then
            txtCmbRepCotizacion.Text := sValor;

        //Recupera el archivo de reporte de factura
        sValor := ReadString('Reportes', 'Factura', '');
        if (Length(sValor) > 0) then
            txtCmbRepFactura.Text := sValor;

        //Recupera el archivo de reporte de nota
        sValor := ReadString('Reportes', 'Nota', '');
        if (Length(sValor) > 0) then
            txtCmbRepNota.Text := sValor;

        //Recupera el archivo de reporte de retiro
        sValor := ReadString('Reportes', 'Retiro', '');
        if (Length(sValor) > 0) then
            txtCmbRepRetiro.Text := sValor;

        //Recupera el archivo de reporte de cancelación
        sValor := ReadString('Reportes', 'Cancela', '');
        if (Length(sValor) > 0) then
            txtCmbRepCancelacion.Text := sValor;

        //Recupera el archivo de reporte de devolucion
        sValor := ReadString('Reportes', 'Devolucion', '');
        if (Length(sValor) > 0) then
            txtCmbRepDevolucion.Text := sValor;

        //Recupera el archivo de reporte de pedido
        sValor := ReadString('Reportes', 'Pedido', '');
        if (Length(sValor) > 0) then
            txtRepPedido.Text := sValor;

        //Recupera el número de copias de los ajustes
        sValor := ReadString('Reportes', 'CopiasAjuste', '');
        if (Length(sValor) > 0) then
            txtCopiAjuste.Value := StrToInt(sValor);

        //Recupera el número de copias de la cotización
        sValor := ReadString('Reportes', 'CopiasCotizacion', '');
        if (Length(sValor) > 0) then
            txtCopiCotiza.Value := StrToInt(sValor);

        //Recupera el número de copias de la factura
        sValor := ReadString('Reportes', 'CopiasFactura', '');
        if (Length(sValor) > 0) then
            txtCopiFact.Value := StrToInt(sValor);

        //Recupera el número de copias de la nota
        sValor := ReadString('Reportes', 'CopiasNota', '');
        if (Length(sValor) > 0) then
            txtCopiNota.Value := StrToInt(sValor);

        //Recupera el número de copias del ticket
        sValor := ReadString('Reportes', 'CopiasTicket', '');
        if (Length(sValor) > 0) then
            txtCopiTicket.Value := StrToInt(sValor);

        //Recupera el número de copias de la devolución
        sValor := ReadString('Reportes', 'CopiasDevolucion', '');
        if (Length(sValor) > 0) then
            txtCopiDevolucion.Value := StrToInt(sValor);

        //Recupera el número de copias de la nota de credito
        sValor := ReadString('Reportes', 'CopiasNotaCredito', '');
        if (Length(sValor) > 0) then
            txtCopiNotaCred.Value := StrToInt(sValor);

        //Recupera el número de copias de los pedidos
        sValor := ReadString('Reportes', 'CopiasPedido', '');
        if (Length(sValor) > 0) then
            txtCopiPedido.Value := StrToInt(sValor);

        //-----------------------------------------------------------------//
        //                      REPORTES DE VENTAS                         //
        //-----------------------------------------------------------------//

        //Recupera el archivo de reporte del corte
        sValor := ReadString('Reportes', 'Corte', '');
        if (Length(sValor) > 0) then
            txtVtaRepCorte.Text := sValor;

        //Recupera el archivo de reporte de comprobación fiscal
        sValor := ReadString('Reportes', 'CompFiscal', '');
        if (Length(sValor) > 0) then
            txtVtaRepCompFiscal.Text := sValor;

        //Recupera el archivo de reporte de ventas por hora
        sValor := ReadString('Reportes', 'VentasHora', '');
        if (Length(sValor) > 0) then
            txtVtaRepHora.Text := sValor;

        //Recupera el archivo de reporte de operaciones del dia
        sValor := ReadString('Reportes', 'Operaciones', '');
        if (Length(sValor) > 0) then
            txtVtaRepOperacion.Text := sValor;

        //Recupera el archivo de reporte de ventas por area
        sValor := ReadString('Reportes', 'VentasArea', '');
        if (Length(sValor) > 0) then
            txtVtaRepArea.Text := sValor;

        //Recupera el archivo de reporte de ventas por caja
        sValor := ReadString('Reportes', 'VentasCaja', '');
        if (Length(sValor) > 0) then
            txtVtaRepCaja.Text := sValor;

        //Recupera el archivo de reporte de ventas por categoria
        sValor := ReadString('Reportes', 'VentasCategoria', '');
        if (Length(sValor) > 0) then
            txtVtaRepCategoria.Text := sValor;

        //Recupera el archivo de reporte de ventas por cliente
        sValor := ReadString('Reportes', 'VentasCliente', '');
        if (Length(sValor) > 0) then
            txtVtaRepCliente.Text := sValor;

        //Recupera el archivo de reporte de ventas por código
        sValor := ReadString('Reportes', 'VentasCodigo', '');
        if (Length(sValor) > 0) then
            txtVtaRepCodigo.Text := sValor;

        //Recupera el archivo de reporte de ventas por departamento
        sValor := ReadString('Reportes', 'VentasDepartamento', '');
        if (Length(sValor) > 0) then
            txtVtaRepDepartamento.Text := sValor;

        //Recupera el archivo de reporte de ventas por descripción
        sValor := ReadString('Reportes', 'VentasDescripcion', '');
        if (Length(sValor) > 0) then
            txtVtaRepDescripcion.Text := sValor;

        //Recupera el archivo de reporte de ventas por proveedor
        sValor := ReadString('Reportes', 'VentasProveedor', '');
        if (Length(sValor) > 0) then
            txtVtaRepProveedor.Text := sValor;

        //Recupera el archivo de reporte de ventas por usuario
        sValor := ReadString('Reportes', 'VentasUsuario', '');
        if (Length(sValor) > 0) then
            txtVtaRepUsuario.Text := sValor;

        //-----------------------------------------------------------------//
        //                      REPORTES DE COMPRAS                        //
        //-----------------------------------------------------------------//

        //Recupera el archivo de reporte de Compras por caja
        sValor := ReadString('Reportes', 'ComprasCaja', '');
        if (Length(sValor) > 0) then
            txtCmpRepCaja.Text := sValor;

        //Recupera el archivo de reporte de Compras por categoria
        sValor := ReadString('Reportes', 'ComprasCategoria', '');
        if (Length(sValor) > 0) then
            txtCmpRepCategoria.Text := sValor;

        //Recupera el archivo de reporte de Compras por código
        sValor := ReadString('Reportes', 'ComprasCodigo', '');
        if (Length(sValor) > 0) then
            txtCmpRepCodigo.Text := sValor;

        //Recupera el archivo de reporte de Compras por departamento
        sValor := ReadString('Reportes', 'ComprasDepartamento', '');
        if (Length(sValor) > 0) then
            txtCmpRepDepartamento.Text := sValor;

        //Recupera el archivo de reporte de Compras por descripción
        sValor := ReadString('Reportes', 'ComprasDescripcion', '');
        if (Length(sValor) > 0) then
            txtCmpRepDescripcion.Text := sValor;

        //Recupera el archivo de reporte de Compras por documento
        sValor := ReadString('Reportes', 'ComprasDocumento', '');
        if (Length(sValor) > 0) then
            txtCmpRepDocumento.Text := sValor;

        //Recupera el archivo de reporte de Compras por proveedor
        sValor := ReadString('Reportes', 'ComprasProveedor', '');
        if (Length(sValor) > 0) then
            txtCmpRepProveedor.Text := sValor;

        //Recupera el archivo de reporte de Compras por usuario
        sValor := ReadString('Reportes', 'ComprasUsuario', '');
        if (Length(sValor) > 0) then
            txtCmpRepUsuario.Text := sValor;

        //-----------------------------------------------------------------//
        //                      REPORTES DE CATALOGOS                      //
        //-----------------------------------------------------------------//

        //Recupera el archivo de reporte de categorias
        sValor := ReadString('Reportes', 'Categorias', '');
        if (Length(sValor) > 0) then
            txtCatRepCategorias.Text := sValor;

        //Recupera el archivo de reporte de unidades
        sValor := ReadString('Reportes', 'Unidades', '');
        if (Length(sValor) > 0) then
            txtCatRepUnidades.Text := sValor;

        //Recupera el archivo de reporte de clientes
        sValor := ReadString('Reportes', 'Clientes', '');
        if (Length(sValor) > 0) then
            txtCatRepClientes.Text := sValor;

        //Recupera el archivo de reporte de departamentos
        sValor := ReadString('Reportes', 'Departamentos', '');
        if (Length(sValor) > 0) then
            txtCatRepDepartamentos.Text := sValor;

        //Recupera el archivo de reporte de proveedores
        sValor := ReadString('Reportes', 'Proveedores', '');
        if (Length(sValor) > 0) then
            txtCatRepProveedores.Text := sValor;

        //Recupera el archivo de reporte de articulos por Categoria
        sValor := ReadString('Reportes', 'ArticulosCategoria', '');
        if (Length(sValor) > 0) then
            txtArtRepCategoria.Text := sValor;

        //Recupera el archivo de reporte de articulos por Código
        sValor := ReadString('Reportes', 'ArticulosCodigo', '');
        if (Length(sValor) > 0) then
            txtArtRepCodigo.Text := sValor;

        //Recupera el archivo de reporte de articulos por Departamento
        sValor := ReadString('Reportes', 'ArticulosDepartamento', '');
        if (Length(sValor) > 0) then
            txtArtRepDepartamento.Text := sValor;

        //Recupera el archivo de reporte de articulos por descripción
        sValor := ReadString('Reportes', 'ArticulosDescripcion', '');
        if (Length(sValor) > 0) then
            txtArtRepDescripcion.Text := sValor;

        //Recupera el archivo de reporte de articulos por Proveedor 1
        sValor := ReadString('Reportes', 'ArticulosProveedor1', '');
        if (Length(sValor) > 0) then
            txtArtRepProveedor1.Text := sValor;

        //Recupera el archivo de reporte de articulos por Proveedor 2
        sValor := ReadString('Reportes', 'ArticulosProveedor2', '');
        if (Length(sValor) > 0) then
            txtArtRepProveedor2.Text := sValor;

        //-----------------------------------------------------------------//
        //                      REPORTES DE INVENTARIO                     //
        //-----------------------------------------------------------------//

        // Recupera el archivo del reporte de ajuste
        sValor := ReadString('Reportes', 'InvAjuste', '');
        if (Length(sValor) > 0) then
            txtInvRepAjuste.Text := sValor;

        // Recupera el archivo del reporte de pedidos
        sValor := ReadString('Reportes', 'InvPedidos', '');
        if (Length(sValor) > 0) then
            txtInvRepPedidos.Text := sValor;

        // Recupera el archivo del reporte de conteo
        sValor := ReadString('Reportes', 'InvConteo', '');
        if (Length(sValor) > 0) then
            txtInvRepConteo.Text := sValor;

        // Recupera el archivo del reporte de valor del inventario
        sValor := ReadString('Reportes', 'InvValor', '');
        if (Length(sValor) > 0) then
            txtInvRepValor.Text := sValor;

        //-----------------------------------------------------------------//
        //                      REPORTES DE COMPROBANTES                   //
        //-----------------------------------------------------------------//

        // Recupera el archivo del reporte de comprobantes
        sValor := ReadString('Reportes', 'Comprobantes', '');
        if (Length(sValor) > 0) then
            txtVarRepComprobantes.Text := sValor;


        // Recupera el archivo de Notas de credito
        sValor := ReadString('Reportes', 'NotaCredito', '');
        if (Length(sValor) > 0) then
            txtCmbRepNotCred.Text:= sValor;


        //-----------------------------------------------------------------//
        //                REPORTES DE CUENTAS POR COBRAR                   //
        //-----------------------------------------------------------------//

        // Recupera el archivo del reporte de Cobranza General
        sValor := ReadString('Reportes', 'XCobrarCobranzaGeneral', '');
        if (Length(sValor) > 0) then
            txtVarRepCobranza.Text := sValor;

        // Recupera el archivo del reporte de Créditos Vencidos
        sValor := ReadString('Reportes', 'XCobrarVencidos', '');
        if (Length(sValor) > 0) then
            txtVarRepCreditosVencidos.Text := sValor;

        //-----------------------------------------------------------------//
        //                REPORTES DE CUENTAS POR PAGAR                    //
        //-----------------------------------------------------------------//

        // Recupera el archivo del reporte de Pagos Generales
        sValor := ReadString('Reportes', 'XPagarPagosGenerales', '');
        if (Length(sValor) > 0) then
            txtVarRepPagosGenerales.Text := sValor;

        // Recupera el archivo del reporte de Pagos Vencidos
        sValor := ReadString('Reportes', 'XPagarVencidos', '');
        if (Length(sValor) > 0) then
            txtVarRepPagosVencidos.Text := sValor;

         //-------------iva----------------//

         sValor := ReadString('IVA', 'ivageneral', '');
         if (Length(sValor) > 0) then
            civa.Text := sValor;
          //-------------CFDI----------------//
             sValor := ReadString('CFDI', 'RFC', '');
         if (Length(sValor) > 0) then
            rfc.Text := sValor;
                 sValor := ReadString('CFDI', 'CUENTA', '');
         if (Length(sValor) > 0) then
            usuario.Text := sValor;
             sValor := ReadString('CFDI', 'PASSWORD', '');
         if (Length(sValor) > 0) then
            password.Text := sValor;

        //-----------------------------------------------------------------//
        //                      DISPOSITIVOS                               //
        //-----------------------------------------------------------------//

        //Recupera el puerto de la impresora de tickets
        sValor := ReadString('Config', 'PuertoTicket', '');
        if (Length(sValor) > 0) then
            txtPuertoTicket.Text := sValor;

        //Recupera el codigo de inicializar la impresora de tickets
        sValor := ReadString('Config', 'IniTicket', '');
        if (Length(sValor) > 0) then
            txtIniTicket.Text := sValor;

        //Recupera el codigo de cortar de la impresora de tickets
        sValor := ReadString('Config', 'CortaTicket', '');
        if (Length(sValor) > 0) then
            txtCortaTicket.Text := sValor;

        //Recupera el codigo de cortar de la impresora de tickets
        sValor := ReadString('Config', 'CortaTicket', '');
        if (Length(sValor) > 0) then
            txtCortaTicket.Text := sValor;

        //Recupera el codigo de finalizar de la impresora de tickets
        sValor := ReadString('Config', 'FinTicket', '');
        if (Length(sValor) > 0) then
            txtFinTicket.Text := sValor;

        //Recupera el puerto del cajon de dinero
        sValor := ReadString('Config', 'PuertoCajon', '');
        if (Length(sValor) > 0) then
            txtPuertoCajon.Text := sValor;

        //Recupera el codigo de abrir del cajon de dinero
        sValor := ReadString('Config', 'AbrirCajon', '');
        if (Length(sValor) > 0) then
            txtAbrirCajon.Text := sValor;

        Free;
    end;
end;

procedure TfrmConfig.FormClose(Sender: TObject; var Action: TCloseAction);
  var iniArchivo : TIniFile;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'config.ini');
    with iniArchivo do begin
        // Registra la posición y de la ventana
        WriteString('Config', 'Posy', IntToStr(Top));

        // Registra la posición X de la ventana
        WriteString('Config', 'Posx', IntToStr(Left));

        //Registra la ultima ficha que se seleccionó
        WriteString('Config', 'Ficha', IntToStr(pgeGeneral.ActivePageIndex));
        Free;
    end;
end;

procedure TfrmConfig.btnAplicarClick(Sender: TObject);
begin
    if(VerificaDatos) then begin
        GuardaDatos;
        if ((Sender as TBitBtn).Name = 'btnAceptar') then
            Close;
    end;
end;

function TfrmConfig.VerificaDatos:boolean;
begin
    btnAplicar.SetFocus;
    Result := true;
    if(cmbCaja.ItemIndex = -1) then begin
        Application.MessageBox('Introduce el número de caja','Error',[smbOK],smsCritical);
        pgeGeneral.ActivePage := tabGeneral;
        cmbCaja.SetFocus;
        Result := false;
    end
    else if(txtMoneda.Value <= 0) then begin
        Application.MessageBox('Introduce un valor mayor a cero para el redondeo','Error',[smbOK],smsCritical);
        pgeGeneral.ActivePage := tabGeneral;
        txtMoneda.SetFocus;
        Result := false;
    end
    else if(txtPrecio.Value < 1) or (txtPrecio.Value > 4) then begin
        Application.MessageBox('Introduce un precio válido para el cliente (1..4)','Error',[smbOK],smsCritical);
        pgeGeneral.ActivePage := tabGeneral;
        txtPrecio.SetFocus;
        Result := false;
    end
    else if(txtCopiAjuste.Value < 1) then begin
        Application.MessageBox('Introduce un número de copias válido para los ajustes','Error',[smbOK],smsCritical);
        pgeGeneral.ActivePage := tabComprobantes;
        txtCopiAjuste.SetFocus;
        Result := false;
    end
    else if(txtCopiCotiza.Value < 1) then begin
        Application.MessageBox('Introduce un número de copias válido para las cotizaciones','Error',[smbOK],smsCritical);
        pgeGeneral.ActivePage := tabComprobantes;
        txtCopiCotiza.SetFocus;
        Result := false;
    end
    else if(txtCopiFact.Value < 1) then begin
        Application.MessageBox('Introduce un número de copias válido para las facturas','Error',[smbOK],smsCritical);
        pgeGeneral.ActivePage := tabComprobantes;
        txtCopiFact.SetFocus;
        Result := false;
    end
    else if(txtCopiNota.Value < 1) then begin
        Application.MessageBox('Introduce un número de copias válido para las notas','Error',[smbOK],smsCritical);
        pgeGeneral.ActivePage := tabComprobantes;
        txtCopiNota.SetFocus;
        Result := false;
    end
    else if(txtCopiTicket.Value < 1) then begin
        Application.MessageBox('Introduce un número de copias válido para los tickets','Error',[smbOK],smsCritical);
        pgeGeneral.ActivePage := tabComprobantes;
        txtCopiTicket.SetFocus;
        Result := false;
    end
    else if(txtCopiDevolucion.Value < 1) then begin
        Application.MessageBox('Introduce un número de copias válido para las devoluciones','Error',[smbOK],smsCritical);
        pgeGeneral.ActivePage := tabComprobantes;
        txtCopiDevolucion.SetFocus;
        Result := false;
    end
    else if(txtCopiNotaCred.Value < 1) then begin
        Application.MessageBox('Introduce un número de copias válido para las notas de credito','Error',[smbOK],smsCritical);
        pgeGeneral.ActivePage := tabComprobantes;
        txtCopiNotaCred.SetFocus;
        Result := false;
    end
    else if(txtCopiPedido.Value < 1) then begin
        Application.MessageBox('Introduce un número de copias válido para los pedidos','Error',[smbOK],smsCritical);
        pgeGeneral.ActivePage := tabComprobantes;
        txtCopiPedido.SetFocus;
        Result := false;
    end;
end;

procedure TfrmConfig.GuardaDatos;
var
    sPagoDef, sPagoCompras, sAreaDef, sComprobDef : String;
    iniArchivo : TIniFile;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'config.ini');

    sAreaDef := BuscaClaveArea(cmbAreas.Text);
    sComprobDef := Copy(cmbComprobantes.Text,1,1);
    sPagoDef := BuscaClavePago(cmbTipoPago.Text);
    sPagoCompras := BuscaClavePago(cmbPagoCompras.Text);

    with iniArchivo do begin
        // Registra el número de caja
        WriteString('Config', 'Caja', cmbCaja.Text);

        // Registra el área de venta por defecto
        WriteString('Config', 'AreaVenta', sAreaDef);

        // Registra si muestra la venta de cantidad automàtico para ventas
        if(chkCantidad.Checked) then
            WriteString('Config', 'Cantidad', 'S')
        else
            WriteString('Config', 'Cantidad', 'N');

        // Registra si muestra la venta de cantidad automàtico para compras
        if(chkCantCompras.Checked) then
            WriteString('Compras', 'Cantidad', 'S')
        else
            WriteString('Compras', 'Cantidad', 'N');

        // Registra si busca el codigo sin necesidad de dar enter en ventas
        if(chkCodigoEnter.Checked) then
            WriteString('Config', 'CodigoEnter', 'S')
        else
            WriteString('Config', 'CodigoEnter', 'N');

        // Registra si busca el codigo sin necesidad de dar enter en compras
        if(chkEnterCompras.Checked) then
            WriteString('Compras', 'Enter', 'S')
        else
            WriteString('Compras', 'Enter', 'N');

        // Registra si agrupa los articulos con el mismo codigo en ventas
        if(chkAgrupar.Checked) then
            WriteString('Config', 'Agrupar', 'S')
        else
            WriteString('Config', 'Agrupar', 'N');

        //-----------------------------------------------------------------//
        //                      REPORTES DE COMPROBANTES                   //
        //-----------------------------------------------------------------//

        // Registra el Directorio de los Reportes
        WriteString('Reportes', 'DirReportes', txtDirReportes.Text);

        // Registra el archivo del reporte de ajuste
        WriteString('Reportes', 'Ajuste', txtCmbRepAjuste.Text);

        // Registra el archivo del reporte de cotización
        WriteString('Reportes', 'Cotizacion', txtCmbRepCotizacion.Text);

        // Registra el archivo del reporte de factura
        WriteString('Reportes', 'Factura', txtCmbRepFactura.Text);

        // Registra el archivo del reporte de Nota
        WriteString('Reportes', 'Nota', txtCmbRepNota.Text);

        // Registra el archivo del reporte de Retiro
        WriteString('Reportes', 'Retiro', txtCmbRepRetiro.Text);

        // Registra el archivo del reporte de Cancelación
        WriteString('Reportes', 'Cancela', txtCmbRepCancelacion.Text);

        // Registra el archivo del reporte de Cancelación
        WriteString('Reportes', 'Devolucion', txtCmbRepDevolucion.Text);

        // Registra el número de copias de los ajustes
        WriteString('Reportes', 'CopiasAjuste', FloatToStr(txtCopiAjuste.Value));

        // Registra el número de copias de la cotización
        WriteString('Reportes', 'CopiasCotizacion', FloatToStr(txtCopiCotiza.Value));

        // Registra el número de copias de la factura
        WriteString('Reportes', 'CopiasFactura', FloatToStr(txtCopiFact.Value));

        // Registra el número de copias de las notas
        WriteString('Reportes', 'CopiasNota', FloatToStr(txtCopiNota.Value));

        // Registra el número de copias de los tickets
        WriteString('Reportes', 'CopiasTicket', FloatToStr(txtCopiTicket.Value));

        // Registra el número de copias de las devoluciones
        WriteString('Reportes', 'CopiasDevolucion', FloatToStr(txtCopiDevolucion.Value));

        // Registra el número de copias de las notas de credito
        WriteString('Reportes', 'CopiasNotaCredito', FloatToStr(txtCopiNotacred.Value));

        // Registra el número de copias de las pedidos
        WriteString('Reportes', 'CopiasPedido', FloatToStr(txtCopiPedido.Value));

        //-----------------------------------------------------------------//
        //                      REPORTES DE VENTAS                         //
        //-----------------------------------------------------------------//

        // Registra el archivo del reporte de corte
        WriteString('Reportes', 'Corte', txtVtaRepCorte.Text);

        // Registra el archivo del reporte de comprobación fiscal
        WriteString('Reportes', 'CompFiscal', txtVtaRepCompFiscal.Text);

        // Registra el archivo del reporte de ventas x hora
        WriteString('Reportes', 'VentasHora', txtVtaRepHora.Text);

        // Registra el archivo del reporte de ventas x hora
        WriteString('Reportes', 'Operaciones', txtVtaRepOperacion.Text);

        // Registra el archivo del reporte de ventas x area
        WriteString('Reportes', 'VentasArea', txtVtaRepArea.Text);

        // Registra el archivo del reporte de ventas x caja
        WriteString('Reportes', 'VentasCaja', txtVtaRepCaja.Text);

        // Registra el archivo del reporte de ventas x categoria
        WriteString('Reportes', 'VentasCategoria', txtVtaRepCategoria.Text);

        // Registra el archivo del reporte de ventas x cliente
        WriteString('Reportes', 'VentasCliente', txtVtaRepCliente.Text);

        // Registra el archivo del reporte de ventas x código
        WriteString('Reportes', 'VentasCodigo', txtVtaRepCodigo.Text);

        // Registra el archivo del reporte de ventas x departamento
        WriteString('Reportes', 'VentasDepartamento', txtVtaRepDepartamento.Text);

        // Registra el archivo del reporte de ventas x departamento
        WriteString('Reportes', 'VentasDescripcion', txtVtaRepDescripcion.Text);

        // Registra el archivo del reporte de ventas x proveedor
        WriteString('Reportes', 'VentasProveedor', txtVtaRepProveedor.Text);

        // Registra el archivo del reporte de ventas x usuario
        WriteString('Reportes', 'VentasUsuario', txtVtaRepUsuario.Text);

        //-----------------------------------------------------------------//
        //                      REPORTES DE COMPRAS                        //
        //-----------------------------------------------------------------//

        // Registra el archivo del reporte de Compras x caja
        WriteString('Reportes', 'ComprasCaja', txtCmpRepCaja.Text);

        // Registra el archivo del reporte de Compras x categoria
        WriteString('Reportes', 'ComprasCategoria', txtCmpRepCategoria.Text);

        // Registra el archivo del reporte de Compras x código
        WriteString('Reportes', 'ComprasCodigo', txtCmpRepCodigo.Text);

        // Registra el archivo del reporte de Compras x departamento
        WriteString('Reportes', 'ComprasDepartamento', txtCmpRepDepartamento.Text);

        // Registra el archivo del reporte de Compras x descripcion
        WriteString('Reportes', 'ComprasDescripcion', txtCmpRepDescripcion.Text);

        // Registra el archivo del reporte de Compras x documento
        WriteString('Reportes', 'ComprasDocumento', txtCmpRepDocumento.Text);

        // Registra el archivo del reporte de Compras x proveedor
        WriteString('Reportes', 'ComprasProveedor', txtCmpRepProveedor.Text);

        // Registra el archivo del reporte de Compras x usuario
        WriteString('Reportes', 'ComprasUsuario', txtCmpRepUsuario.Text);

        //-----------------------------------------------------------------//
        //                      REPORTES DE CATALOGOS                      //
        //-----------------------------------------------------------------//

        // Registra el archivo del reporte de categorías
        WriteString('Reportes', 'Categorias', txtCatRepCategorias.Text);

        // Registra el archivo del reporte de categorías
        WriteString('Reportes', 'Unidades', txtCatRepUnidades.Text);

        // Registra el archivo del reporte de clientes
        WriteString('Reportes', 'Clientes', txtCatRepClientes.Text);

        // Registra el archivo del reporte de clientes
        WriteString('Reportes', 'Departamentos', txtCatRepDepartamentos.Text);

        // Registra el archivo del reporte de clientes
        WriteString('Reportes', 'Proveedores', txtCatRepProveedores.Text);

        // Registra el archivo del reporte de articulos por Categoria
        WriteString('Reportes', 'ArticulosCategoria', txtArtRepCategoria.Text);

        // Registra el archivo del reporte de articulos por Código
        WriteString('Reportes', 'ArticulosCodigo', txtArtRepCodigo.Text);

        // Registra el archivo del reporte de articulos por Departamento
        WriteString('Reportes', 'ArticulosDepartamento', txtArtRepDepartamento.Text);

        // Registra el archivo del reporte de articulos por Descripción
        WriteString('Reportes', 'ArticulosDescripcion', txtArtRepDescripcion.Text);

        // Registra el archivo del reporte de articulos por proveedor 1
        WriteString('Reportes', 'ArticulosProveedor1', txtArtRepProveedor1.Text);

        // Registra el archivo del reporte de articulos por proveedor 1
        WriteString('Reportes', 'ArticulosProveedor2', txtArtRepProveedor2.Text);

        //-----------------------------------------------------------------//
        //                      REPORTES DE INVENTARIO                     //
        //-----------------------------------------------------------------//

        // Registra el archivo del reporte de pedidos
        WriteString('Reportes', 'InvAjuste', txtInvRepAjuste.Text);

        // Registra el archivo del reporte de pedidos
        WriteString('Reportes', 'InvPedidos', txtInvRepPedidos.Text);

        // Registra el archivo del reporte de conteo
        WriteString('Reportes', 'Invconteo', txtInvRepConteo.Text);

        // Registra el archivo del reporte de valor del inventario
        WriteString('Reportes', 'InvValor', txtInvRepValor.Text);

        //-----------------------------------------------------------------//
        //                      REPORTES DE COMPROBANTES                   //
        //-----------------------------------------------------------------//

        // Registra el archivo del reporte de COMPROBANTES
        WriteString('Reportes', 'Comprobantes', txtVarRepComprobantes.Text);


        //Registra el archivo de Notas de credito
        WriteString('Reportes', 'NotaCredito', txtCmbRepNotCred.Text);

        //Registra el archivo de Notas de credito
        WriteString('Reportes', 'Pedido', txtRepPedido.Text);
        
        //-----------------------------------------------------------------//
        //                  REPORTES DE CUENTAS X COBRAR                   //
        //-----------------------------------------------------------------//

        // Registra el archivo del reporte de Cobranza General
        WriteString('Reportes', 'XCobrarCobranzaGeneral', txtVarRepCobranza.Text);

        // Registra el archivo del reporte de Créditos Vencidos
        WriteString('Reportes', 'XCobrarVencidos', txtVarRepCreditosVencidos.Text);

        //-----------------------------------------------------------------//
        //                  REPORTES DE CUENTAS X PAGAR                    //
        //-----------------------------------------------------------------//

        // Registra el archivo del reporte de Pagos Generales
        WriteString('Reportes', 'XPagarPagosGenerales', txtVarRepPagosGenerales.Text);

        // Registra el archivo del reporte de Pagos Vencidos
        WriteString('Reportes', 'XPagarVencidos', txtVarRepPagosVencidos.Text);

        //--------------IVA------------------//
        
        WriteString('IVA', 'ivageneral', civa.Text);

        //-----------CFDI---------/
        WriteString('CFDI', 'RFC', rfc.Text);
        WriteString('CFDI', 'CUENTA', usuario.Text);
        WriteString('CFDI', 'PASSWORD', password.Text);




        //-----------------------------------------------------------------//
        //                      DISPOSITIVOS                               //
        //-----------------------------------------------------------------//

        // Registra el puerto de la impresora de tickets
        WriteString('Config', 'PuertoTicket', txtPuertoTicket.Text);

        // Registra el codigo de inicializar de la impresora de tickets
        WriteString('Config', 'IniTicket', txtIniTicket.Text);

        // Registra el codigo de cortar de la impresora de tickets
        WriteString('Config', 'CortaTicket', txtCortaTicket.Text);

        // Registra el codigo de finalizar de la impresora de tickets
        WriteString('Config', 'FinTicket', txtFinTicket.Text);

        // Registra el puerto del cajon de dinero
        WriteString('Config', 'PuertoCajon', txtPuertoCajon.Text);

        // Registra el codigo para abrir el cajon
        WriteString('Config', 'AbrirCajon', txtAbrirCajon.Text);

        Free;
    end;
    with dmDatos.qryModifica do begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT * FROM config');
        Open;

        if(Eof) then begin
            Close;
            SQL.Clear;
            SQL.Add('INSERT INTO config (monedamenor) VALUES(' + FloatToStr(txtMoneda.Value) + ')');
            ExecSQL;
            Close;
        end;

        Close;
        SQL.Clear;
        SQL.Add('UPDATE config SET');
        if(chkCodigo.Checked) then
            SQL.Add('letraencodigo = ''S'',')
        else
            SQL.Add('letraencodigo = ''N'',');
        if(chkCantidadNegativa.Checked) then
            SQL.Add('cantidadnegativa = ''S'',')
        else
            SQL.Add('cantidadnegativa = ''N'',');
        if(chkLimiteCred.Checked) then
            SQL.Add('limitecred = ''S'',')
        else
            SQL.Add('limitecred = ''N'',');
        SQL.Add('precio = ' + FloatToStr(txtPrecio.Value) + ',');
        // SQL.Add('precio = ' + FormataFloat(txtPrecio.Text,2) + ',');
        SQL.Add('pagodef = ' + sPagoDef + ',');
        SQL.Add('pagocompras = ' + sPagoCompras + ',');
        SQL.Add('comprobantedef = ''' + sComprobDef + ''',');
        SQL.Add('comprobantecompras = ''' + Copy(cmbCompCompras.Text,1,1) + ''',');
        SQL.Add('monedamenor = ' + FloatToStr(txtMoneda.Value) + ',');
        // SQL.Add('monedamenor = ' + FormataFloat(txtMoneda.Text,2) + ',');
        SQL.Add('notaglobal = ''' + Copy(cmbNotaGlobal.Text,1,1) + ''',');
        SQL.Add('facturaglobal = ''' + Copy(cmbFacturaGlobal.Text,1,1) + ''',');
        SQL.Add('ticketglobal = ''' + Copy(cmbTicketGlobal.Text,1,1) + ''',');
        SQL.Add('cotizacionglobal = ''' + Copy(cmbCotizaGlobal.Text,1,1) + ''',');
        SQL.Add('ajusteglobal = ''' + Copy(cmbAjusteGlobal.Text,1,1) + ''',');
        SQL.Add('devolucionglobal = ''' + Copy(cmbDevolucionGlobal.Text,1,1) + ''',');
        SQL.Add('pedidoglobal = ''' + Copy(cmbPedidoGlobal.Text,1,1) + ''',');
        SQL.Add('notacredglobal = ''' + Copy(cmbNotaCredGlobal.Text,1,1) + '''');
        ExecSQL;
        Close;

        GuardaDescuentoPago;
    end;
end;

procedure TfrmConfig.RecuperaCajas;
var
    i, iIndice : integer;
begin
    iIndice := 0;
    with dmDatos.qryModifica do begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT numero FROM cajas ORDER BY numero');
        Open;
        cmbCaja.Clear;
        i:= 0;
        while(not Eof) do begin
            if(sCaja = FieldByName('numero').AsString) then
                iIndice := i;
            cmbCaja.Items.Add(Trim(FieldByName('numero').AsString));
            Next;
            Inc(i);
        end;
        Close;
    end;
    cmbCaja.ItemIndex := iIndice;
end;

procedure TfrmConfig.RecuperaPagosDesc;
begin
    with dmDatos.qryModifica do begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT t.nombre, p.tipopago FROM tipopago t LEFT JOIN descuentospago p');
        SQL.Add('ON t.clave = p.tipopago WHERE aplica LIKE ''%V%''');
        Open;

        lstAceptados.Items.Clear;
        lstNoAceptados.Items.Clear;
        while(not Eof) do begin
            if(FieldByName('tipopago').AsInteger = 0) then
                lstNoAceptados.Items.Add(FieldByName('nombre').AsString)
            else
                lstAceptados.Items.Add(FieldByName('nombre').AsString);
            Next;
        end;
        Close;
    end;
end;

procedure TfrmConfig.RecuperaAreas;
var
    i, iIndice : integer;
begin
    iIndice := 0;
    with dmDatos.qryModifica do begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT clave, nombre FROM areasventa ORDER BY nombre');
        Open;
        cmbAreas.Clear;
        i:= 0;
        while(not Eof) do begin
            if(sArea = FieldByName('clave').AsString) then
                iIndice := i;
            cmbAreas.Items.Add(Trim(FieldByName('nombre').AsString));
            Next;
            Inc(i);
        end;
        Close;
    end;
    cmbAreas.ItemIndex := iIndice;
end;

procedure TfrmConfig.RecuperaTipoPago;
var
    iVentas, iCompras, iIndice, iIndiceCompras : integer;
begin
    iIndice := 0;
    iIndiceCompras := 0;
    with dmDatos.qryModifica do begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT clave, nombre, aplica FROM tipopago ORDER BY nombre');
        Open;
        cmbTipoPago.Clear;
        iVentas := 0;
        iCompras := 0;
        while(not Eof) do begin
            if(Pos('V',FieldByName('aplica').AsString) > 0) then begin
                if(sTipoPago = FieldByName('clave').AsString) then
                    iIndice := iVentas;
                cmbTipoPago.Items.Add(Trim(FieldByName('nombre').AsString));
                Inc(iVentas);
            end;
            if(Pos('C',FieldByName('aplica').AsString) > 0) then begin
                if(sPagoCompras = FieldByName('clave').AsString) then
                    iIndiceCompras := iCompras;
                cmbPagoCompras.Items.Add(Trim(FieldByName('nombre').AsString));
                Inc(iCompras);
            end;
            Next;
        end;
        Close;
    end;
    cmbTipoPago.ItemIndex := iIndice;
    cmbPagoCompras.ItemIndex := iIndiceCompras;
end;

procedure TfrmConfig.RecuperaComprobantes;
var
    i, iIndice : integer;
begin
    cmbComprobantes.Clear;
    cmbComprobantes.Items.Add('AJUSTE');
    cmbComprobantes.Items.Add('COTIZACION');
    cmbComprobantes.Items.Add('DEVOLUCION');
    cmbComprobantes.Items.Add('FACTURA');
    cmbComprobantes.Items.Add('NOTA');
    cmbComprobantes.Items.Add('TICKET');
    cmbComprobantes.Items.Add('PEDIDO');

    cmbCompcompras.Clear;
    cmbCompcompras.Items.Add('AJUSTE');
    cmbCompcompras.Items.Add('GASTO');
    cmbCompcompras.Items.Add('MERCANCIA');

    iIndice := 0;
    for i := 0 to cmbComprobantes.Items.Count - 1 do
        if(sComprobante = Copy(cmbComprobantes.Items.Strings[i],1,1)) then begin
            iIndice := i;
            break;
        end;
    cmbComprobantes.ItemIndex := iIndice;

    iIndice := 0;
    for i := 0 to cmbCompCompras.Items.Count - 1 do
        if(sCompCompras = Copy(cmbCompCompras.Items.Strings[i],1,1)) then begin
            iIndice := i;
            break;
        end;
    cmbCompCompras.ItemIndex := iIndice;
end;

procedure TfrmConfig.RecuperaDatos;
begin
    with dmDatos.qryModifica do begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT * FROM config');
        Open;
        sTipoPago := FieldByName('pagodef').AsString;
        sPagoCompras := FieldByName('pagocompras').AsString;
        txtMoneda.Value := FieldByName('monedamenor').AsFloat;
        txtPrecio.Value := FieldByName('precio').AsFloat;
        sComprobante := FieldByName('comprobantedef').AsString;
        sCompCompras := FieldByName('comprobantecompras').AsString;
        if(FieldByName('letraencodigo').AsString = 'S') then
            chkCodigo.Checked := true
        else
            chkCodigo.Checked := false;

        if(FieldByName('cantidadnegativa').AsString = 'S') then
            chkCantidadNegativa.Checked := true
        else
            chkCantidadNegativa.Checked := false;

        if(FieldByName('limitecred').AsString = 'S') then
            chkLimiteCred.Checked := true
        else
            chkLimiteCred.Checked := false;

        if(FieldByName('notaglobal').AsString = 'S') then
            cmbNotaGlobal.ItemIndex := 0
        else
            cmbNotaGlobal.ItemIndex := 1;

        if(FieldByName('facturaglobal').AsString = 'S') then
            cmbFacturaGlobal.ItemIndex := 0
        else
            cmbFacturaGlobal.ItemIndex := 1;

        if(FieldByName('ticketglobal').AsString = 'S') then
            cmbTicketGlobal.ItemIndex := 0
        else
            cmbTicketGlobal.ItemIndex := 1;

        if(FieldByName('ajusteglobal').AsString = 'S') then
            cmbAjusteGlobal.ItemIndex := 0
        else
            cmbAjusteGlobal.ItemIndex := 1;

        if(FieldByName('cotizacionglobal').AsString = 'S') then
            cmbCotizaGlobal.ItemIndex := 0
        else
            cmbCotizaGlobal.ItemIndex := 1;

        if(FieldByName('devolucionglobal').AsString = 'S') then
            cmbDevolucionGlobal.ItemIndex := 0
        else
            cmbDevolucionGlobal.ItemIndex := 1;

        if(FieldByName('notacredglobal').AsString = 'S') then
            cmbNotaCredGlobal.ItemIndex := 0
        else
            cmbNotaCredGlobal.ItemIndex := 1;

        if(FieldByName('pedidoglobal').AsString = 'S') then
            cmbPedidoGlobal.ItemIndex := 0
        else
            cmbPedidoGlobal.ItemIndex := 1;

        Close;
    end;
end;

function TfrmConfig.BuscaClaveArea(sNombre : String) : String;
begin
    with dmDatos.qryModifica do begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT clave FROM areasventa WHERE nombre = ''' + sNombre + '''');
        Open;
        Result := FieldByName('clave').AsString;
        Close;
    end;
end;

function TfrmConfig.BuscaClavePago(sNombre : String) : String;
begin
    with dmDatos.qryModifica do begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT clave FROM tipopago WHERE nombre = ''' + sNombre + '''');
        Open;
        Result := FieldByName('clave').AsString;
        Close;
    end;
end;

procedure TfrmConfig.btnDerClick(Sender: TObject);
var
    iRen : integer;
begin
    if(lstAceptados.Items.Count > 0) and (lstAceptados.ItemIndex > -1) then begin
        iRen := lstAceptados.ItemIndex;
        lstNoAceptados.Items.Add(lstAceptados.Items.Strings[lstAceptados.ItemIndex]);
        lstAceptados.Items.Delete(lstaceptados.ItemIndex);
        lstAceptados.SetFocus;
        if(iRen < lstAceptados.Items.Count) then
            lstAceptados.ItemIndex := iRen
        else
        lstAceptados.ItemIndex := iRen - 1;
    end;
end;

procedure TfrmConfig.btnIzqClick(Sender: TObject);
var
    iRen : integer;
begin
    if(lstNoAceptados.Items.Count > 0) and (lstNoAceptados.ItemIndex > -1) then begin
        iRen := lstNoAceptados.ItemIndex;
        lstAceptados.Items.Add(lstNoAceptados.Items.Strings[lstNoAceptados.ItemIndex]);
        lstNoAceptados.Items.Delete(lstNoAceptados.ItemIndex);
        lstNoAceptados.SetFocus;
        if(iRen < lstNoAceptados.Items.Count) then
            lstNoAceptados.ItemIndex := iRen
        else
        lstNoAceptados.ItemIndex := iRen - 1;
    end;
end;

procedure TfrmConfig.GuardaDescuentoPago;
var
    i : integer;
begin
    with dmDatos.qryModifica do begin
        Close;
        SQL.Clear;
        SQL.Add('DELETE FROM descuentospago');
        ExecSQL;

        for i := 0 to lstAceptados.Items.Count - 1 do begin
            Close;
            SQL.Clear;
            SQL.Add('INSERT INTO descuentospago (tipopago) SELECT clave FROM tipopago');
            SQL.Add('WHERE nombre = ''' + lstAceptados.Items.Strings[i] + '''');
            ExecSQL;
        end;
        Close;
    end;
end;

procedure TfrmConfig.arbReportesItemClick(Sender: TObject;
  Button: TMouseButton; Node: TTreeNode; const Pt: TPoint);
var
    i : integer;
begin
    sGrupoActual := 'grp' + IntToStr(arbReportes.Selected.Index);
    with TabReportesVentas do
      for i := 0 to ControlCount -1 do
          if (Controls[i] is TGroupBox) then begin
              if (Controls[i].Name <> sGrupoActual) then
                  (Controls[i] as TGroupBox).Visible := false
              else
                  (Controls[i] as TGroupBox).Visible := true;
          end;
end;

procedure TfrmConfig.BuscaReporte(Sender: TObject);
var
    sCajaTexto : string;
begin
    sCajaTexto :=  Copy((Sender as TBitBtn).Name,10,Length((Sender as TBitBtn).Name));
    dlgAbrir.Title := ((Sender as TBitBtn).Parent as TGroupBox).Caption + ' ('+sCajaTexto+')';
    sCajaTexto :=  'txt' + Copy((Sender as TBitBtn).Name,4,Length((Sender as TBitBtn).Name));
    if(dlgAbrir.Execute) then
        TEdit(FindComponent(sCajaTexto)).Text := ExtractFileName(dlgAbrir.FileName);
end;

end.
