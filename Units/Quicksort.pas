unit Quicksort;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, Golyo, Negyzet, Vonal, Animacio;

const
  hezag=20;
  PSEUDOTEXTFILE='data\quickpsz.txt';
  MISCTEXTFILE='data\quickleir.txt';

type
  TQuicksort = class(TAnimacio)
    private
      golyo:TGolyo;
      negyzet:array [1..11] of TNegyzet;
      vonal:TVonal;
      tomb:array [1..11] of integer;
      n,d,h:integer;
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

procedure TQuicksort.init;
var
  i:integer;
begin
  d:=(drawpanel.Width - ((n+1)*hezag)) div n;
  h:=(drawpanel.Height - 3*d) div 2;
  for i:=1 to n do
    tomb[i]:=random(29)+1;
  for i:=1 to n+1 do begin
    negyzet[i]:=TNegyzet.create;
    if i<=n then {a vibralas es a 0-as miatt}
      negyzet[i].setx(hezag+(i-1)*(hezag+d))
    else
      negyzet[i].setx(hezag+15*(hezag+d));
    negyzet[i].sety(h+2*d);
    negyzet[i].setd(d);
    negyzet[i].setCanvas(canvas);
  end;
  golyo:=TGolyo.create;
  golyo.setCanvas(canvas);
  golyo.setx(negyzet[1].getX);
  golyo.sety(h);
  golyo.setr(d);
  golyo.setText('');
  vonal:=TVonal.create;
  vonal.setCanvas(canvas);
  vonal.setCoord(0,0,0,0);
  vonal.setDelay(alvas div 500);
  vonal.setColor(clNavy);
  repaint;
  golyo.hide;
  loadText(pseudoMemo,PSEUDOTEXTFILE);
  loadText(miscMemo,MISCTEXTFILE);
end;

procedure TQuicksort.Repaint;
var
  i:integer;
begin
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
      if vonal.getLineType='z' then
        vonal.showz
      else
        if vonal.getLineType='bum' then
          vonal.showbum(h div 3)
        else
          if vonal.getLineType='none' then
            begin end;
  golyo.show;
  canvas.brush.color:=clBtnFace;
  canvas.pen.color:=clBtnFace;
  if length(mymessage)<>0 then
    canvas.TextOut(drawpanel.width div 2-d, h div 2,mymessage);
end;

procedure TQuicksort.loadText(memo:TMemo;filename:string);
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

procedure TQuicksort.setN(n:integer);
begin
  self.n:=n;
end;

