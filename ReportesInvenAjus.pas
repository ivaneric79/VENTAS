// --------------------------------------------------------------------------
// Archivo del Proyecto Ventas
// P�gina del proyecto: http://sourceforge.net/projects/ventas
// --------------------------------------------------------------------------
// Este archivo puede ser distribuido y/o modificado bajo lo terminos de la
// Licencia P�blica General versi�n 2 como es publicada por la Free Software
// Fundation, Inc.
// --------------------------------------------------------------------------

unit ReportesInvenAjus;

interface

uses
  SysUtils, Types, Classes, QGraphics, QControls, QForms, QDialogs,
  QStdCtrls, QButtons, QExtCtrls, IniFiles, rpcompobase, rpclxreport,
  QcurrEdit;

type
  TfrmReportesInventariosF = class(TForm)
    rgpOrden: TRadioGroup;
    grpDeptos: TGroupBox;
    lblDesde: TLabel;
    lblHasta: TLabel;
    pnlCateg: TPanel;
    cmbCategIni: TComboBox;
    cmbCategFin: TComboBox;
    pnlCodigo: TPanel;
    txtCodigoIni: TEdit;
    txtCodigoFin: TEdit;
    pnlProveedor1: TPanel;
    txtProvIni: TEdit;
    txtProvFin: TEdit;
    pnlDescrip: TPanel;
    txtDescripIni: TEdit;
    txtDescripFin: TEdit;
    pnlDepto: TPanel;
    cmbDeptoIni: TComboBox;
    cmbDeptoFin: TComboBox;
    rdoTodo: TRadioButton;
    rdoRango: TRadioButton;
    btnImprimir: TBitBtn;
    rptReportes: TCLXReport;
    btnCancelar: TBitBtn;
    chkPreliminar: TCheckBox;
    Label4: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure rgpOrdenClick(Sender: TObject);
    procedure rdoTodoClick(Sender: TObject);
    procedure cmbDeptoIniSelect(Sender: TObject);
    procedure Numero (Sender: TObject; var Key: Char);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure chkPreliminarClick(Sender: TObject);
    procedure Salta(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
private
    procedure RecuperaConfig;
    procedure CargaCombos;
    function VerificaDatos : boolean;
    function VerificaRangos : boolean;
  public
  end;

var
  frmReportesInventariosF: TfrmReportesInventariosF;

implementation

uses dm;

{$R *.xfm}

procedure TfrmReportesInventariosF.FormShow(Sender: TObject);
begin
    CargaCombos;
    rgpOrdenClick(Sender);
    rdoTodoClick(Sender);
end;

procedure TfrmReportesInventariosF.CargaCombos;
begin
    cmbCategIni.Clear;
    cmbCategFin.Clear;
    cmbDeptoIni.Clear;
    cmbDeptoFin.Clear;

    with dmDatos.qryConsulta do begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT nombre FROM categorias WHERE tipo =''A'' ORDER BY nombre');
        Open;

        while(not EOF) do begin
            cmbCategIni.Items.Add(FieldByName('nombre').AsString);
            cmbCategFin.Items.Add(FieldByName('nombre').AsString);
            Next;
        end;

        Close;
        SQL.Clear;
        SQL.Add('SELECT nombre FROM departamentos ORDER BY nombre');
        Open;

        while(not EOF) do begin
            cmbDeptoIni.Items.Add(FieldByName('nombre').AsString);
            cmbDeptoFin.Items.Add(FieldByName('nombre').AsString);
            Next;
        end;
        Close;
    end;
    cmbCategIni.ItemIndex := 0;
    cmbCategFin.ItemIndex := 0;
    cmbDeptoIni.ItemIndex := 0;
    cmbDeptoFin.ItemIndex := 0;
end;

procedure TfrmReportesInventariosF.RecuperaConfig;
var
    iniArchivo : TIniFile;
    sIzq, sArriba, sValor : String;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) +'config.ini');

    with iniArchivo do begin
        //Recupera la posici�n Y de la ventana
        sArriba := ReadString('RepInventAjuste', 'Posy', '');

        //Recupera la posici�n X de la ventana
        sIzq := ReadString('RepInventAjuste', 'Posx', '');

        if (Length(sIzq) > 0) and (Length(sArriba) > 0) then begin
            Left := StrToInt(sIzq);
            Top := StrToInt(sArriba);
        end;

        //Recupera la posici�n de los botones de radio
        sValor := ReadString('RepInventAjuste', 'Tipo', '');
        if (Length(sValor) > 0) then
            rgpOrden.ItemIndex := StrToInt(sValor);

        Free;
    end;
