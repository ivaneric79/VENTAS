// --------------------------------------------------------------------------
// Archivo del Proyecto Ventas
// P�gina del proyecto: http://sourceforge.net/projects/ventas
// --------------------------------------------------------------------------
// Este archivo puede ser distribuido y/o modificado bajo lo terminos de la
// Licencia P�blica General versi�n 2 como es publicada por la Free Software
// Fundation, Inc.
// --------------------------------------------------------------------------

unit Descuentos;

interface

uses
  SysUtils, Types, Classes, Variants, QTypes, QGraphics, QControls, QForms,
  QDialogs, QStdCtrls, FMTBcd, DBXpress, DB, SqlExpr, QMenus, QExtCtrls,
  QGrids, QDBGrids, QButtons, QcurrEdit, QComCtrls, IniFiles;

type
  TfrmDescuentos = class(TForm)
    pgeGeneral: TPageControl;
    tabDatos: TTabSheet;
    grpArticulo: TGroupBox;
    Label1: TLabel;
    txtCodigo: TEdit;
    Label3: TLabel;
    txtDescripCorta: TEdit;
    grpFechas: TGroupBox;
    Label2: TLabel;
    Label4: TLabel;
    txtDiaIni: TEdit;
    txtMesIni: TEdit;
    txtAnioIni: TEdit;
    Label30: TLabel;
    Label31: TLabel;
    txtDiaFin: TEdit;
    txtMesFin: TEdit;
    txtAniofin: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    grpCategoria: TGroupBox;
    cmbCategorias: TComboBox;
    grpDepartamento: TGroupBox;
    cmbDeptos: TComboBox;
    grpDescuento: TGroupBox;
    rdbCantidad: TRadioButton;
    txtCantidad: TcurrEdit;
    rdbPorcentaje: TRadioButton;
    grpTotal: TGroupBox;
    txtTotal: TcurrEdit;
    btnInsertar: TBitBtn;
    btnEliminar: TBitBtn;
    btnModificar: TBitBtn;
    btnGuardar: TBitBtn;
    btnCancelar: TBitBtn;
    tabBusqueda: TTabSheet;
    pnlDeptos: TPanel;
    Label20: TLabel;
    cmbDeptosBusq: TComboBox;
    pnlCategorias: TPanel;
    Label18: TLabel;
    cmbCategBusq: TComboBox;
    pnlVentas: TPanel;
    lable23: TLabel;
    txtTotalBusq: TcurrEdit;
    pnlArticulo: TPanel;
    Label19: TLabel;
    txtCodigoBusq: TEdit;
    grdListado: TDBGrid;
    rdgBuscar: TRadioGroup;
    rdgOrden: TRadioGroup;
    btnBuscar: TBitBtn;
    btnSeleccionar: TBitBtn;
    btnLimpiar: TBitBtn;
    Label17: TLabel;
    txtRegistros: TcurrEdit;
    MainMenu1: TMainMenu;
    Archivo1: TMenuItem;
    mnuInsertar: TMenuItem;
    mnuEliminar: TMenuItem;
    mnuModificar: TMenuItem;
    N3: TMenuItem;
    mnuGuardar: TMenuItem;
    mnuCancelar: TMenuItem;
    N6: TMenuItem;
    Buscarproveedor1: TMenuItem;
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
    txtPrecio: TcurrEdit;
    Label7: TLabel;
    rdgTipoDesc: TRadioGroup;
    Label8: TLabel;
    grpVolumen: TGroupBox;
    txtVolumen: TcurrEdit;
    chkVolumen: TCheckBox;
    pnlAgranel: TPanel;
    Label22: TLabel;
    pnlJuego: TPanel;
    Label23: TLabel;
    pnlNoInventariable: TPanel;
    Label24: TLabel;
    pnlNormal: TPanel;
    Label25: TLabel;
    procedure FormShow(Sender: TObject);
    procedure rdbCantidadClick(Sender: TObject);
    procedure btnInsertarClick(Sender: TObject);
    procedure rdgBuscarClick(Sender: TObject);
    procedure btnGuardarClick(Sender: TObject);
    procedure btnBuscarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnLimpiarClick(Sender: TObject);
    procedure grdListadoEnter(Sender: TObject);
    procedure grdListadoExit(Sender: TObject);
    procedure btnSeleccionarClick(Sender: TObject);
    procedure Salta(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnModificarClick(Sender: TObject);
    procedure btnEliminarClick(Sender: TObject);
    procedure mnuProvedClick(Sender: TObject);
    procedure mnuBusquedaClick(Sender: TObject);
    procedure pgeGeneralChange(Sender: TObject);
    procedure mnuAvanzaClick(Sender: TObject);
    procedure mnuRetrocedeClick(Sender: TObject);
    procedure Buscarproveedor1Click(Sender: TObject);
    procedure txtCodigoChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Salir1Click(Sender: TObject);
    procedure rdgTipoDescClick(Sender: TObject);
    procedure chkVolumenClick(Sender: TObject);
    procedure grdListadoDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure txtAnioIniExit(Sender: TObject);
    procedure txtAniofinExit(Sender: TObject);
    procedure txtDiaIniExit(Sender: TObject);

  private
    { Private declarations }
    sModo,sArticulo: String;
    iClave: integer;

    procedure VerificaCategs;
    procedure VerificaDeptos;
    procedure LimpiaDatos;
    procedure ActivaControles;
    procedure Colores(clColor : TColor);
    procedure ActivaBuscar;
    procedure RecuperaDatos;
    procedure RecuperaConfig;
    procedure GuardaDatos;
    procedure RecuperaDatosBusq;
    procedure BuscaArticulo(Sender : TObject; sTipo : String);
    procedure Rellena(Sender: TObject);

    function VerificaDatos : boolean;
    function VerificaCantidades (var sDescripcion, sNum : string): boolean;
    function ClaveCarga(sBusqueda:string; sConsulta:string):Integer;
    function VerificaFechas(sFecha:string):boolean;
    function BuscaDepto(iDepto:Integer):String;
    function BuscaCateg(iCateg:Integer):String;
  public

    { Public declarations }
  end;

var
  frmDescuentos: TfrmDescuentos;

implementation

uses dm , ArticuloBusq;


{$R *.xfm}

procedure TfrmDescuentos.FormShow(Sender: TObject);
begin
    rdgBuscarClick(rdgBuscar);
    rdgTipoDescClick(Sender);
    rdbCantidadClick(Sender);

    VerificaCategs;
    VerificaDeptos;

    LimpiaDatos;
    sModo := 'Consulta';
    ActivaControles;
    ActivaBuscar;
    pgeGeneral.ActivePage := tabBusqueda;
    RecuperaDatos;
    cmbCategorias.ItemIndex := 0;
    cmbDeptos.ItemIndex := 0;
    btnBuscarClick(Sender);
    chkVolumenClick(Sender);
end;

procedure TfrmDescuentos.rdbCantidadClick(Sender: TObject);
begin
    if(rdbCantidad.Checked) then
        txtCantidad.Sufix := ''
    else if(rdbPorcentaje.Checked) then
        txtCantidad.Sufix := '%';
    txtCantidad.Value := txtCantidad.Value;
end;

procedure TfrmDescuentos.VerificaCategs;
begin
    with dmDatos.qryModifica do begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT * FROM categorias WHERE tipo = ' + QuotedStr('A'));
        Open;

        if(Eof) then begin
            Close;
            SQL.Clear;
            SQL.Add('INSERT INTO categorias (nombre, tipo, fecha_umov, cuenta) VALUES');
            SQL.Add('(''DEFAULT'',''A'',''' + FormatDateTime('mm/dd/yyyy',Date) + ''',');
            SQL.Add(''''')');
            ExecSQL;
        end;
        Close;
    end;
end;
procedure TfrmDescuentos.VerificaDeptos;
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

procedure TfrmDescuentos.LimpiaDatos;
begin
    txtDiaIni.Clear;
    txtMesIni.Clear;
    txtAnioIni.Clear;
    txtDiaFin.Clear;
    txtMesFin.Clear;
    txtAnioFin.Clear;
    txtCodigo.Clear;
    txtDescripCorta.Clear;
    txtTotal.Value := 0;
    txtCantidad.Value := 0;
    cmbCategorias.ItemIndex := -1;
    cmbDeptos.ItemIndex := -1;
    btnLimpiar.Click;
end;

procedure TfrmDescuentos.ActivaControles;
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

        txtDiaIni.ReadOnly := False;
        txtMesIni.ReadOnly := False;
        txtAnioIni.ReadOnly := False;
        txtDiaFin.ReadOnly := False;
        txtMesFin.ReadOnly := False;
        txtAnioFin.ReadOnly := False;
        txtCodigo.ReadOnly := False;
        txtTotal.ReadOnly := False;
        txtCantidad.ReadOnly := False;

        txtDiaIni.TabStop := True;
        txtMesIni.TabStop := True;
        txtAnioIni.TabStop := True;
        txtDiaFin.TabStop := True;
        txtMesFin.TabStop := True;
        txtAnioFin.TabStop := True;
        txtCodigo.TabStop := True;
        txtTotal.TabStop := True;
        txtCantidad.TabStop := True;

        cmbCategorias.Enabled := True;
        cmbDeptos.Enabled := True;
        rdgTipoDesc.Enabled := True;
        rdbCantidad.Enabled := True;
        rdbPorcentaje.Enabled := True;
        chkVolumen.Enabled := True;
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

        txtDiaIni.ReadOnly := True;
        txtMesIni.ReadOnly := True;
        txtAnioIni.ReadOnly := True;
        txtDiaFin.ReadOnly := True;
        txtMesFin.ReadOnly := True;
        txtAnioFin.ReadOnly := True;
        txtCodigo.ReadOnly := True;
        txtTotal.ReadOnly := True;
        txtCantidad.ReadOnly := True;

        txtDiaIni.TabStop := False;
        txtMesIni.TabStop := False;
        txtAnioIni.TabStop := False;
        txtDiaFin.TabStop := False;
        txtMesFin.TabStop := False;
        txtAnioFin.TabStop := False;
        txtCodigo.TabStop := False;
        txtTotal.TabStop := False;
        txtCantidad.TabStop := False;

        cmbCategorias.Enabled := False;
        cmbDeptos.Enabled := False;
        rdgTipoDesc.Enabled := False;
        rdbCantidad.Enabled := False;
        rdbPorcentaje.Enabled := False;
        chkVolumen.Enabled := False;
    end;
end;

procedure TfrmDescuentos.Colores(clColor : TColor);
begin 
    txtDiaIni.Font.Color := clColor;
    txtMesIni.Font.Color := clColor;
    txtAnioIni.Font.Color := clColor;
    txtDiaFin.Font.Color := clColor;
    txtMesFin.Font.Color := clColor;
    txtAnioFin.Font.Color := clColor;
    txtCodigo.Font.Color := clColor;
    txtTotal.Font.Color := clColor;
    txtCantidad.Font.Color := clColor;
    txtVolumen.Font.Color := clColor;
end;

procedure  TfrmDescuentos.ActivaBuscar;
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

procedure TfrmDescuentos.RecuperaDatos;
begin
    with dmDatos.qryModifica do begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT nombre FROM categorias WHERE tipo=''A'' ORDER BY nombre');
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
    with dmDatos.qryModifica do begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT nombre FROM departamentos  ORDER BY nombre');
        Open;
        cmbDeptos.Items.Clear;
        cmbDeptosBusq.Items.Clear;
        while (not Eof) do begin
            cmbDeptos.Items.Add(Trim(FieldByName('nombre').AsString));
            cmbDeptosBusq.Items.Add(Trim(FieldByName('nombre').AsString));
            Next;
        end;
        Close;
    end;
end;

procedure TfrmDescuentos.RecuperaConfig;
var
    iniArchivo : TIniFile;
    sIzq, sArriba, sValor : String;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) +'config.ini');

    with iniArchivo do begin
        //Recupera la posici�n Y de la ventana
        sArriba := ReadString('Descuentos', 'Posy', '');

        //Recupera la posici�n X de la ventana
        sIzq := ReadString('Descuentos', 'Posx', '');

        if (Length(sIzq) > 0) and (Length(sArriba) > 0) then begin
            Left := StrToInt(sIzq);
            Top := StrToInt(sArriba);
        end;

        //Recupera el valor de los botones de radio de buscar
        sValor := ReadString('Descuentos', 'Buscar', '');
        if (Length(sValor) > 0) then
            rdgBuscar.ItemIndex := StrToInt(sValor);

        //Recupera el valor de los botones de radio de orden
        sValor := ReadString('Descuentos', 'Orden', '');
        if (Length(sValor) > 0) then
            rdgOrden.ItemIndex := StrToInt(sValor);
        Free;
    end;
