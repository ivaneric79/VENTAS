// --------------------------------------------------------------------------
// Archivo del Proyecto Ventas
// Página del proyecto: http://sourceforge.net/projects/ventas
// --------------------------------------------------------------------------
// Este archivo puede ser distribuido y/o modificado bajo lo terminos de la
// Licencia Pública General versión 2 como es publicada por la Free Software
// Fundation, Inc.
// --------------------------------------------------------------------------

unit ReportesCompras;

interface

uses
  SysUtils, Types, Classes, QGraphics, QControls, QForms, QDialogs,
  QStdCtrls, QButtons, rpcompobase, rpclxreport, QcurrEdit, QExtCtrls, IniFiles;

type
  TfrmReportesCompras = class(TForm)
    rgpOrden: TRadioGroup;
    grpFechas: TGroupBox;
    Label11: TLabel;
    txtDiaIni: TEdit;
    Label30: TLabel;
    txtMesIni: TEdit;
    Label31: TLabel;
    txtAnioIni: TEdit;
    txtDiaFin: TEdit;
    Label1: TLabel;
    txtMesFin: TEdit;
    Label3: TLabel;
    txtAnioFin: TEdit;
    grpImpresion: TGroupBox;
    pnlDepto: TPanel;
    cmbDeptoIni: TComboBox;
    cmbDeptoFin: TComboBox;
    pnlCaja: TPanel;
    txtCajaIni: TcurrEdit;
    txtCajaFin: TcurrEdit;
    pnlCateg: TPanel;
    cmbCategIni: TComboBox;
    cmbCategFin: TComboBox;
    pnlDescrip: TPanel;
    txtDescripIni: TEdit;
    txtDescripFin: TEdit;
    pnlCodigo: TPanel;
    txtCodigoIni: TEdit;
    txtCodigoFin: TEdit;
    pnlProveedor: TPanel;
    txtProvIni: TEdit;
    txtProvFin: TEdit;
    pnlUsuario: TPanel;
    txtUsuarioIni: TEdit;
    txtUsuarioFin: TEdit;
    lblDesde: TLabel;
    lblHasta: TLabel;
    rdoTodo: TRadioButton;
    rdoRango: TRadioButton;
    chkPreliminar: TCheckBox;
    rptReportes: TCLXReport;
    btnImprimir: TBitBtn;
    btnCancelar: TBitBtn;
    pnlDocto: TPanel;
    txtDoctoIni: TEdit;
    txtDoctoFin: TEdit;
    Label2: TLabel;
    Label4: TLabel;
    cbFiscal: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure rgpOrdenClick(Sender: TObject);
    procedure rdoTodoClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure Numero (Sender: TObject; var Key: Char);
    procedure Salta(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cmbDeptoIniSelect(Sender: TObject);
    procedure cmbCategIniSelect(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure txtAnioIniExit(Sender: TObject);
    procedure txtAnioFinExit(Sender: TObject);
    procedure txtDiaIniExit(Sender: TObject);
  private
    sFechaIni, sFechaFin : string;
    procedure RecuperaConfig;
    procedure CargaCombos;
    function VerificaDatos : boolean;
    function VerificaFechas(sFecha : string):boolean;
    function VerificaRangos : boolean;
    procedure ImprimeComprasPorCaja;
    procedure ImprimeComprasPorCategoria;
    procedure ImprimeComprasPorCodigo;
    procedure ImprimeComprasPorDepartamento;
    procedure ImprimeComprasPorDocumento;
    procedure ImprimeComprasPorUsuario;
    procedure ImprimeComprasPorDescripcion;
    procedure ImprimeComprasPorProveedor;
    procedure Rellena(Sender: TObject);
  public
    { Public declarations }
  end;

var
  frmReportesCompras: TfrmReportesCompras;

implementation

uses dm;

{$R *.xfm}

procedure TfrmReportesCompras.FormCreate(Sender: TObject);
begin
   RecuperaConfig;
end;

procedure TfrmReportesCompras.RecuperaConfig;
var
    iniArchivo : TIniFile;
    sIzq, sArriba, sValor : String;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) +'config.ini');

    with iniArchivo do begin
        //Recupera la posición Y de la ventana
        sArriba := ReadString('RepCompras', 'Posy', '');

        //Recupera la posición X de la ventana
        sIzq := ReadString('RepCompras', 'Posx', '');

        if (Length(sIzq) > 0) and (Length(sArriba) > 0) then begin
            Left := StrToInt(sIzq);
            Top := StrToInt(sArriba);
        end;

        //Recupera la posición de los botones de radio
        sValor := ReadString('RepCompras', 'Tipo', '');
        if (Length(sValor) > 0) then
            rgpOrden.ItemIndex := StrToInt(sValor);

        //Recupera la fecha inicial
        sValor := ReadString('RepCompras', 'FechaIni', '');
        if (Length(sValor) > 0) then begin
            txtDiaIni.Text := Copy(sValor,1,2);
            txtMesIni.Text := Copy(sValor,4,2);
            txtAnioIni.Text := Copy(sValor,7,4);
        end;

        //Recupera la fecha final
        sValor := ReadString('RepCompras', 'FechaFin', '');
        if (Length(sValor) > 0) then begin
            txtDiaFin.Text := Copy(sValor,1,2);
            txtMesFin.Text := Copy(sValor,4,2);
            txtAnioFin.Text := Copy(sValor,7,4);
        end;
        Free;
    end;
