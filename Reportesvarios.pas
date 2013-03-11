// --------------------------------------------------------------------------
// Archivo del Proyecto Ventas 
// Página del proyecto: http://sourceforge.net/projects/ventas
// --------------------------------------------------------------------------
// Este archivo puede ser distribuido y/o modificado bajo lo terminos de la
// Licencia Pública General versión 2 como es publicada por la Free Software
// Fundation, Inc.
// --------------------------------------------------------------------------

unit Reportesvarios;

interface

uses
  SysUtils, Types, Classes, QGraphics, QControls, QForms, QDialogs,
  QStdCtrls, rpcompobase, rpclxreport, IniFiles;

type
  TfrmReportesVarios = class(TForm)
    rptReportes: TCLXReport;
  private

  public
    procedure ImprimeCateg;
    procedure ImprimeUnidades;
    procedure ImprimeDeptos;
    procedure ImprimeClientes;
    procedure ImprimeProveedores;
    procedure ImprimeArticulos;
    procedure ImprimeCompFiscal(sFecha : String);
    procedure ImprimeOperaciones(sFecha : String);
    procedure ImprimeTicketsDelDia(sFecha : String);
    procedure ImprimeRetirosGeneral(sFecha : String);
    procedure ImprimeAjuste;
    procedure ImprimePedidos;
    procedure ImprimeExistencias;
    procedure ImprimeConteo(sInventario, sCampo, sOrden: String);
    procedure ImprimeValorInvent(sInventario, sCampo, sOrden: String);
    procedure ImprimeCFDIS(sFecha,sfecha2 : String);
  end;

var
  frmReportesVarios: TfrmReportesVarios;

implementation

uses dm, Reimprimir;

{$R *.xfm}

procedure TfrmReportesVarios.ImprimeCateg;
var
    iniArchivo : TIniFile;
    sArchivo : String;
    sDirReportes : String;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) +'config.ini');

    sDirReportes := iniArchivo.ReadString('Reportes', 'DirReportes', '');

    if not (Length(sDirReportes) > 0) then
       sDirReportes:= ExtractFilePath(Application.ExeName)+'Reportes\';

    sArchivo := iniArchivo.ReadString('Reportes', 'Categorias', '');
    if (Length(sArchivo) > 0) then begin
        rptReportes.FileName := sDirReportes + sArchivo;
        rptReportes.Report.DatabaseInfo.Items[0].SQLConnection := dmDatos.sqlBase.DataSets[0].SQLConnection;
        rptReportes.Execute;
    end
    else
        Application.MessageBox('El archivo ' + sArchivo + ' no existe','Error',[smbOK],smsCritical);
end;

procedure TfrmReportesVarios.ImprimeUnidades;
var
    iniArchivo : TIniFile;
    sArchivo : String;
    sDirReportes : String;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) +'config.ini');

    sDirReportes := iniArchivo.ReadString('Reportes', 'DirReportes', '');

    if not (Length(sDirReportes) > 0) then
       sDirReportes:= ExtractFilePath(Application.ExeName)+'Reportes\';

    sArchivo := iniArchivo.ReadString('Reportes', 'Unidades', '');
    if (Length(sArchivo) > 0) then begin
        rptReportes.FileName := sDirReportes + sArchivo;
        rptReportes.Report.DatabaseInfo.Items[0].SQLConnection := dmDatos.sqlBase.DataSets[0].SQLConnection;
        rptReportes.Execute;
    end
    else
        Application.MessageBox('El archivo ' + sArchivo + ' no existe','Error',[smbOK],smsCritical);
end;

procedure TfrmReportesVarios.ImprimeDeptos;
var
    iniArchivo : TIniFile;
    sArchivo : String;
    sDirReportes : String;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) +'config.ini');

    sDirReportes := iniArchivo.ReadString('Reportes', 'DirReportes', '');

    if not (Length(sDirReportes) > 0) then
       sDirReportes:= ExtractFilePath(Application.ExeName)+'Reportes\';

    sArchivo := iniArchivo.ReadString('Reportes', 'Departamentos', '');
    if (Length(sArchivo) > 0) then begin
        rptReportes.FileName := sDirReportes + sArchivo;
        rptReportes.Report.DatabaseInfo.Items[0].SQLConnection := dmDatos.sqlBase.DataSets[0].SQLConnection;
        rptReportes.Execute;
    end
    else
        Application.MessageBox('El archivo ' + sArchivo + ' no existe','Error',[smbOK],smsCritical);
end;