end;

procedure TfrmDescuentos.btnInsertarClick(Sender: TObject);
var
    sFecha:String;
begin
    pgeGeneral.ActivePage := tabDatos;
    sModo := 'Insertar';
    ActivaControles;
    LimpiaDatos;

    sFecha := FormatDateTime('dd/mm/yyyy',Date);

    txtDiaIni.Text := Copy(sFecha,1,2);
    txtMesIni.Text := Copy(sFecha,4,2);
    txtAnioIni.Text := Copy(sFecha,7,4);

    pgeGeneral.ActivePage := tabDatos;
    cmbCategorias.ItemIndex :=0;
    cmbDeptos.ItemIndex :=0;

    txtDiaIni.SetFocus;
end;

procedure TfrmDescuentos.rdgBuscarClick(Sender: TObject);
begin
    pnlArticulo.Enabled := false;
    pnlArticulo.Visible := false;
    pnlCategorias.Enabled := false;
    pnlCategorias.Visible := false;
    pnlDeptos.Enabled := false;
    pnlDeptos.Visible := false;
    pnlVentas.Enabled := false;
    pnlVentas.Visible := false;
    case rdgBuscar.ItemIndex of
        0: begin
            pnlArticulo.Enabled := True;
            pnlArticulo.Visible := True;
            if(pgeGeneral.ActivePage = tabBusqueda) then
                txtCodigoBusq.SetFocus;
           end;
        1: begin
            pnlCategorias.Enabled := True;
            pnlCategorias.Visible := True;
            if(pgeGeneral.ActivePage = tabBusqueda) then
                cmbCategBusq.SetFocus;
           end;
        2: begin
            pnlDeptos.Enabled := True;
            pnlDeptos.Visible := True;
            if(pgeGeneral.ActivePage = tabBusqueda) then
                cmbDeptosBusq.SetFocus;
           end;
        3: begin
           pnlVentas.Enabled := True;
           pnlVentas.Visible := True;
           if(pgeGeneral.ActivePage = tabBusqueda) then
               txtTotalBusq.SetFocus;
          end;
    end;
