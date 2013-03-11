program Ventas;
                    
{%ToDo 'Ventas.todo'}

uses
  QForms,
  SysUtils,
  Windows,
  Classes,
  Graphics,
  Controls,
  Dialogs,
  MENU in 'Menu.pas' {frmMenu},
  Acceso in 'Acceso.pas' {frmAcceso},
  Permisos in 'Permisos.pas' {frmPermisos},
  Contrasenia in 'Contrasenia.pas' {frmContrasenia},
  BaseDato in 'BaseDato.pas' {frmBaseDatos},
  Departamentos in 'Departamentos.pas' {frmDepartamentos},
  Categorias in 'Categorias.pas' {frmCategorias},
  dm in 'dm.pas' {dmDatos: TDataModule},
  Articulos in 'Articulos.pas' {frmArticulos},
  ProveedBusq in 'ProveedBusq.pas' {frmProveedBusq},
  Actualizador in 'Actualizador.pas' {frmActualizador},
  Clientes in 'Clientes.pas' {frmClientes},
  empresa in 'empresa.pas' {frmEmpresa},
  venta in 'venta.pas' {frmVentas},
  ClientesBusq in 'ClientesBusq.pas' {frmClientesBusq},
  Autoriza in 'Autoriza.pas' {frmAutoriza},
  ArticuloBusq in 'ArticuloBusq.pas' {frmArticuloBusq},
  Descuentos in 'Descuentos.pas' {frmDescuentos},
  Tipospago in 'Tipospago.pas' {frmTipoPago},
  Pago in 'Pago.pas' {frmPago},
  Cambio in 'Cambio.pas' {frmCambio},
  Cajas in 'Cajas.pas' {frmCajas},
  Ticket in 'Ticket.pas' {frmTicket},
  AreasVentaBusq in 'AreasVentaBusq.pas' {frmAreasVentaBusq},
  Exportar in 'Exportar.pas' {frmExportar},
  Inicializar in 'Inicializar.pas' {frmInicializa},
  Corte in 'Corte.pas' {frmCorte},
  Reportesvarios in 'Reportesvarios.pas' {frmReportesVarios},
  TipoComprobante in 'TipoComprobante.pas' {frmTipoComprobante},
  Proveedores in 'Proveedores.pas' {frmProveedores},
  Cantidad in 'Cantidad.pas' {frmCantidad},
  Config in 'Config.pas' {frmConfig},
  Compras in 'Compras.pas' {frmCompras},
  ConsulCompra in 'ConsulCompra.pas' {frmConsulCompra},
  CompraDoc in 'CompraDoc.pas' {frmCompraDoc},
  Reimprimir in 'Reimprimir.pas' {frmReimprimir},
  Importar in 'Importar.pas' {frmImportar},
  Cliente in 'Cliente.pas' {frmCliente},
  Consulventa in 'Consulventa.pas' {frmVentasConsulta},
  Fecha in 'Fecha.pas' {frmFecha},
  ReportesCompras in 'ReportesCompras.pas' {frmReportesCompras},
  AreasVenta in 'AreasVenta.pas' {frmAreasVenta},
  ReportesInvenAjus in 'ReportesInvenAjus.pas' {frmReportesInventariosF},
  VentaRecupera in 'VentaRecupera.pas' {frmRecuperaVenta},
  AcercaDe in 'AcercaDe.pas' {frmAcercaDe},
  SciZipFile in 'SciZipFile.pas',
  ReportesXPagar in 'ReportesXPagar.pas' {frmReportesXPagar},
  xAbono in 'xAbono.pas' {frmXAbono},
  ReportesComprob in 'ReportesComprob.pas' {frmReportesComprob},
  XPagar in 'XPagar.pas' {frmXPagar},
  Consecutivos in 'Consecutivos.pas' {frmConsecutivos},
  ReportesVentas in 'ReportesVentas.pas' {frmReportesVentas},
  XCobrar in 'XCobrar.pas' {frmXCobrar},
  ReportesXCobrar in 'ReportesXCobrar.pas' {frmReportesXCobrar},
  Inventario in 'Inventario.pas' {frmInventario},
  gastos in 'gastos.pas' {frmGastos},
  Vendedores in 'Vendedores.pas' {frmVendedores},
  ReportesArticulos in 'ReportesArticulos.pas' {frmReportesArticulos},
  InventImporta in 'InventImporta.pas' {frmInventImporta},
  NotaCredito in 'NotaCredito.pas' {frmNotaCredito},
  Calc in 'Calc.pas' {frmCalculadora},
  Comentario in 'Comentario.pas' {frmComentario},
  Pedidos in 'Pedidos.pas' {frmPedidos},
  Variables in 'Variables.pas',
  Unidades in 'Unidades.pas' {frmUnidades},
  Funciones in 'Funciones.pas',
  VendedoresBusq in 'VendedoresBusq.pas' {frmVendedoresBusq},
  fgeneral in 'fgeneral.pas' {facgeneral},
  datoscfd in 'datoscfd.pas' {dcfd};

{$R *.res}

const
  RESOLUCION_HORIZONTAL: LongInt = 800;
  RESOLUCION_VERTICAL: LongInt = 600;

var
  szResolucionMinima: array[0..255] of char;

begin
  {$IFDEF MSWINDOWS}
      Application.Tag:= CreateMutex(nil, FALSE, 'Ventas');
      if GetLastError = ERROR_ALREADY_EXISTS then
      begin
        Application.MessageBox('El sistema Ventas 1.0.1 ya se est� ejecutando','Informaci�n',[smbOk],smsInformation);
        Halt(0)
      end;

      if (Screen.Width < RESOLUCION_HORIZONTAL) or (Screen.Height < RESOLUCION_VERTICAL) then
      begin
        StrPCopy(szResolucionMinima,'El sistema Ventas 1.0.1 se visualiza mejor con la resoluci�n m�nima de ' + IntToStr(RESOLUCION_HORIZONTAL) + 'x' + IntToStr(RESOLUCION_VERTICAL) + ' pixeles');
        Application.MessageBox(szResolucionMinima, 'Informaci�n', [smbOk],smsWarning);
      end;
  {$ENDIF}
  Application.Initialize;
  Application.Title := 'Ventas 1.0.1';
  Application.CreateForm(TdmDatos, dmDatos);
  Application.CreateForm(TfrmMenu, frmMenu);
  Application.CreateForm(TfrmPago, frmPago);
  Application.CreateForm(TfrmReimprimir, frmReimprimir);
  Application.CreateForm(Tfacgeneral, facgeneral);
  Application.CreateForm(Tdcfd, dcfd);
  Application.Run;
end.
