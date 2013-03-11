unit ExportarAExcel;

interface

uses
  SysUtils, Classes, QGraphics, QControls, QForms, QDialogs,
  Db, DBClient;

const
  BOF       = $0009;
  BIT_BIFF5 = $0800;
  BOF_BIFF5 = BOF or BIT_BIFF5;
  BIFF_EOF = $000a;
  DIMENSIONS = $0200;
  DOCTYPE_XLS = $0010;
  LEN_RECORDHEADER = 4;
Type


TCsvStream=Class
   Private
     FStream            : TStream;
     FSourceTable       : TDataSet;
     Filename           : string;
     InternDataBase     : String;
   Protected
    procedure   CreateStream;
    procedure   CloseStream;
    property    Stream : TStream read FStream write FStream;
   Public
//    Gauge              : TProgressBar ;
    property    CsvFilename    : string read Filename  write Filename ;
    property    Dataset      : TDataSet Read  FSourceTable  write FSourceTable ;
    property    DataBaseName   : String read InternDataBase  write InternDataBase ;
    Procedure   CsvExport;
   end;


TCellType = (CellBlank, CellInteger, CellDouble, CellLabel, CellBoolean);

TExcelStream=Class
   Private
     FStream            : TStream;
     LineCount,ColCount : Integer;
     FSourceTable       : TDataset;
     Filename           : string;
     InternDataBase     : String;
   Protected
    procedure   CreateStream;
    procedure   CloseStream;
    procedure   WriteRecordHeader(RecType, Size : integer);
    procedure   WriteData(CellType : TCellType; ARow, ACol: Integer; Cell : string); virtual;
    property    Stream : TStream read FStream write FStream;
    Procedure   ConnectXlsFile;
    Procedure   DisConnectXlsFile;
    procedure   WriteXlsData(CellType : TCellType; ARow, ACol: Integer; Value : string);
   Public
//    Gauge             : TGauge ;
    property    XlsFilename : string read Filename  write Filename ;
    property    Dataset   : TDataset read FSourceTable  write FSourceTable ;
    property    DataBaseName    : String read InternDataBase  write InternDataBase ;
    Procedure   XlsExport;
   end;

implementation

{Excel Stream}

procedure TExcelStream.WriteRecordHeader(RecType, Size : integer);
var
    Buffer : array[0..1] of word;
begin
    Buffer[0] := RecType;
    Buffer[1] := Size;
    Stream.Write(Buffer, SizeOf(Buffer));
end;

procedure TExcelStream.CreateStream;
var
    Buffer : array[0..4] of word;
begin
  if pos('.',Filename)>1 then
       Filename:=Trim(Copy(Filename,1,Pos('.',Filename)-1));
  Filename:=Filename+'.Xls';
  FStream := TFileStream.Create(Filename, fmCreate);
  Buffer[0] := 0;
  Buffer[1] := DOCTYPE_XLS;
  Buffer[2] := 0;
  WriteRecordHeader(BOF_BIFF5, 6);
  Stream.Write(Buffer, 6);
  Buffer[0] := 0;
  Buffer[1] := LineCount;
  Buffer[2] := 0;
  Buffer[3] := ColCount;
  Buffer[4] := 0;
  WriteRecordHeader(Dimensions, 10);
  Stream.Write(Buffer, 10);
end;

procedure TExcelStream.CloseStream;
begin
  WriteRecordHeader(BIFF_EOF, 0);
//  inherited CloseStream;
  FStream.Free
end;

procedure TExcelStream.WriteData(CellType : TCellType; ARow, ACol: Integer; Cell : string);
const
  Attribute: Array[0..2] Of Byte = (0, 0, 0); { 24 bit bitfield }
var
  Buffer : array[0..1] of word;
  RecType : word;
  Size : word;
  AString : ShortString;
  aInt: integer;
  aDbl: double;
  Data: Pointer;
begin
  Buffer[0] := ARow;
  Buffer[1] := ACol;
  AString := Cell;
  Data := @aInt;
  case CellType of
    CellInteger   :
      begin
        RecType := 2; Size := 11;
        WriteRecordHeader(RecType, Size);
        Size := 4; aInt := StrtoIntDef(Cell,0);
        Data := @aInt;
      end;
    CellDouble   :
      begin
        RecType := 3; Size := 15;
        WriteRecordHeader(RecType, Size);
        Size := 8;  aDbl := StrToFloatDef(Cell,0);
        Data := @aDbl;
      end;
    CellLabel   :
      begin
        RecType := 4; Size := length(Cell) + 8;
        WriteRecordHeader(RecType, Size);
      end;
  else
    exit;
  end;
  Stream.Write(Buffer, SizeOf(Buffer));
  Stream.Write(Attribute, SizeOf(Attribute));
  if CellType = CellLabel then
    Stream.Write(AString, Length(AString) + 1)
  else
    Stream.Write(Data^, Size);
