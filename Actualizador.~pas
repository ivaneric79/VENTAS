// --------------------------------------------------------------------------
// Archivo del Proyecto Ventas 
// Página del proyecto: http://sourceforge.net/projects/ventas
// --------------------------------------------------------------------------
// Este archivo puede ser distribuido y/o modificado bajo lo terminos de la
// Licencia Pública General versión 2 como es publicada por la Free Software
// Fundation, Inc.
// --------------------------------------------------------------------------

unit Actualizador;

interface

uses
  SysUtils, Types, Classes, QGraphics, QControls, QForms, QDialogs,
  QStdCtrls, QExtCtrls, QcurrEdit, QButtons, QGrids, QDBGrids,IniFiles,
  QMenus, QTypes;

type
  TfrmActualizador = class(TForm)
    rdgBuscar: TRadioGroup;
    rdgOrden: TRadioGroup;
    btnBuscar: TBitBtn;
    btnGuardar: TBitBtn;
    btnLimpiar: TBitBtn;
    Label26: TLabel;
    txtRegistros: TcurrEdit;
    pnlCodigo: TPanel;
    Label27: TLabel;
    txtCodigoBusq: TEdit;
    pnlDepto: TPanel;
    Label30: TLabel;
    cmbDeptosBusq: TComboBox;
    pnlDescCorta: TPanel;
    Label29: TLabel;
    txtDescCortaBusq: TEdit;
    pnlCateg: TPanel;
    Label28: TLabel;
    cmbCategBusq: TComboBox;
    btnCerrar: TBitBtn;
    MainMenu1: TMainMenu;
    Archivo1: TMenuItem;
    Salir1: TMenuItem;
    grpMovMas: TGroupBox;
    txtPorcentaje: TcurrEdit;
    txtcantidad: TcurrEdit;
    chkPrecio1: TCheckBox;
    chkPrecio2: TCheckBox;
    chkPrecio3: TCheckBox;
    chkExistencia: TCheckBox;
    chkPrecio4: TCheckBox;
    btnAplicar: TBitBtn;
    grdListado: TStringGrid;
    Guardar1: TMenuItem;
    Limpiar1: TMenuItem;
    Bsqueda1: TMenuItem;
    Buscar1: TMenuItem;
    rdbCantidad: TRadioButton;
    rdbPorcentaje: TRadioButton;
    chkCosto: TCheckBox;
    pnlReferencia: TPanel;
    rdbPrecio1: TRadioButton;
    rdbPrecio2: TRadioButton;
    rdbPrecio3: TRadioButton;
    rdbPrecio4: TRadioButton;
    rdbExistencia: TRadioButton;
    rdbCosto: TRadioButton;
    chkReferencia: TCheckBox;
    chkRedondear: TCheckBox;
    pnlProveedor: TPanel;
    Label37: TLabel;
    txtProvClave: TcurrEdit;
    txtProvDesc: TEdit;
    procedure btnBuscarClick(Sender: TObject);
    procedure rdgBuscarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnLimpiarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure grdListadoEnter(Sender: TObject);
    procedure grdListadoExit(Sender: TObject);
    procedure Salir1Click(Sender: TObject);
    procedure btnAplicarClick(Sender: TObject);
    procedure btnGuardarClick(Sender: TObject);
    procedure grdListadoDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure grdListadoClick(Sender: TObject);
    procedure chkReferenciaClick(Sender: TObject);
    procedure Salta(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure rdbCantidadClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure txtProvClaveChange(Sender: TObject);
    procedure rdgOrdenClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure grdListadoKeyPress(Sender: TObject; var Key: Char);
  private
    function  ClaveCarga(sBusqueda:String ; sConsulta:String):Integer;
    function  redondea(rTotal:Real):Real;
    procedure RecuperaDatos;
    procedure RecuperaConfig;
    procedure BuscaProveedor(Sender: TObject);
  public
    bSelec, bCambios  :Boolean;
    sCodigo :String;
  end;

var
  frmActualizador: TfrmActualizador;

implementation

uses dm;

{$R *.xfm}

procedure TfrmActualizador.btnBuscarClick(Sender: TObject);
var
    i : Integer;
begin
    btnBuscar.SetFocus;
    with dmDatos.qryListados1 do begin
        dmDatos.cdsCliente1.Active := false;
        Close;
        SQL.Clear;
        SQL.Add('SELECT a.clave, a.tipo, o.codigo, a.desc_corta, a.desc_larga,');
        SQL.Add('a.precio1, a.precio2, a.precio3, a.precio4, a.existencia, ');
        SQL.Add('a.ult_costo, c.nombre AS categorias, d.nombre AS departamentos ');
        SQL.Add('FROM articulos a LEFT JOIN categorias c ON a.categoria = c.clave ');
        SQL.Add('LEFT JOIN departamentos d ON a.departamento = d.clave ');
        SQL.Add('LEFT JOIN codigos o ON a.clave = o.articulo AND o.tipo = ''P'' WHERE a.tipo <> 4');

        case rdgBuscar.ItemIndex of
            0:  SQL.Add('AND a.clave IN (SELECT articulo FROM codigos WHERE codigo STARTING ''' + txtCodigoBusq.Text + ''')');
            1:  SQL.Add('AND a.desc_larga LIKE ''%' + txtDescCortaBusq.Text + '%''');
            2:  if(cmbCategBusq.ItemIndex > -1) then
                    SQL.Add('AND a.categoria = ' + IntToStr(ClaveCarga(cmbCategBusq.Items.Strings[cmbCategBusq.ItemIndex],'C')));
            3:  if(cmbDeptosBusq.ItemIndex > -1) then
                    SQL.Add('AND a.departamento = ' + IntToStr(ClaveCarga(cmbDeptosBusq.Items.Strings[cmbDeptosBusq.ItemIndex],'D')));
            4:  if(txtProvClave.Value > 0) then
                    SQL.Add('AND (a.proveedor1 = ' + FloatToStr(txtProvClave.Value) + ' OR a.proveedor2 = ' + FloatToStr(txtProvClave.Value) + ')');        end;

        case rdgOrden.ItemIndex of
            0: SQL.Add('ORDER BY o.codigo');
            1: SQL.Add('ORDER BY a.desc_larga');
            2: SQL.Add('ORDER BY c.nombre, o.codigo');
            3: SQL.Add('ORDER BY d.nombre, o.codigo');
            4: SQL.Add('ORDER BY proveedor1, proveedor2, o.codigo');
        end;

        Open;
        dmDatos.cdsCliente1.Active := true;

        if(not dmDatos.cdsCliente1.Eof) then begin
            i := 1;
            while (not dmDatos.cdsCliente1.Eof) do begin
                grdListado.RowCount := i + 1;
                grdListado.Cells[0,i] := dmDatos.cdsCliente1.FieldByName('codigo').AsString;
                grdListado.Cells[1,i] := dmDatos.cdsCliente1.FieldByName('desc_larga').AsString;  /// Modificacion para mostra descripccion larga
                grdListado.Cells[2,i] := FloatToStr(dmDatos.cdsCliente1.FieldByName('precio1').AsFloat);
                grdListado.Cells[3,i] := FloatToStr(dmDatos.cdsCliente1.FieldByName('precio2').AsFloat);
                grdListado.Cells[4,i] := FloatToStr(dmDatos.cdsCliente1.FieldByName('precio3').AsFloat);
                grdListado.Cells[5,i] := FloatToStr(dmDatos.cdsCliente1.FieldByName('precio4').AsFloat);
                grdListado.Cells[6,i] := FloatToStr(dmDatos.cdsCliente1.FieldByName('existencia').AsFloat);
                grdListado.Cells[7,i] := FloatToStr(dmDatos.cdsCliente1.FieldByName('ult_Costo').AsFloat);
                Inc(i);
                dmDatos.cdsCliente1.Next;
            end;
        end;
        txtRegistros.Value := dmDatos.cdsCliente1.RecordCount;

        Close;
        grdListado.SetFocus;
    end;
end;

function TfrmActualizador.ClaveCarga(sBusqueda:String;sConsulta:String):Integer;
begin
    with dmDatos.qryModifica do begin
        Close;
        SQL.Clear;

        if (sConsulta='C') then Begin
            SQL.Add('SELECT clave FROM categorias WHERE nombre = ''' + sBusqueda + '''');
            SQL.Add('AND tipo = ''A''');
            Open;
        end
        else if  (sConsulta='D') then Begin
            SQL.Add('SELECT clave FROM departamentos WHERE nombre = ''' + sBusqueda + '''');
            Open;
        end;

        Result := FieldByName('clave').AsInteger;
        Close;
    end;
end;

procedure TfrmActualizador.rdgBuscarClick(Sender: TObject);
begin
    pnlCodigo.Visible := false;
    pnlCodigo.Enabled := false;
    pnlDescCorta.Visible := false;
    pnlDescCorta.Enabled := false;
    pnlCateg.Visible := false;
    pnlCateg.Enabled := false;
    pnlDepto.Visible := false;
    pnlDepto.Enabled := false;
    pnlProveedor.Visible := false;
    pnlProveedor.Enabled := false;
    case rdgBuscar.ItemIndex of
        0: begin
            pnlCodigo.Visible := true;
            pnlCodigo.Enabled := true;
            txtCodigoBusq.SetFocus;
           end;
        1: begin
            pnlDescCorta.Visible := true;
            pnlDescCorta.Enabled := true;
            txtDescCortaBusq.SetFocus;
           end;
        2: begin
            pnlCateg.Visible := true;
            pnlCateg.Enabled := true;
            cmbCategBusq.SetFocus;
           end;
        3: begin
            pnlDepto.Visible := true;
            pnlDepto.Enabled := true;
            cmbDeptosBusq.SetFocus;
           end;
        4: begin
            pnlProveedor.Visible := true;
            pnlProveedor.Enabled := true;
            txtProvClave.SetFocus;
           end;
    end;
end;

procedure TfrmActualizador.RecuperaDatos;
begin
    with dmDatos.qryConsulta do begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT nombre FROM categorias WHERE tipo = ''A'' ORDER BY nombre');
        Open;
        cmbCategBusq.Items.Clear;
        while (not Eof) do begin
            cmbCategBusq.Items.Add(Trim(FieldByName('nombre').AsString));
            Next;
        end;
        Close;
    end;
    
    with dmDatos.qryConsulta do begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT nombre FROM departamentos  ORDER BY nombre');
        Open;
        cmbDeptosBusq.Items.Clear;
        while (not Eof) do begin
            cmbDeptosBusq.Items.Add(Trim(FieldByName('nombre').AsString));
            Next;
        end;
        Close;
    end;
end;

procedure TfrmActualizador.FormShow(Sender: TObject);
begin
    rdgBuscarClick(rdgBuscar);
    RecuperaDatos;

    bCambios := false;

//    btnLimpiarClick(Sender);
    chkReferenciaClick(Sender);

    grdListado.Cells[0,0] := 'Código';
    grdListado.Cells[1,0] := 'Descripción Larga'; /// modificacion para mostrar descripcicon larga
    grdListado.Cells[2,0] := 'Precio 1';
    grdListado.Cells[3,0] := 'Precio 2';
    grdListado.Cells[4,0] := 'Precio 3';
    grdListado.Cells[5,0] := 'Precio 4';
    grdListado.Cells[6,0] := 'Existencia';
    grdListado.Cells[7,0] := 'Costo';

    grdListado.ColWidths[0]:=85;
    grdListado.ColWidths[1]:=150;
    grdListado.ColWidths[2]:=55;
    grdListado.ColWidths[3]:=55;
    grdListado.ColWidths[4]:=55;
    grdListado.ColWidths[5]:=55;
    grdListado.ColWidths[6]:=55;
    grdListado.ColWidths[7]:=55;

    rdbCantidadClick(Sender);    
end;

procedure TfrmActualizador.btnLimpiarClick(Sender: TObject);
begin
    txtCodigoBusq.Clear;
    txtDescCortaBusq.Clear;
    cmbCategBusq.ItemIndex := -1;
    cmbDeptosBusq.ItemIndex := -1;
end;

procedure TfrmActualizador.RecuperaConfig;
var
    iniArchivo : TIniFile;
    sIzq, sArriba, sValor : String;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'config.ini');

    with iniArchivo do begin
        //Recupera la posición Y de la ventana
        sArriba := ReadString('Actualizador', 'Posy', '');

        //Recupera la posición X de la ventana
        sIzq := ReadString('Actualizador', 'Posx', '');

        if (Length(sIzq) > 0) and (Length(sArriba) > 0) then begin
            Left := StrToInt(sIzq);
            Top := StrToInt(sArriba);
        end;

        sValor := ReadString('Actualizador', 'Actualiza', '');
        if (sValor = 'C') then
            rdbCantidad.Checked := true
        else
            rdbPorcentaje.Checked := true;


        //Recupera el valor de los botones de radio de buscar
        sValor := ReadString('Actualizador', 'Buscar', '');
        if (Length(sValor) > 0) then
            rdgBuscar.ItemIndex := StrToInt(sValor);

        //Recupera el valor de los botones de radio de orden
        sValor := ReadString('Actualizador', 'Orden', '');
        if (Length(sValor) > 0) then
            rdgOrden.ItemIndex := StrToInt(sValor);
    end;
end;

procedure TfrmActualizador.FormClose(Sender: TObject;  var Action: TCloseAction);
var
    iniArchivo : TIniFile;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'config.ini');
    with iniArchivo do begin
        // Registra la posición y de la ventana
        WriteString('Actualizador', 'Posy', IntToStr(Top));

        // Registra la posición X de la ventana
        WriteString('Actualizador', 'Posx', IntToStr(Left));

        if(rdbCantidad.Checked) then
            WriteString('Actualizador', 'Actualiza', 'C')
        else
            WriteString('Actualizador', 'Actualiza', 'P');

        //Registra el valor de los botones de radio de buscar
        WriteString('Actualizador', 'Buscar', IntToStr(rdgBuscar.ItemIndex));

        //Registra el valor de los botones de radio de orden
        WriteString('Actualizador', 'Orden', IntToStr(rdgOrden.ItemIndex));

        Free;
    end;
    dmDatos.qryListados1.Close;
    dmDatos.cdsCliente1.Active := false;
end;

procedure TfrmActualizador.grdListadoEnter(Sender: TObject);
begin
    btnBuscar.Default := false;
end;

procedure TfrmActualizador.grdListadoExit(Sender: TObject);
begin
    btnBuscar.Default := true;
end;

procedure TfrmActualizador.Salir1Click(Sender: TObject);
begin
    Close;
end;
procedure TfrmActualizador.btnAplicarClick(Sender: TObject);
var
    i : integer;
    rCantidad : Real;
begin
    bCambios := true;
    rCantidad := 0;
    with dmDatos.qryListados1 do begin
        Open;
        if (txtCantidad.Value <> 0) then begin
            for i := 1 to grdListado.RowCount - 1 do begin
                if (chkReferencia.Checked) then
                    if (rdbPrecio1.Checked) then
                        rCantidad := StrToFloat(grdListado.Cells[2,i])
                    else if (rdbPrecio2.Checked) then
                        rCantidad := StrToFloat(grdListado.Cells[3,i])
                    else if (rdbPrecio3.Checked) then
                        rCantidad := StrToFloat(grdListado.Cells[4,i])
                    else if (rdbPrecio4.Checked) then
                        rCantidad := StrToFloat(grdListado.Cells[5,i])
                    else if (rdbCosto.Checked) then
                        rCantidad := StrToFloat(grdListado.Cells[7,i]);

                if (chkPrecio1.Checked) then
                    if (chkReferencia.Checked) then
                        grdListado.Cells[2,i] := FloatToStr(Redondea(rCantidad + txtCantidad.Value))
                    else
                        grdListado.Cells[2,i] := FloatToStr(Redondea(StrToFloat(grdListado.Cells[2,i]) + txtCantidad.Value));

                if (chkPrecio2.Checked) then
                    if (chkReferencia.Checked) then
                        grdListado.Cells[3,i] := FloatToStr(Redondea(rCantidad + txtCantidad.Value))
                    else
                        grdListado.Cells[3,i] := FloatToStr(Redondea(StrToFloat(grdListado.Cells[3,i]) + txtCantidad.Value));

                if (chkPrecio3.Checked) then
                    if (chkReferencia.Checked) then
                        grdListado.Cells[4,i] := FloatToStr(Redondea(rCantidad + txtCantidad.Value))
                    else
                        grdListado.Cells[4,i] := FloatToStr(Redondea(StrToFloat(grdListado.Cells[4,i]) + txtCantidad.Value));

                if (chkPrecio4.Checked) then
                    if (chkReferencia.Checked) then
                        grdListado.Cells[5,i] := FloatToStr(Redondea(rCantidad + txtCantidad.Value))
                    else
                        grdListado.Cells[5,i] := FloatToStr(Redondea(StrToFloat(grdListado.Cells[5,i]) + txtCantidad.Value));

                if (chkExistencia.Checked) then
                    if (chkReferencia.Checked) then
                        grdListado.Cells[6,i] := FloatToStr(Redondea(rCantidad + txtCantidad.Value))
                    else
                        grdListado.Cells[6,i] := FloatToStr(Redondea(StrToFloat(grdListado.Cells[6,i]) + txtCantidad.Value));

                if (chkCosto.Checked) then
                    if (chkReferencia.Checked) then
                        grdListado.Cells[7,i] := FloatToStr(Redondea(rCantidad + txtCantidad.Value))
                    else
                        grdListado.Cells[7,i] := FloatToStr(Redondea(StrToFloat(grdListado.Cells[7,i]) + txtCantidad.Value));
            end;
        end
        else if (txtPorcentaje.Value <> 0) then begin
             for i := 1 to grdListado.RowCount - 1 do begin
                if (chkReferencia.Checked) then
                    if (rdbPrecio1.Checked) then
                        rCantidad:=StrToFloat(grdListado.Cells[2,i])
                    else if (rdbPrecio2.Checked) then
                        rCantidad:=StrToFloat(grdListado.Cells[3,i])
                    else if (rdbPrecio3.Checked) then
                        rCantidad:=StrToFloat(grdListado.Cells[4,i])
                    else if (rdbPrecio4.Checked) then
                        rCantidad:=StrToFloat(grdListado.Cells[5,i])
                    else if (rdbCosto.Checked) then
                        rCantidad:=StrToFloat(grdListado.Cells[7,i]);

                if (chkPrecio1.Checked) then
                    if (chkReferencia.Checked) then
                        grdListado.Cells[2,i] :=FloatToStr(Redondea(rCantidad * (1+txtPorcentaje.Value/100)))
                    else
                        grdListado.Cells[2,i] :=FloatToStr(Redondea(StrToFloat(grdListado.Cells[2,i]) * (1+txtPorcentaje.Value/100)));

                if (chkPrecio2.Checked) then
                    if (chkReferencia.Checked) then
                        grdListado.Cells[3,i] :=FloatToStr(Redondea(rCantidad * (1+txtPorcentaje.Value/100)))
                    else
                        grdListado.Cells[3,i] :=FloatToStr(Redondea(StrToFloat(grdListado.Cells[3,i]) * (1+txtPorcentaje.Value/100)));

                if (chkPrecio3.Checked) then
                    if (chkReferencia.Checked) then
                        grdListado.Cells[4,i] :=FloatToStr(Redondea(rCantidad * (1+txtPorcentaje.Value/100)))
                    else
                        grdListado.Cells[4,i] :=FloatToStr(Redondea(StrToFloat(grdListado.Cells[4,i]) * (1+txtPorcentaje.Value/100)));

                if (chkPrecio4.Checked) then
                    if (chkReferencia.Checked) then
                        grdListado.Cells[5,i] :=FloatToStr(Redondea(rCantidad * (1+txtPorcentaje.Value/100)))
                    else
                        grdListado.Cells[5,i] :=FloatToStr(Redondea(StrToFloat(grdListado.Cells[5,i]) * (1+txtPorcentaje.Value/100)));

                if (chkExistencia.Checked) then
                    if (chkReferencia.Checked) then
                        grdListado.Cells[6,i] :=FloatToStr(Redondea(rCantidad * (1+txtPorcentaje.Value/100)))
                    else
                        grdListado.Cells[6,i] :=FloatToStr(Redondea(StrToFloat(grdListado.Cells[6,i]) * (1+txtPorcentaje.Value/100)));

               if (chkCosto.Checked) then
                    if (chkReferencia.Checked) then
                        grdListado.Cells[7,i] :=FloatToStr(Redondea(rCantidad * (1+txtPorcentaje.Value/100)))
                    else
                        grdListado.Cells[7,i] :=FloatToStr(Redondea(StrToFloat(grdListado.Cells[7,i]) * (1+txtPorcentaje.Value/100)));
            end;
        end;
    end;
    grdListado.SetFocus;
end;

procedure TfrmActualizador.btnGuardarClick(Sender: TObject);
var
    i : integer;
begin
    for i := 1 to grdListado.RowCount - 1 do begin
        if(Length(Trim(grdListado.Cells[2,i])) = 0) then
            grdListado.Cells[2,i] := '0';
        if(Length(Trim(grdListado.Cells[3,i])) = 0) then
            grdListado.Cells[3,i] := '0';
        if(Length(Trim(grdListado.Cells[4,i])) = 0) then
            grdListado.Cells[4,i] := '0';
        if(Length(Trim(grdListado.Cells[5,i])) = 0) then
            grdListado.Cells[5,i] := '0';
        if(Length(Trim(grdListado.Cells[6,i])) = 0) then
            grdListado.Cells[6,i] := '0';
        if(Length(Trim(grdListado.Cells[7,i])) = 0) then
            grdListado.Cells[7,i] := '0';


        with dmDatos.qryModifica do begin
            Close;
            SQL.Clear;
            SQL.Add('UPDATE articulos SET ');
            SQL.Add('Precio1 = ' + grdListado.Cells[2,i] + ',');
            SQL.Add('Precio2 = ' + grdListado.Cells[3,i] + ',');
            SQL.Add('Precio3 = ' + grdListado.Cells[4,i] + ',');
            SQL.Add('Precio4 = ' + grdListado.Cells[5,i] + ',');
            SQL.Add('existencia = ' + grdListado.Cells[6,i] + ',');
            SQL.Add('ult_costo = ' + grdListado.Cells[7,i]);
            SQL.Add('WHERE clave IN (SELECT articulo FROM codigos WHERE codigo = ''' + grdListado.Cells[0,i] + ''')');
            ExecSQL;
            Close;
        end;
    end;
    bCambios := false;
    Application.MessageBox('Cambios aplicados','Actualizador',[smbOK],smsInformation);
end;

procedure TfrmActualizador.grdListadoDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var
    sCad : String;
    i : real;
    eVal : Extended;
begin
    sCad := (Sender as TStringGrid).Cells[ACol,ARow];
    Rect.Top := Rect.Bottom;
    if (Length(sCad) > 0) then begin
        if(ARow = 0) then begin
            i := Rect.Left + (Rect.Right - Rect.Left) / 2 - (Sender as TStringGrid).Canvas.TextWidth(sCad) / 2;
            (Sender as TStringGrid).Canvas.FillRect(Rect);
            (Sender as TStringGrid).Canvas.TextOut(Round(i),Rect.Top+2,sCad);
        end;
        if(ACol <= 1) and (ARow > 0) then begin
            (Sender as TStringGrid).Canvas.FillRect(Rect);
            (Sender as TStringGrid).Canvas.Font.Color := clBlue;
            (Sender as TStringGrid).Canvas.TextOut(Rect.Left,Rect.Top+2,sCad);
        end;
    end;

    if(ACol >= 2) and (ARow > 0) then begin
        if (TryStrToFloat(sCad, eVal) and (Length(sCad)>0)) then
            sCad := FormatFloat('#,##0.000',StrToFloat(sCad))
        else begin
            (Sender as TStringGrid).Cells[ACol,ARow] := '0';
            sCad := '0.00';
        end;
        i := Rect.Right-(Sender as TStringGrid).Canvas.TextWidth(sCad+' ');
        (Sender as TStringGrid).Canvas.FillRect(Rect);
        (Sender as TStringGrid).Canvas.TextOut(Round(i),Rect.Top+2,sCad);
    end;
end;

procedure TfrmActualizador.grdListadoClick(Sender: TObject);
begin
    if(grdListado.Col > 1) then
        grdListado.EditorMode := true;
end;

procedure TfrmActualizador.chkReferenciaClick(Sender: TObject);
begin
    if(chkReferencia.Checked) then
        pnlReferencia.Enabled := true
    else
        pnlReferencia.Enabled := false;
end;

procedure TfrmActualizador.Salta(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    {Inicio (36), Fin (35), Izquierda (37), derecha (39), arriba (38), abajo (40)}
    if(Key >= 30) and (Key <= 122) and (Key <> 35) and (Key <> 36) and not ((Key >= 37) and (Key <= 40)) then
        if( Length((Sender as TEdit).Text) = (Sender as TEdit).MaxLength) then
            SelectNext(Sender as TWidgetControl, true, true);
end;

procedure TfrmActualizador.rdbCantidadClick(Sender: TObject);
begin
    if(rdbCantidad.Checked) then begin
        txtCantidad.Enabled := true;
        txtPorcentaje.Enabled := false;
    end
    else begin
        txtCantidad.Enabled := false;
        txtPorcentaje.Enabled := true;
    end;
end;

function TfrmActualizador.Redondea(rTotal:Real):Real;
Var
    rResiduo, rMoneda, rRedondeo: Real;
begin
    with dmDatos.qryModifica do begin
        Close;
        SQL.Clear;

        SQL.Add('SELECT monedamenor FROM config' );
        Open;

        rMoneda := FieldByName('monedamenor').AsFloat;
        Close;
    end;

    if  (chkRedondear.Checked) then begin
        rResiduo := rTotal - (Int(rTotal / rMoneda) * rMoneda);
        rRedondeo:=0;
        if(rResiduo > 0) then begin
            if(rResiduo > rMoneda / 2) then
                rRedondeo := rMoneda - rResiduo
            else
                rRedondeo := - rResiduo;
        end;
        rTotal := rTotal + rRedondeo;
    end;
    Result:=rTotal;
end;

procedure TfrmActualizador.FormCreate(Sender: TObject);
begin
    RecuperaConfig;
end;

procedure TfrmActualizador.txtProvClaveChange(Sender: TObject);
begin
    BuscaProveedor(Sender)
end;

procedure TfrmActualizador.BuscaProveedor(Sender: TObject);
begin
    with dmDatos.qryModifica do begin
        if(Length((Sender as TEdit).Text) > 0) then begin
           Close;
           SQL.Clear;
           SQL.Add('SELECT nombre FROM proveedores WHERE clave = ' + (Sender as TEdit).Text);
           Open;

           txtProvDesc.Text := Trim(FieldByName('nombre').AsString);
           Close;
        end;
    end;
end;

procedure TfrmActualizador.rdgOrdenClick(Sender: TObject);
begin
    if(dmDatos.qryListados1.Active) then
        btnBuscarClick(Sender);
end;

procedure TfrmActualizador.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
    if (bCambios) then
        if(Application.MessageBox('¿Deseas salir sin guardar cambios?','Salir', [smbOK,smbCancel], smsWarning) = smbCancel) then
            CanClose := False;
end;

procedure TfrmActualizador.grdListadoKeyPress(Sender: TObject;
  var Key: Char);
begin
    bCambios := true;
end;

end.

