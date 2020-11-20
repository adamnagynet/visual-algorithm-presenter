unit Folyo;

interface

uses
  classes, graphics, controls, forms;

type
  TFolyoPart = class (TObject)
    private
      canvas:TCanvas;
      n,d,h,hezag:integer;
      mk1,mm1,mk2,mm2:integer;
      //d - egy negyzet merete
      //h - fuggoleges tavolsag

    public
      constructor create;
      procedure show;
      procedure hide;
      procedure setCanvas(canvas:TCanvas);
      procedure setN(n:integer);
      procedure setH(h:integer);
      procedure setD(d:integer);
      procedure setHezag(hezag:integer);
      procedure setPartok(mk1,mm1,mk2,mm2:integer);
      function getN:integer;
      function getH:integer;
      function getD:integer;
      function getHezag:integer;
  end;

implementation

constructor TFolyoPart.create;
begin
  n:=0;
  h:=0;
  d:=0;
  mk1:=0;
  mm1:=0;
  mk1:=0;
  mm2:=0;
end;

procedure TFolyoPart.setD(d:integer);
begin
  self.d:=d;
end;

procedure TFolyoPart.sethezag(hezag:integer);
begin
  self.Hezag:=hezag;
end;

procedure TFolyoPart.setH(h:integer);
begin
  self.h:=h;
end;

procedure TFolyopart.setPartok(mk1,mm1,mk2,mm2:integer);
begin
  self.mk1:=mk1;
  self.mk2:=mk2;
  self.mm1:=mm1;
  self.mm2:=mm2;
end;

procedure TFolyoPart.setN(n:integer);
begin
  self.n:=n;
end;

procedure TFolyoPart.setCanvas(canvas:TCanvas);
begin
  self.canvas:=canvas;
end;

function TFolyoPart.getN:integer;
begin
  getN:=n;
end;

function TFolyoPart.getH:integer;
begin
  getH:=h;
end;

function TFolyoPart.getD:integer;
begin
  getD:=d;
end;

function TFolyoPart.getHezag:integer;
begin
  getHezag:=Hezag;
end;

procedure TFolyoPart.show;
var
  i:integer;
begin
  canvas.brush.color:=clSkyBlue;
  canvas.pen.Color:=clNavy;
  canvas.pen.Style:=psSolid;
  canvas.RoundRect(4, 2*h+d, n*(hezag+d)+hezag , 2*h+2*d, d div 2, d div 2);
  if mk1+mm1<>0 then begin
    for i:=0 to mk1 do begin
      canvas.brush.color:=clSilver;
      canvas.pen.Color:=clNavy;
      canvas.roundRect(hezag+(i-1)*(hezag+d), 3*h+2*d, i*(hezag+d), 3*h+3*d, d div 2, d div 2);
    end;
    for i:=mk1+1 to mm1+mk1 do begin
      canvas.brush.color:=clCream;
      canvas.pen.Color:=clNavy;
      canvas.roundRect(hezag+(i-1)*(hezag+d), 3*h+2*d, i*(hezag+d), 3*h+3*d, d div 2, d div 2);
    end;
  end;
  if mk2+mm2<>0 then begin
    for i:=0 to mk2 do begin
      canvas.brush.color:=clSilver;
      canvas.pen.Color:=clNavy;
      canvas.roundRect(hezag+(i-1)*(hezag+d), h, i*(hezag+d), h+d, d div 2, d div 2);
    end;
    for i:=mk2+1 to mm2+mk2 do begin
      canvas.brush.color:=clCream;
      canvas.pen.Color:=clNavy;
      canvas.roundRect(hezag+(i-1)*(hezag+d), h, i*(hezag+d), h+d, d div 2, d div 2);
    end;
  end;
  
end;

procedure TFolyoPart.hide;
begin
  canvas.brush.color:=clBtnFace;
  canvas.pen.Color:=clBtnFace;
  canvas.roundRect(1, h-3, hezag+(n)*(hezag+d), 3*h+3*d+3, d div 2, d div 2);
end;


end.
 