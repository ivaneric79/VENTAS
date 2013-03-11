// --------------------------------------------------------------------------
// Archivo del Proyecto Ventas
// Página del proyecto: http://sourceforge.net/projects/ventas
// --------------------------------------------------------------------------
// Este archivo puede ser distribuido y/o modificado bajo lo terminos de la
// Licencia Pública General versión 2 como es publicada por la Free Software
// Fundation, Inc.
// --------------------------------------------------------------------------

unit ReportesArticulos;

interface

uses
  SysUtils, Types, Classes, QGraphics, QControls, QForms, QDialogs,
  QStdCtrls, QButtons, QExtCtrls, IniFiles, rpcompobase, rpclxreport,
  QcurrEdit;

type
  TfrmReportesArticulos = class(TForm)
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
    txtProvIni1: TEdit;
    txtProvFin1: TEdit;
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
    pnlProveedor2: TPanel;
    txtProvIni2: TEdit;
    txtProvFin2: TEdit;
    chkDesglozar: TCheckBox;
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
    procedure ImprimeArtiCateg;
    procedure ImprimeArtiCodigo;
    procedure ImprimeArtiDepto;
    procedure ImprimeArtiDescrip;
    procedure ImprimeArtiProv1;
    procedure ImprimeArtiProv2;
  public
  end;

var
  frmReportesArticulos: TfrmReportesArticulos;

implementation

uses dm;

{$R *.xfm}

procedure TfrmReportesArticulos.FormShow(Sender: TObject);
begin
    CargaCombos;
    rgpOrdenClick(Sender);
    rdoTodoClick(Sender);
end;

procedure TfrmReportesArticulos.CargaCombos;
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

procedure TfrmReportesArticulos.RecuperaConfig;
var
    iniArchivo : TIniFile;
    sIzq, sArriba, sValor : String;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) +'config.ini');

    with iniArchivo do begin
        //Recupera la posición Y de la ventana
        sArriba := ReadString('RepArticulos', 'Posy', '');

        //Recupera la posición X de la ventana
        sIzq := ReadString('RepArticulos', 'Posx', '');

        if (Length(sIzq) > 0) and (Length(sArriba) > 0) then begin
            Left := StrToInt(sIzq);
            Top := StrToInt(sArriba);
        end;

        //Recupera la posición de los botones de radio
        sValor := ReadString('RepArticulos', 'Tipo', '');
        if (Length(sValor) > 0) then
            rgpOrden.ItemIndex := StrToInt(sValor);

        Free;
    end;
end;

procedure TfrmReportesArticulos.FormClose(Sender: TObject; var Action: TCloseAction);
  var iniArchivo : TIniFile;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) +'config.ini');
    with iniArchivo do begin
        // Registra la posición y de la ventana
        WriteString('RepArticulos', 'Posy', IntToStr(Top));

        // Registra la posición X de la ventana
        WriteString('RepArticulos', 'Posx', IntToStr(Left));

        // Registra la posición de los botones de radio
        WriteString('RepArticulos', 'Tipo', IntToStr(rgpOrden.ItemIndex));

        Free;
    end;
end;

procedure TfrmReportesArticulos.rgpOrdenClick(Sender: TObject);
begin
    pnlCateg.Visible := false;
    pnlCodigo.Visible := false;
    pnlDepto.Visible := false;
    pnlDescrip.Visible := false;
    pnlProveedor1.Visible := false;
    pnlProveedor2.Visible := false;

    case rgpOrden.ItemIndex of
        0: pnlCateg.Visible := true;
        1: pnlCodigo.Visible := true;
        2: pnlDepto.Visible := true;
        3: pnlDescrip.Visible := true;
        4: pnlProveedor1.Visible := true;
        5: pnlProveedor2.Visible := true;
    end;
end;

