// --------------------------------------------------------------------------
// Archivo del Proyecto Ventas
// Página del proyecto: http://sourceforge.net/projects/ventas
// --------------------------------------------------------------------------
// Este archivo puede ser distribuido y/o modificado bajo lo terminos de la
// Licencia Pública General versión 2 como es publicada por la Free Software
// Fundation, Inc.
// --------------------------------------------------------------------------

unit ReportesVentas;

interface

uses
  SysUtils, Types, Classes, QGraphics, QControls, QForms, QDialogs,
  QStdCtrls, QButtons, QExtCtrls, IniFiles, rpcompobase, rpclxreport,
  QcurrEdit, QMenus, QTypes;

type
  TfrmReportesVentas = class(TForm)
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
    pnlProveedor: TPanel;
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
    pnlAreas: TPanel;
    pnlCaja: TPanel;
    pnlCliente: TPanel;
    txtClienteIni: TEdit;
    txtClienteFin: TEdit;
    pnlUsuario: TPanel;
    txtUsuarioIni: TEdit;
    txtUsuarioFin: TEdit;
    chkPreliminar: TCheckBox;
    txtCajaIni: TcurrEdit;
    txtCajaFin: TcurrEdit;
    cmbAreaIni: TComboBox;
    cmbAreaFin: TComboBox;
    cbfiscal: TCheckBox;
    PopupMenu1: TPopupMenu;
    f11: TMenuItem;
    p2: TLabel;
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
    procedure txtAnioIniExit(Sender: TObject);
    procedure txtAnioFinExit(Sender: TObject);
    procedure txtDiaIniExit(Sender: TObject);
    procedure f11Click(Sender: TObject);
private
    sFechaIni, sFechaFin : string;
    procedure RecuperaConfig;
    procedure CargaCombos;
    function VerificaDatos : boolean;
    function VerificaFechas(sFecha : string):boolean;
    function VerificaRangos : boolean;
    procedure ImprimeVentasPorArea;
    procedure ImprimeVentasPorCaja;
    procedure ImprimeVentasPorCategoria;
    procedure ImprimeVentasPorCliente;
    procedure ImprimeVentasPorCodigo;
    procedure ImprimeVentasPorDepartamento;
    procedure ImprimeVentasPorUsuario;
    procedure ImprimeVentasPorDescripcion;
    procedure ImprimeVentasPorProveedor;
    procedure ImprimeVentasPorVendedor;
    procedure Rellena(Sender: TObject);
  public
  end;

var
  frmReportesVentas: TfrmReportesVentas;

implementation

uses dm;

{$R *.xfm}

procedure TfrmReportesVentas.FormShow(Sender: TObject);
begin
    CargaCombos;
    rgpOrdenClick(Sender);
    rdoTodoClick(Sender);
end;

procedure TfrmReportesVentas.CargaCombos;
begin
    cmbAreaIni.Items.Clear;
    cmbAreaFin.Items.Clear;
    cmbCategIni.Clear;
    cmbCategFin.Clear;
    cmbDeptoIni.Clear;
    cmbDeptoFin.Clear;

    with dmDatos.qryConsulta do begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT nombre FROM areasventa ORDER BY nombre');
        Open;

        while(not EOF) do begin
            cmbAreaIni.Items.Add(FieldByName('nombre').AsString);
            cmbAreaFin.Items.Add(FieldByName('nombre').AsString);
            Next;
        end;

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
    cmbAreaIni.ItemIndex := 0;
    cmbAreaFin.ItemIndex := 0;
    cmbCategIni.ItemIndex := 0;
    cmbCategFin.ItemIndex := 0;
    cmbDeptoIni.ItemIndex := 0;
    cmbDeptoFin.ItemIndex := 0;
end;

