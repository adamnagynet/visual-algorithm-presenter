unit Kivalaszto;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, Golyo, Negyzet, Animacio, Vonal;

const
  hezag=20;
  PSEUDOTEXTFILE='data\minpsz.txt';
  MISCTEXTFILE='data\minleir.txt';

type
  TKivalaszt = class(TAnimacio)
    private
      golyo:TGolyo;
      vonal:TVonal;
      negyzet:array [1..11] of TNegyzet;
      seged_adatok:array [1..2] of TNegyzet;
      tomb:array [1..11] of integer;
      n,min,hol,d,h:integer;
      mymessage:string;
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

procedure TKivalaszt.init;
var
  i:integer;
begin
  d:=(drawpanel.Width - ((n+1)*hezag)) div n;
  h:=(drawpanel.Height - 3*d) div 4;
  for i:=1 to n do
    tomb[i]:=random(29)+1;

  for i:=1 to n+1 do begin
    negyzet[i]:=TNegyzet.create;
    if i<=n then {a vibralas es a 0-as miatt}
      negyzet[i].setx(hezag+(i-1)*(hezag+d))
    else
      negyzet[i].setx(hezag+15*(hezag+d));
    negyzet[i].sety(3*h+2*d);
    negyzet[i].setd(d);
    negyzet[i].setCanvas(canvas);
  end;

  vonal:=TVonal.create;
  vonal.setCanvas(canvas);
  vonal.setCoord(0,0,0,0);
  vonal.setDelay(alvas div 500);
  vonal.setColor(clTeal);

  seged_adatok[1]:=TNegyzet.create;
  seged_adatok[1].setx((drawpanel.width div 2) - (d div 2));
  seged_adatok[1].sety(2*h+d);
  seged_adatok[1].setColors(clCream,clNavy);
  seged_adatok[1].setd(d);
  seged_adatok[1].setCanvas(canvas);

  seged_adatok[2]:=TNegyzet.create;
  seged_adatok[2].setx((drawpanel.width div 2) - (d div 2));
  seged_adatok[2].sety(h);
  seged_adatok[2].setColors(clBtnFace,clBtnShadow);
  seged_adatok[2].setd(d);
  seged_adatok[2].setCanvas(canvas);

  min:=0;
  hol:=0;
  repaint;
  loadText(pseudoMemo,PSEUDOTEXTFILE);
  loadText(miscMemo,MISCTEXTFILE);
end;

procedure TKivalaszt.Repaint;
var
  i:integer;
begin
  canvas.brush.color:=clBtnFace;
  canvas.TextOut(seged_adatok[2].getx-(d div 2),seged_adatok[2].gety-(h div 2),'Minimum pozíciója:');
  canvas.TextOut(seged_adatok[1].getx,seged_adatok[1].getY+d+(h div 3),'Minimum:');
  seged_adatok[1].setText(intToStr(min));
  seged_adatok[1].show;
  seged_adatok[2].setText(intToStr(hol));
  seged_adatok[2].show;
  for i:=1 to n do begin
    negyzet[i].setText(intToStr(tomb[i]));
    negyzet[i].show;
  end;
  if vonal.getLineType='yx' then
    vonal.showyx
  else
    if vonal.getLineType='xy' then
      vonal.showxy
    else
      if vonal.getLineType='bum' then
        vonal.showbum(h div 3);
  canvas.brush.color:=clBtnFace;
  canvas.pen.color:=clBtnFace;
  if length(mymessage)<>0 then
    canvas.TextOut(drawpanel.width div 2-d, seged_adatok[2].gety+d+(h div 3),mymessage);
end;

procedure TKivalaszt.loadText(memo:TMemo;filename:string);
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

procedure TKivalaszt.setN(n:integer);
begin
  self.n:=n;
end;

procedure TKivalaszt.execute;
var
  i,j:integer;
  szakadt:boolean;
