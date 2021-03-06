
// --------------------------------------------------------------------------
// Archivo del Proyecto Ventas
// P�gina del proyecto: http://sourceforge.net/projects/ventas
// --------------------------------------------------------------------------
// Este archivo puede ser distribuido y/o modificado bajo lo terminos de la
// Licencia P�blica General versi�n 2 como es publicada por la Free Software
// Fundation, Inc.
// --------------------------------------------------------------------------

unit venta;

interface

uses
  SysUtils, Types, Classes, QGraphics, QControls, QForms, QDialogs, Qt,
  QStdCtrls, QExtCtrls, QMenus, QTypes, QcurrEdit, QGrids, IniFiles,
  QButtons,Math,ConexionRemota32;

type
  TfrmVentas = class(TForm)
    pnlEncab: TPanel;
    pnlArticulo: TPanel;
    lblCliente: TLabel;
    txtCliente: TEdit;
    grdDatos: TStringGrid;
    grdVenta: TStringGrid;
    tmeHora: TTimer;
    ppmMenu: TPopupMenu;
    mnuCantidad: TMenuItem;
    mnuAyuda: TMenuItem;
    mnuPagar: TMenuItem;
    mnuPrecio: TMenuItem;
    mnuAreasVenta: TMenuItem;
    mnuClientes: TMenuItem;
    mnuCredencial: TMenuItem;
    mnuArticulos: TMenuItem;
    mnuEliminar: TMenuItem;
    Cancelarventaactual1: TMenuItem;
    mnuCancelar: TMenuItem;
    mnuComprobante: TMenuItem;
    Label7: TLabel;
    txtComprobante: TEdit;
    Label8: TLabel;
    txtPrecio: TcurrEdit;
    lblDescuento: TLabel;
    txtDescuento: TcurrEdit;
    txtAreaVenta: TEdit;
    Label10: TLabel;
    mnuRetirar: TMenuItem;
    mnuCliente: TMenuItem;
    mnuReimprimir: TMenuItem;
    pnlBotones: TPanel;
    txtCodigo: TEdit;
    Label1: TLabel;
    pnlTotal: TPanel;
    Label2: TLabel;
    txtTotal: TcurrEdit;
    Label5: TLabel;
    txtHora: TEdit;
    Label3: TLabel;
    txtCaja: TcurrEdit;
    btnPagar: TBitBtn;
    btnPrecio: TBitBtn;
    btnComprobante: TBitBtn;
    btnAreas: TBitBtn;
    btnClientes: TBitBtn;
    btnCantidad: TBitBtn;
    btnCredencial: TBitBtn;
    btnArticulos: TBitBtn;
    btnEliminar: TBitBtn;
    btnRetirar: TBitBtn;
    btnCancelar: TBitBtn;
    N2: TMenuItem;
    mnuBarra: TMenuItem;
    mnuCopiarVenta: TMenuItem;
    Label4: TLabel;
    txtUsuario: TEdit;
    Otrasacciones1: TMenuItem;
    N3: TMenuItem;
    mnuAbrirCajon: TMenuItem;
    mnuEliminarDesc: TMenuItem;
    mnuConsecutivos: TMenuItem;
    mnuCalculadora: TMenuItem;
    mnuDescIndividual: TMenuItem;
    mnuDescGeneral: TMenuItem;
    mnuNotaCredito: TMenuItem;
    Comentarios1: TMenuItem;
    Buscarpedido1: TMenuItem;
    mnuVendedor: TMenuItem;
    txtVendedor: TEdit;
    Label6: TLabel;
    IVA1: TMenuItem;
    CFDi1: TMenuItem;
    IncrementoIndividual1: TMenuItem;
    IncrementoGeneral1: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure txtCajaEnter(Sender: TObject);
    procedure txtCodigoKeyPress(Sender: TObject; var Key: Char);
    procedure txtCodigoKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure grdVentaDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure tmeHoraTimer(Sender: TObject);
    procedure grdVentaMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure mnuCancelarVentaActualClick(Sender: TObject);
    procedure mnuPrecioClick(Sender: TObject);
    procedure mnuEliminarClick(Sender: TObject);
    procedure mnuCantidadClick(Sender: TObject);
    procedure mnuCantidadClick2(Sender: TObject);
    procedure mnuArticulosClick(Sender: TObject);
    procedure mnuClientesClick(Sender: TObject);
    procedure mnuCredencialClick(Sender: TObject);
    procedure mnuPagarClick(Sender: TObject);
    procedure mnuComprobanteClick(Sender: TObject);
    procedure mnuAreasVentaClick(Sender: TObject);
    procedure GuardaRenglon(iRenglon : integer);
    procedure ImprimeComprobante;
    procedure GuardaComprobante;
    procedure ActualizaRenglon(iRen : integer);
    procedure mnuRetirarClick(Sender: TObject);
    procedure mnuCancelarClick(Sender: TObject);
    procedure mnuClienteClick(Sender: TObject);
    procedure mnuReimprimirClick(Sender: TObject);
    procedure mnuBarraClick(Sender: TObject);
    procedure mnuCopiarVentaClick(Sender: TObject);
    procedure mnuAbrirCajonClick(Sender: TObject);
    procedure mnuEliminarDescClick(Sender: TObject);
    procedure mnuCalculadoraClick(Sender: TObject);
    procedure mnuConsecutivosClick(Sender: TObject);
    procedure mnuDescIndividualClick(Sender: TObject);
    procedure grdVentaSelectCell(Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
    procedure Botones;
    procedure mnuNotaCreditoClick(Sender: TObject);
    procedure Comentarios1Click(Sender: TObject);
    procedure Buscarpedido1Click(Sender: TObject);
    procedure mnuVendedorClick(Sender: TObject);
    procedure btnCantidadClick(Sender: TObject);
    procedure IVA1Click(Sender: TObject);
    procedure CFDi1Click(Sender: TObject);
    procedure IncrementoIndividual1Click(Sender: TObject);
    procedure IncrementoGeneral1Click(Sender: TObject);
  private
    FSinDescuento: boolean;
    sAreaVenta, iarticulos, iclaveAlterna:String;
    sFacturaGlobal, sNotaGlobal, sTicketGlobal, sAjusteGlobal, sCotizaGlobal, sDevolucionGlobal : String;
    sPedidoGlobal, sComprobanteDef, sNumComp, sVenta, sVentaRef, sClavePedido, sCantidadNegativa : String;
    bLetras, bCantidadAuto, bCodigoEnter, bLimiteCred, bEliminaArtSinExistencia, bAgrupar : boolean;
    iNumero, iCliente, iConsec, iCaja, iPrecio, iVendedor : integer;
    rLimiteCredito, rRedondeo, rCambio, rTotal, rIva, rNumArticulos, rMoneda, rDescuentos : real;
    rango1, rango2, rango3, rango4, rango5:real;
    precio1, precio2,precio3,precio4,precio5, precio6:real;



    procedure AjustaVentana;
    procedure RecuperaConfig;
    procedure BuscaArticulo;
    function BuscaArticuloAlterno:Boolean;
    procedure Inicializa;
    function Rellena(sTexto : String; iCantidad : Integer; sAlineacion : String):String;
    procedure Total;
    procedure RecuperaConsec;
    procedure GuardaDatos;
    procedure VerificaDescuento(iRenglon: integer);
    procedure VerificaCantidad(iRenglon: integer);
    procedure RecuperaAreaVenta;
    procedure EliminaArea;
    function VerificaDatos:boolean;
    function VerificaNumNota(sComprobante, sTipoComp : String) : boolean;
    procedure VerificaPrecios(iClaveCliente : integer);
    procedure VerificaDescuentoTotal;
    procedure CodigoFoco;
    procedure RecuperaVenta;
    function VerificaDevolucion:boolean;
    procedure LimpiaArticulos;
    procedure EliminarDetallePedido;
    procedure CambiarEstatusPedido;
    procedure EliminaArtSinExistencia;
    function verificafiscal:boolean;
    function verifica_precios(cantidad:real):real;
     function verifica_precios2(cantidad:real; codigo:string):real;
     procedure cfdpre;
  public
    iUsuario : integer;
    sUsuario: String;
    facturarotro,ifacturable:boolean;
    articuloencontrado:boolean;
    bfiscal : boolean;
    siva : string;
    iiva: integer;
    ivageneral: real;
    fcambio:boolean;
    cambiob:boolean;
    cambio: boolean;
   
  end;

var
  frmVentas: TfrmVentas;


implementation

uses dm, Autoriza, ArticuloBusq, ClientesBusq, Pago, Cambio,
  AreasVentaBusq, TipoComprobante, Cantidad, VentaRecupera, Clientes, Reimprimir,
  Cliente, Calc, Consecutivos, NotaCredito, Comentario, Pedidos, VendedoresBusq, cfdpre;

{$R *.xfm}

procedure TfrmVentas.FormShow(Sender: TObject);
begin


    grdDatos.Cells[21,grdDatos.RowCount-1]:= '';
    cambio:= false;
    sAreaVenta := '';
    RecuperaConfig;
    tmeHora.Enabled := true;
    Caption := 'Ventas - ' + FormatDateTime('dd/mm/yyyy',Date);
    txtUsuario.Text := sUsuario;

    AjustaVentana;
    txtDescuento.Value := 0;
    iCliente := 0;
    iVendedor := 0;

    FSinDescuento:= false;
    bEliminaArtSinExistencia := false;
    rLimiteCredito := 0;
    sVentaRef := 'null'; // Eliminar referencia con otra venta
    sClavePedido:= '';

    RecuperaConsec;
    Inicializa;
    RecuperaAreaVenta;
    cambiob := FALSE;
end;

procedure TfrmVentas.AjustaVentana;
begin
    Top := 0;
    Left := 0;
    Height := Screen.Height - 32;
    Width := Screen.Width - 6;

    //Establece los encabezados, el tama�o de las celdas y el tama�o de letra
    grdVenta.RowCount := 2;
    grdVenta.Cells[0,0] := 'No.';
    grdVenta.Cells[1,0] := 'Art�culo';
    grdVenta.Cells[2,0] := 'Cantidad';
    grdVenta.Cells[3,0] := 'Precio unit.';
    grdVenta.Cells[4,0] := 'Desc.';
    grdVenta.Cells[5,0] := 'Precio neto';
    grdVenta.Cells[6,0] := 'Importe';

    grdVenta.ColWidths[0] := StrToInt(FormatFloat('0',40 * Width / 800));
    grdVenta.ColWidths[1] := StrToInt(FormatFloat('0',265 * Width / 800));
    grdVenta.Font.Size:=16;

    grdVenta.ColWidths[2] := StrToInt(FormatFloat('0',80 * Width / 800));
    grdVenta.ColWidths[3] := StrToInt(FormatFloat('0',100 * Width / 800));
    grdVenta.ColWidths[4] := StrToInt(FormatFloat('0',70 * Width / 800));
    grdVenta.ColWidths[5] := StrToInt(FormatFloat('0',100 * Width / 800));
    grdVenta.ColWidths[6] := StrToInt(FormatFloat('0',110 * Width / 800));
  //  grdVenta.Font.Size := StrToInt(FormatFloat('0',12 * Width / 800));
    grdVenta.DefaultRowHeight := StrToInt(FormatFloat('0',20 * Width / 800));
end;

procedure TfrmVentas.RecuperaConfig;
var
    iniArchivo : TIniFile;
    sValor : String;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'config.ini');

    with iniArchivo do begin
   //recupera IVA general
     siva := ReadString('IVA', 'ivageneral', '');
    iiva := StrToInt(siva);
    ivageneral := iiva / 100;

        //Recupera el n�mero de caja
        sValor := ReadString('Config', 'Caja', '');
        if (Length(sValor) > 0) then
            iCaja := StrToInt(sValor);

        //Recupera el �rea de venta por default
        sValor := ReadString('Config', 'AreaVenta', '');
        if (Length(sValor) > 0) then
            sAreaVenta := sValor;

        //Recupera la cantidad automatica
        sValor := ReadString('Config', 'Cantidad', '');
        if (sValor= 'S') then
            bCantidadAuto := true
        else
            bCantidadAuto := false;

        //Recupera el enter en el c�digo
        sValor := ReadString('Config', 'CodigoEnter', '');
        if (sValor= 'S') then
            bCodigoEnter := true
        else
            bCodigoEnter := false;

        //Recupera el estado de la barra de botones
        sValor := ReadString('Ventas', 'Barra', '');
        if (sValor= 'S') then begin
            mnuBarra.Checked := true;
            pnlBotones.Visible := true;
        end
        else begin
            mnuBarra.Checked := false;
            pnlBotones.Visible := false;
        end;

        //Recupera la opcion de agrupar articulos
        sValor := ReadString('Config', 'Agrupar', '');
        if (sValor= 'S') then
            bAgrupar := true
        else
            bAgrupar := false;

        Free;
    end;

    with dmDatos.qryConsulta do begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT * FROM config');
        Open;

        rMoneda := FieldByName('monedamenor').AsFloat;

        if(FieldByName('letraencodigo').AsString = 'S' ) then
            bLetras := true
        else
            bLetras := false;

        if(FieldByName('limitecred').AsString = 'S' ) then
            bLimiteCred := true
        else
            bLimiteCred := false;

        sComprobanteDef := FieldByName('comprobantedef').AsString;
        if(sComprobanteDef = 'N' ) then
            sComprobanteDef := 'NOTA'
        else if(sComprobanteDef = 'F' ) then
            sComprobanteDef := 'FACTURA'
        else if(sComprobanteDef = 'C' ) then
            sComprobanteDef := 'COTIZACION'
        else if(sComprobanteDef = 'A' ) then
            sComprobanteDef := 'AJUSTE'
        else
            sComprobanteDef := 'TICKET';
        txtComprobante.Text := sComprobanteDef;

        iPrecio := FieldByName('precio').AsInteger;
        if(iPrecio = 0) then
            iPrecio := 1;
        txtPrecio.Value := iPrecio;

        sFacturaGlobal := FieldByName('facturaglobal').AsString;
        sNotaGlobal := FieldByName('notaglobal').AsString;
        sTicketGlobal := FieldByName('Ticketglobal').AsString;
        sAjusteGlobal := FieldByName('ajusteglobal').AsString;
        sCotizaGlobal := FieldByName('cotizacionglobal').AsString;
        sDevolucionGlobal := FieldByName('devolucionglobal').AsString;
        sPedidoGlobal := FieldByName('pedidoglobal').AsString;
        sCantidadNegativa := FieldByName('cantidadnegativa').AsString;
        Close;
    end;
end;

procedure TfrmVentas.txtCajaEnter(Sender: TObject);
begin
    CodigoFoco;
end;