procedure TfrmReportesVentas.RecuperaConfig;
var
    iniArchivo : TIniFile;
    sIzq, sArriba, sValor : String;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) +'config.ini');

    with iniArchivo do begin
        //Recupera la posición Y de la ventana
        sArriba := ReadString('RepVentas', 'Posy', '');

        //Recupera la posición X de la ventana
        sIzq := ReadString('RepVentas', 'Posx', '');

        if (Length(sIzq) > 0) and (Length(sArriba) > 0) then begin
            Left := StrToInt(sIzq);
            Top := StrToInt(sArriba);
        end;

        //Recupera la posición de los botones de radio
        sValor := ReadString('RepVentas', 'Tipo', '');
        if (Length(sValor) > 0) then
            rgpOrden.ItemIndex := StrToInt(sValor);

        //Recupera la fecha inicial
        sValor := ReadString('RepVentas', 'FechaIni', '');
        if (Length(sValor) > 0) then begin
            txtDiaIni.Text := Copy(sValor,1,2);
            txtMesIni.Text := Copy(sValor,4,2);
            txtAnioIni.Text := Copy(sValor,7,4);
        end;

        //Recupera la fecha final
        sValor := ReadString('RepVentas', 'FechaFin', '');
        if (Length(sValor) > 0) then begin
            txtDiaFin.Text := Copy(sValor,1,2);
            txtMesFin.Text := Copy(sValor,4,2);
            txtAnioFin.Text := Copy(sValor,7,4);
        end;
        Free;
    end;
end;

procedure TfrmReportesVentas.FormClose(Sender: TObject; var Action: TCloseAction);
  var iniArchivo : TIniFile;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) +'config.ini');
    with iniArchivo do begin
        // Registra la posición y de la ventana
        WriteString('RepVentas', 'Posy', IntToStr(Top));

        // Registra la posición X de la ventana
        WriteString('RepVentas', 'Posx', IntToStr(Left));

        // Registra la posición de los botones de radio
        WriteString('RepVentas', 'Tipo', IntToStr(rgpOrden.ItemIndex));

        // Registra la fecha inicial
        WriteString('RepVentas', 'FechaIni', txtDiaIni.Text + '/' + txtMesIni.Text + '/' + txtAnioIni.Text);

        // Registra la fecha final
        WriteString('RepVentas', 'FechaFin', txtDiaFin.Text + '/' + txtMesFin.Text + '/' + txtAnioFin.Text);

        Free;
    end;
end;

procedure TfrmReportesVentas.rgpOrdenClick(Sender: TObject);
begin
    pnlAreas.Visible := false;
    pnlCaja.Visible := false;
    pnlCateg.Visible := false;
    pnlCliente.Visible := false;
    pnlCodigo.Visible := false;
    pnlDepto.Visible := false;
    pnlDescrip.Visible := false;
    pnlProveedor.Visible := false;
    pnlUsuario.Visible := false;

    case rgpOrden.ItemIndex of
        0: Begin
            pnlAreas.Visible := true;
            cbfiscal.Enabled:=false;
           end;
        1: Begin
            pnlCaja.Visible := true;
            cbfiscal.Enabled:=false;
           end;
        2: Begin
            pnlCateg.Visible := true;
            cbfiscal.Enabled:=false;
           end;
        3: Begin
            pnlCliente.Visible := true;
            cbfiscal.Enabled:=false;
           end;
        4: Begin
            pnlCodigo.Visible := true;
            cbfiscal.Enabled:=true;
           end;
        5: Begin
            pnlDepto.Visible := true;
            cbfiscal.Enabled:=false;
           end;
        6: Begin
            pnlDescrip.Visible := true;
            cbfiscal.Enabled:=false;
           end;
        7: Begin
            pnlProveedor.Visible := true;
            cbfiscal.Enabled:=false;
           end;
        8: Begin
            pnlUsuario.Visible := true;
            cbfiscal.Enabled:=false;
           end;
    end;
end;

procedure TfrmReportesVentas.rdoTodoClick(Sender: TObject);
begin
    if(rdoTodo.Checked) then begin
        lblDesde.Enabled := false;
        lblHasta.Enabled := false;

        cmbAreaIni.Enabled := false;
        cmbAreaFin.Enabled := false;
        txtCajaIni.Enabled := false;
        txtCajaFin.Enabled := false;
        txtClienteIni.Enabled := false;
        txtClienteFin.Enabled := false;
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

    end
    else begin
        lblDesde.Enabled := true;
        lblHasta.Enabled := true;

        cmbAreaIni.Enabled := true;
        cmbAreaFin.Enabled := true;
        txtCajaIni.Enabled := true;
        txtCajaFin.Enabled := true;
        txtClienteIni.Enabled := true;
        txtClienteFin.Enabled := true;
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
    end;
