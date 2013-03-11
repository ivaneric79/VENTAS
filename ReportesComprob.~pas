// --------------------------------------------------------------------------
// Archivo del Proyecto Ventas
// Página del proyecto: http://sourceforge.net/projects/ventas
// --------------------------------------------------------------------------
// Este archivo puede ser distribuido y/o modificado bajo lo terminos de la
// Licencia Pública General versión 2 como es publicada por la Free Software
// Fundation, Inc.
// --------------------------------------------------------------------------

unit ReportesComprob;

interface

uses
  SysUtils, Types, Classes, Variants, QTypes, QGraphics, QControls, QForms, 
  QDialogs, QStdCtrls, rpcompobase, rpclxreport, QButtons, QcurrEdit,
  QExtCtrls, IniFiles;

type
  TfrmReportesComprob = class(TForm)
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
    Label2: TLabel;
    grpImpresion: TGroupBox;
    chkPreliminar: TCheckBox;
    btnImprimir: TBitBtn;
    btnCancelar: TBitBtn;
    rptReportes: TCLXReport;
    chkCancelados: TCheckBox;
    rgpComprobante: TRadioGroup;
    cfn: TCheckBox;
    cancela: TCheckBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Numero (Sender: TObject; var Key: Char);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure chkPreliminarClick(Sender: TObject);
    procedure Salta(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure txtAnioIniExit(Sender: TObject);
    procedure txtAnioFinExit(Sender: TObject);
    procedure txtDiaIniExit(Sender: TObject);
    procedure rgpComprobanteClick(Sender: TObject);
  private
    sFechaIni, sFechaFin, sTipo : string;
    procedure RecuperaConfig;
    function VerificaDatos : boolean;
    function VerificaFechas(sFecha : string):boolean;
    procedure ImprimeComprobantes;
    procedure Rellena(Sender: TObject);
    procedure RecuperaIva;
  public
  end;

var
  frmReportesComprob: TfrmReportesComprob;
   siva : string;
    iiva: integer;
    ivageneral: real;

implementation

uses dm;

{$R *.xfm}

procedure TfrmReportesComprob.RecuperaConfig;
var
    iniArchivo : TIniFile;
    sIzq, sArriba, sValor : String;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) +'config.ini');

    with iniArchivo do begin
        //Recupera la posición Y de la ventana
        sArriba := ReadString('RepComprobantes', 'Posy', '');

        //Recupera la posición X de la ventana
        sIzq := ReadString('RepComprobantes', 'Posx', '');

        if (Length(sIzq) > 0) and (Length(sArriba) > 0) then begin
            Left := StrToInt(sIzq);
            Top := StrToInt(sArriba);
        end;

        //Recupera la posición de los botones de radio
        sValor := ReadString('RepComprobantes', 'Tipo', '');
        if (Length(sValor) > 0) then
            rgpComprobante.ItemIndex := StrToInt(sValor);

        //Recupera la opción de comprobantes cancelados
        sValor := ReadString('RepComprobantes', 'Cancelados', '');
        if (sValor = 'S') then
          chkCancelados.Checked := True
        else
          chkCancelados.Checked := False;


        //Recupera la fecha inicial
        sValor := ReadString('RepComprobantes', 'FechaIni', '');
        if (Length(sValor) > 0) then begin
            txtDiaIni.Text := Copy(sValor,1,2);
            txtMesIni.Text := Copy(sValor,4,2);
            txtAnioIni.Text := Copy(sValor,7,4);
        end;

        //Recupera la fecha final
        sValor := ReadString('RepComprobantes', 'FechaFin', '');
        if (Length(sValor) > 0) then begin
            txtDiaFin.Text := Copy(sValor,1,2);
            txtMesFin.Text := Copy(sValor,4,2);
            txtAnioFin.Text := Copy(sValor,7,4);
        end;
        Free;
    end;
end;