end;

procedure TfrmReportesInventariosF.FormClose(Sender: TObject; var Action: TCloseAction);
  var iniArchivo : TIniFile;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) +'config.ini');
    with iniArchivo do begin
        // Registra la posici�n y de la ventana
        WriteString('RepInventAjuste', 'Posy', IntToStr(Top));

        // Registra la posici�n X de la ventana
        WriteString('RepInventAjuste', 'Posx', IntToStr(Left));

        // Registra la posici�n de los botones de radio
        WriteString('RepInventAjuste', 'Tipo', IntToStr(rgpOrden.ItemIndex));

        Free;
    end;
end;

procedure TfrmReportesInventariosF.rgpOrdenClick(Sender: TObject);
begin
    pnlCateg.Visible := false;
    pnlCodigo.Visible := false;
    pnlDepto.Visible := false;
    pnlDescrip.Visible := false;
    pnlProveedor1.Visible := false;

    case rgpOrden.ItemIndex of
        0: pnlCateg.Visible := true;
        1: pnlCodigo.Visible := true;
        2: pnlDepto.Visible := true;
        3: pnlDescrip.Visible := true;
        4: pnlProveedor1.Visible := true;
    end;
end;

procedure TfrmReportesInventariosF.rdoTodoClick(Sender: TObject);
begin
    if(rdoTodo.Checked) then begin
        lblDesde.Enabled := false;
        lblHasta.Enabled := false;


        txtCodigoIni.Enabled := false;
        txtCodigoFin.Enabled := false;
        cmbCategIni.Enabled := false;
        cmbCategFin.Enabled := false;
        cmbDeptoIni.Enabled := false;
        cmbDeptoFin.Enabled := false;
        txtDescripIni.Enabled := false;
        txtDescripFin.Enabled := false;
        txtProvIni.Enabled := false;
        txtProvFin.Enabled := false;

    end
    else begin
        lblDesde.Enabled := true;
        lblHasta.Enabled := true;

        txtCodigoIni.Enabled := true;
        txtCodigoFin.Enabled := true;
        cmbCategIni.Enabled := true;
        cmbCategFin.Enabled := true;
        cmbDeptoIni.Enabled := true;
        cmbDeptoFin.Enabled := true;
        txtDescripIni.Enabled := true;
        txtDescripFin.Enabled := true;
        txtProvIni.Enabled := true;
        txtProvFin.Enabled := true;
    end;
end;

procedure TfrmReportesInventariosF.cmbDeptoIniSelect(Sender: TObject);
begin
    if(cmbDeptoFin.ItemIndex < cmbDeptoIni.ItemIndex) then
        cmbDeptoFin.ItemIndex := cmbDeptoIni.ItemIndex;
end;