end;

procedure TfrmReportesVentas.cmbDeptoIniSelect(Sender: TObject);
begin
    if(cmbDeptoFin.ItemIndex < cmbDeptoIni.ItemIndex) then
        cmbDeptoFin.ItemIndex := cmbDeptoIni.ItemIndex;
end;

procedure TfrmReportesVentas.Numero(Sender: TObject; var Key: Char);
begin
    if not (Key in ['0'..'9',#8]) then
        Key := #0;
end;

procedure TfrmReportesVentas.btnCancelarClick(Sender: TObject);
begin
    Close;
end;

procedure TfrmReportesVentas.chkPreliminarClick(Sender: TObject);
begin
    rptReportes.Preview := chkPreliminar.Checked;
end;

procedure TfrmReportesVentas.btnImprimirClick(Sender: TObject);
begin
    if VerificaDatos then
       case rgpOrden.ItemIndex of
            0: ImprimeVentasPorArea;
            1: ImprimeVentasPorCaja;
            2: ImprimeVentasPorCategoria;
            3: ImprimeVentasPorCliente;
            4: ImprimeVentasPorCodigo;
            5: ImprimeVentasPorDepartamento;
            6: ImprimeVentasPorDescripcion;
            7: ImprimeVentasPorProveedor;            
            8: ImprimeVentasPorUsuario;
            9: ImprimeVentasPorVendedor;

        end;
end;

function TfrmReportesVentas.VerificaDatos : boolean;
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

function TfrmReportesVentas.VerificaFechas(sFecha : string):boolean;
var
   dteFecha : TDateTime;
begin
   Result:=true;
   if(not TryStrToDate(sFecha,dteFecha)) then
      Result:=false;
end;

function TfrmReportesVentas.VerificaRangos : boolean;
var
   bResult : boolean;
begin
    bResult:= true;
    if rdoRango.Checked then
       case rgpOrden.ItemIndex of
          0 : if (Length(cmbAreaIni.Text)=0) or (Length(cmbAreaFin.Text)=0) then
                bResult := false;
          1 : if (Length(txtCajaIni.Text)=0) or (Length(txtCajaFin.Text)=0) then
                bResult := false;
          2 : if (Length(cmbCategIni.Text)=0) or (Length(cmbCategFin.Text)=0) then
                bResult := false;
          3 : if (Length(txtClienteIni.Text)=0) or (Length(txtClienteFin.Text)=0) then
                bResult := false;
          4 : if (Length(txtCodigoIni.Text)=0) or (Length(txtCodigoFin.Text)=0) then
                bResult := false;
          5 : if (Length(cmbDeptoIni.Text)=0) or (Length(cmbDeptoFin.Text)=0) then
                bResult := false;
          6 : if (Length(txtDescripIni.Text)=0) or (Length(txtDescripFin.Text)=0) then
                bResult := false;
          7 : if (Length(txtProvIni.Text)=0) or (Length(txtProvFin.Text)=0) then
                bResult := false;
          8 : if (Length(txtUsuarioIni.Text)=0) or (Length(txtUsuarioFin.Text)=0) then
                bResult := false;
       end;

    if not bResult then
        Application.MessageBox('Introduce un rango válido','Error',[smbOK],smsCritical);

    Result := bResult
end;

procedure TfrmReportesVentas.ImprimeVentasPorArea;
var
    iniArchivo : TIniFile;
    sArchivo : String;
    sDirReportes : String;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) +'config.ini');

    sDirReportes := iniArchivo.ReadString('Reportes', 'DirReportes', '');

    if not (Length(sDirReportes) > 0) then
       sDirReportes:= ExtractFilePath(Application.ExeName)+'Reportes\';

    sArchivo := iniArchivo.ReadString('Reportes', 'VentasArea', '');
    if (Length(sArchivo) > 0) then begin
        rptReportes.FileName := sDirReportes + sArchivo;
        rptReportes.Report.DatabaseInfo.Items[0].SQLConnection := dmDatos.sqlBase.DataSets[0].SQLConnection;
        rptReportes.Report.Params.ParamByName('FECHAINI').AsString := sFechaIni;
        rptReportes.Report.Params.ParamByName('FECHAFIN').AsString := sFechaFin;
        if(rdoTodo.Checked) then begin
            rptReportes.Report.Params.ParamByName('AREAINI').AsString := '';
            rptReportes.Report.Params.ParamByName('AREAFIN').AsString := 'ZZZZZZZZZZ';
        end
        else begin
            rptReportes.Report.Params.ParamByName('AREAINI').AsString := cmbAreaIni.Text;
            rptReportes.Report.Params.ParamByName('AREAFIN').AsString := cmbAreaFin.Text;
        end;

        rptReportes.Execute;
    end
    else
        Application.MessageBox('El archivo ' + sArchivo + ' no existe','Error',[smbOK],smsCritical);
