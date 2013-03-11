unit fgeneral;

interface

uses
  SysUtils, Types, Classes, Variants, QTypes, QGraphics, QControls, QForms, 
  QDialogs, QStdCtrls, QButtons, xmldom, XMLIntf,
  msxmldom, XMLDoc, ConexionRemota32,IniFiles, QExtCtrls,ShellApi,pngimage,
  rpcompobase, rpclxreport, QcurrEdit;


type
  Tfacgeneral = class(TForm)
    GroupBox1: TGroupBox;
    txtDiaIni: TEdit;
    txtMesIni: TEdit;
    txtAnioIni: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label5: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    xmldoc: TXMLDocument;
    rptComprobante: TCLXReport;
    Memo1: TMemo;
    Image1: TImage;
    Image2: TImage;
    Label3: TLabel;
    currEdit1: TcurrEdit;

    procedure r1Click(Sender: TObject);

    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
      procedure InicializaNumeros;

  private
    { Private declarations }
    sUnidades : Array [1..30] of String;
    sDecenas : Array [1..7] of String;
    sCentenas : Array [1..9] of String;
    procedure generaporfecha();
    procedure genera(cadena:string; total: Real);



  public
  function VerificaDatos : boolean;
  function VerificaFechas(sFecha : string):boolean;
  function ConvNumero(rNumero:Real; bPesos :boolean):String;

    { Public declarations }
  end;

var
  facgeneral: Tfacgeneral;
  sFechaIni,  sTipo : string;

implementation

uses dm,Reimprimir,math, okdial;

{$R *.xfm}
function Tfacgeneral.VerificaDatos : boolean;
begin
    Result:= true;

    sFechaIni := txtMesIni.Text + '/' + txtDiaIni.Text + '/' + txtAnioIni.Text;


    if(not VerificaFechas(txtDiaIni.Text + '/' + txtMesIni.Text + '/' + txtAnioIni.Text)) then begin
        Application.MessageBox('Introduce una fecha válida','Error',[smbOK],smsCritical);
        sFechaIni := txtMesIni.Text + '/' + txtDiaIni.Text + '/' + txtAnioIni.Text;
        txtDiaIni.SetFocus;
        Result := false;
    end;
end;

function Tfacgeneral.VerificaFechas(sFecha : string):boolean;
var
   dteFecha : TDateTime;
begin
   Result:=true;
   if(not TryStrToDate(sFecha,dteFecha)) then 
      Result:=false;
end;






procedure Tfacgeneral.r1Click(Sender: TObject);
begin
    txtDiaIni.Enabled:=true;
    txtMesIni.Enabled:=true;
    txtAnioIni.Enabled:=true;


end;



procedure Tfacgeneral.BitBtn1Click(Sender: TObject);
begin
generaporfecha();

end;

procedure Tfacgeneral.generaporfecha();
var
i:integer;
total:real;
inicio,fin:integer;
cadena:string;


begin
if (verificadatos) then
begin
sFechaIni := txtMesIni.Text  + '/' + txtDiaIni.Text + '/' + txtAnioIni.Text;