procedure TfrmReportesInventariosF.Numero(Sender: TObject; var Key: Char);
begin
    if not (Key in ['0'..'9',#8]) then
        Key := #0;
end;

procedure TfrmReportesInventariosF.btnCancelarClick(Sender: TObject);
begin
    Close;
end;

procedure TfrmReportesInventariosF.chkPreliminarClick(Sender: TObject);
begin
    rptReportes.Preview := chkPreliminar.Checked;
end;

procedure TfrmReportesInventariosF.btnImprimirClick(Sender: TObject);
var
    iniArchivo : TIniFile;
    sArchivo, sSentencia : String;
    sDirReportes : String;
begin

    if (VerificaDatos) then begin

        iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) +'config.ini');

        sDirReportes := iniArchivo.ReadString('Reportes', 'DirReportes', '');

        if not (Length(sDirReportes) > 0) then
           sDirReportes:= ExtractFilePath(Application.ExeName)+'Reportes\';

        sArchivo := iniArchivo.ReadString('Reportes', 'InvAjuste', '');

        if (Length(sArchivo) > 0) then begin
            rptReportes.FileName := sDirReportes + sArchivo;
            rptReportes.Report.DatabaseInfo.Items[0].SQLConnection := dmDatos.sqlBase.DataSets[0].SQLConnection;

            sSentencia:= 'SELECT a.clave, a.tipo, o.codigo, a.ult_costo, a.desc_larga,'+
                        ' a.existencia, c.nombre AS categoria, d.nombre AS departamento,'+
                        ' p.clave ||'' '' || p.nombre AS proveedor FROM articulos a '+
                        ' LEFT JOIN codigos o ON (a.clave = o.articulo AND o.tipo = ''P'')'+
                        ' LEFT JOIN categorias c ON a.categoria = c.clave'+
                        ' LEFT JOIN departamentos d ON a.departamento = d.clave'+
                        ' LEFT JOIN proveedores p ON a.proveedor1 = p.clave WHERE 1=1';

            if(not rdoTodo.Checked) then begin
                case rgpOrden.ItemIndex of
                    0: sSentencia := sSentencia + ' AND c.nombre >= ''' + cmbCategIni.Text + ''' AND c.nombre <=''' +cmbCategFin.Text +'''';
                    1: sSentencia := sSentencia + ' AND o.codigo >= ''' + txtCodigoIni.Text + ''' AND o.codigo <=''' +txtCodigoFin.Text +'''';
                    2: sSentencia := sSentencia + ' AND d.nombre >= ''' + cmbDeptoIni.Text + ''' AND d.nombre <=''' +cmbDeptoFin.Text +'''';
                    3: sSentencia := sSentencia + ' AND a.desc_larga >= ''' + txtDescripIni.Text + ''' AND a.desc_larga <= ''' +txtDescripFin.Text +'''';
                    4: sSentencia := sSentencia + ' AND p.clave >= ''' + txtProvIni.Text + ''' AND p.clave <= ''' +txtProvFin.Text +'''';
                end;
            end;

            case rgpOrden.ItemIndex of
                0:  begin
                        sSentencia := sSentencia + ' ORDER BY c.nombre';
                        rptReportes.Report.Params.ParamByName('campo').AsString := 'CATEGORIA';
                    end;
                1:  begin
                        sSentencia := sSentencia + ' ORDER BY o.codigo';
                        rptReportes.Report.Params.ParamByName('campo').AsString := 'CODIGO';
                    end;
                2:  begin
                        sSentencia := sSentencia + ' ORDER BY d.nombre, a.desc_larga';
                        rptReportes.Report.Params.ParamByName('campo').AsString := 'DEPARTAMENTO';
                    end;
                3:  begin
                        sSentencia := sSentencia + ' ORDER BY a.desc_larga';
                        rptReportes.Report.Params.ParamByName('campo').AsString := 'DESC_LARGA';
                    end;
                4:  begin
                        sSentencia := sSentencia + ' ORDER BY p.clave, o.codigo';
                        rptReportes.Report.Params.ParamByName('campo').AsString := 'PROVEEDOR';
                    end;
            end;


            rptReportes.Report.DataInfo.Items[0].SQL:=sSentencia;
            rptReportes.Execute;
        end
        else
            Application.MessageBox('El archivo ' + sArchivo + ' no existe','Error',[smbOK],smsCritical);
    end;
end;

function TfrmReportesInventariosF.VerificaDatos : boolean;
var
   bResult : boolean;
begin
    bResult:= true;
    if not VerificaRangos then
        bResult := false;
    Result := bResult;
end;

function TfrmReportesInventariosF.VerificaRangos : boolean;
var
   bResult : boolean;
begin
    bResult:= true;
    if rdoRango.Checked then
       case rgpOrden.ItemIndex of
          0 : if (Length(cmbCategIni.Text)=0) or (Length(cmbCategFin.Text)=0) then
                bResult := false;
          1 : if (Length(txtCodigoIni.Text)=0) or (Length(txtCodigoFin.Text)=0) then
                bResult := false;
          2 : if (Length(cmbDeptoIni.Text)=0) or (Length(cmbDeptoFin.Text)=0) then
                bResult := false;
          3 : if (Length(txtDescripIni.Text)=0) or (Length(txtDescripFin.Text)=0) then
                bResult := false;
          4 : if (Length(txtProvIni.Text)=0) or (Length(txtProvFin.Text)=0) then
                bResult := false;
       end;

    if not bResult then
        Application.MessageBox('Introduce un rango v�lido','Error',[smbOK],smsCritical);

    Result := bResult
end;

procedure TfrmReportesInventariosF.Salta(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    {Inicio (36), Fin (35), Izquierda (37), derecha (39), arriba (38), abajo (40)}
    if(Key >= 30) and (Key <= 122) and (Key <> 35) and (Key <> 36) and not ((Key >= 37) and (Key <= 40)) then
        if( Length((Sender as TEdit).Text) = (Sender as TEdit).MaxLength) then
            SelectNext(Sender as TWidgetControl, true, true);
end;

procedure TfrmReportesInventariosF.FormCreate(Sender: TObject);
begin
    RecuperaConfig;
end;

end.
