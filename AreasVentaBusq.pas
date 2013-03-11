// --------------------------------------------------------------------------
// Archivo del Proyecto Ventas 
// Página del proyecto: http://sourceforge.net/projects/ventas
// --------------------------------------------------------------------------
// Este archivo puede ser distribuido y/o modificado bajo lo terminos de la
// Licencia Pública General versión 2 como es publicada por la Free Software
// Fundation, Inc.
// --------------------------------------------------------------------------

unit AreasVentaBusq;

interface

uses
  SysUtils, Types, Classes, QGraphics, QControls, QForms, QDialogs,
  QStdCtrls, QGrids, QDBGrids, QButtons, DB, IniFiles;

type
  TfrmAreasVentaBusq = class(TForm)
    btnAceptar: TBitBtn;
    btnCancelar: TBitBtn;
    grdListado: TDBGrid;
    procedure FormShow(Sender: TObject);
    procedure btnAceptarClick(Sender: TObject);
    procedure grdListadoDblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure RecuperaConfig;
    procedure FormCreate(Sender: TObject);
  private
  public
    sClave : String;
    iCaja : Integer;
  end;

var
  frmAreasVentaBusq: TfrmAreasVentaBusq;

implementation

uses dm;

{$R *.xfm}

procedure TfrmAreasVentaBusq.FormShow(Sender: TObject);
begin
    with dmDatos.qryListados1 do begin
        dmDatos.cdsCliente1.Close;
        Close;
        SQL.Clear;
        SQL.Add('SELECT a.clave, a.nombre, CAST(SUM(v.cantidad*v.precio*(1-v.descotorg/100)) AS numeric(12,2)) AS importe FROM areasventa a LEFT JOIN ventasareas v ON a.clave = v.areaventa');
        SQL.Add('WHERE a.caja = ' + IntToStr(iCaja) + ' OR a.caja IS null GROUP BY a.clave, a.nombre ORDER BY nombre');
        Open;
        dmDatos.cdsCliente1.Active := true;
        dmDatos.cdsCliente1.FieldByName('clave').Visible := false;
        (dmDatos.cdsCliente1.FieldByName('importe') as TNumericField).DisplayFormat := '#,##0.00';
        dmDatos.cdsCliente1.FieldByName('nombre').DisplayLabel := 'ÁREA';
        dmDatos.cdsCliente1.FieldByName('importe').DisplayLabel := 'IMPORTE';
        dmDatos.cdsCliente1.FieldByName('nombre').DisplayWidth := 14;
        dmDatos.cdsCliente1.FieldByName('importe').DisplayWidth := 12;
        dmDatos.cdsCliente1.Locate('clave',sClave,[]);
        grdListado.SetFocus;
    end;
end;

procedure TfrmAreasVentaBusq.btnAceptarClick(Sender: TObject);
begin
    sClave := Trim(dmDatos.cdsCliente1.FieldByName('clave').AsString);
end;

procedure TfrmAreasVentaBusq.grdListadoDblClick(Sender: TObject);
begin
    btnAceptar.Click;
end;

procedure TfrmAreasVentaBusq.FormClose(Sender: TObject; var Action: TCloseAction);
var
    iniArchivo : TIniFile;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'config.ini');
    with iniArchivo do begin
        // Registra la posición y de la ventana
        WriteString('Areasbusq', 'Posy', IntToStr(Top));

        // Registra la posición X de la ventana
        WriteString('Areasbusq', 'Posx', IntToStr(Left));

        // Registra la posición en el listado
        WriteString('Areasbusq', 'BookMark', IntToStr(dmDatos.cdsCliente1.Recno));

        Free;
    end;
    dmDatos.qryListados1.Close;
    dmDatos.cdsCliente1.Active := false;
end;

procedure TfrmAreasVentaBusq.RecuperaConfig;
var
    iniArchivo : TIniFile;
    sIzq, sArriba : String;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'config.ini');

    with iniArchivo do begin
        //Recupera la posición Y de la ventana
        sArriba := ReadString('Areasbusq', 'Posy', '');

        //Recupera la posición X de la ventana
        sIzq := ReadString('Areasbusq', 'Posx', '');

        if (Length(sIzq) > 0) and (Length(sArriba) > 0) then begin
            Left := StrToInt(sIzq);
            Top := StrToInt(sArriba);
        end;

        Free;
    end;
end;

procedure TfrmAreasVentaBusq.FormCreate(Sender: TObject);
begin
    RecuperaConfig;
end;

end.