end;

procedure TfrmReportesCompras.Numero(Sender: TObject; var Key: Char);
begin
    if not (Key in ['0'..'9',#8]) then
        Key := #0;
end;

procedure TfrmReportesCompras.CargaCombos;
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

procedure TfrmReportesCompras.FormClose(Sender: TObject;
  var Action: TCloseAction);
var iniArchivo : TIniFile;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) +'config.ini');
    with iniArchivo do begin
        // Registra la posición y de la ventana
        WriteString('RepCompras', 'Posy', IntToStr(Top));

        // Registra la posición X de la ventana
        WriteString('RepCompras', 'Posx', IntToStr(Left));

        // Registra la posición de los botones de radio
        WriteString('RepCompras', 'Tipo', IntToStr(rgpOrden.ItemIndex));

        // Registra la fecha inicial
        WriteString('RepCompras', 'FechaIni', txtDiaIni.Text + '/' + txtMesIni.Text + '/' + txtAnioIni.Text);

        // Registra la fecha final
        WriteString('RepCompras', 'FechaFin', txtDiaFin.Text + '/' + txtMesFin.Text + '/' + txtAnioFin.Text);

        Free;
    end;
end;

procedure TfrmReportesCompras.FormShow(Sender: TObject);
begin
    CargaCombos;

    txtDiaFin.Text := FormatDateTime('dd',Date);
    txtMesFin.Text := FormatDateTime('mm',Date);
    txtAnioFin.Text := FormatDateTime('yyyy',Date);
    rgpOrdenClick(Sender);
    rdoTodoClick(Sender);
end;

procedure TfrmReportesCompras.rgpOrdenClick(Sender: TObject);
begin
    pnlCaja.Visible := false;
    pnlCateg.Visible := false;
    pnlCodigo.Visible := false;
    pnlDepto.Visible := false;
    pnlDescrip.Visible := false;
    pnlProveedor.Visible := false;
    pnlUsuario.Visible := false;
    pnlDocto.Visible := false;
    
    case rgpOrden.ItemIndex of
        0: Begin
            pnlCaja.Visible := true;
            cbfiscal.enabled:=false;
           end;
        1: Begin
            pnlCateg.Visible := true;
            cbfiscal.enabled:=false;
           end;
        2: Begin
            pnlCodigo.Visible := true;
            cbfiscal.enabled:=true;
           end;
        3: Begin
            pnlDepto.Visible := true;
            cbfiscal.enabled:=false;
           end;
        4: Begin
            pnlDescrip.Visible := true;
            cbfiscal.enabled:=false;
           end;
        5: Begin
            pnlDocto.Visible := true;
            cbfiscal.enabled:=false;
           end;
        6: Begin
            pnlProveedor.Visible := true;
            cbfiscal.enabled:=false;
           end;
        7: Begin
            pnlUsuario.Visible := true;
            cbfiscal.enabled:=false;
           end;
    end;
end;

