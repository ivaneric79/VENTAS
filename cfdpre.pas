unit cfdpre;

interface

uses
  SysUtils, Types, Classes, Variants, QTypes, QGraphics, QControls, QForms,
  QDialogs, QStdCtrls, QGrids, QcurrEdit, QButtons, xmldom, XMLIntf,
  msxmldom, XMLDoc, ConexionRemota32, IniFiles, rpcompobase, rpclxreport,
  QExtCtrls,ShellApi,pngimage, rppdfreport, IdMessage, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdMessageClient, IdSMTP;

type
  TcfdiFrom = class(TForm)
    artgrid: TStringGrid;
    txtRfc: TEdit;
    txtNombre: TEdit;
    txtContacto: TEdit;
    txtCalle: TEdit;
    nexterior: TEdit;
    ninterior: TEdit;
    txtColonia: TEdit;
    txtLocalidad: TEdit;
    txtCp: TEdit;
    txtCorreoContacto: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Contacto: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    slestado: TComboBox;
    Button1: TButton;
    Button2: TButton;
    total: TcurrEdit;
    Label13: TLabel;
    Button4: TButton;
    iva: TcurrEdit;
    subtotal: TcurrEdit;
    Label14: TLabel;
    Label15: TLabel;
    txtTelContacto: TEdit;
    GroupBox1: TGroupBox;
    BitBtn1: TBitBtn;
    nfac: TEdit;
    cargar: TButton;
    lfac: TLabel;
    ncliente: TEdit;
    xmldoc: TXMLDocument;
    result: TLabel;
    rptComprobante: TCLXReport;
    ncf: TLabel;
    Image1: TImage;
    Memo1: TMemo;
    Image2: TImage;
    IdSMTP1: TIdSMTP;
    IdMessage1: TIdMessage;
    Memo2: TMemo;
    procedure FormShow(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure cargarClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure InicializaNumeros;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

  private
    { Private declarations }
     sUnidades : Array [1..30] of String;
    sDecenas : Array [1..7] of String;
    sCentenas : Array [1..9] of String;
    procedure cargarinfo(v:string);
   procedure recuperacliente(cliente:integer);
   function ConvNumero(rNumero:Real; bPesos :boolean):String;
   procedure guardardatoscfdi();
   procedure enviarfactura(src,pdf, email, num: string);




   procedure recalcular;


  public
    { Public declarations }
    cfdventa,folio: string;
    cfdtotal: real;
    ctotal,civa,csubtotal : real;
    caja:integer;
    client:integer;
    tipopago,referencia:string;
    fuente:boolean;

  end;

var
  cfdiFrom: TcfdiFrom;

implementation

uses dm,Reimprimir,math;

{$R *.xfm}

procedure TcfdiFrom.FormShow(Sender: TObject);
var

comprobante:string;
 iniArchivo : TIniFile;
    sValor : String;


begin
iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'config.ini');
sValor := iniArchivo.ReadString('Config', 'Caja', '');
if (Length(sValor) > 0) then
Caja := StrToInt(sValor);

InicializaNumeros;
artgrid.ColWidths[1]:=70;
artgrid.ColWidths[2]:=80;
artgrid.ColWidths[3]:=350;
artgrid.ColWidths[4]:=80;
artgrid.ColWidths[6]:=0;

    artgrid.Cells[0,0] := 'No.';
    artgrid.Cells[1,0] := 'CANTIDAD';
    artgrid.Cells[2,0] := 'UNIDAD';
    artgrid.Cells[3,0] := 'ARTICULO';
    artgrid.Cells[4,0] := 'PRECIO UNITARIO';
    artgrid.Cells[5,0] := 'IMPORTE';

if (cfdventa <> '') then
begin
txtrfc.Enabled:=false;
txtnombre.Enabled := false;
txtcontacto.Enabled:= false;
txtcalle.Enabled:= false;
nexterior.Enabled := false;
ninterior.Enabled := false;
txtcolonia.Enabled := false;
txtlocalidad.Enabled:= false;
slestado.Enabled:= false;
txtcp.Enabled:= false;
txttelcontacto.Enabled:= false;
txtcorreocontacto.Enabled:= false;
Button1.Enabled:=false;
artgrid.Enabled:=false;
Button2.Enabled:=false;




nfac.Enabled:= false;
cargar.Enabled:= false;
nfac.Visible := false;
cargar.Visible:=false;
lfac.Visible:=false;

cargarinfo(cfdventa);

end
else
begin
txtrfc.Enabled:=false;
txtnombre.Enabled := false;
txtcontacto.Enabled:= false;
txtcalle.Enabled:= false;
nexterior.Enabled := false;
ninterior.Enabled := false;
txtcolonia.Enabled := false;
txtlocalidad.Enabled:= false;
slestado.Enabled:= false;
txtcp.Enabled:= false;
txttelcontacto.Enabled:= false;
txtcorreocontacto.Enabled:= false;
Button1.Enabled:=false;
artgrid.Enabled:=false;
Button2.Enabled:=false;

nfac.Enabled:= true;
cargar.Enabled:= true;
nfac.Text:='';

end;





end;

procedure TcfdiFrom.cargarinfo(v:string);
var
iNumero:integer;
importe,precio: real;
p1,i1:string;

begin


