// --------------------------------------------------------------------------
// Archivo del Proyecto Ventas 
// Página del proyecto: http://sourceforge.net/projects/ventas
// --------------------------------------------------------------------------
// Este archivo puede ser distribuido y/o modificado bajo lo terminos de la
// Licencia Pública General versión 2 como es publicada por la Free Software
// Fundation, Inc.
// --------------------------------------------------------------------------

unit dm;

interface

uses
  SysUtils, Classes, DBXpress, DB, SqlExpr, Provider, DBClient, FMTBcd;

type
  TdmDatos = class(TDataModule)
    sqlBase: TSQLConnection;
    dspProvList: TDataSetProvider;
    cdsCliente: TClientDataSet;
    dtsFuente: TDataSource;
    dspProvList1: TDataSetProvider;
    cdsCliente1: TClientDataSet;
    dtsFuente1: TDataSource;
    qryModifica: TSQLQuery;
    qryAuxiliar1: TSQLQuery;
    dtsArticulos: TDataSetProvider;
    cdsArticulos: TClientDataSet;
    dscArticulos: TDataSource;
    qryAuxiliar2: TSQLQuery;
    cdsImExportar: TClientDataSet;
    dtsImExportar: TDataSetProvider;
    qryConsulta: TSQLQuery;
    qryArticulos: TSQLQuery;
    qryImExportar: TSQLQuery;
    qryListados: TSQLQuery;
    qryListados1: TSQLQuery;
    qryAuxiliar3: TSQLQuery;
  private
  public
    function ConectaInter(sServer, sDatabase, sUser, sPass: String):boolean;
    procedure DesconectaInter;
  end;

var
  dmDatos: TdmDatos;

implementation

{$R *.xfm}

// ------------------------------------------------------------------
// Funcion: ConectaInter
// Objetivo: Conectar a la base de datos con los parametros recibidos
// Parámetros: sServer: el nombre o dirección IP del servidor
//             sDatabase: la ruta y nombre de la base de datos
//             sUser: el nombre del usuario para la base de datos
//             sPass: la contraseña del usuario para la base de datos
// Regresa: bRegreso (falso o verdadero)
//          falso: si no se conectó a la base de datos
//          verdadero: si se conectó a la base de datos
// ------------------------------------------------------------------
function TdmDatos.ConectaInter(sServer, sDatabase, sUser, sPass: String):boolean;
var
    bRegreso : boolean;
begin
    bRegreso := true;

    sqlBase.Connected := false;
    sqlBase.Params.Clear;
    {$IFDEF LINUX}
        sqlBase.Params.Values['GetDriverFunc'] := 'getSQLDriverINTERBASE';
        sqlBase.Params.Values['LibraryName'] := 'libsqlib.so';
        sqlBase.Params.Values['VendorLib'] := 'libgds.so.0';
    {$ENDIF}
   sqlBase.DriverName := 'Interbase';
   sqlBase.ConnectionName := 'Ventas';
   sqlBase.Params.Values['Database'] := sServer + ':' + sDatabase;
   sqlBase.Params.Values['User_Name'] := sUser;
   sqlBase.Params.Values['Password'] := sPass;
   sqlBase.Params.Values['SQLDialect'] := '3';
   sqlBase.Params.Values['Protocol'] := 'TCP/IP';
   sqlBase.Params.Values['BlobSize'] := '-1';
   sqlBase.Params.Values['CommitRetain'] := 'False';
   sqlBase.Params.Values['Interbase TransIsolation'] := 'ReadCommited';
   sqlBase.Params.Values['WaitOnLocks'] := 'True';
   sqlBase.Params.Values['EnableBCD'] := '0';


    try
        sqlBase.Connected := true;
    except
        bRegreso := false;
    end;
    Result := bRegreso;
end;

procedure TdmDatos.DesconectaInter;
begin
    sqlBase.Connected := false;
end;

end.