end;

procedure TfrmDescuentos.btnGuardarClick(Sender: TObject);
begin
    btnGuardar.SetFocus;
    if(VerificaDatos) then begin
        GuardaDatos;
        sModo := 'Consulta';
        ActivaControles;
        btnInsertar.SetFocus;
    end;
end;

function TfrmDescuentos.VerificaDatos:boolean;
var
    sFecha1, sFecha2, sDescripcion, sNum : String;
    dFecha1, dFecha2 : TDateTime;
begin
    Result := True;
    sFecha1 := Trim(txtDiaIni.Text) + '/' + Trim(txtMesIni.text) + '/' + Trim(txtAnioIni.Text);
    sFecha2 := Trim(txtDiaFin.Text) + '/' + Trim(txtMesFin.text) + '/' + Trim(txtAnioFin.Text);

    if(txtDiaIni.Text = '') or (txtMesIni.Text = '') or (txtAnioIni.Text = '') then begin
        Application.MessageBox('La fecha inicial no puede estar vacia','Error',[smbOK],smsCritical);
        txtDiaIni.SetFocus;
        Result := False;
    end
    else if(txtDiaFin.Text = '') or (txtMesFin.Text = '') or (txtAnioFin.Text = '') then begin
        Application.MessageBox('La fecha final no puede estar vacia','Error',[smbOK],smsCritical);
        txtDiaFin.SetFocus;
        Result := False;
    end
    else if not VerificaFechas(sFecha1)then begin
        txtDiaIni.SetFocus;
        Result := False;
    end
    else if not VerificaFechas(sFecha2) then  begin
        txtDiaFin.SetFocus;
        Result := False;
    end
    else begin
        dFecha1:=StrToDateTime(sFecha1);
        dFecha2:=StrToDateTime(sFecha2);

        if(dFecha1 > dFecha2) then begin
            Application.MessageBox('La fecha inicial no puede ser mayor a la final','Error',[smbOK],smsCritical);
            txtDiaIni.SetFocus;
            Result := False;
        end
        else if (rdgTipoDesc.ItemIndex = 0) and (rdbCantidad.Checked) and (txtCantidad.Value <= 0)then begin
            Application.MessageBox('Introduce una cantidad','Error',[smbOK],smsCritical);
            txtCantidad.SetFocus;
            Result := False;
        end
        else if (rdgTipoDesc.ItemIndex = 0) and (rdbCantidad.Checked) and (txtCantidad.Value >= txtPrecio.Value) then begin
            Application.MessageBox('Introduce una cantidad menor al precio','Error',[smbOK],smsCritical);
            txtCantidad.SetFocus;
            Result :=False;
        end
        else if (rdbPorcentaje.Checked) and (txtCantidad.Value <= 0) then begin
            Application.MessageBox('Introduce un porcentaje','Error',[smbOK],smsCritical);
            txtCantidad.SetFocus;
            Result := False;
        end
        else if (rdbPorcentaje.Checked) and (txtCantidad.Value>99) then begin
            Application.MessageBox('Introduce un porcentaje menor a 100','Error',[smbOK],smsCritical);
            txtCantidad.SetFocus;
            Result :=False;
        end
        else if (rdgTipoDesc.ItemIndex = 0) and (Length(sArticulo) <= 0)  then begin
            Application.MessageBox('Introduce un art�culo v�lido','Error',[smbOK],smsCritical);
            txtCodigo.SetFocus;
            Result := False;
        end
        else if (rdgTipoDesc.ItemIndex = 1) and (cmbCategorias.ItemIndex < 0) then begin
            Application.MessageBox('Selecciona una categor�a','Error',[smbOK],smsCritical);
            cmbCategorias.SetFocus;
            Result := False;
        end
        else if (rdgTipoDesc.ItemIndex = 2) and (cmbDeptos.ItemIndex < 0) then begin
            Application.MessageBox('Selecciona un departamento','Error',[smbOK],smsCritical);
            cmbDeptos.SetFocus;
            Result := False;
        end
        else if (rdgTipoDesc.ItemIndex = 3) and (txtTotal.Value <= 0) then begin
            Application.MessageBox('Introduce un total de venta','Error',[smbOK],smsCritical);
            txtTotal.SetFocus;
            Result := False;
        end
        else if (chkVolumen.Checked) and (txtVolumen.Value <= 0) then begin
            Application.MessageBox('Introduce un volumen de venta','Error',[smbOK],smsCritical);
            txtVolumen.SetFocus;
            Result := False;
        end
        else
        if (not VerificaCantidades(sDescripcion, sNum)) and (rdbCantidad.Checked) then begin
            Application.MessageBox('El valor introducido en Cantidad excede el precio'+sNum+' de '+
                                    sDescripcion,'Error',[smbOK],smsCritical);
            txtCantidad.SetFocus;
            Result :=False;
        end;
    end;