i:=0;
total:=0;
with dmDatos.qryConsulta do begin
        Close;
        SQL.Clear;
        SQL.Add('select VENTAS.TOTAL, comprobantes.NUMERO from ventas, comprobantes where VENTAS.CLAVE=comprobantes.venta and ');
        SQL.Add('VENTAS.ESTATUS=''A'' and comprobantes.TIPO=''T'' and ventas.fecha = '''+ sFechaIni +'''');
        Open;
       inicio := FieldByName('numero').AsInteger;
     //  showmessage(inttostr(inicio));
       while(not Eof) do begin
       inc(i);
       fin:=FieldByName('numero').AsInteger;
       total:= total+FieldByName('total').Asfloat;

       Next;
    end;

   Close;
   end;
   total := total - (currEdit1.Value);


  // showmessage(inttostr(fin));
 cadena:= '¿Desea generar la factura general del día '+ txtDiaIni.Text  + '/' + txtMesIni.Text + '/' + txtAnioIni.Text + ' por la cantidad de $ '+  floattostr(total)  +' restando $ '+ floattostr(currEdit1.Value) + '?';
  // showmessage(cadena);
    with Tokdial.Create(Self) do
    try
        oktxt.Caption := cadena;
      //  ShowModal;
 if ShowModal = mrOK then
 begin
  cadena:= 'Venta al publico general del '+ txtDiaIni.Text  + '/' + txtMesIni.Text + '/' + txtAnioIni.Text;
  genera(cadena,total);
  end;
    finally
        Free;
    end;

     //OKBottomDlg.Label1.Caption := cadena;

 end;




end;

procedure Tfacgeneral.genera(cadena:string; total: Real);
var
i,j:integer;
subtotal,iva:real;

nombrearch,txtotal:string;
datosUsuario, datosReceptor, datosCFDI, nombreEtiqueta, valorEtiqueta, cantidad,
descripcion, valorUnitario, importe, respuesta, respuesta2,nombreRetencion,
impuestoRetencion, importeRetencion,nombreTraslado, impuestoTraslado, tasaTraslado, importeTraslado,datosEtiquetas, datosConceptos, datosInfoAduanera, datosRetenidos, datosTraslados, datosRetenidosLocales, datosTrasladosLocales: arrayofstring;
iniArchivo : TIniFile;
sDirReportes,sArchFactura, srutabmp:string;
xws: WideString;
f: file;
xs: TStream;
feccha, rpdf, param,servidor:string;
p : PAnsichar;
aBMP : TBitmap;

nodo, raiz: IXMLNode;

begin
InicializaNumeros;
subtotal:= total / 1.16;
subtotal:= roundto(subtotal,-2);
iva:= subtotal * 0.16;
iva := RoundTo(iva, -2);

txtotal:= UpperCase(ConvNumero(total,true));
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
datosReceptor[0]:= 'PUBLICO GENERAL';
datosReceptor[1]:='';
datosReceptor[2]:='';
datosReceptor[3]:='javiertrejo@jarcieriaszutam.com';
datosReceptor[4]:='XAXX010101000';
datosReceptor[5]:='PUBLICO GENERAL';
datosReceptor[6]:='_';
datosReceptor[7]:='_';
datosReceptor[8]:=' ';
datosReceptor[9]:='_';
datosReceptor[10]:='';
datosReceptor[11]:='';
datosReceptor[12]:='Puebla';
datosReceptor[13]:='Puebla';
datosReceptor[14]:='México';
datosReceptor[15]:='00000';

SetLength(datosCFDI,22);
datosCFDI[0]:='FAC';
datosCFDI[1]:='Pago en una sola exhibición';
datosCFDI[2]:='';
datosCFDI[3]:='';
datosCFDI[4]:= 'Efectivo'; //insertar pago
datosCFDI[5]:='0.000000';
datosCFDI[6]:='0.000000';
datosCFDI[7]:='';
datosCFDI[8]:='MXN';
datosCFDI[9]:='';
datosCFDI[10]:='';
datosCFDI[11]:='0.000000';
datosCFDI[12]:= FormatFloat('0.00',iva) + '0000';
datosCFDI[13]:= FormatFloat('0.00',subtotal) + '0000';
datosCFDI[14]:= FormatFloat('0.00',total) + '0000';
datosCFDI[15]:=UpperCase(ConvNumero(total,true));

datosCFDI[16]:='Puebla, Pue.';
datosCFDI[17]:='';
datosCFDI[18]:='';
datosCFDI[19]:='';
datosCFDI[20]:='';
datosCFDI[21]:='';

//SetLength(nombreEtiqueta,1);
//nombreEtiqueta[0]:=' ';

//SetLength(valorEtiqueta,1);
//valorEtiqueta[0]:=' ';

 //artgrid.RowCount-1;
  SetLength(datosConceptos,1);
  SetLength(datosInfoAduanera,1);
SetLength(cantidad,1);
SetLength(descripcion,1);
SetLength(valorUnitario,1);
SetLength(importe,1);



cantidad[0]:= '1';


descripcion[0]:= cadena;


valorUnitario[0]:= FormatFloat('0.00',subtotal)+ '0000';

importe[0]:= FormatFloat('0.00',subtotal) + '0000';

datosConceptos[0]:='|'+ cantidad[0]+ '|-|'+ '|'+ descripcion[0] + '|'+  valorUnitario[0]+'|'+ importe[0] +'|';
 datosInfoAduanera[i]:='';




//SetLength(nombreRetencion,1);
//nombreRetencion[0]:='Retencion (IVA 4.00%)';

//SetLength(impuestoRetencion,1);
//impuestoRetencion[0]:='IVA';

//SetLength(importeRetencion,1);
//importeRetencion[0]:='40.000000';

SetLength(datosTraslados,1);
datosTraslados[0]:='|IVA (IVA 16.00%)|IVA|16.000000|'+ FormatFloat('0.00',iva) + '0000|';





SetLength(respuesta,15);

respuesta :=GetConexionRemota32Soap(true).generarCFDIv32(datosUsuario,datosReceptor,datosCFDI,datosEtiquetas, datosConceptos, datosInfoAduanera, datosRetenidos, datosTraslados, datosRetenidosLocales, datosTrasladosLocales);

if  (respuesta[0] = 'True') then
  begin
  Application.MessageBox('El CFDi fue generado con éxito! ','Aviso',[smbOK], smsCritical);


  xmldoc.XML.Text:= UTF8Encode(respuesta[3]);
  xmldoc.Active:=true;

  raiz := xmldoc.DocumentElement.ChildNodes['cfdi:Complemento'].ParentNode;
nodo := xmldoc.DocumentElement.ChildNodes['cfdi:Complemento'];

  if (raiz.Attributes['serie'] = Null) then
begin
  raiz.Attributes['serie'] := 'a';
end;

  nombrearch:= 'ZUTAM_CFDI_GENERAL_' + raiz.Attributes['serie'] + '_'+ raiz.Attributes['folio'];
  respuesta2 := GetConexionRemota32Soap(true).generarCodigoBidimensional(datosUsuario,nodo.ChildNodes[0].Attributes['UUID']);
xws:=  respuesta2[2];
memo1.Text:= xws;
feccha :=  txtMesIni.Text + '/' + txtDiaIni.Text  + '/' + txtAnioIni.Text;

   with dmDatos.qryModifica do begin
  Close;
            SQL.Clear;
            SQL.Add('INSERT INTO CFDITICKET (NCFD, TOTAL, FECHA) values ('''+ raiz.Attributes['serie']+raiz.Attributes['folio'] + ''','+ floattostr(total) + ','''+ feccha +''')');

            ExecSQL;
            Close;

  end;






// image1.Picture.SaveToFile();





////imprimir fac
iniArchivo := TIniFile.Create(ExtractFilePath(Application.ExeName) +'config.ini');
sDirReportes := iniArchivo.ReadString('Reportes', 'DirReportes', '');

  if not (Length(sDirReportes) > 0) then
  sDirReportes:= ExtractFilePath(Application.ExeName)+'Reportes\';

sArchFactura := sDirReportes + iniArchivo.ReadString('Reportes', 'Factura2', '');
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
rptComprobante.Title := 'Factura público general';

rptComprobante.Report.DatabaseInfo.Items[0].SQLConnection := dmDatos.sqlBase.DataSets[0].SQLConnection;

  rptComprobante.Report.Params.ParamByName('femision').Value:=FormatDateTime('dd/mm/yyyy', date);


 rptComprobante.Report.Params.ParamByName('iva').Value:= iva;
 rptComprobante.Report.Params.ParamByName('total').value:=total;
  rptComprobante.Report.Params.ParamByName('subtotal').value:=subtotal;
  rptComprobante.Report.Params.ParamByName('numerotexto').value:=txtotal;
 


 rptComprobante.Report.Params.ParamByName('detalle').Value:= cadena;

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





rptComprobante.Execute;

rptComprobante.SaveToPDF(rpdf + nombrearch + '.pdf');





 iniArchivo.Free;



//guarda folio en comprobantes

end
else
begin

 Application.MessageBox('Error al generar, '+respuesta[1] ,'Error',[smbOK], smsCritical);


//guardardatoscfdi();

end;






end;



procedure Tfacgeneral.BitBtn2Click(Sender: TObject);
begin
close;
end;
function Tfacgeneral.ConvNumero(rNumero:Real; bPesos :boolean):String;
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



procedure Tfacgeneral.InicializaNumeros;
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

end.
