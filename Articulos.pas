// --------------------------------------------------------------------------
// Archivo del Proyecto Ventas             
// P�gina del proyecto: http://sourceforge.net/projects/ventas
// --------------------------------------------------------------------------
// Este archivo puede ser distribuido y/o modificado bajo lo terminos de la
// Licencia P�blica General versi�n 2 como es publicada por la Free Software
// Fundation, Inc.
// --------------------------------------------------------------------------

unit Articulos;

interface

uses
  SysUtils, Types, Classes, QGraphics, QControls, QForms, QDialogs,
  QMenus, QTypes, QExtCtrls, QDBGrids, QStdCtrls, QButtons, QGrids,
  QcurrEdit, QComCtrls, IniFiles, Qt, StrUtils, DB,rpcompobase, rpclxreport;

type
  TfrmArticulos = class(TForm)
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
    Label8: TLabel;
    Label2: TLabel;
    cmbCategorias: TComboBox;
    cmbUnidades: TComboBox;
    cmbDeptos: TComboBox;
    grpProveedores: TGroupBox;
    txtProvNum1: TcurrEdit;
    txtProvNum2: TcurrEdit;
    Label6: TLabel;
    Label7: TLabel;
    txtProveedor1: TEdit;
    txtProveedor2: TEdit;
    tabPrecios: TTabSheet;
    grpPrecios: TGroupBox;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label13: TLabel;
    txtPrecio1: TcurrEdit;
    txtPrecio2: TcurrEdit;
    txtPrecio3: TcurrEdit;
    txtPrecio4: TcurrEdit;
    chkDescAuto: TCheckBox;
    grpCostos: TGroupBox;
    Label14: TLabel;
    txtUltimoCos: TcurrEdit;
    grpImpuesto: TGroupBox;
    Label16: TLabel;
    txtIva: TcurrEdit;
    tabAlmacen: TTabSheet;
    grpExistencia: TGroupBox;
    txtExis: TcurrEdit;
    Label17: TLabel;
    Label18: TLabel;
    txtMax: TcurrEdit;
    txtMin: TcurrEdit;
    Label19: TLabel;
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
    Domicilio1: TMenuItem;
    mnuCodigos: TMenuItem;
    mnuPrecios: TMenuItem;
    tabBusqueda: TTabSheet;
    tabJuego: TTabSheet;
    grdJuego: TStringGrid;
    grdListado: TDBGrid;
    rdgOrden: TRadioGroup;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    pnlAgranel: TPanel;
    pnlJuego: TPanel;
    pnlNoInventariable: TPanel;
    pnlNormal: TPanel;
    Label26: TLabel;
    txtRegistros: TcurrEdit;
    btnBuscar: TBitBtn;
    btnSeleccionar: TBitBtn;
    btnLimpiar: TBitBtn;
    mnuAlmacen: TMenuItem;
    tabMov: TTabSheet;
    grpUltCompra: TGroupBox;
    Label20: TLabel;
    Label21: TLabel;
    txtProv: TEdit;
    grpUltVenta: TGroupBox;
    Label31: TLabel;
    txtClient: TEdit;
    Label32: TLabel;
    txtFechComp: TEdit;
    txtFechVent: TEdit;
    mnuJuegos: TMenuItem;
    cmbEstatus: TComboBox;
    Buscarproveedor1: TMenuItem;
    N6: TMenuItem;
    Label33: TLabel;
    Label34: TLabel;
    txtFaltaMin: TcurrEdit;
    Label35: TLabel;
    txtFaltaMax: TcurrEdit;
    Label36: TLabel;
    txtSobregiro: TcurrEdit;
    tabCodigos: TTabSheet;
    grpCodigos: TGroupBox;
    grdCodigos: TStringGrid;
    mnuMovimientos: TMenuItem;
    txtTotalJuego: TcurrEdit;
    Label15: TLabel;
    grpBuscar: TGroupBox;
    txtProvClave: TcurrEdit;
    txtProvDesc: TEdit;
    txtDescripBusq: TEdit;
    cmbDeptoBusq: TComboBox;
    txtCodigoBusq: TEdit;
    cmbCategBusq: TComboBox;
    chkCodigo: TCheckBox;
    chkProv: TCheckBox;
    chkDescrip: TCheckBox;
    chkDepto: TCheckBox;
    chkCateg: TCheckBox;
    btnArticulos: TBitBtn;
    btnQuitar: TBitBtn;
    txtCostoJuego: TcurrEdit;
    Label27: TLabel;
    tabUtilidad: TTabSheet;
    grpUtilidad: TGroupBox;
    mnuUtilitad: TMenuItem;
    chkCantidad: TCheckBox;
    txtrango1: TcurrEdit;
    txtrango2: TcurrEdit;
    txtrango3: TcurrEdit;
    txtrango4: TcurrEdit;
    Label28: TLabel;
    memUtilidad: TMemo;
    ET1: TButton;
    rptReportes: TCLXReport;
    ET2: TButton;
    ET3: TButton;
    Label29: TLabel;
    txtPrecio5: TcurrEdit;
    txtrango5: TcurrEdit;
    Etiqueta: TLabel;
    e1: TEdit;
    e2: TEdit;
    e3: TEdit;
    e4: TEdit;
    e5: TEdit;
    Button1: TButton;
    GroupBox1: TGroupBox;
    Label30: TLabel;
    Label37: TLabel;
    factor: TcurrEdit;
    tipo: TEdit;
    kg: TCheckBox;
    FactordeVentas1: TMenuItem;
    procedure btnInsertarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnGuardarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure txtProvNum1Change(Sender: TObject);
    procedure btnBuscarClick(Sender: TObject);
    procedure btnModificarClick(Sender: TObject);
    procedure btnLimpiarClick(Sender: TObject);
    procedure grdJuegoDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure grdJuegoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure grdJuegoKeyPress(Sender: TObject; var Key: Char);
    procedure grdJuegoKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Domicilio1Click(Sender: TObject);
    procedure mnuCodigosClick(Sender: TObject);
    procedure mnuPreciosClick(Sender: TObject);
    procedure mnuProvedClick(Sender: TObject);
    procedure mnuBusquedaClick(Sender: TObject);
    procedure mnuAvanzaClick(Sender: TObject);
    procedure mnuRetrocedeClick(Sender: TObject);
    procedure mnuAlmacenClick(Sender: TObject);
    procedure btnEliminarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure mnuJuegosClick(Sender: TObject);
    procedure grdListadoDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure Buscarproveedor1Click(Sender: TObject);
    procedure grdListadoDblClick(Sender: TObject);
    procedure grdListadoEnter(Sender: TObject);
    procedure grdListadoExit(Sender: TObject);
    procedure btnSeleccionarClick(Sender: TObject);
    procedure Salir1Click(Sender: TObject);
    procedure txtExisExit(Sender: TObject);
    procedure txtMinExit(Sender: TObject);
    procedure txtMaxExit(Sender: TObject);
    procedure Salta(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure txtCodigoKeyPress(Sender: TObject; var Key: Char);
    procedure pgeGeneralPageChanging(Sender: TObject; NewPage: TTabSheet; var AllowChange: Boolean);
    procedure pgeGeneralChange(Sender: TObject);
    procedure CargaMovimientos;
    procedure FormCreate(Sender: TObject);
    procedure mnuMovimientosClick(Sender: TObject);
    procedure grdCodigosKeyPress(Sender: TObject; var Key: Char);
    procedure grdCodigosKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure chkCategClick(Sender: TObject);
    procedure chkCodigoClick(Sender: TObject);
    procedure chkDescripClick(Sender: TObject);
    procedure chkProvClick(Sender: TObject);
    procedure chkDeptoClick(Sender: TObject);
    procedure btnArticulosClick(Sender: TObject);
    procedure btnQuitarClick(Sender: TObject);
    procedure mnuUtilitadClick(Sender: TObject);
    procedure chkCantidadClick(Sender: TObject);
    procedure cmbUnidadesChange(Sender: TObject);
    procedure Label17DblClick(Sender: TObject);
    procedure ET1Click(Sender: TObject);
    procedure ET2Click(Sender: TObject);
    procedure ET3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FactordeVentas1Click(Sender: TObject);
    
  private
    sModo:    String;
    iClave:   Integer;
    bLetras:  Boolean;
    rMonedaMenor : real;

    procedure LimpiaDatos;
    procedure ActivaControles;
    procedure Colores(clColor : TColor);
    procedure RecuperaDatos;
    procedure GuardaDatos;
    function  VerificaDatos:boolean;
    procedure Maxmin;
    function  ClaveCarga(sBusqueda:String ; sConsulta:String):Integer;
    procedure BuscaProveedor(Sender: TObject);
    procedure RecuperaDatosBusq;
    procedure ActivaBuscar;
    procedure BuscaArticulo;
    procedure GuardaJuego;
    procedure ReduceJuego;
    procedure EliminaRenglon(iRenglon : Integer);
    procedure CargaJuego;
    procedure RecuperaConfig;
    function  VerificaJuego:Boolean;
    procedure VerificaCategs;
    procedure VerificaDeptos;
    procedure VerificaUnidades;
    function RecuperaTipo(sUnidade: string):String;
    function VerificaCodigo:boolean;
    function VerificaCodigos:boolean;
    function BuscaNombre(iValor:Integer; sTabla:string):String;
    procedure CargaCodigos;
    procedure VerificaTipos;
    procedure ConvierteComillas(Sender : TWidgetControl);
    function VerificaDescLarga:boolean;
    procedure SumaJuego;
  public

  end;

var
  frmArticulos: TfrmArticulos;

implementation

uses dm, ProveedBusq, ArticuloBusq, Autoriza;

{$R *.xfm}

procedure TfrmArticulos.btnInsertarClick(Sender: TObject);
begin
    pgeGeneral.ActivePage := tabDatos;
    sModo := 'Insertar';
    ActivaControles;
    LimpiaDatos;
    txtCodigo.SetFocus;
    txtFechaCap.Text := FormatDateTime('dd/mm/yyyy',Date);
    pgeGeneral.ActivePage := tabDatos;
    cmbEstatus.ItemIndex := 0 ;  //Estatus Activo
    if(cmbUnidades.ItemIndex = -1) then
        cmbUnidades.ItemIndex := 0;
    if(cmbCategorias.ItemIndex = -1) then
        cmbCategorias.ItemIndex := 0;
    if(cmbDeptos.ItemIndex = -1) then
        cmbDeptos.ItemIndex := 0;
    VerificaTipos;
end;

procedure TfrmArticulos.LimpiaDatos;
begin
    txtCodigo.Clear;
    txtDescripCorta.Clear;
    txtDescripLarga.Clear;
    txtFechaCap.Clear;
    txtProvNum1.Value := 0;
    txtProvNum2.Value := 0;
    txtProveedor1.Clear;
    txtProveedor2.Clear;
    memUtilidad.Clear;
    txtPrecio1.Value := 0;
    txtPrecio2.Value := 0;
    txtPrecio3.Value := 0;
    txtPrecio4.Value := 0;
    txtPrecio4.Value := 0;

    e1.Text:='';
    e2.Text:='';
    e3.Text:='';
    e4.Text:='';
    e5.Text:='';
    factor.Value:= 0;
    tipo.Text:='';
    kg.Checked := false;


    txtrango1.Value := 0;
    txtrango2.Value := 0;
    txtrango3.Value := 0;
    txtrango4.Value := 0;
    txtrango5.Value := 0;
    chkDescAuto.Checked := false;
    chkCantidad.Checked := true;
    txtIva.Value := 0;
    txtUltimoCos.Value := 0;

    txtExis.Value := 0;
    txtMin.Value := 0;
    txtMax.Value := 0;
    txtFaltaMax.Value  := 0;
    txtSobregiro.Value := 0;
    txtFaltaMin.Value  := 0;

    grdJuego.RowCount := 2;
    grdJuego.Cells[0,1] := '';
    grdJuego.Cells[1,1] := '';
    grdJuego.Cells[2,1] := '';
    grdJuego.Cells[3,1] := '';

    grdCodigos.RowCount := 2;
    grdCodigos.Cells[0,1] := '';

    cmbCategBusq.ItemIndex := -1;
    cmbDeptoBusq.ItemIndex := -1;
end;

procedure TfrmArticulos.ActivaControles;
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

        tabJuego.Enabled := false;
        tabJuego.TabVisible := false;
        tabBusqueda.Enabled := false;
        tabBusqueda.TabVisible := false;

        btnArticulos.Enabled := true;
        btnQuitar.Enabled := true;

        txtCodigo.ReadOnly := false;
        txtDescripCorta.ReadOnly := false;
        txtDescripLarga.ReadOnly := false;
        txtFechaCap.ReadOnly := true;
        txtFechComp.ReadOnly := true;
        txtFechVent.ReadOnly := true;
        txtRegistros.ReadOnly := false;
        txtProvNum1.ReadOnly := false;
        txtProvNum2.ReadOnly := false;
        txtPrecio1.ReadOnly := false;
        txtPrecio2.ReadOnly := false;
        txtPrecio3.ReadOnly := false;
        txtPrecio4.ReadOnly := false;
        txtPrecio5.ReadOnly := false;

        txtrango1.ReadOnly := false;
        txtrango2.ReadOnly := false;
        txtrango3.ReadOnly := false;
        txtrango4.ReadOnly := false;
        txtrango5.ReadOnly := false;

        e1.ReadOnly := false;
        e2.ReadOnly := false;
        e3.ReadOnly := false;
        e4.ReadOnly := false;
        e5.ReadOnly := false;

        factor.ReadOnly := false;
    tipo.ReadOnly := false;
    kg.Enabled := true;

      if(sModo = 'Modificar') then
       txtExis.ReadOnly := true

        else
       txtExis.ReadOnly := true;

        txtMax.ReadOnly := false;
        txtmin.ReadOnly := false;
        txtUltimoCos.ReadOnly := false;
        txtIva.ReadOnly := false;
        memUtilidad.ReadOnly := false;

        txtCodigo.TabStop := true;
        txtDescripCorta.TabStop := true;
        txtDescripLarga.TabStop := true;
        txtFechaCap.TabStop := false;
        txtFechComp.TabStop := false;
        txtFechVent.TabStop := false;
        txtRegistros.TabStop := false;
        txtProvNum1.TabStop := true;
        txtProvNum2.TabStop := true;
        txtPrecio1.TabStop := true;
        txtPrecio2.TabStop := true;
        txtPrecio3.TabStop := true;
        txtPrecio4.TabStop := true;
        txtPrecio5.TabStop := true;

        txtrango1.TabStop := true;
        txtrango2.TabStop := true;
        txtrango3.TabStop := true;
        txtrango4.TabStop := true;
        txtrango5.TabStop := true;

        e1.TabStop  := true;
        e2.TabStop  := true;
        e3.TabStop  := true;
        e4.TabStop  := true;
        e5.TabStop  := true;

         factor.TabStop  := true;
    tipo.TabStop  := true;
    kg.Enabled := true;


        chkDescAuto.Enabled := true;

        if(sModo = 'Modificar') then
            txtExis.TabStop := false
        else
            txtExis.TabStop := true;

        txtMax.TabStop := true;
        txtMin.TabStop := true;
        txtUltimoCos.TabStop := true;
        txtIva.TabStop := true;
        memUtilidad.TabStop := true;

        cmbCategorias.Enabled:=true;
        cmbUnidades.Enabled:=true;
        cmbEstatus.Enabled:=True;
        cmbDeptos.Enabled:=True;

        chkCantidad.Enabled := True;

        grdJuego.Options := [goFixedVertLine,goFixedHorzLine,goVertLine,goHorzLine,goEditing,goAlwaysShowEditor,goTabs];
        grdJuego.Font.Color := clWindowText;
        grdCodigos.Options := [goFixedVertLine,goFixedHorzLine,goVertLine,goHorzLine,goEditing,goTabs];
        grdCodigos.Font.Color := clWindowText;

       

     end;
     if(sModo = 'Consulta') then begin
        tabBusqueda.TabVisible := True;

        Colores(clBlue);

        btnInsertar.Enabled := True;
        mnuInsertar.Enabled := True;
        btnModificar.Enabled := true;
        btnEliminar.Enabled := true;
        mnuModificar.Enabled := true;
        mnuEliminar.Enabled := true;

        btnGuardar.Enabled := false;
        btnCancelar.Enabled := false;
        mnuGuardar.Enabled := false;
        mnuCancelar.Enabled := false;

        btnArticulos.Enabled := false;
        btnQuitar.Enabled := false;

        mnuConsulta.Enabled := True;
        mnuBusqueda.Enabled := True;

        tabBusqueda.Enabled := True;

        txtCodigo.ReadOnly := True;
        txtDescripCorta.ReadOnly := True;
        txtDescripLarga.ReadOnly := True;
        txtRegistros.ReadOnly := True;
        txtFechaCap.ReadOnly := True;
        txtFechComp.ReadOnly := True;
        txtFechVent.ReadOnly := True;
        txtProvNum1.ReadOnly := True;
        txtProvNum2.ReadOnly := True;
        txtPrecio1.ReadOnly := True;
        txtPrecio2.ReadOnly := True;
        txtPrecio3.ReadOnly := True;
        txtPrecio4.ReadOnly := True;
        txtPrecio5.ReadOnly := True;

        txtrango1.ReadOnly := True;
        txtrango2.ReadOnly := True;
        txtrango3.ReadOnly := True;
        txtrango4.ReadOnly := True;
        txtrango5.ReadOnly := True;
        e1.ReadOnly := True;
        e2.ReadOnly := True;
        e3.ReadOnly := True;
        e4.ReadOnly := True;
        e5.ReadOnly := True;

         factor.ReadOnly := True;

     tipo.ReadOnly := True;
     kg.Enabled := false;


        txtExis.ReadOnly := True;
        txtMax.ReadOnly := True;
        txtMin.ReadOnly := True;
        txtUltimoCos.ReadOnly := true;
        txtIva.ReadOnly  := true;
        memUtilidad.ReadOnly := true;

        txtCodigo.TabStop := False;
        txtDescripCorta.TabStop :=False;
        txtDescripLarga.TabStop := False;
        txtRegistros.TabStop :=False;
        txtFechaCap.TabStop := False;
        txtFechComp.TabStop := False;
        txtFechVent.TabStop := False;
        txtProvNum1.TabStop := False;
        txtProvNum2.TabStop := False;
        txtPrecio1.TabStop := False;
        txtPrecio2.TabStop := False;
        txtPrecio3.TabStop := False;
        txtPrecio4.TabStop := False;
        txtPrecio5.TabStop := False;

        txtrango1.TabStop := False;
        txtrango2.TabStop := False;
        txtrango3.TabStop := False;
        txtrango4.TabStop := False;
        txtrango5.TabStop := False;
        e1.TabStop := False;
        e2.TabStop := False;
        e3.TabStop := False;
        e4.TabStop := False;
        e5.TabStop := False;

           factor.TabStop := False;
            tipo.TabStop := False;

        chkDescAuto.Enabled := false;
        txtExis.TabStop := False;
        txtMax.TabStop := False;
        txtMin.TabStop := False;
        txtUltimoCos.TabStop := False;
        txtIva.TabStop := False;
        memUtilidad.TabStop := False;

        cmbCategorias.Enabled:=False;
        cmbUnidades.Enabled:=False;
        cmbEstatus.Enabled:=False;
        cmbDeptos.Enabled:=False;
        chkCantidad.Enabled := False;

        grdJuego.Options := [goFixedVertLine,goFixedHorzLine,goVertLine,goHorzLine,goTabs];
        grdJuego.Font.Color := clBlue;
        grdCodigos.Options := [goFixedVertLine,goFixedHorzLine,goVertLine,goHorzLine,goTabs];
        grdCodigos.Font.Color := clBlue;
    end;
end;

procedure TfrmArticulos.Colores(clColor : TColor);
begin
    txtCodigo.Font.Color := clColor;
    txtDescripCorta.Font.Color := clColor;
    txtDescripLarga.Font.Color := clColor;
    txtRegistros.Font.Color := clColor;
    txtFechVent.Font.Color := clColor;
    txtFechComp.Font.Color := clColor;
    txtProvNum1.Font.Color := clColor;
    txtProvNum2.Font.Color := clColor;
    txtPrecio1.Font.Color := clColor;
    txtPrecio2.Font.Color := clColor;
    txtPrecio3.Font.Color := clColor;
    txtPrecio4.Font.Color := clColor;
     txtPrecio5.Font.Color := clColor;

    txtrango1.Font.Color := clColor;
    txtrango2.Font.Color := clColor;
    txtrango3.Font.Color := clColor;
    txtrango4.Font.Color := clColor;
    txtrango5.Font.Color := clColor;

    e1.Font.Color:= clColor;
    e2.Font.Color:= clColor;
    e3.Font.Color:= clColor;
    e4.Font.Color:= clColor;
    e5.Font.Color:= clColor;



    txtExis.Font.Color := clColor;
    txtMax.Font.Color := clColor;
    txtMin.Font.Color := clColor;
    txtUltimoCos.Font.Color := clColor;
    txtIva.Font.Color := clColor;
    memUtilidad.Font.Color := clColor;
end;

procedure TfrmArticulos.btnCancelarClick(Sender: TObject);
begin
    sModo := 'Consulta';
    LimpiaDatos;
    ActivaControles;
    pgeGeneral.ActivePage := tabBusqueda;
end;

procedure TfrmArticulos.btnGuardarClick(Sender: TObject);
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

procedure TfrmArticulos.GuardaDatos;
var
    sDescAuto, sFecha, sUnidade, sCateg, sDeptos, sTipo, sProv1, sProv2, sCantidad_Cnt, sEstatus, ifiscal: String;
    i : integer;
    sifiscal:boolean;
    kgf: integer;

begin

    sFecha := FormatDateTime('mm/dd/yyyy hh:nn:ss',Now);

      if (kg.Checked=True) then
        kgf:=1
    else
        kgf:=0;

    if (chkDescAuto.Checked=True) then
        sDescAuto:='S'
    else
        sDescAuto:='N';

    if (chkCantidad.Checked=True) then
        sCantidad_Cnt:='S'
    else
        sCantidad_Cnt:='N';

    if(cmbCategorias.ItemIndex <> -1) then
        sCateg := IntToStr(Clavecarga(cmbCategorias.Items.Strings[cmbCategorias.ItemIndex],'C'))
    else
        sCateg := 'null';

    if(cmbDeptos.ItemIndex <> -1) then
        sDeptos := IntToStr(Clavecarga(cmbDeptos.Items.Strings[cmbDeptos.ItemIndex],'D'))
    else
        sDeptos := 'null';

    if(cmbUnidades.ItemIndex <> -1) then begin
        sUnidade := IntToStr(Clavecarga(cmbUnidades.Items.Strings[cmbUnidades.ItemIndex],'U'));
        sTipo := RecuperaTipo(sUnidade);
    end
    else begin
        sUnidade := 'null';
        sTipo := '2'; // tipo no definido no tienes controle de cantidad
    end;

    if(txtProvNum1.value <> 0) then
        sProv1 := FloatToStr(txtProvNum1.value)
    else
        sProv1 := 'null';

    if(txtProvNum2.value <> 0) then
        sProv2 := FloatToStr(txtProvNum2.value)
    else
        sProv2 := 'null';

    if  (cmbEstatus.ItemIndex = 0)then
        sEstatus := 'A'
    else
        sEstatus := 'I';

    with dmDatos.qryModifica do begin
        if(sModo = 'Insertar') then begin
          ifiscal:='0';
          if (txtExis.Value) > 0 then
     //       if MessageDlg('�Desea Introducir la Existencia como F�scal? ' ,mtCustom, [mbOK, mbCancel],0) = mrOK
     //       then
              ifiscal := FloatToStr(txtExis.value);
            Close;
            SQL.Clear;


            SQL.Add('INSERT INTO articulos (desc_corta, desc_larga, precio1,');
            SQL.Add('precio2, precio3, precio4, ult_costo, costoprom, desc_auto,');
            SQL.Add('existencia, minimo, maximo, categoria, departamento, tipo,');
            SQL.Add('proveedor1, proveedor2, iva, fecha_cap, fecha_umov,');
            SQL.Add('estatus, utilidad, unidade, cantidad_cnt, fiscal, rango1, rango2,rango3,rango4, precio5, rango5, e1, e2, e3, e4, e5,factor,tipo2) VALUES(''' + txtDescripCorta.Text + ''',');
            SQL.Add('''' + txtDescripLarga.text + ''',' + FloatToStr(txtprecio1.value) + ',');
            SQL.Add(FloatToStr(txtprecio2.value) + ',' + FloatToStr(txtprecio3.value) + ',');
            SQL.Add(FloatToStr(txtprecio4.value) + ',' + FloatToStr(txtUltimoCos.value) + ',0,');
            SQL.Add('''' + sDescAuto+''',' + FloatToStr(txtExis.value)+',' );
            SQL.Add(FloatToStr(txtMin.value)+','+FloatToStr(txtMax.value) + ',' + sCateg + ',' + sDeptos + ',' + STipo +',');
            SQL.Add(sProv1 + ',' + sProv2 + ',' + FloatToStr(txtIva.Value) + ',');
            SQL.Add('''' + sFecha + ''',''' + sFecha + ''',''' + sEstatus + ''',''' + memUtilidad.Text + ''',');
            SQL.Add(sUnidade + ',''' + sCantidad_Cnt + ''''+', '+ifiscal+', '+FloatToStr(txtrango1.value)+', '+FloatToStr(txtrango2.value)+',');
            SQL.Add(FloatToStr(txtrango3.value)+','+FloatToStr(txtrango4.value)+ ','+ FloatToStr(txtprecio5.value)+ ','+ FloatToStr(txtrango5.value)+',');
            SQL.Add('''' + e1.Text + ''',''' + e2.Text + ''',''' + e3.Text + ''',''' + e4.Text + ''',''' + e5.Text + ''','+ FloatToStr(factor.value)+ ',''' + tipo.Text +''')');

            ExecSQL;
            Close;
            SQL.Clear;
            SQL.Add('SELECT clave FROM articulos WHERE desc_larga = ''' + txtDescripLarga.Text + '''');
            Open;
            iClave := FieldByName('clave').AsInteger;

            Close;
         end
         else
          begin
          // sifiscal:=false;
           if (txtExis.Value) > 0 then
          //  if MessageDlg('�Desea que la Existencia sea F�scal? ' ,mtCustom, [mbOK, mbCancel],0) = mrOK
        //     then
              Begin
               sifiscal:=true;
               ifiscal := FloatToStr(txtExis.value);
              end;
            Close;
            SQL.Clear;
            SQL.Add('UPDATE articulos SET ');
            SQL.Add('DESC_CORTA = ''' + txtDescripCorta.Text + ''',');
            SQL.Add('DESC_LARGA = ''' + txtDescripLarga.Text + ''',');
            SQL.Add('PRECIO1 = ' + FloatToStr(txtPrecio1.Value) + ',');
            SQL.Add('PRECIO2 = ' + FloatToStr(txtPrecio2.Value) + ',');
            SQL.Add('PRECIO3 = ' + FloatToStr(txtPrecio3.Value) + ',');
            SQL.Add('PRECIO4 = ' + FloatToStr(txtPrecio4.Value) + ',');
            SQL.Add('ULT_COSTO = ' + FloatToStr(txtUltimoCos.Value) + ',');
            SQL.Add('DESC_AUTO = ''' + sDescAuto +''',');
            SQL.Add('EXISTENCIA = ' + FloatToStr(txtExis.Value)+',' );
            SQL.Add('MINIMO = '+ FloatToStr(txtMin.Value)+',' );
            SQL.Add('MAXIMO = '+ FloatToStr(txtMax.Value)+',' );
            SQL.Add('CATEGORIA = ' + sCateg + ',');
            SQL.Add('DEPARTAMENTO = '+ sDeptos + ',');
            SQL.Add('UNIDADE = ' + sUnidade  + ',');
            SQL.Add('TIPO = '+ sTipo + ',');
            SQL.Add('CANTIDAD_CNT = ''' + sCantidad_Cnt + ''',');
            SQL.Add('PROVEEDOR1 = ' + sProv1 + ',');
            SQL.Add('PROVEEDOR2 = ' + sProv2 + ',' );
            SQL.Add('IVA = ' + FloatToStr(txtIva.Value)+',');
            SQL.Add('ESTATUS = ''' + sEstatus+''',');
            SQL.Add('UTILIDAD = ''' + memUtilidad.Text +''',');
            if sifiscal then
            SQL.Add('FISCAL = '+ifiscal+',');
            SQL.Add('RANGO1 = ' + FloatToStr(txtrango1.Value) + ',');
            SQL.Add('RANGO2 = ' + FloatToStr(txtrango2.Value) + ',');
            SQL.Add('RANGO3 = ' + FloatToStr(txtrango3.Value) + ',');
            SQL.Add('RANGO4 = ' + FloatToStr(txtrango4.Value) + ',');
            SQL.Add('PRECIO5 = ' + FloatToStr(txtPrecio5.Value) + ',');
            SQL.Add('RANGO5 = ' + FloatToStr(txtrango5.Value) + ',');
            SQL.Add('e1 = ''' + e1.text+ ''',');
            SQL.Add('e2 = ''' + e2.text+ ''',');
            SQL.Add('e3 = ''' + e3.text+ ''',');
            SQL.Add('e4 = ''' + e4.text+ ''',');
            SQL.Add('e5 = ''' + e5.text+ ''', factor = '+ FloatToStr(factor.value)+',tipo2 = ''' + tipo.Text +  ''', kg = '+ inttostr(kgf));

            SQL.Add(' WHERE clave = ' + IntToStr(iClave));
            ExecSQL;
            // Actualiza los precios en los juegos
            Close;
            SQL.Clear;
            SQL.Add('UPDATE juegos SET precio = ' + FloatToStr(txtPrecio1.Value));
            SQL.Add('WHERE articulo = ' + IntToStr(iClave));
            ExecSQL;

            // Elimina los codigos por si existe alguna modificaci�n en alguno de ellos
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

        // Inserta los codigos secundarios
        for i := 1 to grdCodigos.RowCount - 1 do
            if (Length(grdCodigos.Cells[0,i])>0) then begin
                Close;
                SQL.Clear;
                SQL.Add('INSERT INTO codigos (articulo, codigo, tipo) VALUES(');
                SQL.Add(IntToStr(iClave) + ',''' + grdCodigos.Cells[0,i] + ''',''S'')');
                ExecSQL;
            end;
        Close;
        GuardaJuego;
    end;
end;

procedure TfrmArticulos.ConvierteComillas(Sender : TWidgetControl);
var
    i : integer;
    sTexto : String;
begin
    for i := 0 to Sender.ControlCount - 1 do begin
        if(Sender.Controls[i] is TEdit) then begin
            sTexto := (Sender.Controls[i] as TEdit).Text;
            sTexto := AnsiReplaceStr(sTexto,'''', '�');
            sTexto := AnsiReplaceStr(sTexto,'"', '�');
            (Sender.Controls[i] as TEdit).Text := sTexto;
        end;
    end;
end;

function TfrmArticulos.VerificaDatos:boolean;
var
    bVerifica : Boolean;
begin
    bVerifica := True;
    ConvierteComillas(grpArticulo);
    if(Length(Trim(txtCodigo.Text)) = 0) then begin
        Application.MessageBox('Introduce el c�digo del art�culo','Error',[smbOK],smsCritical);
        txtCodigo.SetFocus;
        bVerifica := False;
    end
    else if(not VerificaCodigo) then begin
        Application.MessageBox('El c�digo especificado ya existe','Error',[smbOK],smsCritical);
        txtCodigo.SetFocus;
        bVerifica := False;
    end
    else if(Length(txtDescripCorta.Text) = 0) then begin
        Application.MessageBox('Introduce la descripci�n corta','Error',[smbOK],smsCritical);
        txtDescripCorta.SetFocus;
        bVerifica := False;
    end
    else if(Length(txtDescripLarga.Text) = 0) then begin
        Application.MessageBox('Introduce la descripci�n larga','Error',[smbOK],smsCritical);
        txtDescripLarga.SetFocus;
        bVerifica := False;
    end
    else if(not VerificaDescLarga) then begin
        Application.MessageBox('La descripci�n larga ya fue asignada a otro art�culo','Error',[smbOK],smsCritical);
        txtDescripLarga.SetFocus;
        bVerifica := False;
    end
    else if (txtProvNum1.Value > 0) and (Length(txtProveedor1.Text) = 0) then begin
        Application.MessageBox('Introduce un proveedor v�lido','Error',[smbOK],smsCritical);
        pgeDatos.ActivePage := tabOrganiza;
        txtProvNum1.SetFocus;
        bVerifica := False;
    end
    else if (txtProvNum2.Value > 0) and (Length(txtProveedor2.Text) = 0) then begin
        Application.MessageBox('Introduce un proveedor v�lido','Error',[smbOK],smsCritical);
        pgeDatos.ActivePage := tabOrganiza;
        txtProvNum2.SetFocus;
        bVerifica := False;
    end
    else if(not VerificaCodigos) then begin
        bVerifica := False;
    end
    else if(txtPrecio1.Value <= 0) then begin
        pgeDatos.ActivePage := tabPrecios;
        Application.MessageBox('Introduce el precio v�lido para el art�culo','Error',[smbOK],smsCritical);
        txtPrecio1.SetFocus;
        bVerifica := False;
    end
    else if(txtPrecio2.Value < 0) then begin
        pgeDatos.ActivePage := tabPrecios;
        Application.MessageBox('Introduce un precio v�lido','Error',[smbOK],smsCritical);
        txtPrecio2.SetFocus;
        bVerifica := False;
    end
    else if(txtPrecio3.Value < 0) then begin
        pgeDatos.ActivePage := tabPrecios;
        Application.MessageBox('Introduce un precio v�lido','Error',[smbOK],smsCritical);
        txtPrecio2.SetFocus;
        bVerifica := False;
    end
    else if(txtPrecio4.Value < 0) then begin
        pgeDatos.ActivePage := tabPrecios;
        Application.MessageBox('Introduce un precio v�lido','Error',[smbOK],smsCritical);
        txtPrecio4.SetFocus;
        bVerifica := False;
    end

    else if(txtPrecio5.Value < 0) then begin
        pgeDatos.ActivePage := tabPrecios;
        Application.MessageBox('Introduce un precio v�lido','Error',[smbOK],smsCritical);
        txtPrecio5.SetFocus;
        bVerifica := False;
    end

    else if(txtrango1.Value < 0) then begin
        pgeDatos.ActivePage := tabPrecios;
        Application.MessageBox('Introduce el rango v�lido para el art�culo','Error',[smbOK],smsCritical);
        txtrango1.SetFocus;
        bVerifica := False;
    end
    else if(txtrango2.Value < 0) then begin
        pgeDatos.ActivePage := tabPrecios;
        Application.MessageBox('Introduce un rango v�lido','Error',[smbOK],smsCritical);
        txtrango2.SetFocus;
        bVerifica := False;
    end
    else if(txtrango3.Value < 0) then begin
        pgeDatos.ActivePage := tabPrecios;
        Application.MessageBox('Introduce un rango v�lido','Error',[smbOK],smsCritical);
        txtrango3.SetFocus;
        bVerifica := False;
    end
    else if(txtrango4.Value < 0) then begin
        pgeDatos.ActivePage := tabPrecios;
        Application.MessageBox('Introduce un rango v�lido','Error',[smbOK],smsCritical);
        txtrango4.SetFocus;
        bVerifica := False;
    end
     else if(txtrango5.Value < 0) then begin
        pgeDatos.ActivePage := tabPrecios;
        Application.MessageBox('Introduce un rango v�lido','Error',[smbOK],smsCritical);
        txtrango5.SetFocus;
        bVerifica := False;
    end

    else if(txtMin.Value > txtMax.Value) then begin
        pgeDatos.ActivePage := tabAlmacen;
        Application.MessageBox('El m�nimo no puede ser mayor que el m�ximo','Error',[smbOK],smsCritical);
        txtMin.SetFocus;
        bVerifica := False;
    end
    else if(not VerificaJuego) then
        bVerifica := False;

    Result := bVerifica;
end;

procedure TfrmArticulos.RecuperaDatos;
begin
    with dmDatos.qryConsulta do begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT nombre FROM categorias WHERE tipo = ''A'' ORDER BY nombre');
        Open;
        cmbCategorias.Items.Clear;
        cmbCategBusq.Items.Clear;
        while (not Eof) do begin
            cmbCategorias.Items.Add(Trim(FieldByName('nombre').AsString));
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
        cmbDeptos.Items.Clear;
        cmbDeptoBusq.Items.Clear;
        while (not Eof) do begin
            cmbDeptos.Items.Add(Trim(FieldByName('nombre').AsString));
            cmbDeptoBusq.Items.Add(Trim(FieldByName('nombre').AsString));
            Next;
        end;
        Close;
    end;
    with dmDatos.qryConsulta do begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT nombre FROM unidades  ORDER BY nombre');
        Open;
        cmbUnidades.Items.Clear;
        while (not Eof) do begin
            cmbUnidades.Items.Add(Trim(FieldByName('nombre').AsString));
            Next;
        end;
        Close;
    end;
end;

function TfrmArticulos.ClaveCarga(sBusqueda:string; sConsulta:string):Integer;
begin
    with dmDatos.qryModifica do begin
        Close;
        SQL.Clear;

        if (sConsulta = 'C') then begin
            SQL.Add('SELECT clave FROM categorias WHERE nombre = ''' + sBusqueda + '''');
            SQL.Add('AND tipo = ''A''');
        end
        else if  (sConsulta = 'D') then begin
            SQL.Add('SELECT clave FROM departamentos WHERE nombre = ''' + sBusqueda + '''');
        end
        else if (sConsulta = 'U') then begin
            SQL.Add('SELECT clave FROM unidades WHERE nombre = ''' + sBusqueda + '''');
        end;
        Open;

        Result := FieldByName('clave').AsInteger;
        Close;
    end;
end;

procedure TfrmArticulos.BuscaProveedor(Sender: TObject);
var
    sProveedor : String;
begin
    with dmDatos.qryModifica do begin
        if(Length((Sender as TEdit).Text) > 0) then begin
           Close;
           SQL.Clear;
           SQL.Add('SELECT nombre FROM proveedores WHERE clave = ' + (Sender as TEdit).Text);
           Open;

           sProveedor := Trim(FieldByName('nombre').AsString);
           Close;
        end;
        if((Sender as TEdit).Name = 'txtProvNum1') then
            txtProveedor1.Text := sProveedor
        else if((Sender as TEdit).Name = 'txtProvNum2') then
            txtProveedor2.Text := sProveedor
        else if((Sender as TEdit).Name = 'txtProvClave') then
            txtProvDesc.Text := sProveedor;
    end;
end;

procedure TfrmArticulos.FormShow(Sender: TObject);
begin
    VerificaCategs;
    VerificaDeptos;
    VerificaUnidades;

    LimpiaDatos;
    sModo := 'Consulta';
    ActivaControles;
    ActivaBuscar;
    pgeGeneral.ActivePage := tabBusqueda;
    RecuperaDatos;
    cmbCategorias.ItemIndex := 0;
    cmbUnidades.ItemIndex := 0;
    cmbDeptos.ItemIndex := 0;
    VerificaTipos;

    grdJuego.Cells[0,0] := 'C�digo';
    grdJuego.Cells[1,0] := 'Descripci�n larga';
    grdJuego.Cells[2,0] := 'Cant.';
    grdJuego.Cells[3,0] := 'Precio';
    grdJuego.Cells[4,0] := 'Importe';
    grdJuego.Cells[5,0] := 'Costo';
    grdJuego.Cells[6,0] := 'CostoTot';
    grdJuego.ColWidths[0] := 90;
    grdJuego.ColWidths[1] := 220;
    grdJuego.ColWidths[2] := 60;
    grdJuego.ColWidths[3] := 60;
    grdJuego.ColWidths[4] := 60;
    grdJuego.ColWidths[5] := 60;
    grdJuego.ColWidths[6] := 60;

    grdCodigos.Cells[0,0] := 'C�digo';

    chkCategClick(Sender);
    chkCodigoClick(Sender);
    chkDescripClick(Sender);
    chkProvClick(Sender);
    chkDeptoClick(Sender);
end;

procedure TfrmArticulos.txtProvNum1Change(Sender: TObject);
begin
    BuscaProveedor(Sender);
end;

procedure TfrmArticulos.btnBuscarClick(Sender: TObject);
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

        SQL.Add('SELECT a.clave, a.tipo, o.codigo, a.desc_larga, a.desc_corta,');
        SQL.Add('a.precio1, a.existencia, u.nombre AS nombre_un FROM articulos a ');
        SQL.Add('LEFT JOIN codigos o ON (a.clave = o.articulo AND o.tipo = ''P'') ');
        SQL.Add('LEFT JOIN unidades u ON a.unidade = u.clave WHERE a.tipo <> 4');

        if(chkCodigo.Checked) then
            SQL.Add('AND a.clave IN (SELECT articulo FROM codigos WHERE codigo STARTING ''' + txtCodigoBusq.Text + ''')');
        if(chkDescrip.Checked) then
            SQL.Add('AND a.desc_larga LIKE ''%' + txtDescripBusq.Text + '%''');
        if(chkCateg.Checked) then
            if(cmbCategBusq.ItemIndex > -1) then
                SQL.Add('AND a.categoria IN (SELECT clave FROM categorias WHERE nombre = ''' + cmbCategBusq.Text + ''' AND tipo = ''A'')');
        if(chkDepto.Checked) then
            if(cmbDeptoBusq.ItemIndex > -1) then
                SQL.Add('AND a.departamento IN (SELECT clave FROM departamentos WHERE nombre = ''' + cmbDeptoBusq.Text + ''')');
        if(chkProv.Checked) then
            if(txtProvClave.Value > 0) then
                SQL.Add('AND (a.proveedor1 = ' + FloatToStr(txtProvClave.Value) + ' OR a.proveedor2 = ' + FloatToStr(txtProvClave.Value) + ')');

        case rdgOrden.ItemIndex of
            0: SQL.Add('ORDER BY o.codigo');
            1: SQL.Add('ORDER BY a.desc_larga');
            2: SQL.Add('ORDER BY a.categoria, o.codigo');
            3: SQL.Add('ORDER BY a.departamento, o.codigo');
            4: SQL.Add('ORDER BY a.proveedor1, a.proveedor2, o.codigo');
        end;

        Open;
        dmDatos.cdsArticulos.Active := true;
        dmDatos.cdsArticulos.FieldByName('clave').Visible := False;
        dmDatos.cdsArticulos.FieldByName('tipo').Visible := False;
        dmDatos.cdsArticulos.FieldByName('codigo').DisplayLabel := 'C�digo';
        dmDatos.cdsArticulos.FieldByName('desc_corta').DisplayLabel := 'Descripci�n corta';
        dmDatos.cdsArticulos.FieldByName('desc_corta').DisplayWidth := 20;
        dmDatos.cdsArticulos.FieldByName('desc_larga').DisplayLabel := 'Descripci�n larga';
        dmDatos.cdsArticulos.FieldByName('desc_larga').DisplayWidth := 35;
        dmDatos.cdsArticulos.FieldByName('precio1').DisplayLabel := 'Precio';
        (dmDatos.cdsArticulos.FieldByName('precio1') as TNumericField).DisplayFormat := '#,##0.00';
        dmDatos.cdsArticulos.FieldByName('existencia').DisplayLabel := 'Exist�ncia';
        (dmDatos.cdsArticulos.FieldByName('existencia') as TNumericField).DisplayFormat := '#,##0.000';
        dmDatos.cdsArticulos.FieldByName('nombre_un').DisplayLabel := 'Unidade';
        dmDatos.cdsArticulos.FieldByName('nombre_un').DisplayWidth := 20;

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

procedure TfrmArticulos.RecuperaDatosBusq;
var
    sCateg, sDeptos, sUnidade: String;
begin
    iClave := dmDatos.cdsArticulos.FieldByName('Clave').AsInteger;

    with dmDatos.qryConsulta do begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT o.codigo, a.desc_corta, a.desc_larga, a.precio1,');
        SQL.Add('a.existencia, a.clave, a.precio2, a.precio3, a.precio4, a.precio5, a.rango1, a.rango2, a.rango3, a.rango4, a.rango5,a.e1, a.e2, a.e3, a.e4, a.e5, a.factor, a.tipo2, a.kg ,  a.ult_costo,');
        SQL.Add('a.desc_auto, a.minimo, a.maximo, a.categoria, a.departamento,');
        SQL.Add('a.tipo, a.cantidad_cnt, a.proveedor1, a.proveedor2, a.iva, a.fecha_cap, a.fecha_umov,');
        SQL.Add('a.ultcompra, a.ultventa, a.estatus, c.nombre AS categorias, a.unidade,');
        SQL.Add('d.nombre AS departamentos, a.utilidad, u.nombre AS nombre_un FROM articulos a ');
        SQL.Add('LEFT JOIN codigos o ON a.clave = o.articulo AND o.tipo = ''P''');
        SQL.Add('LEFT JOIN categorias c ON a.categoria = c.clave ');
        SQL.Add('LEFT JOIN departamentos d ON a.departamento = d.clave ');
        SQL.Add('LEFT JOIN unidades u ON a.unidade = u.clave ');
        SQL.Add('WHERE a.clave = ' + IntToStr(iClave));
        Open;
        if(not Eof) then begin
            pgeGeneral.ActivePage := tabDatos;
            txtCodigo.Text := Trim(FieldByName('codigo').AsString);
            txtDescripCorta.Text := Trim(FieldByName('desc_corta').AsString);
            txtDescripLarga.Text := Trim(FieldByName('desc_larga').AsString);
            memUtilidad.Text := Trim(FieldByName('utilidad').AsString);
            txtFechaCap.Text := FormatDateTime('dd/mm/yyyy',FieldByName('fecha_cap').AsDateTime);
            txtProvNum1.Value := FieldByName('proveedor1').AsInteger;
            txtProvNum2.Value := FieldByName('proveedor2').AsInteger;
            txtPrecio1.Value  := FieldByName('precio1').AsFloat;
            txtPrecio2.Value  := FieldByName('precio2').AsFloat;
            txtPrecio3.Value  := FieldByName('precio3').AsFloat;
            txtPrecio4.Value  := FieldByName('precio4').AsFloat;
            txtPrecio5.Value  := FieldByName('precio5').AsFloat;
            txtrango1.Value  := FieldByName('rango1').AsFloat;
            txtrango2.Value  := FieldByName('rango2').AsFloat;
            txtrango3.Value  := FieldByName('rango3').AsFloat;
            txtrango4.Value  := FieldByName('rango4').AsFloat;
            txtrango5.Value := FieldByName('rango5').AsFloat;
            e1.Text := FieldByName('e1').AsString;
            e2.Text := FieldByName('e2').AsString;
            e3.Text := FieldByName('e3').AsString;
            e4.Text := FieldByName('e4').AsString;
            e5.Text := FieldByName('e5').AsString;
            factor.Value :=  FieldByName('factor').AsFloat;
            tipo.Text :=   FieldByName('tipo2').AsString;

             if (Trim(FieldByName('kg').AsString)='1')  then
                kg.Checked:=True
            else
                kg.Checked:=False;

            if (Trim(FieldByName('desc_auto').AsString)='S')  then
                chkDescAuto.Checked:=True
            else
                chkDescAuto.Checked:=False;

            txtExis.Value := FieldByName('existencia').AsFloat;
            txtMax.Value := FieldByName('maximo').AsFloat;
            txtmin.Value := FieldByName('minimo').AsFloat;
            txtUltimoCos.Value := FieldByName('ult_costo').AsFloat;
            txtIva.Value := FieldByName('iva').AsFloat;
            if FieldByName('estatus').AsString ='A' then
                cmbEstatus.ItemIndex := 0
            else
                cmbEstatus.ItemIndex := 1;
            sDeptos := BuscaNombre(FieldByName('departamento').AsInteger, 'departamentos');
            sCateg := BuscaNombre(FieldByName('categoria').AsInteger, 'categorias');
            sUnidade := BuscaNombre(FieldByName('unidade').AsInteger, 'unidades');
            cmbDeptos.ItemIndex := cmbDeptos.Items.IndexOf(trim(sDeptos));
            cmbCategorias.ItemIndex := cmbCategorias.Items.IndexOf(Trim(sCateg));
            cmbUnidades.ItemIndex :=  cmbUnidades.Items.IndexOf(Trim(sUnidade));

            if (Trim(FieldByName('cantidad_cnt').AsString)='S')  then
                chkCantidad.Checked:=True
            else
                chkCantidad.Checked:=False;

            VerificaTipos;
            CargaJuego;
            CargaCodigos;
            MaxMin;
            CargaMovimientos;
        end;
    end;
end;

procedure TfrmArticulos.btnModificarClick(Sender: TObject);
begin
    if (pgeGeneral.ActivePage = tabBusqueda) then
        RecuperaDatosBusq;
    if(Length(Trim(txtCodigo.Text)) > 0) then begin
        sModo := 'Modificar';
        if (pgeGeneral.ActivePage = tabBusqueda) then
            RecuperaDatosBusq;
        ActivaControles;
        VerificaTipos;
        txtCodigo.SetFocus;
    end;
end;

procedure TfrmArticulos.btnLimpiarClick(Sender: TObject);
begin
    txtCodigoBusq.Clear;
    txtDescripBusq.Clear;
    cmbCategBusq.ItemIndex := -1;
    cmbDeptoBusq.ItemIndex := -1;
    txtProvClave.Value := 0;
    txtProvDesc.Clear;
end;

procedure TfrmArticulos.ActivaBuscar;
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

procedure TfrmArticulos.grdJuegoDrawCell(Sender: TObject; ACol,
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
        if(ACol >= 3) and (ARow > 0) then begin
            sCad := FormatFloat('#,##0.00',StrToFloat(sCad));
            i := Rect.Right-(Sender as TStringGrid).Canvas.TextWidth(sCad+' ');
            (Sender as TStringGrid).Canvas.FillRect(Rect);
            (Sender as TStringGrid).Canvas.TextOut(Round(i),Rect.Top+2,sCad);
        end;
    end;
end;

procedure TfrmArticulos.grdJuegoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
    eValor : Extended;
begin
    // Cuando presionan la flecha hacia abajo en el �ltimo rengl�n
    if(Key = 4117) and (grdJuego.Row + 1 = grdJuego.RowCount) and (Length(grdJuego.Cells[1,grdJuego.Row]) > 0) then begin
        grdJuego.RowCount := grdJuego.RowCount + 1;
        grdJuego.Cells[0,grdJuego.RowCount-1] := '';
        grdJuego.Cells[1,grdJuego.RowCount-1] := '';
        grdJuego.Cells[2,grdJuego.RowCount-1] := '';
        grdJuego.Cells[3,grdJuego.RowCount-1] := '';
    end;
    if(TryStrToFloat(grdJuego.Cells[2,grdJuego.Row],eValor)) then begin
        grdJuego.Cells[4,grdJuego.Row] := FloatToStr(StrToFloat(grdJuego.Cells[2,grdJuego.Row]) * StrToFloat(grdJuego.Cells[3,grdJuego.Row]));
    //  CostoTot
        grdJuego.Cells[6,grdJuego.Row] := FloatToStr(StrToFloat(grdJuego.Cells[2,grdJuego.Row]) * StrToFloat(grdJuego.Cells[5,grdJuego.Row]));
      end
    else
      begin
        grdJuego.Cells[4,grdJuego.Row] := '0';
        grdJuego.Cells[6,grdJuego.Row] := '0';
      end;

    SumaJuego;
end;

procedure TfrmArticulos.grdJuegoKeyPress(Sender: TObject; var Key: Char);
var
    iLimite : Integer;
begin
    if(grdJuego.Col = 0) then begin
        iLimite := 13;
        if (Length(grdJuego.Cells[grdJuego.Col,grdJuego.Row]) = iLimite) and not (Key in [#8,#9,#13,#46]) then
            Key := #0;
        if(not bLetras) then begin
            if not (Key in ['0'..'9',#8,#9,#13,#46]) then
                Key := #0;
        end
        else
            Key := UpCase(Key);
    end
    else begin
        if(grdJuego.Col = 2) then begin
            iLimite := 6;
            if (Length(grdJuego.Cells[grdJuego.Col,grdJuego.Row]) = iLimite) and not (Key in [#8,#9,#13,#46]) then
                Key := #0;
            if (Key in ['0'..'9',#8,#9,#13,#46]) then begin
                if(Key = '.') then begin
                    if(Pos('.',grdJuego.Cells[grdJuego.Col,grdJuego.Row]) > 0) then
                        Key := #0
                end
            end
            else
                Key := #0
        end
        else
            Key := #0;
    end;
end;

procedure TfrmArticulos.grdJuegoKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
    //Si la tecla es F9
   if(Key = 4152) then begin
       if btnArticulos.Enabled = True then
          btnArticulos.Click;
   end;
 {  if(Key = 4153) then begin
      btnQuitar.Click;
   end;}
end;

procedure TfrmArticulos.BuscaArticulo;
begin
    with dmDatos.qryModifica do begin
        // Si la cenda contiene algo
        if(Length(grdJuego.Cells[0,grdJuego.Row]) > 0) then begin
            //Busca el codigo escrito en la celda
            Close;
            SQL.Clear;
            SQL.Add('SELECT clave, desc_larga, precio1, ult_costo FROM articulos');
            SQL.Add('WHERE clave IN (SELECT articulo FROM codigos WHERE codigo = ''' + grdJuego.Cells[0,grdJuego.Row] + ''')');
            Open;

            //Si lo encontr� recupera la descripci�n y el precio y lo pone en su celda correspondiente
            if(not Eof) then  begin
                 grdJuego.Cells[1,grdJuego.Row] := '';
                 grdJuego.Cells[1,grdJuego.Row] := Trim(FieldByName('desc_larga').AsString);
                 grdJuego.Cells[3,grdJuego.Row] := '';
                 grdJuego.Cells[3,grdJuego.Row] := FieldByName('precio1').AsString;
                 grdJuego.Cells[5,grdJuego.Row] := '';
                 grdJuego.Cells[5,grdJuego.Row] := FieldByName('ult_costo').AsString;
            end
            else begin
                //Limpia las celdas de descripcion y precio
                grdJuego.Cells[1,grdJuego.Row] := '';
                grdJuego.Cells[3,grdJuego.Row] := '';
            end;
            Close;
        end
        else
            grdJuego.Cells[1,grdJuego.Row] := '';
    end;
end;

procedure TfrmArticulos.GuardaJuego;
var
    i, iCant : Integer;
    sArticulo, sTipo, sUnidade : String;
begin
    with dmDatos.qryModifica do begin
        if(sModo = 'Modificar') then begin
            Active := false;
            SQL.Clear;
            SQL.Add('DELETE FROM juegos WHERE clave = ' + IntToStr(iClave));
            ExecSQL;
            Active := false;
        end;

        sUnidade := IntToStr(Clavecarga(cmbUnidades.Items.Strings[cmbUnidades.ItemIndex],'U'));
        sTipo := RecuperaTipo(sUnidade);

        if (sTipo = '1') then begin
            ReduceJuego;
            iCant := grdJuego.RowCount - 1;
            with grdJuego do begin
                for i:= 1 to iCant do begin
                    if(Length(Cells[0,i]) > 0) then begin
                        Close;
                        SQL.Clear;
                        SQL.Add('SELECT articulo FROM codigos WHERE codigo = ''' + grdJuego.Cells[0,i] + '''');
                        Open;
                        sArticulo := IntToStr(FieldByName('articulo').AsInteger);

                        Close;
                        SQL.Clear;
                        SQL.Add('INSERT INTO juegos (clave, articulo, cantidad, precio) VALUES(');
                        SQL.Add(IntToStr(iClave) + ',' + sArticulo + ',');
                        SQL.Add(grdJuego.Cells[2,i] + ',' + grdJuego.Cells[3,i] + ')');
                        ExecSQL;
                    end;
                end;
            end;
        end;
    end;
end;

procedure TfrmArticulos.ReduceJuego;
var
    i,j : Integer;
begin
    i := 1;
    while (i < grdJuego.RowCount -1) do begin
        if(Length(grdJuego.Cells[1,i]) = 0) then
            EliminaRenglon(i)
        else
            Inc(i);
    end;

    i := 1;
    with grdJuego do begin
        while i < RowCount do begin
            j := i + 1;
            while j < RowCount do begin
                if(Cells[0,i] = Cells[0,j]) then begin
                    Cells[2,i] := FloatToStr(StrToFloat(Cells[2,i]) + StrToFloat(Cells[2,j]));
                    EliminaRenglon(j);
                end
                else
                    Inc(j);
            end;
            Inc(i);
        end;
    end;
end;

procedure TfrmArticulos.EliminaRenglon(iRenglon : Integer);
var
    i : Integer;
begin
    if(grdJuego.RowCount > 2) then begin
        for i := iRenglon to grdJuego.RowCount - 2 do begin
            grdJuego.Cells[0,i] := grdJuego.Cells[0,i+1];
            grdJuego.Cells[1,i] := grdJuego.Cells[1,i+1];
            grdJuego.Cells[2,i] := grdJuego.Cells[2,i+1];
            grdJuego.Cells[3,i] := grdJuego.Cells[3,i+1];
        end;
        grdJuego.Cells[0,grdJuego.RowCount - 1] := '';
        grdJuego.Cells[1,grdJuego.RowCount - 1] := '';
        grdJuego.Cells[2,grdJuego.RowCount - 1] := '';
        grdJuego.Cells[3,grdJuego.RowCount - 1] := '';
        grdJuego.RowCount := grdJuego.RowCount - 1;
    end;
end;

procedure TfrmArticulos.CargaCodigos;
var
    i: Integer;
begin
    with dmDatos.qryModifica do begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT codigo FROM codigos WHERE tipo <> ''P'' AND articulo = ' + IntToStr(iClave));
        Open;

        grdCodigos.RowCount := 2;
        grdCodigos.Cells[0,1] := '';
        i := 1;
        while(not Eof) do begin
            grdCodigos.RowCount := i + 1;
            grdCodigos.Cells[0,i] := Trim(FieldByName('codigo').AsString);
            Inc(i);
            Next;
        end;
        Close;
    end;
end;

procedure TfrmArticulos.CargaJuego;
var
    i: Integer;
    rTotalJuego, rTotalCosto, rRedondeo, rResiduo : real;
begin
    with dmDatos.qryModifica do begin
{       --   Antes   --
        Close;
        SQL.Clear;
        SQL.Add('SELECT a.clave, o.codigo, a.desc_larga, j.cantidad, j.precio FROM juegos j');
        SQL.Add('LEFT JOIN articulos a ON a.clave = j.articulo');
        SQL.Add('LEFT JOIN codigos o ON a.clave = o.articulo AND o.tipo = ''P''');
        SQL.Add('WHERE j.clave = ' + IntToStr(iClave) + ' ORDER BY a.desc_larga');
        Open;
                          }
//      --  Mi Modificacion  --
        Close;
        SQL.Clear;
        SQL.Add('SELECT a.clave, o.codigo, a.desc_larga, j.cantidad, a.precio1, a.ult_costo FROM juegos j');
        SQL.Add('LEFT JOIN articulos a ON a.clave = j.articulo');
        SQL.Add('LEFT JOIN codigos o ON a.clave = o.articulo AND o.tipo = ''P''');
        SQL.Add('WHERE j.clave = ' + IntToStr(iClave) + ' ORDER BY a.desc_larga');
        Open;

        rTotalJuego := 0;
        rTotalCosto := 0;
        if(not Eof) then begin
            i := 1;
            while (EOF = false) do begin
                grdJuego.RowCount := i + 1;
                grdJuego.Cells[0,i] := Trim(FieldByName('codigo').AsString);
                grdJuego.Cells[1,i] := Trim(FieldByName('desc_larga').AsString);
                grdJuego.Cells[2,i] := FloatToStr(FieldByName('cantidad').AsFloat);
                grdJuego.Cells[3,i] := FloatToStr(FieldByName('precio1').AsFloat);
                grdJuego.Cells[4,i] := FloatToStr(FieldByName('precio1').AsFloat * FieldByName('cantidad').AsFloat);
                grdJuego.Cells[5,i] := FloatToStr(FieldByName('ult_costo').AsFloat);
                grdJuego.Cells[6,i] := FloatToStr(FieldByName('ult_costo').AsFloat * FieldByName('cantidad').AsFloat);
                rTotalJuego := rTotalJuego + FieldByName('precio1').AsFloat * FieldByName('cantidad').AsFloat;
                rTotalCosto := rTotalCosto + FieldByName('ult_costo').AsFloat * FieldByName('cantidad').AsFloat;
                Inc(i);
                Next;
            end;
            // Redondeo Total Juego
            rRedondeo := 0;
            rResiduo := rTotalJuego - (Int(rTotalJuego / rMonedaMenor) * rMonedaMenor);
            if(rResiduo > 0) then begin
                if(rResiduo > rMonedaMenor / 2) then
                    rRedondeo := rMonedaMenor - rResiduo
                else
                    rRedondeo := - rResiduo;
            end;
            txtTotalJuego.Value := rTotalJuego + rRedondeo;
            // Fin Redondeo Total Juego
            // Redondeo Total Costo
            rRedondeo := 0;
          //  rResiduo  := 0;
            rResiduo := rTotalCosto - (Int(rTotalCosto / rMonedaMenor) * rMonedaMenor);
            if(rResiduo > 0) then begin
                if(rResiduo > rMonedaMenor / 2) then
                    rRedondeo := rMonedaMenor - rResiduo
                else
                    rRedondeo := - rResiduo;
            end;
            txtCostoJuego.Value := rTotalCosto + rRedondeo;
            // Fin Redondeo Total Costo
        end
        else begin
            grdJuego.RowCount := 2;
            grdJuego.Cells[3,1] := '';
            grdJuego.Cells[2,1] := '';
            grdJuego.Cells[1,1] := '';
            grdJuego.Cells[0,1] := '';
        end;
        Close;
    end;
//      --  Fin Mi Modificacion --
end;

procedure TfrmArticulos.Domicilio1Click(Sender: TObject);
begin
    pgeDatos.ActivePage := tabOrganiza;
    ActivaBuscar;
end;

procedure TfrmArticulos.mnuCodigosClick(Sender: TObject);
begin
    pgeDatos.ActivePage := tabCodigos;
    ActivaBuscar;
end;

procedure TfrmArticulos.mnuPreciosClick(Sender: TObject);
begin
    pgeDatos.ActivePage := tabPrecios;
    ActivaBuscar;
end;

procedure TfrmArticulos.mnuProvedClick(Sender: TObject);
begin
    pgeGeneral.ActivePage := tabDatos;
    ActivaBuscar;
end;

procedure TfrmArticulos.mnuBusquedaClick(Sender: TObject);
begin
    pgeGeneral.ActivePage := tabBusqueda;
    ActivaBuscar;
end;

procedure TfrmArticulos.mnuAvanzaClick(Sender: TObject);
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

procedure TfrmArticulos.mnuRetrocedeClick(Sender: TObject);
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

procedure TfrmArticulos.mnuAlmacenClick(Sender: TObject);
begin
    pgeDatos.ActivePage := tabAlmacen;
    ActivaBuscar;
end;

procedure TfrmArticulos.btnEliminarClick(Sender: TObject);
begin
    if (pgeGeneral.ActivePage = tabBusqueda) then
        RecuperaDatosBusq;
    if(Length(Trim(txtCodigo.Text)) > 0) then begin
        pgeGeneral.ActivePage := tabDatos;
        if(Application.MessageBox('Se eliminar� el registro seleccionado','Eliminar',[smbOK]+[smbCancel],smsWarning) = smbOK) then begin
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
end;

procedure TfrmArticulos.RecuperaConfig;
var
    iniArchivo : TIniFile;
    sIzq, sArriba, sValor : String;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'config.ini');

    pgeGeneral.ActivePage := tabDatos;

    with iniArchivo do begin
        //Recupera la posici�n Y de la ventana
        sArriba := ReadString('Articulos', 'Posy', '');

        //Recupera la posici�n X de la ventana
        sIzq := ReadString('Articulos', 'Posx', '');

        if (Length(sIzq) > 0) and (Length(sArriba) > 0) then begin
            Left := StrToInt(sIzq);
            Top := StrToInt(sArriba);
        end;

        //Recupera el valor de las casillas de verificaci�n de buscar

        sValor := ReadString('Articulos', 'CategBusq', '');
        if (sValor = 'S') then
            chkCateg.Checked := true
        else
            chkCateg.Checked := false;

        sValor := ReadString('Articulos', 'CodigoBusq', '');
        if (sValor = 'S') then
            chkCodigo.Checked := true
        else
            chkCodigo.Checked := false;

        sValor := ReadString('Articulos', 'DescripBusq', '');
        if (sValor = 'S') then
            chkDescrip.Checked := true
        else
            chkDescrip.Checked := false;

        sValor := ReadString('Articulos', 'ProvBusq', '');
        if (sValor = 'S') then
            chkProv.Checked := true
        else
            chkProv.Checked := false;

        sValor := ReadString('Articulos', 'DeptoBusq', '');
        if (sValor = 'S') then
            chkDepto.Checked := true
        else
            chkDepto.Checked := false;

        //Recupera el valor de los botones de radio de orden
        sValor := ReadString('Articulos', 'Orden', '');
        if (Length(sValor) > 0) then
            rdgOrden.ItemIndex := StrToInt(sValor);

        //Recupera la {ultima ficha que se seleccion�
        sValor := ReadString('Articulos', 'Ficha', '');
        if (Length(sValor) > 0) then
            pgeDatos.ActivePageIndex := StrToInt(sValor);
        Free;
    end;

    with dmDatos.qryModifica do begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT letraencodigo, monedamenor FROM config');
        Open;
        rMonedaMenor := FieldByName('monedamenor').AsFloat;
        if(rMonedaMenor = 0) then
            rMonedaMenor := 1;
        if( FieldByName('letraencodigo').AsString = 'S' ) then
            bLetras := true
        else
            bLetras := false;
        Close;
    end;

end;

procedure TfrmArticulos.FormClose(Sender: TObject; var Action: TCloseAction);
var
    iniArchivo : TIniFile;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'config.ini');
    with iniArchivo do begin
        // Registra la posici�n y de la ventana
        WriteString('Articulos', 'Posy', IntToStr(Top));

        // Registra la posici�n X de la ventana
        WriteString('Articulos', 'Posx', IntToStr(Left));

        //Registra el valor de las casillas de verificaci�n de buscar
        if(chkCateg.Checked) then
            WriteString('Articulos', 'CategBusq', 'S')
        else
            WriteString('Articulos', 'CategBusq', 'N');

        if(chkCodigo.Checked) then
            WriteString('Articulos', 'CodigoBusq', 'S')
        else
            WriteString('Articulos', 'CodigoBusq', 'N');

        if(chkDescrip.Checked) then
            WriteString('Articulos', 'DescripBusq', 'S')
        else
            WriteString('Articulos', 'DescripBusq', 'N');

        if(chkProv.Checked) then
            WriteString('Articulos', 'ProvBusq', 'S')
        else
            WriteString('Articulos', 'ProvBusq', 'N');

        if(chkDepto.Checked) then
            WriteString('ArticuloBusq', 'DeptoBusq', 'S')
        else
            WriteString('ArticuloBusq', 'DeptoBusq', 'N');

        //Registra el valor de los botones de radio de orden
        WriteString('Articulos', 'Orden', IntToStr(rdgOrden.ItemIndex));

        //Registra la ultima ficha que se seleccion�
        WriteString('Articulos', 'Ficha', IntToStr(pgeDatos.ActivePageIndex));

        Free;
    end;
    dmDatos.qryArticulos.Close;
    dmDatos.cdsArticulos.Active := false;
end;

procedure TfrmArticulos.mnuJuegosClick(Sender: TObject);
begin
    pgeDatos.ActivePage := tabJuego;
    ActivaBuscar;
end;

procedure TfrmArticulos.mnuUtilitadClick(Sender: TObject);
begin
    pgeDatos.ActivePage := tabUtilidad;
    ActivaBuscar;
end;

function TfrmArticulos.VerificaJuego:Boolean;
var
    i : Integer;
    szMensaje : array[0..120] of char;
    sTipo, sUnidade : String;
begin
    Result := true;

    sUnidade := IntToStr(Clavecarga(cmbUnidades.Items.Strings[cmbUnidades.ItemIndex],'U'));
    sTipo := RecuperaTipo(sUnidade);

    if(sTipo = '1') then
        with dmDatos.qryModifica do begin
            for i := 1 to grdJuego.RowCount - 1 do begin
                if(Length(grdJuego.Cells[1,i]) > 0) and (Length(grdJuego.Cells[2,i]) = 0) then begin
                    pgeGeneral.ActivePage := tabJuego;
                    Application.MessageBox('Introduce la cantidad de art�culos','Error',[smbOK],smsCritical);
                    grdJuego.Col := 2;
                    grdJuego.Row := i;
                    grdJuego.SetFocus;
                    Result := false;
                    Break;
                end;
                if(Length(grdJuego.Cells[1,i]) = 0) and (Length(grdJuego.Cells[2,i]) > 0) then begin
                    pgeGeneral.ActivePage := tabJuego;
                    Application.MessageBox('Introduce una clave de art�culo v�lida','Error',[smbOK],smsCritical);
                    grdJuego.Col := 0;
                    grdJuego.Row := i;
                    grdJuego.SetFocus;
                    Result := false;
                    Break;
                end;
            end;

            if(Result) then begin
                for i := 1 to grdJuego.RowCount - 1 do begin
                    Close;
                    SQL.Clear;
                    SQL.Add('SELECT tipo FROM articulos WHERE clave');
                    SQL.Add('IN (SELECT articulo FROM codigos WHERE codigo = ''' + grdJuego.Cells[0,i] + ''')');
                    Open;
                    if(FieldByName('tipo').AsInteger = 1) then begin
                        StrPCopy(szMensaje,'El art�culo ' + grdJuego.Cells[1,i] +
                                           ' es un juego. No es posible incluir un juego dentro de otro');
                        pgeGeneral.ActivePage := tabJuego;
                        Application.MessageBox(szMensaje,'Error',[smbOK],smsCritical);
                        Result := false;
                        grdJuego.Row := i;
                        grdJuego.Col := 0;
                        Close;
                        break;
                    end;
                end;
            end;
        end;
end;

procedure TfrmArticulos.grdListadoDrawColumnCell(Sender: TObject;
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

procedure TfrmArticulos.Buscarproveedor1Click(Sender: TObject);
begin
    with TFrmProveedBusq.Create(Self) do
    try
        if(txtProvNum1.Focused)and (txtProvNum1.Font.Color=clWindowText) then begin
            if(ShowModal = mrOk) then
                txtProvNum1.Text := sClave;
            txtProvNum1.SetFocus;
        end
        else if(txtProvNum2.Focused) and (txtProvNum2.Font.Color=clWindowText) then begin
            if(ShowModal = mrOk) then
                txtProvNum2.Text := sClave;
            txtProvNum2.SetFocus;
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

procedure TfrmArticulos.VerificaCategs;
begin
    with dmDatos.qryModifica do begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT * FROM categorias WHERE tipo = ''A''');
        Open;

        if(Eof) then begin
            Close;
            SQL.Clear;
            SQL.Add('INSERT INTO categorias (nombre, tipo, cuenta, fecha_umov, cuenta) VALUES');
            SQL.Add('(''DEFAULT'',''A'','''',''' + FormatDateTime('mm/dd/yyyy',Date) + ''','''')');
            ExecSQL;
        end;
        Close;
    end;
end;

procedure TfrmArticulos.VerificaDeptos;
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

procedure TfrmArticulos.VerificaUnidades;
var
    sClave : String;
begin
    with dmDatos.qryModifica do begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT * FROM unidades');
        Open;

        if(Eof) then begin
            Close;
            SQL.Clear;
            SQL.Add('SELECT CAST(GEN_ID(unidades,1) AS integer) AS Clave');
            SQL.Add('from RDB$DATABASE');
            Open;
            sClave := FieldByName('clave').AsString;

            Close;
            SQL.Clear;
            SQL.Add('INSERT INTO unidades (clave, nombre, fecha_umov, tipo) VALUES');
            SQL.Add('(' + sClave + ',''DEFAULT'',''' + FormatDateTime('mm/dd/yyyy',Date) + ''',' + '2' + ')');
            ExecSQL;
        end;
        Close;
    end;
end;

procedure TfrmArticulos.grdListadoDblClick(Sender: TObject);
begin
    pgeGeneral.ActivePage := tabDatos;
    LimpiaDatos;
    RecuperaDatosBusq;
    ActivaBuscar;
    ActivaControles;
end;

procedure TfrmArticulos.grdListadoEnter(Sender: TObject);
begin
    btnSeleccionar.Default := true;
    btnBuscar.Default := false;
end;

procedure TfrmArticulos.grdListadoExit(Sender: TObject);
begin
    btnBuscar.Default := true;
    btnSeleccionar.Default := false;
end;

procedure TfrmArticulos.btnSeleccionarClick(Sender: TObject);
begin
    if(txtRegistros.Value > 0) then begin
        RecuperaDatosBusq;
        ActivaBuscar;
        ActivaControles;
    end;
end;

procedure TfrmArticulos.Salir1Click(Sender: TObject);
begin
    Close;
end;

procedure TfrmArticulos.MaxMin;
var
     iFaltaMin, iFaltaMax, iSobregiro : real;
begin
     iFaltaMin:= txtMin.Value - txtExis.Value;
     if (iFaltaMin < 0)then
        iFaltaMin := 0;
     txtFaltaMin.Value := iFaltaMin;

     iFaltaMax := txtMax.Value - txtExis.Value;
     if (iFaltaMax < 0)then
        iFaltaMax := 0;
     txtFaltamax.Value := iFaltaMax;

     iSobregiro:= txtExis.Value - txtMax.Value;
     if (iSobregiro < 0)then
        iSobregiro := 0;
     txtSobregiro.Value:=iSobregiro;
end;

procedure TfrmArticulos.txtExisExit(Sender: TObject);
begin
    MaxMin;
end;

procedure TfrmArticulos.txtMinExit(Sender: TObject);
begin
    MaxMin;
end;

procedure TfrmArticulos.txtMaxExit(Sender: TObject);
begin
    MaxMin;
end;

procedure TfrmArticulos.Salta(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    {Inicio (36), Fin (35), Izquierda (37), derecha (39), arriba (38), abajo (40)}
    if(Key >= 30) and (Key <= 122) and (Key <> 35) and (Key <> 36) and not ((Key >= 37) and (Key <= 40)) then
        if( Length((Sender as TEdit).Text) = (Sender as TEdit).MaxLength) then
            SelectNext(Sender as TWidgetControl, true, true);
end;

procedure TfrmArticulos.txtCodigoKeyPress(Sender: TObject; var Key: Char);
begin
    if(not bLetras) then
        if not (Key in ['0'..'9',#8,#9,#13,#46]) then
            Key := #0;
end;

procedure TfrmArticulos.pgeGeneralPageChanging(Sender: TObject;
  NewPage: TTabSheet; var AllowChange: Boolean);
begin
    ActivaBuscar;
end;

procedure TfrmArticulos.pgeGeneralChange(Sender: TObject);
begin
    ActivaBuscar;
end;

procedure TfrmArticulos.CargaMovimientos;
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
            if(Length(FieldByName('vfecha').AsString) > 0) then
                txtFechVent.Text := FormatDateTime('dd/mm/yyyy',FieldByName('VFECHA').AsDateTime)
            else
                txtFechVent.Clear;
            txtProv.Text := Trim(FieldByName('NOMPROVEEDOR').AsString);
            txtClient.Text := Trim(FieldByName('NOMCLIENTE').AsString);
        end;
        Close;
    end;
end;

procedure TfrmArticulos.FormCreate(Sender: TObject);
begin
    RecuperaConfig;
end;

function TfrmArticulos.VerificaCodigo:boolean;
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

function TfrmArticulos.VerificaCodigos:boolean;
var
    i, j, k : integer;
begin
    Result := true;
    txtCodigo.Text := Trim(txtCodigo.Text);

    // Reduce los c�digos eliminando los espacios vacios
    i := 1;
    while(i < grdCodigos.RowCount - 1) do begin
        grdCodigos.Cells[0,i] := Trim(grdCodigos.Cells[0,i]);
        if(Length(grdCodigos.Cells[0,i]) = 0) then begin
            for j := i to grdCodigos.RowCount - 2 do
                grdCodigos.Rows[j] := grdCodigos.Rows[j + 1];
            grdCodigos.RowCount := grdCodigos.RowCount - 1;
        end;
        Inc(i);
    end;

    // Reduce los c�digos eliminando los repetidos
    i := 1;
    while(i < grdCodigos.RowCount - 1) do begin
        for j := i + 1 to grdCodigos.RowCount - 1 do
            if(grdCodigos.Cells[0,i] = grdCodigos.Cells[0,j]) then begin
                for k := j to grdCodigos.RowCount - 2 do
                    grdCodigos.Rows[j] := grdCodigos.Rows[j + 1];
                grdCodigos.RowCount := grdCodigos.RowCount - 1;
            end;
        Inc(i);
    end;

    for i := 1 to grdCodigos.RowCount - 1 do begin
        if(Length(grdCodigos.Cells[0,i]) > 0) then begin
            if(grdCodigos.Cells[0,i] <> txtCodigo.Text) then begin
                with dmDatos.qryModifica do begin
                    Close;
                    SQL.Clear;
                    SQL.Add('SELECT articulo FROM codigos WHERE codigo = ''' + grdCodigos.Cells[0,i] + '''');
                    Open;

                    if(not Eof) and ((sModo = 'Insertar') or ((FieldByName('articulo').AsInteger <> iClave) and
                         (sModo = 'Modificar'))) then begin
                        pgeDatos.ActivePage := tabCodigos;
                        Application.MessageBox('El c�digo alterno ya existe','Error',[smbOK],smsCritical);
                        grdCodigos.SetFocus;
                        grdCodigos.Row := i;
                        Result := false;
                        break;
                    end;
                    Close;
                end;
            end
            else begin
                pgeDatos.ActivePage := tabCodigos;
                Application.MessageBox('El c�digo alterno no puede ser igual que el c�digo principal','Error',[smbOK],smsCritical);
                grdCodigos.SetFocus;
                grdCodigos.Row := i;
                Result := false;
                break;
            end;
        end;
    end;
end;

function TfrmArticulos.BuscaNombre(iValor:Integer; sTabla:string):String;
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

procedure TfrmArticulos.mnuMovimientosClick(Sender: TObject);
begin
    pgeDatos.ActivePage := tabMov;
    ActivaBuscar;
end;

procedure TfrmArticulos.grdCodigosKeyPress(Sender: TObject; var Key: Char);
var
    iLimite : integer;
begin
    iLimite := 13;
    if (Length(grdCodigos.Cells[grdCodigos.Col,grdCodigos.Row]) = iLimite) and not (Key in [#8,#9,#13,#46]) then
        Key := #0;
    if(not bLetras) then begin
        if not (Key in ['0'..'9',#8,#9,#13,#46]) then
            Key := #0;
    end
    else
        Key := UpCase(Key);
end;

procedure TfrmArticulos.grdCodigosKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
    if (Key = Key_Down) and (grdCodigos.Row = grdCodigos.RowCount - 1) then begin
        grdCodigos.RowCount := grdCodigos.RowCount + 1;
        grdCodigos.Cells[0,grdCodigos.Row + 1] := '';
    end;
end;

function TfrmArticulos.VerificaDescLarga:boolean;
begin
    Result := true;

    if(Length(txtDescripLarga.Text) > 0) then begin
        with dmDatos.qryModifica do begin
            Close;
            SQL.Clear;
            SQL.Add('SELECT clave FROM articulos WHERE desc_larga = ''' + txtDescripLarga.Text + '''');
            Open;

            if(not Eof) and ((sModo = 'Insertar') or ((FieldByName('clave').AsInteger <> iClave) and
                     (sModo = 'Modificar'))) then begin
                Result := false;
            end;
            Close;
        end;
    end;
end;

procedure TfrmArticulos.SumaJuego;
var
    rImporteJuego, rTotalJuego : double;
    i : integer;
begin
    rTotalJuego := 0;
    for i := 1 to grdJuego.RowCount - 1 do
        if(TryStrToFloat(grdJuego.Cells[4,i],rImporteJuego)) then
            rTotalJuego := rTotalJuego + rImporteJuego;
    txtTotalJuego.Value := rTotalJuego;
    //  Suma Total Costo
    rTotalJuego := 0;
    for i := 1 to grdJuego.RowCount - 1 do
        if(TryStrToFloat(grdJuego.Cells[6,i],rImporteJuego)) then
            rTotalJuego := rTotalJuego + rImporteJuego;
    txtCostoJuego.Value := rTotalJuego;
end;

procedure TfrmArticulos.chkCategClick(Sender: TObject);
begin
    if(chkCateg.Checked) then begin
        cmbCategBusq.Visible := true;
   //     cmbCategBusq.SetFocus;
    end
    else
        cmbCategBusq.Visible := false;
end;

procedure TfrmArticulos.chkCodigoClick(Sender: TObject);
begin
    if(chkCodigo.Checked) then begin
        txtCodigoBusq.Visible := true;
  //      txtCodigoBusq.SetFocus;
    end
    else
        txtCodigoBusq.Visible := false;
end;

procedure TfrmArticulos.chkDescripClick(Sender: TObject);
begin
    if(chkDescrip.Checked) then begin
        txtDescripBusq.Visible := true;
    //    txtDescripBusq.SetFocus;
    end
    else
        txtDescripBusq.Visible := false;
end;

procedure TfrmArticulos.chkProvClick(Sender: TObject);
begin
    if(chkProv.Checked) then begin
        txtProvClave.Visible := true;
        txtProvDesc.Visible := true;
      //  txtProvClave.SetFocus;
    end
    else begin
        txtProvClave.Visible := false;
        txtProvDesc.Visible := false;
    end;
end;

procedure TfrmArticulos.chkDeptoClick(Sender: TObject);
begin
    if(chkDepto.Checked) then begin
        cmbDeptoBusq.Visible := true;
     //   cmbDeptoBusq.SetFocus;
    end
    else
        cmbDeptoBusq.Visible := false;
end;

procedure TfrmArticulos.btnArticulosClick(Sender: TObject);
var
    eValor : Extended;
begin
    //Agregar fila al final
    if (grdJuego.Cells[0,grdJuego.RowCount-1]<>'') and (grdJuego.RowCount>1) then
    begin
      grdJuego.RowCount := grdJuego.RowCount + 1;
      grdJuego.Cells[0,grdJuego.RowCount-1] := '';
      grdJuego.Cells[1,grdJuego.RowCount-1] := '';
      grdJuego.Cells[2,grdJuego.RowCount-1] := '';
      grdJuego.Cells[3,grdJuego.RowCount-1] := '';
      if(TryStrToFloat(grdJuego.Cells[2,grdJuego.Row],eValor)) then
          grdJuego.Cells[4,grdJuego.Row] := FloatToStr(StrToFloat(grdJuego.Cells[2,grdJuego.Row]) * StrToFloat(grdJuego.Cells[3,grdJuego.Row]))
      else
          grdJuego.Cells[4,grdJuego.Row] := '0';
      SumaJuego;
      grdJuego.Row := grdJuego.RowCount-1;
      grdJuego.Col := 0;
    end;
    //Fin Agregar
    //Buscar el Articulo
    grdJuego.Col := 0;
    with TFrmArticuloBusq.Create(Self) do
       try
         ShowModal;
         if bSelec then
            grdJuego.Cells[grdJuego.Col,grdJuego.Row] := sCodigo;
            grdJuego.SetFocus;
            grdJuego.Col := 2;
       finally
            free;
       end;
    BuscaArticulo;
    //Fin Buscar
end;

procedure TfrmArticulos.btnQuitarClick(Sender: TObject);
var
    i : integer;
begin
    for i := grdJuego.Row to grdJuego.RowCount - 2 do begin
        grdJuego.Cells[0,i+1] := IntToStr(StrToInt(grdJuego.Cells[0,i+1]) - 1);
        grdJuego.Rows[i] := grdJuego.Rows[i+1];
    end;

    if grdJuego.RowCount > 2 then
        grdJuego.RowCount:=grdJuego.RowCount - 1
    else begin
        grdJuego.Cells[0,1]:='';
        grdJuego.Cells[1,1]:='';
        grdJuego.Cells[2,1]:='';
        grdJuego.Cells[3,1]:='';
        grdJuego.Cells[4,1]:='';
        grdJuego.Cells[5,1]:='';
        grdJuego.Cells[6,1]:='';
    end;

    SumaJuego;
    grdJuego.Row := grdJuego.RowCount-1;
    grdJuego.Realign;
end;

procedure TfrmArticulos.chkCantidadClick(Sender: TObject);
begin
    VerificaTipos;
end;

procedure TfrmArticulos.VerificaTipos;
var
    sTipo, sUnidade : String;
begin
    if(cmbUnidades.ItemIndex = -1) then
        Exit;

    sUnidade := IntToStr(Clavecarga(cmbUnidades.Items.Strings[cmbUnidades.ItemIndex],'U'));
    sTipo := RecuperaTipo(sUnidade);

    if(sTipo = '2') then begin
        chkCantidad.Checked := false;
        chkCantidad.Enabled := false;
    end;

    if(sTipo = '1') then begin
        tabJuego.Enabled := true;
        tabJuego.TabVisible := true;
        mnuJuegos.Enabled := true;
        mnuJuegos.Visible := true;
    end
    else begin
        tabJuego.Enabled := false;
        tabJuego.TabVisible := false;
        mnuJuegos.Enabled := false;
        mnuJuegos.Visible := false;
    end;

    if(chkCantidad.Checked=True) then
        grpExistencia.Enabled := true
    else
        grpExistencia.Enabled := false;
end;

function TfrmArticulos.RecuperaTipo(sUnidade : String):String;
var
    sRegreso : String;
begin
    sRegreso := '-1';
    with dmDatos.qryConsulta do begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT tipo FROM unidades WHERE clave = ' + sUnidade);
        Open;

        sRegreso := FieldByName('tipo').AsString;

        Close;
    end;
    Result := sRegreso;
end;

procedure TfrmArticulos.cmbUnidadesChange(Sender: TObject);
begin
    VerificaTipos;
end;


procedure TfrmArticulos.Label17DblClick(Sender: TObject);
begin
txtExis.Enabled:=true;
end;

procedure TfrmArticulos.ET1Click(Sender: TObject);
begin

rptReportes.FileName := 'C:\Ventas\Reportes\etiqueta1.rep';
rptReportes.Report.DatabaseInfo.Items[0].SQLConnection := dmDatos.sqlBase.DataSets[0].SQLConnection;
        rptReportes.Report.Params.ParamByName('CODIGO').AsString := txtCodigo.Text;
        rptReportes.Execute;
end;

procedure TfrmArticulos.ET2Click(Sender: TObject);
begin
rptReportes.FileName := 'C:\Ventas\Reportes\etiqueta2.rep';
rptReportes.Report.DatabaseInfo.Items[0].SQLConnection := dmDatos.sqlBase.DataSets[0].SQLConnection;
        rptReportes.Report.Params.ParamByName('CODIGO').AsString := txtCodigo.Text;
        rptReportes.Execute;
end;

procedure TfrmArticulos.ET3Click(Sender: TObject);
begin
rptReportes.FileName := 'C:\Ventas\Reportes\etiqueta3.rep';
rptReportes.Report.DatabaseInfo.Items[0].SQLConnection := dmDatos.sqlBase.DataSets[0].SQLConnection;
        rptReportes.Report.Params.ParamByName('CODIGO').AsString := txtCodigo.Text;
        rptReportes.Execute;
end;



procedure TfrmArticulos.Button1Click(Sender: TObject);
begin
with TfrmAutoriza.Create(Self) do
    try

        sTipoAutoriza := 'V16';
        ShowModal;
        if(bAutorizacion) then begin

         txtExis.ReadOnly := false;


        end
        else
        begin

          txtExis.ReadOnly := true;

        end;
    finally
        Free;
    end;
end;

procedure TfrmArticulos.FactordeVentas1Click(Sender: TObject);
var registros,nart,n: integer;
importef,factor,factual :real;
precio,cantidad:string;
art : array of integer;
sqll : string;
begin
 with dmDatos.qryConsulta do begin
  Close;
        SQL.Clear;
        SQL.Add('select count(distinct(fecha)) as cnt from VENTAS');
        Open;
            registros := FieldByName('cnt').AsInteger;
  Close;
 end;

  with dmDatos.qryConsulta do begin
  Close;
        SQL.Clear;
        SQL.Add('select count(distinct(articulo)) as cnt from VENTASDET');
        Open;
            nart:= FieldByName('cnt').AsInteger;
              SetLength(art, nart);
  Close;
 end;


  with dmDatos.qryConsulta do begin
  Close;
        SQL.Clear;
        SQL.Add('select distinct(articulo) from VENTASDET');
        Open;
        n:=0;
         while(not Eof) do begin
          art[n]:= FieldByName('articulo').AsInteger;
          n := n+1;
          next;
        end;

   Close;
 end;

 for n:=0 to  nart-1 do
 begin

  with dmDatos.qryConsulta  do
     begin
         Close;
         SQL.Clear;
          SQL.Add('select FACTORVENTAS as fact from articulos where clave = '+ inttostr(art[n]));
         open;

           factual :=  strtofloat(dmDatos.qryConsulta.FieldByName('fact').Asstring);
           close;
         end;

   with dmDatos.qryConsulta do begin
  Close;
        SQL.Clear;
       // sqll := 'select sum(cantidad*precio)as precio from VENTASDET where articulo = ''' + inttostr(art[n]) +'''';
        SQL.Add('select sum(cantidad)as precio from VENTASDET where articulo = ''' + inttostr(art[n]) +'''');
        Open;

        precio:=  trim(FieldByName('precio').Asstring);

      importef := strtofloat(precio);

     // ShowMessage(floattostr(factor));

       factor:= importef/registros;

 end;
    Close;
     with dmDatos.qryModifica do
     begin


           if (factual > 0) then
           begin
            factor := (factual + factor) /2;
           end;


          Close;
          SQL.Clear;
          SQL.Add('UPDATE articulos SET factorventas =  '+ floattostr(factor) + 'where clave = '+ inttostr(art[n]));
          ExecSQL;

     end;
     close;


 end;




  ShowMessage('Factor de ventas calculado');

end;

end.

// TODO la existencia del campo TIPO en articulos se debe por la compatibilidad con
//      el tipo de articulo GASTOS