end;

procedure TfrmDescuentos.GuardaDatos;
var
    sFecha1, sFecha2, sDeptos, sCateg, sCodigo, sTotal, sVolumen, sCantidad, sPorcentaje : String;
begin
    with dmDatos.qryModifica do begin

        sFecha1 := '''' + Trim(txtMesIni.Text) + '/' + Trim(txtDiaIni.Text) + '/' + Trim(txtAnioIni.Text) + '''';
        sFecha2 := '''' + Trim(txtMesFin.Text) + '/' + Trim(txtDiaFin.Text) + '/' + Trim(txtAnioFin.Text) + '''';

        sCodigo := 'null';
        sCateg  := 'null';
        sDeptos := 'null';
        sTotal := '0';
        case rdgTipoDesc.ItemIndex of
            0 : sCodigo := '''' + sArticulo + '''';
            1 : sCateg  := IntToStr(Clavecarga(cmbCategorias.Items.Strings[cmbCategorias.ItemIndex],'C'));
            2 : sDeptos := IntToStr(Clavecarga(cmbDeptos.Items.Strings[cmbDeptos.ItemIndex],'D'));
            3 : sTotal := FloatToStr(txtTotal.Value);
        end;

        sVolumen := '0';
        if (chkVolumen.Checked) then
            sVolumen := FloatToStr(txtVolumen.Value);

        sCantidad := '0';
        sPorcentaje := '0';
        if (rdbCantidad.Checked) then
            sCantidad := FloatToStr(txtCantidad.Value)
        else
            sPorcentaje := FloatToStr(txtCantidad.Value);


        Close;
        SQL.Clear;

        if(sModo = 'Insertar') then begin
            SQL.Add('INSERT INTO descuentos (fechaini,fechafin,articulo,departamento,categoria,total,cantidad,porcentaje,volumen)');
            SQL.Add('VALUES(');
            SQL.Add( sFecha1 + ',' + sFecha2 + ',' + sCodigo + ',' + sDeptos + ',');
            SQL.Add( sCateg + ',' + sTotal + ',' + sCantidad + ',' + sPorcentaje + ','+ sVolumen +')');
        end
        else begin
            SQL.Add('UPDATE descuentos SET fechaini= ' + sFecha1 + ',');
            SQL.Add('fechafin = ' + sFecha2 + ',');
            SQL.Add('articulo = ' + sCodigo + ',');
            SQL.Add('departamento = ' +sDeptos + ',');
            SQL.Add('categoria = ' + sCateg  + ',');
            SQL.Add('total =' + sTotal + ',');
            SQL.Add('cantidad = ' + sCantidad + ',');
            SQL.Add('porcentaje = ' + sPorcentaje + ',');
            SQL.Add('volumen = ' + sVolumen);
            SQL.Add('WHERE clave ='+ IntToStr(iClave));
        end;
        ExecSQL;
        Close;
    end;
