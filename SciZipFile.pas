unit SciZipFile;
// Copyright 2004 Patrik Spanel
// scilib@sendme.cz 

// Written from scratch using InfoZip PKZip file specification application note

// ftp://ftp.info-zip.org/pub/infozip/doc/appnote-iz-latest.zip

// uses the Borland out of the box zlib

// Nick Naimo <nick@naimo.com> added support for folders on 6/29/2004 (see "NJN")
// Marcin Wojda <Marcin@sacer.com.pl> added exceptions and try finally blocks

interface

uses SysUtils, Classes, Types, Zlib;

type

  TCommonFileHeader = packed record
    VersionNeededToExtract: WORD; //       2 bytes
    GeneralPurposeBitFlag: WORD; //        2 bytes
    CompressionMethod: WORD; //              2 bytes
    LastModFileTimeDate: DWORD; //             4 bytes
    Crc32: DWORD; //                          4 bytes
    CompressedSize: DWORD; //                 4 bytes
    UncompressedSize: DWORD; //               4 bytes
    FilenameLength: WORD; //                 2 bytes
    ExtraFieldLength: WORD; //              2 bytes
  end;

  TLocalFile = packed record
    LocalFileHeaderSignature: DWORD; //     4 bytes  (0x04034b50)
    CommonFileHeader: TCommonFileHeader; //
    filename: AnsiString; //variable size
    extrafield: AnsiString; //variable size
    CompressedData: AnsiString; //variable size
  end;

  TFileHeader = packed record
    CentralFileHeaderSignature: DWORD; //   4 bytes  (0x02014b50)
    VersionMadeBy: WORD; //                 2 bytes
    CommonFileHeader: TCommonFileHeader; //
    FileCommentLength: WORD; //             2 bytes
    DiskNumberStart: WORD; //               2 bytes
    InternalFileAttributes: WORD; //        2 bytes
    ExternalFileAttributes: DWORD; //        4 bytes
    RelativeOffsetOfLocalHeader: DWORD; // 4 bytes
    filename: AnsiString; //variable size
    extrafield: AnsiString; //variable size
    fileComment: AnsiString; //variable size
  end;

  TEndOfCentralDir = packed record
    EndOfCentralDirSignature: DWORD; //    4 bytes  (0x06054b50)
    NumberOfThisDisk: WORD; //             2 bytes
    NumberOfTheDiskWithTheStart: WORD; //  2 bytes
    TotalNumberOfEntriesOnThisDisk: WORD; //    2 bytes
    TotalNumberOfEntries: WORD; //            2 bytes
    SizeOfTheCentralDirectory: DWORD; //   4 bytes
    OffsetOfStartOfCentralDirectory: DWORD; // 4 bytes
    ZipfileCommentLength: WORD; //          2 bytes
  end;

  TZipFile = class(TObject)
    Files: array of TLocalFile;
    CentralDirectory: array of TFileHeader;
    EndOfCentralDirectory: TEndOfCentralDir;
    ZipFileComment: string;
  private
    function GetUncompressed(i: integer): string;
    procedure SetUncompressed(i: integer; const Value: string);
    function GetDateTime(i: integer): TDateTime;
    procedure SetDateTime(i: integer; const Value: TDateTime);
    function GetCount: integer;
    function GetName(i: integer): string;
    procedure SetName(i: integer; const Value: string);
  public
    property Count:integer read GetCount;
    procedure AddFile(const name: string; FAttribute: DWord=0);
    procedure SaveToFile(const filename: string);
    procedure LoadFromFile(const filename: string);
    property Uncompressed[i: integer]: string read GetUncompressed write
    SetUncompressed;
    property Data[i: integer]: string read GetUncompressed write
      SetUncompressed;
    property DateTime[i: integer]: TDateTime read GetDateTime write SetDateTime;
    property Name[i: integer]:string read GetName write SetName;
  end;

  EZipFileCRCError = class(Exception);

function ZipCRC32(const Data:string):  longword;

implementation



{ TZipFile }

procedure TZipFile.SaveToFile(const filename: string);
var
  ZipFileStream: TFileStream;
  i: integer;
