// --------------------------------------------------------------------------
// Archivo del Proyecto Ventas  
// P�gina del proyecto: http://sourceforge.net/projects/ventas
// --------------------------------------------------------------------------
// Este archivo puede ser distribuido y/o modificado bajo lo terminos de la
// Licencia P�blica General versi�n 2 como es publicada por la Free Software
// Fundation, Inc.
// --------------------------------------------------------------------------

unit Compras;

interface

uses
  {$IFDEF MSWINDOWS}
      Windows,ShellApi,
  {$ENDIF}
  {$IFDEF LINUX}
      Libc,
  {$ENDIF}
  SysUtils, Types, Classes, QGraphics, QControls, QForms, QDialogs, IniFiles,
  QStdCtrls, QcurrEdit, QExtCtrls, QMenus, QTypes, QButtons, Qt, QGrids;

type
  TfrmCompras = class(TForm)
    pnlArticulo: TPanel;
    txtCodigo: TEdit;
    Label1: TLabel;
    pnlTotal: TPanel;
    Label2: TLabel;
    txtTotal: TcurrEdit;
    Label5: TLabel;
    txtHora: TEdit;
    pnlEncab: TPanel;
    lblCliente: TLabel;
    txtProveedor: TEdit;
    Label7: TLabel;
    txtDocumento: TEdit;
    grdCompra: TStringGrid;
    grdDatos: TStringGrid;
    tmeHora: TTimer;
    pnlMensaje: TPanel;
    Label6: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    pnlBotones: TPanel;
    btnGuardar: TBitBtn;
    btnCosto: TBitBtn;
    btnComprobante: TBitBtn;
    btnCantidad: TBitBtn;
    btnArticulos: TBitBtn;
    btnEliminar: TBitBtn;
    btnCancelaAnterior: TBitBtn;
    lblIva: TLabel;
    txtIva: TcurrEdit;
    btnDescIndividual: TBitBtn;
    pnlIva: TPanel;
    txtSubTotal: TcurrEdit;
    Label3: TLabel;
    Label10: TLabel;
    txtComprobante: TEdit;
    btnDocto: TBitBtn;
    Label4: TLabel;
    txtFecha: TEdit;
    Label11: TLabel;
    txtFechaDoc: TEdit;
    ppmMenu: TPopupMenu;
    mnuCancelaActual: TMenuItem;
    N1: TMenuItem;
    mnuAyuda: TMenuItem;
    mnuGuardar: TMenuItem;
    mnuCosto: TMenuItem;
    mnuComprobante: TMenuItem;
    mnuDocumento: TMenuItem;
    mnuCantidad: TMenuItem;
    mnuDescIndividual: TMenuItem;
    mnuArticulos: TMenuItem;
    mnuEliminar: TMenuItem;
    mnuCancelaAnterior: TMenuItem;
    mnuAdicionales: TMenuItem;
    mnuCalculadora: TMenuItem;
    mnuEliminarDescuentos: TMenuItem;
    N2: TMenuItem;
    mnuBarra: TMenuItem;
    DescuentoGeneral1: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure tmeHoraTimer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure txtDocumentoEnter(Sender: TObject);
    procedure txtCodigoKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure mnuCostoClick(Sender: TObject);
    procedure grdCompraDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure mnuCantidadClick(Sender: TObject);
    procedure mnuEliminarClick(Sender: TObject);
    procedure mnuArticulosClick(Sender: TObject);
    procedure grdCompraMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure mnuGuardarClick(Sender: TObject);
    procedure mnuCancelaAnteriorClick(Sender: TObject);
    procedure mnuCancelaActualClick(Sender: TObject);
    procedure mnuAyudaClick(Sender: TObject);
    procedure mnuBarraClick(Sender: TObject);
    procedure btnDescIndividualClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure grdCompraSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure btnComprobanteClick(Sender: TObject);
    procedure mnuDocumentoClick(Sender: TObject);
    procedure mnuCalculadoraClick(Sender: TObject);
    procedure mnuEliminarDescuentosClick(Sender: TObject);
  private
    iProveedor, iNumero, iCaja, iClaveCompra : integer;
    bCodigoEnter, bCantidadAuto, bLetras : boolean;
    rTotal, rIva, rDescuento : real;
    sIva, sComprobanteDef: String;

    procedure RecuperaConfig;
    procedure AjustaVentana;
    procedure Inicializa;
    procedure Total;
    procedure BuscaArticulo;
    procedure GuardaDatos;
    procedure MuestraAyuda(sUrl:string);
    procedure LimpiaArticulos;
  public
    iUsuario : integer;
    sEmpresa : String;
  end;

var
  frmCompras: TfrmCompras;

implementation

uses dm, venta, cantidad, ArticuloBusq, ProveedBusq, CompraDoc, Pago, TipoComprobante, Calc;

{$R *.xfm}

procedure TfrmCompras.FormShow(Sender: TObject);
begin
    RecuperaConfig;
//    VerificaPago;
    tmeHora.Enabled := true;

    Caption := 'Compras - ' + sEmpresa;
    txtFecha.Text := FormatDateTime('dd/mm/yyyy',Date);
    AjustaVentana;
    iProveedor := 0;
    Inicializa;
end;

{function TfrmCompras.VerificaPago;
begin
end;}

procedure TfrmCompras.tmeHoraTimer(Sender: TObject);
begin
    txtHora.Text := FormatDateTime('hh:nn:ss',Now);
end;

procedure TfrmCompras.FormClose(Sender: TObject; var Action: TCloseAction);
var
    iniArchivo : TIniFile;
begin
    tmeHora.Enabled := false;
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) +'config.ini');
    with iniArchivo do begin
        // Registra estado de la barra de botones
        if(mnuBarra.Checked) then
            WriteString('Compras', 'Barra', 'S')
        else
            WriteString('Compras', 'Barra', 'N');
        Free;
    end;
end;

procedure TfrmCompras.RecuperaConfig;
var
    iniArchivo : TIniFile;
    sValor : String;