if (v <> '0') then
begin
txtrfc.Enabled:=true;
txtnombre.Enabled := true;
txtcontacto.Enabled:= true;
txtcalle.Enabled:= true;
nexterior.Enabled := true;
ninterior.Enabled := true;
txtcolonia.Enabled := true;
txtlocalidad.Enabled:= true;
slestado.Enabled:= true;
txtcp.Enabled:= true;
txttelcontacto.Enabled:= true;
txtcorreocontacto.Enabled:= true;
Button1.Enabled:=true;
artgrid.Enabled:=true;
Button2.Enabled:=true;

 with dmDatos.qryConsulta do begin
  Close;
        SQL.Clear;
        SQL.Add('select numero from comprobantes where tipo = ''F'' and venta = ' + v);
        Open;
        folio :=  inttostr(FieldByName('numero').AsInteger);
   Close;
 end;

with dmDatos.qryConsulta do begin
        Close;
        SQL.Clear;
        SQL.Add('select cliente from ventas where clave = ' + v);
        Open;
       client :=  FieldByName('cliente').AsInteger;
   Close;
   end;

with dmDatos.qryConsulta do begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT  tipopago.NOMBRE, ventaspago.referencia FROM tipopago, VENTASPAGO where tipopago.CLAVE = ventaspago.TIPOPAGO and ventaspago.VENTA = ' + v);
        Open;
       tipopago :=  trim(FieldByName('nombre').AsString);
       referencia :=   trim(FieldByName('referencia').AsString);
   Close;
   end;

  recuperacliente(client);

subtotal.Value := cfdtotal;

  iNumero:=0;
 with dmDatos.qryConsulta do begin
        Close;
        SQL.Clear;
        SQL.Add('select VENTASDET.VENTA, ventasdet.ARTICULO, ventasdet.CANTIDAD, UNIDADES.NOMBRE, ventasdet.precio,ventasdet.descuento, ventasdet.orden, ');
        SQL.Add('ventasdet.FECHA,articulos.DESC_CORTA, codigos.CODIGO, ARTICULOS.UNIDADE from VENTASDET, ');
        SQL.Add('articulos, codigos, UNIDADES where VENTASDET.VENTA = '+ v +' and ventasdet.ARTICULO = articulos.CLAVE');
        SQL.Add(' and codigos.ARTICULO = articulos.CLAVE AND ARTICULOS.UNIDADE = UNIDADES.CLAVE order by ventasdet.ORDEN');
        Open;


    while(not Eof) do begin
             Inc(iNumero);
                        artgrid.RowCount := iNumero + 1;
                        artgrid.Cells[0,iNumero] := IntToStr(FieldByName('orden').AsInteger + 1);
                      artgrid.Cells[6,iNumero] := FieldByName('codigo').AsString;              // Clave del artículo
                        artgrid.Cells[1,iNumero] := FloatToStr(FieldByName('cantidad').AsFloat);
                        artgrid.Cells[2,iNumero] := Trim(FieldByName('nombre').AsString);         // Código
                        artgrid.Cells[3,iNumero] := Trim(FieldByName('desc_corta').AsString);
                        precio:=  FieldByName('precio').AsFloat;

                        p1:= FormatFloat('0.0000',precio-precio*(FieldByName('descuento').AsFloat/100));
                        artgrid.Cells[4,iNumero] := p1;//FloatToStr(FieldByName('precio').AsFloat);//FloatToStr(RoundTo(FieldByName('precio').AsFloat,-2));   // Cantidad de artículos (por default 1)
                         importe :=  FieldByName('cantidad').AsFloat * (precio-precio*(FieldByName('descuento').AsFloat/100)); //FieldByName('precio').AsFloat;
                        //importe := StrToFloat(artgrid.Cells[4,iNumero]) * StrToFloat(artgrid.Cells[2,iNumero]);
                        i1:= FormatFloat('0.0000',importe);
                        artgrid.Cells[5,iNumero] := i1;//FloatToStr(StrToFloat(artgrid.Cells[4,iNumero]) * StrToFloat(artgrid.Cells[2,iNumero]));//FloatToStr(RoundTo(StrToFloat(artgrid.Cells[4,iNumero]) * StrToFloat(artgrid.Cells[2,iNumero]),-2));    // Precio del artículo


                       {grdDatos.Cells[6,iNumero] := Trim(FieldByName('tipo').AsString);            // Tipo de artículo (A granel, Juego, etc.
                        grdDatos.Cells[7,iNumero] := Trim(FieldByName('descauto').AsString);        // Descuento automático del artículo
                        grdDatos.Cells[8,iNumero] := FloatToStr(FieldByName('descotorg').AsFloat);  // Descuento otorgado
                        grdDatos.Cells[9,iNumero] := FloatToStr(FieldByName('descfechas').AsFloat); // Descuento por fechas
                        grdDatos.Cells[10,iNumero] := IntToStr(FieldByName('categoria').AsInteger); // Categoria
                        grdDatos.Cells[11,iNumero] := IntToStr(FieldByName('departamento').AsInteger); // Departamento
                        grdDatos.Cells[13,iNumero] := FloatToStr(FieldByName('descusuario').AsFloat); // Departamento
                        grdDatos.Cells[14,iNumero] := Trim(FieldByName('comentario').AsString); // Comentario
                        grdDatos.Cells[15,iNumero] := FormatDateTime('mm/dd/yyyy',FieldByName('fecha').AsDateTime); // Comentario
                        grdDatos.Cells[16,iNumero] := Trim(FieldByName('cantidad_Cnt').AsString); // Articulo controla cantidad en el almacén
                        grdDatos.Cells[17,iNumero] := FieldByName('fiscal').AsString;           //Recupera cantidad fiscal
                        grdDatos.Cells[18,iNumero] := FieldByName('articulo').AsString;}

    Next;
    end;
    Close;
   end;