end;

function TfrmDescuentos.ClaveCarga(sBusqueda:string; sConsulta:string):Integer;
begin
        with dmDatos.qryModifica do begin
             Close;
             SQL.Clear;

             if (sConsulta = 'C') then Begin
                SQL.Add('SELECT clave FROM categorias WHERE nombre = ''' + sBusqueda + '''');
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

function TfrmDescuentos.VerificaFechas(sFecha:string):boolean;
var
   dteFecha : TDateTime;
begin
    Result := true;
    if (not TryStrToDate(sFecha,dteFecha)) then begin
        Application.MessageBox('Introduce una fecha v�lida','Error',[smbOK],smsCritical);
        Result := false;
    end;
end;

function TfrmDescuentos.VerificaCantidades (var sDescripcion, sNum : string): boolean;
var
    sCant, sCateg, sDepto : string;
    i : byte;
begin
    Result:= True;
    sCant := FloatToStr(txtCantidad.Value);

    with dmDatos.qryConsulta do begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT desc_larga, precio1, precio2, precio3, precio4 ');
        SQL.Add('FROM articulos WHERE ((precio1 - ' + sCant + ' <= 0 AND precio1 > 0)');
        SQL.Add('OR (precio2 - ' + sCant + '<= 0 AND precio2 > 0)');
        SQL.Add('OR (precio3 - ' + sCant + '<= 0 AND precio3 > 0)');
        SQL.Add('OR (precio4 - ' + sCant + '<= 0 AND precio4 > 0))');
        
        case rdgTipoDesc.ItemIndex of
            0 : begin
                    SQL.Add('AND clave IN (SELECT articulo FROM codigos WHERE codigo = ''' + txtCodigo.Text + ''')');
                end;
            1 : begin
                    sCateg := IntToStr(ClaveCarga(cmbCategorias.Items.Strings[cmbCategorias.ItemIndex],'C'));
                    SQL.Add('AND categoria = ' + sCateg );
                end;
            2 : begin
                    sDepto := IntToStr(ClaveCarga(cmbDeptos.Items.Strings[cmbDeptos.ItemIndex],'D'));
                    SQL.Add('AND departamento = ' + sDepto);
                end;
        end;
        Open;

        while (not Eof) do begin
            for i := 1 to 4 do
                if (Fields[i].Value - txtCantidad.Value <= 0) then begin
                    sNum := IntToStr(i);
                    sDescripcion := Trim(FieldByName('desc_larga').AsString);
                    Result:=False;
                    Break;
                end;
            Next;    
        end;
    end;
end;

procedure TfrmDescuentos.btnBuscarClick(Sender: TObject);
var
    sBM : String;
begin
    with dmDatos.qryListados do begin
        sBM := dmDatos.cdsCliente.Bookmark;

        dmDatos.cdsCliente.Active := false;
        Close;
        SQL.Clear;
        SQL.Add('SELECT d.clave, a.desc_corta AS articulo, c.nombre AS categorias, dep.Nombre AS Departamentos, d.Total, ');
        SQL.Add('d.porcentaje, d.cantidad FROM descuentos d LEFT JOIN categorias c ON d.categoria = c.clave');
        SQL.Add('LEFT JOIN departamentos dep ON d.departamento = dep.clave  LEFT JOIN articulos a ON d.articulo = a.clave WHERE 1 = 1');

        case rdgBuscar.ItemIndex of
            0:  if(Length(txtCodigo.Text)>0) then begin
                    SQL.Add('AND d.articulo STARTING ''' + txtCodigoBusq.Text + '''');
                end;
            1:  if(cmbCategBusq.ItemIndex > -1) then begin
                    SQL.Add('AND d.categoria = ''' + IntToStr(ClaveCarga(cmbCategBusq.Items.Strings[cmbCategBusq.ItemIndex],'C')) + '''');
                end;
            2:  if(cmbDeptosBusq.ItemIndex > -1) then
                    SQL.Add('AND d.departamento = ''' + IntToStr(ClaveCarga(cmbDeptosBusq.Items.Strings[cmbDeptosBusq.ItemIndex],'D')) + '''');
            3:  SQL.Add('AND d.total STARTING ''' + FloatToStr(txtTotalBusq.Value) + '''');
        end;

        case rdgOrden.ItemIndex of
            0: SQL.Add('ORDER BY d.articulo');
            1: SQL.Add('ORDER BY c.nombre');
            2: SQL.Add('ORDER BY dep.nombre');
            3: SQL.Add('ORDER BY d.Total');
        end;

        Open;
        dmDatos.cdsCliente.Active := true;
        dmDatos.cdsCliente.FieldByName('clave').Visible := False;
        dmDatos.cdsCliente.FieldByName('articulo').DisplayLabel := 'Art�culo';
        dmDatos.cdsCliente.FieldByName('articulo').DisplayWidth := 30;
        dmDatos.cdsCliente.FieldByName('categorias').DisplayLabel := 'Categoria';
        dmDatos.cdsCliente.FieldByName('categorias').DisplayWidth := 15;
        dmDatos.cdsCliente.FieldByName('departamentos').DisplayLabel := 'Departamento';
        dmDatos.cdsCliente.FieldByName('departamentos').DisplayWidth := 15;
        dmDatos.cdsCliente.FieldByName('total').DisplayLabel := 'Total';
        dmDatos.cdsCliente.FieldByName('total').DisplayWidth := 12;
        (dmDatos.cdsCliente.FieldByName('total') as TNumericField).DisplayFormat := '###,##0.00';
        dmDatos.cdsCliente.FieldByName('porcentaje').DisplayLabel := 'Porcentaje';
        dmDatos.cdsCliente.FieldByName('porcentaje').DisplayWidth := 10;
        (dmDatos.cdsCliente.FieldByName('porcentaje') as TNumericField).DisplayFormat := '##0.00';
        dmDatos.cdsCliente.FieldByName('cantidad').DisplayLabel := 'Cantidad';
        dmDatos.cdsCliente.FieldByName('cantidad').DisplayWidth := 12;
        (dmDatos.cdsCliente.FieldByName('cantidad') as TNumericField).DisplayFormat := '###,##0.000';

        if(pgeGeneral.ActivePage = tabBusqueda) then
            grdListado.SetFocus;

        txtRegistros.Value := dmDatos.cdsCliente.RecordCount;
        try
            dmDatos.cdsCliente.Bookmark := sBM;
        except
            txtRegistros.Value := txtRegistros.Value;
       end;
    end;
end;

procedure TfrmDescuentos.btnCancelarClick(Sender: TObject);
begin
    sModo := 'Consulta';
    LimpiaDatos;
    ActivaControles;
    pgeGeneral.ActivePage := tabBusqueda;
end;

procedure TfrmDescuentos.btnLimpiarClick(Sender: TObject);
begin
    txtCodigoBusq.Clear;
    cmbCategBusq.ItemIndex := -1;
    cmbDeptosBusq.ItemIndex := -1;
    txtTotalBusq.Value:=0;
end;

procedure TfrmDescuentos.grdListadoEnter(Sender: TObject);
begin
    btnBuscar.Default := false;
    btnSeleccionar.Default := true;
end;

procedure TfrmDescuentos.grdListadoExit(Sender: TObject);
begin
    btnBuscar.Default := true;
    btnSeleccionar.Default := false;
end;

procedure TfrmDescuentos.btnSeleccionarClick(Sender: TObject);
begin
    if (txtRegistros.Value > 0) then begin
        sModo := 'Consulta';
        pgeGeneral.ActivePage := tabDatos;
        LimpiaDatos;
        RecuperaDatosBusq;
        ActivaBuscar;
        ActivaControles;
    end;
end;

procedure TfrmDescuentos.RecuperaDatosBusq;
var
    sFechaIni, sFechaFin, sDeptos,SCateg: String;
begin

    iClave := dmDatos.cdsCliente.FieldByName('clave').AsInteger;

     with dmDatos.qryConsulta do begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT * FROM descuentos WHERE clave = ' + IntToStr(iClave));
        Open;

        if(not Eof) then begin
            iClave := FieldByName('clave').AsInteger;
            sFechaIni := FormatDateTime('dd/mm/yyyy',FieldByname('fechaini').AsDateTime);
            txtDiaIni.Text := Copy(sFechaIni,1,2);
            txtMesIni.Text := Copy(sFechaIni,4,2);
            txtAnioIni.Text := Copy(sFechaIni,7,4);

            sFechaFin := FormatDateTime('dd/mm/yyyy',FieldByname('fechafin').AsDateTime);
            txtDiaFin.Text := Copy(sFechaFin,1,2);
            txtMesFin.Text := Copy(sFechaFin,4,2);
            txtAnioFin.Text := Copy(sFechaFin,7,4);

            if (Length(FieldByName('articulo').AsString) > 0) then begin
                rdgTipoDesc.ItemIndex :=  0;
                sArticulo:= FieldByName('articulo').AsString;
                BuscaArticulo(txtCodigo,'Cargar');
                txtCodigo.Text := sArticulo;
            end;

            if ((FieldByName('categoria').AsInteger)>0) then
                rdgTipoDesc.ItemIndex :=  1;
            sCateg := BuscaCateg(FieldByName('Categoria').AsInteger);

            if ((FieldByName('departamento').AsInteger) > 0) then
                rdgTipoDesc.ItemIndex :=  2;
            sDeptos := BuscaDepto(FieldByName('departamento').AsInteger);

            if ((FieldByName('total').AsFloat) > 0) then
                rdgTipoDesc.ItemIndex :=  3;
            txtTotal.Value := FieldByName('total').AsFloat;

            if ((FieldByName('volumen').AsFloat) > 0) then
                chkVolumen.Checked := True
            else
               chkVolumen.Checked := False;
            txtVolumen.Value := FieldByName('volumen').AsFloat;

            if (FieldByName('cantidad').AsFloat>0) then begin
                rdbCantidad.Checked := True;
                txtCantidad.Value := FieldByName('cantidad').AsFloat;
            end
            else begin
                rdbPorcentaje.Checked := True;
                txtCantidad.Value := FieldByName('porcentaje').AsFloat;
            end;

            cmbDeptos.ItemIndex := cmbDeptos.Items.IndexOf(Trim(sDeptos));
            cmbCategorias.ItemIndex := cmbCategorias.Items.IndexOf(Trim(sCateg));
            rdgTipoDescClick(Self);

//            btnLimpiar.Click;
            txtCodigoChange(txtCodigo)
        end;
        Close;
    end;
end;

function TfrmDescuentos.BuscaDepto(iDepto:Integer):String;
begin
     with dmDatos.qryModifica do begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT nombre FROM departamentos WHERE clave = ' + IntToStr(iDepto));
        Open;
        Result := FieldByName('nombre').AsString;
        Close;
     end;
end;

function TfrmDescuentos.BuscaCateg(iCateg:Integer):String;
begin
     with dmDatos.qryModifica do begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT nombre FROM categorias WHERE clave = ' + IntToStr(iCateg));
        Open;
        Result := FieldByName('nombre').AsString;
        Close;
     end;
end;

procedure TfrmDescuentos.Salta(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    {Inicio (36), Fin (35), Izquierda (37), derecha (39), arriba (38), abajo (40)}
    if(Key >= 30) and (Key <= 122) and (Key <> 35) and (Key <> 36) and not ((Key >= 37) and (Key <= 40)) then
        if( Length((Sender as TEdit).Text) = (Sender as TEdit).MaxLength) then
            SelectNext(Sender as TWidgetControl, true, true);
end;

procedure TfrmDescuentos.btnModificarClick(Sender: TObject);
begin
    sModo := 'Modificar';
    ActivaControles;
    chkVolumenClick(Sender);
    pgeGeneral.ActivePageIndex := 0;
    txtDiaIni.SetFocus;
end;

procedure TfrmDescuentos.btnEliminarClick(Sender: TObject);
begin
    pgeGeneral.ActivePage := tabDatos;
    if(Application.MessageBox('Se eliminar� el descuento seleccionado','Eliminar',[smbOK]+[smbCancel],smsWarning) = smbOK) then begin
        with dmDatos.qryModifica do begin
            Close;
            SQL.Clear;
            SQL.Add('DELETE FROM descuentos WHERE clave = ' + IntToStr(iClave));
            ExecSQL;
            Close;
        end;

        LimpiaDatos;
        sModo := 'Consulta';
        ActivaControles;
        btnBuscarClick(Sender);
    end;
end;

procedure TfrmDescuentos.mnuProvedClick(Sender: TObject);
begin
    pgeGeneral.ActivePage := tabDatos;
    ActivaBuscar;
end;

procedure TfrmDescuentos.mnuBusquedaClick(Sender: TObject);
begin
    pgeGeneral.ActivePage := tabBusqueda;
    ActivaBuscar;
end;

procedure TfrmDescuentos.pgeGeneralChange(Sender: TObject);
begin
    ActivaBuscar;
end;

procedure TfrmDescuentos.mnuAvanzaClick(Sender: TObject);
begin
    with dmDatos.cdsCliente do begin
        if(Active) then begin
            Next;
            if(pgeGeneral.ActivePage <> tabBusqueda) then begin
                RecuperaDatos;
                ActivaControles;
            end;
        end;
    end;
end;

procedure TfrmDescuentos.mnuRetrocedeClick(Sender: TObject);
begin
    with dmDatos.cdsCliente do begin
        if(Active) then begin
            Prior;
            if(pgeGeneral.ActivePage <> tabBusqueda) then begin
                RecuperaDatos;
                ActivaControles;
            end;
        end;
    end;
end;

procedure TfrmDescuentos.Buscarproveedor1Click(Sender: TObject);
begin
    if (txtCodigo.Focused) and (txtCodigo.Font.Color=clWindowText) then begin
        with TFrmArticuloBusq.Create(Self) do
         try
          ShowModal;
            if bSelec then
            txtCodigo.Text:= sCodigo;
         finally
          free;
         end;
    end;
end;

procedure TfrmDescuentos.txtCodigoChange(Sender: TObject);
begin
    BuscaArticulo(Sender,'Buscar');
end;

procedure TfrmDescuentos.BuscaArticulo(Sender: TObject; sTipo:String);
begin

    if (sTipo = 'Buscar') then begin
        with dmDatos.qryModifica do begin
            if(Length((Sender as TEdit).Text) > 0) then begin
                Close;
                SQL.Clear;
                SQL.Add('SELECT clave, desc_larga, precio1 FROM articulos ');
                SQL.Add('WHERE clave IN (SELECT articulo FROM codigos WHERE codigo = ''' + (Sender as TEdit).Text + ''')');
                Open;
                txtDescripCorta.Text := FieldByName('desc_larga').AsString;
                txtPrecio.Value := FieldByName('precio1').AsFloat;
                sArticulo := FieldByName('clave').AsString;
                Close;
            end
            else begin
                txtDescripCorta.Clear;
                txtPrecio.Clear;
            end;
        end;
    end
    else begin
        with dmDatos.qryModifica do begin
            Close;
            SQL.Clear;
            SQL.Add('SELECT codigo FROM codigos WHERE articulo = ' + sArticulo);
            Open;
            sArticulo := FieldByName('codigo').AsString;
            Close;
        end;
    end;
end;

procedure TfrmDescuentos.FormClose(Sender: TObject; var Action: TCloseAction);
var
    iniArchivo : TIniFile;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) +'config.ini');
    with iniArchivo do begin
        // Registra la posici�n y de la ventana
        WriteString('Descuentos', 'Posy', IntToStr(Top));

        // Registra la posici�n X de la ventana
        WriteString('Descuentos', 'Posx', IntToStr(Left));
        Free;
    end;
    dmDatos.qryListados.Close;
    dmDatos.cdsCliente.Active := False;
end;

procedure TfrmDescuentos.FormCreate(Sender: TObject);
begin
    RecuperaConfig;
end;

procedure TfrmDescuentos.Salir1Click(Sender: TObject);
begin
    Close;
end;

procedure TfrmDescuentos.rdgTipoDescClick(Sender: TObject);
begin
    grpArticulo.Enabled := false;
    grpCategoria.Enabled := false;
    grpDepartamento.Enabled := false;
    grpTotal.Enabled := false;
    chkVolumen.Enabled := true;

    case rdgTipoDesc.ItemIndex of
        0 : grpArticulo.Enabled := true;
        1 : grpCategoria.Enabled := true;
        2 : grpDepartamento.Enabled := true;
        3 : begin
              grpTotal.Enabled := true;
              chkVolumen.Checked := false;
              chkVolumen.Enabled := false;
              chkVolumenClick(Sender);
            end;
    end;
end;

procedure TfrmDescuentos.chkVolumenClick(Sender: TObject);
begin
    grpVolumen.Enabled := chkVolumen.Checked;
    txtVolumen.ReadOnly:= not chkVolumen.Checked;
    txtVolumen.TabStop := chkVolumen.Checked;
    rdbCantidad.Enabled := not chkVolumen.Checked;
end;

procedure TfrmDescuentos.grdListadoDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
     with dmDatos.cdsCliente do begin
        if (not FieldByName('articulo').IsNull) then
            grdListado.Canvas.Brush.Color := $0094E7ED
        else
        if (not FieldByName('categorias').IsNull) then
            grdListado.Canvas.Brush.Color := $0099A7F7
        else
        if (not FieldByName('departamentos').IsNull) then
            grdListado.Canvas.Brush.Color := $00DCBFA5
        else
        if (not FieldByName('total').IsNull) then
            grdListado.Canvas.Brush.Color := $00BFCAB7;
    end;
    grdListado.Canvas.FillRect(Rect);
    grdListado.DefaultDrawColumnCell(Rect,DataCol,Column,State);
end;

procedure TfrmDescuentos.txtAnioIniExit(Sender: TObject);
begin
    txtAnioIni.Text := Trim(txtAnioIni.Text);
    if(Length(txtAnioIni.Text) < 4) and (Length(txtAnioIni.Text) > 0) then
        txtAnioIni.Text := IntToStr(StrToInt(txtAnioIni.Text) + 2000);
end;

procedure TfrmDescuentos.txtAniofinExit(Sender: TObject);
begin
    txtAniofin.Text := Trim(txtAniofin.Text);
    if(Length(txtAniofin.Text) < 4) and (Length(txtAniofin.Text) > 0) then
        txtAniofin.Text := IntToStr(StrToInt(txtAniofin.Text) + 2000);
end;

procedure TfrmDescuentos.txtDiaIniExit(Sender: TObject);
begin
    Rellena(Sender);
end;

procedure TfrmDescuentos.Rellena(Sender: TObject);
var
    i : integer;
begin
    for i := Length((Sender as TEdit).Text) to (Sender as TEdit).MaxLength - 1 do
        (Sender as TEdit).Text := '0' + (Sender as TEdit).Text;
end;

end.