procedure TfrmReportesCompras.rdoTodoClick(Sender: TObject);
begin
    if(rdoTodo.Checked) then begin
        lblDesde.Enabled := false;
        lblHasta.Enabled := false;

        txtCajaIni.Enabled := false;
        txtCajaFin.Enabled := false;
        txtUsuarioIni.Enabled := false;
        txtUsuarioFin.Enabled := false;
        
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
        txtDoctoIni.Enabled := false;
        txtDoctoFin.Enabled := false;
    end
    else begin
        lblDesde.Enabled := true;
        lblHasta.Enabled := true;

        txtCajaIni.Enabled := true;
        txtCajaFin.Enabled := true;
        txtUsuarioIni.Enabled := true;
        txtUsuarioFin.Enabled := true;

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
        txtDoctoIni.Enabled := false;
        txtDoctoFin.Enabled := false;
    end;
end;

procedure TfrmReportesCompras.btnImprimirClick(Sender: TObject);
begin
    if VerificaDatos then
       case rgpOrden.ItemIndex of
            0: ImprimeComprasPorCaja;
            1: ImprimeComprasPorCategoria;
            2: ImprimeComprasPorCodigo;
            3: ImprimeComprasPorDepartamento;
            4: ImprimeComprasPorDescripcion;
            5: ImprimeComprasPorDocumento;
            6: ImprimeComprasPorProveedor;
            7: ImprimeComprasPorUsuario;
        end;
end;

function TfrmReportesCompras.VerificaDatos : boolean;
begin
    Result:= true;

    sFechaIni := txtMesIni.Text + '/' + txtDiaIni.Text + '/' + txtAnioIni.Text;
    sFechaFin := txtMesFin.Text + '/' + txtDiaFin.Text + '/' + txtAnioFin.Text;

    if(not VerificaFechas(txtDiaIni.Text + '/' + txtMesIni.Text + '/' + txtAnioIni.Text)) then begin
        Application.MessageBox('Introduce una fecha válida','Error',[smbOK],smsCritical);
        txtDiaIni.SetFocus;
        Result := false;
    end
    else if(not VerificaFechas(txtDiaFin.Text + '/' + txtMesFin.Text + '/' + txtAnioFin.Text)) then begin
        Application.MessageBox('Introduce una fecha válida','Error',[smbOK],smsCritical);
        txtDiaFin.SetFocus;
        Result := false;
    end
    else if not VerificaRangos then
        Result := false;
end;

function TfrmReportesCompras.VerificaFechas(sFecha : string):boolean;
var
   dteFecha : TDateTime;
begin
   Result:=true;
   if(not TryStrToDate(sFecha,dteFecha)) then
      Result:=false;
end;

function TfrmReportesCompras.VerificaRangos : boolean;
var
   bResult : boolean;
begin
    bResult:= true;
    if rdoRango.Checked then
       case rgpOrden.ItemIndex of
          0 : if (Length(txtCajaIni.Text)=0) or (Length(txtCajaFin.Text)=0) then
                bResult := false;
          1 : if (Length(cmbCategIni.Text)=0) or (Length(cmbCategFin.Text)=0) then
                bResult := false;
          2 : if (Length(txtCodigoIni.Text)=0) or (Length(txtCodigoFin.Text)=0) then
                bResult := false;
          3 : if (Length(cmbDeptoIni.Text)=0) or (Length(cmbDeptoFin.Text)=0) then
                bResult := false;
          4 : if (Length(txtDescripIni.Text)=0) or (Length(txtDescripFin.Text)=0) then
                bResult := false;
          5 : if (Length(txtProvIni.Text)=0) or (Length(txtProvFin.Text)=0) then
                bResult := false;
          6 : if (Length(txtUsuarioIni.Text)=0) or (Length(txtUsuarioFin.Text)=0) then
                bResult := false;
          7 : if (Length(txtDoctoIni.Text)=0) or (Length(txtDoctoFin.Text)=0) then
                bResult := false;
       end;

    if not bResult then
        Application.MessageBox('Introduce un rango válido','Error',[smbOK],smsCritical);

    Result := bResult
end;

procedure TfrmReportesCompras.cmbDeptoIniSelect(Sender: TObject);
begin
    if(cmbDeptoFin.ItemIndex < cmbDeptoIni.ItemIndex) then
        cmbDeptoFin.ItemIndex := cmbDeptoIni.ItemIndex;
end;

procedure TfrmReportesCompras.cmbCategIniSelect(Sender: TObject);
begin
    if(cmbCategFin.ItemIndex < cmbCategIni.ItemIndex) then
        cmbCategFin.ItemIndex := cmbCategIni.ItemIndex;
end;

