// --------------------------------------------------------------------------
// Archivo del Proyecto Ventas 
// Página del proyecto: http://sourceforge.net/projects/ventas
// --------------------------------------------------------------------------
// Este archivo puede ser distribuido y/o modificado bajo lo terminos de la
// Licencia Pública General versión 2 como es publicada por la Free Software
// Fundation, Inc.
// --------------------------------------------------------------------------

unit Gastos;

interface

uses
  SysUtils, Types, Classes, QGraphics, QControls, QForms, QDialogs,
  QMenus, QTypes, QExtCtrls, QDBGrids, QStdCtrls, QButtons, QGrids,
  QcurrEdit, QComCtrls, IniFiles, Qt;

type
  TfrmGastos = class(TForm)
    pgeGeneral: TPageControl;
    tabDatos: TTabSheet;
    grpArticulo: TGroupBox;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label12: TLabel;
    txtDescripLarga: TEdit;
    txtDescripCorta: TEdit;
    txtCodigo: TEdit;
    txtFechaCap: TEdit;
    pgeDatos: TPageControl;
    tabOrganiza: TTabSheet;
    grpOrganiza: TGroupBox;
    Label5: TLabel;
    cmbCategorias: TComboBox;
    grpProveedores: TGroupBox;
    txtProvNum1: TcurrEdit;
    Label6: TLabel;
    txtProveedor1: TEdit;
    btnInsertar: TBitBtn;
    btnEliminar: TBitBtn;
    btnModificar: TBitBtn;
    btnGuardar: TBitBtn;
    btnCancelar: TBitBtn;
    MainMenu1: TMainMenu;
    Archivo1: TMenuItem;
    mnuInsertar: TMenuItem;
    mnuEliminar: TMenuItem;
    mnuModificar: TMenuItem;
    N3: TMenuItem;
    mnuGuardar: TMenuItem;
    mnuCancelar: TMenuItem;
    N2: TMenuItem;
    Salir1: TMenuItem;
    mnuConsulta: TMenuItem;
    mnuAvanza: TMenuItem;
    mnuRetrocede: TMenuItem;
    N1: TMenuItem;
    mnuBuscar: TMenuItem;
    N4: TMenuItem;
    mnuLimpiar: TMenuItem;
    mnuSeleccionar: TMenuItem;
    mnuFichas: TMenuItem;
    mnuProved: TMenuItem;
    mnuBusqueda: TMenuItem;
    N5: TMenuItem;
    mnuOrganizacion: TMenuItem;
    tabBusqueda: TTabSheet;
    grdListado: TDBGrid;
    rdgBuscar: TRadioGroup;
    rdgOrden: TRadioGroup;
    Label26: TLabel;
    txtRegistros: TcurrEdit;
    btnBuscar: TBitBtn;
    btnSeleccionar: TBitBtn;
    btnLimpiar: TBitBtn;
    pnlCodigo: TPanel;
    Label27: TLabel;
    txtCodigoBusq: TEdit;
    pnlDescCorta: TPanel;
    Label29: TLabel;
    txtDescCortaBusq: TEdit;
    tabMov: TTabSheet;
    grpUltCompra: TGroupBox;
    Label20: TLabel;
    Label21: TLabel;
    txtProv: TEdit;
    txtFechComp: TEdit;
    cmbEstatus: TComboBox;
    Buscarproveedor1: TMenuItem;
    N6: TMenuItem;
    Label33: TLabel;
    pnlProveedor: TPanel;
    Label37: TLabel;
    txtProvClave: TcurrEdit;
    txtProvDesc: TEdit;
    mnuMovimientos: TMenuItem;
    grpImpuesto: TGroupBox;
    Label16: TLabel;
    txtIva: TcurrEdit;
    grpCostos: TGroupBox;
    Label14: TLabel;
    txtUltimoCos: TcurrEdit;
    procedure btnInsertarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnGuardarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure txtProvNum1Change(Sender: TObject);
    procedure txtProvNum2Change(Sender: TObject);
    procedure btnBuscarClick(Sender: TObject);
    procedure rdgBuscarClick(Sender: TObject);
    procedure btnModificarClick(Sender: TObject);
    procedure btnLimpiarClick(Sender: TObject);
    procedure grdJuegoDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);

    procedure mnuOrganizacionClick(Sender: TObject);
    procedure mnuProvedClick(Sender: TObject);
    procedure mnuBusquedaClick(Sender: TObject);
    procedure mnuAvanzaClick(Sender: TObject);
    procedure mnuRetrocedeClick(Sender: TObject);
    procedure btnEliminarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure grdListadoDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure Buscarproveedor1Click(Sender: TObject);
    procedure grdListadoDblClick(Sender: TObject);
    procedure grdListadoEnter(Sender: TObject);
    procedure grdListadoExit(Sender: TObject);
    procedure btnSeleccionarClick(Sender: TObject);
    procedure Salir1Click(Sender: TObject);
    procedure Salta(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure txtCodigoKeyPress(Sender: TObject; var Key: Char);
    procedure pgeGeneralPageChanging(Sender: TObject; NewPage: TTabSheet;
      var AllowChange: Boolean);
    procedure pgeGeneralChange(Sender: TObject);
    procedure CargaMovimientos;
    procedure mnuMovimientosClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure txtProvClaveChange(Sender: TObject);
    function  VerificaCodigo:boolean;


  private
    sModo:    String;
    iClave:   Integer;
    bLetras:  Boolean;

    procedure LimpiaDatos;
    procedure ActivaControles;
    procedure Colores(clColor : TColor);
    procedure RecuperaDatos;
    procedure GuardaDatos;
    function  VerificaDatos:boolean;
    function  ClaveCarga(sBusqueda:String ; sConsulta:String):Integer;
    procedure BuscaProveedor(Sender: TObject);
    procedure RecuperaDatosBusq;
    procedure ActivaBuscar;
//    procedure BuscaArticulo;
    procedure RecuperaConfig;
    procedure VerificaCategs;
    procedure VerificaDeptos;
    function BuscaNombre(iValor:Integer; sTabla:string):String;

  public
  end;

var
  frmGastos: TfrmGastos;

implementation

uses dm, ProveedBusq, ArticuloBusq;

{$R *.xfm}

procedure TfrmGastos.btnInsertarClick(Sender: TObject);
begin
    pgeGeneral.ActivePage := tabDatos;
    sModo := 'Insertar';
    ActivaControles;
    LimpiaDatos;
    txtCodigo.SetFocus;
    txtFechaCap.Text := FormatDateTime('dd/mm/yyyy',Date);
    pgeGeneral.ActivePage := tabDatos;
    cmbEstatus.ItemIndex := 0 ;  //Estatus Activo
    if(cmbCategorias.ItemIndex = -1) then
        cmbCategorias.ItemIndex := 0;
end;

procedure TfrmGastos.LimpiaDatos;
begin
    txtCodigo.Clear;
    txtDescripCorta.Clear;
    txtDescripLarga.Clear;
    txtFechaCap.Clear;
    txtProvNum1.Value := 0;
    txtProveedor1.Clear;
    txtUltimoCos.Value := 0;
    txtIva.Value:=0;
end;

procedure TfrmGastos.ActivaControles;
begin
    if( (sModo = 'Insertar') or (sModo = 'Modificar') ) then begin
        tabBusqueda.TabVisible := false;

        Colores(clWindowText);

        btnInsertar.Enabled := false;
        btnModificar.Enabled := false;
        btnEliminar.Enabled := false;
        mnuInsertar.Enabled := false;
        mnuModificar.Enabled := false;
        mnuEliminar.Enabled := false;

        btnGuardar.Enabled := true;
        btnCancelar.Enabled := true;
        mnuGuardar.Enabled := true;
        mnuCancelar.Enabled := true;

        mnuConsulta.Enabled := false;
        mnuBusqueda.Enabled := false;

        tabBusqueda.Enabled := false;
        tabBusqueda.TabVisible := false;

        txtCodigo.ReadOnly := false;
        txtDescripCorta.ReadOnly := false;
        txtDescripLarga.ReadOnly := false;
        txtFechaCap.ReadOnly := true;
        txtFechComp.ReadOnly := true;
        txtRegistros.ReadOnly := false;
        txtProvNum1.ReadOnly := false;
        txtUltimoCos.ReadOnly := false;
        txtIva.ReadOnly:=false;

        txtCodigo.TabStop := true;
        txtDescripCorta.TabStop := true;
        txtDescripLarga.TabStop := true;
        txtFechaCap.TabStop := false;
        txtFechComp.TabStop := false;
        txtIva.TabStop:=True;

        txtRegistros.TabStop := false;
        txtProvNum1.TabStop := true;
        txtUltimoCos.TabStop := true;

        cmbCategorias.Enabled:=true;
        cmbEstatus.Enabled:=True;

     end;
     if(sModo = 'Consulta') then begin
        tabBusqueda.TabVisible := True;

        Colores(clBlue);

        btnInsertar.Enabled := True;
        btnModificar.Enabled := True;;
        btnEliminar.Enabled := True;
        mnuInsertar.Enabled := True;
        mnuModificar.Enabled  :=True;
        mnuEliminar.Enabled := True;

        btnGuardar.Enabled := false;
        btnCancelar.Enabled := false;
        mnuGuardar.Enabled := false;
        mnuCancelar.Enabled := false;

        mnuConsulta.Enabled := True;
        mnuBusqueda.Enabled := True;

        tabBusqueda.Enabled := True;

        if(Length(txtCodigo.Text) > 0) then begin
            btnModificar.Enabled := true;
            btnEliminar.Enabled := true;
            mnuModificar.Enabled := true;
            mnuEliminar.Enabled := true;
        end;

        txtCodigo.ReadOnly := True;
        txtDescripCorta.ReadOnly := True;
        txtDescripLarga.ReadOnly := True;
        txtRegistros.ReadOnly := True;
        txtFechaCap.ReadOnly := True;
        txtFechComp.ReadOnly := True;
        txtProvNum1.ReadOnly := True;
        txtUltimoCos.ReadOnly := True;
        txtIva.ReadOnly:=True;


        txtCodigo.TabStop := False;
        txtDescripCorta.TabStop :=False;
        txtDescripLarga.TabStop := False;
        txtRegistros.TabStop :=False;
        txtFechaCap.TabStop := False;
        txtFechComp.TabStop := False;
        txtProvNum1.TabStop := False;
        txtUltimoCos.TabStop := False;
        txtIva.TabStop:=False;

        cmbCategorias.Enabled:=False;
        cmbEstatus.Enabled:=False;
    end;
end;

procedure TfrmGastos.Colores(clColor : TColor);
begin
    txtCodigo.Font.Color := clColor;
    txtDescripCorta.Font.Color := clColor;
    txtDescripLarga.Font.Color := clColor;
    txtRegistros.Font.Color := clColor;
    txtFechComp.Font.Color := clColor;
    txtProvNum1.Font.Color := clColor;
    txtUltimoCos.Font.Color := clColor;
    txtIva.Font.Color:=clColor;
end;

procedure TfrmGastos.btnCancelarClick(Sender: TObject);
begin
    sModo := 'Consulta';
    LimpiaDatos;
    ActivaControles;
    pgeGeneral.ActivePage := tabBusqueda;
end;

procedure TfrmGastos.btnGuardarClick(Sender: TObject);
begin
    btnGuardar.SetFocus;
    if(VerificaDatos) then begin
        GuardaDatos;
        sModo := 'Consulta';
        ActivaControles;
        btnBuscar.Click;
        btnInsertar.SetFocus;
    end;
end;

procedure TfrmGastos.GuardaDatos;
var
    sDescAuto, sFecha,sCateg, sDeptos, sTipo, sProv1, sProv2, sEstatus: String;
begin

    sFecha := FormatDateTime('mm/dd/yyyy hh:nn:ss',Now);
    sDescAuto:='N';
    sDeptos := 'null';

    if(cmbCategorias.ItemIndex <> -1) then
        sCateg := IntToStr(Clavecarga(cmbCategorias.Items.Strings[cmbCategorias.ItemIndex],'C'))
    else
        sCateg := 'null';

    if(txtProvNum1.value <> 0) then
        sProv1 := FloatToStr(txtProvNum1.value)
    else
        sProv1 := 'null';

    sProv2 :='null';
    sTipo := '4';
    if  (cmbEstatus.ItemIndex = 0)then
        sEstatus := 'A'
    else
        sEstatus := 'I';

    with dmDatos.qryModifica do begin
        if(sModo = 'Insertar') then begin
            Close;
            SQL.Clear;
            SQL.Add('INSERT INTO articulos (desc_corta,desc_larga, precio1,');
            SQL.Add('precio2, precio3, precio4, ult_costo, costoprom, desc_auto,');
            SQL.Add('existencia, minimo, maximo, categoria, departamento, tipo,');
            SQL.Add('proveedor1, proveedor2, iva, fecha_cap, fecha_umov,');
            SQL.Add('estatus) VALUES(');
            SQL.Add('''' + txtDescripCorta.Text + ''',''' + txtDescripLarga.text + ''',' + '0,');
            SQL.Add('0,0,0,'+ FloatToStr(txtUltimoCos.value) + ',0,' +'''' + sDescAuto+''',');
            SQL.Add('0,0,0,'+ sCateg + ',' + sDeptos + ',' + sTipo + ',');
            SQL.Add(sProv1 + ',' + sProv2 + ',' + FloatToStr(txtIva.Value) + ',');
            SQL.Add('''' + sFecha + ''',''' + sFecha + ''',''' + sEstatus + ''')');
            ExecSQL;

            Close;
            SQL.Clear;
            SQL.Add('SELECT clave FROM articulos WHERE desc_larga = ''' + txtDescripLarga.Text + '''');
            Open;
            iClave := FieldByName('clave').AsInteger;

            Close;
         end
         else begin
            Close;
            SQL.Clear;
            SQL.Add('UPDATE articulos SET ');
            SQL.Add('DESC_CORTA = ''' + txtDescripCorta.Text + ''',');
            SQL.Add('DESC_LARGA = ''' + txtDescripLarga.Text + ''',');
            SQL.Add('ULT_COSTO = ' + FloatToStr(txtUltimoCos.Value) + ',');
            SQL.Add('CATEGORIA = ' + sCateg + ',');
            SQL.Add('TIPO = '+ sTipo + ',');
            SQL.Add('PROVEEDOR1 = ' + sProv1 + ',');
            SQL.Add('IVA = ' + FloatToStr(txtIva.Value)+',');
            SQL.Add('ESTATUS = ''' + sEstatus+'''');
            SQL.Add('WHERE clave = ' + IntToStr(iClave));
            ExecSQL;

            // Elimina los codigos por si existe alguna modificación en alguno de ellos
            Close;
            SQL.Clear;
            SQL.Add('DELETE FROM codigos WHERE articulo = ' + IntToStr(iClave));
            ExecSQL;
        end;

        // Inserta el codigo principal
        Close;
        SQL.Clear;
        SQL.Add('INSERT INTO codigos (articulo, codigo, tipo) VALUES(');
        SQL.Add(IntToStr(iClave) + ',''' + txtCodigo.Text + ''',''P'')');
        ExecSQL;


    end;
end;

function TfrmGastos.VerificaDatos:boolean;
var
    bVerifica : Boolean;
begin
    bVerifica := True;
    if(Length(Trim(txtCodigo.Text)) = 0) then begin
        Application.MessageBox('Introduce el código del gasto','Error',[smbOK],smsCritical);
        txtCodigo.SetFocus;
        bVerifica := False;
    end
    else if(not VerificaCodigo) then begin
        Application.MessageBox('El código especificado ya existe','Error',[smbOK],smsCritical);
        txtCodigo.SetFocus;
        bVerifica := False;
    end
    else if(Length(txtDescripCorta.Text) = 0) then begin
        Application.MessageBox('Introduce la descripción corta','Error',[smbOK],smsCritical);
        txtDescripCorta.SetFocus;
        bVerifica := False;
    end
    else if(Length(txtDescripLarga.Text) = 0) then begin
        Application.MessageBox('Introduce la descripción larga','Error',[smbOK],smsCritical);
        txtDescripLarga.SetFocus;
        bVerifica := False;
    end

    else if (txtProvNum1.Value > 0) and (Length(txtProveedor1.Text) = 0) then begin
        Application.MessageBox('Introduce un proveedor válido','Error',[smbOK],smsCritical);
        pgeDatos.ActivePage := tabOrganiza;
        txtProvNum1.SetFocus;
        bVerifica := False;
    end;
    Result := bVerifica;
end;

procedure TfrmGastos.RecuperaDatos;
begin
    with dmDatos.qryConsulta do begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT nombre FROM categorias WHERE tipo = ''G'' ORDER BY nombre');
        Open;
        cmbCategorias.Items.Clear;
        while (not Eof) do begin
            cmbCategorias.Items.Add(Trim(FieldByName('nombre').AsString));
            Next;
        end;
        Close;
    end;
end;

function TfrmGastos.ClaveCarga(sBusqueda:string; sConsulta:string):Integer;
begin
        with dmDatos.qryModifica do begin
             Close;
             SQL.Clear;
             if (sConsulta = 'C') then Begin
                SQL.Add('SELECT clave FROM categorias WHERE nombre = ''' + sBusqueda + '''');
                SQL.Add('AND tipo = ''G''');
                Open;
             end;
             Result := FieldByName('clave').AsInteger;
             Close;
        end;
end;

procedure TfrmGastos.BuscaProveedor(Sender: TObject);
begin
    with dmDatos.qryModifica do begin
        if(Length((Sender as TEdit).Text) > 0) then begin
           Close;
           SQL.Clear;
           SQL.Add('SELECT nombre FROM proveedores WHERE clave = ' + (Sender as TEdit).Text);
           Open;

           if((Sender as TEdit).Name = 'txtProvNum1') then
               txtProveedor1.Text := Trim(FieldByName('nombre').AsString)
           else if((Sender as TEdit).Name = 'txtProvClave') then
               txtProvDesc.Text := Trim(FieldByName('nombre').AsString);
           Close;
        end;
    end;
end;

procedure TfrmGastos.FormShow(Sender: TObject);
begin
    rdgBuscarClick(rdgBuscar);
    VerificaCategs;
    VerificaDeptos;

    LimpiaDatos;
    sModo := 'Consulta';
    ActivaControles;
    ActivaBuscar;
    pgeGeneral.ActivePage := tabBusqueda;
    RecuperaDatos;
    cmbCategorias.ItemIndex := 0;

    btnBuscarClick(Sender);
end;

procedure TfrmGastos.txtProvNum1Change(Sender: TObject);
begin
   BuscaProveedor(Sender);
end;

procedure TfrmGastos.txtProvNum2Change(Sender: TObject);
begin
    BuscaProveedor(Sender);
end;

procedure TfrmGastos.btnBuscarClick(Sender: TObject);
var
    sBM : String;
begin
    if(pgeGeneral.ActivePage = tabBusqueda) then
        btnBuscar.SetFocus;

    with dmDatos.qryArticulos do begin
        sBM := dmDatos.cdsArticulos.Bookmark;

        Close;
        SQL.Clear;
        dmDatos.cdsArticulos.Active := false;

        SQL.Add('SELECT a.clave, a.tipo, o.codigo, a.desc_larga, a.desc_corta');
        SQL.Add('FROM articulos a LEFT JOIN codigos o');
        SQL.Add('ON (a.clave = o.articulo AND o.tipo = ''P'') WHERE 1 = 1 and a.tipo=4');

        case rdgBuscar.ItemIndex of
                0:  SQL.Add('AND a.clave IN (SELECT articulo FROM codigos WHERE codigo STARTING ''' + txtCodigoBusq.Text + ''')');
                1:  SQL.Add('AND a.desc_larga LIKE ''%' + txtDescCortaBusq.Text + '%''');
                2:  if(txtProvClave.Value > 0) then
                        SQL.Add('AND (a.proveedor1 = ' + FloatToStr(txtProvClave.Value) + ' OR a.proveedor2 = ' + FloatToStr(txtProvClave.Value) + ')');
        end;

        case rdgOrden.ItemIndex of
            0: SQL.Add('ORDER BY o.codigo');
            1: SQL.Add('ORDER BY a.desc_larga');
            2: SQL.Add('ORDER BY a.proveedor1, a.proveedor2, o.codigo');
        end;

        Open;
        dmDatos.cdsArticulos.Active := true;

        dmDatos.cdsArticulos.FieldByName('clave').Visible := False;
        dmDatos.cdsArticulos.FieldByName('tipo').Visible := False;
        dmDatos.cdsArticulos.FieldByName('codigo').DisplayLabel := 'Código';
        dmDatos.cdsArticulos.FieldByName('desc_corta').DisplayWidth := 25;
        dmDatos.cdsArticulos.FieldByName('desc_larga').DisplayWidth := 35;
        dmDatos.cdsArticulos.FieldByName('desc_corta').DisplayLabel := 'Descripción corta';
        dmDatos.cdsArticulos.FieldByName('desc_larga').DisplayLabel := 'Descripción larga';

        txtRegistros.Value := dmDatos.cdsArticulos.RecordCount;
        try
            dmDatos.cdsArticulos.Bookmark := sBM;
        except
            txtRegistros.Value := txtRegistros.Value;
        end;

        if(pgeGeneral.ActivePage = tabBusqueda) then
            grdListado.SetFocus;
    end;
end;


procedure TfrmGastos.rdgBuscarClick(Sender: TObject);
begin
    pnlCodigo.Visible := false;
    pnlCodigo.Enabled := false;
    pnlDescCorta.Visible := false;
    pnlDescCorta.Enabled := false;
    pnlProveedor.Visible := false;
    pnlProveedor.Enabled := false;
    case rdgBuscar.ItemIndex of
        0: begin
            pnlCodigo.Visible := true;
            pnlCodigo.Enabled := true;
            if(pgeGeneral.ActivePage = tabBusqueda) then
                txtCodigoBusq.SetFocus;
           end;
        1: begin
            pnlDescCorta.Visible := true;
            pnlDescCorta.Enabled := true;
            if(pgeGeneral.ActivePage = tabBusqueda) then
                txtDescCortaBusq.SetFocus;
           end;
        2: begin
            pnlProveedor.Visible := true;
            pnlProveedor.Enabled := true;
            if(pgeGeneral.ActivePage = tabBusqueda) then
                txtProvClave.SetFocus;
           end;
    end;

end;

procedure TfrmGastos.RecuperaDatosBusq;
var
    sCateg, sDeptos: String;
begin
    iClave := dmDatos.cdsArticulos.FieldByName('Clave').AsInteger;

    with dmDatos.qryConsulta do begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT o.codigo, a.desc_corta, a.desc_larga, a.precio1,');
        SQL.Add('a.existencia, a.clave, a.precio2, a.precio3, a.precio4, a.ult_costo,');
        SQL.Add('a.desc_auto, a.minimo, a.maximo, a.categoria, a.departamento,');
        SQL.Add('a.tipo, a.proveedor1, a.proveedor2, a.iva, a.fecha_cap, a.fecha_umov,');
        SQL.Add('a.ultcompra, a.ultventa, a.estatus, c.nombre AS categorias,');
        SQL.Add('d.nombre AS departamentos FROM articulos a ');
        SQL.Add('LEFT JOIN codigos o ON a.clave = o.articulo AND o.tipo = ''P''');
        SQL.Add('LEFT JOIN categorias c ON a.categoria = c.clave ');
        SQL.Add('LEFT JOIN departamentos d ON a.departamento = d.clave ');
        SQL.Add('WHERE a.clave = ' + IntToStr(iClave));
        Open;
        if(not Eof) then begin
            pgeGeneral.ActivePage := tabDatos;
            txtCodigo.Text := Trim(FieldByName('codigo').AsString);
            txtDescripCorta.Text := Trim(FieldByName('desc_corta').AsString);
            txtDescripLarga.Text := Trim(FieldByName('desc_larga').AsString);
            txtFechaCap.Text := FormatDateTime('dd/mm/yyyy',FieldByName('fecha_cap').AsDateTime);
            txtProvNum1.Value := FieldByName('proveedor1').AsInteger;

            txtUltimoCos.Value := FieldByName('ult_costo').AsFloat;
            txtIva.Value := FieldByName('iva').AsFloat;

            if FieldByName('estatus').AsString ='A' then
                cmbEstatus.ItemIndex := 0
            else
                cmbEstatus.ItemIndex := 1;
            sDeptos := BuscaNombre(FieldByName('departamento').AsInteger, 'departamentos');
            sCateg := BuscaNombre(FieldByName('categoria').AsInteger, 'categorias');
            cmbCategorias.ItemIndex := cmbCategorias.Items.IndexOf(Trim(sCateg));

        end;
    end;
end;

procedure TfrmGastos.btnModificarClick(Sender: TObject);
begin
    sModo := 'Modificar';
    if (pgeGeneral.ActivePage = tabBusqueda) then
         RecuperaDatosBusq;
    ActivaControles;
    txtCodigo.SetFocus;
end;


procedure TfrmGastos.btnLimpiarClick(Sender: TObject);
begin
    txtCodigoBusq.Clear;
    txtDescCortaBusq.Clear;
    txtProvClave.Value:=0;
end;

procedure TfrmGastos.ActivaBuscar;
begin
    if(pgeGeneral.ActivePage <> tabBusqueda) then begin
        mnuBuscar.Enabled := false;
        mnuLimpiar.Enabled := false;
        mnuSeleccionar.Enabled := false;
    end
    else begin
        mnuBuscar.Enabled := true;
        mnuLimpiar.Enabled := true;
        mnuSeleccionar.Enabled := true;
    end;
end;

procedure TfrmGastos.grdJuegoDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var
    sCad : String;
    i : real;
begin
    sCad := (Sender as TStringGrid).Cells[ACol,ARow];
    if(Length(sCad) > 0) then begin
        if(ARow = 0) then begin
            i := Rect.Left + (Rect.Right - Rect.Left) / 2 - (Sender as TStringGrid).Canvas.TextWidth(sCad) / 2;
            (Sender as TStringGrid).Canvas.FillRect(Rect);
            (Sender as TStringGrid).Canvas.TextOut(Round(i),Rect.Top+2,sCad);
        end;
        if(ACol = 2) and (ARow > 0) then begin
            sCad := FormatFloat('#,##0.000',StrToFloat(sCad));
            i := Rect.Right-(Sender as TStringGrid).Canvas.TextWidth(sCad+' ');
            (Sender as TStringGrid).Canvas.FillRect(Rect);
            (Sender as TStringGrid).Canvas.TextOut(Round(i),Rect.Top+2,sCad);
        end;
        if(ACol = 3) and (ARow > 0) then begin
            sCad := FormatFloat('#,##0.00',StrToFloat(sCad));
            i := Rect.Right-(Sender as TStringGrid).Canvas.TextWidth(sCad+' ');
            (Sender as TStringGrid).Canvas.FillRect(Rect);
            (Sender as TStringGrid).Canvas.TextOut(Round(i),Rect.Top+2,sCad);
        end;
    end;
end;

procedure TfrmGastos.mnuOrganizacionClick(Sender: TObject);
begin
    pgeDatos.ActivePage := tabOrganiza;
    ActivaBuscar;
end;


procedure TfrmGastos.mnuProvedClick(Sender: TObject);
begin
    pgeGeneral.ActivePage := tabDatos;
    ActivaBuscar;
end;

procedure TfrmGastos.mnuBusquedaClick(Sender: TObject);
begin
    pgeGeneral.ActivePage := tabBusqueda;
    ActivaBuscar;
end;

procedure TfrmGastos.mnuAvanzaClick(Sender: TObject);
begin
    with dmDatos.cdsArticulos do begin
        if(Active) then begin
            Next;
            if(pgeGeneral.ActivePage <> tabBusqueda) then begin
                RecuperaDatosBusq;
                ActivaControles;
            end;
        end;
    end;
end;

procedure TfrmGastos.mnuRetrocedeClick(Sender: TObject);
begin
    with dmDatos.cdsArticulos do begin
        if(Active) then begin
            Prior;
            if(pgeGeneral.ActivePage <> tabBusqueda) then begin
                RecuperaDatosBusq;
                ActivaControles;
            end;
        end;
    end;
end;


procedure TfrmGastos.btnEliminarClick(Sender: TObject);
begin
    if (pgeGeneral.ActivePage = tabBusqueda) then
        RecuperaDatosBusq;

    pgeGeneral.ActivePage := tabDatos;
    if(Application.MessageBox('Se eliminará el registro seleccionado','Eliminar',[smbOK]+[smbCancel],smsWarning) = smbOK) then begin
        with dmDatos.qryModifica do begin
            Close;
            SQL.Clear;
            SQL.Add('DELETE FROM articulos WHERE clave = ' + IntToStr(iClave));
            ExecSQL;
            Close;
            LimpiaDatos;
            sModo := 'Consulta';
            ActivaControles;
            btnBuscar.Click;
            pgeGeneral.ActivePage := tabBusqueda;
            ActivaBuscar;
        end;
    end;
end;

procedure TfrmGastos.RecuperaConfig;
var
    iniArchivo : TIniFile;
    sIzq, sArriba, sValor : String;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'config.ini');

    with iniArchivo do begin
        //Recupera la posición Y de la ventana
        sArriba := ReadString('Gastos', 'Posy', '');

        //Recupera la posición X de la ventana
        sIzq := ReadString('Gastos', 'Posx', '');

        if (Length(sIzq) > 0) and (Length(sArriba) > 0) then begin
            Left := StrToInt(sIzq);
            Top := StrToInt(sArriba);
        end;

        //Recupera el valor de los botones de radio de buscar
        sValor := ReadString('Gastos', 'Buscar', '');
        if (Length(sValor) > 0) then
            rdgBuscar.ItemIndex := StrToInt(sValor);

        //Recupera el valor de los botones de radio de orden
        sValor := ReadString('Gastos', 'Orden', '');
        if (Length(sValor) > 0) then
            rdgOrden.ItemIndex := StrToInt(sValor);

        //Recupera la {ultima ficha que se seleccionó
        sValor := ReadString('Gastos', 'Ficha', '');
        if (Length(sValor) > 0) then
            pgeDatos.ActivePageIndex := StrToInt(sValor);
        
        sValor := ReadString('Gastos', 'Ficha2', '');
        if (Length(sValor) > 0) then
            pgeGeneral.ActivePageIndex := StrToInt(sValor);
        Free;

    end;

    with dmDatos.qryModifica do begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT letraencodigo FROM config');
        Open;
        if( FieldByName('letraencodigo').AsString = 'S' ) then
            bLetras := true
        else
            bLetras := false;
        Close;
    end;

end;

procedure TfrmGastos.FormClose(Sender: TObject;
   var Action: TCloseAction);
var
    iniArchivo : TIniFile;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'config.ini');
    with iniArchivo do begin
        // Registra la posición y de la ventana
        WriteString('Gastos', 'Posy', IntToStr(Top));

        // Registra la posición X de la ventana
        WriteString('Gastos', 'Posx', IntToStr(Left));

        //Registra el valor de los botones de radio de buscar
        WriteString('Gastos', 'Buscar', IntToStr(rdgBuscar.ItemIndex));

        //Registra el valor de los botones de radio de orden
        WriteString('Gastos', 'Orden', IntToStr(rdgOrden.ItemIndex));

        //Registra la ultima ficha que se seleccionó
        WriteString('Gastos', 'Ficha', IntToStr(pgeDatos.ActivePageIndex));

        //Registra la ultima ficha que se seleccionó
        WriteString('Gastos', 'Ficha2', IntToStr(pgeGeneral.ActivePageIndex));
        Free;
    end;
    dmDatos.qryArticulos.Close;
    dmDatos.cdsArticulos.Active := false;
end;

procedure TfrmGastos.grdListadoDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
    case dmDatos.cdsArticulos.FieldByName('tipo').AsInteger of
        0:grdListado.Canvas.Brush.Color := $0094E7ED;
        1:grdListado.Canvas.Brush.Color := $0099A7F7;
        2:grdListado.Canvas.Brush.Color := $00DCBFA5;
        3:grdListado.Canvas.Brush.Color := $00BFCAB7;
    end;
    grdListado.Canvas.FillRect(Rect);
    grdListado.DefaultDrawColumnCell(Rect,DataCol,Column,State);
end;

procedure TfrmGastos.Buscarproveedor1Click(Sender: TObject);
begin
    with TFrmProveedBusq.Create(Self) do
    try
        if(txtProvNum1.Focused)and (txtProvNum1.Font.Color=clWindowText) then begin
            if(ShowModal = mrOk) then
                txtProvNum1.Text := sClave;
            txtProvNum1.SetFocus;
        end
        else if(txtProvClave.Focused) then begin
            if(ShowModal = mrOk) then
                txtProvClave.Text := sClave;
            txtProvClave.SetFocus;
        end;
    finally
        Free;
    end;
end;

procedure TfrmGastos.VerificaCategs;
begin
    with dmDatos.qryModifica do begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT * FROM categorias WHERE tipo = ''A''');
        Open;

        if(Eof) then begin
            Close;
            SQL.Clear;
            SQL.Add('INSERT INTO categorias (nombre, tipo, cuenta, fecha_umov) VALUES');
            SQL.Add('(''DEFAULT'',''G'','''',''' + FormatDateTime('mm/dd/yyyy',Date) + ''')');
            ExecSQL;
        end;
        Close;
    end;
end;

procedure TfrmGastos.VerificaDeptos;
begin
    with dmDatos.qryModifica do begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT * FROM departamentos');
        Open;

        if(Eof) then begin
            Close;
            SQL.Clear;
            SQL.Add('INSERT INTO departamentos (clave, nombre, fecha_umov) VALUES');
            SQL.Add('(1,''DEFAULT'',''' + FormatDateTime('mm/dd/yyyy',Date) + ''')');
            ExecSQL;
        end;
        Close;
    end;
end;

procedure TfrmGastos.grdListadoDblClick(Sender: TObject);
begin
    pgeGeneral.ActivePage := tabDatos;
    LimpiaDatos;
    RecuperaDatosBusq;
    ActivaBuscar;
    ActivaControles;
end;

procedure TfrmGastos.grdListadoEnter(Sender: TObject);
begin
    btnSeleccionar.Default := true;
    btnBuscar.Default := false;
end;

procedure TfrmGastos.grdListadoExit(Sender: TObject);
begin
    btnBuscar.Default := true;
    btnSeleccionar.Default := false;
end;

procedure TfrmGastos.btnSeleccionarClick(Sender: TObject);
begin
    if (txtRegistros.Value > 0) then begin
        RecuperaDatosBusq;
        ActivaBuscar;
        ActivaControles;
    end;
end;

procedure TfrmGastos.Salir1Click(Sender: TObject);
begin
    Close;
end;

procedure TfrmGastos.Salta(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
    {Inicio (36), Fin (35), Izquierda (37), derecha (39), arriba (38), abajo (40)}
    if(Key >= 30) and (Key <= 122) and (Key <> 35) and (Key <> 36) and not ((Key >= 37) and (Key <= 40)) then
        if( Length((Sender as TEdit).Text) = (Sender as TEdit).MaxLength) then
            SelectNext(Sender as TWidgetControl, true, true);
end;

procedure TfrmGastos.txtCodigoKeyPress(Sender: TObject; var Key: Char);
begin
    if(not bLetras) then
        if not (Key in ['0'..'9',#8,#9,#13,#46]) then
            Key := #0;
end;

procedure TfrmGastos.pgeGeneralPageChanging(Sender: TObject;
  NewPage: TTabSheet; var AllowChange: Boolean);
begin
    ActivaBuscar;
end;

procedure TfrmGastos.pgeGeneralChange(Sender: TObject);
begin
    ActivaBuscar;
end;

procedure TfrmGastos.CargaMovimientos;
begin
    with dmDatos.qryConsulta do begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT a.ultcompra, a.ultventa, a.estatus, ');
        SQL.Add('c.fecha AS cfecha, c.proveedor, p.nombre AS nomproveedor,');
        SQL.Add('v.fecha AS vfecha, v.hora, v.cliente, cli.nombre AS nomcliente');
        SQL.Add('FROM articulos a ');
        SQL.Add('LEFT JOIN compras c ON a.ultcompra = c.clave ');
        SQL.Add('LEFT JOIN ventas v ON a.ultventa = v.clave ');
        SQL.Add('LEFT JOIN proveedores p ON c.proveedor = p.clave ');
        SQL.Add('LEFT JOIN clientes cli ON v.cliente = cli.clave ');
        SQL.Add('WHERE a.clave = ' + IntToStr(iClave));
        Open;
        if(not Eof) then begin
            if(Length(FieldByName('cfecha').AsString) > 0) then
                txtFechComp.Text := FormatDateTime('dd/mm/yyyy',FieldByName('cfecha').AsDateTime)
            else
                txtFechComp.Clear;
            end;
        Close;
    end;
end;

function TfrmGastos.BuscaNombre(iValor:Integer; sTabla:string):String;
begin
     with dmDatos.qryModifica do begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT nombre FROM ' + sTabla + ' WHERE clave = ' + IntToStr(iValor));
        Open;
        Result := FieldByName('nombre').AsString;
        Close;
     end;
end;

procedure TfrmGastos.mnuMovimientosClick(Sender: TObject);
begin
    pgeDatos.ActivePage := tabMov;
    ActivaBuscar;
end;

procedure TfrmGastos.FormCreate(Sender: TObject);
begin
   RecuperaConfig;
end;

procedure TfrmGastos.txtProvClaveChange(Sender: TObject);
begin
    BuscaProveedor(Sender);
end;

function TfrmGastos.VerificaCodigo:boolean;
begin
    Result := true;

    if(Length(txtCodigo.Text) > 0) then begin
        with dmDatos.qryModifica do begin
            Close;
            SQL.Clear;
            SQL.Add('SELECT articulo FROM codigos WHERE codigo = ''' + txtCodigo.Text + '''');
            Open;

            if(not Eof) and ((sModo = 'Insertar') or ((FieldByName('articulo').AsInteger <> iClave) and
                     (sModo = 'Modificar'))) then begin
                Result := false;
            end;
            Close;
        end;
    end;
end;

end.