end;

procedure TfrmReportesVentas.ImprimeVentasPorCaja;
var
    iniArchivo : TIniFile;
    sArchivo : String;
    sDirReportes : String;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) +'config.ini');

    sDirReportes := iniArchivo.ReadString('Reportes', 'DirReportes', '');

    if not (Length(sDirReportes) > 0) then
       sDirReportes:= ExtractFilePath(Application.ExeName)+'Reportes\';

    sArchivo := iniArchivo.ReadString('Reportes', 'VentasCaja', '');
    if (Length(sArchivo) > 0) then begin
        rptReportes.FileName := sDirReportes + sArchivo;
        rptReportes.Report.DatabaseInfo.Items[0].SQLConnection := dmDatos.sqlBase.DataSets[0].SQLConnection;
        rptReportes.Report.Params.ParamByName('FECHAINI').AsString := sFechaIni;
        rptReportes.Report.Params.ParamByName('FECHAFIN').AsString := sFechaFin;


        if(rdoTodo.Checked) then begin
            rptReportes.Report.Params.ParamByName('CAJAINI').AsString := '1';
            rptReportes.Report.Params.ParamByName('CAJAFIN').AsString := '999';
        end
        else begin
            rptReportes.Report.Params.ParamByName('CAJAINI').AsString := FloatToStr(txtCajaIni.Value);
            rptReportes.Report.Params.ParamByName('CAJAFIN').AsString := FloatToStr(txtCajaFin.Value);
        end;
       if cbfiscal.Checked then
        begin
          rptReportes.Report.Params.ParamByName('FISCALES').AsString  := 'P';

     end
     else
     begin
     rptReportes.Report.Params.ParamByName('FISCALES').AsString  := 'T';
     end;
        rptReportes.Execute;
    end
    else
        Application.MessageBox('El archivo ' + sArchivo + ' no existe','Error',[smbOK],smsCritical);
end;

procedure TfrmReportesVentas.ImprimeVentasPorCategoria;
var
    iniArchivo : TIniFile;
    sArchivo : String;
    sDirReportes : String;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) +'config.ini');

    sDirReportes := iniArchivo.ReadString('Reportes', 'DirReportes', '');

    if not (Length(sDirReportes) > 0) then
       sDirReportes:= ExtractFilePath(Application.ExeName)+'Reportes\';

    sArchivo := iniArchivo.ReadString('Reportes', 'VentasCategoria', '');
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
        {if cbfiscal.Checked then
         rptReportes.Report.Params.ParamByName('FISCALES').AsString  := '1'
        else
         rptReportes.Report.Params.ParamByName('FISCALES').AsString :='0';  }
               if cbfiscal.Checked then
        begin
          rptReportes.Report.Params.ParamByName('FISCALES').AsString  := 'P';

     end
     else
     begin
     rptReportes.Report.Params.ParamByName('FISCALES').AsString  := 'T';
     end;
        rptReportes.Execute;
    end
    else
        Application.MessageBox('El archivo ' + sArchivo + ' no existe','Error',[smbOK],smsCritical);
