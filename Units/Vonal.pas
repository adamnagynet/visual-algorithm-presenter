unit Vonal;

interface

uses
  Classes, Graphics, Controls, Forms, sysutils, animacio;

type
  TVonal = class(TObject)
    private
      canvas:TCanvas;
      x,y,tx,ty:integer;
      color:TColor;
      dtime:integer;
      linetype:string;
    public
      constructor create;
      procedure showyx;
      procedure hideyx;
      procedure showxy;
      procedure hidexy;
      procedure showbum(dist:integer);
      procedure hidebum(dist:integer);
      procedure showz;
      procedure hidez;
      procedure setDelay(dtime:integer);
      procedure setCanvas(canvas:TCanvas);
      procedure setCoord(x,y,tx,ty:integer);
      procedure setColor(color:TColor);
      procedure setLineType(linetype:string);
      function getX:integer;
      function getY:integer;
      function getTX:integer;
      function getTy:integer;
      function getLineType:string;
  end;

implementation

constructor TVonal.create;
begin
  x:=0;
  y:=0;
  tx:=0;
  ty:=0;
  color:=clBlack;
  linetype:='yx';
end;

procedure TVonal.setCanvas(canvas:TCanvas);
begin
  self.canvas:=canvas;
end;

procedure TVonal.setLineType(linetype:string);
begin
  self.linetype:=linetype;
end;

procedure TVonal.setCoord(x,y,tx,ty:integer);
begin
  self.x:=x;
  self.y:=y;
  self.tx:=tx;
  self.ty:=ty;
end;

procedure TVonal.setDelay(dtime:integer);
begin
  self.dtime:=dtime;
end;

procedure TVonal.setColor(color:TColor);
begin
  self.color:=color;
end;

function TVonal.getX:integer;
begin
  getX:=x;
end;

function TVonal.getY:integer;
begin
  getY:=y;
end;

function TVonal.getlinetype:string;
begin
  getlinetype:=linetype;
end;

function TVonal.getTX:integer;
begin
  getTX:=tx;
end;

function TVonal.getTY:integer;
begin
  getTY:=Ty;
end;

procedure TVonal.showyx;
var
  i:integer;
begin
  canvas.brush.color:=color;
  Canvas.Pen.Color:=color;
  //Canvas.Brush.Style:=bsSolid;
  //Canvas.Pen.Style:=psSolid;

  //------------------------------------
  if ty>=y then
    for i:=y to ty do begin
      Canvas.MoveTo(x,y);
      Canvas.lineTo(x,i);
      sleep(dtime);
    end
  else
    for i:=y downto ty do begin
      Canvas.MoveTo(x,y);
      Canvas.lineTo(x,i);
      sleep(dtime);
    end;
  //------------------------------------
  if tx>=x then
    for i:=x to tx do begin
      Canvas.MoveTo(x,ty);
      Canvas.lineTo(i,ty);
      sleep(dtime);
    end
  else
    for i:=x downto tx do begin
      Canvas.MoveTo(x,ty);
      Canvas.lineTo(i,ty);
      sleep(dtime);
    end;
end;

procedure TVonal.showxy;
var
  i:integer;
begin
  canvas.brush.color:=color;
  Canvas.Pen.Color:=color;
  if tx>=x then
    for i:=x to tx do begin
      Canvas.MoveTo(x,y);
      Canvas.lineTo(i,y);
      sleep(dtime);
    end
  else
    for i:=x downto tx do begin
      Canvas.MoveTo(x,y);
      Canvas.lineTo(i,y);
      sleep(dtime);
    end;
  //------------------------------------
  if ty>=y then
    for i:=y to ty do begin
      Canvas.MoveTo(tx,y);
      Canvas.lineTo(tx,i);
      sleep(dtime);
    end
  else
    for i:=y downto ty do begin
      Canvas.MoveTo(tx,y);
      Canvas.lineTo(tx,i);
      sleep(dtime);
    end;
end;

procedure TVonal.showbum(dist:integer);
var
  i:integer;