procedure TfrmReportesCompras.ImprimeComprasPorCaja;
var
    iniArchivo : TIniFile;
    sArchivo : String;
    sDirReportes : String;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) +'config.ini');

    sDirReportes := iniArchivo.ReadString('Reportes', 'DirReportes', '');

    if not (Length(sDirReportes) > 0) then
       sDirReportes:= ExtractFilePath(Application.ExeName)+'Reportes\';

    sArchivo := iniArchivo.ReadString('Reportes', 'ComprasCaja', '');
    if (Length(sArchivo) > 0) then begin
        rptReportes.FileName := sDirReportes + sArchivo;
        rptReportes.Report.DatabaseInfo.Items[0].SQLConnection := dmDatos.sqlBase.DataSets[0].SQLConnection;
        rptReportes.Report.Params.ParamByName('FECHAINI').AsString := sFechaIni;
        rptReportes.Report.Params.ParamByName('FECHAFIN').AsString := sFechaFin;
        if(rdoTodo.Checked) then begin
            rptReportes.Report.Params.ParamByName('CAJAINI').AsString := '0';
            rptReportes.Report.Params.ParamByName('CAJAFIN').AsString := '999';
        end
        else begin
            rptReportes.Report.Params.ParamByName('CAJAINI').AsString := FloatToStr(txtCajaIni.Value);
            rptReportes.Report.Params.ParamByName('CAJAFIN').AsString := FloatToStr(txtCajaFin.Value);
        end;
        rptReportes.Execute;
    end
    else
        Application.MessageBox('El archivo ' + sArchivo + ' no existe','Error',[smbOK],smsCritical);
end;

procedure TfrmReportesCompras.ImprimeComprasPorCategoria;
var
    iniArchivo : TIniFile;
    sArchivo : String;
    sDirReportes : String;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) +'config.ini');

    sDirReportes := iniArchivo.ReadString('Reportes', 'DirReportes', '');

    if not (Length(sDirReportes) > 0) then
       sDirReportes:= ExtractFilePath(Application.ExeName)+'Reportes\';

    sArchivo := iniArchivo.ReadString('Reportes', 'ComprasCategoria', '');
    if (Length(sArchivo) > 0) then begin
        rptReportes.FileName := sDirReportes + sArchivo;
        rptReportes.Report.DatabaseInfo.Items[0].SQLConnection := dmDatos.sqlBase.DataSets[0].SQLConnection;
        rptReportes.Report.Params.ParamByName('FECHAINI').AsString := sFechaIni;
        rptReportes.Report.Params.ParamByName('FECHAFIN').AsString := sFechaFin;
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

procedure TfrmReportesCompras.ImprimeComprasPorCodigo;
var
    iniArchivo : TIniFile;
    sArchivo : String;
    sDirReportes : String;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) +'config.ini');

    sDirReportes := iniArchivo.ReadString('Reportes', 'DirReportes', '');

    if not (Length(sDirReportes) > 0) then
       sDirReportes:= ExtractFilePath(Application.ExeName)+'Reportes\';

    if cbfiscal.Checked then
      sArchivo := iniArchivo.ReadString('Reportes', 'ComprasCodigoFiscal', '')
    else
     sArchivo := iniArchivo.ReadString('Reportes', 'ComprasCodigo', '');

    if (Length(sArchivo) > 0) then begin
        rptReportes.FileName := sDirReportes + sArchivo;
        rptReportes.Report.DatabaseInfo.Items[0].SQLConnection := dmDatos.sqlBase.DataSets[0].SQLConnection;
        rptReportes.Report.Params.ParamByName('FECHAINI').AsString := sFechaIni;
        rptReportes.Report.Params.ParamByName('FECHAFIN').AsString := sFechaFin;
        if(rdoTodo.Checked) then begin
            rptReportes.Report.Params.ParamByName('CODIGOINI').AsString := '';
            rptReportes.Report.Params.ParamByName('CODIGOFIN').AsString := 'ZZZZZZZZZZZZZ';
        end
        else begin
            rptReportes.Report.Params.ParamByName('CODIGOINI').AsString := txtCodigoIni.Text;
            rptReportes.Report.Params.ParamByName('CODIGOFIN').AsString := txtCodigoFin.Text;
        end;
        if cbfiscal.Checked then
         rptReportes.Report.Params.ParamByName('FISCALES').AsString := '1';

        rptReportes.Execute;
    end
    else
        Application.MessageBox('El archivo ' + sArchivo + ' no existe','Error',[smbOK],smsCritical);