begin
    with dmDatos.qryConsulta do begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT * FROM config');
        Open;

        if(FieldByName('letraencodigo').AsString = 'S' ) then
            bLetras := true
        else
            bLetras := false;

        sComprobanteDef := FieldByName('comprobantecompras').AsString;
        if(sComprobanteDef = 'A' ) then
            sComprobanteDef := 'AJUSTE'
        else if(sComprobanteDef = 'G' ) then
            sComprobanteDef := 'GASTO'
        else if(sComprobanteDef = 'M' ) then
            sComprobanteDef := 'MERCANCIA';
        txtComprobante.Text := sComprobanteDef;
    end;

    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'config.ini');
    with iniArchivo do begin

        //Recupera el n�mero de caja
        sValor := ReadString('Config', 'Caja', '');
        if (Length(sValor) > 0) then
            iCaja := StrToInt(sValor);

        //Recupera el estado de la barra de botones
        sValor := ReadString('Compras', 'Barra', '');
        if (sValor= 'S') then begin
            mnuBarra.Checked := true;
            pnlBotones.Visible := true;
        end
        else begin
            mnuBarra.Checked := false;
            pnlBotones.Visible := false;
        end;

        //Recupera la cantidad automatica
        sValor := ReadString('Compras', 'Cantidad', '');
        if (sValor= 'S') then
            bCantidadAuto := true
        else
            bCantidadAuto := false;

        //Recupera el enter en el c�digo
        sValor := ReadString('Compras', 'Enter', '');
        if (sValor= 'S') then
            bCodigoEnter := true
        else
            bCodigoEnter := false;
    end;

end;

procedure TfrmCompras.txtDocumentoEnter(Sender: TObject);
begin
    if(txtCodigo.Enabled) then
        txtCodigo.SetFocus;
end;

procedure TfrmCompras.AjustaVentana;
begin
    Top := 0;
    Left := 0;
    Height := Screen.Height - 32;
    Width := Screen.Width - 6;
    pnlMensaje.Left := Width div 2 - pnlMensaje.Width div 2;
    pnlMensaje.Top  := Height div 2 - pnlMensaje.Height div 2;

    //Establece los encabezados, el tama�o de las celdas y el tama�o de letra
    with grdCompra do begin
        RowCount := 2;
        Cells[0,0] := 'No.';
        Cells[1,0] := 'Art�culo';
        Cells[2,0] := 'Cantidad';
        Cells[3,0] := 'Costo';
        Cells[4,0] := 'Descuento';
        Cells[5,0] := 'Importe';

        ColWidths[0] := StrToInt(FormatFloat('0',35 * Width / 800)); //40
        ColWidths[1] := StrToInt(FormatFloat('0',405 * Width / 800)); //265
        ColWidths[2] := StrToInt(FormatFloat('0',86 * Width / 800));// 100
        ColWidths[3] := StrToInt(FormatFloat('0',80 * Width / 800));//120
        ColWidths[4] := StrToInt(FormatFloat('0',80 * Width / 800));//120
        ColWidths[5] := StrToInt(FormatFloat('0',80 * Width / 800));//120
         font.Size := 14;
        //Font.Size := StrToInt(FormatFloat('0',12 * Width / 800));
        DefaultRowHeight := StrToInt(FormatFloat('0',20 * Width / 800));
    end;
end;

procedure TfrmCompras.txtCodigoKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    if (Key = Key_Up) then begin
        if(grdCompra.Row > 1) then
            grdCompra.Row := grdCompra.Row - 1;
    end
    else if (Key = Key_Down) then begin
        if(grdCompra.Row < grdCompra.RowCount - 1) then
            grdCompra.Row := grdCompra.Row + 1;
    end
    else if(Key = Key_Enter) or (Key = Key_Return) or (bCodigoEnter) then
        BuscaArticulo;
end;

procedure TfrmCompras.BuscaArticulo;
var
    iClave, iTipo : Integer;
    sCodigo, sDescrip, sCantidad_Cnt : string;
    fCosto, rIvaArt : Real;