begin
  ZipFileStream := TFileStream.Create(filename, fmCreate);
  try
    for i := 0 to High(Files) do
      with Files[i] do
      begin
        CentralDirectory[i].RelativeOffsetOfLocalHeader :=
          ZipFileStream.Position;
        ZipFileStream.Write(LocalFileHeaderSignature, 4);
        if (LocalFileHeaderSignature = ($04034B50)) then
        begin
          ZipFileStream.Write(CommonFileHeader, SizeOf(CommonFileHeader));
          ZipFileStream.Write(PChar(filename)^,
            CommonFileHeader.FilenameLength);
          ZipFileStream.Write(PChar(extrafield)^,
            CommonFileHeader.ExtraFieldLength);
          ZipFileStream.Write(PChar(CompressedData)^,
            CommonFileHeader.CompressedSize);
        end;
      end;

    EndOfCentralDirectory.OffsetOfStartOfCentralDirectory :=
      ZipFileStream.Position;

    for i := 0 to High(CentralDirectory) do
      with CentralDirectory[i] do
      begin
        ZipFileStream.Write(CentralFileHeaderSignature, 4);
        ZipFileStream.Write(VersionMadeBy, 2);
        ZipFileStream.Write(CommonFileHeader, SizeOf(CommonFileHeader));
        ZipFileStream.Write(FileCommentLength, 2);
        ZipFileStream.Write(DiskNumberStart, 2);
        ZipFileStream.Write(InternalFileAttributes, 2);
        ZipFileStream.Write(ExternalFileAttributes, 4);
        ZipFileStream.Write(RelativeOffsetOfLocalHeader, 4);
        ZipFileStream.Write(PChar(filename)^, length(filename));
        ZipFileStream.Write(PChar(extrafield)^, length(extrafield));
        ZipFileStream.Write(PChar(fileComment)^, length(fileComment));
      end;
    with EndOfCentralDirectory do
    begin
      EndOfCentralDirSignature := $06054B50;
      NumberOfThisDisk := 0;
      NumberOfTheDiskWithTheStart := 0;
      TotalNumberOfEntriesOnThisDisk := High(Files) + 1;
      TotalNumberOfEntries := High(Files) + 1;
      SizeOfTheCentralDirectory :=
        ZipFileStream.Position - OffsetOfStartOfCentralDirectory;
      ZipfileCommentLength := length(ZipFileComment);
    end;
    ZipFileStream.Write(EndOfCentralDirectory, SizeOf(EndOfCentralDirectory));
    ZipFileStream.Write(PChar(ZipFileComment)^, length(ZipFileComment));
  finally
    ZipFileStream.Free;
  end;

end;

procedure TZipFile.LoadFromFile(const filename: string);
var
  ZipFileStream: TFileStream;
  n: integer;
  signature: DWORD;
begin
  ZipFileStream := TFileStream.Create(filename, fmOpenRead or fmShareDenyWrite);
  n := 0;
  try
    repeat
      signature := 0;
      ZipFileStream.Read(signature, 4);
    until signature = $04034B50;
    repeat
      begin
        if (signature = $04034B50) then
        begin
          inc(n);
          SetLength(Files, n);
          SetLength(CentralDirectory, n);
          with Files[n - 1] do
          begin
            LocalFileHeaderSignature := signature;
            ZipFileStream.Read(CommonFileHeader, SizeOf(CommonFileHeader));
            SetLength(filename, CommonFileHeader.FilenameLength);
            ZipFileStream.Read(PChar(filename)^,
              CommonFileHeader.FilenameLength);
            SetLength(extrafield, CommonFileHeader.ExtraFieldLength);
            ZipFileStream.Read(PChar(extrafield)^,
              CommonFileHeader.ExtraFieldLength);
            SetLength(CompressedData, CommonFileHeader.CompressedSize);
            ZipFileStream.Read(PChar(CompressedData)^,
              CommonFileHeader.CompressedSize);
          end;
        end;
      end;
      signature := 0;
      ZipFileStream.Read(signature, 4);
    until signature <> ($04034B50);

    n := 0;
    repeat
      begin
        if (signature = $02014B50) then
        begin
          inc(n);
          with CentralDirectory[n - 1] do
          begin
            CentralFileHeaderSignature := signature;
            ZipFileStream.Read(VersionMadeBy, 2);
            ZipFileStream.Read(CommonFileHeader, SizeOf(CommonFileHeader));
            ZipFileStream.Read(FileCommentLength, 2);
            ZipFileStream.Read(DiskNumberStart, 2);
            ZipFileStream.Read(InternalFileAttributes, 2);
            ZipFileStream.Read(ExternalFileAttributes, 4);
            ZipFileStream.Read(RelativeOffsetOfLocalHeader, 4);
            SetLength(filename, CommonFileHeader.FilenameLength);
            ZipFileStream.Read(PChar(filename)^,
              CommonFileHeader.FilenameLength);
            SetLength(extrafield, CommonFileHeader.ExtraFieldLength);
            ZipFileStream.Read(PChar(extrafield)^,
              CommonFileHeader.ExtraFieldLength);
            SetLength(fileComment, FileCommentLength);
            ZipFileStream.Read(PChar(fileComment)^, FileCommentLength);
          end;
        end;
      end;
      signature := 0;
      ZipFileStream.Read(signature, 4);
    until signature <> ($02014B50);
    if signature = $06054B50 then
    begin
      EndOfCentralDirectory.EndOfCentralDirSignature := Signature;
      ZipFileStream.Read(EndOfCentralDirectory.NumberOfThisDisk,
        SizeOf(EndOfCentralDirectory) - 4);
      SetLength(ZipFileComment, EndOfCentralDirectory.ZipfileCommentLength);
      ZipFileStream.Read(PChar(ZipFileComment)^,
        EndOfCentralDirectory.ZipfileCommentLength);
    end;

  finally
    ZipFileStream.Free;
  end;
