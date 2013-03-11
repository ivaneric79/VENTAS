// --------------------------------------------------------------------------
// Archivo del Proyecto Ventas
// Página del proyecto: http://sourceforge.net/projects/ventas
// --------------------------------------------------------------------------
// Este archivo puede ser distribuido y/o modificado bajo lo terminos de la
// Licencia Pública General versión 2 como es publicada por la Free Software
// Fundation, Inc.
// --------------------------------------------------------------------------

unit ReportesXPagar;

interface

uses
  SysUtils, Types, Classes, QGraphics, QControls, QForms, QDialogs,
  QStdCtrls, QButtons, QExtCtrls, IniFiles, rpcompobase, rpclxreport,
  QcurrEdit;

type
  TfrmReportesXPagar = class(TForm)
    grpDeptos: TGroupBox;
    lblDesde: TLabel;
    lblHasta: TLabel;
    rdoTodo: TRadioButton;
    rdoRango: TRadioButton;
    grpFechas: TGroupBox;
    Label2: TLabel;
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
    btnImprimir: TBitBtn;
    rptReportes: TCLXReport;
    btnCancelar: TBitBtn;
    pnlProveedor: TPanel;
    txtClienteIni: TEdit;
    txtClienteFin: TEdit;
    chkPreliminar: TCheckBox;
    rdoVencidos: TRadioButton;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure rdoTodoClick(Sender: TObject);
    procedure Numero (Sender: TObject; var Key: Char);
    procedure btnImprimirClick(Sender: TObject);
    procedure chkPreliminarClick(Sender: TObject);
    procedure Salta(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure txtAnioIniExit(Sender: TObject);
    procedure txtAnioFinExit(Sender: TObject);
    procedure txtDiaIniExit(Sender: TObject);
private
    sFechaIni, sFechaFin : string;
    procedure RecuperaConfig;
    function VerificaDatos : boolean;
    function VerificaFechas(sFecha : string):boolean;
    function VerificaRangos : boolean;
    procedure ImprimePagosGenerales;
    procedure ImprimeVencidos;
    procedure Rellena(Sender: TObject);
public

  end;

var
  frmReportesXPagar: TfrmReportesXPagar;

implementation

uses dm;

{$R *.xfm}

procedure TfrmReportesXPagar.FormShow(Sender: TObject);
begin
    rdoTodoClick(Sender);
end;

procedure TfrmReportesXPagar.RecuperaConfig;
var
    iniArchivo : TIniFile;
    sIzq, sArriba, sValor : String;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) +'config.ini');

    with iniArchivo do begin
        //Recupera la posición Y de la ventana
        sArriba := ReadString('RepXPagar', 'Posy', '');

        //Recupera la posición X de la ventana
        sIzq := ReadString('RepXPagar', 'Posx', '');

        if (Length(sIzq) > 0) and (Length(sArriba) > 0) then begin
            Left := StrToInt(sIzq);
            Top := StrToInt(sArriba);
        end;

        //Recupera la fecha inicial
        sValor := ReadString('RepXPagar', 'FechaIni', '');
        if (Length(sValor) > 0) then begin
            txtDiaIni.Text := Copy(sValor,1,2);
            txtMesIni.Text := Copy(sValor,4,2);
            txtAnioIni.Text := Copy(sValor,7,4);
        end;

        //Recupera la fecha final
        sValor := ReadString('RepXPagar', 'FechaFin', '');
        if (Length(sValor) > 0) then begin
            txtDiaFin.Text := Copy(sValor,1,2);
            txtMesFin.Text := Copy(sValor,4,2);
            txtAnioFin.Text := Copy(sValor,7,4);
        end;
        Free;
    end;
end;

procedure TfrmReportesXPagar.FormClose(Sender: TObject; var Action: TCloseAction);
  var iniArchivo : TIniFile;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) +'config.ini');
    with iniArchivo do begin
        // Registra la posición y de la ventana
        WriteString('RepXPagar', 'Posy', IntToStr(Top));

        // Registra la posición X de la ventana
        WriteString('RepXPagar', 'Posx', IntToStr(Left));

        // Registra la fecha inicial
        WriteString('RepXPagar', 'FechaIni', txtDiaIni.Text + '/' + txtMesIni.Text + '/' + txtAnioIni.Text);

        // Registra la fecha final
        WriteString('RepXPagar', 'FechaFin', txtDiaFin.Text + '/' + txtMesFin.Text + '/' + txtAnioFin.Text);

        Free;
    end;
end;

procedure TfrmReportesXPagar.rdoTodoClick(Sender: TObject);
begin
    if (rdoTodo.Checked) then begin
        rdoRango.Checked := False;
        rdoVencidos.Checked := False;
    end
    else
    if (rdoRango.Checked) then begin
        rdoTodo.Checked := False;
        rdoVencidos.Checked := False;
    end
    else begin
        rdoTodo.Checked := False;
        rdoRango.Checked := False;
    end;

    lblDesde.Enabled := rdoRango.Checked;
    lblHasta.Enabled := rdoRango.Checked;
    pnlProveedor.Enabled := rdoRango.Checked;
    grpFechas.Enabled := not rdoVencidos.Checked;
end;

