unit UCompressFile;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls;

type
  TFCompressFile = class(TForm)
    EditFile: TEdit;
    cmdCompress: TButton;
    lblFile: TLabel;
    SbFile: TSpeedButton;
    OpenDialog: TOpenDialog;
    cmbLevel: TComboBox;
    lblLevel: TLabel;
    cmdUncompress: TButton;
    procedure cmdCompressClick(Sender: TObject);
    procedure SbFileClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cmdUncompressClick(Sender: TObject);
  private
    { Private declarations }
    gsExePath : string;
  public
    { Public declarations }
  end;

var
  FCompressFile: TFCompressFile;

implementation

{$R *.dfm}

uses UtilityPasZlib;

procedure TFCompressFile.SbFileClick(Sender: TObject);
var
 sPath: string;
begin
 with OpenDialog do
  begin
   DefaultExt:='';
   Options:=[ofFileMustExist];
   sPath:=ExtractFilePath(EditFile.Text);
   if sPath=''
   then sPath:=gsExePath;
   InitialDir:=sPath;
   FileName:='';
   if Execute
   then
    begin
     if UpperCase(gsExePath)=UpperCase(ExtractFilePath(FileName))
     then EditFile.Text:=ExtractFileName(FileName)
     else EditFile.Text:=FileName;
    end;
  end;
end;

procedure TFCompressFile.FormCreate(Sender: TObject);
begin
 gsExePath:=ExtractFilePath(Application.ExeName);
end;

function CutExt(s: string): string;
begin
 Result:=Copy(s,1,length(s)-length(ExtractFileExt(s)));
end;

procedure TFCompressFile.cmdCompressClick(Sender: TObject);
var
 sFilename: string;
 Level: TCompLevel;
begin
 Screen.Cursor:=crHourGlass;
 Level:=clDefault;
 try
  sFilename:=trim(EditFile.Text);
  if sFilename<>''
  then
   begin
    if cmbLevel.Text='Fastest'
    then Level:=clNone
    else
     if cmbLevel.Text='Max'
     then Level:=clMax;
    CompressFile(sFilename,sFilename+'.zip',Level);
    ShowMessage('File successfully compressed!');
   end;
 finally
  Screen.Cursor:=crDefault;
 end;
end;

procedure TFCompressFile.cmdUncompressClick(Sender: TObject);
var
 sFilename, sDestFile: string;
begin
 Screen.Cursor:=crHourGlass;
 try
  sFilename:=trim(EditFile.Text);
  if sFilename<>''
  then
   begin
    sDestFile:=sFilename;
    if UpperCase(ExtractFileExt(sFileName))<>'.ZIP'
    then
     begin
      sDestFile:=sFilename;
      sFilename:=sDestFile+'.zip';
     end
    else sDestFile:=CutExt(sFilename);
    UnCompressFile(sFilename,sDestFile);
    ShowMessage('File successfully uncompressed!');    
   end;
 finally
  Screen.Cursor := crDefault;
 end;
end;

end.