end;

Procedure  TExcelStream.ConnectXlsFile;
begin
  CreateStream;
end;

    Procedure  TExcelStream.DisConnectXlsFile;
begin
  CloseStream;
end;
procedure   TExcelStream.WriteXlsData(CellType : TCellType; ARow, ACol: Integer; Value : string);
begin
  WriteData(CellType , ARow, ACol, Value);
end;

Procedure   TExcelStream.XlsExport;
Var
  Col,Row:integer;
begin
  FSourceTable.Open;
  LineCount:=FSourceTable.RecordCount+1;
  ColCount:=FSourceTable.FieldCount;
  ConnectXlsFile;
  Row:=0;
{  if Gauge<>Nil then
  begin
    Gauge.MaxValue := FSourceTable.RecordCount;
    Gauge.Progress := 0;
  end;}
  FSourceTable.First;
  // Save Fields Names
  for Col:=0 to FSourceTable.FieldCount-1 do
      WriteXlsData(CellLabel,Row,Col,FSourceTable.Fields[Col].FieldName);
  //
  Row:=1;
  while not  FSourceTable.Eof do Begin
//    Gauge.Progress := FSourceTable.RecNo;
    Application.ProcessMessages;
    for Col:=0 to FSourceTable.FieldCount-1 do begin
      if FSourceTable.Fields[Col].DataType=ftInteger then
        WriteXlsData(CellInteger,Row,Col,FSourceTable.Fields[Col].AsString)
      else
      if FSourceTable.Fields[Col].DataType=ftFloat then
        WriteXlsData(CellDouble,Row,Col,FSourceTable.Fields[Col].AsString)
      else
        WriteXlsData(CellLabel,Row,Col,FSourceTable.Fields[Col].AsString);
    end;
    inc(Row);
    FSourceTable.Next;
  end;
  DisConnectXlsFile;
//  FSourceTable.free;
end;

// Csv Export

procedure TCsvStream.CreateStream;
begin
  if pos('.',Filename)>1 then
       Filename:=Trim(Copy(Filename,1,Pos('.',Filename)-1));
  Filename:=Filename+'.Csv';
  FStream := TFileStream.Create(Filename, fmCreate);
end;

procedure TCsvStream.CloseStream;
begin
//  inherited CloseStream;
  FStream.Free
end;

Procedure   TCsvStream.CsvExport;
Var
//  Row,
    Col     : Integer;
  AString : ShortString;
begin
//  FSourceTable:=TQuery.Create(nil);
//  FSourceTable.close;
//  FSourceTable.DatabaseName:=InternDataBase;
//  FSourceTable.SQL.Text:=InternSQl;
  FSourceTable.Open;
//  Row:=FSourceTable.RecordCount;
  CreateStream;
{  if Gauge<>Nil then
  begin
    Gauge.MaxValue := FSourceTable.RecordCount;
    Gauge.Progress := 0;
  end;}
  FSourceTable.First;
  // Save Fields Names
  for Col:=0 to FSourceTable.FieldCount-1 do
  begin
//    if Gauge<>Nil then
//      Gauge.Progress := FSourceTable.RecNo;
    Application.ProcessMessages;
    AString:=FSourceTable.Fields[Col].FieldName;
     if Col=FSourceTable.FieldCount-1 then
        AString:=AString+#13#10
      else
        AString:=AString+',';
      Stream.Write(AString[1], Length(AString));
  end;
  // Save Values
  while not FSourceTable.Eof do Begin
    for Col:=0 to FSourceTable.FieldCount-1 do begin
      AString:=FSourceTable.Fields[Col].AsString;
      {Put String in '' for csv importation}
      if FSourceTable.Fields[Col].DataType = ftString then
        aString := '"'+ aString + '"';
      if Col=FSourceTable.FieldCount-1 then
        AString:=AString+#13#10
      else
        AString:=AString+',';
      Stream.Write(AString[1], Length(AString));
    end;
    FSourceTable.Next;
  end;
  CloseStream;
//  FSourceTable.free;
end;

end.