procedure TfrmReportesArticulos.rdoTodoClick(Sender: TObject);
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
        txtProvIni1.Enabled := false;
        txtProvFin1.Enabled := false;
        txtProvIni2.Enabled := false;
        txtProvFin2.Enabled := false;

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
        txtProvIni1.Enabled := true;
        txtProvFin1.Enabled := true;
        txtProvIni2.Enabled := true;
        txtProvFin2.Enabled := true;
    end;
end;

procedure TfrmReportesArticulos.cmbDeptoIniSelect(Sender: TObject);
begin
    if(cmbDeptoFin.ItemIndex < cmbDeptoIni.ItemIndex) then
        cmbDeptoFin.ItemIndex := cmbDeptoIni.ItemIndex;
end;

procedure TfrmReportesArticulos.Numero(Sender: TObject; var Key: Char);
begin
    if not (Key in ['0'..'9',#8]) then
        Key := #0;
end;

procedure TfrmReportesArticulos.btnCancelarClick(Sender: TObject);
begin
    Close;
end;

procedure TfrmReportesArticulos.chkPreliminarClick(Sender: TObject);
begin
    rptReportes.Preview := chkPreliminar.Checked;
end;

procedure TfrmReportesArticulos.btnImprimirClick(Sender: TObject);
begin
    if VerificaDatos then
       case rgpOrden.ItemIndex of
            0: ImprimeArtiCateg;
            1: ImprimeArtiCodigo;
            2: ImprimeArtiDepto;
            3: ImprimeArtiDescrip;
            4: ImprimeArtiProv1;
            5: ImprimeArtiProv2;
        end;
end;

function TfrmReportesArticulos.VerificaDatos : boolean;
var
   bResult : boolean;
begin
    bResult:= true;
    if not VerificaRangos then
        bResult := false;
    Result := bResult;
end;

function TfrmReportesArticulos.VerificaRangos : boolean;
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
          4 : if (Length(txtProvIni1.Text)=0) or (Length(txtProvFin1.Text)=0) then
                bResult := false;
          5 : if (Length(txtProvIni2.Text)=0) or (Length(txtProvFin2.Text)=0) then
                bResult := false;
       end;

    if not bResult then
        Application.MessageBox('Introduce un rango válido','Error',[smbOK],smsCritical);

    Result := bResult
end;

procedure TfrmReportesArticulos.ImprimeArtiCateg;
var
    iniArchivo : TIniFile;
    sArchivo : String;
    sDirReportes : String;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) +'config.ini');

    sDirReportes := iniArchivo.ReadString('Reportes', 'DirReportes', '');

    if not (Length(sDirReportes) > 0) then
       sDirReportes:= ExtractFilePath(Application.ExeName)+'Reportes\';

    sArchivo := iniArchivo.ReadString('Reportes', 'ArticulosCategoria', '');
    if (Length(sArchivo) > 0) then begin
        rptReportes.FileName := sDirReportes + sArchivo;
        rptReportes.Report.DatabaseInfo.Items[0].SQLConnection := dmDatos.sqlBase.DataSets[0].SQLConnection;
        if(rdoTodo.Checked) then begin
            rptReportes.Report.Params.ParamByName('CATEGINI').AsString := '';
            rptReportes.Report.Params.ParamByName('CATEGFIN').AsString := 'ZZZZZZZZZZZZZZZ';
        end
        else begin
            rptReportes.Report.Params.ParamByName('CATEGINI').AsString := cmbCategIni.Text;
            rptReportes.Report.Params.ParamByName('CATEGFIN').AsString := cmbCategFin.Text;
        end;
        rptReportes.Execute;
    end
    else
        Application.MessageBox('El archivo ' + sArchivo + ' no existe','Error',[smbOK],smsCritical);
end;

