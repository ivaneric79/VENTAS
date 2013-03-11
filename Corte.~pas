// --------------------------------------------------------------------------
// Archivo del Proyecto Ventas
// Página del proyecto: http://sourceforge.net/projects/ventas
// --------------------------------------------------------------------------
// Este archivo puede ser distribuido y/o modificado bajo lo terminos de la
// Licencia Pública General versión 2 como es publicada por la Free Software
// Fundation, Inc.
// --------------------------------------------------------------------------

unit Corte;

interface

uses
  SysUtils, Types, Classes, QGraphics, QControls, QForms, QDialogs, QPrinters,
  QStdCtrls, QMenus, QTypes, QcurrEdit, QButtons, QGrids, IniFiles,
  rpcompobase, rpclxreport,Windows ;

type
  TfrmCorte = class(TForm)
    grpDatos: TGroupBox;
    MainMenu1: TMainMenu;
    Corte1: TMenuItem;
    Reimpresin1: TMenuItem;
    Label1: TLabel;
    txtCaja: TcurrEdit;
    Label29: TLabel;
    txtDia: TEdit;
    txtMes: TEdit;
    txtAnio: TEdit;
    Label30: TLabel;
    Label31: TLabel;
    txtUsuario: TEdit;
    grpReimpresion: TGroupBox;
    btnAceptar: TBitBtn;
    btnCancelar: TBitBtn;
    grdCortes: TStringGrid;
    btnReimprimir: TBitBtn;
    btnEliminar: TBitBtn;
    Label2: TLabel;
    rptCorte: TCLXReport;
    Cortedelda1: TMenuItem;
    CorteDaAnterior1: TMenuItem;
    Respaldar1: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnAceptarClick(Sender: TObject);
    procedure btnReimprimirClick(Sender: TObject);
    procedure btnEliminarClick(Sender: TObject);
    procedure Reimpresin1Click(Sender: TObject);
    procedure Cortedelda1Click(Sender: TObject);
    procedure Salta(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure txtDiaChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure txtAnioExit(Sender: TObject);
    procedure txtDiaExit(Sender: TObject);
    procedure Rellena(Sender: TObject);
    procedure CorteDaAnterior1Click(Sender: TObject);
    procedure Respaldar1Click(Sender: TObject);
  private
    sArchCorte : String;
    
    procedure RecuperaConfig;
    procedure RecuperaCortes;
    function VerificaFechas(sFecha : string):boolean;
  public
    sUsuario : string;
    iUsuario, iCaja : integer;
  end;

var
  frmCorte: TfrmCorte;

implementation

uses dm, Autoriza;

{$R *.xfm}

procedure TfrmCorte.FormShow(Sender: TObject);
begin
    Height := 110;
    grpReimpresion.Enabled := false;

    txtDia.Enabled := false;
    txtMes.Enabled := false;
    txtAnio.Enabled := false;
    txtDia.Text := FormatDateTime('dd',Date);
    txtMes.Text := FormatDateTime('mm',Date);
    txtAnio.Text := FormatDateTime('yyyy',Date);
    txtUsuario.Text := sUsuario;

    grdCortes.ColWidths[0] := 40;
    grdCortes.ColWidths[1] := 60;
    grdCortes.ColWidths[2] := 200;
    txtCaja.Value := iCaja;
end;

procedure TfrmCorte.RecuperaConfig;
var
    iniArchivo : TIniFile;
    sIzq, sArriba, sValor : String;
    sDirReportes : String;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'config.ini');

    with iniArchivo do begin
        //Recupera la posición Y de la ventana
        sArriba := ReadString('Corte', 'Posy', '');

        //Recupera la posición X de la ventana
        sIzq := ReadString('Corte', 'Posx', '');

        if (Length(sIzq) > 0) and (Length(sArriba) > 0) then begin
            Left := StrToInt(sIzq);
            Top := StrToInt(sArriba);
        end;

        //Recupera el número de caja
        sValor := ReadString('Config', 'Caja', '');
        if (Length(sValor) > 0) then
            iCaja := StrToInt(sValor);

        sDirReportes := iniArchivo.ReadString('Reportes', 'DirReportes', '');

        if not (Length(sDirReportes) > 0) then
           sDirReportes:= ExtractFilePath(Application.ExeName)+'Reportes\';

        //Recupera el nombre del archivo del reporte
        sValor := ReadString('Reportes', 'Corte', '');
        if (Length(sValor) > 0) then
            sArchCorte := sDirReportes + sValor;

        Free;
    end;
end;

procedure TfrmCorte.FormClose(Sender: TObject; var Action: TCloseAction);
var
    iniArchivo : TIniFile;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'config.ini');
    with iniArchivo do begin
        // Registra la posición y de la ventana
        WriteString('Corte', 'Posy', IntToStr(Top));

        // Registra la posición X de la ventana
        WriteString('Corte', 'Posx', IntToStr(Left));

        Free;
    end;
end;

procedure TfrmCorte.btnAceptarClick(Sender: TObject);
var
    bCorteParcial : boolean;
    sHoraIni, sHoraFin, sFecha : String;
