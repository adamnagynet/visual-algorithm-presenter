unit Korongok;

interface

uses
  classes, graphics, controls, forms, StackInt;

type
  TKorong = class (TObject)
    private
      canvas:TCanvas;
      x,y,n,h,m,sz,index:integer;
    public
      constructor create;
      procedure show(stack:TStackInt);
      procedure setCanvas(canvas:TCanvas);
      procedure setX(x:integer);
      procedure setY(y:integer);
      procedure setH(h:integer);
      procedure setM(m:integer);
      procedure setSz(sz:integer);
      procedure setIndex(index:integer);
      function getX:integer;
      function getY:integer;
      function getH:integer;
      function getM:integer;
      function getIndex:integer;
  end;

implementation

constructor Tkorong.create;
begin
  x:=0;
  y:=0;
  h:=0;
  m:=0;
  sz:=0;
  n:=0;
end;

procedure Tkorong.setX(x:integer);
begin
  self.x:=x;
end;

procedure Tkorong.setH(h:integer);
begin
  self.h:=h;
end;

procedure Tkorong.setM(m:integer);
begin
  self.m:=m;
end;

procedure Tkorong.setY(y:integer);
begin
  self.y:=y;
end;

procedure Tkorong.setSz(sz:integer);
begin
  self.Sz:=sz;
end;

procedure Tkorong.setIndex(index:integer);
begin
  self.index:=index;
end;

procedure Tkorong.setCanvas(canvas:TCanvas);
begin
  self.canvas:=canvas;
end;

function Tkorong.getX:integer;
begin
  getX:=x;
end;

function Tkorong.getIndex:integer;
begin
  getIndex:=index;
end;

function Tkorong.getH:integer;
begin
  geth:=h;
end;

function Tkorong.gety:integer;
begin
  gety:=y;
end;

function Tkorong.getM:integer;
begin
  getM:=m;
end;

procedure Tkorong.show(stack:TStackInt);
var
  i,r:integer;

begin
  canvas.pen.Color:=clBlack;
  canvas.pen.Style:=psSolid;
  canvas.moveto(x,y);
  canvas.lineto(x,y+h-m);
  if index=1 then
    canvas.brush.color:=clGray
  else
    if index=2 then
      canvas.brush.color:=clSilver
    else
      canvas.brush.color:=$009FDCE1;
  canvas.brush.Style:=bsSolid;
  canvas.roundRect(x-m, h-m, x+m, h,m div 2, m div 2);
  canvas.brush.color:=clCream;
  canvas.pen.Color:=clNavy;
  for i:=0 to stack.size do begin
    r:=stack.elementAt(i);
    canvas.roundRect(x-(r div 2) , h-(i+2)*m, x+(r div 2) , h-(i+1)*m ,m div 2, m div 2);
    //200 =  drawpanel.height;
  end;
end;


end.