begin
    sCodigo := txtCodigo.Text;
    with dmDatos.qryModifica do begin
        Close;
        SQL.Clear;
          // se modifico la consulta para que muestre la descripccion larga
        SQL.Add('SELECT a.clave, o.codigo, a.desc_larga , a.tipo, a.desc_auto, a.ult_costo, a.cantidad_cnt,'); //a.desc_corta
        SQL.Add('a.categoria, a.departamento, a.iva, a.precio1, a.precio2, a.precio3, a.precio4');
        SQL.Add('FROM articulos a LEFT JOIN codigos o ON a.clave = o.articulo');
        SQL.Add('WHERE a.clave IN (SELECT articulo FROM codigos WHERE codigo = ''' + txtCodigo.Text + ''')');
        if(txtComprobante.Text = 'GASTO') then
            SQL.Add('AND a.tipo = 4')
        else
            SQL.Add('AND a.tipo <> 4');
        Open;

        if(not Eof) then begin
            iClave := FieldByName('clave').AsInteger;
            sCodigo := Trim(FieldByName('codigo').AsString);
            sDescrip := Trim(FieldByName('desc_larga').AsString); //desc_corta
            sCantidad_Cnt := FieldByName('cantidad_cnt').AsString;
            fCosto := FieldByName('ult_costo').AsFloat;
            iTipo := FieldByName('tipo').AsInteger;
            rIvaArt := FieldByName('iva').AsInteger;

            Inc(iNumero);
            grdDatos.RowCount := iNumero + 1;

            grdDatos.Cells[0,iNumero] := IntToStr(iClave);       {Clave del art�culo}
            grdDatos.Cells[1,iNumero] := sCodigo;                {C�digo}
            grdDatos.Cells[2,iNumero] := sDescrip;               {Descripci�n del art�culo}
            grdDatos.Cells[3,iNumero] := '1';                    {Cantidad de art�culos (por default 1)}
            grdDatos.Cells[4,iNumero] := FloatToStr(fCosto);     {Costo del art�culo}
            grdDatos.Cells[5,iNumero] := IntToStr(iTipo);        {Tipo del art�culo}
            grdDatos.Cells[6,iNumero] := FloatToStr(rIvaArt);    {Iva del art�culo}
            grdDatos.Cells[7,iNumero] := FloatToStr(rDescuento); {Descuento}
            grdDatos.Cells[8,iNumero] := sCantidad_Cnt;          {Articulo con controle de cantidad en el almac�n}

            // Guarda los datos del art�culo en un grid que se muestra en la pantalla
            grdCompra.RowCount := iNumero + 2;
            grdCompra.Cells[0,iNumero + 1] := IntToStr(iNumero + 1);          // Consecutivo
            grdCompra.Cells[1,iNumero + 1] := sDescrip;                       // Descripci�n corta
            grdCompra.Cells[2,iNumero + 1] := '1';                            // Cantidad
            if(sIva = 'S') then
                grdCompra.Cells[3,iNumero + 1] := FloatToStr(fCosto)          // Costo
            else
                grdCompra.Cells[3,iNumero + 1] := FloatToStr(fCosto / (1 + rIvaArt / 100) );         // Costo
            grdCompra.Cells[4,iNumero + 1] := FloatToStr(rDescuento);         // Descuento global
            grdCompra.Cells[5,iNumero + 1] := grdCompra.Cells[3,iNumero + 1]; // Importe
            grdCompra.Row := iNumero + 1;

            Total;
            if(bCantidadAuto) then
                mnuCantidadClick(txtCodigo);
            if(fCosto = 0) then
                mnuCostoClick(txtCodigo);
            txtCodigo.Clear;
        end;
    end;
end;

procedure TfrmCompras.Inicializa;
begin
    txtCodigo.Clear;
    txtDocumento.Clear;
    txtFechaDoc.Clear;
    txtProveedor.Clear;
    txtSubTotal.Value:=0;
    txtIva.Value:=0;

    LimpiaArticulos;

    rDescuento := 0;
    txtTotal.Value := 0;

    txtCodigo.Enabled := false;
    mnuCancelaActual.Enabled := false;
    mnuGuardar.Enabled := false;
    mnuCosto.Enabled := false;
    mnuComprobante.Enabled := false;
    mnuCantidad.Enabled := false;
    mnuArticulos.Enabled := false;
    mnuEliminar.Enabled := false;
    mnuDescIndividual.Enabled := false;

    btnGuardar.Enabled := false;
    btnCosto.Enabled := false;
    btnComprobante.Enabled := false;
    btnCantidad.Enabled := false;
    btnArticulos.Enabled := false;
    btnEliminar.Enabled := false;
    btnDescIndividual.Enabled := false;

    grdCompra.SetFocus;
    pnlMensaje.Visible := true;
end;

procedure TfrmCompras.Total;
var
    i: Integer;
    rPrecio: Real;
begin
    rTotal := 0;
    rIva := 0;
    for i:=0 to iNumero do begin
        rPrecio := StrToFloat(grdDatos.Cells[4,i]) *
                   StrToFloat(grdDatos.Cells[3,i]);
        rTotal := rTotal + rPrecio;
        rIva := rIva + (rPrecio - (rPrecio /(1 + StrToFloat(grdDatos.Cells[6,i]) / 100)));
    end;
    rTotal := StrToFloat(Format('%8.2f',[rTotal]));

    txtSubTotal.Value := rTotal - rIva;
    txtIva.Value := rIva;
    txtTotal.Value := rTotal;
end;

procedure TfrmCompras.grdCompraDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var
    sCad : String;
    i : real;
begin
    sCad := (Sender as TStringGrid).Cells[ACol,ARow];
    if(Length(sCad) > 0) then begin
        if(ARow = 0) or (ACol = 0) then begin
            i := Rect.Left + (Rect.Right - Rect.Left) / 2 - (Sender as TStringGrid).Canvas.TextWidth(sCad) / 2;
            (Sender as TStringGrid).Canvas.FillRect(Rect);
            (Sender as TStringGrid).Canvas.TextOut(Round(i),Rect.Top + 2,sCad);
        end;
        if(ACol > 1) and (ARow > 0) then begin
            if(ACol <> 2) then
                sCad := FormatFloat('#,##0.00',StrToFloat(sCad))
            else
                sCad := FormatFloat('#,##0.000',StrToFloat(sCad));

            i := Rect.Right - (Sender as TStringGrid).Canvas.TextWidth(sCad + ' ');
            (Sender as TStringGrid).Canvas.FillRect(Rect);
            (Sender as TStringGrid).Canvas.TextOut(Round(i),Rect.Top + 2,sCad);
        end;
    end;
end;

procedure TfrmCompras.mnuCostoClick(Sender: TObject);
begin
    if(iNumero <> - 1) then begin //Si hay cuando menos un art�culo
        with TFrmCantidad.Create(Self) do
        try
            sTitulo := 'Costo';
            rCantidad := StrToFloat(grdCompra.Cells[3,grdCompra.Row]);
            bDecimales := true;
            cajch.Visible:=false;
            cajas.Visible:=false;
            ShowModal;
            if(rCantidad > 0) then begin
                if(sIva = 'S') then
                    grdDatos.Cells[4,grdCompra.Row - 1] := FloatToStr(rCantidad)
                else
                    grdDatos.Cells[4,grdCompra.Row - 1] := FloatToStr(rCantidad * (1 + StrToFloat(grdDatos.Cells[6,grdCompra.Row - 1]) / 100));

                grdCompra.Cells[3,grdCompra.Row] := FloatToStr(rCantidad);  // Costo
                grdCompra.Cells[5,grdCompra.Row] := FloatToStr(StrToFloat(grdCompra.Cells[3,grdCompra.Row]) * StrToFloat(grdCompra.Cells[2,grdCompra.Row]));  // Importe

                Total;
            end;
            txtCodigo.SetFocus;
        finally
            Free;
        end;
    end;
end;

procedure TfrmCompras.mnuCantidadClick(Sender: TObject);
var
f: real;
begin

 with dmDatos.qryModifica do begin
        Close;
        SQL.Clear;
          // se modifico la consulta para que muestre la descripccion larga
        SQL.Add('SELECT a.clave, a.factor FROM articulos a where a.clave = ' + grdDatos.Cells[0,iNumero]); //a.desc_corta
        Open;
 if(not Eof) then
 begin
            f:= FieldByName('factor').Asfloat;
 end;
   close;
 end;




    if(iNumero <> - 1) then begin //Si hay cuando menos un art�culo
        with TFrmCantidad.Create(Self) do
        try
            fac:=f;
            sTitulo := 'Cantidad';
            rCantidad := StrToFloat(grdDatos.Cells[3,iNumero]);
            ///
  with dmDatos.qryConsulta do begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT precio1,precio2,precio3,precio4,precio5, rango1, rango2, rango3, rango4, rango5, e1,e2,e3,e4,e5, factor FROM articulos WHERE clave = ' + grdDatos.Cells[0,iNumero]);
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

 ///

            if(grdDatos.Cells[5,iNumero] = '0') then
                bDecimales := true
            else
                bDecimales := false;
            ShowModal;
            if(rCantidad > 0) then begin
                grdDatos.Cells[14,grdCompra.Row - 1] := FloatToStr(rkg);
                grdDatos.Cells[3,grdCompra.Row - 1] := FloatToStr(rCantidad);
                grdCompra.Cells[2,grdCompra.Row] := FloatToStr(rCantidad);  // Cantidad
                grdCompra.Cells[5,grdCompra.Row] := FloatToStr(StrToFloat(grdCompra.Cells[3,grdCompra.Row]) * StrToFloat(grdCompra.Cells[2,grdCompra.Row]));  // Importe

                Total;
            end;
            txtCodigo.SetFocus;
        finally
            Free;
        end;
    end;
end;

procedure TfrmCompras.mnuEliminarClick(Sender: TObject);
var
    i : integer;
begin
    if(iNumero <> - 1) then begin //Si hay cuando menos un art�culo
        if(Application.MessageBox('�Desea eliminar el art�culo seleccionado?','Eliminar',
                                      [smbOK,smbCancel], smsWarning) = smbOK) then begin
            for i := grdCompra.Row to grdCompra.RowCount - 2 do begin
                grdCompra.Cells[0,i+1] := IntToStr(StrToInt(grdCompra.Cells[0,i+1]) - 1);
                grdCompra.Rows[i] := grdCompra.Rows[i+1];
                grdDatos.Rows[i-1] := grdDatos.Rows[i];
            end;
            if(grdCompra.RowCount > 2) then begin
                grdCompra.RowCount := grdCompra.RowCount - 1;
                grdDatos.RowCount := grdCompra.RowCount - 1;
            end
            else begin
                grdCompra.Cells[0,1] := '';
                grdCompra.Cells[1,1] := '';
                grdCompra.Cells[2,1] := '';
                grdCompra.Cells[3,1] := '';
                grdCompra.Cells[4,1] := '';
                grdCompra.Cells[5,1] := '';
            end;
            iNumero := iNumero - 1;
            Total;
        end;
    end;
    txtCodigo.SetFocus;
end;

procedure TfrmCompras.mnuArticulosClick(Sender: TObject);
begin
    with TFrmArticuloBusq.Create(Self) do
    try
        if(txtComprobante.Text = 'GASTO') then
            bGasto := true
        else
            bGasto := false;
        ShowModal;
        if(bSelec) then begin
            txtCodigo.Text := sCodigo;
            BuscaArticulo;
        end;
        txtCodigo.SetFocus;
    finally
        Free;
    end;
end;

procedure TfrmCompras.grdCompraMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
    grcRenglon : TGridCoord;
begin
    if(Button = mbRight) then begin
        grcRenglon := grdCompra.MouseCoord(X, Y);
        if(grcRenglon.y >= 1) then
            grdCompra.Row := grcRenglon.y;
    end;
end;

procedure TfrmCompras.mnuGuardarClick(Sender: TObject);
var
    bAutoriza : boolean;
begin

    if(iNumero > -1) then begin
        if(txtComprobante.Text <> 'AJUSTE') then begin
            frmPago.rTotal := txtTotal.Value;
            frmPago.sTipoOper := 'C';
            frmPago.dteFecha := StrToDate(txtFechaDoc.Text);
            frmPago.ShowModal;
            bAutoriza := frmPago.bAceptar;
        end
        else
            if(Application.MessageBox('Se guardar� el ajuste','Ajuste',[smbOk]+[smbCancel]) = smbOk) then
                bAutoriza := true
            else
                bAutoriza := false;
        if(bAutoriza) then begin
            GuardaDatos;
            Inicializa;
            txtComprobante.Text := sComprobanteDef;
        end;
        if(txtCodigo.Enabled) then
            txtCodigo.SetFocus
        else
            SetFocus;
    end;
end;

procedure TfrmCompras.GuardaDatos;
var
    sClave, sCantidad, sCantidad_Cnt, sFecha, sInteres : String;
     iClaveArt, i, k, iConsec, iPagos, iPlazo : Integer;
    dteFechaPago : TDateTime;
    iCantidad,rImporte, rSumaImporte : real;
begin
    sFecha := Copy(txtFechaDoc.Text,4,3) + Copy(txtFechaDoc.Text,1,2) + Copy(txtFechaDoc.Text,6,5);
    with dmDatos.qryModifica do begin
        // Regresa al inventario en caso de que ya hab�a algo
        Close;
        SQL.Clear;
        SQL.Add('SELECT c.articulo, c.cantidad, a.cantidad_cnt FROM comprasdet c');
        SQL.Add('LEFT JOIN articulos a ON c.articulo = a.clave');
        SQL.Add('WHERE c.compra = ' + IntToStr(iClaveCompra));
        Open;

        while not Eof do begin
            iClaveArt := FieldByName('articulo').AsInteger;
            iCantidad := FieldByName('cantidad').AsFloat;
            sCantidad_Cnt := FieldByName('cantidad_cnt').AsString;

            // articulo con controle de cantidad en el almac�n
            if(sCantidad_Cnt = 'S') then begin
                dmDatos.qryAuxiliar1.Close;
                dmDatos.qryAuxiliar1.SQL.Clear;
                dmDatos.qryAuxiliar1.SQL.Add('UPDATE articulos SET');
                dmDatos.qryAuxiliar1.SQL.Add('existencia = existencia - ' + floatToStr(iCantidad));
                dmDatos.qryAuxiliar1.SQL.Add('WHERE clave = ' + IntToStr(iClaveArt));
                dmDatos.qryAuxiliar1.ExecSQL;
                dmDatos.qryAuxiliar1.Close;
            end;

            Next;
        end;

        Close;
        SQL.Clear;
        SQL.Add('DELETE FROM compras WHERE clave = ' + IntToStr(iClaveCompra));
        ExecSQL;

        Close;
        SQL.Clear;
        SQL.Add('INSERT INTO compras (proveedor, documento, fecha, usuario, estatus, total, caja, iva, descuento, tipo, fecha_cap) VALUES(');
        SQL.Add(IntToStr(iProveedor) + ',''' + txtDocumento.Text + ''',''' + sFecha + ''',');
        SQL.Add(IntToStr(iUsuario) + ',''A'',' + FloatToStr(txtTotal.value) + ',');
        SQL.Add(IntToStr(iCaja) + ',' + FloatToStr(rIva) + ', 0, ''' + Copy(txtComprobante.Text,1,1) + ''',''' + FormatDateTime('mm/dd/yyyy',Date) + ''')');
        ExecSQL;

        Close;
        SQL.Clear;
        SQL.Add('SELECT clave FROM compras WHERE documento = ''' + txtDocumento.Text + '''');
        SQL.Add('AND estatus = ''A'' AND proveedor = ' + IntToStr(iProveedor));
        Open;

        iConsec := FieldByName('clave').AsInteger;

        Close;
        SQL.Clear;
        SQL.Add('UPDATE proveedores SET ultcompra = ' + IntToStr(iConsec));
        SQL.Add('WHERE clave = ' + IntToStr(iProveedor));
        ExecSQL;

        if(txtComprobante.Text <> 'AJUSTE') then
            //Inserta el (los) tipo(s) de pago(s)
            for i := 0 to frmPago.grdPagos.RowCount - 1 do begin
                Close;
                SQL.Clear;
                SQL.Add('INSERT INTO compraspago (compra, tipopago, importe, referencia) VALUES(');
                SQL.Add(IntToStr(iConsec) + ',''' + frmPago.grdPagos.Cells[0,i] + ''',');
                SQL.Add(frmPago.grdPagos.Cells[1,i] + ',''' + frmPago.grdPagos.Cells[2,i] + ''')');
                ExecSQL;
                Close;

                if(frmPago.grdPagos.Cells[4,i] = 'CREDITO') then begin
                    iPagos := StrToInt(frmPago.grdPagos.Cells[5,i]);
                    iPlazo := StrToInt(frmPago.grdPagos.Cells[6,i]);
                    dteFechaPago := StrToDate(frmPago.grdPagos.Cells[7,i]);
                    rImporte := StrToFloat(frmPago.grdPagos.Cells[12,i]);
                    rSumaImporte := 0;
                    for k := 1 to iPagos do begin
                        rSumaImporte := rSumaImporte + rImporte;

                        // Si es el ultimo pago y la suma es diferente que la deuda, ajusta el ultimo pago
                        if(k = iPagos) and (rSumaImporte <> StrToFloat(frmPago.grdPagos.Cells[13,i])) then
                            rImporte := rImporte + StrToFloat(frmPago.grdPagos.Cells[1,i]) - rSumaImporte;
                        if(iPagos > 1) then
                            sInteres := '0'
                        else
                            sInteres := frmPago.grdPagos.Cells[8,i];
                        // Inserta los datos del cr�dito
                        Close;
                        SQL.Clear;
                        SQL.Add('INSERT INTO xpagar (compra, proveedor, importe, numpago, plazo, interes,');
                        SQL.Add('intmoratorio, proximopago, tipointeres, tipoplazo, pagado, estatus, fecha,');
                        SQL.Add('cantinteres, cantintmorat) VALUES(');
                        SQL.Add(IntToStr(iConsec) + ',' + IntToStr(iProveedor) + ',' + FloatToStr(rImporte) + ',''' + IntToStr(k) + '/' + IntToStr(iPagos) + ''',');
                        SQL.Add(frmPago.grdPagos.Cells[6,i] + ',' + sInteres + ',' + frmPago.grdPagos.Cells[9,i] + ',');
                        SQL.Add('''' + FormatDateTime('mm/dd/yyyy',dteFechaPago) + ''',''' + frmPago.grdPagos.Cells[10,i] + ''',');
                        SQL.Add(frmPago.grdPagos.Cells[11,i] + ',0,''A'',''' + sFecha + ''',0,0)');
                        ExecSQL;
                        Close;
                        dteFechaPago := dteFechaPago + iPlazo;
                    end;
                end;
            end;

        for i:= 0 to grdDatos.RowCount - 1 do begin
            Close;
            SQL.Clear;
            SQL.Add('INSERT INTO comprasdet (compra,orden,articulo,cantidad,');
            SQL.Add('descuento,costo,iva,cantidad_cnt) VALUES(');
            SQL.Add(IntToStr(iConsec) + ',' + IntToStr(i) + ',');
            SQL.Add(grdDatos.Cells[0,i] + ',');
            SQL.Add(grdDatos.Cells[3,i] + ',0,');
            SQL.Add(grdDatos.Cells[4,i] + ',');
            SQL.Add(grdDatos.Cells[6,i] + ',''' + grdDatos.Cells[8,i] + ''')');
            ExecSQL;

            Close;
            SQL.Clear;
            SQL.Add('UPDATE articulos SET ult_costo = ' + grdDatos.Cells[4,i] + ',');
            SQL.Add('ultcompra = ' + IntToStr(iConsec));

            //Si es diferente de juego y diferente de no inventariable
            if(grdDatos.Cells[5,i] <> '1') and (grdDatos.Cells[5,i] <> '2') then
                // Si articulo controla cantidad en el almac�n
                if(grdDatos.Cells[8,i] = 'S') then
                    SQL.Add(', existencia = existencia + ' + grdDatos.Cells[3,i]);  //arreglo

            SQL.Add(' WHERE clave = ' + grdDatos.Cells[0,i]);
            ExecSQL;
            Close;

            if(grdDatos.Cells[5,i] = '1') then begin  //Si es juego
                Close;
                SQL.Clear;
                SQL.Add('SELECT j.articulo, j.cantidad, a.cantidad_cnt FROM juegos j');
                SQL.Add('LEFT JOIN articulos a ON j.articulo = a.clave WHERE j.clave = ' + grdDatos.Cells[0,i]);
                Open;

                while(not Eof) do begin
                    sClave := FieldByName('articulo').AsString;
                    sCantidad := FloatToStr(FieldByName('cantidad').AsFloat);
                    sCantidad_Cnt := FieldByName('cantidad_cnt').AsString;

                    // si articulo controla cantidad en el almac�n
                    if(sCantidad_Cnt = 'S') then begin
                        dmDatos.qryAuxiliar1.Close;
                        dmDatos.qryAuxiliar1.SQL.Clear;
                        dmDatos.qryAuxiliar1.SQL.Add('UPDATE articulos SET');
                        dmDatos.qryAuxiliar1.SQL.Add('existencia = existencia + ' + grdDatos.Cells[3,i] + ' * ' + sCantidad);
                        dmDatos.qryAuxiliar1.SQL.Add('WHERE clave = ' + sClave);
                        dmDatos.qryAuxiliar1.ExecSQL;
                        dmDatos.qryAuxiliar1.Close;
                    end;

                    Next;
                end;
                Close;
            end;
        end;
        Close;
    end;
end;

procedure TfrmCompras.mnuCancelaAnteriorClick(Sender: TObject);
var
    bAceptar : boolean;
    sDoc, sProveedor, sClaveArt, sCantidad, sCant, sCantidad_Cnt, sClave, sCompra : String;
begin
    bAceptar := false;
    with TFrmCompraDoc.Create(Self) do
    try
        sTitulo := 'Cancelar compra';
        bCaptura := false; // Propiedad que permite ocultar la casilla de verificaci�n "IVA incluido en costo"

        if(ShowModal = mrOk) then begin
            if(Application.MessageBox('Se cancelar� el documento ' + sDoc ,'Cancelar',
                                      [smbOK,smbCancel], smsWarning) = smbOK) then begin
                sProveedor := sClave;
                sDoc := sDocumento;
                bAceptar := true;
            end;
        end;
    finally
        Free;
    end;

    if(bAceptar) then begin
        with dmDatos.qryModifica do begin
            Close;
            SQL.Clear;
            SQL.Add('SELECT c.compra, c.articulo, c.cantidad, a.tipo, c.cantidad_cnt');
            SQL.Add('FROM comprasdet c LEFT JOIN articulos a ON c.articulo = a.clave');
            SQL.Add('WHERE compra IN (SELECT clave FROM compras WHERE documento = '''+ sDoc + ''' AND');
            SQL.Add('proveedor = ' + sProveedor + ' AND estatus =''A'')');
            Open;

            if(not Eof) then begin
                sCompra := FieldByName('compra').AsString;
                while(not Eof) do begin
                    sClaveArt := FieldByName('articulo').AsString;
                    sCantidad := FieldByName('cantidad').AsString;
                    sCantidad_Cnt := FieldByName('cantidad_cnt').AsString;

                    if(FieldByName('tipo').AsInteger <> 1) then begin  //Si no es juego
                        // si articulo controla cantidad en el almac�n
                        if(sCantidad_Cnt = 'S') then begin
                            dmDatos.qryAuxiliar1.Close;
                            dmDatos.qryAuxiliar1.SQL.Clear;
                            dmDatos.qryAuxiliar1.SQL.Add('UPDATE articulos SET');
                            dmDatos.qryAuxiliar1.SQL.Add('existencia = existencia - ' + sCantidad);
                            dmDatos.qryAuxiliar1.SQL.Add('WHERE clave = ' + sClaveArt);
                            dmDatos.qryAuxiliar1.ExecSQL;
                            dmDatos.qryAuxiliar1.Close;
                        end;
                    end
                    else begin
                        dmDatos.qryAuxiliar1.Close;
                        dmDatos.qryAuxiliar1.SQL.Clear;
                        dmDatos.qryAuxiliar1.SQL.Add('SELECT j.articulo, j.cantidad, a.cantidad_cnt');
                        dmDatos.qryAuxiliar1.SQL.Add('FROM juegos j LEFT JOIN articulos a ON j.articulo = a.clave');
                        dmDatos.qryAuxiliar1.SQL.Add('WHERE j.clave = ' + sClaveArt);
                        dmDatos.qryAuxiliar1.Open;

                        while(not dmDatos.qryAuxiliar1.Eof) do begin
                            sClave := FieldByName('articulo').AsString;
                            sCant := FloatToStr(FieldByName('cantidad').AsFloat);
                            sCantidad_Cnt := FieldByName('cantidad_cnt').AsString;

                            // si articulo controla cantidad en el almac�n
                            if(sCantidad_Cnt = 'S') then begin
                                dmDatos.qryAuxiliar2.Close;
                                dmDatos.qryAuxiliar2.SQL.Clear;
                                dmDatos.qryAuxiliar2.SQL.Add('UPDATE articulos SET');
                                dmDatos.qryAuxiliar2.SQL.Add('existencia = existencia - ' + sCant + ' * ' + sCantidad);
                                dmDatos.qryAuxiliar2.SQL.Add('WHERE clave = ' + sClave);
                                dmDatos.qryAuxiliar2.ExecSQL;
                                dmDatos.qryAuxiliar2.Close;
                            end;

                            dmDatos.qryAuxiliar1.Next;
                        end;
                        dmDatos.qryAuxiliar1.Close;
                    end;
                    Next;
                end;

                Close;
                SQL.Clear;
                SQL.Add('UPDATE compras SET estatus = ''C'' WHERE documento = '''+ sDoc + '''');
                SQL.Add('AND proveedor = ' + sProveedor);
                ExecSQL;
                Close;

                Close;
                SQL.Clear;
                SQL.Add('UPDATE xpagar SET estatus = ''C'' WHERE compra = ' + sCompra);
                ExecSQL;

                Application.MessageBox('El documento '+ sDoc +' ha sido cancelado','Cancelar',[smbOk],smsInformation);
            end
            else begin
                Application.MessageBox('El documento ' + sDoc + ' no existe','Error',[smbOk],smsInformation);
                txtDocumento.SetFocus;
            end;
        end;
    end;
    if(txtCodigo.Enabled) then
        txtCodigo.SetFocus
    else
        grdCompra.SetFocus
end;

procedure TfrmCompras.mnuCancelaActualClick(Sender: TObject);
begin
    if(Application.MessageBox('Se cancelar� la compra actual','Cancelar',[smbOK,smbCancel],smsWarning) = smbOK) then begin
        Inicializa;
        txtComprobante.Text := sComprobanteDef;
    end;
end;

procedure TfrmCompras.MuestraAyuda(sUrl : string);
var
    szAbrir, szUrl : array[0..100] of char;
begin
    {$IFDEF LINUX}
        Libc.system(PChar('konqueror "' + sUrl + '"&'));
    {$ENDIF}
    {$IFDEF MSWINDOWS}
        StrPCopy(szAbrir, 'open');
        StrPCopy(szAbrir, sUrl);
        ShellExecute(0,szAbrir,szUrl,nil,nil,SW_SHOWNORMAL);
    {$ENDIF}
end;

procedure TfrmCompras.mnuAyudaClick(Sender: TObject);
var
    sUrl, sDirSep : string;
begin
    sUrl := ExtractFilePath(Application.Exename);
    {$IFDEF MSWINDOWS}
        sDirSep:='\';
    {$ENDIF}
    {$IFDEF LINUX}
        sDirSep:='/';
    {$ENDIF}
    sUrl := sUrl + 'ayuda' + sDirSep + 'compras.html';
    if FileExists(sUrl) then
        MuestraAyuda(sUrl)
    else
        MuestraAyuda('http://ventas.sourceforge.net');
end;

procedure TfrmCompras.mnuBarraClick(Sender: TObject);
begin
    pnlBotones.Visible := not pnlBotones.Visible;
    mnuBarra.Checked := not mnuBarra.Checked;
end;

procedure TfrmCompras.btnDescIndividualClick(Sender: TObject);
var
    i : integer;
    eValor : extended;
begin
    if(iNumero <> - 1) then begin //Si hay cuando menos un art�culo
        with TFrmCantidad.Create(Self) do
        try
            if(TryStrToFloat(grdDatos.Cells[7,iNumero],eValor)) then begin
                rCantidad := StrToFloat(grdDatos.Cells[7,iNumero]);
                rDescuento := StrToFloat(grdDatos.Cells[7,iNumero])
            end
            else begin
                rCantidad := 0;
                rDescuento := 0;
            end;
            sTitulo := 'Descuento (Porcentaje)';
            bDecimales := True;
            cajch.Visible:=false;
            cajas.Visible:=false;
            ShowModal;
            if(rCantidad >= 0) then begin
                if (Copy((Sender as TComponent).Name,4,Length((Sender as TComponent).Name)) = 'DescIndividual') then begin
                    grdDatos.Cells[7,grdCompra.Row - 1] := FloatToStr(rCantidad);
                    grdCompra.Cells[4,grdCompra.Row] := FloatToStr(rCantidad);  // descuento
                    grdCompra.Cells[5,grdCompra.Row] := FloatToStr(StrToFloat(grdCompra.Cells[3,grdCompra.Row]) *
                                                          (1 - StrToFloat(grdCompra.Cells[4,grdCompra.Row]) / 100));    // Precio neto
                end
                else begin
                  for i := 1 to iNumero+1 do begin
                      grdDatos.Cells[7, i - 1] := FloatToStr(rCantidad);
                      grdCompra.Cells[4,i] := FloatToStr(rCantidad);  // descuento
                      grdCompra.Cells[5,i] := FloatToStr(StrToFloat(grdCompra.Cells[3,i]) *
                                              (1 - StrToFloat(grdCompra.Cells[4,i]) / 100));    // Precio neto
                  end;
                end;
                Total;
            end;
            txtCodigo.SetFocus;
        finally
            Free;
        end;
    end;
end;

procedure TfrmCompras.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
    if(iNumero <> -1) then
        if(Application.MessageBox('No se ha guardado la compra, �deseas salir sin guardar?','Salir',[smbOK,smbCancel],smsWarning) = smbCancel) then
            CanClose := false;                        
end;

procedure TfrmCompras.grdCompraSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
    txtCodigo.SetFocus;
end;

procedure TfrmCompras.btnComprobanteClick(Sender: TObject);
var
    i : integer;
begin
    with TfrmTipoComprobante.Create(Self) do
    try
        sTipo := 'COMPRA';
        sComprobante := txtComprobante.Text;
        iUsuario := Self.iUsuario;
        ShowModal;
        if(ModalResult = mrOK) then begin
            if(sComprobante = 'GASTO') and (txtComprobante.Text <> 'GASTO') then begin
                for i := 0 to grdDatos.RowCount - 1 do
                    if(grdDatos.Cells[5,i] <> '4') and (grdDatos.Cells[5,i] <> '') then begin
                        if(Application.MessageBox('�Desea eliminar todos los art�culos que no sean gastos?','Gastos',[smbOk]+[smbCancel]) = smbOk) then begin
                            txtComprobante.Text := sComprobante;
                            LimpiaArticulos;
                            break;
                        end;
                    end
                    else
                        txtComprobante.Text := sComprobante;
            end
            else
                for i := 0 to grdDatos.RowCount - 1 do
                    if(grdDatos.Cells[5,i] = '4') and (grdDatos.Cells[5,i] <> '') then begin
                        if(Application.MessageBox('�Desea eliminar todos los art�culos que sean gastos?','Gastos',[smbOk]+[smbCancel]) = smbOk) then begin
                            txtComprobante.Text := sComprobante;
                            LimpiaArticulos;
                            break;
                        end;
                    end
                    else
                        txtComprobante.Text := sComprobante;
        end;
    finally
        Free;
    end;
    if(txtCodigo.Enabled) then
        txtCodigo.SetFocus
    else
        grdCompra.SetFocus;
end;

procedure TfrmCompras.LimpiaArticulos;
begin
    grdCompra.RowCount := 2;
    grdCompra.Cells[0,1] := '';
    grdCompra.Cells[1,1] := '';
    grdCompra.Cells[2,1] := '';
    grdCompra.Cells[3,1] := '';
    grdCompra.Cells[4,1] := '';
    grdCompra.Cells[5,1] := '';

    grdDatos.RowCount := 1;
    grdDatos.Cells[0,0] := '';    {Clave del art�culo}
    grdDatos.Cells[1,0] := '';    {C�digo}
    grdDatos.Cells[2,0] := '';    {Descripci�n del art�culo}
    grdDatos.Cells[3,0] := '';    {Cantidad de art�culos (por default 1)}
    grdDatos.Cells[4,0] := '';    {Costo del art�culo}
    grdDatos.Cells[5,0] := '';    {Tipo del art�culo}
    grdDatos.Cells[6,0] := '';    {Iva del art�culo}
    grdDatos.Cells[7,0] := '';    {Descuento}
    grdDatos.Cells[8,0] := '';    {Articulos con o sin controle de cantidad en el almac�n}

    iNumero := -1;
end;

procedure TfrmCompras.mnuDocumentoClick(Sender: TObject);
var
    bAceptar : boolean;
begin
    bAceptar := false;
    with TFrmCompraDoc.Create(Self) do
    try
        sTitulo := 'Documento';
        bCaptura := true; // Propiedad que permite mostar la casilla de verificaci�n "IVA incluido en costo"

        if(ShowModal = mrOk) then begin
            Inicializa;
            Self.txtDocumento.Text := sDocumento;
            txtProveedor.Text := sNombreProv;
            iProveedor := StrToInt(sClave);
            txtFechaDoc.Text := sFecha;
            Self.sIva := sIva;
            bAceptar := true;
        end;
    finally
        Free;
    end;
    if(bAceptar) then begin
        if(sIva = 'S') then
            pnlIva.Caption := 'COSTOS CON I.V.A.'
        else
            pnlIva.Caption := 'COSTOS SIN I.V.A.';
        txtCodigo.Enabled := true;
        mnuCancelaActual.Enabled := true;
        mnuGuardar.Enabled := true;
        mnuCosto.Enabled := true;
        mnuComprobante.Enabled := true;
        mnuCantidad.Enabled := true;
        mnuArticulos.Enabled := true;
        mnuEliminar.Enabled := true;
        mnuDescIndividual.Enabled := true;

        btnCancelaAnterior.Enabled := true;
        btnGuardar.Enabled := true;
        btnCosto.Enabled := true;
        btnComprobante.Enabled := true;
        btnCantidad.Enabled := true;
        btnArticulos.Enabled := true;
        btnEliminar.Enabled := true;
        btnDescIndividual.Enabled := true;
        pnlMensaje.Visible := false;

        txtCodigo.SetFocus;

        with dmDatos.qryModifica do begin
            Close;
            SQL.Clear;
            SQL.Add('SELECT clave FROM compras WHERE proveedor = ' + IntToStr(iProveedor));
            SQL.Add('AND documento = ''' + txtDocumento.Text + '''  AND estatus = ''A''');
            Open;

            if(not Eof) then begin
                iClaveCompra := FieldByName('clave').AsInteger;
                Close;
                SQL.Clear;
                SQL.Add('SELECT a.clave, o.codigo, a.desc_corta, a.desc_larga, c.cantidad, c.cantidad_cnt,');
                SQL.Add('c.costo, a.tipo, c.iva FROM comprasdet c LEFT JOIN articulos a');
                SQL.Add('ON c.articulo = a.clave LEFT JOIN codigos o ON a.clave = o.articulo AND o.tipo=''P''');
                SQL.Add('WHERE c.compra = ' + IntToStr(iClaveCompra) + ' ORDER BY orden');
                Open;

                iNumero := -1;
                while(not Eof) do begin
                    Inc(iNumero);
                    grdDatos.RowCount := iNumero + 1;

                    grdDatos.Cells[0,iNumero] := FieldByName('clave').AsString;   {Clave del art�culo}
                    grdDatos.Cells[1,iNumero] := Trim(FieldByName('codigo').AsString);            {C�digo}
                    grdDatos.Cells[2,iNumero] := Trim(FieldByName('desc_larga').AsString); //modificacion jul/2009           {Descripci�n del art�culo}
                    grdDatos.Cells[3,iNumero] := FieldByName('cantidad').AsString;                {Cantidad de art�culos}
                    grdDatos.Cells[4,iNumero] := FieldByName('costo').AsString; {Costo del art�culo}
                    grdDatos.Cells[5,iNumero] := FieldByName('tipo').AsString; {Tipo del art�culo}
                    grdDatos.Cells[6,iNumero] := FieldByName('iva').AsString; {Iva del art�culo}
                    grdDatos.Cells[8,iNumero] := FieldByName('cantidad_cnt').AsString;  {Articulo con controle de cantidad en el almac�n}

                    // Guarda los datos del art�culo en un grid que se muestra en la pantalla
                    grdCompra.RowCount := iNumero + 2;
                    grdCompra.Cells[0,iNumero + 1] := IntToStr(iNumero + 1);          // Consecutivo
                    grdCompra.Cells[1,iNumero + 1] := grdDatos.Cells[2,iNumero];      // Descripci�n corta
                    grdCompra.Cells[2,iNumero + 1] := grdDatos.Cells[3,iNumero];      // Cantidad
                    if(sIva = 'S') then
                        grdCompra.Cells[3,iNumero + 1] := grdDatos.Cells[4,iNumero]      // Costo
                    else
                        grdCompra.Cells[3,iNumero + 1] := FloatToStr(StrToFloat(grdDatos.Cells[4,iNumero]) / (1 + StrToFloat(grdDatos.Cells[6,iNumero]) / 100));      // Costo
                    grdCompra.Cells[4,iNumero + 1] := FloatToStr(rDescuento);         // Descuento
                    grdCompra.Cells[5,iNumero + 1] := FloatToStr(StrToFloat(grdCompra.Cells[3,iNumero + 1]) *
                                                      StrToFloat(grdDatos.Cells[3,iNumero]));  // Importe
                    grdCompra.Row := iNumero + 1;

                    Next;
                end;
                Total;
                Close;
            end;
        end;
    end;
    if(txtCodigo.Enabled) then
        txtCodigo.SetFocus
    else
        grdCompra.SetFocus;
end;

procedure TfrmCompras.mnuCalculadoraClick(Sender: TObject);
begin
    with TFrmCalculadora.Create(Self) do
    try
        ShowModal;
        Self.SetFocus;
    finally
        Free;
    end;
end;

procedure TfrmCompras.mnuEliminarDescuentosClick(Sender: TObject);
var
    i : integer;
begin
    if (iNumero <> -1) then
        if(Application.MessageBox('Se eliminar�n todos los descuentos','Eliminar descuentos',[smbOk]+[smbCancel],smsWarning) = smbOk) then begin
            for i := 0 to grdDatos.RowCount - 1 do begin
                grdDatos.Cells[7,i] := '0';                               // Descuento otorgado
                grdCompra.Cells[4,i + 1] := '0';                          // Descuento
                grdCompra.Cells[3,i + 1] := grdDatos.Cells[4,i];          // Costo
                grdCompra.Cells[5,i + 1] := FloatToStr(StrToFloat(grdCompra.Cells[3,i + 1]) *
                                                          (StrToFloat(grdCompra.Cells[2,i + 1])));    // Precio neto
            end;
            Total;
        end;

end;

end.