procedure TfrmReportesArticulos.ImprimeArtiCodigo;
var
    iniArchivo : TIniFile;
    sArchivo : String;
    sDirReportes : String;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) +'config.ini');

    sDirReportes := iniArchivo.ReadString('Reportes', 'DirReportes', '');

    if not (Length(sDirReportes) > 0) then
       sDirReportes:= ExtractFilePath(Application.ExeName)+'Reportes\';

    sArchivo := iniArchivo.ReadString('Reportes', 'ArticulosCodigo', '');
    if (Length(sArchivo) > 0) then begin
        rptReportes.FileName := sDirReportes + sArchivo;
        rptReportes.Report.DatabaseInfo.Items[0].SQLConnection := dmDatos.sqlBase.DataSets[0].SQLConnection;
        if(rdoTodo.Checked) then begin
            rptReportes.Report.Params.ParamByName('CODIGOINI').AsString := '';
            rptReportes.Report.Params.ParamByName('CODIGOFIN').AsString := 'ZZZZZZZZZZZZZ';
        end
        else begin
            rptReportes.Report.Params.ParamByName('CODIGOINI').AsString := txtCodigoIni.Text;
            rptReportes.Report.Params.ParamByName('CODIGOFIN').AsString := txtCodigoFin.Text;
        end;
        rptReportes.Execute;
    end
    else
        Application.MessageBox('El archivo ' + sArchivo + ' no existe','Error',[smbOK],smsCritical);
end;

procedure TfrmReportesArticulos.ImprimeArtiDepto;
var
    iniArchivo : TIniFile;
    sArchivo : String;
    sDirReportes : String;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) +'config.ini');

    sDirReportes := iniArchivo.ReadString('Reportes', 'DirReportes', '');

    if not (Length(sDirReportes) > 0) then
       sDirReportes:= ExtractFilePath(Application.ExeName)+'Reportes\';

    sArchivo := iniArchivo.ReadString('Reportes', 'ArticulosDepartamento', '');
    if (Length(sArchivo) > 0) then begin
        rptReportes.FileName := sDirReportes + sArchivo;
        rptReportes.Report.DatabaseInfo.Items[0].SQLConnection := dmDatos.sqlBase.DataSets[0].SQLConnection;
        if(rdoTodo.Checked) then begin
            rptReportes.Report.Params.ParamByName('DEPTOINI').AsString := '';
            rptReportes.Report.Params.ParamByName('DEPTOFIN').AsString := 'ZZZZZZZZZZZZZ';
        end
        else begin
            rptReportes.Report.Params.ParamByName('DEPTOINI').AsString := cmbDeptoIni.Text;
            rptReportes.Report.Params.ParamByName('DEPTOFIN').AsString := cmbDeptoFin.Text;
        end;
        rptReportes.Execute;
    end
    else
        Application.MessageBox('El archivo ' + sArchivo + ' no existe','Error',[smbOK],smsCritical);
end;

procedure TfrmReportesArticulos.ImprimeArtiDescrip;
var
    iniArchivo : TIniFile;
    sArchivo : String;
    sDirReportes : String;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) +'config.ini');

    sDirReportes := iniArchivo.ReadString('Reportes', 'DirReportes', '');

    if not (Length(sDirReportes) > 0) then
       sDirReportes:= ExtractFilePath(Application.ExeName)+'Reportes\';

    sArchivo := iniArchivo.ReadString('Reportes', 'ArticulosDescripcion', '');
    if (Length(sArchivo) > 0) then begin
        rptReportes.FileName := sDirReportes + sArchivo;
        rptReportes.Report.DatabaseInfo.Items[0].SQLConnection := dmDatos.sqlBase.DataSets[0].SQLConnection;
        if(rdoTodo.Checked) then begin
            rptReportes.Report.Params.ParamByName('DESCRIPINI').AsString := '';
            rptReportes.Report.Params.ParamByName('DESCRIPFIN').AsString := 'ZZZZZZZZZZZZZ';
        end
        else begin
            rptReportes.Report.Params.ParamByName('DESCRIPINI').AsString := txtDescripIni.Text;
            rptReportes.Report.Params.ParamByName('DESCRIPFIN').AsString := txtDescripFin.Text;
        end;
        rptReportes.Execute;
    end
    else
        Application.MessageBox('El archivo ' + sArchivo + ' no existe','Error',[smbOK],smsCritical);