end;

function TZipFile.GetUncompressed(i: integer): string;
var
  Decompressor: TDecompressionStream;
  UncompressedStream: TStringStream;
  Aheader: string;
  ReadBytes: integer;
  LoadedCrc32: DWORD;
begin
  if (i < 0) or (i > High(Files)) then
//  begin
//    result := '';
//    exit;
//  end;
    raise Exception.Create('Index out of range.');
  Aheader := chr(120) + chr(156); //manufacture a 2 byte header for zlib; 4 byte footer is not required.
  UncompressedStream := TStringStream.Create(Aheader + Files[i].CompressedData);
  try  {+}
    Decompressor := TDecompressionStream.Create(UncompressedStream);
    try  {+}
      SetLength(Result, Files[i].CommonFileHeader.UncompressedSize);
      ReadBytes := Decompressor.Read(PChar(Result)^,
      Files[i].CommonFileHeader.UncompressedSize);
      if ReadBytes <> integer(Files[i].CommonFileHeader.UncompressedSize) then
        Result := '';
    finally
      Decompressor.Free;
    end;
  finally
    UncompressedStream.Free;
  end;

  LoadedCRC32 := ZipCRC32(Result);
  if LoadedCRC32 <> Files[i].CommonFileHeader.Crc32 then
// - Result := '';
     raise EZipFileCRCError.CreateFmt('CRC Error in "%s".', [Files[i].filename]);
end;

procedure TZipFile.SetUncompressed(i: integer; const Value: string);
var
  Compressor: TCompressionStream;
  CompressedStream: TStringStream;
begin
  if i>High(Files) then // exit;
    raise Exception.Create('Index out of range.');
  compressedStream := TStringStream.Create('');
  try {+}
    compressor := TcompressionStream.Create(clDefault, CompressedStream);
    try {+}
      compressor.Write(PChar(Value)^, length(Value));
    finally
      compressor.Free;
    end;
    Files[i].CompressedData := Copy(compressedStream.DataString, 3,
      length(compressedStream.DataString) - 6); //strip the 2 byte headers and 4 byte footers
    Files[i].LocalFileHeaderSignature := ($04034B50);
    with Files[i].CommonFileHeader do
    begin
      VersionNeededToExtract := 20;
      GeneralPurposeBitFlag := 0;
      CompressionMethod := 8;
      LastModFileTimeDate := DateTimeToFileDate(Now);
      Crc32 := ZipCRC32(Value);
      CompressedSize := length(Files[i].CompressedData);
      UncompressedSize := length(Value);
      FilenameLength := length(Files[i].filename);
      ExtraFieldLength := length(Files[i].extrafield);
    end;

    with CentralDirectory[i] do
    begin
      CentralFileHeaderSignature := $02014B50;
      VersionMadeBy := 20;
      CommonFileHeader := Files[i].CommonFileHeader;
      FileCommentLength := 0;
      DiskNumberStart := 0;
      InternalFileAttributes := 0;
