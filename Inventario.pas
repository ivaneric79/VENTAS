// --------------------------------------------------------------------------
// Archivo del Proyecto Ventas
// Página del proyecto: http://sourceforge.net/projects/ventas
// --------------------------------------------------------------------------
// Este archivo puede ser distribuido y/o modificado bajo lo terminos de la
// Licencia Pública General versión 2 como es publicada por la Free Software
// Fundation, Inc.
// --------------------------------------------------------------------------

unit Inventario;

interface

uses
  SysUtils, Types, Classes, Variants, QTypes, QGraphics, QControls, QForms, 
  QDialogs, QStdCtrls, QcurrEdit, QButtons, QExtCtrls, QGrids, QDBGrids,
  QComCtrls, IniFiles, QMenus, Qt;

type
  TfrmInventario = class(TForm)
    pgeGeneral: TPageControl;
    tabDatos: TTabSheet;
    tabBusqueda: TTabSheet;
    btnBuscar: TBitBtn;
    btnLimpiar: TBitBtn;
    txtRegistros: TcurrEdit;
    rdgOrden: TRadioGroup;
    rdgBuscar: TRadioGroup;
    pnlProveedor: TPanel;
    Label37: TLabel;
    txtProvClave: TcurrEdit;
    txtProvDesc: TEdit;
    pnlDescCorta: TPanel;
    Label29: TLabel;
    txtDescCortaBusq: TEdit;
    pnlDepto: TPanel;
    Label30: TLabel;
    cmbDeptosBusq: TComboBox;
    pnlCodigo: TPanel;
    Label27: TLabel;
    txtCodigoBusq: TEdit;
    pnlCateg: TPanel;
    Label28: TLabel;
    cmbCategBusq: TComboBox;
    Label2: TLabel;
    grdListado: TStringGrid;
    MainMenu1: TMainMenu;
    mnuInventarios: TMenuItem;
    mnuGuardar: TMenuItem;
    mnuConsulta: TMenuItem;
    mnuBuscar: TMenuItem;
    grdListadoInv: TDBGrid;
    mnuInsertar: TMenuItem;
    mnuEliminar: TMenuItem;
    N1: TMenuItem;
    mnuCancelar: TMenuItem;
    Salir1: TMenuItem;
    N2: TMenuItem;
    mnuLimpiar: TMenuItem;
    pnlInventario: TPanel;
    grpInventario: TGroupBox;
    Label3: TLabel;
    txtDescrip: TEdit;
    Label4: TLabel;
    txtDia: TEdit;
    Label5: TLabel;
    txtMes: TEdit;
    Label31: TLabel;
    txtAnio: TEdit;
    btnGuardar: TBitBtn;
    btnCancelar: TBitBtn;
    Panel2: TPanel;
    btnSalir: TBitBtn;
    btnEliminar: TBitBtn;
    btnInsertar: TBitBtn;
    btnSeleccionar: TBitBtn;
    txtRegistrosInv: TcurrEdit;
    Label1: TLabel;
    btnInventarios: TBitBtn;
    mnuReportes: TMenuItem;
    mnuAjustes: TMenuItem;
    Conteofsico1: TMenuItem;
    Procesos1: TMenuItem;
    mnuAfectar: TMenuItem;
    Recalcularexistencias1: TMenuItem;
    mnuSeleccionar: TMenuItem;
    N3: TMenuItem;
    mnuCodigo: TMenuItem;
    mnuDescrip: TMenuItem;
    mnuCateg: TMenuItem;
    mnuDepto: TMenuItem;
    mnuProveedor: TMenuItem;
    Valordelinventario1: TMenuItem;
    mnuCodigoValor: TMenuItem;
    mnuDescripValor: TMenuItem;
    mnuCategValor: TMenuItem;
    mnuDeptoValor: TMenuItem;
    mnuProvValor: TMenuItem;
    Importar1: TMenuItem;
    N4: TMenuItem;
    Label6: TLabel;
    cmbTipo: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnBuscarClick(Sender: TObject);
    procedure grdListadoDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure FormShow(Sender: TObject);
    procedure txtProvClaveChange(Sender: TObject);
    procedure rdgBuscarClick(Sender: TObject);
    procedure rdgOrdenClick(Sender: TObject);
    procedure btnLimpiarClick(Sender: TObject);
    procedure mnuInventarioClick(Sender: TObject);
    procedure Bsqueda2Click(Sender: TObject);
    procedure btnSeleccionarClick(Sender: TObject);
    procedure btnInsertarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure Salta(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnGuardarClick(Sender: TObject);
    procedure btnEliminarClick(Sender: TObject);
    procedure grdListadoInvCellClick(Column: TColumn);
    procedure grdListadoKeyPress(Sender: TObject; var Key: Char);
    procedure pgeGeneralChange(Sender: TObject);
    procedure grdListadoKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure grdListadoClick(Sender: TObject);
    procedure grdListadoExit(Sender: TObject);
    procedure btnInventariosClick(Sender: TObject);
    procedure Salir1Click(Sender: TObject);
    procedure mnuAjustesClick(Sender: TObject);
    procedure mnuAfectarClick(Sender: TObject);
    procedure Recalcularexistencias1Click(Sender: TObject);
    procedure grdListadoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure txtAnioExit(Sender: TObject);
    procedure txtDiaExit(Sender: TObject);
    procedure mnuCodigoClick(Sender: TObject);
    procedure ValorInventario(Sender: TObject);
    procedure Importar1Click(Sender: TObject);
  private
    sClave : String;
    iRen, iCol : integer;
    rCantidad : Double; 
    
    procedure RecuperaConfig;
    procedure Inicializa;
    procedure CargaCombos;
    function CargaClave(sBusqueda:String;sConsulta:String):Integer;
    procedure BuscaProveedor(Sender: TObject);
    procedure RecuperaInventarios;
    procedure ActivaControles (sTipo : string);
    procedure LimpiaDatos;
    function VerificaDatos:boolean;
    function VerificaFechas(sFecha : string):boolean;
    procedure GuardaDato;
    procedure BuscaArticulo;
    procedure AfectaExistencia;
    procedure Rellena(Sender: TObject);
    function VerificaNombre:Boolean;
  public
    { Public declarations }
  end;

var
  frmInventario: TfrmInventario;

implementation

uses
    dm, reportesvarios, ReportesInvenAjus, fecha, InventImporta;

{$R *.xfm}

procedure TfrmInventario.FormCreate(Sender: TObject);
begin
    RecuperaConfig;
end;

procedure TfrmInventario.FormShow(Sender: TObject);
begin
    Inicializa;
    CargaCombos;
    RecuperaInventarios;
    tabDatos.TabVisible := false;
    btnCancelar.Click;
    btnInventariosClick(Sender);
end;

procedure TfrmInventario.RecuperaConfig;
var
    iniArchivo : TIniFile;
    sIzq, sArriba, sValor : String;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'config.ini');

    with iniArchivo do begin
        //Recupera la posición Y de la ventana
        sArriba := ReadString('Inventario', 'Posy', '');

        //Recupera la posición X de la ventana
        sIzq := ReadString('Inventario', 'Posx', '');

        if (Length(sIzq) > 0) and (Length(sArriba) > 0) then begin
            Left := StrToInt(sIzq);
            Top := StrToInt(sArriba);
        end;

        //Recupera el valor de los botones de radio de buscar
        pgeGeneral.ActivePage := tabDatos;
        sValor := ReadString('Inventario', 'Buscar', '');
        if (Length(sValor) > 0) then
            rdgBuscar.ItemIndex := StrToInt(sValor);

        //Recupera el valor de los botones de radio de orden
        sValor := ReadString('Inventario', 'Orden', '');
        if (Length(sValor) > 0) then
            rdgOrden.ItemIndex := StrToInt(sValor);

        Free;
    end;