procedure TfrmReportesComprob.FormClose(Sender: TObject; var Action: TCloseAction);
var iniArchivo : TIniFile;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) +'config.ini');
    with iniArchivo do begin
        // Registra la posición y de la ventana
        WriteString('RepComprobantes', 'Posy', IntToStr(Top));

        // Registra la posición X de la ventana
        WriteString('RepComprobantes', 'Posx', IntToStr(Left));

        // Registra la posición de los botones de radio
        WriteString('RepComprobantes', 'Tipo', IntToStr(rgpComprobante.ItemIndex));

        // Registra la opción de comprobantes cancelados
        if (chkCancelados.Checked = True) then
            WriteString('RepComprobantes', 'Cancelados', 'S')
        else
            WriteString('RepComprobantes', 'Cancelados', 'N');


        // Registra la fecha inicial
        WriteString('RepComprobantes', 'FechaIni', txtDiaIni.Text + '/' + txtMesIni.Text + '/' + txtAnioIni.Text);

        // Registra la fecha final
        WriteString('RepComprobantes', 'FechaFin', txtDiaFin.Text + '/' + txtMesFin.Text + '/' + txtAnioFin.Text);

        Free;
    end;
end;

procedure TfrmReportesComprob.Numero(Sender: TObject; var Key: Char);
begin
    if not (Key in ['0'..'9',#8]) then
        Key := #0;
end;

procedure TfrmReportesComprob.btnCancelarClick(Sender: TObject);
begin
    Close;
end;

procedure TfrmReportesComprob.chkPreliminarClick(Sender: TObject);
begin
    rptReportes.Preview := chkPreliminar.Checked;
end;

procedure TfrmReportesComprob.btnImprimirClick(Sender: TObject);
begin
    if VerificaDatos then begin
       sTipo := rgpComprobante.Items[rgpComprobante.ItemIndex][2];
       ImprimeComprobantes;
    end;
end;

function TfrmReportesComprob.VerificaDatos : boolean;
begin
    Result:= true;

    sFechaIni := txtMesIni.Text + '/' + txtDiaIni.Text + '/' + txtAnioIni.Text;
    sFechaFin := txtMesFin.Text + '/' + txtDiaFin.Text + '/' + txtAnioFin.Text;

    if(not VerificaFechas(txtDiaIni.Text + '/' + txtMesIni.Text + '/' + txtAnioIni.Text)) then begin
        Application.MessageBox('Introduce una fecha válida','Error',[smbOK],smsCritical);
        sFechaIni := txtMesIni.Text + '/' + txtDiaIni.Text + '/' + txtAnioIni.Text;
        txtDiaIni.SetFocus;
        Result := false;
    end
    else if(not VerificaFechas(txtDiaFin.Text + '/' + txtMesFin.Text + '/' + txtAnioFin.Text)) then begin
        Application.MessageBox('Introduce una fecha válida','Error',[smbOK],smsCritical);
        txtDiaFin.SetFocus;
        Result := false;
    end;
end;

function TfrmReportesComprob.VerificaFechas(sFecha : string):boolean;
var
   dteFecha : TDateTime;
begin
   Result:=true;
   if(not TryStrToDate(sFecha,dteFecha)) then 
      Result:=false;
end;

procedure TfrmReportesComprob.ImprimeComprobantes;
var
    iniArchivo : TIniFile;
    sArchivo : String;
    sDirReportes : String;
    stat: string;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) +'config.ini');
      if(cancela.Checked = True) then begin
        stat:='C';
      end
      else
      begin
      stat:='A';
      end;
//    sDirReportes := iniArchivo.ReadString('Reportes', 'DirReportes', '');

//    if not (Length(sDirReportes) > 0) then
//       sDirReportes:= ExtractFilePath(Application.ExeName)+'Reportes\';

    sArchivo := iniArchivo.ReadString('Reportes', 'Comprobantes', '');
    if (Length(sArchivo) > 0) then begin
    RecuperaIva;
           if (sTipo <> 'F') then
           begin
            cfn.Checked := false;
           end;

           if (sTipo = 'C') then
           begin
           rptReportes.FileName := 'comprecios.rep';
           end
           else
           begin
             rptReportes.FileName := sArchivo;
           end;