procedure TfrmVentas.txtCodigoKeyPress(Sender: TObject; var Key: Char);
begin
    if(not bLetras) then
        if not (Key in ['0'..'9',#8]) then
            Key := #0;
end;

procedure TfrmVentas.txtCodigoKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
    if (Key = Key_Up) then begin
        if(grdVenta.Row > 1) then
            grdVenta.Row := grdVenta.Row - 1;
    end
    else if (Key = Key_Down) then begin
        if(grdVenta.Row < grdVenta.RowCount - 1) then
            grdVenta.Row := grdVenta.Row + 1;
    end
    else if(Key = Key_Enter) or (Key = Key_Return) or (bCodigoEnter) then
        BuscaArticulo;
end;


function TfrmVentas.BuscaArticuloAlterno:Boolean;
var
 ifiscal:real;
begin
    with dmDatos.qryConsulta do
     begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT distinct a.clave, o.codigo, a.fiscal');
        SQL.Add('FROM articulos a LEFT JOIN codigos o ON a.clave = o.articulo');
        SQL.Add('WHERE a.estatus = ''A'' AND a.tipo <> 4 AND o.codigo = ' + txtCodigo.Text);
        Open;
        if(not Eof) then
         begin
           ifiscal:= FieldByName('fiscal').AsFloat;
           iclavealterna :=FieldByName('clave').AsString;
           Close;
           if iFiscal >= StrToFloat(iArticulos) then
             articuloencontrado:=true
           else
            articuloencontrado:=false;
         end;
     end; //With
end;


procedure TfrmVentas.BuscaArticulo;
var
    iClave, iTipo, iRen, ifiscal : Integer;
    sDescrip, sDescripLarga, sDescAuto, sCodigo, sCateg, sDepto, sPrecio, sCantidad_Cnt  : string;
    fPrecio, fIva : Real;
    bAgrupado: Boolean;
begin
    with dmDatos.qryConsulta do begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT a.clave, o.codigo, a.desc_corta, a.desc_larga, a.tipo, a.desc_auto, a.cantidad_cnt, ');
        SQL.Add('a.categoria, a.departamento, a.iva, a.precio1, a.precio2, a.precio3, a.precio4, a.precio5, a.ult_costo, a.rango1, a.rango2,a.rango3, a.rango4, a.rango5, a.fiscal'); // Modificacion para ajuste a.ult_costo
        SQL.Add('FROM articulos a LEFT JOIN codigos o ON a.clave = o.articulo');
        SQL.Add('WHERE a.estatus = ''A'' AND a.tipo <> 4 AND a.clave IN (SELECT articulo FROM codigos WHERE codigo = ''' + txtCodigo.Text + ''')');
        Open;

        if(not Eof) then begin
            if(iNumero = -1) then
                Inicializa;

            iClave := FieldByName('clave').AsInteger;
            sCodigo := Trim(FieldByName('codigo').AsString);
            sDescrip := Trim(FieldByName('desc_corta').AsString);
            sDescripLarga :=Trim(FieldByName('desc_larga').AsString);

            precio1:=FieldByname('precio1').AsFloat;
            precio2:=FieldByname('precio2').AsFloat;
            precio3:=FieldByname('precio3').AsFloat;
            precio4:=FieldByname('precio4').AsFloat;
            precio5:=FieldByname('precio5').AsFloat;
            precio6:=FieldByname('ult_costo').AsFloat;   // modificacion para ajuste

         //   rango1:=FieldByName('rango1').AsInteger;
         //   rango2:=FieldByName('rango2').AsInteger;
         //   rango3:=FieldByName('rango3').AsInteger;
         //   rango4:=FieldByName('rango4').AsInteger;

            rango1:=FieldByName('rango1').AsFloat;
            rango2:=FieldByName('rango2').AsFloat;
            rango3:=FieldByName('rango3').AsFloat;
            rango4:=FieldByName('rango4').AsFloat;

            //Busca articulos similares en la columna de codigos
            iRen:= grdDatos.Cols[1].IndexOf(sCodigo);
            if (bAgrupar) and (iRen <> -1) and (iNumero <> -1) then
            begin
                grdVenta.Cells[2, iRen + 1]:= FloatToStr(StrToFloat(grdVenta.Cells[2,iRen + 1]) + 1); //StrToInt
                grdDatos.Cells[3, iRen]:= grdVenta.Cells[2, iRen + 1];
                ActualizaRenglon(iRen);
                bAgrupado:= True;
            end
            else
            begin
                //Arma la cadena para determinar que campo le corresponde al precio ('precio1', precio2...)

                sPrecio := 'precio' + FloatToStr(txtPrecio.Value);


                if(txtPrecio.Value = 0) then
                    fPrecio := FieldByName('precio1').AsFloat
                else
                  if((txtPrecio.Value <> 6) and (txtPrecio.Value <> 0)) then   //modifica ajuste
                begin                                                          //modifica ajuste
                  fPrecio := FieldByName(sPrecio).AsFloat;                     //modifica ajuste
                 end;                                                          //modifica ajuste

                if(txtPrecio.Value = 6) then                                   //modifica ajuste
                begin                                                          //modifica ajuste
                   fPrecio := precio6;                                         //modifica ajuste
                end;                                                           //modifica ajuste



                fIva := FieldByName('iva').AsFloat;
                iTipo := FieldByName('tipo').AsInteger;
                sDescAuto := FieldByName('desc_auto').AsString;
                sCateg := FieldByName('categoria').AsString;
                sDepto := FieldByName('departamento').AsString;
                sCantidad_Cnt := FieldByName('cantidad_cnt').AsString;
                ifiscal := FieldByName('fiscal').AsInteger;
                Inc(iNumero);
                grdDatos.RowCount := iNumero + 1;

                // Guarda los datos del art�culo en un gri no visible
                grdDatos.Cells[0,iNumero] := IntToStr(iClave);      // Clave del art�culo
                grdDatos.Cells[1,iNumero] := sCodigo;               // C�digo
                grdDatos.Cells[2,iNumero] := sDescripLarga;       //sDescrip;  modificacion jul/09            // Descripci�n del art�culo
                grdDatos.Cells[3,iNumero] := '1';                   // Cantidad de art�culos (por default 1)
                grdDatos.Cells[4,iNumero] := FloatToStr(fPrecio);   // Precio del art�culo
                grdDatos.Cells[5,iNumero] := FloatToStr(fIva);      // I.V.A. del art�culo
                grdDatos.Cells[6,iNumero] := IntToStr(iTipo);       // Tipo de art�culo (A granel, Juego, etc.
                grdDatos.Cells[7,iNumero] := sDescAuto;             // Descuento autom�tico del art�culo
                grdDatos.Cells[8,iNumero] := '0';                   // Descuento otorgado
                grdDatos.Cells[9,iNumero] := '0';                   // Descuento por fechas
                grdDatos.Cells[10,iNumero] := sCateg;               // Categor�a
                grdDatos.Cells[11,iNumero] := sDepto;               // Departamento
                grdDatos.Cells[12,iNumero] := '0';                  // Orden, solo �til para devoluciones
                grdDatos.Cells[13,iNumero] := '0';                  // Descuento otorgado por usuario
                grdDatos.Cells[14,iNumero] := '';                   // Comentario
                grdDatos.Cells[15,iNumero] := FormatDateTime('mm/dd/yyyy',Date);  // Fecha de inserci�n util para pedidos
                grdDatos.Cells[16,iNumero] := sCantidad_Cnt;        // controlar cantidad del articulo en el almac�n
                grdDatos.Cells[17,iNumero] := inttostr(ifiscal);     //Existencia Fiscal
                grdDatos.Cells[18,iNumero] := intTostr(iClave);     //Clave del Articulo Alterna

                // Guarda los datos del art�culo en un grid que se muestra en la pantalla
                grdVenta.RowCount := iNumero + 2;
                grdVenta.Cells[0,iNumero + 1] := IntToStr(iNumero + 1);          // Consecutivo
                grdVenta.Cells[1,iNumero + 1] := sDescripLarga;                       // Descripci�n corta
                grdVenta.Cells[2,iNumero + 1] := '1';                            // Cantidad
                grdVenta.Cells[3,iNumero + 1] := FloatToStr(fPrecio);            // Precio
                grdVenta.Cells[4,iNumero + 1] := grdDatos.Cells[8,iNumero];      // Descuento
                grdVenta.Cells[5,iNumero + 1] := FloatToStr(fPrecio*(1-StrToFloat(grdDatos.Cells[8,iNumero])/100));        // Precio neto
                grdVenta.Cells[6,iNumero + 1] := grdVenta.Cells[5,iNumero + 1];  // Importe
                grdVenta.Row := iNumero + 1;
                GuardaRenglon(iNumero); // Guarda los datos del art�culo en la tabla ventasareas
                bAgrupado:= False;
            end;

            VerificaDescuento(iNumero);
            Total;

            txtCodigo.Clear;
            if (not bAgrupado) then //(bCantidadAuto) and
                mnuCantidadClick(txtCodigo)
            else
                VerificaCantidad(iNumero);
        end;
        Close;
    end;

    if(bEliminaArtSinExistencia) then
        EliminaArtSinExistencia;

end;

procedure TfrmVentas.VerificaDescuento(iRenglon: integer);
var
    rDescFechas : real;
    sDepto: String;
    sCateg: String;
    sCantidad: String;
begin
    if(not FSinDescuento) then begin
        sDepto:= grdDatos.Cells[11,iRenglon];
        sCateg:= grdDatos.Cells[10,iRenglon];
        sCantidad:= grdDatos.Cells[3,iRenglon];
        with dmDatos.qryAuxiliar1 do begin
            Close;
            SQL.Clear;
            SQL.Add('SELECT MAX(porcentaje) AS porcent, MAX(cantidad) AS cantidad FROM descuentos');
            SQL.Add('WHERE fechaini <= ''' + FormatDateTime('mm/dd/yyyy',Date) + ''' AND ');
            SQL.Add('fechafin >= ''' + FormatDateTime('mm/dd/yyyy',Date) + '''');
            SQL.Add('AND (articulo = ' + grdDatos.Cells[0,iRenglon]);
            if(Length(sDepto) > 0) then
                SQL.Add('OR departamento = ' + sDepto);
            if(Length(sCateg) > 0) then
                SQL.Add('OR categoria = ' + sCateg);

            SQL.Add(') AND volumen <= ' + sCantidad);
            Open;

            //if(not Eof) then begin
           // if(not Eof) then begin
          //  if RowsAffected>0 then Begin
              if(not Eof) then begin
              // Si el porcentaje convertido a cantida es mayor que la cantidad
              if((FieldByName('porcent').AsFloat / 100) * StrToFloat(grdDatos.Cells[4,iRenglon]) > FieldByName('cantidad').AsFloat) then
                  rDescFechas := FieldByName('porcent').AsFloat
              else
                  rDescFechas := FieldByName('cantidad').AsFloat / StrToFloat(grdDatos.Cells[4,iRenglon]) * 100;

              grdDatos.Cells[9,iRenglon] :=  FloatToStr(rDescFechas); // Descuento por fechas

              if(txtDescuento.Value > rDescFechas) and (grdDatos.Cells[7,iRenglon] = 'S') then
                  grdDatos.Cells[8,iRenglon] := FloatToStr(txtDescuento.Value)     // Se asgina descuento por cliente
              else
                  grdDatos.Cells[8,iRenglon] := FloatToStr(rDescFechas);  // Se asigna descuento por fechas

              grdVenta.Cells[4,iRenglon + 1] := grdDatos.Cells[8,iRenglon]; //Se muestra el descuento otorgado
            end
            else
            if(txtDescuento.Value > 0) and (grdDatos.Cells[7,iRenglon] = 'S') then begin
                grdDatos.Cells[8,iRenglon] := FloatToStr(txtDescuento.Value);     // Se asigna descuento por cliente
                grdVenta.Cells[4,iRenglon + 1] := grdDatos.Cells[8,iRenglon]; //Se muestra el descuento otorgado
            end;

            Close;
        end;
    end;
end;

procedure TfrmVentas.VerificaDescuentoTotal;
var
    i : integer;
    rDescTotal, rTotalSinDesc, rTotalConDesc, rTotalNormal : real;
begin
    if(iNumero <> -1) and (not FSinDescuento) then begin
        with dmDatos.qryConsulta do begin
            rTotalSinDesc := 0;
            rTotalNormal := 0;
            // Suma los importes de los art�culos sin descuentos para sacar un total
            for i := 0 to iNumero do begin
                rTotalSinDesc := rTotalSinDesc + StrToFloat(grdDatos.Cells[3,i]) * StrToFloat(grdDatos.Cells[4,i]);
                rTotalNormal := rTotalNormal + StrToFloat(grdDatos.Cells[4,i]) *
                                StrToFloat(grdDatos.Cells[3,i]) * (1 - StrToFloat(grdDatos.Cells[8,i]) / 100);
            end;

            Close;
            SQL.Clear;
            SQL.Add('SELECT total, porcentaje, cantidad FROM descuentos WHERE total <= ' + FloatToStr(rTotalSinDesc));
            SQL.Add('AND total > 0 AND fechaini <= ''' + FormatDateTime('mm/dd/yyyy',Date) + ''' AND ');
            SQL.Add('fechafin >= ''' + FormatDateTime('mm/dd/yyyy',Date) + ''' ORDER BY total DESC');
            Open;

            if(not Eof) then begin
                if((FieldByName('porcentaje').AsFloat / 100) * StrToFloat(grdDatos.Cells[4,iNumero]) > FieldByName('cantidad').AsFloat) then
                    rDescTotal := FieldByName('porcentaje').AsFloat
                else
                    rDescTotal := FieldByName('cantidad').AsFloat / StrToFloat(grdDatos.Cells[4,iNumero]) * 100;

                // Calcula el total que generar�a con el descuento
                rTotalConDesc := rTotalSinDesc * (1 - rDescTotal / 100);

                if (FieldByName('total').AsFloat <= rTotalSinDesc) and (rTotalNormal >= rTotalConDesc) then begin
                    for i := 0 to iNumero do begin
                        grdDatos.Cells[8,i] := FloatToStr(rDescTotal); // Se asigna Descuento por total
                        grdVenta.Cells[4,i+1] := grdDatos.Cells[8,i];  // Se muestra el descuento otorgado
                        grdVenta.Cells[5,i+1] := FloatToStr(StrToFloat(grdDatos.Cells[4,i])*(1-StrToFloat(grdDatos.Cells[8,i])/100));  // Precio neto
                        grdVenta.Cells[6,i+1] := FloatToStr(StrToFloat(grdVenta.Cells[5,i+1])* StrToFloat(grdVenta.Cells[2,i+1]));    // Importe
                    end;
                end
            end
            else begin
                for i := 0 to iNumero do begin
                  if(txtDescuento.Value > StrToFloat(grdDatos.Cells[9,i])) and (grdDatos.Cells[7,i] = 'S') then
                      grdDatos.Cells[8,i] := FloatToStr(txtDescuento.Value)     // Se asgina descuento por cliente
                  else
                  begin
                      if(StrToFloat(grdDatos.Cells[9,i]) > StrToFloat(grdDatos.Cells[13,i])) then
                          grdDatos.Cells[8,i] := grdDatos.Cells[9,i]
                      else
                          grdDatos.Cells[8,i] := grdDatos.Cells[13,i];
                  end;
                  grdVenta.Cells[4,i+1] := grdDatos.Cells[8,i]; // Se muestra el descuento otorgado
                  grdVenta.Cells[5,i+1] := FloatToStr(StrToFloat(grdDatos.Cells[4,i])*(1-StrToFloat(grdDatos.Cells[8,i])/100));  // Precio neto
                  grdVenta.Cells[6,i+1] := FloatToStr(StrToFloat(grdVenta.Cells[5,i+1])* StrToFloat(grdVenta.Cells[2,i+1]));    // Importe
                end;
            end;
        end;
    end;
end;

procedure TfrmVentas.VerificaCantidad(iRenglon: integer);
var
    i : Integer;
    rConteo, rExistencia, rMinimo, rFaltaMin: real;
    sClave : String;
begin

    // articulo sin controle de cantidad en el almac�n
    if(grdDatos.Cells[16,iRenglon] = 'N') then
        Exit;

    rConteo := 0;
    with dmDatos.qryAuxiliar1 do begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT existencia, minimo FROM articulos');
        SQL.Add('WHERE clave = ' + grdDatos.Cells[0,iRenglon]);
        Open;

        rExistencia := FieldByName('existencia').AsFloat;
        rMinimo := FieldByName('minimo').AsFloat;
        sClave := grdDatos.Cells[0,iRenglon];
        Close;

        // el quantidade ya assignada
        for i:=0 to iNumero do begin
            if(grdDatos.Cells[0,i] = sClave) then
                rConteo := rConteo + StrToFloat(grdDatos.Cells[3,i]);
        end;

        rExistencia := rExistencia - rConteo;
        if(rExistencia < 0) then begin
            Application.MessageBox('Art�culo sin disponibilidad en el almac�n','Informaci�n',[smbOK],smsWarning);

            // No permitir cantidad negativa del articulo en el almac�n
            if(sCantidadNegativa = 'N') then
                bEliminaArtSinExistencia := true;

        end
        else begin
            rFaltaMin := rMinimo - rExistencia;

            if (rFaltaMin >= 0) then
                Application.MessageBox('El art�culo alcanz� el disponibilidad m�nima del almac�n','Informaci�n',[smbOK],smsWarning)
            else
            if (rExistencia <= (StrToFloat(grdDatos.Cells[3,iRenglon]) - rConteo + rMinimo)) then begin
                Application.MessageBox('El art�culo no tiene disponibilidad para la cantidad informada','Informaci�n',[smbOK],smsWarning);

                // No permitir cantidad negativa del articulo en el almac�n
                if(sCantidadNegativa = 'N') then
                    bEliminaArtSinExistencia := true;
            end;
        end;
    end;
end;

procedure TfrmVentas.Inicializa;
var cont,cont2:integer;
begin
    txtCodigo.Clear;
    if(iCliente > 0) then begin
        txtCliente.Visible := true;
        lblCliente.Visible := true;
    end
    else begin
        txtCliente.Visible := false;
        lblCliente.Visible := false;
        txtCliente.Clear;
    end;

    if(txtDescuento.Value > 0) then begin
        lblDescuento.Visible := true;
        txtDescuento.Visible := true;
    end
    else begin
        lblDescuento.Visible := false;
        txtDescuento.Visible := false;
    end;

    grdVenta.RowCount := 2;
    grdVenta.Cells[0,1] := '';
    grdVenta.Cells[1,1] := '';
    grdVenta.Cells[2,1] := '';
    grdVenta.Cells[3,1] := '';
    grdVenta.Cells[4,1] := '';
    grdVenta.Cells[5,1] := '';
    grdVenta.Cells[6,1] := '';
     for cont:=0 to grdDatos.RowCount do
     begin
     for cont2:=0 to 21 do
     begin
     grdDatos.Cells[cont2,cont] := '';
     end;

     end;
    grdDatos.RowCount := 1;

    iNumero := -1;

    txtTotal.Value := 0;
    txtCaja.Value := iCaja;

    pnlEncab.Height:= 60;
end;

function TfrmVentas.Rellena(sTexto : String; iCantidad : Integer; sAlineacion : String):String;
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

procedure TfrmVentas.Total;
var
    i: Integer;
    rPrecio, rResiduo: Real;

begin
    rDescuentos := 0;
    rRedondeo := 0;
    rTotal := 0;
    rIva := 0;
    rNumArticulos := 0;

    VerificaDescuentoTotal;

    for i:=0 to iNumero do begin
        rPrecio := StrToFloat(grdDatos.Cells[4,i]) *
                   StrToFloat(grdDatos.Cells[3,i]) *
                   (1 - StrToFloat(grdDatos.Cells[8,i]) / 100);
        if(StrToFloat(grdDatos.Cells[8,i]) > 0) then
            rDescuentos := rDescuentos + rPrecio;

        if(Frac(StrToFloat(grdDatos.Cells[3,i])) > 0) then
            rNumArticulos := rNumArticulos + 1
        else
            rNumArticulos := rNumArticulos + StrToFloat(grdDatos.Cells[3,i]);
        rTotal := rTotal + rPrecio;
        rIva := rIva + (rPrecio - (rPrecio /(1 + StrToFloat(grdDatos.Cells[5,i]) / 100)));
    end;
    rTotal := StrToFloat(Format('%8.2f',[rTotal]));

    rResiduo := rTotal - (Int(rTotal / rMoneda) * rMoneda);
    if(rResiduo > 0 ) then begin
        if(rResiduo < rMoneda / 2) then
            rRedondeo := rMoneda - rResiduo
        else
            rRedondeo :=  rMoneda - rResiduo;
    end;
    rTotal := rTotal + rRedondeo;
    if((rRedondeo>0) AND (rIva > 0))then begin
    if ( txtcomprobante.Text<>'FACTURA') then begin
    rIva:=rTotal-(rTotal/(1+ivageneral));  //1.15
    end
    else
    begin
    rTotal:=rTotal-rRedondeo;
    end;
    end;

    txtTotal.Value := rTotal;
end;

procedure TfrmVentas.RecuperaConsec;
begin
    with dmDatos.qryConsulta do begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT MAX(numero) AS numero FROM ventas WHERE caja = ' + IntToStr(iCaja));
        SQL.Add('AND estatus = ''A''');
        Open;
        iConsec := FieldByName('numero').AsInteger + 1;
//        txtRemision.Value := iConsec;
        Close;
    end;
end;

procedure TfrmVentas.grdVentaDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var
    sCad : String;
    i : real;
begin
    sCad := (Sender as TStringGrid).Cells[ACol,ARow];
    if(Length(sCad) > 0) then begin
        if(ARow = 0) or (ACol = 0) then begin
            if(ACol = 0) and (ARow > 0) then
            begin
                if(Length(Trim(grdDatos.Cells[14,ARow-1])) > 0) then
                    sCad := '�' + sCad + '�';
                 if(Length(Trim(grdDatos.Cells[21,ARow-1])) > 0) then
                    sCad := '<' + sCad + '>';
              end;
            i := Rect.Left + (Rect.Right - Rect.Left) / 2 - (Sender as TStringGrid).Canvas.TextWidth(sCad) / 2;
            (Sender as TStringGrid).Canvas.FillRect(Rect);
            (Sender as TStringGrid).Canvas.TextOut(Round(i),Rect.Top + 2,sCad);
        end;




        if(ACol > 1) and (ARow > 0) then begin
            if(ACol <> 2) then
                sCad := FormatFloat('#,##0.00',StrToFloat(sCad))
            else
                sCad := FormatFloat('#,##0.000',StrToFloat(sCad));

            if(ACol = 4) then
                sCad := sCad + '%';
            i := Rect.Right - (Sender as TStringGrid).Canvas.TextWidth(sCad + ' ');
            (Sender as TStringGrid).Canvas.FillRect(Rect);
            (Sender as TStringGrid).Canvas.TextOut(Round(i),Rect.Top + 2,sCad);
        end;
    end;
end;

procedure TfrmVentas.FormClose(Sender: TObject; var Action: TCloseAction);
var
    iniArchivo : TIniFile;
begin
    // Se asigna falso para que al volver a entrar a la ventana no borre el detalle de la venta
    tmeHora.Enabled := false;

    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) +'config.ini');
    with iniArchivo do begin
        // Registra estado de la barra de botones
        if(mnuBarra.Checked) then
            WriteString('Ventas', 'Barra', 'S')
        else
            WriteString('Ventas', 'Barra', 'N');
        Free;
    end;
