unit golyo;

interface

uses
  classes, graphics, controls, forms;

type
  TGolyo = class (TObject)
    private
      canvas:TCanvas;
      x,y,r:integer;
      color,border:TColor;
      text:string;
      visible:boolean;
    public
      constructor create;
      procedure show;
      procedure hide;
      procedure setCanvas(canvas:TCanvas);
      procedure setX(x:integer);
      procedure setY(y:integer);
      procedure setR(r:integer);
      procedure setColors(color,border:TColor);
      procedure setText(text:String);
      function getX:integer;
      function getY:integer;
      function getR:integer;
      function getVisible:boolean;
  end;

implementation

constructor TGolyo.create;
begin
  x:=0;
  y:=0;
  r:=0;
  color:=clSkyBlue;
  border:=clNavy;
  text:='';
  visible:=false;
end;

procedure TGolyo.setX(x:integer);
begin
  self.x:=x;
end;

procedure TGolyo.setY(y:integer);
begin
  self.y:=y;
end;

procedure TGolyo.setCanvas(canvas:TCanvas);
begin
  self.canvas:=canvas;
end;

procedure TGolyo.setColors(color,border:TColor);
begin
  self.color:=color;
  self.border:=border;
end;

function TGolyo.getVisible:boolean;
begin
  getVisible:=visible;
end;

function TGolyo.getX:integer;
begin
  getX:=x;
end;

function TGolyo.getR:integer;
begin
  getR:=r;
end;

function TGolyo.getY:integer;
begin
  getY:=y;
end;

procedure TGolyo.show;
begin
  canvas.brush.color:=color;
  canvas.pen.color:=border;
  canvas.brush.style:=bsSolid;
  canvas.pen.style:=psSolid;
  canvas.ellipse(x,y,x+r,y+r);
  if (color=clBlack)or(color=clNavy) then
    canvas.font.Color:=clWhite
  else
    canvas.font.Color:=clBlack;
  canvas.textOut(x+(r div 2)-3,y+(r div 3),text);
  visible:=true;
end;

procedure TGolyo.hide;
begin
  canvas.brush.color:=clBtnFace;
  canvas.pen.color:=clBtnFace;
  canvas.ellipse(x,y,x+r,y+r);
  visible:=false;
end;

procedure TGolyo.setR(r:integer);
begin
  self.r:=r;
end;

procedure TGolyo.setText(text:string);
begin
  self.text:=text;
end;

end.