end;

procedure TfrmReportesArticulos.ImprimeArtiProv1;
var
    iniArchivo : TIniFile;
    sArchivo : String;
    sDirReportes : String;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) +'config.ini');

    sDirReportes := iniArchivo.ReadString('Reportes', 'DirReportes', '');

    if not (Length(sDirReportes) > 0) then
       sDirReportes:= ExtractFilePath(Application.ExeName)+'Reportes\';

    sArchivo := iniArchivo.ReadString('Reportes', 'ArticulosProveedor1', '');
    if (Length(sArchivo) > 0) then begin
        rptReportes.FileName := sDirReportes + sArchivo;
        rptReportes.Report.DatabaseInfo.Items[0].SQLConnection := dmDatos.sqlBase.DataSets[0].SQLConnection;
        if(rdoTodo.Checked) then begin
            rptReportes.Report.Params.ParamByName('PROVINI').AsString := '1';
            rptReportes.Report.Params.ParamByName('PROVFIN').AsString := '9999';
        end
        else begin
            rptReportes.Report.Params.ParamByName('PROVINI').AsString := txtProvIni1.Text;
            rptReportes.Report.Params.ParamByName('PROVFIN').AsString := txtProvFin1.Text;
        end;
        if(chkDesglozar.Checked) then
            rptReportes.Report.Params.ParamByName('DESGLOCEJUEGO').AsString := 'S'
        else
            rptReportes.Report.Params.ParamByName('DESGLOCEJUEGO').AsString := 'N';
        rptReportes.Execute;
    end
    else
        Application.MessageBox('El archivo ' + sArchivo + ' no existe','Error',[smbOK],smsCritical);
end;

procedure TfrmReportesArticulos.ImprimeArtiProv2;
var
    iniArchivo : TIniFile;
    sArchivo : String;
    sDirReportes : String;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) +'config.ini');

    sDirReportes := iniArchivo.ReadString('Reportes', 'DirReportes', '');

    if not (Length(sDirReportes) > 0) then
       sDirReportes:= ExtractFilePath(Application.ExeName)+'Reportes\';

    sArchivo := iniArchivo.ReadString('Reportes', 'ArticulosProveedor2', '');
    if (Length(sArchivo) > 0) then begin
        rptReportes.FileName := sDirReportes + sArchivo;
        rptReportes.Report.DatabaseInfo.Items[0].SQLConnection := dmDatos.sqlBase.DataSets[0].SQLConnection;
        if(rdoTodo.Checked) then begin
            rptReportes.Report.Params.ParamByName('PROVINI').AsString := '1';
            rptReportes.Report.Params.ParamByName('PROVFIN').AsString := '9999';
        end
        else begin
            rptReportes.Report.Params.ParamByName('PROVINI').AsString := txtProvIni2.Text;
            rptReportes.Report.Params.ParamByName('PROVFIN').AsString := txtProvFin2.Text;
        end;
        rptReportes.Execute;
    end
    else
        Application.MessageBox('El archivo ' + sArchivo + ' no existe','Error',[smbOK],smsCritical);
end;

procedure TfrmReportesArticulos.Salta(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    {Inicio (36), Fin (35), Izquierda (37), derecha (39), arriba (38), abajo (40)}
    if(Key >= 30) and (Key <= 122) and (Key <> 35) and (Key <> 36) and not ((Key >= 37) and (Key <= 40)) then
        if( Length((Sender as TEdit).Text) = (Sender as TEdit).MaxLength) then
            SelectNext(Sender as TWidgetControl, true, true);
end;

procedure TfrmReportesArticulos.FormCreate(Sender: TObject);
begin
    RecuperaConfig;
end;

end.