end;

procedure TfrmInventario.FormClose(Sender: TObject; var Action: TCloseAction);
var
    iniArchivo : TIniFile;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'config.ini');
    with iniArchivo do begin
        // Registra la posición y de la ventana
        WriteString('Inventario', 'Posy', IntToStr(Top));

        // Registra la posición X de la ventana
        WriteString('Inventario', 'Posx', IntToStr(Left));

        //Registra el valor de los botones de radio de buscar
        WriteString('Inventario', 'Buscar', IntToStr(rdgBuscar.ItemIndex));

        //Registra el valor de los botones de radio de orden
        WriteString('Inventario', 'Orden', IntToStr(rdgOrden.ItemIndex));

        Free;
    end;
    dmDatos.cdsCliente1.Active := false;
    dmDatos.qryListados1.Close;
    dmDatos.cdsCliente.Active := false;
    dmDatos.qryListados.Close;
end;

procedure TfrmInventario.Inicializa;
begin
    grdListado.Cells[0,0] := 'Código';
    grdListado.Cells[1,0] := 'Descripción Larga'; ///modificacion
    grdListado.Cells[2,0] := 'Existencia';
    grdListado.Cells[3,0] := 'Real';
    grdListado.Cells[4,0] := 'Juego';
    grdListado.Cells[5,0] := 'Diferencia';

    grdListado.ColWidths[0] :=  85;
    grdListado.ColWidths[1] := 150;
    grdListado.ColWidths[2] :=  55;
    grdListado.ColWidths[3] :=  55;
    grdListado.ColWidths[4] :=  55;
    grdListado.ColWidths[5] :=  55;

    iRen := 0;
    iCol := 0;

    rdgBuscarClick(rdgBuscar);
end;

procedure TfrmInventario.btnBuscarClick(Sender: TObject);
var
    i : Integer;