//      ExternalFileAttributes := 0;
      RelativeOffsetOfLocalHeader := 0;
      filename := Files[i].filename;
      extrafield := Files[i].extrafield;
      fileComment := '';
    end;
  finally
    compressedStream.Free;
  end;
end;

procedure TZipFile.AddFile(const name: string; FAttribute: DWord=0);
begin
    SetLength(Files, High(Files) + 2);
    SetLength(CentralDirectory, length(Files));
    Files[High(Files)].filename := name;
    Files[High(Files)].CompressedData := ''; //start with an empty file
    Files[High(Files)].extrafield := '';
    Files[High(Files)].LocalFileHeaderSignature := $04034B50;
    with Files[High(Files)].CommonFileHeader do
    begin
        VersionNeededToExtract := 20;
        GeneralPurposeBitFlag := 0;
        CompressionMethod := 8;
        LastModFileTimeDate := DateTimeToFileDate(Now);
        Crc32 := 0;
        CompressedSize := 0;
        UncompressedSize := 0;
        FilenameLength := length(Files[High(Files)].filename);
        ExtraFieldLength := length(Files[High(Files)].extrafield);
    end;

  with CentralDirectory[High(Files)] do
  begin
    CentralFileHeaderSignature := $02014B50;
    VersionMadeBy := 20;
    CommonFileHeader := Files[High(Files)].CommonFileHeader;
    FileCommentLength := 0;
    DiskNumberStart := 0;
    InternalFileAttributes := 0;
    ExternalFileAttributes := FAttribute;
    RelativeOffsetOfLocalHeader := 0;
    filename := Files[High(Files)].filename;
    extrafield := Files[High(Files)].extrafield;
    fileComment := '';
  end;
end;

function TZipFile.GetDateTime(i: integer): TDateTime;
begin
  if i>High(Files) then // begin Result:=0; exit; end;
    raise Exception.Create('Index out of range.');
  result := FileDateToDateTime(Files[i].CommonFileHeader.LastModFileTimeDate);
end;

procedure TZipFile.SetDateTime(i: integer; const Value: TDateTime);
begin
 if i>High(Files) then //exit;
    raise Exception.Create('Index out of range.');
 Files[i].CommonFileHeader.LastModFileTimeDate:=DateTimeToFileDate(Value);
end;

function TZipFile.GetCount: integer;
begin
  Result:=High(Files)+1;
end;

function TZipFile.GetName(i: integer): string;
begin
  Result:=Files[i].filename;
end;

procedure TZipFile.SetName(i: integer; const Value: string);
begin
 Files[i].filename:=Value;
end;


{ ZipCRC32 }

//calculates the zipfile CRC32 value from a string