end;

procedure TfrmReportesCompras.ImprimeComprasPorDepartamento;
var
    iniArchivo : TIniFile;
    sArchivo : String;
    sDirReportes : String;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) +'config.ini');

    sDirReportes := iniArchivo.ReadString('Reportes', 'DirReportes', '');

    if not (Length(sDirReportes) > 0) then
       sDirReportes:= ExtractFilePath(Application.ExeName)+'Reportes\';

    sArchivo := iniArchivo.ReadString('Reportes', 'ComprasDepartamento', '');
    if (Length(sArchivo) > 0) then begin
        rptReportes.FileName := sDirReportes + sArchivo;
        rptReportes.Report.DatabaseInfo.Items[0].SQLConnection := dmDatos.sqlBase.DataSets[0].SQLConnection;
        rptReportes.Report.Params.ParamByName('FECHAINI').AsString := sFechaIni;
        rptReportes.Report.Params.ParamByName('FECHAFIN').AsString := sFechaFin;
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

procedure TfrmReportesCompras.ImprimeComprasPorDescripcion;
var
    iniArchivo : TIniFile;
    sArchivo : String;
    sDirReportes : String;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) +'config.ini');

    sDirReportes := iniArchivo.ReadString('Reportes', 'DirReportes', '');

    if not (Length(sDirReportes) > 0) then
       sDirReportes:= ExtractFilePath(Application.ExeName)+'Reportes\';

    sArchivo := iniArchivo.ReadString('Reportes', 'ComprasDescripcion', '');
    if (Length(sArchivo) > 0) then begin
        rptReportes.FileName := sDirReportes + sArchivo;
        rptReportes.Report.DatabaseInfo.Items[0].SQLConnection := dmDatos.sqlBase.DataSets[0].SQLConnection;
        rptReportes.Report.Params.ParamByName('FECHAINI').AsString := sFechaIni;
        rptReportes.Report.Params.ParamByName('FECHAFIN').AsString := sFechaFin;
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

procedure TfrmReportesCompras.ImprimeComprasPorDocumento;
var
    iniArchivo : TIniFile;
    sArchivo : String;
    sDirReportes : String;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) +'config.ini');

    sDirReportes := iniArchivo.ReadString('Reportes', 'DirReportes', '');

    if not (Length(sDirReportes) > 0) then
       sDirReportes:= ExtractFilePath(Application.ExeName)+'Reportes\';

    sArchivo := iniArchivo.ReadString('Reportes', 'ComprasDocumento', '');
    if (Length(sArchivo) > 0) then begin
        rptReportes.FileName := sDirReportes + sArchivo;
        rptReportes.Report.DatabaseInfo.Items[0].SQLConnection := dmDatos.sqlBase.DataSets[0].SQLConnection;
        rptReportes.Report.Params.ParamByName('FECHAINI').AsString := sFechaIni;
        rptReportes.Report.Params.ParamByName('FECHAFIN').AsString := sFechaFin;
        if(rdoTodo.Checked) then begin
            rptReportes.Report.Params.ParamByName('DOCTOINI').AsString := '';
            rptReportes.Report.Params.ParamByName('DOCTOFIN').AsString := 'ZZZZZZZZZZZZZ';
        end
        else begin
            rptReportes.Report.Params.ParamByName('DOCTOINI').AsString := txtDoctoIni.Text;
            rptReportes.Report.Params.ParamByName('DOCTOFIN').AsString := txtDoctoFin.Text;
        end;
        rptReportes.Execute;
    end
    else
        Application.MessageBox('El archivo ' + sArchivo + ' no existe','Error',[smbOK],smsCritical);
end;