begin
    btnBuscar.SetFocus;
    with dmDatos.qryListados1 do begin
        dmDatos.cdsCliente1.Active := false;
        Close;
        SQL.Clear;
        SQL.Add('SELECT a.clave, a.tipo, o.codigo, a.desc_larga, a.existencia,');
        SQL.Add('c.nombre AS categorias, d.nombre AS departamentos, i.existencia AS existen, i.cantidad, i.Cantjuego ');
        SQL.Add('FROM articulos a LEFT JOIN inventdet i ON a.clave = i.articulo AND i.inventario = ' + sClave);
        SQL.Add('LEFT JOIN categorias c ON a.categoria = c.clave');
        SQL.Add('LEFT JOIN codigos o ON (a.clave = o.articulo AND o.tipo = ''P'') ');
        SQL.Add('LEFT JOIN departamentos d ON a.departamento = d.clave WHERE a.tipo <> 2');

        case rdgBuscar.ItemIndex of
            0:  SQL.Add('AND o.codigo STARTING ''' + txtCodigoBusq.Text + '''');
            1:  SQL.Add('AND a.desc_larga LIKE ''%' + txtDescCortaBusq.Text + '%''');
            2:  if(cmbCategBusq.ItemIndex > -1) then
                    SQL.Add('AND a.categoria = ' + IntToStr(CargaClave(cmbCategBusq.Items.Strings[cmbCategBusq.ItemIndex],'C')));
            3:  if(cmbDeptosBusq.ItemIndex > -1) then
                    SQL.Add('AND a.departamento = ' + IntToStr(CargaClave(cmbDeptosBusq.Items.Strings[cmbDeptosBusq.ItemIndex],'D')));
            4:  if(txtProvClave.Value > 0) then
                    SQL.Add('AND (proveedor1 = ' + FloatToStr(txtProvClave.Value) + ' OR proveedor2 = ' + FloatToStr(txtProvClave.Value) + ')');
        end;

        case rdgOrden.ItemIndex of
            0: SQL.Add('ORDER BY o.codigo');
            1: SQL.Add('ORDER BY a.desc_larga');
            2: SQL.Add('ORDER BY c.nombre,o.codigo');
            3: SQL.Add('ORDER BY d.nombre,o.codigo');
            4: SQL.Add('ORDER BY a.proveedor1, a.proveedor2, o.codigo');
        end;

        Open;

        if(not Eof) then begin
            i := 1;
            while (Eof = false) do begin
                grdListado.RowCount := i + 1;
                grdListado.Cells[0,i] := Trim(FieldByName('codigo').AsString);
                grdListado.Cells[1,i] := Trim(FieldByName('desc_larga').AsString);     //modificacion
                if(FieldByName('existen').AsString = '') then
                    grdListado.Cells[2,i] := FloatToStr(FieldByName('existencia').AsFloat)
                else
                    grdListado.Cells[2,i] := FloatToStr(FieldByName('existen').AsFloat);
                if(not FieldByName('cantidad').IsNull) then begin
                    grdListado.Cells[3,i] := FloatToStr(FieldByName('cantidad').AsFloat);
                    grdListado.Cells[4,i] := FloatToStr(FieldByName('cantJuego').AsFloat);
                    grdListado.Cells[5,i] := FloatToStr(StrToFloat(grdListado.Cells[3,i]) + StrToFloat(grdListado.Cells[4,i]) - StrToFloat(grdListado.Cells[2,i]));
                end
                else begin
                    grdListado.Cells[3,i] := '';
                    grdListado.Cells[4,i] := '';
                    grdListado.Cells[5,i] := '';
                end;
                Inc(i);
                Next;
            end;
        end
        else begin
            grdListado.RowCount := 2;
            grdListado.Cells[0,1] := '';
            grdListado.Cells[1,1] := '';
            grdListado.Cells[2,1] := '';
            grdListado.Cells[3,1] := '';
            grdListado.Cells[4,1] := '';
            grdListado.Cells[5,1] := '';
        end;
        dmDatos.cdsCliente1.Active := true;

        txtRegistros.Value := dmDatos.cdsCliente1.RecordCount;

        Close;

        //Para que registre la columna donde esta situado el foco sin grabar nada en la tabla (iCol = 0, iRen = 0)
        iCol := 0;
        iRen := 0;
        grdListado.OnClick(Sender);

        grdListado.SetFocus;
    end;
end;

procedure TfrmInventario.grdListadoDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var
    sCad : String;
    i : real;
    eVal : Extended;
begin
    sCad := (Sender as TStringGrid).Cells[ACol,ARow];
    if(Length(sCad) > 0) then begin
        if(ARow = 0) then begin
            i := Rect.Left + (Rect.Right - Rect.Left) / 2 - (Sender as TStringGrid).Canvas.TextWidth(sCad) / 2;
            (Sender as TStringGrid).Canvas.FillRect(Rect);
            (Sender as TStringGrid).Canvas.TextOut(Round(i),Rect.Top+2,sCad);
        end;
        if ( ((ACol in [1,2,4,5]) or (dmDatos.cdsCliente.FieldByName('aplicado').AsString <> 'N')) and (ARow > 0)) then begin
            (Sender as TStringGrid).Canvas.FillRect(Rect);
            (Sender as TStringGrid).Canvas.Font.Color := clBlue;
            (Sender as TStringGrid).Canvas.TextOut(Rect.Left,Rect.Top+2,sCad);
        end;
        if(ACol >= 2) and (ARow > 0) then begin
            if (TryStrToFloat(sCad, eVal) and (Length(sCad)>0)) then
                sCad := FormatFloat('#,##0.000',StrToFloat(sCad));
            i := Rect.Right-(Sender as TStringGrid).Canvas.TextWidth(sCad+' ');
            (Sender as TStringGrid).Canvas.FillRect(Rect);
            (Sender as TStringGrid).Canvas.TextOut(Round(i),Rect.Top+2,sCad);
        end;
    end;
end;

procedure TfrmInventario.CargaCombos;
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