function ZipCRC32(const Data:string):  longword;
const
  CRCtable: array[0..255] of DWORD = (
 $00000000, $77073096, $EE0E612C, $990951BA, $076DC419, $706AF48F, $E963A535, $9E6495A3, $0EDB8832, $79DCB8A4,
 $E0D5E91E, $97D2D988, $09B64C2B, $7EB17CBD, $E7B82D07, $90BF1D91, $1DB71064, $6AB020F2, $F3B97148, $84BE41DE,
 $1ADAD47D, $6DDDE4EB, $F4D4B551, $83D385C7, $136C9856, $646BA8C0, $FD62F97A, $8A65C9EC, $14015C4F, $63066CD9,
 $FA0F3D63, $8D080DF5, $3B6E20C8, $4C69105E, $D56041E4, $A2677172, $3C03E4D1, $4B04D447, $D20D85FD, $A50AB56B,
 $35B5A8FA, $42B2986C, $DBBBC9D6, $ACBCF940, $32D86CE3, $45DF5C75, $DCD60DCF, $ABD13D59, $26D930AC, $51DE003A,
 $C8D75180, $BFD06116, $21B4F4B5, $56B3C423, $CFBA9599, $B8BDA50F, $2802B89E, $5F058808, $C60CD9B2, $B10BE924,
 $2F6F7C87, $58684C11, $C1611DAB, $B6662D3D, $76DC4190, $01DB7106, $98D220BC, $EFD5102A, $71B18589, $06B6B51F,
 $9FBFE4A5, $E8B8D433, $7807C9A2, $0F00F934, $9609A88E, $E10E9818, $7F6A0DBB, $086D3D2D, $91646C97, $E6635C01,
 $6B6B51F4, $1C6C6162, $856530D8, $F262004E, $6C0695ED, $1B01A57B, $8208F4C1, $F50FC457, $65B0D9C6, $12B7E950,
 $8BBEB8EA, $FCB9887C, $62DD1DDF, $15DA2D49, $8CD37CF3, $FBD44C65, $4DB26158, $3AB551CE, $A3BC0074, $D4BB30E2,
 $4ADFA541, $3DD895D7, $A4D1C46D, $D3D6F4FB, $4369E96A, $346ED9FC, $AD678846, $DA60B8D0, $44042D73, $33031DE5,
 $AA0A4C5F, $DD0D7CC9, $5005713C, $270241AA, $BE0B1010, $C90C2086, $5768B525, $206F85B3, $B966D409, $CE61E49F,
 $5EDEF90E, $29D9C998, $B0D09822, $C7D7A8B4, $59B33D17, $2EB40D81, $B7BD5C3B, $C0BA6CAD, $EDB88320, $9ABFB3B6,
 $03B6E20C, $74B1D29A, $EAD54739, $9DD277AF, $04DB2615, $73DC1683, $E3630B12, $94643B84, $0D6D6A3E, $7A6A5AA8,
 $E40ECF0B, $9309FF9D, $0A00AE27, $7D079EB1, $F00F9344, $8708A3D2, $1E01F268, $6906C2FE, $F762575D, $806567CB,
 $196C3671, $6E6B06E7, $FED41B76, $89D32BE0, $10DA7A5A, $67DD4ACC, $F9B9DF6F, $8EBEEFF9, $17B7BE43, $60B08ED5,
 $D6D6A3E8, $A1D1937E, $38D8C2C4, $4FDFF252, $D1BB67F1, $A6BC5767, $3FB506DD, $48B2364B, $D80D2BDA, $AF0A1B4C,
 $36034AF6, $41047A60, $DF60EFC3, $A867DF55, $316E8EEF, $4669BE79, $CB61B38C, $BC66831A, $256FD2A0, $5268E236,
 $CC0C7795, $BB0B4703, $220216B9, $5505262F, $C5BA3BBE, $B2BD0B28, $2BB45A92, $5CB36A04, $C2D7FFA7, $B5D0CF31,
 $2CD99E8B, $5BDEAE1D, $9B64C2B0, $EC63F226, $756AA39C, $026D930A, $9C0906A9, $EB0E363F, $72076785, $05005713,
 $95BF4A82, $E2B87A14, $7BB12BAE, $0CB61B38, $92D28E9B, $E5D5BE0D, $7CDCEFB7, $0BDBDF21, $86D3D2D4, $F1D4E242,
 $68DDB3F8, $1FDA836E, $81BE16CD, $F6B9265B, $6FB077E1, $18B74777, $88085AE6, $FF0F6A70, $66063BCA, $11010B5C,
 $8F659EFF, $F862AE69, $616BFFD3, $166CCF45, $A00AE278, $D70DD2EE, $4E048354, $3903B3C2, $A7672661, $D06016F7,
 $4969474D, $3E6E77DB, $AED16A4A, $D9D65ADC, $40DF0B66, $37D83BF0, $A9BCAE53, $DEBB9EC5, $47B2CF7F, $30B5FFE9,
 $BDBDF21C, $CABAC28A, $53B39330, $24B4A3A6, $BAD03605, $CDD70693, $54DE5729, $23D967BF, $B3667A2E, $C4614AB8,
 $5D681B02, $2A6F2B94, $B40BBE37, $C30C8EA1, $5A05DF1B, $2D02EF8D);
var
  i: integer;
begin
  result := $FFFFFFFF;
  for i := 0 to length(Data) - 1 do
    result := (result shr 8) xor (CRCtable[byte(result) xor Ord(Data[i+1])]);
  result := result xor $FFFFFFFF;
end;



end.