end;

procedure TfrmReportesVentas.ImprimeVentasPorCliente;
var
    iniArchivo : TIniFile;
    sArchivo : String;
    sDirReportes : String;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) +'config.ini');

    sDirReportes := iniArchivo.ReadString('Reportes', 'DirReportes', '');

    if not (Length(sDirReportes) > 0) then
       sDirReportes:= ExtractFilePath(Application.ExeName)+'Reportes\';

    sArchivo := iniArchivo.ReadString('Reportes', 'VentasCliente', '');
    if (Length(sArchivo) > 0) then begin
        rptReportes.FileName := sDirReportes + sArchivo;
        rptReportes.Report.DatabaseInfo.Items[0].SQLConnection := dmDatos.sqlBase.DataSets[0].SQLConnection;
        rptReportes.Report.Params.ParamByName('FECHAINI').AsString := sFechaIni;
        rptReportes.Report.Params.ParamByName('FECHAFIN').AsString := sFechaFin;
        if(rdoTodo.Checked) then begin
            rptReportes.Report.Params.ParamByName('CLIENTEINI').AsString := '';
            rptReportes.Report.Params.ParamByName('CLIENTEFIN').AsString := 'ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ';
        end
        else begin
            rptReportes.Report.Params.ParamByName('CLIENTEINI').AsString := txtClienteIni.Text;
            rptReportes.Report.Params.ParamByName('CLIENTEFIN').AsString := txtClienteFin.Text;
        end;
        if cbfiscal.Checked then
        begin
          rptReportes.Report.Params.ParamByName('FISCALES').AsString  := 'P';

     end
     else
     begin
     rptReportes.Report.Params.ParamByName('FISCALES').AsString  := 'T';
     end;
        rptReportes.Execute;
    end
    else
        Application.MessageBox('El archivo ' + sArchivo + ' no existe','Error',[smbOK],smsCritical);
end;

procedure TfrmReportesVentas.ImprimeVentasPorCodigo;
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
      sArchivo := iniArchivo.ReadString('Reportes', 'VentasCodigoFiscal', '')
    else
      sArchivo := iniArchivo.ReadString('Reportes', 'VentasCodigo', '');

    if (Length(sArchivo) > 0) then
     begin
        rptReportes.FileName := sDirReportes + sArchivo;
        rptReportes.Report.DatabaseInfo.Items[0].SQLConnection := dmDatos.sqlBase.DataSets[0].SQLConnection;
        rptReportes.Report.Params.ParamByName('FECHAINI').AsString := sFechaIni;
        rptReportes.Report.Params.ParamByName('FECHAFIN').AsString := sFechaFin;
        if(rdoTodo.Checked) then begin
            rptReportes.Report.Params.ParamByName('CODIGOINI').AsString := '';
            rptReportes.Report.Params.ParamByName('CODIGOFIN').AsString := 'ZZZZZZZZZZZZZ';
        end
        else
        begin
            rptReportes.Report.Params.ParamByName('CODIGOINI').AsString := txtCodigoIni.Text;
            rptReportes.Report.Params.ParamByName('CODIGOFIN').AsString := txtCodigoFin.Text;
        end;
        if cbfiscal.Checked then
          rptReportes.Report.Params.ParamByName('FISCALES').AsString  := '1';
        rptReportes.Execute;
     end
    else
        Application.MessageBox('El archivo ' + sArchivo + ' no existe','Error',[smbOK],smsCritical);
end;

