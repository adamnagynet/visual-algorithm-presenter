unit Mergesort;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, Golyo, Negyzet, Animacio, Vonal;

const
  hezag=20;
  PSEUDOTEXTFILE='data\szekvpsz.txt';
  MISCTEXTFILE='data\szekvleir.txt';

type
  TMergesort = class(TAnimacio)
    private
      golyo:TGolyo;
      negyzet1,negyzet2:array [1..11] of TNegyzet;
      ujnegyzet:array [1..20] of TNegyzet;
      tomb1,tomb2:array [1..11] of integer;
      uj:array [1..20] of integer;
      vonal:TVonal;
      megszam:TNegyzet;
      n,m,h,d:integer;
      mymessage:string;
      mutat:array [1..11] of boolean;
    public
      procedure setN(n:integer);
      procedure setM(m:integer);
      destructor Destroy; override;
      procedure init; override;
      procedure repaint; override;
      procedure loadText(memo:TMemo;filename:string); override;
    protected
      procedure Execute; override;
  end;

implementation

procedure TMergesort.init;
var
  i:integer;
begin
  d:=(drawpanel.Width - ((n+1)*hezag)) div n;
  h:=(drawpanel.Height - 3*d) div 4;
  for i:=1 to n do
    tomb1[i]:=random(29)+1;
  for i:=1 to m do
    tomb2[i]:=random(29)+1;

  for i:=1 to n+1 do begin
    negyzet1[i]:=TNegyzet.create;
    if i<=n then {a vibralas es a 0-as miatt}
      negyzet1[i].setx(hezag+(i-1)*(hezag+d))
    else
      negyzet1[i].setx(hezag+15*(hezag+d));
    negyzet1[i].sety(3*h+2*d);
    negyzet1[i].setd(d);
    negyzet1[i].setCanvas(canvas);
    negyzet1[i].setText(intToStr(tomb1[i]));
  end;

  for i:=1 to n+1 do begin
    negyzet2[i]:=TNegyzet.create;
    if i<=n then {a vibralas es a 0-as miatt}
      negyzet2[i].setx(hezag+(i-1)*(hezag+d))
    else
      negyzet2[i].setx(hezag+15*(hezag+d));
    negyzet2[i].sety(3*h+2*d);
    negyzet2[i].setd(d);
    negyzet2[i].setCanvas(canvas);
    negyzet2[i].setText(intToStr(tomb2[i]));
  end;


  for i:=1 to n+1 do begin
    ujnegyzet[i]:=TNegyzet.create;
    if i<=n then {a vibralas es a 0-as miatt}
      ujnegyzet[i].setx(hezag+(i-1)*(hezag+d))
    else
      ujnegyzet[i].setx(hezag+15*(hezag+d));
    ujnegyzet[i].sety(2*h+d);
    ujnegyzet[i].setd(d);
    ujnegyzet[i].setcolors(clSkyBlue,clNavy);
    ujnegyzet[i].setCanvas(canvas);
    mutat[i]:=false;
  end;

  vonal:=TVonal.create;
  vonal.setCanvas(canvas);
  vonal.setCoord(0,0,0,0);
  vonal.setDelay(alvas div 500);
  vonal.setColor(clTeal);

  repaint;
  loadText(pseudoMemo,PSEUDOTEXTFILE);
  loadText(miscMemo,MISCTEXTFILE);
end;

procedure TMergesort.Repaint;
var
  i:integer;
begin
  for i:=1 to n+1 do begin
    negyzet1[i].show;
    negyzet2[i].show;
  end;
  if vonal.getLineType='yx' then
    vonal.showyx
  else
    if vonal.getLineType='z' then
      vonal.showz
    else
      if vonal.getLineType='xy' then
        vonal.showxy
      else
        if vonal.getLineType='bum' then
          vonal.showbum(h div 2);
            if vonal.getlinetype='none' then begin
            end;
  for i:=1 to n+1 do
    if mutat[i] then begin
      ujnegyzet[i].setText(intToStr(uj[i]));
      ujnegyzet[i].show;
    end;
  canvas.brush.color:=clBtnFace;
  canvas.pen.color:=clBtnFace;
  if length(mymessage)<>0 then
    canvas.TextOut(drawpanel.width div 2-d, h div 2,mymessage);
end;

procedure TMergesort.loadText(memo:TMemo;filename:string);
var
  c:char;
  f:textfile;
begin
  assignfile(f,filename);
  reset(f);
  memo.Clear;
  while not eof(f) do begin
    read(f,c);
    memo.text:=memo.text+c;
  end;
  closefile(f);
end;

procedure TMergesort.setN(n:integer);
begin
  self.n:=n;
end;

procedure TMergesort.setM(m:integer);
begin
  self.M:=m;
end;
     
procedure TMergesort.execute;

  {procedure fesul(e,u,k:integer);
  var
    k1,e1,i,j:integer;
    x:tomb1;
  begin
     k1:=k+1;
     e1:=e;
     i:=0;
     while (e1<=k)and(k1<=u) do begin
           inc(i);
           if et[e1]<=et[k1] then begin
              x[i]:=et[e1];
              inc(e1);
           end else begin
               x[i]:=et[k1];
               inc(k1);
           end;
     end;
     if e1<=k then
        for j:=e1 to k do begin
            inc(i);
            x[i]:=et[j];
        end
     else
        for j:=k1 to u do begin
            inc(i);
            x[i]:=et[j];
        end;
     i:=0;
     for j:=e to u do begin
         inc(i);
         et[j]:=x[i];
     end; 
end; }

var
  i:integer;
begin
//  fesul
end;

destructor TMergesort.destroy;
var
  i:integer;
begin
  inherited destroy;
  for i:=1 to n do
    negyzet1[i].destroy;
  for i:=1 to m do
    negyzet2[i].destroy;
  for i:=1 to n+m do
    ujnegyzet[i].destroy;
  vonal.Destroy;
end;

end.