//        rptReportes.FileName := sDirReportes + sArchivo;

        rptReportes.Report.DatabaseInfo.Items[0].SQLConnection := dmDatos.sqlBase.DataSets[0].SQLConnection;
        rptReportes.Report.Params.ParamByName('IIVA').Value:= ivageneral;
        rptReportes.Report.Params.ParamByName('FECHAINI').AsString := sFechaIni;
        rptReportes.Report.Params.ParamByName('FECHAFIN').AsString := sFechaFin;
        rptReportes.Report.Params.ParamByName('TIPO').AsString := sTipo;
        if(chkCancelados.Checked = True) then begin
            rptReportes.Report.Params.ParamByName('ESTATUS1').AsString := stat;
            rptReportes.Report.Params.ParamByName('ESTATUS2').AsString := 'C';
        end
        else begin
            rptReportes.Report.Params.ParamByName('ESTATUS1').AsString := stat;
            rptReportes.Report.Params.ParamByName('ESTATUS2').AsString := stat;
        end;
        if (sTipo = 'F')then
        begin
        if (cfn.Checked = True) then
        begin
          rptReportes.Report.Params.ParamByName('CFD').AsString := 'N';
        end
        else
        begin
         rptReportes.Report.Params.ParamByName('CFD').AsString := 'S';
        end;
        end;
        rptReportes.Execute;
    end
    else
        Application.MessageBox('El archivo ' + sArchivo + ' no existe','Error',[smbOK],smsCritical);
end;

procedure TfrmReportesComprob.Salta(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    {Inicio (36), Fin (35), Izquierda (37), derecha (39), arriba (38), abajo (40)}
    if(Key >= 30) and (Key <= 122) and (Key <> 35) and (Key <> 36) and not ((Key >= 37) and (Key <= 40)) then
        if( Length((Sender as TEdit).Text) = (Sender as TEdit).MaxLength) then
            SelectNext(Sender as TWidgetControl, true, true);
end;

procedure TfrmReportesComprob.FormCreate(Sender: TObject);
begin
    RecuperaConfig;
end;

procedure TfrmReportesComprob.txtAnioIniExit(Sender: TObject);
begin
    txtAnioIni.Text := Trim(txtAnioIni.Text);
    if(Length(txtAnioIni.Text) < 4) and (Length(txtAnioIni.Text) > 0) then
        txtAnioIni.Text := IntToStr(StrToInt(txtAnioIni.Text) + 2000);
end;

procedure TfrmReportesComprob.txtAnioFinExit(Sender: TObject);
begin
    txtAnioFin.Text := Trim(txtAnioFin.Text);
    if(Length(txtAnioFin.Text) < 4) and (Length(txtAnioFin.Text) > 0) then
        txtAnioFin.Text := IntToStr(StrToInt(txtAnioFin.Text) + 2000);
end;

procedure TfrmReportesComprob.Rellena(Sender: TObject);
var
    i : integer;
begin
    for i := Length((Sender as TEdit).Text) to (Sender as TEdit).MaxLength - 1 do
        (Sender as TEdit).Text := '0' + (Sender as TEdit).Text;
end;

procedure TfrmReportesComprob.txtDiaIniExit(Sender: TObject);
begin
    Rellena(Sender);
end;

procedure TfrmReportesComprob.RecuperaIva;
var
    iniArchivo : TIniFile;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) +'config.ini');

    with iniArchivo do begin
         //recupera IVA general
     siva := ReadString('IVA', 'ivageneral', '');
    iiva := StrToInt(siva);
    ivageneral := iiva / 100;


        Free;
    end;
end;

procedure TfrmReportesComprob.rgpComprobanteClick(Sender: TObject);
var
tipo:string;
begin
tipo := rgpComprobante.Items[rgpComprobante.ItemIndex][2];
if (tipo = 'F') then
begin
cfn.Visible := true;
end
else
begin
cfn.Visible := false;
end;

end;

end.