procedure TfrmReportesCompras.ImprimeComprasPorProveedor;
var
    iniArchivo : TIniFile;
    sArchivo : String;
    sDirReportes : String;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) +'config.ini');

    sDirReportes := iniArchivo.ReadString('Reportes', 'DirReportes', '');

    if not (Length(sDirReportes) > 0) then
       sDirReportes:= ExtractFilePath(Application.ExeName)+'Reportes\';

    sArchivo := iniArchivo.ReadString('Reportes', 'ComprasProveedor', '');
    if (Length(sArchivo) > 0) then begin
        rptReportes.FileName := sDirReportes + sArchivo;
        rptReportes.Report.DatabaseInfo.Items[0].SQLConnection := dmDatos.sqlBase.DataSets[0].SQLConnection;
        rptReportes.Report.Params.ParamByName('FECHAINI').AsString := sFechaIni;
        rptReportes.Report.Params.ParamByName('FECHAFIN').AsString := sFechaFin;
        if(rdoTodo.Checked) then begin
            rptReportes.Report.Params.ParamByName('PROVINI').AsString := '1';
            rptReportes.Report.Params.ParamByName('PROVFIN').AsString := '9999';
        end
        else begin
            rptReportes.Report.Params.ParamByName('PROVINI').AsString := txtProvIni.Text;
            rptReportes.Report.Params.ParamByName('PROVFIN').AsString := txtProvFin.Text;
        end;
        rptReportes.Execute;
    end
    else
        Application.MessageBox('El archivo ' + sArchivo + ' no existe','Error',[smbOK],smsCritical);
end;

procedure TfrmReportesCompras.ImprimeComprasPorUsuario;
var
    iniArchivo : TIniFile;
    sArchivo : String;
    sDirReportes : String;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) +'config.ini');

    sDirReportes := iniArchivo.ReadString('Reportes', 'DirReportes', '');

    if not (Length(sDirReportes) > 0) then
       sDirReportes:= ExtractFilePath(Application.ExeName)+'Reportes\';

    sArchivo := iniArchivo.ReadString('Reportes', 'ComprasUsuario', '');
    if (Length(sArchivo) > 0) then begin
        rptReportes.FileName := sDirReportes + sArchivo;
        rptReportes.Report.DatabaseInfo.Items[0].SQLConnection := dmDatos.sqlBase.DataSets[0].SQLConnection;
        rptReportes.Report.Params.ParamByName('FECHAINI').AsString := sFechaIni;
        rptReportes.Report.Params.ParamByName('FECHAFIN').AsString := sFechaFin;
        if(rdoTodo.Checked) then begin
            rptReportes.Report.Params.ParamByName('USUARIOINI').AsString := '';
            rptReportes.Report.Params.ParamByName('USUARIOFIN').AsString := 'ZZZZZZZZZZZ';
        end
        else begin
            rptReportes.Report.Params.ParamByName('USUARIOINI').AsString := txtUsuarioIni.Text;
            rptReportes.Report.Params.ParamByName('USUARIOFIN').AsString := txtUsuarioFin.Text;
        end;
        rptReportes.Execute;
    end
    else
        Application.MessageBox('El archivo ' + sArchivo + ' no existe','Error',[smbOK],smsCritical);
end;

procedure TfrmReportesCompras.Salta(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    {Inicio (36), Fin (35), Izquierda (37), derecha (39), arriba (38), abajo (40)}
    if(Key >= 30) and (Key <= 122) and (Key <> 35) and (Key <> 36) and not ((Key >= 37) and (Key <= 40)) then
        if( Length((Sender as TEdit).Text) = (Sender as TEdit).MaxLength) then
            SelectNext(Sender as TWidgetControl, true, true);
end;

procedure TfrmReportesCompras.btnCancelarClick(Sender: TObject);
begin
   Close;
end;

procedure TfrmReportesCompras.txtAnioIniExit(Sender: TObject);
begin
    txtAnioIni.Text := Trim(txtAnioIni.Text);
    if(Length(txtAnioIni.Text) < 4) and (Length(txtAnioIni.Text) > 0) then
        txtAnioIni.Text := IntToStr(StrToInt(txtAnioIni.Text) + 2000);
end;

procedure TfrmReportesCompras.txtAnioFinExit(Sender: TObject);
begin
    txtAnioFin.Text := Trim(txtAnioFin.Text);
    if(Length(txtAnioFin.Text) < 4) and (Length(txtAnioFin.Text) > 0) then
        txtAnioFin.Text := IntToStr(StrToInt(txtAnioFin.Text) + 2000);
end;
procedure TfrmReportesCompras.Rellena(Sender: TObject);
var
    i : integer;
begin
    for i := Length((Sender as TEdit).Text) to (Sender as TEdit).MaxLength - 1 do
        (Sender as TEdit).Text := '0' + (Sender as TEdit).Text;
end;

procedure TfrmReportesCompras.txtDiaIniExit(Sender: TObject);
begin
    Rellena(Sender);
end;

end.