begin
  szakadt:=false;
  seged_adatok[1].setText('0');
  seged_adatok[2].setText('0');
  repaint;
  for i:=1 to n do begin
    vonal.setDelay(alvas div 500);
    vonal.setColor(clNavy);
    if (seged_adatok[1].getx)>=(negyzet[i].getx+(d div 2)) then
      vonal.setCoord(negyzet[i].getx+(d div 2),negyzet[i].gety-1,seged_adatok[1].getx-1,seged_adatok[1].gety+(d div 2))
    else
      vonal.setCoord(negyzet[i].getx+(d div 2),negyzet[i].gety-1,seged_adatok[1].getx+d+1,seged_adatok[1].gety+(d div 2));
    vonal.setLineType('yx');
    vonal.showyx;
    min:=tomb[i];
    seged_adatok[1].setText(intToStr(min));
    repaint;
    sleep(alvas div 10);
    vonal.hideyx;
    vonal.setDelay(alvas div 700);
    vonal.setCoord(seged_adatok[1].getx+(d div 2),seged_adatok[1].gety-1,seged_adatok[2].getx+(d div 2),seged_adatok[2].gety+d+1);
    vonal.setLineType('yx');
    repaint;
    hol:=i;
    seged_adatok[2].setText(intToStr(hol));
    repaint;
    vonal.hideyx;
    sleep(alvas div 3);

    for j:=i+1 to n do
      if tomb[j]<min then begin
        vonal.setDelay(alvas div 500);
        vonal.setColor(clNavy);
        if (negyzet[j].getx+(d div 2))<=(seged_adatok[1].getx) then
          vonal.setCoord(negyzet[j].getx+(d div 2),negyzet[j].gety-1,seged_adatok[1].getx-1,seged_adatok[1].gety+(d div 2))
        else
          vonal.setCoord(negyzet[j].getx+(d div 2),negyzet[j].gety-1,seged_adatok[1].getx+d+1,seged_adatok[1].gety+(d div 2));
        vonal.showyx;
        min:=tomb[j];
        seged_adatok[1].setText(intToStr(min));
        repaint;
        sleep(alvas div 10);
        vonal.hideyx;
        vonal.setDelay(alvas div 700);
        vonal.setCoord(seged_adatok[1].getx+(d div 2),seged_adatok[1].gety-1,seged_adatok[2].getx+(d div 2),seged_adatok[2].gety+d+1);
        vonal.setLineType('yx');
        repaint;
        hol:=j;
        seged_adatok[2].setText(intToStr(hol));
        repaint;
        vonal.hideyx;
        sleep(alvas div 3);
      end;

    vonal.setDelay(alvas div 500);
    vonal.setCoord(negyzet[i].getx+(d div 2),negyzet[i].gety+d+1,negyzet[hol].getx+(d div 2),negyzet[hol].gety+d+1);
    vonal.setLineType('bum');
    repaint;
    tomb[hol]:=tomb[i];
    repaint;
    vonal.hidebum(h div 3);
    sleep(alvas div 3);

    if (seged_adatok[1].getx)>=(negyzet[i].getx+(d div 2)) then
      vonal.setCoord(seged_adatok[1].getx-1,seged_adatok[1].gety+(d div 2),negyzet[i].getx+(d div 2),negyzet[i].gety-1)
    else
      vonal.setCoord(seged_adatok[1].getx+d+1,seged_adatok[1].gety+(d div 2),negyzet[i].getx+(d div 2),negyzet[i].gety-1);
    vonal.setLineType('xy');
    repaint;
    tomb[i]:=min;
    negyzet[i].setcolors(clSkyBlue, clNavy);
    repaint;
    vonal.hidexy;
    sleep(alvas div 3);

    if terminated then begin
      mymessage:='A rendezés félbeszakadt!';
      repaint;
      szakadt:=true;
      exit;
    end;
  end;
  if not szakadt then
    mymessage:='A rendezés megtörtént!';
  repaint;

  over;
end;

destructor TKivalaszt.destroy;
var
  i:integer;
begin
  inherited destroy;
  for i:=1 to n do
    negyzet[i].destroy;
  vonal.destroy;
  for i:=1 to 2 do
    seged_adatok[i].destroy;
end;

end.