begin
    sFecha := txtMes.Text + '/' + txtDia.Text + '/' + txtAnio.Text;
    if(VerificaFechas(txtDia.Text + '/' + txtMes.Text + '/' + txtAnio.Text)) then begin
        if(FileExists(sArchCorte)) then begin
            bCorteParcial := false;
            // Si se presionó un boton ya sea el de corte parcial o el de reimpresión
            if(Sender is TButton) then begin
                // Si se presionó el botón Reimpresión
                if( (Sender as TButton).Name = 'btnReimprimir') then begin
                    sHoraFin := grdCortes.Cells[1,grdCortes.Row];
                    if(grdCortes.Row = 1) then
                        sHoraIni := '00:00:00'
                    else
                        sHoraIni := grdCortes.Cells[1,grdCortes.Row-1];
                end
                else begin
                    // Se presionó el botón aceptar
                    bCorteParcial := true;
                    with dmDatos.qryConsulta do begin
                        Close;
                        SQL.Clear;
                        SQL.Add('SELECT MAX(hora) AS hora FROM cortes WHERE caja = ' + IntToStr(iCaja));
                        SQL.Add('AND fecha = ''' + sFecha + '''');
                        Open;
                        if(Length(FieldByName('hora').AsString) > 0) then
                            sHoraIni := FormatDateTime('hh:nn:ss',FieldByName('hora').AsDateTime)
                        else
                            sHoraIni := '00:00:00';
                        sHoraFin := FormatDateTime('hh:nn:ss',Now);
                        Close;
                    end;
                end;
            end
            else begin
                //Corte del día
                sHoraIni := '00:00:00';
                sHorafin := '23:59:59';
            end;

            // Si no se seleccionó la opción corte del día
            if bCorteParcial then begin
                with dmDatos.qryModifica do begin
                    Close;
                    SQL.Clear;
                    SQL.Add('INSERT INTO cortes (fecha, hora, usuario, caja) VALUES(');
                    SQL.Add('''' + txtMes.Text + '/' + txtDia.Text + '/' + txtAnio.Text + ''',''' + sHoraFin + ''',');
                    SQL.Add(IntToStr(iUsuario) + ',' + IntToStr(iCaja) + ')');
                    ExecSQL;
                    Close;
                end;
            end;

            rptCorte.FileName:= sArchCorte;
            rptCorte.Report.DatabaseInfo.Items[0].SQLConnection := dmDatos.sqlBase.DataSets[0].SQLConnection;
            rptCorte.Report.Params.ParamByName('caja').Value:= IntToStr(iCaja);
            rptCorte.Report.Params.ParamByName('usuario').Value:= sUsuario;
            rptCorte.Report.Params.ParamByName('fecha').Value:= sFecha;
            rptCorte.Report.Params.ParamByName('HoraIni').Value:= sHoraIni;
            rptCorte.Report.Params.ParamByName('HoraFin').Value:= sHorafin;
            rptCorte.Execute;

        end
        else begin
            Application.MessageBox('No existe el archivo de reporte del corte','Error',[smbOK],smsCritical);
            btnAceptar.SetFocus;
        end;
    end
    else begin
        Application.MessageBox('Introduce una fecha válida','Error',[smbOK],smsCritical);
        txtDia.SetFocus;
    end;
end;

procedure TfrmCorte.btnReimprimirClick(Sender: TObject);
begin
    if(Length(grdCortes.Cells[0,1]) > 0) then
        btnAceptarClick(Sender);
end;

procedure TfrmCorte.btnEliminarClick(Sender: TObject);
begin
    if(Length(grdCortes.Cells[0,grdCortes.Row]) > 0) then
        if(Application.MessageBox('Se eliminará el corte seleccionado','Eliminar',[smbOK,smbCancel],smsCritical) = smbOK) then
            with dmDatos.qryModifica do begin
                Close;
                SQL.Clear;
                SQL.Add('DELETE FROM cortes WHERE caja = ' + grdCortes.Cells[0,grdCortes.Row]);
                SQL.Add('AND fecha = ''' + txtMes.Text + '/' + txtDia.Text + '/' + txtAnio.Text + '''');
                SQL.Add('AND hora = ''' + grdCortes.Cells[1,grdCortes.Row] + '''');
                ExecSQL;
                Close;
                RecuperaCortes;
            end;
end;

procedure TfrmCorte.RecuperaCortes;
var
    i : integer;
begin
    grdCortes.RowCount := 2;
    grdCortes.Cells[0,0] := 'Caja';
    grdCortes.Cells[1,0] := 'Hora';
    grdCortes.Cells[2,0] := 'Usuario';
    grdCortes.Cells[0,1] := '';
    grdCortes.Cells[1,1] := '';
    grdCortes.Cells[2,1] := '';
    if(VerificaFechas(txtDia.Text + '/' + txtMes.Text + '/' + txtAnio.Text)) then begin
        with dmDatos.qryModifica do begin
            Close;
            SQL.Clear;
            SQL.Add('SELECT c.*, u.nombre FROM cortes c LEFT JOIN usuarios u ON c.usuario = u.clave');
            SQL.Add('WHERE c.fecha = ''' + txtMes.Text + '/' + txtDia.Text + '/' + txtAnio.Text + '''');
            SQL.Add('ORDER BY c.fecha');
            Open;
            i := 0;
            while (not Eof) do begin
                Inc(i);
                grdCortes.RowCount := i + 1;
                grdCortes.Cells[0,i] := FieldByName('caja').AsString;
                grdCortes.Cells[1,i] := FormatDateTime('hh:mm:ss',FieldByName('hora').AsDateTime);
                grdCortes.Cells[2,i] := Trim(FieldByName('nombre').AsString);
                Next;
            end;
            Close;
        end;
    end;
end;

procedure TfrmCorte.Reimpresin1Click(Sender: TObject);
begin
    with TfrmAutoriza.Create(Self) do
    try
        sMensaje := '(Caja ' + IntToStr(iCaja) + ')';
        sTipoAutoriza := 'C02';
        ShowModal;
        if(bAutorizacion) then begin
            txtDia.Enabled := true;
            txtMes.Enabled := true;
            txtAnio.Enabled := true;
            grpReimpresion.Enabled := true;
            Self.Height := 267;
            RecuperaCortes;
        end;
    finally
        Free;
    end;
    SetFocus;
end;

function TfrmCorte.VerificaFechas(sFecha : string):boolean;
var
   dteFecha : TDateTime;
begin
   Result:=true;
   if(not TryStrToDate(sFecha,dteFecha)) then begin
      Result:=false;
   end;
end;

procedure TfrmCorte.Cortedelda1Click(Sender: TObject);
begin
    with TfrmAutoriza.Create(Self) do
    try
        sMensaje := '(Caja ' + IntToStr(iCaja) + ')';
        sTipoAutoriza := 'C01';
        ShowModal;
        if(bAutorizacion) then
             Self.btnAceptarClick(Sender);
    finally
        Free;
    end;
    SetFocus;
end;

procedure TfrmCorte.Salta(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    {Inicio (36), Fin (35), Izquierda (37), derecha (39), arriba (38), abajo (40)}
    if(Key >= 30) and (Key <= 122) and (Key <> 35) and (Key <> 36) and not ((Key >= 37) and (Key <= 40)) then
        if( Length((Sender as TEdit).Text) = (Sender as TEdit).MaxLength) then
            SelectNext(Sender as TWidgetControl, true, true);
end;

procedure TfrmCorte.txtDiaChange(Sender: TObject);
begin
    RecuperaCortes;
end;

procedure TfrmCorte.FormCreate(Sender: TObject);
begin
    RecuperaConfig;
end;

procedure TfrmCorte.txtAnioExit(Sender: TObject);
begin
    txtAnio.Text := Trim(txtAnio.Text);
    if(Length(txtAnio.Text) < 4) and (Length(txtAnio.Text) > 0) then
        txtAnio.Text := IntToStr(StrToInt(txtAnio.Text) + 2000);
end;

procedure TfrmCorte.txtDiaExit(Sender: TObject);
begin
    Rellena(Sender);
end;
procedure TfrmCorte.Rellena(Sender: TObject);
var
    i : integer;
begin
    for i := Length((Sender as TEdit).Text) to (Sender as TEdit).MaxLength - 1 do
        (Sender as TEdit).Text := '0' + (Sender as TEdit).Text;
end;
procedure TfrmCorte.CorteDaAnterior1Click(Sender: TObject);
begin
 with TfrmAutoriza.Create(Self) do
    try
        sMensaje := '(Caja ' + IntToStr(iCaja) + ')';
        sTipoAutoriza := 'C02';
        ShowModal;
        if(bAutorizacion) then begin
            txtDia.Enabled := true;
            txtMes.Enabled := true;
            txtAnio.Enabled := true;
        //    grpReimpresion.Enabled := true;
        //    Self.Height := 267;
        //    RecuperaCortes;
        end;
    finally
        Free;
    end;
    SetFocus;

end;

procedure TfrmCorte.Respaldar1Click(Sender: TObject);
var
 FOrigen : string;
  servidor , FDestino : string;
   iniArchivo : TIniFile;


begin
iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) +'config.ini');
   servidor := iniArchivo.ReadString('BaseDato', 'Servidor', '');
if (servidor <> 'localhost')then begin
  FOrigen := '\\'+servidor+'\Base\Ventas.gdb';
 FDestino := 'C:\Ventas\Respaldos\Ventas_'+FormatDateTime('dd-mm-yyyy', date)+'.gdb';
 CopyFile(PChar(FOrigen), PChar(FDestino), false);
 ShowMessage('Archivo Respaldado');
end
else
begin
   FOrigen := 'C:\Ventas\Base\Ventas.gdb';
      FDestino := 'C:\Ventas\Respaldos\Ventas_'+FormatDateTime('dd-mm-yyyy', date)+'.gdb';
 CopyFile(PChar(FOrigen), PChar(FDestino), false);
  ShowMessage('Archivo Respaldado');
end;



end;

end.
