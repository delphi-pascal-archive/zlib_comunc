program PasZlibFile;

uses
  Forms,
  UCompressFile in 'UCompressFile.pas' {FCompressFile},
  UtilityPasZlib in 'UtilityPasZlib.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TFCompressFile, FCompressFile);
  Application.Run;
end.
