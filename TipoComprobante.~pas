// --------------------------------------------------------------------------
// Archivo del Proyecto Ventas
// Página del proyecto: http://sourceforge.net/projects/ventas
// --------------------------------------------------------------------------
// Este archivo puede ser distribuido y/o modificado bajo lo terminos de la
// Licencia Pública General versión 2 como es publicada por la Free Software
// Fundation, Inc.
// --------------------------------------------------------------------------

unit TipoComprobante;

interface

uses
  SysUtils, Types, Classes, QGraphics, QControls, QForms, QDialogs,
  QStdCtrls, QButtons, QGrids, IniFiles;

type
  TfrmTipoComprobante = class(TForm)
    grpComprobante: TGroupBox;
    btnAceptar: TBitBtn;
    btnCancelar: TBitBtn;
    grdComprobante: TStringGrid;
    procedure btnAceptarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    procedure RecuperaConfig;
  public
    iUsuario : integer;
    sTipo, sComprobante : String;
  end;

var
  frmTipoComprobante: TfrmTipoComprobante;

implementation

uses Autoriza;

{$R *.xfm}

procedure TfrmTipoComprobante.btnAceptarClick(Sender: TObject);
var
    bAutoriza : boolean;
begin
    bAutoriza := true;

    sComprobante := grdComprobante.Cells[0,grdComprobante.Row];
    with TfrmAutoriza.Create(Self) do
    try
        sMensaje := '( ' + sComprobante + ')';
        iUsuario := Self.iUsuario;
        if(sComprobante = 'AJUSTE') then begin
            if(sTipo = 'VENTA') then begin
                if(not VerificaAutoriza(iUsuario,'M01')) then begin
                    sTipoAutoriza := 'M01';
                    ShowModal;
                    bAutoriza := bAutorizacion;
                end;
            end
            else begin
                if(not VerificaAutoriza(iUsuario,'P01')) then begin
                    sTipoAutoriza := 'P01';
                    ShowModal;
                    bAutoriza := bAutorizacion;
                end;
            end
        end
        else if(sComprobante = 'COTIZACION') then begin
            if(not VerificaAutoriza(iUsuario,'M02')) then begin
                sTipoAutoriza := 'M02';
                ShowModal;
                bAutoriza := bAutorizacion;
            end;
        end
        else if(sComprobante = 'DEVOLUCION') then begin
            if(not VerificaAutoriza(iUsuario,'M03')) then begin
                sTipoAutoriza := 'M03';
                ShowModal;
                bAutoriza := bAutorizacion;
            end;
        end
        else if(sComprobante = 'FACTURA') then begin
            if(not VerificaAutoriza(iUsuario,'M04')) then begin
                sTipoAutoriza := 'M04';
                ShowModal;
                bAutoriza := bAutorizacion;
            end;
        end
        else if(sComprobante = 'GASTO') then begin
            if(not VerificaAutoriza(iUsuario,'P02')) then begin
                sTipoAutoriza := 'P02';
                ShowModal;
                bAutoriza := bAutorizacion;
            end;
        end
        else if(sComprobante = 'MERCANCIA') then begin
            if(not VerificaAutoriza(iUsuario,'P03')) then begin
                sTipoAutoriza := 'P03';
                ShowModal;
                bAutoriza := bAutorizacion;
            end;
        end
        else if(sComprobante = 'NOTA') then begin
            if(not VerificaAutoriza(iUsuario,'M05')) then begin
                sTipoAutoriza := 'M05';
                ShowModal;
                bAutoriza := bAutorizacion;
            end;
        end
        else if(sComprobante = 'TICKET') then begin
            if(not VerificaAutoriza(iUsuario,'M06')) then begin
                sTipoAutoriza := 'M06';
                ShowModal;
                bAutoriza := bAutorizacion;
            end;
        end
        else if(sComprobante = 'PEDIDO') then begin
            if(not VerificaAutoriza(iUsuario,'M07')) then begin
                sTipoAutoriza := 'M07';
                ShowModal;
                bAutoriza := bAutorizacion;
            end;
        end;
        grdComprobante.SetFocus;
        if(bAutoriza) then
            Self.ModalResult := mrOK;
    finally
        Free;
    end;
end;

procedure TfrmTipoComprobante.FormShow(Sender: TObject);
begin
    if(sTipo = 'VENTA') then begin
        grdComprobante.RowCount := 7;
        grdComprobante.Cells[0,0] := 'AJUSTE';
        grdComprobante.Cells[0,1] := 'COTIZACION';
        grdComprobante.Cells[0,2] := 'DEVOLUCION';
        grdComprobante.Cells[0,3] := 'FACTURA';
        grdComprobante.Cells[0,4] := 'NOTA';
        grdComprobante.Cells[0,5] := 'PEDIDO';
        grdComprobante.Cells[0,6] := 'TICKET';
    end
    else begin
        grdComprobante.RowCount := 3;
        grdComprobante.Cells[0,0] := 'AJUSTE';
        grdComprobante.Cells[0,1] := 'GASTO';
        grdComprobante.Cells[0,2] := 'MERCANCIA';
    end;

    RecuperaConfig;

    grdComprobante.SetFocus;
end;

procedure TfrmTipoComprobante.RecuperaConfig;
var
    iniArchivo : TIniFile;
    sIzq, sArriba, sValor : String;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) +'config.ini');

    with iniArchivo do begin
        //Recupera la posición Y de la ventana
        sArriba := ReadString('TipoComprobante', 'Posy', '');

        //Recupera la posición X de la ventana
        sIzq := ReadString('TipoComprobante', 'Posx', '');

        if (Length(sIzq) > 0) and (Length(sArriba) > 0) then begin
            Left := StrToInt(sIzq);
            Top := StrToInt(sArriba);
        end;

        //Recupera el comprobante
        sValor := ReadString('TipoComprobante', sTipo, '');
        if (Length(sValor) > 0) then
            grdComprobante.Row := StrToInt(sValor);

        Free;
    end;
end;

procedure TfrmTipoComprobante.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
    iniArchivo : TIniFile;
begin
    iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) +'config.ini');
    with iniArchivo do begin
        // Registra la posición y de la ventana
        WriteString('TipoComprobante', 'Posy', IntToStr(Top));

        // Registra la posición X de la ventana
        WriteString('TipoComprobante', 'Posx', IntToStr(Left));

        // Registra el comprobante seleccionado
        WriteString('TipoComprobante', sTipo, IntToStr(grdComprobante.Row));
        Free;
    end;
end;

end.