end;

procedure TfrmVentas.tmeHoraTimer(Sender: TObject);
begin
    txtHora.Text := FormatDateTime('hh:nn:ss',Now);
end;

procedure TfrmVentas.grdVentaMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
    grcRenglon : TGridCoord;
begin
    if(Button = mbRight) then begin
        grcRenglon := grdVenta.MouseCoord(X, Y);
        if(grcRenglon.y >= 1) then
            grdVenta.Row := grcRenglon.y;
    end;
    CodigoFoco;
end;

procedure TfrmVentas.mnuCancelarVentaActualClick(Sender: TObject);
var
    bAutoriza : boolean;
begin
    if(iNumero <> - 1) or (iCliente > 0) then begin //Si hay cuando menos un art�culo o un cliente
        bAutoriza := true;
        with TFrmAutoriza.Create(Self) do
        try
            if(not VerificaAutoriza(Self.iUsuario,'V04')) then begin
                sMensaje := '(Caja ' + IntToStr(iCaja) + ')';
                sTipoAutoriza := 'V04';
                iUsuario := Self.iUsuario;
                ShowModal;
                bAutoriza := bAutorizacion;
            end
            else
                if(Application.MessageBox('Se cancelar� la venta actual','Cancelar',[smbOK]+[smbCancel],smsWarning) = smbCancel) then
                    bAutoriza := false;
        finally
            Free;
        end;
        if bAutoriza then begin
            LimpiaArticulos;
            txtComprobante.Text := sComprobanteDef;
            Botones;
            txtPrecio.Value := iPrecio;
        end;
        CodigoFoco;
    end;
end;

procedure TfrmVentas.LimpiaArticulos;
begin
    EliminaArea;
     grdDatos.Cells[21,grdDatos.RowCount-1]:= '';
    txtDescuento.Value := 0;
    iCliente := 0;
    iVendedor:= 0;
    FSinDescuento:= false;
    rLimiteCredito := 0;
    sVentaRef := 'null'; // Eliminar referencia con otra venta
    sClavePedido:= '';
    Inicializa;
end;

procedure TfrmVentas.mnuPrecioClick(Sender: TObject);
var
    rPrecio : real;
    bAutoriza : boolean;
begin
    if(iNumero <> -1) then begin //Si hay cuando menos un art�culo
        with TFrmAutoriza.Create(Self) do
            try
                if(not VerificaAutoriza(Self.iUsuario,'V06')) then begin
                    sMensaje := '(Caja ' + IntToStr(iCaja) + ', articulo: ' + grdVenta.Cells[2,grdVenta.Row] + ')';
                    sTipoAutoriza := 'V06';
                    iUsuario := Self.iUsuario;
                    ShowModal;
                    bAutoriza := bAutorizacion;
                end
                else
                    bAutoriza := true;
            finally//frmautoriza
                Free;
            end;
            if(bAutoriza) then begin
                rPrecio := StrToFloat(grdVenta.Cells[3,grdVenta.Row]);
                with TfrmCantidad.Create(Self) do
                try
                    sTitulo := 'Precio';
                    rCantidad := rPrecio;
                    bDecimales := true;
                     cajch.Visible:=false;
                     cajas.Visible:=false;

                     with dmDatos.qryConsulta do begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT precio1,precio2,precio3,precio4,precio5, rango1, rango2, rango3, rango4, rango5, e1,e2,e3,e4,e5 FROM articulos WHERE clave = ' + grdDatos.Cells[0,grdVenta.Row-1]);
        Open;

        if(not Eof) then begin
        pre.Visible:=true;

            r1.Visible := true;
            r2.Visible := true;
            r3.Visible := true;
            r4.Visible := true;
            r5.Visible := true;
            ra1.Visible := true;
            ra2.Visible := true;
            ra3.Visible := true;
            ra4.Visible := true;
            ra5.Visible := true;

            v1.Visible := true;
            v2.Visible := true;
            v3.Visible := true;
            v4.Visible := true;
            v5.Visible := true;
            pre.Visible := true;
            rango.Visible := true;



            r1.Caption:=  Trim(FieldByname('e1').AsString);
            r2.Caption:=  Trim(FieldByname('e2').AsString);
            r3.Caption:=  Trim(FieldByname('e3').AsString);
            r4.Caption:=  Trim(FieldByname('e4').AsString);
            r5.Caption:=  Trim(FieldByname('e5').AsString);

            ra1.Caption:=  '1';
            ra2.Caption:=  Trim(floattostr(strtofloat(FieldByname('rango1').AsString)+1));
            ra3.Caption:=  Trim(floattostr(strtofloat(FieldByname('rango2').AsString)+1));
            ra4.Caption:=  Trim(floattostr(strtofloat(FieldByname('rango3').AsString)+1));
            ra5.Caption:=  Trim(floattostr(strtofloat(FieldByname('rango4').AsString)+1));

            v1.Caption:=  Trim(FieldByname('precio1').AsString);
            v2.Caption:=  Trim(FieldByname('precio2').AsString);
            v3.Caption:=  Trim(FieldByname('precio3').AsString);
            v4.Caption:=  Trim(FieldByname('precio4').AsString);
            v5.Caption:=  Trim(FieldByname('precio5').AsString);

        end;
        Close;
    end;

                    ShowModal;





                    if(rCantidad > 0) then begin
                    cambio:= true;
                        rPrecio := rCantidad;
                        grdVenta.Cells[3,grdVenta.Row] := FloatToStr(rPrecio);  // Precio unitario
                        grdDatos.Cells[4,grdVenta.Row-1] := FloatToStr(rPrecio); // Precio unitario en el grid datos
                        grdVenta.Cells[5,grdVenta.Row] := FloatToStr(StrToFloat(grdVenta.Cells[3,grdVenta.Row]) *
                                                          (1 - StrToFloat(grdVenta.Cells[4,grdVenta.Row]) / 100));    // Precio neto
                        grdVenta.Cells[6,grdVenta.Row] := FloatToStr(StrToFloat(grdVenta.Cells[5,grdVenta.Row]) *
                                                            StrToFloat(grdVenta.Cells[2,grdVenta.Row]));    // Importe
                        ActualizaRenglon(grdVenta.Row-1);
                        Total;

                        grdDatos.Cells[19,grdVenta.Row-1] := '1';
            grdVenta.Refresh;
                ActualizaRenglon(grdVenta.Row-1);
                    end;
                finally //frmcantidad
                    Free;
                end;
            end;
    end;
    CodigoFoco;
end;

procedure TfrmVentas.mnuEliminarClick(Sender: TObject);
var
    bAutoriza : boolean;
    i : integer;
begin
cambiob:=false;
    if(iNumero <> - 1) then begin //Si hay cuando menos un art�culo
        with TfrmAutoriza.Create(Self) do
        try
            if(not VerificaAutoriza(Self.iUsuario,'V03')) then begin
                sMensaje := '(Caja ' + IntToStr(iCaja) + ', articulo ' + grdVenta.Cells[2,grdVenta.Row] + ')';
                sTipoAutoriza := 'V03';
                iUsuario := Self.iUsuario;
                ShowModal;
                bAutoriza := bAutorizacion
            end
            else
                bAutoriza := true;
        finally
            Free;
        end;

        if(bAutoriza) then begin  // Si ya cuenta con autorizaci�n o se dio en tiempo de ejecuci�n

            if(Application.MessageBox('�Desea eliminar el art�culo seleccionado?','Eliminar',
                                          [smbOK,smbCancel], smsWarning) = smbOK) then begin
                //Elimina las ventas pendientes a partir del renglon seleccionado
                with dmDatos.qryModifica do begin
                    Close;
                    SQL.Clear;
                    SQL.Add('DELETE FROM ventasareas WHERE areaventa = ' + sAreaVenta);
                    SQL.Add('AND orden = ' + IntToStr(grdVenta.Row-1));
                    ExecSQL;

                    Close;
                    SQL.Clear;
                    SQL.Add('UPDATE ventasareas SET orden = orden - 1 WHERE areaventa = ' + sAreaVenta);
                    SQL.Add('AND orden > ' + IntToStr(grdVenta.Row-1));
                    ExecSQL;
                    Close;
                end;
                grdDatos.Cells[21,grdVenta.Row-1]:= '';
                for i := grdVenta.Row to grdVenta.RowCount - 2 do begin
                    grdVenta.Cells[0,i+1] := IntToStr(StrToInt(grdVenta.Cells[0,i+1]) - 1);
                    grdVenta.Rows[i] := grdVenta.Rows[i+1];
                    grdDatos.Rows[i-1] := grdDatos.Rows[i];
                end;
                if(grdVenta.RowCount > 2) then begin
                    grdVenta.RowCount := grdVenta.RowCount - 1;
                    grdDatos.RowCount := grdVenta.RowCount - 1;
                end
                else begin
                    grdVenta.Cells[0,1] := '';
                    grdVenta.Cells[1,1] := '';
                    grdVenta.Cells[2,1] := '';
                    grdVenta.Cells[3,1] := '';
                    grdVenta.Cells[4,1] := '';
                    grdVenta.Cells[5,1] := '';
                    grdVenta.Cells[6,1] := '';
                end;
                iNumero := iNumero - 1;
                Total;
            end;
        end;
    end;
    CodigoFoco;
end;
procedure TfrmVentas.mnuCantidadClick(Sender: TObject);
begin
    if(iNumero <> -1) then begin //Si hay cuando menos un art�culo
        with TFrmCantidad.Create(Self) do
        try

            rCantidad := StrToFloat(grdDatos.Cells[3,grdVenta.Row-1]);
            sTitulo := 'Cantidad';

             with dmDatos.qryConsulta do begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT precio1,precio2,precio3,precio4,precio5, rango1, rango2, rango3, rango4, rango5, e1,e2,e3,e4,e5, factor FROM articulos WHERE clave = ' + grdDatos.Cells[0,grdVenta.Row-1]);
        Open;

        if(not Eof) then begin
        pre.Visible:=true;

            r1.Visible := true;
            r2.Visible := true;
            r3.Visible := true;
            r4.Visible := true;
            r5.Visible := true;
            ra1.Visible := true;
            ra2.Visible := true;
            ra3.Visible := true;
            ra4.Visible := true;
            ra5.Visible := true;

            v1.Visible := true;
            v2.Visible := true;
            v3.Visible := true;
            v4.Visible := true;
            v5.Visible := true;
            pre.Visible := true;
            rango.Visible := true;



            r1.Caption:=  Trim(FieldByname('e1').AsString);
            r2.Caption:=  Trim(FieldByname('e2').AsString);
            r3.Caption:=  Trim(FieldByname('e3').AsString);
            r4.Caption:=  Trim(FieldByname('e4').AsString);
            r5.Caption:=  Trim(FieldByname('e5').AsString);

            ra1.Caption:=  '1';
            ra2.Caption:=  Trim(floattostr(strtofloat(FieldByname('rango1').AsString)+1));
            ra3.Caption:=  Trim(floattostr(strtofloat(FieldByname('rango2').AsString)+1));
            ra4.Caption:=  Trim(floattostr(strtofloat(FieldByname('rango3').AsString)+1));
            ra5.Caption:=  Trim(floattostr(strtofloat(FieldByname('rango4').AsString)+1));

            v1.Caption:=  Trim(FieldByname('precio1').AsString);
            v2.Caption:=  Trim(FieldByname('precio2').AsString);
            v3.Caption:=  Trim(FieldByname('precio3').AsString);
            v4.Caption:=  Trim(FieldByname('precio4').AsString);
            v5.Caption:=  Trim(FieldByname('precio5').AsString);
            fac :=   FieldByname('factor').Asfloat;
            if (fac > 0) then
            begin
            if (StrToFloat(grdDatos.Cells[3,grdVenta.Row-1]) > fac) then
            begin
            cajas.Value := StrToFloat(grdDatos.Cells[3,grdVenta.Row-1]) / fac;
            cajch.Checked := true;
            end;
             end;
        end;
        Close;
    end;

            if(grdDatos.Cells[6,grdVenta.Row-1] = '0') then
                bDecimales := true
            else
                bDecimales := false;

            ShowModal;
             if(rCantidad > 0) then
             begin
                grdVenta.Cells[2,grdVenta.Row] := FloatToStr(rCantidad);
                grdDatos.Cells[3,grdVenta.Row-1] := FloatToStr(rCantidad);

                //Modifica los costos
                grdVenta.Cells[3,grdVenta.Row]:=floattostr(Verifica_precios(rcantidad));
                grdDatos.Cells[4,grdVenta.Row-1]:=floattostr(Verifica_precios(rcantidad));

                VerificaDescuento(grdVenta.Row - 1);
                VerificaCantidad(grdVenta.Row - 1);
                ActualizaRenglon(grdVenta.Row-1);

                grdVenta.Cells[5,grdVenta.Row] := FloatToStr(StrToFloat(grdDatos.Cells[4,grdVenta.Row-1])*(1-StrToFloat(grdDatos.Cells[8,grdVenta.Row-1])/100));  // Precio neto
                grdVenta.Cells[6,grdVenta.Row] := FloatToStr(StrToFloat(grdVenta.Cells[5,grdVenta.Row]) * rCantidad);    // Importe

                Total;
             end;
        finally
            Free;
        end;
    end;
    CodigoFoco;
end;

procedure TfrmVentas.mnuCantidadClick2(Sender: TObject);
begin
    if(iNumero <> -1) then begin //Si hay cuando menos un art�culo
        with TFrmCantidad.Create(Self) do
        try
            rCantidad := StrToFloat(grdDatos.Cells[3,grdVenta.Row-1]);
            sTitulo := 'Cantidad';
        with dmDatos.qryConsulta do begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT precio1,precio2,precio3,precio4,precio5, rango1, rango2, rango3, rango4, rango5, e1,e2,e3,e4,e5, factor FROM articulos WHERE clave = ' + grdDatos.Cells[0,grdVenta.Row-1]);
        Open;

        if(not Eof) then begin
        pre.Visible:=true;

            r1.Visible := true;
            r2.Visible := true;
            r3.Visible := true;
            r4.Visible := true;
            r5.Visible := true;
            ra1.Visible := true;
            ra2.Visible := true;
            ra3.Visible := true;
            ra4.Visible := true;
            ra5.Visible := true;

            v1.Visible := true;
            v2.Visible := true;
            v3.Visible := true;
            v4.Visible := true;
            v5.Visible := true;
            pre.Visible := true;
            rango.Visible := true;



            r1.Caption:=  Trim(FieldByname('e1').AsString);
            r2.Caption:=  Trim(FieldByname('e2').AsString);
            r3.Caption:=  Trim(FieldByname('e3').AsString);
            r4.Caption:=  Trim(FieldByname('e4').AsString);
            r5.Caption:=  Trim(FieldByname('e5').AsString);

            ra1.Caption:=  '1';
            ra2.Caption:=  Trim(floattostr(strtofloat(FieldByname('rango1').AsString)+1));
            ra3.Caption:=  Trim(floattostr(strtofloat(FieldByname('rango2').AsString)+1));
            ra4.Caption:=  Trim(floattostr(strtofloat(FieldByname('rango3').AsString)+1));
            ra5.Caption:=  Trim(floattostr(strtofloat(FieldByname('rango4').AsString)+1));

            v1.Caption:=  Trim(FieldByname('precio1').AsString);
            v2.Caption:=  Trim(FieldByname('precio2').AsString);
            v3.Caption:=  Trim(FieldByname('precio3').AsString);
            v4.Caption:=  Trim(FieldByname('precio4').AsString);
            v5.Caption:=  Trim(FieldByname('precio5').AsString);

              fac :=   FieldByname('factor').Asfloat;
              if (fac > 0) then
            begin
            if (StrToFloat(grdDatos.Cells[3,grdVenta.Row-1]) > fac) then
            begin
            cajch.Checked := true;

            cajas.Value := StrToFloat(grdDatos.Cells[3,grdVenta.Row-1]) / fac;

            end;
             end;

        end;
        Close;
    end;


            if(grdDatos.Cells[6,grdVenta.Row-1] = '0') then
                bDecimales := true
            else
                bDecimales := false;

            ShowModal;
             if(rCantidad > 0) then
             begin
                grdVenta.Cells[2,grdVenta.Row] := FloatToStr(rCantidad);
                grdDatos.Cells[3,grdVenta.Row-1] := FloatToStr(rCantidad);

                //Modifica los costos
                grdVenta.Cells[3,grdVenta.Row]:=floattostr(Verifica_precios2(rcantidad,grdDatos.Cells[0,grdVenta.Row-1]));
                grdDatos.Cells[4,grdVenta.Row-1]:=floattostr(Verifica_precios2(rcantidad,grdDatos.Cells[0,grdVenta.Row-1]));

                VerificaDescuento(grdVenta.Row - 1);
                VerificaCantidad(grdVenta.Row - 1);
                ActualizaRenglon(grdVenta.Row-1);

                grdVenta.Cells[5,grdVenta.Row] := FloatToStr(StrToFloat(grdDatos.Cells[4,grdVenta.Row-1])*(1-StrToFloat(grdDatos.Cells[8,grdVenta.Row-1])/100));  // Precio neto
                grdVenta.Cells[6,grdVenta.Row] := FloatToStr(StrToFloat(grdVenta.Cells[5,grdVenta.Row]) * rCantidad);    // Importe

                Total;
             end;
        finally
            Free;
        end;
    end;
    CodigoFoco;
end;

function Tfrmventas.verifica_precios(cantidad:real):real;
Begin

if (txtPrecio.Value = 6) then        //modificacion para ajuste
 begin
  verifica_precios:= precio6;
 end
 else
 begin
   if (cantidad <= rango1) then
   verifica_precios:=precio1
  else if (cantidad>rango1) and (cantidad<=rango2) then
   verifica_precios:=precio2
  else if (cantidad>rango2) and (cantidad<=rango3) then
   verifica_precios:=precio3
   else if (cantidad>rango3) and (cantidad<=rango4) then
   verifica_precios:=precio4
  else
   verifica_precios:=precio5;
End;
end;