begin
  canvas.brush.color:=color;
  canvas.pen.Color:=color;
  if (dist+y)>=y then
    for i:=y to (dist+y) do begin
      canvas.moveTo(x,y);
      canvas.lineTo(x,i);
      sleep(dtime);
    end
  else
    for i:=y downto (dist+y) do begin
      Canvas.MoveTo(x,y);
      Canvas.lineTo(x,i);
      sleep(dtime);
    end;

  //------------------------------------

  if tx>=x then
    for i:=x to tx do begin
      Canvas.MoveTo(x,dist+y);
      Canvas.lineTo(i,dist+y);
      sleep(dtime);
    end
  else
    for i:=x downto tx do begin
      Canvas.MoveTo(x,dist+y);
      Canvas.lineTo(i,dist+y);
      sleep(dtime);
    end;

  //------------------------------------

  if ty>=(y+dist) then
    for i:=(y+dist) to ty do begin
      Canvas.MoveTo(tx,(y+dist));
      Canvas.lineTo(tx,i);
      sleep(dtime);
    end
  else
    for i:=(y+dist) downto ty do begin
      Canvas.MoveTo(tx,(y+dist));
      Canvas.lineTo(tx,i);
      sleep(dtime);
    end;
end;

procedure TVonal.showz;
var
  i,half:integer;
begin
  canvas.brush.color:=clRed;
  canvas.pen.Color:=color;
  
  half:=(abs(y - ty)) div 2;
  if ty>=y then
    for i:=y to (ty-half) do begin
      Canvas.MoveTo(x,y);
      Canvas.lineTo(x,i);
      sleep(dtime);
    end
  else
    for i:=y downto (ty+half) do begin
      Canvas.MoveTo(x,y);
      Canvas.lineTo(x,i);
      sleep(dtime);
    end;

  if tx>=x then
    if ty>=y then
      for i:=x to tx do begin
        Canvas.MoveTo(x,(ty-half));
        Canvas.lineTo(i,(ty-half));
        sleep(dtime);
      end
    else
      for i:=x to tx do begin
        Canvas.MoveTo(x,(ty+half));
        Canvas.lineTo(i,(ty+half));
        sleep(dtime);
      end
  else
    if ty>=y then
      for i:=x downto tx do begin
        Canvas.MoveTo(x,(ty-half));
        Canvas.lineTo(i,(ty-half));
        sleep(dtime);
      end
    else
      for i:=x downto tx do begin
        Canvas.MoveTo(x,(ty+half));
        Canvas.lineTo(i,(ty+half));
        sleep(dtime);
      end;
      
  if ty>=y then
    for i:=(ty-half) to ty do begin
      Canvas.MoveTo(tx,(ty-half));
      Canvas.lineTo(tx,i);
      sleep(dtime);
    end
  else
    for i:=(ty+half) downto ty do begin
      Canvas.MoveTo(tx,(ty+half));
      Canvas.lineTo(tx,i);
      sleep(dtime);
    end;  
end;

procedure TVonal.hideyx;
var
  i:integer;
begin
  canvas.brush.Color:=clBtnFace;
  Canvas.Pen.Color := clBtnFace;
  Canvas.Pen.Style:=psSolid;
  //------------------------------------
  if ty>=y then
    for i:=y to ty do begin
      Canvas.MoveTo(x,y);
      Canvas.lineTo(x,i);
      sleep(dtime);
    end
  else
    for i:=y downto ty do begin
      Canvas.MoveTo(x,y);
      Canvas.lineTo(x,i);
      sleep(dtime);
    end;
  //------------------------------------
  if tx>=x then
    for i:=x to tx do begin
      Canvas.MoveTo(x,ty);
      Canvas.lineTo(i,ty);
      sleep(dtime);
    end
  else
    for i:=x downto tx do begin
      Canvas.MoveTo(x,ty);
      Canvas.lineTo(i,ty);
      sleep(dtime);
    end;
end;

procedure TVonal.hidexy;
var
  i:integer;