procedure TQuicksort.execute;

  function szetvalogat(e,u:integer):integer;
  var
    seged,j:integer;
  begin
    for j:=1 to n+1 do
      negyzet[j].setcolors(clMoneyGreen,clTeal);
    negyzet[e].setColors(clSkyBlue,clNavy);
    negyzet[u].setColors(clSkyBlue,clNavy);
    for j:=e+1 to u-1 do
      negyzet[j].setcolors($00D9D9FF,clMaroon);
    repaint;
    golyo.hide;
    vonal.setlinetype('yx');
    vonal.setDelay(alvas div 500);
    vonal.setCoord(negyzet[e].getx+(d div 2), negyzet[e].gety,negyzet[e].getx+(d div 2),golyo.getY+golyo.getR);
    repaint;
    golyo.hide;
    seged:=tomb[e];
    golyo.setText(intToStr(seged));
    golyo.setX(hezag+(e-1)*(hezag+d));
    vonal.setlinetype('none');//
    repaint;
    sleep(alvas div 3);
    vonal.setCoord(negyzet[e].getx+(d div 2), negyzet[e].gety,negyzet[e].getx+(d div 2),golyo.getY+golyo.getR);
    vonal.hideyx;
    while (e<u) do begin
      while (e<u)and(tomb[u]>=seged) do begin
        negyzet[u].setColors(clMoneyGreen,clTeal);
        dec(u);
        for j:=e+1 to u-1 do
          negyzet[j].setcolors($00D9D9FF,clMaroon);
        negyzet[u].setColors(clSkyBlue,clNavy);
        repaint;
      end;
      if e<u then begin
        vonal.setlinetype('bum');
        vonal.setDelay(alvas div 500);
        vonal.setCoord(negyzet[u].getx+(d div 2), negyzet[u].gety+d,negyzet[e].getx+(d div 2), negyzet[e].gety+d);
        repaint;
        tomb[e]:=tomb[u];
        vonal.setlinetype('none');
        repaint;
        sleep(alvas div 3);
        vonal.setCoord(negyzet[u].getx+(d div 2), negyzet[u].gety+d,negyzet[e].getx+(d div 2), negyzet[e].gety+d);
        vonal.hidebum(h div 3);
        negyzet[e].setColors(clMoneyGreen,clTeal);
        inc(e);
        for j:=e+1 to u-1 do
          negyzet[j].setcolors($00D9D9FF,clMaroon);
        negyzet[e].setColors(clSkyBlue,clNavy);
        repaint;
        sleep(alvas div 4);
        while (e<u)and(tomb[e]<seged) do begin
          negyzet[e].setColors(clMoneyGreen,clTeal);
          inc(e);
          for j:=e+1 to u-1 do
            negyzet[j].setcolors($00D9D9FF,clMaroon);
          negyzet[e].setColors(clSkyBlue,clNavy);
          repaint;
          sleep(alvas div 3);
        end;
        if u<>e then begin
          vonal.setlinetype('bum');
          vonal.setDelay(alvas div 500);
          vonal.setCoord(negyzet[e].getx+(d div 2), negyzet[e].gety+d,negyzet[u].getx+(d div 2), negyzet[u].gety+d);
          repaint;
          tomb[u]:=tomb[e];
          vonal.setlinetype('none');
          repaint;
          sleep(alvas div 3);
          vonal.setCoord(negyzet[e].getx+(d div 2), negyzet[e].gety+d,negyzet[u].getx+(d div 2), negyzet[u].gety+d);
          vonal.hidebum(h div 3);
        end;
        negyzet[u].setColors(clMoneyGreen,clTeal);
        dec(u);
        negyzet[u].setColors(clSkyBlue,clNavy);
        repaint;
        sleep(alvas div 4);
     end;
   end;

   vonal.setlinetype('z');
   vonal.setDelay(alvas div 500);
   vonal.setCoord(golyo.getX+(golyo.getR div 2),golyo.getY+golyo.getR,negyzet[e].getx+(d div 2), negyzet[e].gety);
   repaint;
   tomb[e]:=seged;
   vonal.setlinetype('none');
   repaint;
   sleep(alvas div 3);
   vonal.setCoord(golyo.getX+(golyo.getR div 2),golyo.getY+golyo.getR,negyzet[e].getx+(d div 2), negyzet[e].gety);
   vonal.hidez;
   golyo.hide;
   szetvalogat:=e;
  end;

  procedure quicksort(ah,fh:integer;szakadt:boolean);
  var
    k:integer;
  begin
    if terminated then begin
      szakadt:=true;
      mymessage:='A rendezés félbeszakadt!';
      exit;
    end;
    if ah<fh then begin
      k:=szetvalogat(ah,fh);
      quicksort(ah,k-1,szakadt);
      quicksort(k+1,fh,szakadt);
    end;
  end;

var
  i:integer;
  szakadt:boolean;
  
begin
  szakadt:=false;
  quicksort(1,n,szakadt);
  if not szakadt then begin
    mymessage:='A rendezés megtörtént!';
    for i:=1 to n do
      negyzet[i].setcolors(clMoneygreen, clTeal);
    repaint;
    golyo.hide;
  end;
  over;
end;

destructor TQuicksort.destroy;
var
  i:integer;
begin
  inherited destroy;
  for i:=1 to n do
    negyzet[i].destroy;
  vonal.destroy;
end;

end.