procedure TfrmReportesVarios.ImprimeClientes;
var
    iniArchivo : TIniFile;
    sArchivo : String;
    sDirReportes : String;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) +'config.ini');

    sDirReportes := iniArchivo.ReadString('Reportes', 'DirReportes', '');

    if not (Length(sDirReportes) > 0) then
       sDirReportes:= ExtractFilePath(Application.ExeName)+'Reportes\';

    sArchivo := iniArchivo.ReadString('Reportes', 'Clientes', '');
    if (Length(sArchivo) > 0) then begin
        rptReportes.FileName := sDirReportes + sArchivo;
        rptReportes.Report.DatabaseInfo.Items[0].SQLConnection := dmDatos.sqlBase.DataSets[0].SQLConnection;
        rptReportes.Execute;
    end
    else
        Application.MessageBox('El archivo ' + sArchivo + ' no existe','Error',[smbOK],smsCritical);
end;

procedure TfrmReportesVarios.ImprimeProveedores;
var
    iniArchivo : TIniFile;
    sArchivo : String;
    sDirReportes : String;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) +'config.ini');

    sDirReportes := iniArchivo.ReadString('Reportes', 'DirReportes', '');

    if not (Length(sDirReportes) > 0) then
       sDirReportes:= ExtractFilePath(Application.ExeName)+'Reportes\';

    sArchivo := iniArchivo.ReadString('Reportes', 'Proveedores', '');
    if (Length(sArchivo) > 0) then begin
        rptReportes.FileName := sDirReportes + sArchivo;
        rptReportes.Report.DatabaseInfo.Items[0].SQLConnection := dmDatos.sqlBase.DataSets[0].SQLConnection;
        rptReportes.Execute;
    end
    else
        Application.MessageBox('El archivo ' + sArchivo + ' no existe','Error',[smbOK],smsCritical);
end;

procedure TfrmReportesVarios.ImprimeArticulos;
var
    iniArchivo : TIniFile;
    sArchivo : String;
    sDirReportes : String;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) +'config.ini');

    sDirReportes := iniArchivo.ReadString('Reportes', 'DirReportes', '');

    if not (Length(sDirReportes) > 0) then
       sDirReportes:= ExtractFilePath(Application.ExeName)+'Reportes\';

    sArchivo := iniArchivo.ReadString('Reportes', 'Articulos', '');
    if (Length(sArchivo) > 0) then begin
        rptReportes.FileName := sDirReportes + sArchivo;
        rptReportes.Report.DatabaseInfo.Items[0].SQLConnection := dmDatos.sqlBase.DataSets[0].SQLConnection;
        rptReportes.Execute;
    end
    else
        Application.MessageBox('El archivo ' + sArchivo + ' no existe','Error',[smbOK],smsCritical);
end;

procedure TfrmReportesVarios.ImprimeCompFiscal(sFecha : String);
var
    iniArchivo : TIniFile;
    sArchivo : String;
    sDirReportes : String;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) +'config.ini');

    sDirReportes := iniArchivo.ReadString('Reportes', 'DirReportes', '');

    if not (Length(sDirReportes) > 0) then
       sDirReportes:= ExtractFilePath(Application.ExeName)+'Reportes\';

    sArchivo := iniArchivo.ReadString('Reportes', 'CompFiscal', '');
    if (Length(sArchivo) > 0) then begin
        rptReportes.FileName := sDirReportes + sArchivo;
        rptReportes.Report.Params.ParamByName('Fecha').Value:= sFecha;
        rptReportes.Report.DatabaseInfo.Items[0].SQLConnection := dmDatos.sqlBase.DataSets[0].SQLConnection;
        rptReportes.Execute;
    end
    else
        Application.MessageBox('El archivo ' + sArchivo + ' no existe','Error',[smbOK],smsCritical);
end;

procedure TfrmReportesVarios.ImprimeOperaciones(sFecha : String);
var
    iniArchivo : TIniFile;
    sArchivo : String;
    sDirReportes : String;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'config.ini');

    sDirReportes := iniArchivo.ReadString('Reportes', 'DirReportes', '');

    if not (Length(sDirReportes) > 0) then
       sDirReportes:= ExtractFilePath(Application.ExeName)+'Reportes\';

    sArchivo := iniArchivo.ReadString('Reportes', 'Operaciones', '');
    if (Length(sArchivo) > 0) then begin
        rptReportes.FileName := sDirReportes + sArchivo;
        rptReportes.Report.Params.ParamByName('Fecha').Value:= sFecha;
        rptReportes.Report.DatabaseInfo.Items[0].SQLConnection := dmDatos.sqlBase.DataSets[0].SQLConnection;
        rptReportes.Execute;
    end
    else
        Application.MessageBox('El archivo ' + sArchivo + ' no existe','Error',[smbOK],smsCritical);
