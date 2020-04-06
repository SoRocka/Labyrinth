    unit Main;

interface

uses
  Windows, Graphics, Forms, Dialogs, ExtCtrls, StdCtrls, Controls, Classes;

const
  WALL=-1;
  BLANK=-2;
  DEADBLOCK=-3;

type
  TForm1 = class(TForm)
    Button1: TButton;
    OpenDialog1: TOpenDialog;
    Output: TImage;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  N:integer=600;
  LABIRINT:array[0..600,0..600] of integer;

implementation

{$R *.dfm}

procedure genBitmap;
var bit:TBitmap;
    i,j:Integer;
    Output: TImage;
begin
bit:=TBitmap.Create;
bit.Width:=N+1;
bit.Height:=N+1;

for i:=0 to N do
  for j:=0 to N do
    begin
    if LABIRINT[i,j]=BLANK then bit.Canvas.Pixels[i,j]:=clWhite //
      else
        if LABIRINT[i,j]=WALL then bit.Canvas.Pixels[i,j]:=clBlack
          else bit.Canvas.Pixels[i,j]:=clRed;
    end;

  //Output.Canvas.Draw(0,0,bit); Выдаёт ошибку и я не понимаю, как её исправить;
  
  Form1.Canvas.Draw(24,80,bit);
  bit.SaveToFile('output.bmp');
  bit.Free;
end;

procedure rebuildArr2;
var i,j:integer;
begin
for i:=0 to ((N div 3) ) do
  for j:=0 to ((N div 3) ) do
    LABIRINT[i,j]:=LABIRINT[i*3,j*3];
N:=N div 3;
end;

procedure setBlankAsDeadblockRec(x,y:integer);
var k:integer;
begin
k:=0;
if LABIRINT[x,y]=blank then
  begin
  if LABIRINT[x-1,y]<>BLANK then k:=k+1;
  if LABIRINT[x,y-1]<>BLANK then k:=k+1;
  if LABIRINT[x+1,y]<>BLANK then k:=k+1;
  if LABIRINT[x,y+1]<>BLANK then k:=k+1;

  if k=4 then LABIRINT[x,y]:=DEADBLOCK;


  if k=3 then
    begin
    LABIRINT[x,y]:=DEADBLOCK;
    if LABIRINT[x-1,y]=BLANK then setBlankAsDeadblockRec(x-1,y);
    if LABIRINT[x,y-1]=BLANK then setBlankAsDeadblockRec(x,y-1);
    if LABIRINT[x+1,y]=BLANK then setBlankAsDeadblockRec(x+1,y);
    if LABIRINT[x,y+1]=BLANK then setBlankAsDeadblockRec(x,y+1);
    end;
  end;
end;

procedure setDeadblock;
var i,j:integer;
begin
for i:=1 to N-1 do
  for j:=1 to N-1 do
    setBlankAsDeadblockRec(i,j);
end;

procedure TForm1.Button1Click(Sender: TObject);
var bit:TBitmap;
    i,j:integer;
begin
bit:=TBitmap.Create;
If OpenDialog1.Execute then
  begin
  bit.LoadFromFile(OpenDialog1.FileName);
  for i:=0 to N do
    for j:=0 to N do
      if bit.Canvas.Pixels[j,i]=clWhite then
        LABIRINT[j,i]:=BLANK else LABIRINT[j,i]:=WALL;
  bit.Free;

  setDeadblock;
  genBitmap;
  end;
end;
end.
