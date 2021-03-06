// --------------------------------------------------------------------------
// Archivo del Proyecto Ventas   
// P�gina del proyecto: http://sourceforge.net/projects/ventas
// --------------------------------------------------------------------------
// Este archivo puede ser distribuido y/o modificado bajo lo terminos de la
// Licencia P�blica General versi�n 2 como es publicada por la Free Software
// Fundation, Inc.
// --------------------------------------------------------------------------

unit ArticuloBusq;

interface

uses
  SysUtils, Types, Classes, QGraphics, QControls, QForms, QDialogs,
  QStdCtrls, QExtCtrls, QcurrEdit, QButtons, QGrids, QDBGrids,IniFiles,
  QMenus, QTypes, DB, Qt;

type
  TfrmArticuloBusq = class(TForm)
    btnBuscar: TBitBtn;
    btnSeleccionar: TBitBtn;
    btnLimpiar: TBitBtn;
    Label26: TLabel;
    txtRegistros: TcurrEdit;
    Label22: TLabel;
    pnlAgranel: TPanel;
    pnlJuego: TPanel;
    Label23: TLabel;
    pnlNoInventariable: TPanel;
    Label24: TLabel;
    pnlNormal: TPanel;
    Label25: TLabel;
    btnCerrar: TBitBtn;
    Label2: TLabel;
    grpBuscar: TGroupBox;
    txtProv: TcurrEdit;
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
    grpListado: TGroupBox;
    grdListado: TDBGrid;
    rdgOrden: TRadioGroup;
    procedure btnBuscarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnLimpiarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure grdListadoDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure btnSeleccionarClick(Sender: TObject);
    procedure grdListadoEnter(Sender: TObject);
    procedure grdListadoExit(Sender: TObject);
    procedure Salir1Click(Sender: TObject);
    procedure Salta(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure txtProvChange(Sender: TObject);
    procedure BuscaProveedor(Sender: TObject);
    procedure rdgOrdenClick(Sender: TObject);
    procedure chkCategClick(Sender: TObject);
    procedure chkCodigoClick(Sender: TObject);
    procedure chkDescripClick(Sender: TObject);
    procedure chkProvClick(Sender: TObject);
    procedure chkDeptoClick(Sender: TObject);
  private
   function  ClaveCarga(sBusqueda:String ; sConsulta:String):Integer;
   procedure RecuperaDatos;
   procedure RecuperaConfig;

  public
    bSelec  :Boolean;
    sCodigo :String;
    bGasto : boolean;
  end;

var
  frmArticuloBusq: TfrmArticuloBusq;

implementation

uses dm;

{$R *.xfm}

procedure TfrmArticuloBusq.btnBuscarClick(Sender: TObject);
begin
    btnBuscar.SetFocus;
    with dmDatos.qryArticulos do begin
        dmDatos.cdsArticulos.Active := false;

        Close;
        SQL.Clear;
        if(bGasto) then begin
            SQL.Add('SELECT a.clave, a.tipo, o.codigo, a.desc_larga, a.desc_corta,');
            SQL.Add('c.nombre AS categoria FROM articulos a LEFT JOIN categorias c ON a.categoria = c.clave'); // , a.fiscal as F
            SQL.Add('LEFT JOIN codigos o ON a.clave = o.articulo AND o.tipo = ''P''');
            SQL.Add('WHERE a.estatus = ''A'' AND a.tipo = 4');
        end
        else begin
            SQL.Add('SELECT a.clave, a.tipo, o.codigo, a.desc_larga, a.desc_corta, a.precio1, a.existencia,');
            SQL.Add('c.nombre AS categoria, d.nombre AS departamento FROM articulos a LEFT JOIN categorias c ON a.categoria = c.clave');   //, a.fiscal as F
            SQL.Add('LEFT JOIN codigos o ON a.clave = o.articulo AND o.tipo = ''P''');
            SQL.Add('LEFT JOIN departamentos d ON a.departamento = d.clave WHERE a.estatus = ''A''');
            SQL.Add('AND a.tipo <> 4');
        end;

        if(chkCodigo.Checked) then
            SQL.Add('AND a.clave IN (SELECT articulo FROM codigos WHERE codigo STARTING ''' + txtCodigoBusq.Text + ''')');
        if(chkDescrip.Checked) then
            SQL.Add('AND a.desc_larga LIKE ''%' + txtDescripBusq.Text + '%''');
        if(chkCateg.Checked) then
            if(cmbCategBusq.ItemIndex > -1) then
                SQL.Add('AND a.categoria = ''' + IntToStr(ClaveCarga(cmbCategBusq.Items.Strings[cmbCategBusq.ItemIndex],'C')) + '''');
        if(chkProv.Checked) then
            if(txtProv.Value > 0) then
                SQL.Add('AND (a.proveedor1 = ' + FloatToStr(txtProv.Value) + ' OR a.proveedor2 = ' + FloatToStr(txtProv.Value) + ')');
        if(chkDepto.Checked) then
            if(cmbDeptoBusq.ItemIndex > -1) then
                SQL.Add('AND a.departamento = ''' + IntToStr(ClaveCarga(cmbDeptoBusq.Items.Strings[cmbDeptoBusq.ItemIndex],'D')) + '''');

        case rdgOrden.ItemIndex of
            0: SQL.Add('ORDER BY o.codigo');
            1: SQL.Add('ORDER BY a.desc_larga');
            2: SQL.Add('ORDER BY c.nombre, o.codigo');
            3: SQL.Add('ORDER BY a.proveedor1, a.proveedor2, o.codigo');
            4: SQL.Add('ORDER BY d.nombre, o.codigo');
        end;

        Open;
        dmDatos.cdsArticulos.Active := true;

        dmDatos.cdsArticulos.FieldByName('clave').Visible := False;
        dmDatos.cdsArticulos.FieldByName('tipo').Visible := False;
        dmDatos.cdsArticulos.FieldByName('codigo').DisplayLabel := 'C�digo';
        dmDatos.cdsArticulos.FieldByName('desc_larga').DisplayLabel := 'Descripci�n larga';
        dmDatos.cdsArticulos.FieldByName('desc_larga').DisplayWidth := 45;
        dmDatos.cdsArticulos.FieldByName('desc_corta').DisplayLabel := 'Descripci�n corta';
        dmDatos.cdsArticulos.FieldByName('desc_corta').DisplayWidth := 26;
        dmDatos.cdsArticulos.FieldByName('categoria').DisplayLabel := 'Categor�a';
        dmDatos.cdsArticulos.FieldByName('categoria').DisplayWidth := 26;
        if(not bGasto) then begin
            dmDatos.cdsArticulos.FieldByName('departamento').DisplayLabel := 'Departamento';
            dmDatos.cdsArticulos.FieldByName('departamento').DisplayWidth := 26;
            dmDatos.cdsArticulos.FieldByName('precio1').DisplayLabel := 'Precio';
            (dmDatos.cdsArticulos.FieldByName('precio1') as TNumericField).DisplayFormat := '#,##0.00';
            dmDatos.cdsArticulos.FieldByName('existencia').DisplayLabel := 'Exist�ncia';
            (dmDatos.cdsArticulos.FieldByName('existencia') as TNumericField).DisplayFormat := '#,##0.000';
        end;

        grdListado.SetFocus;

        txtRegistros.Value := dmDatos.cdsArticulos.RecordCount;
    end;
    grdListado.SetFocus;
end;

function TfrmArticuloBusq.ClaveCarga(sBusqueda : String; sConsulta:String):Integer;
begin
    with dmDatos.qryModifica do begin
        Close;
        SQL.Clear;

        if(sConsulta = 'C') then begin
            SQL.Add('SELECT clave FROM categorias WHERE nombre = ''' + sBusqueda + '''');
            SQL.Add('AND tipo = ''A''');
            Open;
        end
        else if(sConsulta = 'D') then Begin
            SQL.Add('SELECT clave FROM departamentos WHERE nombre = ''' + sBusqueda + '''');
            Open;
        end;

        Result := FieldByName('clave').AsInteger;
        Close;
    end;
end;

procedure TfrmArticuloBusq.RecuperaDatos;
begin
    with dmDatos.qryConsulta do begin
        Close;
        SQL.Clear;
        if(not bGasto) then
            SQL.Add('SELECT nombre FROM categorias WHERE tipo = ''A'' ORDER BY nombre')
        else
            SQL.Add('SELECT nombre FROM categorias WHERE tipo = ''G'' ORDER BY nombre');
        Open;
        cmbCategBusq.Items.Clear;
        while (not Eof) do begin
            cmbCategBusq.Items.Add(Trim(FieldByName('nombre').AsString));
            Next;
        end;
        Close;

        if(not bGasto) then begin
            Close;
            SQL.Clear;
            SQL.Add('SELECT nombre FROM departamentos  ORDER BY nombre');
            Open;
            cmbDeptoBusq.Items.Clear;
            while (not Eof) do begin
                cmbDeptoBusq.Items.Add(Trim(FieldByName('nombre').AsString));
                Next;
            end;
            Close;
        end;
    end;
end;

procedure TfrmArticuloBusq.FormShow(Sender: TObject);
begin
    bSelec := false;

    if(bGasto) then begin
        chkDepto.Visible := false;
        chkDepto.Enabled := false;
        chkDepto.Checked := false;
        cmbDeptoBusq.Visible := false;
    end;

    rdgOrden.Items.Clear;
    rdgOrden.Items.Add('C�dig&o');
    rdgOrden.Items.Add('Descripci�&n');
    rdgOrden.Items.Add('Cate&gor�a');
    rdgOrden.Items.Add('P&roveedor');
    if(not bGasto) then
        rdgOrden.Items.Add('Departa&mento');

    RecuperaDatos;

    chkCategClick(Sender);
    chkCodigoClick(Sender);
    chkDescripClick(Sender);
    chkProvClick(Sender);
    chkDeptoClick(Sender);

    if (dmDatos.cdsArticulos.Active) then
        txtRegistros.Value := dmDatos.cdsArticulos.RecordCount;
end;

procedure TfrmArticuloBusq.btnLimpiarClick(Sender: TObject);
begin
    txtCodigoBusq.Clear;
    txtDescripBusq.Clear;
    cmbCategBusq.ItemIndex := -1;
    cmbDeptoBusq.ItemIndex := -1;
end;

procedure TfrmArticuloBusq.RecuperaConfig;
var
    iniArchivo : TIniFile;
    sIzq, sArriba, sValor : String;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'config.ini');

    with iniArchivo do begin
        //Recupera la posici�n Y de la ventana
        sArriba := ReadString('ArticuloBusq', 'Posy', '');

        //Recupera la posici�n X de la ventana
        sIzq := ReadString('ArticuloBusq', 'Posx', '');

        if (Length(sIzq) > 0) and (Length(sArriba) > 0) then begin
            Left := StrToInt(sIzq);
            Top := StrToInt(sArriba);
        end;

        //Recupera el valor de las casillas de verificaci�n de buscar
        sValor := ReadString('ArticuloBusq', 'CategBusq', '');
        if (sValor = 'S') then
            chkCateg.Checked := true
        else
            chkCateg.Checked := false;

        sValor := ReadString('ArticuloBusq', 'CodigoBusq', '');
        if (sValor = 'S') then
            chkCodigo.Checked := true
        else
            chkCodigo.Checked := false;

        sValor := ReadString('ArticuloBusq', 'DescripBusq', '');
        if (sValor = 'S') then
            chkDescrip.Checked := true
        else
            chkDescrip.Checked := false;

        sValor := ReadString('ArticuloBusq', 'ProvBusq', '');
        if (sValor = 'S') then
            chkProv.Checked := true
        else
            chkProv.Checked := false;

        sValor := ReadString('ArticuloBusq', 'DeptoBusq', '');
        if (sValor = 'S') then
            chkDepto.Checked := true
        else
            chkDepto.Checked := false;

        //Recupera el valor de los botones de radio de orden
        sValor := ReadString('ArticuloBusq', 'Orden', '');
        if (Length(sValor) > 0) then
            rdgOrden.ItemIndex := StrToInt(sValor);
    end;
end;
procedure TfrmArticuloBusq.FormClose(Sender: TObject; var Action: TCloseAction);
var
    iniArchivo : TIniFile;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'config.ini');
    with iniArchivo do begin
        // Registra la posici�n y de la ventana
        WriteString('ArticuloBusq', 'Posy', IntToStr(Top));

        // Registra la posici�n X de la ventana
        WriteString('ArticuloBusq', 'Posx', IntToStr(Left));

        //Registra el valor de las casillas de verificaci�n de buscar
        if(chkCateg.Checked) then
            WriteString('ArticuloBusq', 'CategBusq', 'S')
        else
            WriteString('ArticuloBusq', 'CategBusq', 'N');

        if(chkCodigo.Checked) then
            WriteString('ArticuloBusq', 'CodigoBusq', 'S')
        else
            WriteString('ArticuloBusq', 'CodigoBusq', 'N');

        if(chkDescrip.Checked) then
            WriteString('ArticuloBusq', 'DescripBusq', 'S')
        else
            WriteString('ArticuloBusq', 'DescripBusq', 'N');

        if(chkProv.Checked) then
            WriteString('ArticuloBusq', 'ProvBusq', 'S')
        else
            WriteString('ArticuloBusq', 'ProvBusq', 'N');

        if(chkDepto.Checked) then
            WriteString('ArticuloBusq', 'DeptoBusq', 'S')
        else
            WriteString('ArticuloBusq', 'DeptoBusq', 'N');

        //Registra el valor de los botones de radio de orden
        WriteString('ArticuloBusq', 'Orden', IntToStr(rdgOrden.ItemIndex));

        Free;
    end;
    dmDatos.qryArticulos.Close;
    dmDatos.cdsArticulos.Active := false;
end;

procedure TfrmArticuloBusq.grdListadoDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
    if(dmDatos.cdsArticulos.Active) then begin
        case dmDatos.cdsArticulos.FieldByName('tipo').AsInteger of
            0:grdListado.Canvas.Brush.Color := $0094E7ED;
            1:grdListado.Canvas.Brush.Color := $0099A7F7;
            2:grdListado.Canvas.Brush.Color := $00DCBFA5;
            3:grdListado.Canvas.Brush.Color := $00BFCAB7;
        end;
        grdListado.Canvas.FillRect(Rect);
        grdListado.DefaultDrawColumnCell(Rect,DataCol,Column,State);
    end;
end;

procedure TfrmArticuloBusq.btnSeleccionarClick(Sender: TObject);
begin
    if(txtRegistros.Value > 0) then begin
        bSelec := true;
        sCodigo := Trim(dmDatos.cdsArticulos.FieldByName('codigo').AsString);
        Close;
    end;
end;

procedure TfrmArticuloBusq.grdListadoEnter(Sender: TObject);
begin
    btnBuscar.Default := false;
    btnSeleccionar.Default := true;
end;

procedure TfrmArticuloBusq.grdListadoExit(Sender: TObject);
begin
    btnBuscar.Default := true;
    btnSeleccionar.Default := false;
end;

procedure TfrmArticuloBusq.Salir1Click(Sender: TObject);
begin
    Close;
end;

procedure TfrmArticuloBusq.Salta(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
    {Inicio (36), Fin (35), Izquierda (37), derecha (39), arriba (38), abajo (40)}
    if(Key >= 30) and (Key <= 122) and (Key <> 35) and (Key <> 36) and not ((Key >= 37) and (Key <= 40)) then
        if( Length((Sender as TEdit).Text) = (Sender as TEdit).MaxLength) then
            SelectNext(Sender as TWidgetControl, true, true);
end;

procedure TfrmArticuloBusq.FormCreate(Sender: TObject);
begin
    RecuperaConfig;
end;

procedure TfrmArticuloBusq.txtProvChange(Sender: TObject);
begin
    BuscaProveedor(Sender)
end;

procedure TfrmArticuloBusq.BuscaProveedor(Sender: TObject);
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

procedure TfrmArticuloBusq.rdgOrdenClick(Sender: TObject);
begin
    if(dmDatos.qryArticulos.Active) then
        btnBuscar.Click;
end;

procedure TfrmArticuloBusq.chkCategClick(Sender: TObject);
begin
    if(chkCateg.Checked) then begin
        cmbCategBusq.Visible := true;
        cmbCategBusq.SetFocus;
    end
    else
        cmbCategBusq.Visible := false;
end;

procedure TfrmArticuloBusq.chkCodigoClick(Sender: TObject);
begin
    if(chkCodigo.Checked) then begin
        txtCodigoBusq.Visible := true;
        txtCodigoBusq.SetFocus;
    end
    else
        txtCodigoBusq.Visible := false;
end;

procedure TfrmArticuloBusq.chkDescripClick(Sender: TObject);
begin
    if(chkDescrip.Checked) then begin
        txtDescripBusq.Visible := true;
        txtDescripBusq.SetFocus;
    end
    else
        txtDescripBusq.Visible := false;
end;

procedure TfrmArticuloBusq.chkProvClick(Sender: TObject);
begin
    if(chkProv.Checked) then begin
        txtProv.Visible := true;
        txtProvDesc.Visible := true;
        txtProv.SetFocus;
    end
    else begin
        txtProv.Visible := false;
        txtProvDesc.Visible := false;
    end;
end;

procedure TfrmArticuloBusq.chkDeptoClick(Sender: TObject);
begin
    if(chkDepto.Checked) then begin
        cmbDeptoBusq.Visible := true;
        cmbDeptoBusq.SetFocus;
    end
    else
        cmbDeptoBusq.Visible := false;
end;

end.