end;

procedure TfrmReportesVarios.ImprimeTicketsDelDia(sFecha : String);
var
iniArchivo : TIniFile;
    sArchivo : String;
    sDirReportes : String;

begin
       iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'config.ini');

    sDirReportes := iniArchivo.ReadString('Reportes', 'DirReportes', '');

    if not (Length(sDirReportes) > 0) then
       sDirReportes:= ExtractFilePath(Application.ExeName)+'Reportes\';

    sArchivo := iniArchivo.ReadString('Reportes', 'ticketsdia', '');
    if (Length(sArchivo) > 0) then begin
        rptReportes.FileName := sDirReportes + sArchivo;
        rptReportes.Report.Params.ParamByName('Fecha').Value:= sFecha;
        rptReportes.Report.DatabaseInfo.Items[0].SQLConnection := dmDatos.sqlBase.DataSets[0].SQLConnection;
        rptReportes.Execute;
    end
    else
        Application.MessageBox('El archivo ' + sArchivo + ' no existe','Error',[smbOK],smsCritical);







 {   with dmDatos.qryAuxiliar1 do
     begin
      Close;
        SQL.Clear;
        SQL.Add('SELECT caja, numero FROM comprobantes WHERE tipo = ''T'' AND fecha = ''' + sFecha + ''' AND estatus = ''A'' ORDER BY caja, numero');
        Open;
        while(not Eof) do
         begin
//            with TfrmReimprimir.Create(Self) do
//            try
                frmReimprimir.ImprimeTicket(FieldByName('caja').AsString, FieldByName('numero').AsString, 'T');
//            finally
//                Free;
//            end;
            Next;
         end;
        Close;
     end;}
end;

procedure TfrmReportesVarios.ImprimeAjuste;
var
    iniArchivo : TIniFile;
    sArchivo : String;
    sDirReportes : String;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) +'config.ini');

    sDirReportes := iniArchivo.ReadString('Reportes', 'DirReportes', '');

    if not (Length(sDirReportes) > 0) then
       sDirReportes:= ExtractFilePath(Application.ExeName)+'Reportes\';

    sArchivo := iniArchivo.ReadString('Reportes', 'InvAjuste', '');
    if (Length(sArchivo) > 0) then begin
        rptReportes.FileName := sDirReportes + sArchivo;
        rptReportes.Report.DatabaseInfo.Items[0].SQLConnection := dmDatos.sqlBase.DataSets[0].SQLConnection;
        rptReportes.Execute;
    end
    else
        Application.MessageBox('El archivo ' + sArchivo + ' no existe','Error',[smbOK],smsCritical);
end;

procedure TfrmReportesVarios.ImprimePedidos;
var
    iniArchivo : TIniFile;
    sArchivo : String;
    sDirReportes : String;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) +'config.ini');

    sDirReportes := iniArchivo.ReadString('Reportes', 'DirReportes', '');

    if not (Length(sDirReportes) > 0) then
       sDirReportes:= ExtractFilePath(Application.ExeName)+'Reportes\';

    sArchivo := iniArchivo.ReadString('Reportes', 'InvPedidos', '');
    if (Length(sArchivo) > 0) then begin
        rptReportes.FileName := sDirReportes + sArchivo;
        rptReportes.Report.DatabaseInfo.Items[0].SQLConnection := dmDatos.sqlBase.DataSets[0].SQLConnection;
        rptReportes.Execute;
    end
    else
        Application.MessageBox('El archivo ' + sArchivo + ' no existe','Error',[smbOK],smsCritical);
end;

procedure TfrmReportesVarios.ImprimeExistencias;
var
    iniArchivo : TIniFile;
    sArchivo : String;
    sDirReportes : String;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) +'config.ini');

    sDirReportes := iniArchivo.ReadString('Reportes', 'DirReportes', '');

    if not (Length(sDirReportes) > 0) then
       sDirReportes:= ExtractFilePath(Application.ExeName)+'Reportes\';

    sArchivo := iniArchivo.ReadString('Reportes', 'InvExistencias', '');
    if (Length(sArchivo) > 0) then begin
        rptReportes.FileName := sDirReportes + sArchivo;
        rptReportes.Report.DatabaseInfo.Items[0].SQLConnection := dmDatos.sqlBase.DataSets[0].SQLConnection;
        rptReportes.Execute;
    end
    else
        Application.MessageBox('El archivo ' + sArchivo + ' no existe','Error',[smbOK],smsCritical);
end;

procedure TfrmReportesVarios.ImprimeConteo(sInventario, sCampo, sOrden: String);
var
    iniArchivo : TIniFile;
    sArchivo : String;
    sDirReportes : String;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) +'config.ini');

    sDirReportes := iniArchivo.ReadString('Reportes', 'DirReportes', '');

    if not (Length(sDirReportes) > 0) then
       sDirReportes:= ExtractFilePath(Application.ExeName)+'Reportes\';

    sArchivo := iniArchivo.ReadString('Reportes', 'InvConteo', '');
    if (Length(sArchivo) > 0) then begin
        rptReportes.FileName := sDirReportes + sArchivo;
        rptReportes.Report.DatabaseInfo.Items[0].SQLConnection := dmDatos.sqlBase.DataSets[0].SQLConnection;
        rptReportes.Report.Params.ParamByName('Clave').Value:= sInventario;
        rptReportes.Report.Params.ParamByName('CampoOrden').Value:= sCampo;
        rptReportes.Report.Params.ParamByName('Orden').Value:= sOrden;
        rptReportes.Execute;
    end
    else
        Application.MessageBox('El archivo ' + sArchivo + ' no existe','Error',[smbOK],smsCritical);
end;

procedure TfrmReportesVarios.ImprimeValorInvent(sInventario, sCampo, sOrden: String);
var
    iniArchivo : TIniFile;
    sArchivo : String;
    sDirReportes : String;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) +'config.ini');

    sDirReportes := iniArchivo.ReadString('Reportes', 'DirReportes', '');

    if not (Length(sDirReportes) > 0) then
       sDirReportes:= ExtractFilePath(Application.ExeName)+'Reportes\';

    if not (Length(sDirReportes) > 0) then
       sDirReportes:= ExtractFilePath(Application.ExeName)+'Reportes\';

    sArchivo := iniArchivo.ReadString('Reportes', 'InvValor', '');
    if (Length(sArchivo) > 0) then begin
        rptReportes.FileName := sDirReportes + sArchivo;
        rptReportes.Report.DatabaseInfo.Items[0].SQLConnection := dmDatos.sqlBase.DataSets[0].SQLConnection;
        rptReportes.Report.Params.ParamByName('Clave').Value:= sInventario;
        rptReportes.Report.Params.ParamByName('CampoOrden').Value:= sCampo;
        rptReportes.Report.Params.ParamByName('Orden').Value:= sOrden;
        rptReportes.Execute;
    end
    else
        Application.MessageBox('El archivo ' + sArchivo + ' no existe','Error',[smbOK],smsCritical);
end;
////Modificacion 22/07/2009
procedure TfrmReportesVarios.ImprimeRetirosGeneral(sFecha : String);
var

iniArchivo : TIniFile;
    sArchivo : String;
    sDirReportes : String;

begin

       sDirReportes:= ExtractFilePath(Application.ExeName)+'Reportes\';

    sArchivo := 'retirosgeneral.rep';
    if (Length(sArchivo) > 0) then begin
        rptReportes.FileName := sDirReportes + sArchivo;
        rptReportes.Report.Params.ParamByName('Fecha').Value:= sFecha;
        rptReportes.Report.DatabaseInfo.Items[0].SQLConnection := dmDatos.sqlBase.DataSets[0].SQLConnection;
        rptReportes.Execute;
    end
    else
        Application.MessageBox('El archivo ' + sArchivo + ' no existe','Error',[smbOK],smsCritical);








end;

procedure TfrmReportesVarios.ImprimeCFDIS(sFecha,sfecha2 : String);
var
    iniArchivo : TIniFile;
    sArchivo : String;
    sDirReportes : String;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'config.ini');

    sDirReportes := iniArchivo.ReadString('Reportes', 'DirReportes', '');

    if not (Length(sDirReportes) > 0) then
       sDirReportes:= ExtractFilePath(Application.ExeName)+'Reportes\';

    sArchivo := 'reportefiscal.rep';
    if (Length(sArchivo) > 0) then begin
        rptReportes.FileName := sDirReportes + sArchivo;
        rptReportes.Report.Params.ParamByName('Fecha').Value:= sFecha;
         rptReportes.Report.Params.ParamByName('Fecha2').Value:= sfecha2;
        rptReportes.Report.DatabaseInfo.Items[0].SQLConnection := dmDatos.sqlBase.DataSets[0].SQLConnection;
        rptReportes.Execute;
    end
    else
        Application.MessageBox('El archivo ' + sArchivo + ' no existe','Error',[smbOK],smsCritical);
end;



end.
