// --------------------------------------------------------------------------
// Archivo del Proyecto Ventas
// Página del proyecto: http://sourceforge.net/projects/ventas
// --------------------------------------------------------------------------
// Este archivo puede ser distribuido y/o modificado bajo lo terminos de la
// Licencia Pública General versión 2 como es publicada por la Free Software
// Fundation, Inc.
// --------------------------------------------------------------------------

unit InventImporta;

interface

uses
  SysUtils, Types, Classes, Variants, QTypes, QGraphics, QControls, QForms, 
  QDialogs, QStdCtrls, QButtons;

type
  TfrmInventImporta = class(TForm)
    grpImporta: TGroupBox;
    btnImportar: TBitBtn;
    btnCancelar: TBitBtn;
    dlgAbrir: TOpenDialog;
    Label1: TLabel;
    txtRuta: TEdit;
    btnDir: TBitBtn;
    procedure btnDirClick(Sender: TObject);
    procedure btnImportarClick(Sender: TObject);
  private
    { Private declarations }
  public
    sInventario : String;
  end;

var
  frmInventImporta: TfrmInventImporta;

implementation

uses dm;

{$R *.xfm}

procedure TfrmInventImporta.btnDirClick(Sender: TObject);
begin
    dlgAbrir.InitialDir := ExtractFilePath(txtRuta.Text);
    if(dlgAbrir.Execute) then
        txtRuta.Text := dlgAbrir.FileName;
end;

procedure TfrmInventImporta.btnImportarClick(Sender: TObject);
var
    txfArchivo : TextFile;
    sSeparador, sLinea, sCodigo, sCantidad, sArticulo, sExistencia : String;
    sJuego, sTipo, sArtJuego, sCantJuego : String;
    iTamLinea, iPos : integer;
    rCantJuego : real;
begin
    sSeparador := ',';

    AssignFile(txfArchivo, txtRuta.Text);
    Reset(txfArchivo);
    while(not Eof(txfArchivo)) do begin
        Readln(txfArchivo, sLinea);
        iPos := Pos(sSeparador, sLinea);
        iTamLinea := Length(sLinea); 
        if(iPos > 0) and (iPos < iTamLinea) then begin
            sCodigo := Copy(sLinea, 1, iPos-1);
            sCantidad := Copy(sLinea, iPos+1, iTamLinea - iPos);
            with dmDatos.qryModifica do begin
                Close;
                SQL.Clear;
                SQL.Add('SELECT a.clave, a.tipo, i.cantidad, i.cantjuego, a.existencia FROM articulos a LEFT JOIN inventdet i ON ');
                SQL.Add('a.clave = i.articulo AND i.inventario = ' + sInventario);
                SQL.Add('WHERE a.clave IN (SELECT articulo FROM codigos WHERE codigo = ''' + sCodigo + ''')');
                Open;
                // Si existe el articulo
                if(not Eof) then begin
                    sArticulo := FieldByName('clave').AsString;
                    sTipo := FieldByName('tipo').AsString;
                    sExistencia := FieldByName('existencia').AsString;
                    if(sTipo = '1') then
                        sJuego := 'S'
                    else
                        sJuego := 'N';
                    if(FieldByName('cantidad').IsNull) then begin
                        // Si no existe en la tabla inventdet
                        Close;
                        SQL.Clear;
                        SQL.Add('INSERT INTO inventdet (inventario, existencia, articulo,');
                        SQL.Add('cantidad, cantJuego, juego) VALUES(' + sInventario + ',');
                        SQL.Add(sExistencia + ',' + sArticulo + ',');
                        SQL.Add(sCantidad + ',0,''' + sJuego + ''')');
                        ExecSQL;
                    end
                    else begin
                        // Si ya existe en la tabla inventdet
                        Close;
                        SQL.Clear;
                        SQL.Add('UPDATE inventdet SET cantidad = cantidad + ' + sCantidad);
                        SQL.Add('WHERE articulo = ' + sArticulo + ' AND inventario = ' + sInventario);
                        ExecSQL;
                    end;
                    Close;

                    // Si es juego y la cantidad anterior es diferente de la nueva
                    if(sJuego = 'S') then begin
                        rCantJuego := StrToFloat(sCantidad);
                        Close;
                        SQL.Clear;
                        SQL.Add('SELECT articulo, cantidad FROM juegos WHERE clave = ' + sArticulo);
                        Open;
                        while(not Eof) do begin
                            sArtJuego := FieldByName('articulo').AsString;
                            sCantJuego := FloatToStr(rCantJuego * FieldByName('cantidad').AsFloat);
                            dmDatos.qryAuxiliar1.Close;
                            dmDatos.qryAuxiliar1.SQL.Clear;
                            dmDatos.qryAuxiliar1.SQL.Add('SELECT * FROM inventdet WHERE articulo = ' + sArtJuego + ' AND inventario = ' + sInventario);
                            dmDatos.qryAuxiliar1.Open;

                            if(dmDatos.qryAuxiliar1.Eof) then begin
                                dmDatos.qryAuxiliar1.Close;
                                dmDatos.qryAuxiliar1.SQL.Clear;
                                dmDatos.qryAuxiliar1.SQL.Add('INSERT INTO inventdet (inventario, existencia, articulo,');
                                dmDatos.qryAuxiliar1.SQL.Add('cantidad, cantJuego, juego) VALUES(' + sInventario + ',');
                                dmDatos.qryAuxiliar1.SQL.Add(sExistencia + ',' + sArtJuego + ',');
                                dmDatos.qryAuxiliar1.SQL.Add('0,' + sCantJuego + ',''N'')');
                                dmDatos.qryAuxiliar1.ExecSQL;
                                dmDatos.qryAuxiliar1.Close;
                            end
                            else begin
                                dmDatos.qryAuxiliar1.Close;
                                dmDatos.qryAuxiliar1.SQL.Clear;
                                dmDatos.qryAuxiliar1.SQL.Add('UPDATE inventdet SET cantjuego = cantjuego + ' + sCantJuego);
                                dmDatos.qryAuxiliar1.SQL.Add('WHERE articulo = ' + sArtJuego + ' AND inventario = ' + sInventario);
                                dmDatos.qryAuxiliar1.ExecSQL;
                                dmDatos.qryAuxiliar1.Close;
                            end;
                            Next;
                        end;
                    end;
                end;
                Close;
            end;
        end;
    end;
    CloseFile(txfArchivo);    
end;

end.