procedure TfrmReportesVentas.ImprimeVentasPorDepartamento;
var
    iniArchivo : TIniFile;
    sArchivo : String;
    sDirReportes : String;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) +'config.ini');

    sDirReportes := iniArchivo.ReadString('Reportes', 'DirReportes', '');

    if not (Length(sDirReportes) > 0) then
       sDirReportes:= ExtractFilePath(Application.ExeName)+'Reportes\';

    sArchivo := iniArchivo.ReadString('Reportes', 'VentasDepartamento', '');
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
         if cbfiscal.Checked then
        begin
          rptReportes.Report.Params.ParamByName('FISCALES').AsString  := 'P';

     end
     else
     begin
     rptReportes.Report.Params.ParamByName('FISCALES').AsString  := 'T';
     end;

       {if cbfiscal.Checked then
         rptReportes.Report.Params.ParamByName('FISCALES').AsString  := '1'
        else
         rptReportes.Report.Params.ParamByName('FISCALES').AsString :='0';  }

        rptReportes.Execute;
    end
    else
        Application.MessageBox('El archivo ' + sArchivo + ' no existe','Error',[smbOK],smsCritical);
end;

procedure TfrmReportesVentas.ImprimeVentasPorDescripcion;
var
    iniArchivo : TIniFile;
    sArchivo : String;
    sDirReportes : String;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) +'config.ini');

    sDirReportes := iniArchivo.ReadString('Reportes', 'DirReportes', '');

    if not (Length(sDirReportes) > 0) then
       sDirReportes:= ExtractFilePath(Application.ExeName)+'Reportes\';

    sArchivo := iniArchivo.ReadString('Reportes', 'VentasDescripcion', '');
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
       { if cbfiscal.Checked then
         rptReportes.Report.Params.ParamByName('FISCALES').AsString  := '1'
        else
         rptReportes.Report.Params.ParamByName('FISCALES').AsString :='0';  }
               if cbfiscal.Checked then
        begin
          rptReportes.Report.Params.ParamByName('FISCALES').AsString  := 'P';

     end
     else
     begin
     rptReportes.Report.Params.ParamByName('FISCALES').AsString  := 'T';
     end;
        rptReportes.Execute;
    end
    else
        Application.MessageBox('El archivo ' + sArchivo + ' no existe','Error',[smbOK],smsCritical);
end;

procedure TfrmReportesVentas.ImprimeVentasPorProveedor;
var
    iniArchivo : TIniFile;
    sArchivo : String;
    sDirReportes : String;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) +'config.ini');

    sDirReportes := iniArchivo.ReadString('Reportes', 'DirReportes', '');

    if not (Length(sDirReportes) > 0) then
       sDirReportes:= ExtractFilePath(Application.ExeName)+'Reportes\';

    sArchivo := iniArchivo.ReadString('Reportes', 'VentasProveedor', '');
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
        {if cbfiscal.Checked then
         rptReportes.Report.Params.ParamByName('FISCALES').AsString  := '1'
        else
         rptReportes.Report.Params.ParamByName('FISCALES').AsString :='0';}
             if cbfiscal.Checked then
        begin
          rptReportes.Report.Params.ParamByName('FISCALES').AsString  := 'P';

     end
     else
     begin
     rptReportes.Report.Params.ParamByName('FISCALES').AsString  := 'T';
     end;
        rptReportes.Execute;
    end
    else
        Application.MessageBox('El archivo ' + sArchivo + ' no existe','Error',[smbOK],smsCritical);
end;

