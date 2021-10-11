unit UtilityPasZlib;

// by Andrea Russo - Italy - 2005
// email: andrusso@libero.it

interface

//Unit zlib is icluded into the latest version of Delphi (from Delphi 6), but in old versions is
//included into the Delphi cd.
// Otherwise if do you want to use paszlib library change the uses.

//If do you want to use zlib included into Delphi

uses zlib, Classes;

//If do you want to use paszlib library
//uses dzlib, Classes;

type TCompLevel = (clNone, clFastest, clDefault, clMax);

procedure CompressFile(const sFileIn : string; const sFileOut : string; const Level : TCompLevel = clDefault);
procedure UnCompressFile(const sFileIn : string; const sFileOut : string);

procedure CompressStream(inStream, outStream :TStream; const Level : TCompLevel = clDefault);
procedure ExpandStream(inStream, outStream :TStream);

implementation

procedure CompressFile(const sFileIn : string; const sFileOut : string; const Level : TCompLevel = clDefault);
var
 inStream, outStream: TMemoryStream;
begin
 inStream:=TMemoryStream.Create;
 outStream:=TMemoryStream.Create;
 try
  inStream.LoadFromFile(sFileIn);
  with TCompressionStream.Create(TCompressionLevel(Level), outStream) do
   try
    CopyFrom(inStream, inStream.Size);
   finally
    Free;
   end;
   outStream.SaveToFile(sFileOut);
  finally
   outStream.Free;
   inStream.Free;
  end;
end;

procedure UnCompressFile(const sFileIn : string; const sFileOut : string);
var
 inStream, outStream: TMemoryStream;
begin
 inStream:=TMemoryStream.Create;
 outStream:=TMemoryStream.Create;
 try
  inStream.LoadFromFile(sFileIn);
  ExpandStream(inStream, outStream);
  outStream.SaveToFile(sFileOut);
 finally
  inStream.Free;
  outStream.Free;
 end;
end;

procedure CompressStream(inStream, outStream :TStream; const Level : TCompLevel = clDefault);
begin
 with TCompressionStream.Create(TCompressionLevel(Level), outStream) do
  try
   CopyFrom(inStream, inStream.Size);
  finally
   Free;
  end;
end;

procedure ExpandStream(inStream, outStream :TStream);
const
 BufferSize = 4096;
var
 Count: integer;
 ZStream: TDecompressionStream;
 Buffer: array[0..BufferSize-1] of Byte;
begin
 ZStream:=TDecompressionStream.Create(InStream);
 try
  while true do
   begin
    Count:=ZStream.Read(Buffer, BufferSize);
    if Count<>0
    then OutStream.WriteBuffer(Buffer, Count)
    else Break;
   end;
  finally
   ZStream.Free;
  end;
end;

end.