begin
  canvas.brush.Color:=clBtnFace;
  Canvas.Pen.Color := clBtnFace;
  Canvas.Pen.Style:=psSolid;
  //------------------------------------
  if tx>=x then
    for i:=x to tx do begin
      Canvas.MoveTo(x,y);
      Canvas.lineTo(i,y);
      sleep(dtime);
    end
  else
    for i:=x downto tx do begin
      Canvas.MoveTo(x,y);
      Canvas.lineTo(i,y);
      sleep(dtime);
    end;
  //------------------------------------
  if ty>=y then
    for i:=y to ty do begin
      Canvas.MoveTo(tx,y);
      Canvas.lineTo(tx,i);
      sleep(dtime);
    end
  else
    for i:=y downto ty do begin
      Canvas.MoveTo(tx,y);
      Canvas.lineTo(tx,i);
      sleep(dtime);
    end;
end;

procedure TVonal.hidebum(dist:integer);
var
  i:integer;
begin
  canvas.brush.Color:=clBtnFace;
  Canvas.Pen.Color := clBtnFace;
  Canvas.Pen.Style:=psSolid;
  if (dist+y)>=y then
    for i:=y to (dist+y) do begin
      canvas.moveTo(x,y);
      canvas.lineTo(x,i);
      sleep(dtime);
    end
  else
    for i:=y downto (dist+y) do begin
      Canvas.MoveTo(x,y);
      Canvas.lineTo(x,i);
      sleep(dtime);
    end;

  //------------------------------------

  if tx>=x then
    for i:=x to tx do begin
      Canvas.MoveTo(x,dist+y);
      Canvas.lineTo(i,dist+y);
      sleep(dtime);
    end
  else
    for i:=x downto tx do begin
      Canvas.MoveTo(x,dist+y);
      Canvas.lineTo(i,dist+y);
      sleep(dtime);
    end;

  //------------------------------------

  if ty>=(y+dist) then
    for i:=(y+dist) to ty do begin
      Canvas.MoveTo(tx,(y+dist));
      Canvas.lineTo(tx,i);
      sleep(dtime);
    end
  else
    for i:=(y+dist) downto ty do begin
      Canvas.MoveTo(tx,(y+dist));
      Canvas.lineTo(tx,i);
      sleep(dtime);
    end;
end;

procedure TVonal.hidez;
var
  i,half:integer;
begin
  canvas.brush.Color:=clBtnFace;
  Canvas.Pen.Color := clBtnFace;
  Canvas.Pen.Style:=psSolid;
  half:=(abs(y - ty)) div 2;
  if ty>=y then
    for i:=y to (ty-half) do begin
      Canvas.MoveTo(x,y);
      Canvas.lineTo(x,i);
      sleep(dtime);
    end
  else
    for i:=y downto (ty+half) do begin
      Canvas.MoveTo(x,y);
      Canvas.lineTo(x,i);
      sleep(dtime);
    end;

  if tx>=x then
    if ty>=y then
      for i:=x to tx do begin
        Canvas.MoveTo(x,(ty-half));
        Canvas.lineTo(i,(ty-half));
        sleep(dtime);
      end
    else
      for i:=x to tx do begin
        Canvas.MoveTo(x,(ty+half));
        Canvas.lineTo(i,(ty+half));
        sleep(dtime);
      end
  else
    if ty>=y then
      for i:=x downto tx do begin
        Canvas.MoveTo(x,(ty-half));
        Canvas.lineTo(i,(ty-half));
        sleep(dtime);
      end
    else
      for i:=x downto tx do begin
        Canvas.MoveTo(x,(ty+half));
        Canvas.lineTo(i,(ty+half));
        sleep(dtime);
      end;
      
  if ty>=y then
    for i:=(ty-half) to ty do begin
      Canvas.MoveTo(tx,(ty-half));
      Canvas.lineTo(tx,i);
      sleep(dtime);
    end
  else
    for i:=(ty+half) downto ty do begin
      Canvas.MoveTo(tx,(ty+half));
      Canvas.lineTo(tx,i);
      sleep(dtime);
    end;  
end;

end.
