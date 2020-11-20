unit Buborekos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, Golyo, Negyzet, Animacio, Vonal;

const
  hezag=20;
  PSEUDOTEXTFILE='data\bubpsz.txt';
  MISCTEXTFILE='data\bubleir.txt';

type
  TBuborek = class(TAnimacio)
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

procedure TBuborek.init;
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
  vonal.setColor(clTeal);

  repaint;
  golyo.hide;
  loadText(pseudoMemo,PSEUDOTEXTFILE);
  loadText(miscMemo,MISCTEXTFILE);
end;

procedure TBuborek.Repaint;
var
  i:integer;
begin
  for i:=1 to n do begin
    negyzet[i].setText(intToStr(tomb[i]));
    negyzet[i].show;
  end;
  vonal.showyx;
  golyo.show;
  canvas.brush.color:=clBtnFace;
  canvas.pen.color:=clBtnFace;
  if length(mymessage)<>0 then
    canvas.TextOut(drawpanel.width div 2-d, h div 2,mymessage);
end;

procedure TBuborek.loadText(memo:TMemo;filename:string);
var
  c:char;
  f:textfile;
begin
  assignfile(f,filename);
  reset(f);
  memo.Clear;
  memo.ScrollBars:=ssVertical;
  while not eof(f) do begin
    read(f,c);
    memo.text:=memo.text+c;
  end;
  closefile(f);
end;

procedure TBuborek.setN(n:integer);
begin
  self.n:=n;
end;

procedure TBuborek.execute;
var
  i,k,seged:integer;
  mutato,vajon:boolean;
begin
   k:=0;
   golyo.hide;
   repeat
    mutato:=true;
    vajon:=true;
    for i:=1 to n-k-1 do begin
      if tomb[i]>tomb[i+1] then begin
         vonal.setDelay(alvas div 500);
         vonal.setColor(clTeal);
         vonal.setCoord(negyzet[i].getx+(d div 2),{*} negyzet[i].gety-1{*},negyzet[i+1].getx{*},golyo.getY+(golyo.getR div 2));
         seged:=tomb[i];
         golyo.setText(intToStr(seged));
         golyo.setX(hezag+i*(hezag+d));
         repaint;
         sleep(alvas div 3);
         vonal.hideyx;
         vonal.setCoord(negyzet[i+1].getx-1, negyzet[i+1].gety+(negyzet[i+1].getd div 2),negyzet[i].getx + negyzet[i].getD, negyzet[i].gety+(negyzet[i].getd div 2));
         repaint;
         tomb[i]:=tomb[i+1];
         repaint;
         sleep(alvas div 3);
         vonal.hideyx;
         vonal.setColor(clNavy);
         vonal.setCoord(negyzet[i+1].getx +(negyzet[i+1].getD div 2),golyo.getY+golyo.getR, negyzet[i+1].getx +(negyzet[i+1].getD div 2), negyzet[i+1].gety);
         repaint;
         tomb[i+1]:=seged;
         repaint;
         sleep(alvas div 3);
         vonal.hideyx;
         golyo.hide;
         mutato:=false;
      end;
      if (terminated) then begin
        vajon:=false;
        mymessage:='A rendezés félbeszakadt!';
        break;
      end;
    end;
    inc(k);
  until mutato;
  if vajon then
    mymessage:='A rendezés megtörtént!';
  repaint;
  golyo.hide;
  vonal.hidexy;
  over;
end;

destructor TBuborek.destroy;
var
  i:integer;
begin
  inherited destroy;
  for i:=1 to n do
    negyzet[i].destroy;
  golyo.Destroy;
  vonal.Destroy;
end;

end.