procedure TfrmReportesVentas.ImprimeVentasPorVendedor;
var
    iniArchivo : TIniFile;
    sArchivo : String;
    sDirReportes : String;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) +'config.ini');

    sDirReportes := iniArchivo.ReadString('Reportes', 'DirReportes', '');

    if not (Length(sDirReportes) > 0) then
       sDirReportes:= ExtractFilePath(Application.ExeName)+'Reportes\';

   // sArchivo := iniArchivo.ReadString('Reportes', 'VentasProveedor', '');
   sArchivo := 'Ventasporvendedor.rep';
    if (Length(sArchivo) > 0) then begin
        rptReportes.FileName := sDirReportes + sArchivo;
        rptReportes.Report.DatabaseInfo.Items[0].SQLConnection := dmDatos.sqlBase.DataSets[0].SQLConnection;
        rptReportes.Report.Params.ParamByName('FECHAINI').AsString := sFechaIni;
        rptReportes.Report.Params.ParamByName('FECHAFIN').AsString := sFechaFin;
       if (cbfiscal.Checked = true) then
       begin
        rptReportes.Report.Params.ParamByName('P2').AsString := 'P';
        end
        else
        begin
          rptReportes.Report.Params.ParamByName('P2').AsString := 'T';
        end;
        if(rdoTodo.Checked) then begin
            rptReportes.Report.Params.ParamByName('PROVINI').AsString := '1';
            rptReportes.Report.Params.ParamByName('PROVFIN').AsString := '9999';
        end
        else begin
            rptReportes.Report.Params.ParamByName('PROVINI').AsString := txtProvIni.Text;
            rptReportes.Report.Params.ParamByName('PROVFIN').AsString := txtProvFin.Text;
        end;
        {if cbfiscal.Checked then
         rptReportes.Report.Params.ParamByName('FISCALES').AsString  := '1'
        else
         rptReportes.Report.Params.ParamByName('FISCALES').AsString :='0';}
        rptReportes.Execute;
    end
    else
        Application.MessageBox('El archivo ' + sArchivo + ' no existe','Error',[smbOK],smsCritical);
end;

procedure TfrmReportesVentas.ImprimeVentasPorUsuario;
var
    iniArchivo : TIniFile;
    sArchivo : String;
    sDirReportes : String;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) +'config.ini');

    sDirReportes := iniArchivo.ReadString('Reportes', 'DirReportes', '');

    if not (Length(sDirReportes) > 0) then
       sDirReportes:= ExtractFilePath(Application.ExeName)+'Reportes\';

    sArchivo := iniArchivo.ReadString('Reportes', 'VentasUsuario', '');
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
           if cbfiscal.Checked then
        begin
          rptReportes.Report.Params.ParamByName('FISCALES').AsString  := 'P';

     end
     else
     begin
     rptReportes.Report.Params.ParamByName('FISCALES').AsString  := 'T';
     end;
        rptReportes.Execute;
    end
    else
        Application.MessageBox('El archivo ' + sArchivo + ' no existe','Error',[smbOK],smsCritical);
end;

procedure TfrmReportesVentas.Salta(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    {Inicio (36), Fin (35), Izquierda (37), derecha (39), arriba (38), abajo (40)}
    if(Key >= 30) and (Key <= 122) and (Key <> 35) and (Key <> 36) and not ((Key >= 37) and (Key <= 40)) then
        if( Length((Sender as TEdit).Text) = (Sender as TEdit).MaxLength) then
            SelectNext(Sender as TWidgetControl, true, true);
end;

procedure TfrmReportesVentas.FormCreate(Sender: TObject);
begin
    RecuperaConfig;
end;

procedure TfrmReportesVentas.txtAnioIniExit(Sender: TObject);
begin
    txtAnioIni.Text := Trim(txtAnioIni.Text);
    if(Length(txtAnioIni.Text) < 4) and (Length(txtAnioIni.Text) > 0) then
        txtAnioIni.Text := IntToStr(StrToInt(txtAnioIni.Text) + 2000);
end;

procedure TfrmReportesVentas.txtAnioFinExit(Sender: TObject);
begin
    txtAnioFin.Text := Trim(txtAnioFin.Text);
    if(Length(txtAnioFin.Text) < 4) and (Length(txtAnioFin.Text) > 0) then
        txtAnioFin.Text := IntToStr(StrToInt(txtAnioFin.Text) + 2000);
end;

procedure TfrmReportesVentas.Rellena(Sender: TObject);
var
    i : integer;
begin
    for i := Length((Sender as TEdit).Text) to (Sender as TEdit).MaxLength - 1 do
        (Sender as TEdit).Text := '0' + (Sender as TEdit).Text;
end;

procedure TfrmReportesVentas.txtDiaIniExit(Sender: TObject);
begin
    Rellena(Sender);
end;

procedure TfrmReportesVentas.f11Click(Sender: TObject);
begin


if (cbfiscal.Checked = true) then
begin
p2.Visible:=false;
cbfiscal.Checked := false;

end
else
begin
p2.Visible:=true;
cbfiscal.Checked := true;
end;
end;

end.