procedure TfrmReportesXPagar.Numero(Sender: TObject; var Key: Char);
begin
    if not (Key in ['0'..'9',#8]) then
        Key := #0;
end;

procedure TfrmReportesXPagar.chkPreliminarClick(Sender: TObject);
begin
    rptReportes.Preview := chkPreliminar.Checked;
end;

procedure TfrmReportesXPagar.btnImprimirClick(Sender: TObject);
begin
    if VerificaDatos then
        if (rdoVencidos.Checked) then
            ImprimeVencidos
        else
            ImprimePagosGenerales;
end;

function TfrmReportesXPagar.VerificaDatos : boolean;
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

function TfrmReportesXPagar.VerificaFechas(sFecha : string):boolean;
var
   dteFecha : TDateTime;
begin
   Result:=true;
   if(not TryStrToDate(sFecha,dteFecha)) then
      Result:=false;
end;

function TfrmReportesXPagar.VerificaRangos : boolean;
begin
    Result:= true;
    if rdoRango.Checked then
        if (Length(txtClienteIni.Text)=0) or (Length(txtClienteFin.Text)=0) then begin
            Result := false;
            Application.MessageBox('Introduce un rango válido para los clientes','Error',[smbOK],smsCritical);
        end;
end;

procedure TfrmReportesXPagar.ImprimePagosGenerales;
var
    iniArchivo : TIniFile;
    sArchivo : String;
    sDirReportes : String;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) +'config.ini');

    sDirReportes := iniArchivo.ReadString('Reportes', 'DirReportes', '');

    if not (Length(sDirReportes) > 0) then
       sDirReportes:= ExtractFilePath(Application.ExeName)+'Reportes\';

    sArchivo := iniArchivo.ReadString('Reportes', 'XPagarPagosGenerales', '');
    if (Length(sArchivo) > 0) then begin
        rptReportes.FileName := sDirReportes + sArchivo;
        rptReportes.Report.DatabaseInfo.Items[0].SQLConnection := dmDatos.sqlBase.DataSets[0].SQLConnection;
        rptReportes.Report.Params.ParamByName('FECHAINI').AsString := sFechaIni;
        rptReportes.Report.Params.ParamByName('FECHAFIN').AsString := sFechaFin;
        if(rdoTodo.Checked) then begin
            rptReportes.Report.Params.ParamByName('PROVEEDORINI').AsString := '';
            rptReportes.Report.Params.ParamByName('PROVEEDORFIN').AsString := 'ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ';
        end
        else begin
            rptReportes.Report.Params.ParamByName('PROVEEDORINI').AsString := txtClienteIni.Text;
            rptReportes.Report.Params.ParamByName('PROVEEDORFIN').AsString := txtClienteFin.Text;
        end;
        rptReportes.Execute;
    end
    else
        Application.MessageBox('El archivo ' + sArchivo + ' no existe','Error',[smbOK],smsCritical);
end;

procedure TfrmReportesXPagar.ImprimeVencidos;
var
    iniArchivo : TIniFile;
    sArchivo : String;
    sDirReportes : String;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) +'config.ini');

    sDirReportes := iniArchivo.ReadString('Reportes', 'DirReportes', '');

    if not (Length(sDirReportes) > 0) then
       sDirReportes:= ExtractFilePath(Application.ExeName)+'Reportes\';

    sArchivo := iniArchivo.ReadString('Reportes', 'XPagarVencidos', '');
    if (Length(sArchivo) > 0) then begin
        rptReportes.FileName :=  sDirReportes + sArchivo;
        rptReportes.Report.DatabaseInfo.Items[0].SQLConnection := dmDatos.sqlBase.DataSets[0].SQLConnection;
        rptReportes.Report.Params.ParamByName('FECHAACTUAL').AsString := FormatDateTime('mm/dd/yyyy',Date);
        rptReportes.Execute;
    end
    else
        Application.MessageBox('El archivo ' + sArchivo + ' no existe','Error',[smbOK],smsCritical);
end;

procedure TfrmReportesXPagar.Salta(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    {Inicio (36), Fin (35), Izquierda (37), derecha (39), arriba (38), abajo (40)}
    if(Key >= 30) and (Key <= 122) and (Key <> 35) and (Key <> 36) and not ((Key >= 37) and (Key <= 40)) then
        if( Length((Sender as TEdit).Text) = (Sender as TEdit).MaxLength) then
            SelectNext(Sender as TWidgetControl, true, true);
end;

procedure TfrmReportesXPagar.FormCreate(Sender: TObject);
begin
    RecuperaConfig;
end;

procedure TfrmReportesXPagar.txtAnioIniExit(Sender: TObject);
begin
    txtAnioIni.Text := Trim(txtAnioIni.Text);
    if(Length(txtAnioIni.Text) < 4) and (Length(txtAnioIni.Text) > 0) then
        txtAnioIni.Text := IntToStr(StrToInt(txtAnioIni.Text) + 2000);
end;

procedure TfrmReportesXPagar.txtAnioFinExit(Sender: TObject);
begin
    txtAnioFin.Text := Trim(txtAnioFin.Text);
    if(Length(txtAnioFin.Text) < 4) and (Length(txtAnioFin.Text) > 0) then
        txtAnioFin.Text := IntToStr(StrToInt(txtAnioFin.Text) + 2000);
end;

procedure TfrmReportesXPagar.Rellena(Sender: TObject);
var
    i : integer;
begin
    for i := Length((Sender as TEdit).Text) to (Sender as TEdit).MaxLength - 1 do
        (Sender as TEdit).Text := '0' + (Sender as TEdit).Text;
end;

procedure TfrmReportesXPagar.txtDiaIniExit(Sender: TObject);
begin
    Rellena(Sender)
end;

end.
