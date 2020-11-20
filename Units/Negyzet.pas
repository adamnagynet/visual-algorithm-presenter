unit Negyzet;

interface

uses
  Classes, Graphics, Controls, Forms;

type
  TNegyzet = class(TObject)
    private
      canvas:TCanvas;
      x,y,d:integer;
      color,border:TColor;
      text:String;
    public
      constructor create;
      procedure show;
      procedure hide;
      procedure setCanvas(canvas:TCanvas);
      procedure setX(x:integer);
      procedure setY(y:integer);
      procedure setD(d:integer);
      procedure setColors(color,border:TColor);
      procedure setText(text:String);
      function getX:integer;
      function getY:integer;
      function getD:integer;
      function getColor:TColor;
  end;

implementation

constructor TNegyzet.create;
begin
  x:=0;
  y:=0;
  d:=0;
  color:=clMoneyGreen;
  border:=clTeal;
  text:='';
end;

procedure TNegyzet.setX(x:integer);
begin
  self.x:=x;
end;

procedure TNegyzet.setY(y:integer);
begin
  self.y:=y;
end;

procedure TNegyzet.setCanvas(canvas:TCanvas);
begin
  self.canvas:=canvas;
end;

procedure TNegyzet.setColors(color,border:TColor);
begin
  self.color:=color;
  self.border:=border;
end;

function TNegyzet.getX:integer;
begin
  getX:=x;
end;

function TNegyzet.getColor:TColor;
begin
  getColor:=Color;
end;

function TNegyzet.getY:integer;
begin
  getY:=y;
end;

function TNegyzet.getd:integer;
begin
  getD:=d;
end;

procedure TNegyzet.show;
begin
  canvas.brush.color:=color;
  canvas.pen.Color:=border;
  canvas.brush.Style:=bsSolid;
  canvas.pen.Style:=psSolid;
  canvas.roundRect(x, y, x+d, y+d, d div 2, d div 2);
  if (color=clBlack)or(color=clNavy) then
    canvas.font.Color:=clWhite
  else
    canvas.font.Color:=clBlack;
  canvas.textOut(x+(d div 3)+3,y+(d div 3),text);
end;

procedure TNegyzet.hide;
begin
  canvas.brush.Color:=clBtnFace;
  Canvas.Pen.Color:=clBtnFace;
  Canvas.RoundRect(x, y, x+d, x+d, d div 2, d div 2);
end;

procedure TNegyzet.setD(d:integer);
begin
  self.d:=d;
end;

procedure TNegyzet.setText(text:string);
begin
  self.text:=text;
end;

end.