function TfrmInventario.CargaClave(sBusqueda:String;sConsulta:String):Integer;
begin
    with dmDatos.qryModifica do begin
        Close;
        SQL.Clear;
        if (sConsulta = 'C') then Begin
            SQL.Add('SELECT clave FROM categorias WHERE nombre = ''' + sBusqueda + '''');
            SQL.Add('AND tipo = ''A''');
            Open;
        end
        else if  (sConsulta = 'D') then Begin
            SQL.Add('SELECT clave FROM departamentos WHERE nombre = ''' + sBusqueda + '''');
            Open;
        end;
        Result := FieldByName('clave').AsInteger;
        Close;
    end;
end;

procedure TfrmInventario.txtProvClaveChange(Sender: TObject);
begin
  BuscaProveedor(Sender);
end;

procedure TfrmInventario.BuscaProveedor(Sender: TObject);
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

procedure TfrmInventario.rdgBuscarClick(Sender: TObject);
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

procedure TfrmInventario.rdgOrdenClick(Sender: TObject);
begin
    if(dmDatos.qryListados1.Active) then
        btnBuscarClick(Sender);
end;

procedure TfrmInventario.btnLimpiarClick(Sender: TObject);
begin
    txtCodigoBusq.Clear;
    txtDescCortaBusq.Clear;
    cmbCategBusq.ItemIndex := -1;
    cmbDeptosBusq.ItemIndex := -1;
    txtProvClave.Clear;
    txtProvDesc.Clear;
end;

procedure TfrmInventario.RecuperaInventarios;
begin
    dmDatos.cdsCliente.Active := false;
    with dmDatos.qryListados do begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT clave, fecha, descrip, aplicado FROM inventario ORDER BY fecha');
        Open;

        with dmDatos.cdsCliente do begin
            Active := true;

            sClave := FieldByName('clave').AsString;
            txtRegistrosInv.Value := RecordCount;

            FieldByName('clave').Visible := false;
            FieldByName('fecha').DisplayLabel := 'Fecha';
            FieldByName('fecha').DisplayWidth := 12;
            FieldByName('descrip').DisplayLabel := 'Descripción';
            FieldByName('descrip').DisplayWidth := 30;
            FieldByName('aplicado').DisplayLabel := 'Aplicado';
            FieldByName('aplicado').DisplayWidth := 5;

        end;
        if (pgeGeneral.ActivePage = tabBusqueda) then
            grdListadoInv.SetFocus;
    end;
end;

procedure TfrmInventario.mnuInventarioClick(Sender: TObject);
begin
    pgeGeneral.ActivePage := tabDatos;
end;

procedure TfrmInventario.Bsqueda2Click(Sender: TObject);
begin
    pgeGeneral.ActivePage := tabBusqueda;
end;

procedure TfrmInventario.btnSeleccionarClick(Sender: TObject);
begin
    if(txtRegistrosInv.Value > 0) then begin
        sClave := dmDatos.cdsCliente.FieldByName('clave').AsString;
        tabDatos.TabVisible := true;
        pgeGeneral.ActivePage := tabDatos;
        tabBusqueda.TabVisible := false;

        mnuInventarios.Enabled := false;
        mnuInventarios.Visible := false;
        mnuConsulta.Enabled := true;
        mnuConsulta.Visible := true;
        Caption := 'Inventarios físicos - ' + grdListadoInv.Fields[1].AsString;

        grdListado.RowCount := 2;
        grdListado.Cells[0,1] := '';
        grdListado.Cells[1,1] := '';
        grdListado.Cells[2,1] := '';
        grdListado.Cells[3,1] := '';
        grdListado.Cells[4,1] := '';
        grdListado.Cells[5,1] := '';
    end;
end;

procedure TfrmInventario.btnInsertarClick(Sender: TObject);
begin
    ActivaControles('Insertar');
    LimpiaDatos;
    txtDia.SetFocus;
end;

procedure TfrmInventario.btnCancelarClick(Sender: TObject);
begin
    ActivaControles('Consulta');
end;

procedure TfrmInventario.ActivaControles(sTipo : string);
begin
    if (sTipo = 'Insertar') then begin
        pnlInventario.Enabled := true;
        pnlInventario.Visible := true;

        btnInsertar.Enabled := false;
        btnEliminar.Enabled := false;
        btnSeleccionar.Enabled := false;
        mnuInsertar.Enabled := false;
        mnuEliminar.Enabled := false;

        mnuGuardar.Enabled := true;
        mnuCancelar.Enabled := true;

        mnuConsulta.Enabled := false;
    end
    else begin
        pnlInventario.Enabled := false;
        pnlInventario.Visible := false;

        btnInsertar.Enabled := true;
        mnuInsertar.Enabled := true;
        btnSeleccionar.Enabled := true;

        mnuGuardar.Enabled := false;
        mnuCancelar.Enabled := false;

        if(txtRegistrosInv.Value > 0) then begin
            btnEliminar.Enabled := true;
            mnuEliminar.Enabled := true;
            btnSeleccionar.Enabled := true;
            mnuSeleccionar.Enabled := true;
        end
        else begin
            btnEliminar.Enabled := false;
            mnuEliminar.Enabled := false;
            btnSeleccionar.Enabled := false;
            mnuSeleccionar.Enabled := false;
        end;

        mnuConsulta.Enabled := true;
    end;
end;

procedure TfrmInventario.LimpiaDatos;
begin
    txtDescrip.Clear;
    txtDia.Clear;
    txtMes.Clear;
    txtAnio.Clear;
end;

procedure TfrmInventario.Salta(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    {Inicio (36), Fin (35), Izquierda (37), derecha (39), arriba (38), abajo (40)}
    if(Key >= 30) and (Key <= 122) and (Key <> 35) and (Key <> 36) and not ((Key >= 37) and (Key <= 40)) then
        if( Length((Sender as TEdit).Text) = (Sender as TEdit).MaxLength) then
            SelectNext(Sender as TWidgetControl, true, true);
end;

function TfrmInventario.VerificaFechas(sFecha : string):boolean;
var
   dteFecha : TDateTime;
begin
   Result:=true;
   if(not TryStrToDate(sFecha,dteFecha)) then 
      Result:=false;
end;

procedure TfrmInventario.btnGuardarClick(Sender: TObject);
var
    sInventario : String;
begin
    if(VerificaDatos) then begin
        with dmDatos.qryModifica do begin
            Close;
            SQL.Clear;
            SQL.Add('INSERT INTO inventario (fecha, aplicado, descrip) VALUES(');
            SQL.Add('''' + txtMes.Text + '/' + txtDia.Text + '/' + txtAnio.Text + ''',');
            SQL.Add('''N'',''' + txtDescrip.Text + ''')');
            ExecSQL;

            if(cmbTipo.Text = 'TOTAL') then begin
                Close;
                SQL.Clear;
                SQL.Add('SELECT clave FROM inventario WHERE fecha =');
                SQL.Add('''' + txtMes.Text + '/' + txtDia.Text + '/' + txtAnio.Text + '''');
                SQL.Add('AND descrip = ''' + txtDescrip.Text + '''');
                Open;
                sInventario := FieldByName('clave').AsString;

                Close;
                SQL.Clear;
                SQL.Add('INSERT INTO inventdet (inventario, articulo, cantidad, existencia, juego, cantjuego)');
                SQL.Add('SELECT ' + sInventario + ',clave, 0, existencia, ''N'',0 FROM articulos WHERE');
                SQL.Add('tipo <> 2');
                ExecSQL;

                Close;
                SQL.Clear;
                SQL.Add('UPDATE inventdet SET juego = ''S'' WHERE articulo IN ');
                SQL.Add('(SELECT clave FROM articulos WHERE tipo = 1) AND');
                SQL.Add('inventario = ' + sInventario);
                ExecSQL;
            end;
            Close;
        end;
        RecuperaInventarios;
        btnCancelar.Click;
    end;
end;

function TfrmInventario.VerificaDatos:boolean;
begin
    btnGuardar.SetFocus;
    Result := True;
    if(not VerificaFechas(txtDia.Text + '/' + txtMes.Text + '/' + txtAnio.Text)) then begin
        Application.MessageBox('Introduce una fecha correcta','Error',[smbOK],smsCritical);
        txtDia.SetFocus;
        Result := false;
    end
    else if(Length(txtDescrip.Text) = 0) then begin
        Application.MessageBox('Introduce una descripción para el inventario','Error',[smbOK],smsCritical);
        txtDescrip.SetFocus;
        Result := False;
    end
    else if(not VerificaNombre) then begin
        Application.MessageBox('Ya existe un inventario con el mismo nombre y fecha','Error',[smbOK],smsCritical);
        txtDescrip.SetFocus;
        Result := False;
    end
end;

function TfrmInventario.VerificaNombre:Boolean;
begin
    Result := true;
    with dmDatos.qryModifica do begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT clave FROM inventario WHERE descrip = ''' + txtDescrip.Text + '''');
        SQL.Add('AND fecha = ''' + txtMes.Text + '/' + txtDia.Text + '/' + txtAnio.Text + '''');
        Open;
        if(not Eof) then
            Result := false;
        Close;
    end;
end;

procedure TfrmInventario.btnEliminarClick(Sender: TObject);
begin
    if(Application.MessageBox('Se eliminará el inventario seleccionado','Eliminar',[smbOK]+[smbCancel],smsCritical) = smbOk) then begin
        sClave := dmDatos.cdsCliente.FieldByName('clave').AsString;
        with dmDatos.qryModifica do begin
            Close;
            SQL.Clear;
            SQL.Add('DELETE FROM inventario WHERE clave = ' + sClave);
            ExecSQL;
            Close;
        end;
        RecuperaInventarios;
    end;
end;

procedure TfrmInventario.grdListadoInvCellClick(Column: TColumn);
begin
    with dmDatos.cdsCliente do
        if(Active) then
            sClave := FieldByName('clave').AsString;
end;

procedure TfrmInventario.grdListadoKeyPress(Sender: TObject;
  var Key: Char);
begin
    if(grdListado.Col <> 3) or (dmDatos.cdsCliente.FieldByName('aplicado').AsString <> 'N') then
        Key := #0
end;

procedure TfrmInventario.GuardaDato;
var
    sArticulo, sExistencia, sArtJuego, sTipo, sJuego, sCantJuego, sCantidad : String;
    rCantJuego, rCantBaseDato, rCantGrid : real;
    eVal : Currency;
begin
    if (not TryStrToCurr(grdListado.Cells[3, iRen], eVal)) then
        grdListado.Cells[3, iRen] := ''
    else
        // Para prevenir errores cuando el usuario introduce la letra E en la celda
        grdListado.Cells[3,iRen] := FloatToStr(StrToFloat(grdListado.Cells[3,iRen]));

    with dmDatos.qryModifica do begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT a.clave, a.tipo, i.cantidad, i.cantjuego FROM articulos a LEFT JOIN inventdet i ON ');
        SQL.Add('a.clave = i.articulo AND i.inventario = ' + sClave);
        SQL.Add('WHERE a.clave IN (SELECT articulo FROM codigos WHERE codigo = ''' + grdListado.Cells[0,iRen] + ''')');
        Open;
        sArticulo := FieldByName('clave').AsString;
        sTipo := FieldByName('tipo').AsString;
        if(sTipo = '1') then
            sJuego := 'S'
        else
            sJuego := 'N';

        // Si existe el articulo
        if(not Eof) then begin
            if(grdListado.Cells[3,iRen] <> '') then begin
                if(FieldByName('cantidad').IsNull) then begin
                    // Si no existe en la tabla inventdet
                    Close;
                    SQL.Clear;
                    SQL.Add('INSERT INTO inventdet (inventario, existencia, articulo,');
                    SQL.Add('cantidad, cantJuego, juego) VALUES(' + sClave + ',');
                    SQL.Add(grdListado.Cells[2,iRen] + ',' + sArticulo + ',');
                    SQL.Add(grdListado.Cells[3,iRen] + ',0,''' + sJuego + ''')');
                    ExecSQL;
                end
                else begin
                    // Si ya existe en la tabla inventdet
                    Close;
                    SQL.Clear;
                    SQL.Add('UPDATE inventdet SET cantidad = ' + grdListado.Cells[3,iRen]);
                    SQL.Add('WHERE articulo = ' + sArticulo + ' AND inventario = ' + sClave);
                    ExecSQL;
                end;
                Close;
            end
            else begin
                // Si la celda esta vacia pero cantjuego tiene algo
                if(FieldByName('cantjuego').AsFloat > 0) then begin
                    // Si ya existe en la tabla inventdet
                    Close;
                    SQL.Clear;
                    SQL.Add('UPDATE inventdet SET cantidad = 0');
                    SQL.Add('WHERE articulo = ' + sArticulo + ' AND inventario = ' + sClave);
                    ExecSQL;
                end
                else begin
                    // Si la celda esta vacia, se elimina de la tabla inventdet
                    Close;
                    SQL.Clear;
                    SQL.Add('DELETE FROM inventdet WHERE articulo  = ' + sArticulo);
                    SQL.Add('AND inventario = ' + sClave);
                    ExecSQL;
                    Close;
                end;
            end;
            if(grdListado.Cells[3, iRen] = '') then
                sCantidad := '0'
            else
                sCantidad := grdListado.Cells[3,iRen];

            // Si es juego y la cantidad anterior es diferente de la nueva
            if(sJuego = 'S') and (StrToFloat(sCantidad) <> rCantidad) then begin
                rCantJuego := StrToFloat(sCantidad) - rCantidad;
                Close;
                SQL.Clear;
                SQL.Add('SELECT articulo, cantidad FROM juegos WHERE clave = ' + sArticulo);
                Open;
                while(not Eof) do begin
                    sArtJuego := FieldByName('articulo').AsString;
                    sCantJuego := FloatToStr(rCantJuego * FieldByName('cantidad').AsFloat);
                    dmDatos.qryAuxiliar1.Close;
                    dmDatos.qryAuxiliar1.SQL.Clear;
                    dmDatos.qryAuxiliar1.SQL.Add('SELECT i.*, a.existencia AS existen FROM articulos a');
                    dmDatos.qryAuxiliar1.SQL.Add('LEFT JOIN inventdet i ON i.articulo = a.clave');
                    dmDatos.qryAuxiliar1.SQL.Add('WHERE a.clave = ' + sArtJuego + ' AND i.inventario = ' + sClave);
                    dmDatos.qryAuxiliar1.Open;
                    if(dmDatos.qryAuxiliar1.FieldByName('articulo').IsNull) then begin
                        sExistencia := dmDatos.qryAuxiliar1.FieldByName('existen').AsString;
                        dmDatos.qryAuxiliar1.Close;
                        dmDatos.qryAuxiliar1.SQL.Clear;
                        dmDatos.qryAuxiliar1.SQL.Add('INSERT INTO inventdet (inventario, existencia, articulo,');
                        dmDatos.qryAuxiliar1.SQL.Add('cantidad, cantJuego, juego) VALUES(' + sClave + ',');
                        dmDatos.qryAuxiliar1.SQL.Add(sExistencia + ',' + sArtJuego + ',');
                        dmDatos.qryAuxiliar1.SQL.Add('0,' + sCantJuego + ',''N'')');
                        dmDatos.qryAuxiliar1.ExecSQL;
                        dmDatos.qryAuxiliar1.Close;
                    end
                    else begin
                        rCantBaseDato := dmDatos.qryAuxiliar1.FieldByName('cantjuego').AsFloat;
                        rCantGrid := StrToFloat(sCantjuego);
                        // Si cantidad = 0 y la diferencia de cantjuego con la cantida = 0
                        if(dmDatos.qryAuxiliar1.FieldByName('cantidad').AsFloat = 0) and (rCantBaseDato + rCantGrid = 0) then begin
                            dmDatos.qryAuxiliar1.Close;
                            dmDatos.qryAuxiliar1.SQL.Clear;
                            dmDatos.qryAuxiliar1.SQL.Add('DELETE FROM inventdet WHERE articulo = ' + sArtJuego + ' AND inventario = ' + sClave);
                            dmDatos.qryAuxiliar1.ExecSQL;
                            dmDatos.qryAuxiliar1.Close;
                        end
                        else begin
                            dmDatos.qryAuxiliar1.Close;
                            dmDatos.qryAuxiliar1.SQL.Clear;
                            dmDatos.qryAuxiliar1.SQL.Add('UPDATE inventdet SET cantjuego = cantjuego + ' + sCantJuego);
                            dmDatos.qryAuxiliar1.SQL.Add('WHERE articulo = ' + sArtJuego + ' AND inventario = ' + sClave);
                            dmDatos.qryAuxiliar1.ExecSQL;
                            dmDatos.qryAuxiliar1.Close;
                        end;
                    end;
                    Next;
                end;
            end;
        end;
        Close;
    end;
end;

procedure TfrmInventario.pgeGeneralChange(Sender: TObject);
begin
    if(pgeGeneral.ActivePage = tabDatos) then begin

    end;
end;

procedure TfrmInventario.grdListadoKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
    eVal : Extended;
begin
    if(grdListado.Col = 0) then
        BuscaArticulo;
    if (TryStrToFloat(grdListado.Cells[3, grdListado.Row], eVal)) then begin
        eVal := 0;
        TryStrToFloat(grdListado.Cells[4,grdListado.Row],eVal);
        grdListado.Cells[5,grdListado.Row] := FloatToStr(StrToFloat(grdListado.Cells[3, grdListado.Row]) + eVal - StrToFloat(grdListado.Cells[2, grdListado.Row]))
    end
    else
        grdListado.Cells[5,grdListado.Row] := '';

end;

procedure TfrmInventario.BuscaArticulo;
begin
    with dmDatos.qryModifica do begin
        // Si la celda contiene algo
        if(Length(grdListado.Cells[0,grdListado.Row]) > 0) then begin
            //Busca el codigo escrito en la celda
            Close;
            SQL.Clear;
            SQL.Add('SELECT desc_corta, existencia FROM articulos');
            SQL.Add('WHERE clave IN (SELECT articulo FROM codigos WHERE codigo = ''' + grdListado.Cells[0,grdListado.Row] + ''')');
            Open;

            //Si lo encontró recupera la descripción y el precio y lo pone en su celda correspondiente
            if(not Eof) then  begin
                 //grdListado.Cells[1,grdListado.Row] := '';
                 grdListado.Cells[1,grdListado.Row] := FieldByName('desc_corta').AsString;
                 //grdListado.Cells[2,grdListado.Row] := '';
                 grdListado.Cells[2,grdListado.Row] := FieldByName('existencia').AsString;
            end
            else begin
                //Limpia las celdas de descripcion y precio
                grdListado.Cells[1,grdListado.Row] := '';
                grdListado.Cells[2,grdListado.Row] := '';
                grdListado.Cells[3,grdListado.Row] := '';
                grdListado.Cells[4,grdListado.Row] := '';
                grdListado.Cells[5,grdListado.Row] := '';
            end;
            Close;
        end
        else
            grdListado.Cells[1,grdListado.Row] := '';
    end;
end;

procedure TfrmInventario.grdListadoClick(Sender: TObject);
begin
    // Si la celda anterior = 3
    if(iCol = 3) then
        GuardaDato;
    // si la celda actual = 3
    if(grdListado.Col = 3) then begin
        rCantidad := 0;
        // Se asigna la cantidad de la celda antes de modificarla
        TryStrToFloat(grdListado.Cells[3,grdListado.Row], rCantidad);
    end;
    iCol := grdListado.Col;
    iRen := grdListado.Row;
end;

procedure TfrmInventario.grdListadoExit(Sender: TObject);
begin
    grdListadoClick(Sender);
end;

procedure TfrmInventario.btnInventariosClick(Sender: TObject);
begin
    tabBusqueda.TabVisible := true;
    pgeGeneral.ActivePage := tabBusqueda;
    tabDatos.TabVisible := false;

    mnuInventarios.Enabled := true;
    mnuInventarios.Visible := true;
    mnuConsulta.Enabled := false;
    mnuConsulta.Visible := false;

    Caption := 'Inventarios físicos';
end;

procedure TfrmInventario.Salir1Click(Sender: TObject);
begin
    Close;
end;

procedure TfrmInventario.mnuAjustesClick(Sender: TObject);
begin
    with TfrmReportesInventariosF.Create(Self) do
    try
        ShowModal;
    finally
        Free;
    end;
    SetFocus;
end;

procedure TfrmInventario.mnuAfectarClick(Sender: TObject);
begin
    if(dmDatos.cdsCliente.FieldByName('clave').AsString <> '') then begin
        if(Application.MessageBox('Se afectarán las existencias con los valores capturados','Afectar existencias',[smbOk]+[smbCancel]) = smbOk) then begin
            AfectaExistencia;
            with dmDatos.qryModifica do begin
                Close;
                SQL.Clear;
                SQL.Add('UPDATE inventario SET aplicado = ''S'' WHERE clave = ' + sClave);
                ExecSQL;
                Close;
            end;
            RecuperaInventarios;
            Application.MessageBox('Proceso terminado','Afectar existencias',[smbOk])
        end;
    end
    else
        Application.MessageBox('Selecciona un inventario','Error',[smbOk])
end;

procedure TfrmInventario.AfectaExistencia;
begin
    with dmDatos.qryModifica do begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT i.articulo, i.cantidad + i.cantjuego AS cantidad, i.existencia FROM inventdet i');
        SQL.Add('LEFT JOIN articulos a ON i.articulo = a.clave WHERE a.tipo NOT IN (1,2) AND inventario = ' + sClave);
        Open;

        while(not Eof) do begin
            dmDatos.qryConsulta.Close;
            dmDatos.qryConsulta.SQL.Clear;
            dmDatos.qryConsulta.SQL.Add('UPDATE articulos SET existencia = ' + FloatToStr(FieldByName('Cantidad').AsFloat ));
            dmDatos.qryConsulta.SQL.Add('WHERE clave = ' + FieldByName('articulo').AsString);
            dmDatos.qryConsulta.ExecSQL;
            dmDatos.qryConsulta.Close;
            Next;
        end;
        Close;
    end;
end;

procedure TfrmInventario.Recalcularexistencias1Click(Sender: TObject);
var
    bRecalcula : boolean;
    dteFechaLimite : TDateTime;
begin
    bRecalcula := false;
    dteFechaLimite := Date;
    if(dmDatos.cdsCliente.FieldByName('clave').AsString <> '') then begin
        if(Application.MessageBox('Se recalcularán las existencias de acuerdo con ' + #10 + 'las ventas y las compras realizadas a partir del inventario seleccionado y hasta el limite especificado','Recalcular existencias',[smbOk]+[smbCancel]) = smbOk) then begin
            with TfrmFecha.Create(Self) do
            try
                sTitulo := 'Límite para recalcular existencias';
                if(ShowModal = mrOk) then begin
                    dteFechaLimite := dteFecha;
                    bRecalcula := true;
                end;
            finally
                Free;
            end;

            if(bRecalcula) then begin
                AfectaExistencia;
                with dmDatos.qryModifica do begin
                    Close;
                    SQL.Clear;
                    SQL.Add('SELECT d.articulo, SUM(d.cantidad) AS cantidad FROM comprasdet d JOIN compras c');
                    SQL.Add('ON d.compra = c.clave JOIN articulos a ON d.articulo = a.clave');
                    SQL.Add('JOIN inventdet i ON i.articulo = d.articulo AND i.inventario = ' + sClave);
                    SQL.Add('WHERE c.fecha >= ''' + FormatDateTime('mm/dd/yyyy',dmDatos.cdsCliente.FieldByName('fecha').AsDateTime) + '''');
                    SQL.Add('AND c.fecha <= ''' + FormatDateTime('mm/dd/yyyy',dteFechaLimite) + '''');
                    SQL.Add('AND c.estatus = ''A'' AND a.tipo NOT IN (1,2) GROUP BY d.articulo');
                    Open;

                    while(not Eof) do begin
                        dmDatos.qryConsulta.Close;
                        dmDatos.qryConsulta.SQL.Clear;
                        dmDatos.qryConsulta.SQL.Add('UPDATE articulos SET existencia = existencia + ' + FieldByName('Cantidad').AsString);
                        dmDatos.qryConsulta.SQL.Add('WHERE clave = ' + FieldByName('articulo').AsString);
                        dmDatos.qryConsulta.ExecSQL;
                        dmDatos.qryConsulta.Close;
                        Next;
                    end;

                    Close;
                    SQL.Clear;
                    SQL.Add('SELECT d.articulo, SUM(d.cantidad) AS cantidad, c.tipo FROM ventasdet d JOIN ventas v');
                    SQL.Add('JOIN articulos a ON d.articulo = a.clave');
                    SQL.Add('ON d.venta = v.clave LEFT JOIN comprobantes c ON v.clave = c.venta');
                    SQL.Add('JOIN inventdet i ON i.articulo = d.articulo AND i.inventario = ' + sClave);
                    SQL.Add('WHERE c.tipo <> ''C'' AND c.estatus = ''A'' AND ');
                    SQL.Add('v.fecha >= ''' + FormatDateTime('mm/dd/yyyy',dmDatos.cdsCliente.FieldByName('fecha').AsDateTime) + '''');
                    SQL.Add('AND v.fecha <= ''' + FormatDateTime('mm/dd/yyyy',dteFechaLimite) + '''');
                    SQL.Add('AND a.tipo NOT IN (1,2) AND v.estatus = ''A'' GROUP BY c.tipo, d.articulo');
                    Open;

                    while(not Eof) do begin
                        dmDatos.qryConsulta.Close;
                        dmDatos.qryConsulta.SQL.Clear;
                        if(FieldByName('tipo').AsString = 'D') then
                            dmDatos.qryConsulta.SQL.Add('UPDATE articulos SET existencia = existencia + ' + FieldByName('Cantidad').AsString)
                        else
                            dmDatos.qryConsulta.SQL.Add('UPDATE articulos SET existencia = existencia - ' + FieldByName('Cantidad').AsString);
                        dmDatos.qryConsulta.SQL.Add('WHERE clave = ' + FieldByName('articulo').AsString);
                        dmDatos.qryConsulta.ExecSQL;
                        dmDatos.qryConsulta.Close;
                        Next;
                    end;
                    Close;
                    Application.MessageBox('Proceso terminado','Afectar existencias',[smbOk])
                end;
            end;
        end;
    end;
end;

procedure TfrmInventario.grdListadoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if(grdListado.Col <> 3) and (grdListado.Col <> 0) and (Key = Key_Delete) then
        Key := 0;
end;

procedure TfrmInventario.txtAnioExit(Sender: TObject);
begin
    txtAnio.Text := Trim(txtAnio.Text);
    if(Length(txtAnio.Text) < 4) and (Length(txtAnio.Text) > 0) then
        txtAnio.Text := IntToStr(StrToInt(txtAnio.Text) + 2000);
end;

procedure TfrmInventario.txtDiaExit(Sender: TObject);
begin
    Rellena(Sender)
end;
procedure TfrmInventario.Rellena(Sender: TObject);
var
    i : integer;
begin
    for i := Length((Sender as TEdit).Text) to (Sender as TEdit).MaxLength - 1 do
        (Sender as TEdit).Text := '0' + (Sender as TEdit).Text;
end;

procedure TfrmInventario.mnuCodigoClick(Sender: TObject);
var
    sOrden, sCampo : String;
begin
    if(dmDatos.cdsCliente.FieldByName('clave').AsString <> '') then begin
        if((Sender as TMenuItem).Name = 'mnuCodigo') then begin
            sOrden := 'ORDER BY codigo';
            sCampo := 'codigo';
        end
        else if((Sender as TMenuItem).Name = 'mnuDescrip') then begin
            sOrden := 'ORDER BY desc_larga';
            sCampo := 'desc_larga';
        end
        else if((Sender as TMenuItem).Name = 'mnuCateg') then begin
            sOrden := 'ORDER BY categoria';
            sCampo := 'CATEGORIA';
        end
        else if((Sender as TMenuItem).Name = 'mnuDepto') then begin
            sOrden := 'ORDER BY departamento';
            sCampo := 'DEPARTAMENTO';
        end
        else if((Sender as TMenuItem).Name = 'mnuProveedor') then begin
            sOrden := 'ORDER BY p.clave';
            sCampo := 'PROVEEDOR';
        end;

        with TfrmReportesVarios.Create(Self) do
        try
            ImprimeConteo(sClave, sCampo, sOrden);
        finally
            Free;
        end;
        SetFocus;
    end
    else
        Application.MessageBox('Selecciona un inventario','Error',[smbOk])
end;

procedure TfrmInventario.ValorInventario(Sender: TObject);
var
    sOrden, sCampo : String;
begin
    if(dmDatos.cdsCliente.FieldByName('clave').AsString <> '') then begin
        if((Sender as TMenuItem).Name = 'mnuCodigoValor') then begin
            sOrden := 'ORDER BY codigo';
            sCampo := 'codigo';
        end
        else if((Sender as TMenuItem).Name = 'mnuDescripValor') then begin
            sOrden := 'ORDER BY desc_larga';
            sCampo := 'desc_larga';
        end
        else if((Sender as TMenuItem).Name = 'mnuCategValor') then begin
            sOrden := 'ORDER BY categoria';
            sCampo := 'CATEGORIA';
        end
        else if((Sender as TMenuItem).Name = 'mnuDeptoValor') then begin
            sOrden := 'ORDER BY departamento';
            sCampo := 'DEPARTAMENTO';
        end
        else if((Sender as TMenuItem).Name = 'mnuProvValor') then begin
            sOrden := 'ORDER BY p.clave';
            sCampo := 'PROVEEDOR';
        end;

        with TfrmReportesVarios.Create(Self) do
        try
            ImprimeValorInvent(sClave, sCampo, sOrden);
        finally
            Free;
        end;
        SetFocus;
    end
    else
        Application.MessageBox('Selecciona un inventario','Error',[smbOk])

end;

procedure TfrmInventario.Importar1Click(Sender: TObject);
begin
    if(dmDatos.cdsCliente.FieldByName('clave').AsString <> '') then begin
        with TfrmInventImporta.Create(Self) do
        try
            sInventario := sClave;
            ShowModal;
        finally
            Free;
        end;
        SetFocus;
    end
    else
        Application.MessageBox('Selecciona un inventario','Error',[smbOk])
end;

end.
