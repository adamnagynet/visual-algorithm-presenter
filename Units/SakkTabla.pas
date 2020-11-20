unit SakkTabla;

interface

uses
  Classes, Graphics, Controls, Forms;

type
  TSakkTabla = class(TObject)
    private
      canvas:TCanvas;
      x,y,d,nr,r:integer;
      x1,y1,x2,y2,x3,y3,x4,y4,x5,y5,x6,y6,x7,y7,x8,y8:integer;
      light,dark:TColor;
    public
      constructor create;
      procedure show;
      procedure hide(a:integer);
      procedure setCanvas(canvas:TCanvas);
      procedure setNr(Nr:integer);
      procedure setX(x:integer);
      procedure setY(y:integer);
      procedure setD(d:integer);
      procedure setColors(light,dark:TColor);
      procedure set4Queens(x1,y1,x2,y2,x3,y3,x4,y4:integer);
      procedure set8Queens(x1,y1,x2,y2,x3,y3,x4,y4,x5,y5,x6,y6,x7,y7,x8,y8:integer);
      function getNr:integer;
      function getX:integer;
      function getY:integer;
      function getD:integer;
end;

implementation

constructor TSakkTabla.create;
begin
  x:=0;
  y:=0;
  d:=0;
  nr:=4;
  x1:=0; y1:=0;
  x2:=0; y2:=0;
  x3:=0; y3:=0;
  x4:=0; y4:=0;
  light:=clCream;
  dark:=clGray;
end;

procedure TSakkTabla.setNr(nr:integer);
begin
  self.nr:=nr;
end;

procedure TSakkTabla.setX(x:integer);
begin
  self.x:=x;
end;

procedure TSakkTabla.setY(y:integer);
begin
  self.y:=y;
end;

procedure TSakkTabla.setCanvas(canvas:TCanvas);
begin
  self.canvas:=canvas;
end;

procedure TSakkTabla.setColors(light,dark:TColor);
begin
  self.light:=light;
  self.dark:=dark;
end;

procedure TSakkTabla.set4Queens(x1,y1,x2,y2,x3,y3,x4,y4:integer);
begin
  self.x1:=x1;
  self.y1:=y1;
  self.x2:=x2;
  self.y2:=y2;
  self.x3:=x3;
  self.y3:=y3;
  self.x4:=x4;
  self.y4:=y4;
end;

procedure TSakkTabla.set8Queens(x1,y1,x2,y2,x3,y3,x4,y4,x5,y5,x6,y6,x7,y7,x8,y8:integer);
begin
  self.x1:=x1;
  self.y1:=y1;
  self.x2:=x2;
  self.y2:=y2;
  self.x3:=x3;
  self.y3:=y3;
  self.x4:=x4;
  self.y4:=y4;
  self.x5:=x5;
  self.y5:=y5;
  self.x6:=x6;
  self.y6:=y6;
  self.x7:=x7;
  self.y7:=y7;
  self.x8:=x8;
  self.y8:=y8;
end;

function TSakkTabla.getX:integer;
begin
  getX:=x;
end;

function TSakkTabla.getD:integer;
begin
  getD:=d;
end;

function TSakkTabla.getY:integer;
begin
  getY:=y;
end;

function TSakkTabla.getNr:integer;
begin
  getNr:=Nr;
end;

procedure TSakkTabla.show;
var
  i,j:integer;
begin
  canvas.brush.style:=bsSolid;
  canvas.pen.style:=psClear;
  canvas.brush.color:=clBlack;
  canvas.pen.color:=clBlack;
  canvas.Rectangle(x-1, y-1, x+nr*d+1, y+nr*d+1);      
  r:=d-2*7;
  for i:=1 to nr do begin
    for j:=1 to nr do begin
      if (i+j) mod 2 = 0 then begin
        canvas.brush.color:=light;
        canvas.pen.color:=clBlack;
      end else begin
        canvas.brush.color:=dark;
        canvas.pen.color:=clBlack;
      end;
      canvas.Rectangle(x+(i-1)*d, y+(j-1)*d, x+i*d, y+j*d);
      if ((i=x1)and(j=y1)) or ((i=x2)and(j=y2)) or ((i=x3)and(j=y3)) or ((i=x4)and(j=y4)) or ((i=x5)and(j=y5)) or ((i=x6)and(j=y6)) or ((i=x7)and(j=y7)) or ((i=x8)and(j=y8)) then begin
        canvas.brush.color:=$00D9D9FF;
        canvas.pen.color:=clMaroon;
        canvas.brush.style:=bsSolid;
        canvas.pen.style:=psSolid;
        canvas.ellipse(x+(i-1)*d+7,y+(j-1)*d+7,x+(i-1)*d+7+r,y+(j-1)*d+7+r);
        canvas.pen.style:=psClear;
      end;
    end;
  end;
end;

procedure TSakkTabla.hide(a:integer);
begin
  canvas.brush.Color:=clBtnFace;
  Canvas.Pen.Color := clBtnFace;
  canvas.brush.style:=bsSolid;
  canvas.pen.style:=psClear;
  canvas.Rectangle(x-1, y-1, x+nr*d+1, y+nr*d+1);
end;

procedure TSakkTabla.setD(d:integer);
begin
  self.d:=d;
end;

end.