function Tfrmventas.verifica_precios2(cantidad:real; codigo:string):real;
Begin

   with dmDatos.qryConsulta do begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT a.clave, a.desc_corta, a.desc_larga, a.tipo, a.desc_auto, a.cantidad_cnt, ');
        SQL.Add('a.categoria, a.departamento, a.iva, a.precio1, a.precio2, a.precio3, a.precio4, a.precio5, a.ult_costo, a.rango1, a.rango2,a.rango3, a.rango4,a.rango5, a.fiscal'); // Modificacion para ajuste a.ult_costo
        SQL.Add('FROM articulos a WHERE a.estatus = ''A'' AND a.tipo <> 4 AND a.clave  = ''' + codigo + '''');

        Open;



            precio1:=FieldByname('precio1').AsFloat;
            precio2:=FieldByname('precio2').AsFloat;
            precio3:=FieldByname('precio3').AsFloat;
            precio4:=FieldByname('precio4').AsFloat;
            precio5:=FieldByname('precio5').AsFloat;
            precio6:=FieldByname('ult_costo').AsFloat;   // modificacion para ajuste

         //   rango1:=FieldByName('rango1').AsInteger;
         //   rango2:=FieldByName('rango2').AsInteger;
         //   rango3:=FieldByName('rango3').AsInteger;
         //   rango4:=FieldByName('rango4').AsInteger;

            rango1:=FieldByName('rango1').AsFloat;
            rango2:=FieldByName('rango2').AsFloat;
            rango3:=FieldByName('rango3').AsFloat;
            rango4:=FieldByName('rango4').AsFloat;
            rango5:=FieldByName('rango5').AsFloat;

        close;
        end;

if (txtPrecio.Value = 6) then        //modificacion para ajuste
 begin
  verifica_precios2:= precio6;
 end
 else
 begin
   if (cantidad <= rango1) then
   verifica_precios2:=precio1
  else if (cantidad>rango1) and (cantidad<=rango2) then
   verifica_precios2:=precio2
  else if (cantidad>rango2) and (cantidad<=rango3) then
   verifica_precios2:=precio3
   else if (cantidad>rango3) and (cantidad<=rango4) then
   verifica_precios2:=precio4
  else
   verifica_precios2:=precio5;
End;
end;



procedure TfrmVentas.mnuArticulosClick(Sender: TObject);
begin

    with TFrmArticuloBusq.Create(Self) do
    try
        ShowModal;
        if bSelec then
         begin
            bGasto := false;
            txtCodigo.Text := sCodigo;
            if facturarotro then
             BuscaArticuloalterno
            else
             BuscaArticulo;
        end;
    finally
        Free;
    end;
    CodigoFoco;
end;

procedure TfrmVentas.mnuClientesClick(Sender: TObject);
var
    bAutoriza : boolean;
begin
    with TFrmAutoriza.Create(Self) do
    try
        if(not VerificaAutoriza(Self.iUsuario,'V02')) then begin
            sMensaje := '(Caja ' + IntToStr(iCaja) + ')';
            sTipoAutoriza := 'V02';
            iUsuario := Self.iUsuario;
            ShowModal;
            bAutoriza := bAutorizacion;
        end
        else
            bAutoriza := true;
    finally
        Free;
    end;

    if(bAutoriza) then

        with TFrmClientesBusq.Create(Self) do
        try
            ShowModal;
            if(bSelec) then begin
                Self.iCliente := StrToInt(sClave);
                txtCliente.Text := sCliente;
                Self.rLimiteCredito := rLimiteCredito;
                if(dteFechaVencim >= Date) then begin
                    txtDescuento.Value := rDescuento;
                end
                else begin
                    txtDescuento.Value := 0;
                    if(Length(sCreden) > 0) then
                        Application.MessageBox('La credencial especificada ha vencido','Error',[smbOK],smsCritical);
                end;

                txtPrecio.Value := iPrecio;
                with dmDatos.qryModifica do begin
                    Close;
                    SQL.Clear;
                    SQL.Add('UPDATE ventasareas SET cliente = ' + IntToStr(Self.iCliente) + ' WHERE areaventa = ' + sAreaVenta);
                    ExecSQL;
                    Close;
                end;
                VerificaPrecios(iCliente);
            end;
        finally
            Free;
        end;
    CodigoFoco;
end;

procedure TfrmVentas.mnuCredencialClick(Sender: TObject);
var
    sCreden : String;
    iPrecioCliente : integer;
begin
    if(InputQuery('Credencial del cliente','Credencial',sCreden)) then begin
        with dmDatos.qryConsulta do begin
            Close;
            SQL.Clear;
            SQL.Add('SELECT clave, nombre, descuento, precio, vencimcreden, limitecredito FROM clientes WHERE credencial  = ''' + sCreden + '''');
            Open;
            if(not Eof) then begin
                iCliente := FieldByName('clave').AsInteger;
                txtCliente.Text := Trim(FieldByName('nombre').AsString);
                iPrecioCliente := FieldByName('precio').AsInteger;
                if(iPrecioCliente = 0) then
                    iPrecioCliente := 1;
                txtPrecio.Value := iPrecioCliente;
                rLimiteCredito := FieldByName('limitecredito').AsFloat;
                if(FieldByName('vencimcreden').AsDateTime >= Date) then begin
                    txtDescuento.Value := FieldByName('descuento').AsFloat;
                end
                else begin
                    txtDescuento.Value := 0;
                    Application.MessageBox('La credencial de ' + txtCliente.Text + ' ha vencido','Error',[smbOK],smsCritical);
                end;
                VerificaPrecios(iCliente);
            end
            else
                Application.MessageBox('No se encontr� la credencial especificada','Error',[smbOK],smsCritical);
            Close;
        end
    end;
    CodigoFoco;
end;

procedure TfrmVentas.VerificaPrecios(iClaveCliente : integer);
var
    i : Integer;
    rPrecio : real;
    aux:string;
begin
    txtCliente.Visible := true;
    lblCliente.Visible := true;

    if(txtDescuento.Value > 0) then begin
        txtDescuento.Visible := true;
        lblDescuento.Visible := true;
    end
    else begin
        txtDescuento.Visible := false;
        lblDescuento.Visible := false;
    end;

    if(txtComprobante.Text = 'DEVOLUCION') then
        Exit;

    for i := 0 to iNumero do begin
        with dmDatos.qryConsulta do begin
            //Rectifica los precios para el cliente
            Close;
            SQL.Clear;
            SQL.Add('SELECT a.clave, o.codigo, a.desc_corta, a.tipo, a.desc_auto,');
            SQL.Add('a.categoria, a.departamento, a.iva, a.precio1, a.precio2, a.precio3, a.ult_costo, a.precio4, a.precio5'); //modificacion para juste
            SQL.Add('FROM articulos a JOIN codigos o ON a.clave = o.articulo WHERE o.codigo = ''' + grdDatos.Cells[1,i] + '''');
            Open;


            if (txtPrecio.Value = 6) then        //modificacion para ajuste
            begin
                rprecio := FieldByName('ult_costo').AsFloat;
            end
            else
            begin
                rPrecio := FieldByName('precio' + FloatToStr(txtPrecio.Value)).AsFloat;
            end;

            {if(rPrecio > 0) then    //Deshabilitar Cod, si no cambia de nuevo precio
             begin
                grdDatos.Cells[4,i] := FloatToStr(rPrecio);
                grdVenta.Cells[3,i+1] := grdDatos.Cells[4,i];  // Precio
             end;}

        end;

        // Si el articulo tiene descuento autom�tico y el descuento del cliente
        // es mayor al descuento por fechas
        if(grdDatos.Cells[7,i] = 'S') and (txtDescuento.Value > StrToFloat(grdDatos.Cells[9,i])) then begin
            grdVenta.Cells[4,i+1] := FloatToStr(txtDescuento.Value);  // Descuento
            grdVenta.Cells[5,i+1] := FloatToStr(StrToFloat(grdVenta.Cells[3,i+1]) *
                                     (1 - StrToFloat(grdVenta.Cells[4,i+1]) / 100));    // Precio neto
            grdVenta.Cells[6,i+1] := FloatToStr(StrToFloat(grdVenta.Cells[5,i+1]) * StrToFloat(grdVenta.Cells[2,i+1]));    // Importe
            grdDatos.Cells[8,i]   := FloatToStr(txtDescuento.Value);    // Descuento
        end
        else begin
            grdVenta.Cells[4,i+1] := grdDatos.Cells[9,i];     // Descuento
            grdVenta.Cells[5,i+1] := FloatToStr(StrToFloat(grdVenta.Cells[3,i+1]) *
                                    (1 - StrToFloat(grdVenta.Cells[4,i+1]) / 100));    // Precio neto
            grdVenta.Cells[6,i+1] := FloatToStr(StrToFloat(grdVenta.Cells[5,i+1]) * StrToFloat(grdVenta.Cells[2,i+1]));    // Importe
            grdDatos.Cells[8,i] := grdDatos.Cells[9,i];       // Descuento
        end;

        ActualizaRenglon(i);;
    end;
    Total;
end;


function TfrmVentas.verificafiscal:boolean;
var i:integer;
     encontrado:boolean;
Begin
 if (txtComprobante.Text <> 'FACTURA') and (txtComprobante.Text <> 'TICKET') then
   verificaFiscal:=true
 else
  Begin
   i:=0;
   encontrado:=false;
   while (i<=grdDatos.RowCount - 1) and (not encontrado) do
    begin
     //si cantidad fiscal  >= cantidad a vender => No hay problema
     if StrToFloat(grdDatos.cells[17,i])>= StrToFloat(grdDatos.cells[3,i]) then
      i:=i+1
     else
      encontrado:=true;
    end; //While

   if (encontrado) then
    Begin
     verificafiscal:=false;
     articuloEncontrado:=false;
     if (txtComprobante.Text = 'FACTURA') then
     while (not articuloEncontrado) do
      Begin
        if MessageDlg('El producto: '+grdDatos.Cells[2,i] +' no tiene suficiente existencia F�scal. �Desea Facturar otro Producto?' ,mtCustom, [mbYes, mbNo],0,mbYes) = mrYes	 then
          Begin
            iarticulos:=grdDatos.Cells[3,i];
            facturarotro:=true;
            mnuArticulos.click;
            if (articuloencontrado = true) then
             Begin
              grdDatos.Cells[18,i]:=iclavealterna;
              verificafiscal:=true;
             end
            else
             Begin
              grdDatos.Cells[18,i]:=grdDatos.Cells[0,i];
              verificafiscal:=false;
             end;
            facturarotro:=false;
          End
        else     //No desea Facturar
         Begin
          articuloencontrado:=true;
          verificafiscal:=false;
         end;
      end; //While
    end // if encontrado
   else
    verificafiscal:=true;
  end; //Else
end;

procedure TfrmVentas.mnuPagarClick(Sender: TObject);
var
    bPago : boolean;
begin
 if (iNumero <> - 1) then
  Begin
    if VerificaDatos then
      begin //Si hay cuando menos un art�culo
            bfiscal := false;
            bPago := false;
            if(txtComprobante.Text = 'FACTURA') then begin

                fcambio := true;
            end
            else
            begin
               fcambio := false;
            end;
            if(txtComprobante.Text = 'AJUSTE') then begin
                if(Application.MessageBox('Se guardar� el ajuste','Ajuste',[smbOK]+[smbCancel],smsWarning) = smbOK) then
                    bPago := true;
                    bfiscal := true;
            end
            else if(txtComprobante.Text = 'COTIZACION') then begin
                if(Application.MessageBox('Se guardar� la cotizaci�n','Cotizaci�n',[smbOK]+[smbCancel],smsWarning) = smbOK) then
                    bPago := true;
                    bfiscal := true;
            end
            else if(txtComprobante.Text = 'DEVOLUCION') then begin
                if(Application.MessageBox('Se guardar� la devoluci�n','Devoluci�n',[smbOK]+[smbCancel],smsWarning) = smbOK) then
                    bPago := true;
                    bfiscal := true;
            end
            else if(txtComprobante.Text = 'PEDIDO') then begin
                if(Length(Trim(txtCliente.Text)) = 0) then begin
                    Application.MessageBox('Introduzca un cliente','Pedido',[smbOK]);
                    bPago := false;
                end
                else if(Application.MessageBox('Se guardar� el pedido','Pedido',[smbOK]+[smbCancel],smsWarning) = smbOK) then
                    bPago := true;
            end
            else begin
                  if (fcambio = true and cambiob = false)then
                begin
                  frmPago.rTotal :=  RoundTo(txtTotal.Value * 1.16,-2);
                  txtTotal.Value :=  RoundTo(txtTotal.Value * 1.16,-2);
                cambiob:=true;
               frmPago.rTotal := txtTotal.Value;
                end
                else
                begin
                 frmPago.rTotal := txtTotal.Value;
                end;
                frmPago.rLimiteCredito := rLimiteCredito;
                frmPago.sTipoOper := 'V';
                frmPago.iCliente := iCliente;
                frmPago.rDescuentos := rDescuentos;
                frmPago.dteFecha := Date;
                frmPago.bLimiteCred := bLimiteCred;
                frmPago.Caption  := 'Pago';
                frmPago.CheckBox1.Checked  := true;
                frmPago.tipoc:= txtComprobante.Text;
                frmPago.ShowModal;
                rCambio := frmPago.rCambio;
                bfiscal := frmPago.bfiscal;
                bPago := frmPago.bAceptar;

            end;
            if(bPago) then begin

                GuardaDatos;
                CambiarEstatusPedido;
                EliminaArea;
                GuardaComprobante;
                ImprimeComprobante;
                with TfrmCambio.Create(Self) do
                try
                    lblComprobante.Caption := Self.txtComprobante.Text;
                    txtComprobante.Value := StrToInt(sNumComp);
                    rCambio := Self.rCambio;
                    ShowModal;
                finally
                    Free;
                end;
                if(txtComprobante.Text = 'FACTURA') then begin
                cfdpre;
                end;
                iCliente := 0;
                iVendedor := 0;
                FSinDescuento:= false;
                rLimiteCredito := 0;
                txtDescuento.Value := 0;
                sVentaRef := 'null'; // Eliminar referencia con otra venta
                sClavePedido:= '';
                Inicializa;
                txtPrecio.Value := iPrecio;

                grdDatos.Cells[21,grdVenta.Row-1]:= '';
                RecuperaConsec;
                txtComprobante.Text := sComprobanteDef;
                Botones;
            end;

      end;  //VerificaDatos
    CodigoFoco;
  end //(iNumero <> - 1)
end;

procedure TfrmVentas.CambiarEstatusPedido;
begin
  if(sClavePedido <> EmptyStr) and (txtComprobante.Text <> 'PEDIDO') then
    with dmDatos.qryModifica do begin
      //Actualiza en la tabla de ventas la informaci�n general
      Close;
      SQL.Clear;
      SQL.Add('UPDATE ventas SET estatus = ''U'' WHERE clave = ' + sClavePedido);
      ExecSQL;

      Close;
      SQL.Clear;
      SQL.Add('UPDATE comprobantes SET estatus = ''U'' WHERE venta = ' + sClavePedido);
      ExecSQL;
    end;
end;

procedure TfrmVentas.GuardaDatos;
var
    i, j, k, iPagos, iPlazo, iOrdenXCobrar, iOrdenPagos : integer;
    sFecha, sHora, sClave, sCantidad, sCantidad_Cnt, sCliente, sVendedor, sInteres, sClaveComent,aux,sVF : String;     // se modifico para xilotzingo  , sVF
    dteFechaPago : TDateTime;
    rImporte, rSumaImporte : real;
begin
    sFecha := FormatDateTime('mm/dd/yyyy',Date);
    sHora := FormatDateTime('hh:nn:ss',Time);
    with dmDatos.qryModifica do
     begin
        if(iCliente > 0) then
          sCliente := IntToStr(iCliente)
        else
         sCliente := 'null';

        if(iVendedor > 0) then
         sVendedor := IntToStr(iVendedor)
        else
         sVendedor := 'null';

        if(txtComprobante.Text = 'PEDIDO') and (sClavePedido <> EmptyStr) then
         begin
          EliminarDetallePedido;

          //Actualiza en la tabla de ventas la informaci�n general
          Close;
          SQL.Clear;
          SQL.Add('UPDATE ventas SET areaventa = ' + sAreaVenta + ',');
          SQL.Add('caja = ' + IntToStr(iCaja) + ', iva = ' + FloatToStr(rIva) + ',');
          SQL.Add('total = ' + FloatToStr(rTotal) + ', cambio = 0, redondeo = 0,');
          SQL.Add('cliente = ' + sCliente + ', usuario = ' + IntToStr(iUsuario) + ',');
          SQL.Add('vendedor = ' + sVendedor);
          SQL.Add('WHERE clave = ' + sClavePedido);
          ExecSQL;
          sVenta:= sClavePedido;
         end
        else
         begin
          //Inserta en la tabla de ventas la informaci�n general
         sVF := 'S';
         for i:=1 to grdDatos.RowCount do
         begin
            if grdDatos.Cells[19,i-1] = '1' then
            begin
            cambio:= true;
            end;
         end;
        if not (cambio) then sVF := 'N';

          Close;
          SQL.Clear;
          SQL.Add('INSERT INTO ventas (areaventa, caja, numero, fecha, hora, iva,');
          SQL.Add('total, cambio, redondeo, estatus, cliente, usuario, ventaref, vendedor,vf) VALUES(');   // se modifico para xilotzingo , vf
          SQL.Add(sAreaVenta + ',' + IntToStr(iCaja) + ',' + IntToStr(iConsec) + ',''' + sFecha + ''',');
          SQL.Add('''' + sHora + ''',' + FloatToStr(rIva) + ',' + FloatToStr(rTotal) + ',');
          SQL.Add(FloatToStr(rCambio) + ',' + FloatToStr(rRedondeo) + ',');
          SQL.Add('''A'',' + sCliente + ',' + IntToStr(iUsuario) + ',' + sVentaRef + ',' + sVendedor + ',''' + sVF + ''')');
          ExecSQL;
          //Recupera la clave que genera el Trigger
          Close;
          SQL.Clear;
          SQL.Add('SELECT clave FROM ventas WHERE caja = ' + IntToStr(iCaja));
          SQL.Add('AND fecha = ''' + sFecha + ''' AND hora = ''' + sHora + '''');
          Open;
          sVenta := FieldByName('clave').AsString;
          Close;
         end;
           cambio := false;
        if(txtComprobante.Text <> 'AJUSTE') and (txtComprobante.Text <> 'COTIZACION')
          and (txtComprobante.Text <> 'DEVOLUCION') and (txtComprobante.Text <> 'PEDIDO') then
         begin //1
           if(iCliente > 0) then
            begin
             //Guarda la ultima venta al cliente
             Close;
             SQL.Clear;
             SQL.Add('UPDATE clientes SET ultimacompra = ' + sVenta + ',');
             SQL.Add('acumulado = acumulado + ' + FloatToStr(rTotal));
             SQL.Add('WHERE clave = ' + sCliente);
             ExecSQL;
             Close;
            end;

           if(iVendedor > 0) then
            begin
             // Guarda la ultima venta al vendedor
             Close;
             SQL.Clear;
             SQL.Add('UPDATE vendedores SET ultventa = ' + sVenta);
             SQL.Add('WHERE clave = ' + sVendedor);
             ExecSQL;
             Close;
            end;

           iOrdenPagos := 0;
           iOrdenXCobrar := 0;
           //Inserta el (los) tipo(s) de pago(s)
           for i := 0 to frmPago.grdPagos.RowCount - 1 do
            begin
             Close;
             SQL.Clear;
             SQL.Add('INSERT INTO ventaspago (venta, tipopago, importe, referencia, orden, notacredito) VALUES(');
             SQL.Add(sVenta + ',''' + frmPago.grdPagos.Cells[0,i] + ''',');
             SQL.Add(frmPago.grdPagos.Cells[1,i] + ',');
             SQL.Add('''' + frmPago.grdPagos.Cells[2,i] + ''',' + IntToStr(iOrdenPagos) + ',');
             if(frmPago.grdPagos.Cells[4,i] = 'NOTA DE CREDITO') then
               SQL.Add(frmPago.grdPagos.Cells[6,i] + ')')
             else
               SQL.Add('null)');
             ExecSQL;

             Close;
             Inc(iOrdenPagos);

             if(frmPago.grdPagos.Cells[4,i] = 'NOTA DE CREDITO') then
              begin
               Close;
               SQL.Clear;
               SQL.Add('UPDATE notascredito SET estatus = ''U'' WHERE clave = ' + frmPago.grdPagos.Cells[6,i]);
               ExecSQL;
              end;

             if(frmPago.grdPagos.Cells[4,i] = 'CREDITO') then
              begin
               iPagos := StrToInt(frmPago.grdPagos.Cells[5,i]);
               iPlazo := StrToInt(frmPago.grdPagos.Cells[6,i]);
               dteFechaPago := StrToDate(frmPago.grdPagos.Cells[7,i]);
               rImporte := StrToFloat(frmPago.grdPagos.Cells[12,i]);
               rSumaImporte := 0;
               for k := 1 to iPagos do
                begin
                 rSumaImporte := rSumaImporte + rImporte;

                 // Si es el ultimo pago y la suma es diferente que la deuda, ajusta el ultimo pago
                 if(k = iPagos) and (rSumaImporte <> StrToFloat(frmPago.grdPagos.Cells[13,i])) then
                  rImporte := rImporte + StrToFloat(frmPago.grdPagos.Cells[13,i]) - rSumaImporte;
                 if(iPagos = 1) then
                  sInteres := '0'
                 else
                  sInteres := frmPago.grdPagos.Cells[8,i];

                 Inc(iOrdenXCobrar);
                 // Inserta los datos del cr�dito
                 Close;
                 SQL.Clear;
                 SQL.Add('INSERT INTO xcobrar (venta, cliente, importe, numpago, plazo, interes,');
                 SQL.Add('intmoratorio, proximopago, tipointeres, tipoplazo, pagado, estatus, fecha,');
                 SQL.Add('cantinteres, cantintmorat, orden) VALUES(');
                 SQL.Add(sVenta + ',' + sCliente + ',' + FloatToStr(rImporte) + ',''' + IntToStr(k) + '/' + IntToStr(iPagos) + ''',');
                 SQL.Add(frmPago.grdPagos.Cells[6,i] + ',' + sInteres + ',' + frmPago.grdPagos.Cells[9,i] + ',');
                 SQL.Add('''' + FormatDateTime('mm/dd/yyyy',dteFechaPago) + ''',''' + frmPago.grdPagos.Cells[10,i] + ''',');
                 SQL.Add(frmPago.grdPagos.Cells[11,i] + ',0,''A'',''' + sFecha + ''',0,0,' + IntToStr(iOrdenXCobrar) + ')');
                 ExecSQL;
                 Close;
                 dteFechaPago := dteFechaPago + iPlazo;
                end; //FOR
              end; //CREDITO
            end; //Inserta el (los) tipo(s) de pago(s)
         end; // 1

        //Inserta el detalle de la venta
        for i := 0 to grdDatos.RowCount - 1 do
         begin
          ifacturable:=false;
          if(Length(Trim(grdDatos.Cells[14,i])) > 0) then
           begin
            // Se manda ejecutar el procedimiento almacenado InsertaComent
            // para que regrese la clave que asign� el generador
            Close;
            SQL.Clear;
            SQL.Add('SELECT clavecoment FROM insertacoment(''' + grdDatos.Cells[14,i] + ''')');
            Open;
            sClaveComent := FieldByName('clavecoment').AsString;
           end
          else
           sClaveComent := 'null';

          if(txtComprobante.Text <> 'COTIZACION') then
           begin
            if(sClavePedido = EmptyStr) or (txtComprobante.Text = 'PEDIDO') then
              begin

                //Si tipo de art�culo es diferente de "no inventariable" y de "juego"
                if(grdDatos.Cells[6,i] <> '1') and (grdDatos.Cells[6,i] <> '2') then
                 begin
                  // articulo controla cantidad
                  if(grdDatos.Cells[16,i] = 'S') then
                   begin
                    Close;
                    SQL.Clear;
                    SQL.Add('UPDATE articulos SET');
                    if(txtComprobante.Text <> 'DEVOLUCION') AND(txtComprobante.Text <> 'NOTA') then
                      SQL.Add('existencia = existencia - ' + grdDatos.Cells[3,i] + ',')
                    else  //Es Devolucion
                      SQL.Add('existencia = existencia + ' + grdDatos.Cells[3,i] + ',');
                    SQL.Add('ultventa = ' + sVenta);
                    SQL.Add('WHERE clave = ' + grdDatos.Cells[0,i]);
                    ExecSQL;
                    Close;
                   end;  // S
                 end //<> 1 <> 2
                else
                 begin
                  Close;
                  SQL.Clear;
                  SQL.Add('UPDATE articulos SET ultventa = ' + sVenta);
                  SQL.Add('WHERE clave = ' + grdDatos.Cells[0,i]);
                  ExecSQL;
                  Close;
                 end;

                //Si tipo de art�culo es juego
                if(grdDatos.Cells[6,i] = '1') then
                 begin
                  Close;
                  SQL.Clear;
                  SQL.Add('SELECT j.articulo, j.cantidad, a.cantidad_cnt FROM juegos j');
                  SQL.Add('LEFT JOIN articulos a ON j.articulo = a.clave WHERE j.clave = ' + grdDatos.Cells[0,i]);
                  Open;
                  j := 1;
                  while(not Eof) do
                   begin
                    sClave := FieldByName('articulo').AsString;
                    sCantidad := FloatToStr(FieldByName('cantidad').AsFloat);
                    sCantidad_Cnt := FieldByName('cantidad_cnt').AsString;

                    // si articulo controla cantidad
                    if(sCantidad_Cnt = 'S') then
                     begin
                      dmDatos.qryAuxiliar1.Close;
                      dmDatos.qryAuxiliar1.SQL.Clear;
                      dmDatos.qryAuxiliar1.SQL.Add('UPDATE articulos SET');
                      if(txtComprobante.Text <> 'DEVOLUCION') AND (txtComprobante.Text <> 'NOTA') then
                       dmDatos.qryAuxiliar1.SQL.Add('existencia = existencia - ' + grdDatos.Cells[3,i] + ' * ' + sCantidad)
                      else
                       dmDatos.qryAuxiliar1.SQL.Add('existencia = existencia + ' + grdDatos.Cells[3,i] + ' * ' + sCantidad);

                      dmDatos.qryAuxiliar1.SQL.Add('WHERE clave = ' + sClave);
                      dmDatos.qryAuxiliar1.ExecSQL;
                      dmDatos.qryAuxiliar1.Close;

                     end;
                    dmDatos.qryAuxiliar1.Close;
                    dmDatos.qryAuxiliar1.SQL.Clear;
                    dmDatos.qryAuxiliar1.SQL.Add('INSERT INTO ventasdet (venta, orden, juego, articulo, cantidad,');
                    dmDatos.qryAuxiliar1.SQL.Add('precio, iva, descuento, devolucion, cantidad_cnt,articuloalterno) VALUES(');
                    dmDatos.qryAuxiliar1.SQL.Add(sVenta + ',' + IntToStr(i) + ',' + IntToStr(j) + ',' + sClave + ',');
                    dmDatos.qryAuxiliar1.SQL.Add(sCantidad + '*' + grdDatos.Cells[3,i] + ',0,0,0,0,''' + sCantidad_Cnt + ''''+grdDatos.Cells[0,i]+')');
                    dmDatos.qryAuxiliar1.ExecSQL;
                    dmDatos.qryAuxiliar1.Close;

                    Inc(j);
                    Next;
                   end;  // while (not Eof)
                 end;//Si tipo de art�culo es juego


              end; //if(sClavePedido = EmptyStr) or (txtComprobante.Text = 'PEDIDO')
           end; // if(txtComprobante.Text <> 'COTIZACION')

          Close;
          SQL.Clear;
          SQL.Add('INSERT INTO ventasdet (venta, orden, articulo, cantidad, precio,');
          SQL.Add('iva, descuento, juego, devolucion, ventareforden, comentario, fecha, cantidad_cnt,fiscal,articuloalterno,facturable) VALUES(');
          SQL.Add(sVenta + ',' + IntToStr(i) + ',');
          SQL.Add(grdDatos.Cells[0,i] + ',');
          SQL.Add(grdDatos.Cells[3,i] + ',');
          SQL.Add(grdDatos.Cells[4,i] + ',');
          SQL.Add(grdDatos.Cells[5,i] + ',');
          SQL.Add(grdDatos.Cells[8,i] + ',0,0,');
          if(grdDatos.Cells[12,i] = '') then
            SQL.Add('null,')
          else
           SQL.Add(grdDatos.Cells[12,i] + ',');
          SQL.Add(sClaveComent + ',' + QuotedStr(grdDatos.Cells[15,i]) + ',');
          SQL.Add('''' + grdDatos.Cells[16,i] + ''',');
          if (grdDatos.Cells[19,i] = '1' )then
           Begin
            SQL.Add('1');
            SQL.Add(', '+grdDatos.Cells[18,i]);
            SQL.Add(',1)');
           end
          else
           Begin
            SQL.Add('0');
            SQL.Add(', '+grdDatos.Cells[18,i]);
            SQL.Add(',0)');
           End;
          ExecSQL;
          grdDatos.Cells[19,i] := '';

          if(txtComprobante.Text = 'DEVOLUCION') then
           begin
            // Incrementa la cantidad devuelta a la venta original
            Close;
            SQL.Clear;
            SQL.Add('UPDATE ventasdet SET devolucion = devolucion + ' + grdDatos.Cells[3,i]);
            SQL.Add('WHERE juego = 0 AND orden = ' + grdDatos.Cells[12,i]);
            ExecSQL;
            Close;
           end;

          Close;
         end; //for i := 0 to grdDatos.RowCount - 1 do
     end; //With
end;

procedure TfrmVentas.EliminarDetallePedido;
var
    iCantidad: integer;
    iClaveArt: Integer;
    sCantidad_Cnt: String;
begin
    with dmDatos.qryModifica do begin
        // Regresa al inventario en caso de que ya hab�a algo
        Close;
        SQL.Clear;
        SQL.Add('SELECT articulo, cantidad, cantidad_cnt FROM ventasdet');
        SQL.Add('WHERE venta = ' + sClavePedido);
        Open;

        while not Eof do begin
            iClaveArt := FieldByName('articulo').AsInteger;
            iCantidad := FieldByName('cantidad').AsInteger;
            sCantidad_Cnt := FieldByName('cantidad_cnt').AsString;

            if(sCantidad_Cnt = 'S') then begin
                dmDatos.qryAuxiliar1.Close;
                dmDatos.qryAuxiliar1.SQL.Clear;
                dmDatos.qryAuxiliar1.SQL.Add('UPDATE articulos SET');
                dmDatos.qryAuxiliar1.SQL.Add('existencia = existencia + ' + IntToStr(iCantidad));
                dmDatos.qryAuxiliar1.SQL.Add('WHERE clave = ' + IntToStr(iClaveArt) + ' AND tipo NOT IN (1,2)');
                dmDatos.qryAuxiliar1.ExecSQL;
                dmDatos.qryAuxiliar1.Close;
            end;

            Next;
        end;

        Close;
        SQL.Clear;
        SQL.Add('DELETE FROM ventasdet WHERE venta = ' + sClavePedido);
        ExecSQL;
    end;
end;

procedure TfrmVentas.mnuComprobanteClick(Sender: TObject);
var
    bAutoriza : boolean;
begin
    bAutoriza := false;
    with TfrmTipoComprobante.Create(Self) do
    try
        sTipo := 'VENTA';
        sComprobante := txtComprobante.Text;
        iUsuario := Self.iUsuario;
        ShowModal;
        if(ModalResult = mrOK) then begin
            with dmDatos.qryModifica do begin
                Close;
                SQL.Clear;
                SQL.Add('UPDATE ventasareas SET comprobante = ''' + Copy(sComprobante,1,1) + '''');
                SQL.Add('WHERE areaventa = ' + sAreaVenta);
                ExecSQL;
                Close;
                bAutoriza := true;
            end;
            txtComprobante.Text := sComprobante;
            Total; ///mod
            Botones;
        end;
    finally
        Free;
    end;
  {  if(bAutoriza) and (txtComprobante.Text = 'DEVOLUCION') then begin
        LimpiaArticulos;
        with TfrmRecuperaVenta.Create(Self) do
        try
            sTitulo := 'Recuperar comprobante';
            bCotizacion := false;
            bAjuste := false;
            bDevolucion := false;
            bPedido := true;
            if(ShowModal = mrOk) then begin
                Self.sVentaRef := sVenta;
                RecuperaVenta;
            end
        finally
            Free;
        end;
    end;    }
    Botones;
    CodigoFoco;
end;

procedure TfrmVentas.Botones;
begin
    if(txtComprobante.Text = 'DEVOLUCION') then begin
        mnuPrecio.Enabled := false;
        mnuArticulos.Enabled := False;
        mnuCredencial.Enabled := false;
        btnPrecio.Enabled := false;
        btnArticulos.Enabled := False;
        btnCredencial.Enabled := false;
        mnuDescGeneral.Enabled := false;
        mnuDescIndividual.Enabled := false;
        mnuEliminarDesc.Enabled := false;
        txtCodigo.Enabled := False;
    end
    else begin
        mnuPrecio.Enabled := true;
        mnuArticulos.Enabled := true;
        mnuCredencial.Enabled := true;
        btnPrecio.Enabled := true;
        btnArticulos.Enabled := true;
        btnCredencial.Enabled := true;
        mnuDescGeneral.Enabled := true;
        mnuDescIndividual.Enabled := true;
        mnuEliminarDesc.Enabled := true;
        txtCodigo.Enabled := true;
    end;
end;

procedure TfrmVentas.mnuAreasVentaClick(Sender: TObject);
begin
    with TfrmAreasVentaBusq.Create(Self) do
    try
        iCaja := Self.iCaja;
        sClave := sAreaVenta;
        ShowModal;
        if ModalResult = mrOK then begin
            sAreaVenta := sClave;
            RecuperaAreaVenta;
        end;
    finally
        Free;
    end;
    CodigoFoco;
end;

procedure TfrmVentas.GuardaRenglon(iRenglon : integer);
var
    sCliente, sVendedor : String;
begin
    if(iCliente < 1) then
        sCliente := 'null'
    else
        sCliente := IntToStr(iCliente);

    if(iVendedor < 1) then
        sVendedor := 'null'
    else
        sVendedor := IntToStr(iVendedor);

    with dmDatos.qryAuxiliar1 do begin
        Close;
        SQL.Clear;
        SQL.Add('INSERT INTO ventasareas (areaventa, orden, articulo, codigo, descrip, cantidad, precio, iva, tipo,');
        SQL.Add('descauto, descotorg, descfechas, descusuario, cliente, comprobante, categoria, departamento,');
        SQL.Add('comentario, fecha, vendedor, cantidad_cnt,fiscal) VALUES(');
        SQL.Add(sAreaVenta + ',' + IntToStr(iRenglon) + ',' + grdDatos.Cells[0,iRenglon] + ',');
        SQL.Add('''' + grdDatos.Cells[1,iRenglon] + ''',''' + grdDatos.Cells[2,iRenglon] + ''',');
        SQL.Add(grdDatos.Cells[3,iRenglon] + ',' + grdDatos.Cells[4,iRenglon] + ',');
        SQL.Add(grdDatos.Cells[5,iRenglon] + ',' + grdDatos.Cells[6,iRenglon] + ',');
        SQL.Add('''' + grdDatos.Cells[7,iRenglon] + ''',' + grdDatos.Cells[8,iRenglon] + ',' + grdDatos.Cells[13,iRenglon] + ',');
        SQL.Add(grdDatos.Cells[9,iRenglon] + ',' + sCliente + ',''' + Copy(txtComprobante.Text,1,1) + ''',');
        if(Length(grdDatos.Cells[10,iRenglon]) > 0) then
            SQL.Add(grdDatos.Cells[10,iRenglon] + ',')
        else
            SQL.Add('null,');
        if(Length(grdDatos.Cells[11,iRenglon]) > 0) then
            SQL.Add(grdDatos.Cells[11,iRenglon] + ',')
        else
            SQL.Add('null,');
        SQL.Add('''' + grdDatos.Cells[14,iRenglon] + ''',' + QuotedStr(grdDatos.Cells[15,iRenglon]) + ',');
        SQL.Add(sVendedor + ',''' + grdDatos.Cells[16,iRenglon] + ''','+grdDatos.Cells[17,iRenglon]+')');
        ExecSQL;
        Close;
    end;
end;

procedure TfrmVentas.RecuperaAreaVenta;
var
    sComprobante : String;
begin
    with dmDatos.qryConsulta do begin
        if(Length(sAreaVenta) > 0) then begin
            // Recupera el nombre del �rea de venta si se tiene la clave
            Close;
            SQL.Clear;
            SQL.Add('SELECT nombre FROM areasventa WHERE clave = ' + sAreaVenta);
            Open;
            txtAreaVenta.Text := Trim(FieldByName('nombre').AsString);
            Close;
        end
        else begin
            // Recupera el nombre y la clave de la primera �rea de venta
            Close;
            SQL.Clear;
            SQL.Add('SELECT clave, nombre FROM areasventa ORDER BY clave');
            Open;
            txtAreaVenta.Text := Trim(FieldByName('nombre').AsString);
            sAreaVenta := Trim(FieldByName('clave').AsString);
            Close;
        end;

        // Recupera los datos de la venta
        Close;
        SQL.Clear;
        SQL.Add('SELECT v.*, c.nombre, c.descuento, c.precio AS tipoprecio, c.limitecredito, ');
        SQL.Add('n.nombre as nom_vendedor ');
        SQL.Add('FROM ventasareas v LEFT JOIN clientes c ON v.cliente = c.clave');
        SQL.Add('LEFT JOIN vendedores n ON v.vendedor = n.clave');
        SQL.Add('WHERE v.areaventa = ' + sAreaVenta + ' ORDER BY orden');
        Open;

        if(not Eof) then begin  // estou aqui
            sVentaRef := 'null'; // Eliminar referencia con otra venta
            sComprobante := FieldByName('comprobante').AsString;
            if(sComprobante = 'F') then
                txtComprobante.Text := 'FACTURA'
            else if(sComprobante = 'N') then
                txtComprobante.Text := 'NOTA'
            else if(sComprobante = 'T') then
                txtComprobante.Text := 'TICKET'
            else if(sComprobante = 'C') then
                txtComprobante.Text := 'COTIZACION'
            else if(sComprobante = 'A') then
                txtComprobante.Text := 'AJUSTE'
            else if(sComprobante = 'D') then begin
                txtComprobante.Text := 'DEVOLUCION';
                sVentaRef := FieldByName('ventaref').AsString;
            end
            else
                txtComprobante.Text := sComprobanteDef;

//            if(txtComprobante.Text <> 'DEVOLUCION') then begin
                iCliente := FieldByName('cliente').AsInteger;
                txtCliente.Text := Trim(FieldByName('nombre').AsString);
                txtDescuento.Value := FieldByName('descuento').AsFloat;
                if (iCliente > 0) then
                    iPrecio := FieldByName('tipoprecio').AsInteger;
                if(iPrecio = 0) then
                    iPrecio := 1;
                txtPrecio.Value := iPrecio;
                rLimiteCredito := FieldByName('limitecredito').AsFloat;

                Inicializa;

                iVendedor := FieldByName('vendedor').AsInteger;
                if(iVendedor > 0) then begin
                    pnlEncab.Height:= 114;
                    txtVendedor.Text := Trim(FieldByName('nom_vendedor').AsString);
                end;

                while(not Eof) do begin
                    if (not FieldByName('articulo').IsNull) then begin
                        Inc(iNumero);
                        grdDatos.RowCount := iNumero + 1;
                        grdDatos.Cells[0,iNumero] := FieldByName('articulo').AsString;              // Clave del art�culo
                        grdDatos.Cells[1,iNumero] := Trim(FieldByName('codigo').AsString);          // C�digo
                        grdDatos.Cells[2,iNumero] := Trim(FieldByName('descrip').AsString);         // Descripci�n del art�culo
                        grdDatos.Cells[3,iNumero] := FloatToStr(FieldByName('cantidad').AsFloat);   // Cantidad de art�culos (por default 1)
                        grdDatos.Cells[4,iNumero] := FloatToStr(FieldByName('precio').AsFloat);     // Precio del art�culo
                        grdDatos.Cells[5,iNumero] := FloatToStr(FieldByName('iva').AsFloat);        // I.V.A. del art�culo
                        grdDatos.Cells[6,iNumero] := Trim(FieldByName('tipo').AsString);            // Tipo de art�culo (A granel, Juego, etc.
                        grdDatos.Cells[7,iNumero] := Trim(FieldByName('descauto').AsString);        // Descuento autom�tico del art�culo
                        grdDatos.Cells[8,iNumero] := FloatToStr(FieldByName('descotorg').AsFloat);  // Descuento otorgado
                        grdDatos.Cells[9,iNumero] := FloatToStr(FieldByName('descfechas').AsFloat); // Descuento por fechas
                        grdDatos.Cells[10,iNumero] := IntToStr(FieldByName('categoria').AsInteger); // Categoria
                        grdDatos.Cells[11,iNumero] := IntToStr(FieldByName('departamento').AsInteger); // Departamento
                        grdDatos.Cells[13,iNumero] := FloatToStr(FieldByName('descusuario').AsFloat); // Departamento
                        grdDatos.Cells[14,iNumero] := Trim(FieldByName('comentario').AsString); // Comentario
                        grdDatos.Cells[15,iNumero] := FormatDateTime('mm/dd/yyyy',FieldByName('fecha').AsDateTime); // Comentario
                        grdDatos.Cells[16,iNumero] := Trim(FieldByName('cantidad_Cnt').AsString); // Articulo controla cantidad en el almac�n
                        grdDatos.Cells[17,iNumero] := FieldByName('fiscal').AsString;           //Recupera cantidad fiscal
                        grdDatos.Cells[18,iNumero] := FieldByName('articulo').AsString;              // Clave del art�culo

                        with dmDatos.qryAuxiliar3 do
                         begin
                          SQL.Clear;
                          SQL.Add('SELECT a.precio1, a.precio2, a.precio3, a.precio4,a.precio5,  a.rango1, a.rango2, a.rango3, a.rango4, a.rango5 from Articulos a ');
                          SQL.Add('WHERE  a.clave = ' +grdDatos.Cells[0,iNumero]);
                          Open;

                          precio1:=FieldByname('precio1').AsFloat;
                          precio2:=FieldByname('precio2').AsFloat;
                          precio3:=FieldByname('precio3').AsFloat;
                          precio4:=FieldByname('precio4').AsFloat;
                          precio5:=FieldByname('precio5').AsFloat;

                  //        rango1:=FieldByName('rango1').AsInteger;
                  //        rango2:=FieldByName('rango2').AsInteger;
                  //        rango3:=FieldByName('rango3').AsInteger;
                  //        rango4:=FieldByName('rango4').AsInteger;
                           rango1:=FieldByName('rango1').AsFloat;
            rango2:=FieldByName('rango2').AsFloat;
            rango3:=FieldByName('rango3').AsFloat;
            rango4:=FieldByName('rango4').AsFloat;
            rango5:=FieldByName('rango5').AsFloat;

                          close;
                         end; // With



                        grdDatos.Cells[4, iNumero] := floattostr(verifica_precios(FieldByName('cantidad').AsFloat));
                        VerificaDescuento(iNumero);

                        // Guarda los datos del art�culo en un grid que se muestra en la pantalla
                        grdVenta.RowCount := iNumero + 2;
                        grdVenta.Cells[0,iNumero + 1] := IntToStr(iNumero + 1);         // Consecutivo
                        grdVenta.Cells[1,iNumero + 1] := grdDatos.Cells[2,iNumero];     // Descripci�n corta
                        grdVenta.Cells[2,iNumero + 1] := grdDatos.Cells[3,iNumero];     // Cantidad
                        grdVenta.Cells[3,iNumero + 1] := grdDatos.Cells[4,iNumero];     // Precio
                        grdVenta.Cells[4,iNumero + 1] := grdDatos.Cells[8,iNumero];     // Descuento
                        grdVenta.Cells[5,iNumero + 1] := FloatToStr(StrToFloat(grdDatos.Cells[4,iNumero])*(1-StrToFloat(grdDatos.Cells[8,iNumero])/100));        // Precio neto
                        grdVenta.Cells[6,iNumero + 1] := FloatToStr(StrToFloat(grdVenta.Cells[5,iNumero + 1]) * StrToFloat(grdDatos.Cells[3,iNumero]));  // Importe

                        grdVenta.Cells[3,iNumero + 1] := floattostr(verifica_precios(FieldByName('cantidad').AsFloat));
                    end;
                    Next;
                end;
                Close;
                Total;
//            end
{            else begin
                iCliente := 0;
                txtDescuento.Value := 0;
                sVentaRef := 'null'; // Eliminar referencia con otra venta
                Inicializa;
            end;}
        end
        else begin
            iCliente := 0;
            iVendedor := 0;
            FSinDescuento:= false;
            txtDescuento.Value := 0;
            txtComprobante.Text := sComprobanteDef;
            Botones;
            sVentaRef := 'null'; // Eliminar referencia con otra venta
            Inicializa;
        end;
        Botones;
        CodigoFoco;
    end;
end;

procedure TfrmVentas.EliminaArea;
begin
    with dmDatos.qryModifica do begin
        Close;
        SQL.Clear;
        SQL.Add('DELETE FROM ventasareas WHERE areaventa = ' + sAreaVenta);
        ExecSQL;
        Close;
    end;
end;

procedure TfrmVentas.ImprimeComprobante;
begin
    if(txtComprobante.Text = 'TICKET') then
       if (bfiscal) then
        frmReimprimir.ImprimeTicket(IntToStr(iCaja), sNumComp,'T')
       else
        frmReimprimir.ImprimeTicket(IntToStr(iCaja), sNumComp,'P')
    else
        frmReimprimir.ImprimeComprobante(txtComprobante.Text, IntToStr(iCaja), sNumComp);
end;

function TfrmVentas.VerificaDatos:boolean;
begin
    Result := true;
    if(txtComprobante.Text = 'FACTURA') and (iCliente = 0) then begin
        Application.MessageBox('Introduce un cliente','Error',[smbOK],smsCritical);
        Result := false;
    end
    else if(not VerificaDevolucion) then
        Result := false;
    CodigoFoco;
end;                                                               

function TfrmVentas.VerificaDevolucion:boolean;
var
    i : integer;
begin
    Result := true;
 {   if(txtComprobante.Text = 'DEVOLUCION') then begin
        for i := 1 to grdVenta.RowCount - 1 do begin
            with dmDatos.qryModifica do begin
                Close;
                SQL.Clear;
                SQL.Add('SELECT cantidad - devolucion AS disponible FROM ventasdet WHERE venta = ' + sVentaRef);
                SQL.Add('AND juego = 0 AND orden = ' + grdDatos.Cells[12,i-1]);
                Open;
                if(FieldByName('disponible').AsFloat < StrToFloat(grdDatos.Cells[3,i-1])) then begin
                    Application.MessageBox('El m�ximo a devolver para ' + grdDatos.Cells[2,i-1] + ' es ' + FieldByName('disponible').AsString,'Error',[smbOK],smsCritical);
                    grdVenta.SetFocus;
                    grdVenta.Row := i;
                    Result := false;
                    break;
                end;
                Close;
            end;
        end;
    end;   }
end;

procedure TfrmVentas.GuardaComprobante;
var
    sFecha, sCliente, sGlobal : String;
begin
    sFecha := FormatDateTime('mm/dd/yyyy',Date);
    if(iCliente = 0) then
      sCliente := 'null'
    else
      sCliente := IntToStr(iCliente);

    if(txtComprobante.Text = 'FACTURA') then
      sGlobal := sFacturaGlobal
    else if(txtComprobante.Text = 'NOTA') then
      sGlobal := sNotaGlobal
    else if(txtComprobante.Text = 'TICKET') then
      sGlobal := sTicketGlobal
    else if(txtComprobante.Text = 'AJUSTE') then
      sGlobal := sAjusteGlobal
    else if(txtComprobante.Text = 'COTIZACION') then
      sGlobal := sCotizaGlobal
    else if(txtComprobante.Text = 'DEVOLUCION') then
      sGlobal := sDevolucionGlobal
    else if(txtComprobante.Text = 'PEDIDO') then
      sGlobal := sPedidoGlobal;

    with dmDatos.qryModifica do begin
      if(txtComprobante.Text = 'PEDIDO') and (sClavePedido <> EmptyStr) then begin
        Close;
        SQL.Clear;
        SQL.Add('UPDATE comprobantes SET cliente = ' + sCliente + ' WHERE venta = ' + sClavePedido);
        ExecSQL;
        Close;

        SQL.Clear;
        SQL.Add('SELECT numero FROM comprobantes WHERE venta = ' + sClavePedido);
        Open;
        sNumComp := FieldByName('numero').AsString;
        Close;
      end
      else begin
        Close;
        SQL.Clear;
        if (bfiscal) then
           SQL.Add('SELECT MAX(numero) AS numero FROM comprobantes WHERE tipo = ''' + Copy(txtComprobante.Text,1,1) + '''')
        else
           SQL.Add('SELECT MAX(numero) AS numero FROM comprobantes WHERE tipo = ''P''');
     //   SQL.Add('AND estatus = ''A''');       mod 28sep2010
        if(sGlobal = 'N') then
            SQL.Add('AND caja = ' + IntToStr(iCaja));
        Open;
        sNumComp := IntToStr(FieldByName('numero').AsInteger + 1);

        Close;
        SQL.Clear;
        SQL.Add('INSERT INTO comprobantes (venta, tipo, numero, cliente, fecha, estatus, caja) VALUES(');
       if (bfiscal) then
            SQL.Add(sVenta + ',''' + Copy(txtComprobante.Text,1,1) + ''',' + sNumComp + ',')
       else
          SQL.Add(sVenta + ',''P'',' + sNumComp + ',');
        SQL.Add(sCliente + ',''' + sFecha + ''',''A'',' + IntToStr(iCaja) + ')');
        ExecSQL;
        Close;
      end;
    end;
end;

procedure TfrmVentas.ActualizaRenglon(iRen : integer);
var
    sCliente, sVendedor : String;
begin
cambiob:=false;
    if(iCliente < 1) then
        sCliente := 'null'
    else
        sCliente := IntToStr(iCliente);

    if(iVendedor < 1) then
        sVendedor := 'null'
    else
        sVendedor := IntToStr(iVendedor);

    with dmDatos.qryModifica do begin
        Close;
        SQL.Clear;
        SQL.Add('UPDATE ventasareas SET precio = ' + grdDatos.Cells[4,iRen] + ',');
        SQL.Add('cantidad = ' + grdDatos.Cells[3,iRen] + ',');
        SQL.Add('cantidad_cnt = ''' + grdDatos.Cells[16,iRen] + ''',');
        SQL.Add('cliente = ' + sCliente + ',');
        SQL.Add('vendedor = ' + sVendedor + ',');
        SQL.Add('descotorg = ' + grdDatos.Cells[8,iRen] + ',');
        SQL.Add('descfechas = ' + grdDatos.Cells[9,iRen] + ',');
        SQL.Add('descusuario = ' + grdDatos.Cells[13,iRen] + ',');
        SQL.Add('comentario = ''' + grdDatos.Cells[14,iRen] + '''');
        SQL.Add('WHERE areaventa = ' + sAreaVenta + ' AND orden = ' + IntToStr(iRen));
        ExecSQL;
        Close;
    end;
end;

procedure TfrmVentas.mnuRetirarClick(Sender: TObject);
var
    bAutoriza : boolean;
    sFecha, sHora, sCantidad, smotivo : String;

    iImpresora : TextFile;
    sPuertoImpre, sCodigoIni: String;
    i : Integer;
    sTipoVar : Char;

    sCaja,sLinea, sSerie, sUsuario, sCodigoCorta, sTel, sRfc : String;
    sCodigoFin, sVenta, sCliente, sCalle, sColonia, sLocalidad, sEstado, sCp : String;

begin
    bAutoriza := true;

    with TFrmAutoriza.Create(Self) do
    try
        if(not VerificaAutoriza(Self.iUsuario,'V10')) then begin
            sMensaje := '(Caja ' + IntToStr(iCaja) + ')';
            sTipoAutoriza := 'V10';
            iUsuario := Self.iUsuario;
            ShowModal;
            bAutoriza := bAutorizacion;
        end;
    finally
        Free;
    end;

    if(bAutoriza) then begin
        with TFrmCantidad.Create(Self) do
        try

            bDecimales := true;
            retiro := true;
            sTitulo := 'Efectivo';
            cajch.Visible := false;
             cajas.Visible:= false;
            ShowModal;
            if(rCantidad > 0) then begin
                sCantidad := FloatToStr(rCantidad); // Se le asigna la cantidad de frmCantidad
                sFecha := FormatDateTime('mm/dd/yyyy',Date);
                sHora := FormatDateTime('hh:nn:ss',Time);
                smotivo := ''''+ rmotivo +'''';
                with dmDatos.qryModifica do begin
                    Close;
                    SQL.Clear;
                    SQL.Add('INSERT INTO retiros (fecha, hora, usuario, importe, caja, motivo) VALUES('); //modificacion 21/07/2009
                    SQL.Add('''' + sFecha + ''',''' + sHora + ''',' + IntToStr(iUsuario) + ',');
                    SQL.Add(sCantidad + ',' + IntToStr(iCaja) + ',' + smotivo +')');  //modificacion 21/07/2009
                    ExecSQL;
                    Close;
                end;

               

    //Recupera el puerto de la impresora de tickets

                ///
              //frmReimprimir.ImprimeRetiros(IntToStr(iCaja), sFecha, sHora);
                ////
 {               sCaja:=IntToStr(iCaja);
                             Assignfile(iImpresora,'LPT1'); //Puerto: LPT1, COM1, etc;
        Rewrite(iImpresora);

        Writeln(iImpresora,sCodigoIni);

         dmDatos.qryAuxiliar1.Close;
            dmDatos.qryAuxiliar1.SQL.Clear;
            dmDatos.qryAuxiliar1.SQL.Add('SELECT * FROM ticket WHERE nivel = 1 ORDER BY nivel, renglon');
            dmDatos.qryAuxiliar1.Open;

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
            dmDatos.qryAuxiliar1.Close;
            if(Length(sSerie) > 0) then
                Writeln(iImpresora,'CAJA: ' + Format('%02d',[StrToInt(sCaja)]))
            else
                Writeln(iImpresora,'CAJA: ' + Format('%02d',[StrToInt(sCaja)]));
            Writeln(iImpresora,'FECHA: ' + sFecha + '         ' +
                    'HORA: ' + sHora);
            Writeln(iImpresora,'');
             Writeln(iImpresora,'----------------------------------------');
             Writeln(iImpresora,'---------------Retiro-------------------');
             Writeln(iImpresora,'Concepto:'+smotivo);
             Writeln(iImpresora,'Importe:'+sCantidad);
             Writeln(iImpresora,'');
             Writeln(iImpresora,'');
             Writeln(iImpresora,'');
             Writeln(iImpresora,'');
             Writeln(iImpresora,'');
             Writeln(iImpresora,'          ________________ ');
             Writeln(iImpresora,'              Autoriza');
              Writeln(iImpresora,sCodigoCorta);

            Writeln(iImpresora,sCodigoFin);

            CloseFile(iImpresora);   }
                ////
            end;
        finally
            Free;
        end;
    end;
    CodigoFoco;
end;

procedure TfrmVentas.mnuCancelarClick(Sender: TObject);
var
    bAutoriza : boolean;
    sCantidad, sCantidad_Cnt, sArticulo, sTipo, uuid : string;
    datosUsuario, uids,respuesta: arrayofstring;
    iniArchivo : TIniFile;
begin
    with TFrmAutoriza.Create(Self) do
    try
        if(not VerificaAutoriza(Self.iUsuario,'V05')) then begin
            sMensaje := '(Caja ' + IntToStr(iCaja) + ')';
            sTipoAutoriza := 'V05';
            iUsuario := Self.iUsuario;
            ShowModal;
            bAutoriza := bAutorizacion;
        end
        else
            bAutoriza := true;
    finally
        Free;
    end;

    if(bAutoriza) then
        with TfrmRecuperaVenta.Create(Self) do
        try
            sTitulo := 'Cancelar comprobante';
            if((ShowModal = mrOk) and (VerificaNumNota(sNumero, sTipoComp))) then begin
                if(Application.MessageBox('�Desea cancelar el comprobante ' + sTipoComp + ' con el n�mero ' + sNumero +
                                      ' del ' + sFecha + ' ' + sHora + ' de un total de ' + sTotal + '?','Cancelar',
                                      [smbOK,smbCancel], smsWarning) = smbOK) then begin
                    if (sTipoComp[1] = 'F') then
                    begin
        with dmDatos.qryModifica do begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT c.UUID, c.numero, c.tipo FROM comprobantes c where c.tipo = ''F'' and c.numero = ' + sNumero);

        Open;
        uuid :=  FieldByName('UUID').AsString;
        if(uuid = '') then begin
           Application.MessageBox('No existe UUID','Error',[smbOK], smsCritical);

        end
        else
        begin
        SetLength(uids,1);
        uids[0] :=  uuid;
      iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) +'config.ini');
        SetLength(datosUsuario,3);
datosUsuario[0]:= iniarchivo.ReadString('CFDI', 'RFC', '');
datosUsuario[1]:= iniarchivo.ReadString('CFDI', 'CUENTA', '');
datosUsuario[2]:= iniarchivo.ReadString('CFDI', 'PASSWORD', '');
iniArchivo.Free;
        respuesta := GetConexionRemota32Soap(true).CancelarCFDI(datosUsuario,uids);

        Application.MessageBox(respuesta[0] ,'Mensaje',[smbOK], smsCritical);


        end;



        Close;
    end;

                    end;

                    with dmDatos.qryModifica do begin
                        // Cancela el comprobante
                        Close;
                        SQL.Clear;
                        SQL.Add('UPDATE comprobantes SET estatus = ''C'' WHERE venta = ' + sVenta);
                        SQL.Add('AND tipo = ''' + Copy(sTipoComp,1,1) + '''');
                        ExecSQL;

                        // Cancela la venta
                        Close;
                        SQL.Clear;
                        SQL.Add('UPDATE ventas SET estatus = ''C'' WHERE clave = ' + sVenta);
                        ExecSQL;

                        // Cancela la cuenta por cobrar
                        Close;
                        SQL.Clear;
                        SQL.Add('UPDATE xcobrar SET estatus = ''C'' WHERE venta = ' + sVenta);
                        ExecSQL;

                        // Afecta la existencia
                        if (sTipoComp[1] <> 'C') then begin
                            Close;
                            SQL.Clear;
                            SQL.Add('SELECT a.clave, a.tipo, v.cantidad_cnt, v.cantidad FROM ventasdet v ');
                            SQL.Add('LEFT JOIN articulos a ON v.articulo = a.clave');
                            SQL.Add('WHERE v.venta = ' + sVenta);
                            Open;

                            while (not Eof) do begin
                                sTipo := FieldByName('tipo').AsString;
                                if (sTipo <> '1') then begin
                                    sArticulo := Trim(FieldByName('clave').AsString);
                                    sCantidad := Trim(FieldByName('cantidad').AsString);
                                    sCantidad_Cnt := FieldByName('cantidad_cnt').AsString;

                                    // si articulo controla cantidad en el almac�n
                                    if(sCantidad_Cnt = 'S') then begin
                                        with dmDatos.qryConsulta do begin
                                            Close;
                                            SQL.Clear;
                                            if (sTipoComp[1] = 'D') then
                                                SQL.Add('UPDATE articulos SET existencia = existencia - ' + sCantidad)
                                            else
                                                SQL.Add('UPDATE articulos SET existencia = existencia + ' + sCantidad);
                                            SQL.Add('WHERE clave = ' + sArticulo);
                                            ExecSQL;
                                        end;
                                    end;

                                end;
                                Next;
                            end;
                            Close;
                        end;

                        // Restaura la venta original para eliminar la devoluci�n por art�culo
                        if (sTipoComp[1] = 'D') then begin
                            Close;
                            SQL.Clear;
                            SQL.Add('SELECT cantidad, ventareforden FROM ventasdet WHERE venta = ' + sVenta);
                            Open;

                            while (not Eof) do begin
                                dmDatos.qryConsulta.Close;
                                dmDatos.qryConsulta.SQL.Clear;
                                dmDatos.qryConsulta.SQL.Add('UPDATE ventasdet SET devolucion = devolucion - ' + FieldByName('cantidad').AsString);
                                dmDatos.qryConsulta.SQL.Add('WHERE venta = ' + sVentaRef);
                                dmDatos.qryConsulta.SQL.Add('AND orden = ' + FieldByName('ventareforden').AsString);
                                dmDatos.qryConsulta.ExecSQL;
                                Next;
                            end;
                        end;
                    end;
                    //frmReimprimir.ImprimeCancela(grdComprobante.Cells[0,grdComprobante.Row], FloatToStr(txtCaja.Value), FloatToStr(txtNumero.Value));
                end;
            end;
        finally
            Free;
        end;
    CodigoFoco;
end;

procedure TfrmVentas.mnuClienteClick(Sender: TObject);
begin
    with TFrmCliente.Create(Self) do
    try
        iCliente := Self.iCliente;
        ShowModal;
        if(bAceptar) then begin
            Self.iCliente := iCliente;
            txtCliente.Text := sCliente;
            txtDescuento.Value := rDescuento;
            txtPrecio.Value := iPrecio;

            if(dteFechaVencim >= Date) then begin
                txtDescuento.Value := rDescuento;
            end
            else begin
                txtDescuento.Value := 0;
                if(Length(sCreden) > 0) then
                    Application.MessageBox('La credencial especificada ha vencido','Error',[smbOK],smsCritical);
            end;

            txtCliente.Visible := true;
            lblCliente.Visible := true;
            if(txtDescuento.Value > 0) then
                txtDescuento.Visible := true
            else
                txtDescuento.Visible := false;

            VerificaPrecios(iCliente);
        end;
    finally
        Free;
    end;
    CodigoFoco;
end;

procedure TfrmVentas.mnuReimprimirClick(Sender: TObject);
var
    bAutoriza : boolean;
begin
    bAutoriza := true;
    with TfrmAutoriza.Create(Self) do
    try
        if(not VerificaAutoriza(Self.iUsuario,'V09')) then begin
            sMensaje := '(Caja ' + IntToStr(iCaja) + ')';
            sTipoAutoriza := 'V09';
            iUsuario := Self.iUsuario;
            ShowModal;
            bAutoriza := bAutorizacion;
        end
    finally
        Free;
    end;

    if(bAutoriza) then begin
        frmReimprimir.iUsuario := iUsuario;
        frmReimprimir.ShowModal;
    end;
    CodigoFoco;
end;

procedure TfrmVentas.mnuBarraClick(Sender: TObject);
begin
    pnlBotones.Visible := not pnlBotones.Visible;
    mnuBarra.Checked := not mnuBarra.Checked;
end;

procedure TfrmVentas.mnuCopiarVentaClick(Sender: TObject);
var
    bAutoriza : boolean;
begin
    if(txtComprobante.Text <> 'DEVOLUCION') then begin
        with TFrmAutoriza.Create(Self) do
        try
            if(not VerificaAutoriza(Self.iUsuario,'V07')) then begin
                sMensaje := '(Caja ' + IntToStr(iCaja) + ')';
                sTipoAutoriza := 'V07';
                iUsuario := Self.iUsuario;
                ShowModal;
                bAutoriza := bAutorizacion;
            end
            else
                bAutoriza := true;
        finally
            Free;
        end;
    end
    else
        bAutoriza := true;

    if(bAutoriza) then
        with TfrmRecuperaVenta.Create(Self) do
        try
            sTitulo := 'Recuperar venta anterior';
            if(txtComprobante.Text = 'DEVOLUCION') then begin
                bCotizacion := false;
                bAjuste := false;
                bDevolucion := false;
                bPedido := false;
            end;
            if(ShowModal = mrOk) then begin
                Self.sVentaRef := sVenta;
                RecuperaVenta;
            end
        finally
            Free;
        end;
    CodigoFoco;
end;

procedure TfrmVentas.RecuperaVenta;
var
cpre:string;
begin
        with dmDatos.qryModifica do begin
            EliminaArea;

            // Recupera los datos de la venta
            Close;
            SQL.Clear;
            SQL.Add('SELECT v.*, c.nombre, c.descuento, c.precio AS tipoprecio, ');
            SQL.Add('n.nombre as nom_vendedor');
            SQL.Add('FROM ventas v LEFT JOIN clientes c ON v.cliente = c.clave');
            SQL.Add('LEFT JOIN vendedores n ON v.vendedor = n.clave');
            SQL.Add('WHERE v.clave = ' + sVentaRef);
            Open;

            Inicializa;
             cpre := Trim(FieldByName('VF').AsString);
             if (cpre = 'S') then
             begin
             cambio := true;
             end;
            iCliente := FieldByName('cliente').AsInteger;
            txtCliente.Text := Trim(FieldByName('nombre').AsString);
            txtDescuento.Value := FieldByName('descuento').AsFloat;
            iPrecio := FieldByName('tipoprecio').AsInteger;
            if(iPrecio = 0) then
                iPrecio := 1;
            txtPrecio.Value := iPrecio;

            txtCliente.Visible := true;
            lblCliente.Visible := true;

            if(txtDescuento.Value > 0) then begin
                txtDescuento.Visible := true;
                lblDescuento.Visible := true;
            end
            else begin
                txtDescuento.Visible := false;
                lblDescuento.Visible := false;
            end;

            iVendedor := FieldByName('vendedor').AsInteger;
            if(iVendedor > 0) then begin
                pnlEncab.Height:= 114;
                txtVendedor.Text := Trim(FieldByName('nom_vendedor').AsString);
            end;

            // Recupera el detalle de la venta
            Close;
            SQL.Clear;
            SQL.Add('SELECT a.clave, o.codigo, a.desc_larga, a.tipo, a.desc_auto,');
            SQL.Add('a.categoria, a.departamento, v.cantidad, v.precio,v.facturable, v.iva, v.fecha,');
            SQL.Add('v.descuento, v.orden, v.devolucion, v.ventareforden, v.cantidad_cnt,v.fiscal,v.articuloalterno, m.comentario');
            SQL.Add('FROM ventasdet v ');
            SQL.Add('JOIN articulos a ON v.articulo = a.clave');
            SQL.Add('LEFT JOIN codigos o ON o.articulo = a.clave AND o.tipo = ''P''');
            SQL.Add('LEFT JOIN ventascoment m ON v.comentario = m.clave');
            SQL.Add('WHERE v.venta = ' + sVentaRef + ' AND v.juego = 0');
            if(txtComprobante.Text = 'DEVOLUCION') then
                SQL.Add('AND cantidad - devolucion > 0');
            SQL.Add('ORDER BY v.orden');
            Open;

            if(Eof) then
                Application.MessageBox('Esta venta no tiene art�culos para recuperar','Recuperar',[smbOK],smsCritical);

            while(not Eof) do begin
                if (not FieldByName('clave').IsNull) then begin
                    Inc(iNumero);
                    grdDatos.RowCount := iNumero + 1;
                    grdDatos.Cells[0,iNumero] := FieldByName('clave').AsString;                 // Clave del art�culo
                    grdDatos.Cells[1,iNumero] := Trim(FieldByName('codigo').AsString);          // C�digo
                    grdDatos.Cells[2,iNumero] := Trim(FieldByName('desc_larga').AsString);      // Descripci�n del art�culo
                    if(txtComprobante.Text = 'DEVOLUCION') then
                        grdDatos.Cells[3,iNumero] := FloatToStr(FieldByName('cantidad').AsFloat - FieldByName('devolucion').AsFloat)   // Cantidad de art�culos
                    else
                        grdDatos.Cells[3,iNumero] := FloatToStr(FieldByName('cantidad').AsFloat);   // Cantidad de art�culos
                        
                    grdDatos.Cells[4,iNumero] := FloatToStr(FieldByName('precio').AsFloat);     // Precio del art�culo
                    grdDatos.Cells[5,iNumero] := FloatToStr(FieldByName('iva').AsFloat);        // I.V.A. del art�culo
                    grdDatos.Cells[6,iNumero] := Trim(FieldByName('tipo').AsString);            // Tipo de art�culo (A granel, Juego, etc.
                    grdDatos.Cells[7,iNumero] := Trim(FieldByName('desc_auto').AsString);       // Descuento autom�tico del art�culo
                    grdDatos.Cells[8,iNumero] := FloatToStr(FieldByName('descuento').AsFloat);  // Descuento otorgado
                    grdDatos.Cells[9,iNumero] := '0';                                           // Descuento por fechas
                    grdDatos.Cells[10,iNumero] := IntToStr(FieldByName('categoria').AsInteger); // Categoria
                    grdDatos.Cells[11,iNumero] := IntToStr(FieldByName('departamento').AsInteger);  // Departamento
                    grdDatos.Cells[12,iNumero] := FieldByName('orden').AsString;                   // Orden
                    grdDatos.Cells[13,iNumero] := '0'; // descuento por usuario
                    grdDatos.Cells[14,iNumero] := FieldByName('comentario').AsString;;  // Comentario
                    grdDatos.Cells[15,iNumero] := FormatDateTime('mm/dd/yyyy',FieldByName('fecha').AsdateTime);;  // Comentario
                    grdDatos.Cells[16,iNumero] := FieldByName('cantidad_cnt').AsString;;  // controle de cantidad del articulo en el almac�n
                    grdDatos.Cells[17,iNumero] := FieldByName('fiscal').AsString;
                    grdDatos.Cells[18,iNumero] := FieldByName('articuloalterno').AsString;
                    grdDatos.Cells[19,iNumero] := FieldByName('facturable').AsString;

                    // Guarda los datos del art�culo en un grid que se muestra en la pantalla
                    grdVenta.RowCount := iNumero + 2;
                    grdVenta.Cells[0,iNumero + 1] := IntToStr(iNumero + 1);         // Consecutivo
                    grdVenta.Cells[1,iNumero + 1] := grdDatos.Cells[2,iNumero];     // Descripci�n corta
                    grdVenta.Cells[2,iNumero + 1] := grdDatos.Cells[3,iNumero];     // Cantidad
                    grdVenta.Cells[3,iNumero + 1] := grdDatos.Cells[4,iNumero];     // Precio
                    grdVenta.Cells[4,iNumero + 1] := grdDatos.Cells[8,iNumero];     // Descuento
                    grdVenta.Cells[5,iNumero + 1] := FloatToStr(StrToFloat(grdDatos.Cells[4,iNumero])*(1-StrToFloat(grdDatos.Cells[8,iNumero])/100));        // Precio neto
                    grdVenta.Cells[6,iNumero + 1] := FloatToStr(StrToFloat(grdVenta.Cells[5,iNumero + 1]) * StrToFloat(grdDatos.Cells[3,iNumero]));  // Importe

                    GuardaRenglon(iNumero); // Guarda los datos del art�culo en la tabla ventasareas
                end;
                Next;
            end;
            Close;
            Total;
        end;
end;

procedure TfrmVentas.mnuAbrirCajonClick(Sender: TObject);
begin
    with TFrmAutoriza.Create(Self) do
    try
        sMensaje := '(Caja ' + IntToStr(iCaja) + ')';
        sTipoAutoriza := 'V01';
        iUsuario := Self.iUsuario;
        ShowModal;
        if(bAutorizacion) then
            frmPago.AbreCajon;
    finally
        Free;
    end;
    SetFocus;
end;

procedure TfrmVentas.mnuEliminarDescClick(Sender: TObject);
var
    i : integer;
begin
    if (iNumero <> -1) then
    begin
      FSinDescuento:= true;
      if(Application.MessageBox('Se eliminar�n todos los descuentos','Eliminar descuentos',[smbOk]+[smbCancel],smsWarning) = smbOk) then begin
        for i := 0 to grdDatos.RowCount - 1 do begin
          grdDatos.Cells[8,i] := '0';                              // Descuento otorgado
          grdDatos.Cells[9,i] := '0';                              // Descuento por fechas
          grdVenta.Cells[4,i + 1] := '0';                          // Descuento
          grdVenta.Cells[5,i + 1] := grdVenta.Cells[3,i + 1];      // Precio neto
          grdVenta.Cells[6,i + 1] := FloatToStr(StrToFloat(grdVenta.Cells[2,i + 1]) * StrToFloat(grdVenta.Cells[5,i + 1]));    // Importe
          ActualizaRenglon(i);
        end;
        Total;
      end;
    end;
end;

procedure TfrmVentas.mnuCalculadoraClick(Sender: TObject);
begin
    with TFrmCalculadora.Create(Self) do
    try
        ShowModal;
    finally
        Free;
    end;
    SetFocus;
end;

procedure TfrmVentas.mnuConsecutivosClick(Sender: TObject);
begin
    with TFrmAutoriza.Create(Self) do
    try
        if(not VerificaAutoriza(Self.iUsuario,'V11')) then begin
            sMensaje := '(Caja ' + IntToStr(iCaja) + ')';
            sTipoAutoriza := 'V11';
            iUsuario := Self.iUsuario;
            ShowModal;
        end
        else
            with TFrmConsecutivos.Create(Self) do
            try
                iUsuario := Self.iUsuario;
                ShowModal;
            finally
                Free;
            end;
    finally
        Free;
    end;
    CodigoFoco;
end;

procedure TfrmVentas.mnuDescIndividualClick(Sender: TObject);
var
    bAutoriza  : boolean;
    rDesc : real;
    i : integer;
begin
    bAutoriza := false;
    if(iNumero <> - 1) then
        with TFrmAutoriza.Create(Self) do
        try
            if(not VerificaAutoriza(Self.iUsuario,'V13')) then begin

                sMensaje := '(Caja ' + IntToStr(iCaja) + ')';
                sTipoAutoriza := 'V13';
                iUsuario := Self.iUsuario;
                ShowModal;
                bAutoriza := bAutorizacion;
            end
            else
                bAutoriza := true;
        finally
            Free;
        end;

    if(bAutoriza) then begin
        with dmDatos.qryModifica do begin
            Close;
            SQL.Clear;
            SQL.Add('SELECT descuento FROM usuarios WHERE clave = ' + IntToStr(iUsuario));
            Open;
            rDesc := FieldByName('descuento').AsFloat;
            Close;
        end;

        with TFrmCantidad.Create(Self) do
        try
            cajch.Visible:= false;
            cajas.Visible :=false;
            rCantidad := StrToFloat(grdVenta.Cells[4,grdVenta.Row]);
            sTitulo := 'Descuento (Porcentaje)';
            bDecimales := true;
            ShowModal;
            if (rCantidad <> -1) then
                if(rCantidad <= rDesc) and (rCantidad >= 0) then begin
                    if ((Sender as TMenuItem).Name = 'mnuDescIndividual') then begin
                        if (grdDatos.Cells[7,grdVenta.Row-1] = 'S') then begin
                            grdVenta.Cells[4,grdVenta.Row] := FloatToStr(rCantidad);  // Descuento
                            grdDatos.Cells[13,grdVenta.Row-1] := FloatToStr(rCantidad);
                            grdDatos.Cells[8,grdVenta.Row-1] := FloatToStr(rCantidad);// Descuento en el grid de Datos

                            grdVenta.Cells[5,grdVenta.Row] := FloatToStr(StrToFloat(grdVenta.Cells[3,grdVenta.Row]) *
                                                              (1 - StrToFloat(grdVenta.Cells[4,grdVenta.Row]) / 100));    // Precio neto
                            grdVenta.Cells[6,grdVenta.Row] := FloatToStr(StrToFloat(grdVenta.Cells[5,grdVenta.Row]) *
                                                              StrToFloat(grdVenta.Cells[2,grdVenta.Row]));    // Importe
                            grdDatos.Cells[19,grdVenta.Row-1] := '1';
                             cambio := true;
                            ActualizaRenglon(grdVenta.Row-1);
                        end
                        else
                          Application.MessageBox('No se puede aplicar descuento al art�culo seleccionado','Error',[smbOK],smsCritical);
                    end
                    else
                        for i := 1 to iNumero+1 do begin
                            grdVenta.Cells[4,i] := FloatToStr(rCantidad);  // Descuento
                            grdDatos.Cells[13,i-1] := FloatToStr(rCantidad); // Descuento en el grid de Datos
                             grdDatos.Cells[8,grdVenta.Row-1] := FloatToStr(rCantidad);
                            grdVenta.Cells[5,i] := FloatToStr(StrToFloat(grdVenta.Cells[3,i]) *
                                                              (1 - StrToFloat(grdVenta.Cells[4,i]) / 100));    // Precio neto
                            grdVenta.Cells[6,i] := FloatToStr(StrToFloat(grdVenta.Cells[5,i]) *
                                                              StrToFloat(grdVenta.Cells[2,i]));    // Importe
                            grdDatos.Cells[19,i-1] := '1';
                             cambio := true;
                            ActualizaRenglon(i-1)
                        end;
                    Total;
                end
                else
                    Application.MessageBox('El descuento otorgado no puede ser mayor a ' + FloatToStr(rDesc) + '%','Error',[smbOK],smsCritical);
        finally
            Free;
        end;
    end;
    CodigoFoco;
end;

procedure TfrmVentas.grdVentaSelectCell(Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
begin
    CodigoFoco;
end;

procedure TfrmVentas.CodigoFoco;
begin
    if(txtCodigo.Enabled) then
        txtCodigo.SetFocus
    else
        grdVenta.SetFocus;
end;

procedure TfrmVentas.mnuNotaCreditoClick(Sender: TObject);
var
    bAutoriza : boolean;
begin
    with TFrmAutoriza.Create(Self) do
    try
        if(not VerificaAutoriza(Self.iUsuario,'V14')) then begin
            sMensaje := '(Caja ' + IntToStr(iCaja) + ')';
            sTipoAutoriza := 'V14';
            iUsuario := Self.iUsuario;
            ShowModal;
            bAutoriza := bAutorizacion;
        end
        else
            bAutoriza := true;
    finally
        Free;
    end;

    if(bAutoriza) then
        with TFrmNotaCredito.Create(Self) do
        try
            sTipo := 'Captura';
            ShowModal;
        finally
            Free;
        end;
    CodigoFoco;
end;

procedure TfrmVentas.Comentarios1Click(Sender: TObject);
begin
    with TfrmComentario.Create(Self) do
    try
        memComentario.Text := grdDatos.Cells[14,grdVenta.Row-1];
        if(ShowModal = mrOk) then begin
            grdDatos.Cells[14,grdVenta.Row-1] := Trim(memComentario.Text);
            grdVenta.Refresh;
                ActualizaRenglon(grdVenta.Row-1);
        end;
    finally
        Free;
    end;
    CodigoFoco;
end;

procedure TfrmVentas.Buscarpedido1Click(Sender: TObject);
begin
    with TfrmPedidos.Create(Self) do
    try
        if(ShowModal = mrOk) then begin
          txtComprobante.Text:= 'PEDIDO';
          Self.sClavePedido := IntToStr(ClaveVenta);
          sVentaRef:= sClavePedido;
          RecuperaVenta;
        end;
    finally
        Free;
    end;
    CodigoFoco;
end;

function TfrmVentas.VerificaNumNota(sComprobante, sTipoComp : String) : boolean;
begin
    Result := true;
    with dmDatos.qryModifica do begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT n.comprobante, n.numero FROM notascredito n JOIN comprobantes c ON n.comprobante = c.clave');
        SQL.Add('WHERE c.clave = ' + sComprobante);
        SQL.Add('AND c.tipo = ''' + Copy(sTipoComp,1,1) + '''');
        SQL.Add('AND n.estatus IN (''A'',''U'') AND c.estatus = ''A''');
        Open;

        // existe una nota de credito para la venta, no �s posible eliminar la venta
        if(not Eof) then begin
            Application.MessageBox('El comprobante ' + sComprobante + ' tiene la NOTA DE CR�DITO con el n�mero ' +
                                   FieldByName('numero').AsString + '. Cancele la NOTA DE CR�DITO primero' ,'Error',[smbOK],smsCritical);
            Result := false;
        end;

        Close;
    end;
end;

procedure TfrmVentas.mnuVendedorClick(Sender: TObject);
var
    bAutoriza : boolean;
begin
    with TFrmAutoriza.Create(Self) do
    try
        if(not VerificaAutoriza(Self.iUsuario,'V15')) then begin
            sMensaje := '(Caja ' + IntToStr(iCaja) + ')';
            sTipoAutoriza := 'V15';
            iUsuario := Self.iUsuario;
            ShowModal;
            bAutoriza := bAutorizacion;
        end
        else
            bAutoriza := true;
    finally
        Free;
    end;

    if(bAutoriza) then begin
        with TFrmVendedoresBusq.Create(Self) do
        try
            if(ShowModal = mrOk) then begin
                pnlEncab.Height:= 114;
                Self.iVendedor := StrToInt(sClave);
                txtVendedor.Text := sNombre;
            end;
        finally
            Free;
        end;
        // asigna el vendedor a venta
        with dmDatos.qryModifica do begin
            Close;
            SQL.Clear;
            SQL.Add('UPDATE ventasareas SET vendedor = ' + IntToStr(iVendedor) + ' WHERE areaventa = ' + sAreaVenta);
            ExecSQL;
            Close;
        end;
    end;

    CodigoFoco;
end;

procedure TfrmVentas.EliminaArtSinExistencia;
var
    i : Integer;
begin
    //Elimina las ventas pendientes a partir del renglon seleccionado
    with dmDatos.qryModifica do begin
        Close;
        SQL.Clear;
        SQL.Add('DELETE FROM ventasareas WHERE areaventa = ' + sAreaVenta);
        SQL.Add('AND orden = ' + IntToStr(grdVenta.Row-1));
        ExecSQL;

        Close;
        SQL.Clear;
        SQL.Add('UPDATE ventasareas SET orden = orden - 1 WHERE areaventa = ' + sAreaVenta);
        SQL.Add('AND orden > ' + IntToStr(grdVenta.Row-1));
        ExecSQL;
        Close;
    end;
    for i := grdVenta.Row to grdVenta.RowCount - 2 do begin
        grdVenta.Cells[0,i+1] := IntToStr(StrToInt(grdVenta.Cells[0,i+1]) - 1);
        grdVenta.Rows[i] := grdVenta.Rows[i+1];
        grdDatos.Rows[i-1] := grdDatos.Rows[i];
    end;
    if(grdVenta.RowCount > 2) then begin
        grdVenta.RowCount := grdVenta.RowCount - 1;
        grdDatos.RowCount := grdVenta.RowCount - 1;
    end
    else begin
        grdVenta.Cells[0,1] := '';
        grdVenta.Cells[1,1] := '';
        grdVenta.Cells[2,1] := '';
        grdVenta.Cells[3,1] := '';
        grdVenta.Cells[4,1] := '';
        grdVenta.Cells[5,1] := '';
        grdVenta.Cells[6,1] := '';
    end;
    iNumero := iNumero - 1;
    Total;

    bEliminaArtSinExistencia := false;
end;

procedure TfrmVentas.btnCantidadClick(Sender: TObject);
var
i : integer;
begin
 {
        with dmDatos.qryConsulta do
        begin
        Close;
                    SQL.Clear;
                    SQL.Add('SELECT codigo FROM ventasareas WHERE areaventa = ' + sAreaVenta);
                    SQL.Add('AND orden = ' + IntToStr(grdVenta.Row-1));
                    Open;

                    txtCodigo.Text:=Trim(FieldByName('codigo').AsString);
        end;
            ///elimina
         with dmDatos.qryModifica do begin
                    Close;
                    SQL.Clear;
                    SQL.Add('DELETE FROM ventasareas WHERE areaventa = ' + sAreaVenta);
                    SQL.Add('AND orden = ' + IntToStr(grdVenta.Row-1));
                    ExecSQL;

                    Close;
                    SQL.Clear;
                    SQL.Add('UPDATE ventasareas SET orden = orden - 1 WHERE areaventa = ' + sAreaVenta);
                    SQL.Add('AND orden > ' + IntToStr(grdVenta.Row-1));
                    ExecSQL;
                    Close;
                end;
                for i := grdVenta.Row to grdVenta.RowCount - 2 do begin
                    grdVenta.Cells[0,i+1] := IntToStr(StrToInt(grdVenta.Cells[0,i+1]) - 1);
                    grdVenta.Rows[i] := grdVenta.Rows[i+1];
                    grdDatos.Rows[i-1] := grdDatos.Rows[i];
                end;
                if(grdVenta.RowCount > 2) then begin
                    grdVenta.RowCount := grdVenta.RowCount - 1;
                    grdDatos.RowCount := grdVenta.RowCount - 1;
                end
                else begin
                    grdVenta.Cells[0,1] := '';
                    grdVenta.Cells[1,1] := '';
                    grdVenta.Cells[2,1] := '';
                    grdVenta.Cells[3,1] := '';
                    grdVenta.Cells[4,1] := '';
                    grdVenta.Cells[5,1] := '';
                    grdVenta.Cells[6,1] := '';
                end;
                iNumero := iNumero - 1;
                Total;




               /////fin de elimina
               CodigoFoco;
               BuscaArticulo;



             }
end;

procedure TfrmVentas.IVA1Click(Sender: TObject);
var
    rPrecio : real;

begin


                    cambio:= true;
                     if(Length(Trim(grdDatos.Cells[21,grdVenta.Row-1])) > 0) then
                     begin
                    rPrecio :=  StrToFloat(grdVenta.Cells[3,grdVenta.Row]) * 1.16;
                        grdDatos.Cells[21,grdVenta.Row-1]:= '';
                        grdVenta.Cells[3,grdVenta.Row] := FloatToStr(rPrecio);  // Precio unitario
                        grdDatos.Cells[4,grdVenta.Row-1] := FloatToStr(rPrecio); // Precio unitario en el grid datos
                        grdVenta.Cells[5,grdVenta.Row] := FloatToStr(StrToFloat(grdVenta.Cells[3,grdVenta.Row]) *
                                                          (1 - StrToFloat(grdVenta.Cells[4,grdVenta.Row]) / 100));    // Precio neto
                        grdVenta.Cells[6,grdVenta.Row] := FloatToStr(StrToFloat(grdVenta.Cells[5,grdVenta.Row]) *
                                                            StrToFloat(grdVenta.Cells[2,grdVenta.Row]));    // Importe
                        grdDatos.Cells[19,grdVenta.Row-1] := '0';
                        cambio:= false;
                        ActualizaRenglon(grdVenta.Row-1);
                        Total;

                       // grdDatos.Cells[19,grdVenta.Row-1] := '1';
            grdVenta.Refresh;
                ActualizaRenglon(grdVenta.Row-1);
              end
              else
              begin

                        rPrecio :=  StrToFloat(grdVenta.Cells[3,grdVenta.Row]) / 1.16;
                        grdDatos.Cells[21,grdVenta.Row-1]:= '1';
                        grdVenta.Cells[3,grdVenta.Row] := FloatToStr(rPrecio);  // Precio unitario
                        grdDatos.Cells[4,grdVenta.Row-1] := FloatToStr(rPrecio); // Precio unitario en el grid datos
                        grdVenta.Cells[5,grdVenta.Row] := FloatToStr(StrToFloat(grdVenta.Cells[3,grdVenta.Row]) *
                                                          (1 - StrToFloat(grdVenta.Cells[4,grdVenta.Row]) / 100));    // Precio neto
                        grdVenta.Cells[6,grdVenta.Row] := FloatToStr(StrToFloat(grdVenta.Cells[5,grdVenta.Row]) *
                                                            StrToFloat(grdVenta.Cells[2,grdVenta.Row]));    // Importe
                        grdDatos.Cells[19,grdVenta.Row-1] := '1';
                        cambio:=true;
                        ActualizaRenglon(grdVenta.Row-1);
                        Total;

                       // grdDatos.Cells[19,grdVenta.Row-1] := '1';
            grdVenta.Refresh;
                ActualizaRenglon(grdVenta.Row-1);
               end;

end;

Procedure TfrmVentas.cfdpre;
begin

 with TcfdiFrom.Create(Self) do
    try

        cfdtotal := rTotal;
        cfdventa := sVenta;
        ShowModal;
         finally
        Free;
    end;



end;




procedure TfrmVentas.CFDi1Click(Sender: TObject);
begin
  cfdpre;
end;

procedure TfrmVentas.IncrementoIndividual1Click(Sender: TObject);
var
    bAutoriza  : boolean;
    rDesc : real;
    i : integer;
     rPrecio : real;
begin
    bAutoriza := false;
    if(iNumero <> - 1) then
        with TFrmAutoriza.Create(Self) do
        try
            if(not VerificaAutoriza(Self.iUsuario,'V13')) then begin
                sMensaje := '(Caja ' + IntToStr(iCaja) + ')';
                sTipoAutoriza := 'V13';
                iUsuario := Self.iUsuario;
                ShowModal;
                bAutoriza := bAutorizacion;
            end
            else
                bAutoriza := true;
        finally
            Free;
        end;

    if(bAutoriza) then begin
     {   with dmDatos.qryModifica do begin
            Close;
            SQL.Clear;
            SQL.Add('SELECT descuento FROM usuarios WHERE clave = ' + IntToStr(iUsuario));
            Open;
            rDesc := FieldByName('descuento').AsFloat;
            Close;
        end;     }

        with TFrmCantidad.Create(Self) do
        try
            rCantidad := StrToFloat(grdVenta.Cells[4,grdVenta.Row]);
            sTitulo := 'Incremento (Porcentaje)';
             cajch.Visible:=false;
             cajas.Visible:=false;
            bDecimales := true;
            ShowModal;
            if (rCantidad <> -1) then
                if(rCantidad >= 0) then begin

                       rPrecio :=  StrToFloat(grdVenta.Cells[3,grdVenta.Row]) * (1 + (rCantidad / 100 ));
                        //grdDatos.Cells[21,grdVenta.Row-1]:= '';
                        grdVenta.Cells[3,grdVenta.Row] := FloatToStr(rPrecio);  // Precio unitario
                        grdDatos.Cells[4,grdVenta.Row-1] := FloatToStr(rPrecio); // Precio unitario en el grid datos
                        grdVenta.Cells[5,grdVenta.Row] := FloatToStr(StrToFloat(grdVenta.Cells[3,grdVenta.Row]) *
                                                          (1 - StrToFloat(grdVenta.Cells[4,grdVenta.Row]) / 100));    // Precio neto
                        grdVenta.Cells[6,grdVenta.Row] := FloatToStr(StrToFloat(grdVenta.Cells[5,grdVenta.Row]) *
                                                            StrToFloat(grdVenta.Cells[2,grdVenta.Row]));    // Importe
                       grdDatos.Cells[19,grdVenta.Row-1] := '1';
                        ActualizaRenglon(grdVenta.Row-1);
                        Total;

                       // grdDatos.Cells[19,grdVenta.Row-1] := '1';
            grdVenta.Refresh;
                ActualizaRenglon(grdVenta.Row-1);
                end;


        finally
            Free;
        end;
    end;
    CodigoFoco;
end;

procedure TfrmVentas.IncrementoGeneral1Click(Sender: TObject);
var
    bAutoriza  : boolean;
    rDesc : real;
    i : integer;
     rPrecio : real;
begin
    bAutoriza := false;
    if(iNumero <> - 1) then
        with TFrmAutoriza.Create(Self) do
        try
            if(not VerificaAutoriza(Self.iUsuario,'V13')) then begin
                sMensaje := '(Caja ' + IntToStr(iCaja) + ')';
                sTipoAutoriza := 'V13';
                iUsuario := Self.iUsuario;
                ShowModal;
                bAutoriza := bAutorizacion;
            end
            else
                bAutoriza := true;
        finally
            Free;
        end;

    if(bAutoriza) then begin
     {   with dmDatos.qryModifica do begin
            Close;
            SQL.Clear;
            SQL.Add('SELECT descuento FROM usuarios WHERE clave = ' + IntToStr(iUsuario));
            Open;
            rDesc := FieldByName('descuento').AsFloat;
            Close;
        end;     }

        with TFrmCantidad.Create(Self) do
        try
            rCantidad := StrToFloat(grdVenta.Cells[4,grdVenta.Row]);
            sTitulo := 'Incremento (Porcentaje)';
             cajch.Visible:=false;
             cajas.Visible:=false;
            bDecimales := true;
            ShowModal;
            if (rCantidad <> -1) then
                if(rCantidad >= 0) then begin
                         for i := 1 to iNumero+1 do begin
                       rPrecio :=  StrToFloat(grdVenta.Cells[3,i]) * (1 + (rCantidad / 100 ));
                        //grdDatos.Cells[21,grdVenta.Row-1]:= '';
                        grdVenta.Cells[3,i] := FloatToStr(rPrecio);  // Precio unitario
                        grdDatos.Cells[4,i-1] := FloatToStr(rPrecio); // Precio unitario en el grid datos
                        grdVenta.Cells[5,i] := FloatToStr(StrToFloat(grdVenta.Cells[3,i]) *
                                                          (1 - StrToFloat(grdVenta.Cells[4,i]) / 100));    // Precio neto
                        grdVenta.Cells[6,i] := FloatToStr(StrToFloat(grdVenta.Cells[5,i]) *
                                                            StrToFloat(grdVenta.Cells[2,i]));    // Importe
                         grdDatos.Cells[19,i-1] := '1';                                    
                        ActualizaRenglon(i-1);


                     





                       // grdDatos.Cells[19,grdVenta.Row-1] := '1';
            grdVenta.Refresh;
                ActualizaRenglon(i-1);
                end;
                Total;
                 end;


        finally
            Free;
        end;
    end;
    CodigoFoco;
end;

end.