recalcular;
end;
end;


procedure TcfdiFrom.recuperacliente(cliente:integer);
begin
   ncliente.Text := IntToStr(cliente);
 with dmDatos.qryConsulta do begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT * FROM clientes WHERE clave = ' + IntToStr(cliente));
        Open;

        if(not Eof) then begin

            txtNombre.Text := Trim(FieldByname('Nombre').AsString);
            txtRfc.Text := Trim(FieldByname('RFC').AsString);
            txtCalle.Text := Trim(FieldByname('CALLE').AsString);
            txtColonia.Text := Trim(FieldByname('COLONIA').AsString);
            txtLocalidad.Text := Trim(FieldByname('LOCALIDAD').AsString);
            slestado.Text := trim(FieldByname('ESTADO').AsString);
            txtCp.text := Trim(FieldByname('CP').AsString);
            txtCorreoContacto.Text := Trim(FieldByname('Ecorreo').AsString);
            txtTelContacto.Text:= Trim(FieldByname('TELEFONO').AsString);
             ninterior.Text := Trim(FieldByname('NINTERIOR').AsString);
            nexterior.Text := Trim(FieldByname('NEXTERIOR').AsString);
            txtContacto.Text :=Trim(FieldByname('CONTACTO').AsString);

            

        end;
        Close;
    end;

end;

procedure TcfdiFrom.Button4Click(Sender: TObject);
begin

 recalcular;

end;

procedure TcfdiFrom.recalcular;
var i,rows:integer;
csubtotal,civa,ctotal:real;
begin
rows := artgrid.RowCount;
csubtotal:= 0;
ctotal := 0;
civa := 0;
{for i:=1 to  rows-1 do
begin

artgrid.Cells[5,i] := FloatToStr(StrToFloat(artgrid.Cells[4,i]) * StrToFloat(artgrid.Cells[2,i]));
csubtotal := csubtotal + strtofloat(artgrid.Cells[5,i]);

end; }
for i:=1 to  rows-1 do
begin
artgrid.Cells[1,i] := FloatToStr(RoundTo(StrToFloat(artgrid.Cells[5,i]) /  StrToFloat(artgrid.Cells[4,i]), -4));//FloatToStr(roundto(StrToFloat(artgrid.Cells[5,i]) /  StrToFloat(artgrid.Cells[4,i]),-2));
csubtotal := csubtotal + roundto(strtofloat(artgrid.Cells[5,i]),-2);
//artgrid.Cells[2,i] :=  FloatToStr(RoundTo(StrToFloat(artgrid.Cells[2,i]), -2));
end;




subtotal.Value := csubtotal;
iva.Value:=  roundto(subtotal.Value * 0.16,-2);
total.Value:=  subtotal.Value + iva.Value;





end;

procedure TcfdiFrom.cargarClick(Sender: TObject);
var
venta:string;
fac:string;
begin

 with dmDatos.qryConsulta do begin
  Close;
        SQL.Clear;
        SQL.Add('select venta, fac from comprobantes where tipo = ''F'' and numero = ' + nfac.Text);
        Open;
        venta := inttostr(FieldByName('venta').AsInteger);
        fac :=  FieldByName('fac').AsString;
       Close;
 end;
 if (fac <> 'S') then
 begin
 cargarinfo(venta);
 cfdventa := venta;
 folio:= nfac.Text;
 fuente := true;
 end
 else
 begin
 nfac.Text:='';
 showmessage('Factura ya emitida');

 end;

end;

