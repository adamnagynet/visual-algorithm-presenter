unit Kiralyno;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls,Golyo, Negyzet, Vonal, SakkTabla, Animacio;

const
  hezag=20;
  PSEUDOTEXTFILE='data\backpsz.txt';
  MISCTEXTFILE='data\kiralynoleir.txt';

type
  TKiralyno = class(TAnimacio)
    private
      SakkTabla:TSakkTabla;
      golyok:array [1..8,1..8] of TGolyo;
      verem:array [1..9] of TNegyzet;
      tomb:array [1..8] of integer;
      n,d,h:integer;
    public
      procedure setN(n:integer);
      destructor Destroy; override;
      procedure init; override;
      procedure repaint; override;
      procedure loadText(memo:TMemo;filename:string); override;
    protected
      procedure Execute; override;
  end;

implementation

procedure TKiralyno.init;
var
  i,j:integer;
begin
  d:=(drawpanel.Height div (n+2))+3;
  sakkTabla:=TSakkTabla.create;
  sakkTabla.setx(d-10);
  sakkTabla.sety(d-10);
  sakkTabla.setColors(clCream,clGray);
  sakkTabla.setNr(n);
  sakkTabla.setd(d);
  sakkTabla.setCanvas(canvas);
  for i:=1 to n do
    for j:=1 to n do
      golyok[i,j]:=TGolyo.create;
  for i:=1 to n+1 do begin
    verem[i]:=TNegyzet.create;
    if i<>n+1 then
      verem[i].setx(drawpanel.Width-2*d)
    else
      verem[i].setx(drawpanel.Width+10);
    verem[i].sety(i*d-10);
    verem[i].setColors(clCream,clBlack);
    verem[i].setd(d);
    verem[i].setCanvas(canvas);
  end;
  repaint;
  loadText(pseudoMemo,PSEUDOTEXTFILE);
  loadText(miscMemo,MISCTEXTFILE);
end;

procedure TKiralyno.Repaint;
var
  i,j:integer;
begin
  if n=4 then
    sakktabla.set4Queens(1,tomb[1],2,tomb[2],3,tomb[3],4,tomb[4])
  else
    sakktabla.set8Queens(1,tomb[1],2,tomb[2],3,tomb[3],4,tomb[4],5,tomb[5],6,tomb[6],7,tomb[7],8,tomb[8]);
  sakkTabla.show;
  for i:=1 to n+1 do begin
    if i<>n+1 then begin
      verem[i].setColors(clCream,clBlack);
      verem[i].setText(intToStr(tomb[i]));
    end;
    verem[i].show;
    canvas.brush.color:=clBtnFace;
    if i<>n+1 then
      canvas.TextOut(verem[i].getx-(d div 2), verem[i].getY+(d div 2),intToStr(i));
  end;
  canvas.brush.color:=clBtnFace;
  canvas.TextOut(verem[1].getx, verem[1].getY-(d div 2),'Verem:');
end;

procedure TKiralyno.loadText(memo:TMemo;filename:string);
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

procedure TKiralyno.setN(n:integer);
begin
  self.n:=n;
end;

procedure TKiralyno.execute;

  procedure init(k:integer);
  begin
    tomb[k]:=0;
    verem[k].setText(intToStr(0));
    repaint;
  end;

  procedure kovetkezo(var van:boolean;k:integer);
  begin
    van:=false;
    if tomb[k]<n then begin
      inc(tomb[k]);
      verem[k].setText(intToStr(tomb[k]));
      repaint;
      sleep(alvas);
      van:=true;
    end;
  end;

  procedure megfelelo(var jo:boolean;k:integer);
  var
    i:integer;
  begin
    jo:=true;
    for i:=1 to k-1 do
      if (tomb[k]=tomb[i])or(k-i=abs(tomb[k]-tomb[i])) then
        jo:=false;
  end;

  function megoldas(k:integer):boolean;
  begin
    megoldas:=k=n;
  end;

  procedure kiir;
  var
    i:integer;
  begin
    for i:=1 to n+1 do begin
      verem[i].setColors($00E1FFDF,clGreen);
      verem[i].show;
    end;
    sleep(3*alvas);
    repaint;
  end;

var
  i,k:integer;
  van,jo:boolean;
begin
  k:=1;
  init(k);
  while k>0 do begin
    repeat
      kovetkezo(van,k);
      if van then
        megfelelo(jo,k);
    until (not van) or (van and jo);
    if van then
      if megoldas(k) then
        kiir
      else begin
        inc(k);
        init(k);
      end
    else dec(k);
    if terminated then
      exit;
  end;
  repaint;
  over;
end;

destructor TKiralyno.destroy;
var
  i,j:integer;
begin
  inherited destroy;
  SakkTabla.Destroy;
  for i:=1 to n+1 do
    verem[i].destroy;
end;

end.