procedure TcfdiFrom.Button1Click(Sender: TObject);
begin


  with dmDatos.qryModifica do begin
  Close;
            SQL.Clear;
            SQL.Add('UPDATE clientes SET nombre = ''' + txtNombre.Text + ''',');
            SQL.Add('RFC = ''' + txtRfc.Text+ ''',');
            SQL.Add('CALLE = '''+ txtCalle.Text + ''',');
            SQL.Add('COLONIA = '''+ txtColonia.Text+ ''',');
            SQL.Add('LOCALIDAD = '''+ txtLocalidad.Text + ''',');
            SQL.Add('ESTADO = '''+ slestado.text+ ''',');
            SQL.Add('CP = ''' + txtCp.Text + ''',');
      //      SQL.Add('DESCUENTO = '+FloatToStr(txtDescuento.Value) + ',');
            SQL.Add('TELEFONO = ''' + txtTelContacto.Text + ''',');
            SQL.Add('ECORREO = '''+ txtCorreoContacto.Text + ''',');
       //     SQL.Add('CREDENCIAL = ''' + txtCreden.Text + ''',');
       //     SQL.Add('VENCIMCREDEN = ' + sFechaCred + ',');
      //      SQL.Add('LIMITECREDITO =' +FloatToStr(txtCredito.Value)+ ',');
      //      SQL.Add('FECHACAP = '''+ sFecha + ''',');
       //     SQL.Add('FECHAUMOV = '''+ sFecha + ''',');
         SQL.Add('CONTACTO = '''+ txtContacto.Text+ ''',');
       //     SQL.Add('EMPRESA = ''' + txtEmpresa.Text+ ''',');
       //     SQL.Add('RFCEMP = ''' +txtRfcEmp.Text + ''',');
        //    SQL.Add('CALLEEMP = '''+ txtCalleEmp.Text + ''',');
       //     SQL.Add('COLONIAEMP = ''' + txtColoniaEmp.Text + ''',');
       //     SQL.Add('LOCALIDADEMP = ''' +txtLocalidadEmp.Text + ''',');
       //     SQL.Add('ESTADOEMP = ''' +txtEstadoEmp.Text + ''',');
        //    SQL.Add('CPEMP = '''+ txtCpEmp.Text+ ''',');
         //   SQL.Add('CORREOEMP = ''' + txtCorreoEmp.Text + ''',');
     //       SQL.Add('CELULAR = ''' + txtCelContacto.Text + ''',');
      //      SQL.Add('FAXEMP = ''' +txtFaxEmp.Text + ''',');
       //     SQL.Add('TELEMP = ''' + txtTelEmp.Text + ''',');
        //    SQL.Add('CATEGORIA = ' + sCateg + ',');

            SQL.Add('NEXTERIOR = ''' + nexterior.Text + ''',');
            SQL.Add('NINTERIOR = ''' + ninterior.Text + ''' ');
          //  SQL.Add('precio = ' + FloatToStr(txtPrecio.Value));
            SQL.Add('WHERE clave = ' + ncliente.Text);
            ExecSQL;
            Close;

  end;

  ShowMessage('Cliente Actualizado');

end;

procedure TcfdiFrom.Button2Click(Sender: TObject);
var
i,j:integer;
nombrearch,txtotal:string;
datosUsuario, datosReceptor, datosCFDI, nombreEtiqueta, valorEtiqueta, cantidad, umedida,
descripcion, valorUnitario, importe, respuesta, respuesta2,nombreRetencion,
impuestoRetencion, importeRetencion,nombreTraslado, impuestoTraslado, tasaTraslado, importeTraslado,datosEtiquetas, datosConceptos, datosInfoAduanera, datosRetenidos, datosTraslados, datosRetenidosLocales, datosTrasladosLocales: arrayofstring;
iniArchivo : TIniFile;
sDirReportes,sArchFactura, srutabmp:string;
xws: WideString;
f: file;
xs: TStream;
nodotxt, rpdf, param,servidor:string;
p : PAnsichar;
aBMP : TBitmap;

nodo, raiz: IXMLNode;


begin
cfdtotal :=  total.Value;//roundto(total.Value,-2);
//strtofloat(total.Text);
txtotal:= UpperCase(ConvNumero(cfdtotal,true));
 iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) +'config.ini');
SetLength(datosUsuario,3);
//datosUsuario[0]:='DEMO000002FEL';
//datosUsuario[1]:='Pruebas14';
//datosUsuario[2]:='DEMO000002FELa$';
datosUsuario[0]:= iniarchivo.ReadString('CFDI', 'RFC', '');
datosUsuario[1]:= iniarchivo.ReadString('CFDI', 'CUENTA', '');
datosUsuario[2]:= iniarchivo.ReadString('CFDI', 'PASSWORD', '');
 iniArchivo.Free;
SetLength(datosReceptor,16);
datosReceptor[0]:= trim(txtnombre.Text);
datosReceptor[1]:=trim(txtcontacto.Text);
datosReceptor[2]:=trim(txtTelContacto.Text);
datosReceptor[3]:=trim(txtCorreoContacto.Text);
datosReceptor[4]:=trim(txtrfc.Text);
datosReceptor[5]:=trim(txtnombre.Text);
datosReceptor[6]:=trim(txtcalle.Text);
datosReceptor[7]:=trim(nexterior.Text);
datosReceptor[8]:=trim(ninterior.Text);
datosReceptor[9]:=trim(txtcolonia.Text);
datosReceptor[10]:='_';
datosReceptor[11]:='_';
datosReceptor[12]:=trim(txtlocalidad.Text);
datosReceptor[13]:= trim(slestado.Text);
datosReceptor[14]:= 'México';
datosReceptor[15]:=trim(txtCp.Text);

SetLength(datosCFDI,22);   //mod 3.2
datosCFDI[0]:='FAC';
datosCFDI[1]:='Pago en una sola exhibición';
datosCFDI[2]:='_';
datosCFDI[3]:='_';
datosCFDI[4]:= tipopago; //insertar pago
datosCFDI[5]:='0.000000';
datosCFDI[6]:='0.000000';
datosCFDI[7]:='_';
datosCFDI[8]:='MXN';
datosCFDI[9]:='';
datosCFDI[10]:='';
datosCFDI[11]:='0.000000';
datosCFDI[12]:= iva.Text + '0000';
datosCFDI[13]:=subtotal.Text + '0000';
datosCFDI[14]:=total.Text + '0000';
datosCFDI[15]:=txtotal;

datosCFDI[16]:='Puebla, Pue.';
if (referencia <> '') then
begin
datosCFDI[17]:=referencia;
end
else
begin
datosCFDI[17]:='';
end;

datosCFDI[18]:='';
datosCFDI[19]:='';
datosCFDI[20]:='';
datosCFDI[21]:='';





//SetLength(datosEtiquetas,1);
//datosEtiquetas[0]:='';


 SetLength(datosConceptos,artgrid.RowCount-1);
  SetLength(datosInfoAduanera,artgrid.RowCount-1);
 //artgrid.RowCount-1;
SetLength(cantidad,artgrid.RowCount-1);
SetLength(umedida,artgrid.RowCount-1);
SetLength(descripcion,artgrid.RowCount-1);
SetLength(valorUnitario,artgrid.RowCount-1);
SetLength(importe,artgrid.RowCount-1);

for i:= 0  to  artgrid.RowCount-2 do
begin

cantidad[i]:= artgrid.Cells[1,i+1];

umedida[i]:= artgrid.Cells[2,i+1];
descripcion[i]:=artgrid.Cells[3,i+1];


valorUnitario[i]:=artgrid.Cells[4,i+1]+ '00';

importe[i]:=artgrid.Cells[5,i+1] + '00';
datosConceptos[i]:='|'+ cantidad[i]+ '|'+ umedida[i]+ '||'+ descripcion[i] + '|'+  valorUnitario[i]+'|'+ importe[i] +'|';
 datosInfoAduanera[i]:='';
end;


//SetLength(nombreRetencion,1);
//nombreRetencion[0]:='Retencion (IVA 4.00%)';

//SetLength(impuestoRetencion,1);
//impuestoRetencion[0]:='IVA';

//SetLength(importeRetencion,1);
//importeRetencion[0]:='40.000000';

SetLength(datosTraslados,1);
datosTraslados[0]:='|IVA (IVA 16.00%)|IVA|16.000000|'+ iva.Text + '0000|';



SetLength(respuesta,15);

respuesta :=GetConexionRemota32Soap(true).generarCFDIv32(datosUsuario,datosReceptor,datosCFDI,datosEtiquetas, datosConceptos, datosInfoAduanera, datosRetenidos, datosTraslados, datosRetenidosLocales, datosTrasladosLocales);
if  (respuesta[0] = 'True') then
begin

result.Font.Color := clGreen;
result.Visible := true;
result.Caption:= 'El CFDi fue generado con éxito!';
//ncf.Visible:= true;
//ncf.Caption:= 'Restan ' + respuesta[6] + ' folios';
Button2.Enabled:= false;
Button1.Enabled:= false;

//nombrearch:= 'ZUTAM_CFDI_' + respuesta[2] + '_'+ respuesta[3];
xmldoc.XML.Text:= UTF8Encode(respuesta[3]);
xmldoc.Active:=true;
raiz := xmldoc.DocumentElement.ChildNodes['cfdi:Complemento'].ParentNode;
//nombrearch:= 'ZUTAM_CFDI_' + raiz.Attributes['serie'] + '_'+ raiz.Attributes['folio'];

if (raiz.Attributes['serie'] = Null) then
begin
  raiz.Attributes['serie'] := 'a';
end;

nombrearch:= 'ZUTAM_CFDI_' + raiz.Attributes['serie'] +'_'+ raiz.Attributes['folio'];

nodo := xmldoc.DocumentElement.ChildNodes['cfdi:Complemento'];
nodotxt := nodo.ChildNodes[0].Attributes['UUID'];


respuesta2 := GetConexionRemota32Soap(true).generarCodigoBidimensional(datosUsuario,nodo.ChildNodes[0].Attributes['UUID']);
xws:=  respuesta2[2];
memo1.Text:= xws;





// image1.Picture.SaveToFile();




guardardatoscfdi();
////imprimir fac
iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) +'config.ini');
sDirReportes := iniArchivo.ReadString('Reportes', 'DirReportes', '');

  if not (Length(sDirReportes) > 0) then
  sDirReportes:= ExtractFilePath(Application.ExeName)+'Reportes\';

sArchFactura := sDirReportes + iniArchivo.ReadString('Reportes', 'Factura', '');
rptComprobante.FileName := sArchFactura;

servidor := iniArchivo.ReadString('BaseDato', 'Servidor', '');

if (servidor <> 'localhost')then begin
param:=  '-d \\'+servidor+'\facturas\codigos\' + nombrearch  + '.txt  \\'+servidor+'\facturas\codigos\' + nombrearch  + '.png';
p:= PAnsiChar(param);
xmldoc.SaveToFile('\\'+servidor+'\facturas\xml\'+ nombrearch  + '.xml');
rpdf :=  '\\'+servidor+'\facturas\pdf\';
if (respuesta2[0] = 'True') then
begin
memo1.Lines.SaveToFile('\\'+servidor+'\facturas\codigos\'+ nombrearch +'.txt');
ShellExecute(0, nil, 'C:\Ventas\base64.exe', p, '',5);
while NOT(FileExists('\\'+servidor+'\facturas\codigos\' + nombrearch + '.png'))do
begin
sleep(5000);
end;
image1.Picture.LoadFromFile('\\'+servidor+'\facturas\codigos\' + nombrearch + '.png');

aBMP := TBitmap.Create;

    aBMP.Assign(Image1.Picture.Graphic);
    Image2.Picture.Assign(aBMP);
    aBMP.Free;
    image2.Picture.SaveToFile('\\'+servidor+'\facturas\codigos\' + nombrearch + '.bmp');
   //  rptComprobante.Report.Params.ParamByName('rimagen').Value:= '\\'+servidor+'\facturas\codigos\' + nombrearch + '.bmp';
   srutabmp :=  '\\'+servidor+'\facturas\codigos\' + nombrearch + '.bmp';
end;

end
else
begin
param:=  '-d c:\facturas\codigos\' + nombrearch  + '.txt  c:\facturas\codigos\' + nombrearch  + '.png';
p:= PAnsiChar(param);
 xmldoc.SaveToFile('c:\facturas\xml\'+ nombrearch + '.xml');
 rpdf := 'c:\facturas\pdf\';
 if (respuesta2[0] = 'True') then
begin
 memo1.Lines.SaveToFile('c:\facturas\codigos\'+ nombrearch +'.txt');
 ShellExecute(0, nil, 'C:\Ventas\base64.exe', p, '',5);
 while NOT(FileExists('c:\facturas\codigos\' + nombrearch + '.png'))do
begin
sleep(5000);
end;
  image1.Picture.LoadFromFile('c:\facturas\codigos\'+ nombrearch  + '.png');
aBMP := TBitmap.Create;

    aBMP.Assign(Image1.Picture.Graphic);
    Image2.Picture.Assign(aBMP);
    aBMP.Free;
    image2.Picture.SaveToFile('c:\facturas\codigos\' + nombrearch + '.bmp');
   // rptComprobante.Report.Params.ParamByName('rimagen').Value:= 'c:\facturas\codigos\' + nombrearch + '.bmp';
   srutabmp := 'c:\facturas\codigos\' + nombrearch + '.bmp';
 end;
end;





rptComprobante.Report.Copies := 1;
rptComprobante.Title := 'Factura ' + folio ;

rptComprobante.Report.DatabaseInfo.Items[0].SQLConnection := dmDatos.sqlBase.DataSets[0].SQLConnection;
            rptComprobante.Report.Params.ParamByName('Numero').Value:= cfdventa;
            rptComprobante.Report.Params.ParamByName('Caja').Value:= caja;
  rptComprobante.Report.Params.ParamByName('femision').Value:=FormatDateTime('dd/mm/yyyy', date);
  rptComprobante.Report.Params.ParamByName('mpago').Value:=tipopago;
 rptComprobante.Report.Params.ParamByName('cliente').Value:= inttostr(client);
 rptComprobante.Report.Params.ParamByName('tiva').Value:= iva.Value;
 rptComprobante.Report.Params.ParamByName('ttotal').Value:=cfdtotal;
 rptComprobante.Report.Params.ParamByName('numerotexto').Value:= UpperCase(ConvNumero(cfdtotal,true));

 rptComprobante.Report.Params.ParamByName('folio').Value:= raiz.Attributes['serie']+' '+raiz.Attributes['folio'];
 rptComprobante.Report.Params.ParamByName('fecha').Value:= raiz.Attributes['fecha'];
 rptComprobante.Report.Params.ParamByName('uuid').Value:= nodo.ChildNodes[0].Attributes['UUID'];
 rptComprobante.Report.Params.ParamByName('leyenda').Value:= 'Este documento es una representación impresa de un CFDI'; //respuesta[5];
 rptComprobante.Report.Params.ParamByName('ftimbrado').Value:= nodo.ChildNodes[0].Attributes['FechaTimbrado'];
 rptComprobante.Report.Params.ParamByName('sellocfd').Value:= nodo.ChildNodes[0].Attributes['selloCFD'];
 rptComprobante.Report.Params.ParamByName('certificadosat').Value:= nodo.ChildNodes[0].Attributes['noCertificadoSAT'];
 rptComprobante.Report.Params.ParamByName('certificadoemisor').Value:= '00001000000103116917';
 rptComprobante.Report.Params.ParamByName('sellosat').Value:= nodo.ChildNodes[0].Attributes['selloSAT'];
 rptComprobante.Report.Params.ParamByName('cadoriginal').Value:= '||1.0|'+ nodo.ChildNodes[0].Attributes['UUID']+'|'+nodo.ChildNodes[0].Attributes['FechaTimbrado']+'|'+nodo.ChildNodes[0].Attributes['selloCFD']+'|'+nodo.ChildNodes[0].Attributes['noCertificadoSAT']+'||';//respuesta[14];
 rptComprobante.Report.Params.ParamByName('rimagen').Value:= srutabmp;
 rptComprobante.Report.Params.ParamByName('ncuenta').Value:= referencia;



rptComprobante.Execute;


rptComprobante.SaveToPDF(rpdf + nombrearch + '.pdf',true);






 iniArchivo.Free;
    with dmDatos.qryModifica do begin
        Close;
        SQL.Clear;
        SQL.Add('DELETE FROM cfdi WHERE caja = ' + inttostr(caja));
        ExecSQL;

        Close;

    end;
BitBtn1.Caption:= 'Cerrar';

//guarda folio en comprobantes
rpdf := 'update comprobantes set NCFDI = ''' + raiz.Attributes['serie']+raiz.Attributes['folio'] + ''', FAC = ''S'' where venta =  ' + cfdventa;

 with dmDatos.qryModifica do begin
  Close;
        SQL.Clear;
        SQL.Add('update comprobantes set ncfdi = ''' + raiz.Attributes['serie']+raiz.Attributes['folio'] + ''',UUID = '''+ nodo.ChildNodes[0].Attributes['UUID']+''' , FAC = ''S'' where venta =  ' + cfdventa);
        ExecSQL;

   Close;
 end;
if txtCorreoContacto.Text <> '' then
begin
//respuesta2 := GetConexionRemota32Soap(true).EnviarCFDI(datosUsuario,nodo.ChildNodes[0].Attributes['UUID'],txtCorreoContacto.Text);
if (servidor <> 'localhost')then begin
servidor := '\\'+ servidor;
 enviarfactura( servidor,nombrearch, txtCorreoContacto.Text,raiz.Attributes['serie'] + ' '+ raiz.Attributes['folio']);
end
else
begin
servidor := 'c:';
 enviarfactura(servidor,nombrearch, txtCorreoContacto.Text,raiz.Attributes['serie'] + ' '+ raiz.Attributes['folio']);
end;

end;

end
else
begin
 with dmDatos.qryModifica do begin
  Close;
        SQL.Clear;
        SQL.Add('update comprobantes set FAC = ''N'' where venta =  ' + cfdventa);
        ExecSQL;

   Close;
 end;

result.Font.Color := clRed;
result.Visible := true;
result.Caption:= respuesta[1];
//guardardatoscfdi();

end;



{with dmDatos.qryModifica do
begin

Close;
   SQL.Clear;
        SQL.Add('INSERT INTO ventas (areaventa, caja, numero, fecha, hora, iva,');
          SQL.Add('total, cambio, redondeo, estatus, cliente, usuario, ventaref, vendedor,vf) VALUES(');   // se modifico para xilotzingo , vf
          SQL.Add(sAreaVenta + ',' + IntToStr(iCaja) + ',' + IntToStr(iConsec) + ',''' + sFecha + ''',');
          SQL.Add('''' + sHora + ''',' + FloatToStr(rIva) + ',' + FloatToStr(rTotal) + ',');
          SQL.Add(FloatToStr(rCambio) + ',' + FloatToStr(rRedondeo) + ',');
          SQL.Add('''A'',' + sCliente + ',' + IntToStr(iUsuario) + ',' + sVentaRef + ',' + sVendedor + ',''' + sVF + ''')');
          ExecSQL;
end;}
end;







Procedure Tcfdifrom.guardardatoscfdi();
var
i: integer;
sq:string;
begin

with dmDatos.qryModifica do
begin


for i:=1 to artgrid.RowCount-1 do
begin
sq:= 'INSERT INTO cfdi(orden, cantidad, descripcion, precio, importe, caja, unidad) VALUES('+inttostr(i)+','+artgrid.Cells[1,i] +  ',''' + artgrid.Cells[3,i] + ''',' + artgrid.Cells[4,i] + ','+ artgrid.Cells[5,i] + ',' + inttostr(caja) +','''+ artgrid.Cells[2,i]+''')';
Close;
   SQL.Clear;
 //       SQL.Add('INSERT INTO cfdi(orden, cantidad, descripcion, precio, importe, caja');
   //       SQL.Add(') VALUES(');
     //     SQL.Add(inttostr(i) + ',' + artgrid.Cells[2,i] +  ',' + artgrid.Cells[3,i] + ',''' + artgrid.Cells[4,i] + ''',');
      //    SQL.Add(''+ artgrid.Cells[5,i] + ',' + artgrid.Cells[6,i] + ','+ inttostr(caja) + ')');
        SQL.Add(sq);
          ExecSQL;
          Close;
sq:='';
end;



end;





end;




function Tcfdifrom.ConvNumero(rNumero:Real; bPesos :boolean):String;
var
    iNumero, iDecimales, iMillon, iMil, iCentena, iDecena, iUnidad: LongInt;
    sRegreso : String;
    rTemp: real;


begin
    sRegreso := '';
    rNumero:=roundto(rNumero,-2);
    iNumero := Trunc(rNumero);
    rTemp := StrToFloat(FormatFloat('0.0000',Frac(rNumero)));
    rTemp := rTemp * 100;
 

    iDecimales :=Round(rTemp); //Trunc(rTemp);




    iMillon := iNumero div 1000000;
    iNumero := iNumero - iMillon * 1000000;
    iMil := iNumero div 1000;
    iNumero := iNumero - iMil * 1000;
    iCentena := iNumero div 100;
    iNumero := iNumero - iCentena * 100;
    iDecena := iNumero div 10;
    iNumero := iNumero - iDecena * 10;
    iUnidad := iNumero;

    if(iMillon > 0) then
        if(iMillon > 1) then
            sRegreso := ConvNumero(iMillon,false) + ' millones'
        else
            sRegreso := 'un millon';
    if(iMil > 0) then
        sRegreso := sRegreso + ' ' + ConvNumero(iMil,false) + ' mil';
    if(iCentena > 0) then
        if(iCentena = 1) and (iDecena = 0) and (iUnidad = 0) then
            sRegreso := sRegreso + ' cien'
        else
            sRegreso := sRegreso + ' ' + sCentenas[iCentena];
    if(iDecena > 0) then
        if(iDecena < 3) then
            sRegreso := sRegreso + ' ' + sUnidades[iDecena*10+iUnidad]
        else
            sRegreso := sRegreso + ' ' + sDecenas[iDecena-2];
    if(iUnidad > 0) and ((iDecena = 0) or (iDecena > 2)) then begin
        if(iDecena > 0) then
            sRegreso := sRegreso + ' y';
        sRegreso := sRegreso + ' ' + sUnidades[iUnidad];
    end;
    if(Copy(sRegreso,1,1) = ' ') then
        sRegreso := Copy(sRegreso,2,Length(sRegreso)-1);
     if(bPesos) then
        sRegreso := sRegreso + ' pesos ' + FormatFloat('00',iDecimales) + '/100 m.n.';
    Result := sRegreso;
end;



procedure Tcfdifrom.InicializaNumeros;
begin
    sUnidades[1] := 'un';
    sUnidades[2] := 'dos';
    sUnidades[3] := 'tres';
    sUnidades[4] := 'cuatro';
    sUnidades[5] := 'cinco';
    sUnidades[6] := 'seis';
    sUnidades[7] := 'siete';
    sUnidades[8] := 'ocho';
    sUnidades[9] := 'nueve';
    sUnidades[10] := 'diez';
    sUnidades[11] := 'once';
    sUnidades[12] := 'doce';
    sUnidades[13] := 'trece';
    sUnidades[14] := 'catorce';
    sUnidades[15] := 'quince';
    sUnidades[16] := 'diez y seis';
    sUnidades[17] := 'diez y siete';
    sUnidades[18] := 'diez y ocho';
    sUnidades[19] := 'diez y nueve';
    sUnidades[20] := 'veinte';
    sUnidades[21] := 'veintiun';
    sUnidades[22] := 'veintidos';
    sUnidades[23] := 'veintitres';
    sUnidades[24] := 'veinticuatro';
    sUnidades[25] := 'veinticinco';
    sUnidades[26] := 'veintiseis';
    sUnidades[27] := 'veintisiete';
    sUnidades[28] := 'veintiocho';
    sUnidades[29] := 'veintinueve';

    sDecenas[1] := 'treinta';
    sDecenas[2] := 'cuarenta';
    sDecenas[3] := 'cincuenta';
    sDecenas[4] := 'sesenta';
    sDecenas[5] := 'setenta';
    sDecenas[6] := 'ochenta';
    sDecenas[7] := 'noventa';

    sCentenas[1] := 'ciento';
    sCentenas[2] := 'doscientos';
    sCentenas[3] := 'trescientos';
    sCentenas[4] := 'cuatrocientos';
    sCentenas[5] := 'quinientos';
    sCentenas[6] := 'seiscientos';
    sCentenas[7] := 'setecientos';
    sCentenas[8] := 'ochocientos';
    sCentenas[9] := 'novecientos';
end;

procedure Tcfdifrom.enviarfactura(src, pdf, email, num: string);
var SMTP: TIdSMTP;
   Mensaje: TIdMessage;
   Adjunto: TIdAttachment;
   sAdjunto :string;
begin
SMTP := TIdSMTP.Create(nil);
smtp.Username:='facturacion@jarcieriaszutam.com';
smtp.Password:='Fzutam2012';
smtp.Host:= 'mail.jarcieriaszutam.com';
smtp.Port := 26;
smtp.AuthenticationType:= atLogin;

Mensaje := TIdMessage.Create( nil );
  Mensaje.Clear;
  Mensaje.From.Name := 'Jarcierias ZUTAM';
  Mensaje.From.Address := 'facturacion@jarcieriaszutam.com';
  Mensaje.Subject := 'FACTURA JARCIERIAS ZUTAM (CFDI '+ num +')';

  //Mensaje.Body.Text := 'Adjuntamos factura. Gracias por su compra.';
Mensaje.Body.Text := memo2.Text;




  Mensaje.Recipients.Add;
  Mensaje.Recipients.Items[0].Address := email;

      sAdjunto := src+'\facturas\pdf\' + pdf+'.pdf';
  // Si hay que meter un archivo adjunto lo creamos y lo asignamos al mensaje
  if sAdjunto <> '' then
  begin
    if FileExists( sAdjunto ) then
      Adjunto := TIdAttachment.Create( Mensaje.MessageParts, sAdjunto );
      Adjunto := TIdAttachment.Create( Mensaje.MessageParts, src + '\facturas\xml\' + pdf +'.xml');

  end
  else
    Adjunto := nil;

  // Conectamos con el servidor SMTP
  try
    SMTP.Connect;
  except
    raise Exception.Create( 'Error al conectar con el servidor.' );
  end;

  // Si ha conectado enviamos el mensaje y desconectamos
  if SMTP.Connected then
  begin
    try
      result.Visible := true;
      result.Caption:= 'Enviando factura por e-mail. Espere...';
      SMTP.Send( Mensaje );
    except
      raise Exception.Create( 'Error al enviar el mensaje.' );
    end;

    try
      SMTP.Disconnect;
    except
      raise Exception.Create( 'Error al desconectar del servidor.' );
    end;
  end;

  // Liberamos los objetos creados
  if Adjunto <> nil then
    FreeAndNil( Adjunto );

  FreeAndNil( Mensaje );
  FreeAndNil( SMTP );
   result.Caption:= 'Factura enviada correctamente.';
 // Application.MessageBox( 'Mensaje enviado correctamente.',
  //i  'Fin de proceso',[smbOK] );

    end;

procedure TcfdiFrom.FormClose(Sender: TObject; var Action: TCloseAction);
begin
cfdventa := '';
end;

end.
