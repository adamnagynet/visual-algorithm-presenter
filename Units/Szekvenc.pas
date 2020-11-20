unit Szekvenc;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, Golyo, Negyzet, Animacio;

const
  hezag=20;
  PSEUDOTEXTFILE='data\szekvpsz.txt';
  MISCTEXTFILE='data\szekvleir.txt';

type
  TSzekvenc = class(TAnimacio)
    private
      golyo:TGolyo;
      negyzet:array [1..11] of TNegyzet;
      seged_negyzet:TNegyzet;
      tomb:array [1..11] of integer;
      n,mit,d,h:integer;
      mymessage:string;
    public
      procedure setN(n:integer);
      procedure setMit(mit:integer);
      destructor Destroy; override;
      procedure init; override;
      procedure repaint; override;
      procedure loadText(memo:TMemo;filename:string); override;
    protected
      procedure Execute; override;
  end;

implementation

procedure TSzekvenc.init;
var
  i:integer;
begin
  d:=(drawpanel.Width - ((n+1)*hezag)) div n;
  h:=(drawpanel.Height - 3*d) div 2;
  mymessage:='';
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
    negyzet[i].setText(intToStr(tomb[i]));
  end;

  golyo:=TGolyo.create;
  golyo.setCanvas(canvas);
  golyo.setx(negyzet[1].getX);
  golyo.sety(h);
  golyo.setr(d);
  golyo.setText(intToStr(mit));

  seged_negyzet:=TNegyzet.create;
  seged_negyzet.setCanvas(canvas);
  seged_negyzet.setx(negyzet[1].getX);
  seged_negyzet.sety(h+2*d);
  seged_negyzet.setColors(clCream,clNavy);
  seged_negyzet.setd(d);
  seged_negyzet.setText(intToStr(tomb[1]));

  repaint;
  loadText(pseudoMemo,PSEUDOTEXTFILE);
  loadText(miscMemo,MISCTEXTFILE);
end;

procedure TSzekvenc.Repaint;
var
  i:integer;
begin
  for i:=1 to n do
    negyzet[i].show;
  seged_negyzet.show;
  golyo.setText(intToStr(mit));
  golyo.show;
  canvas.brush.color:=clBtnFace;
  canvas.pen.color:=clBtnFace;
  if length(mymessage)<>0 then
    canvas.TextOut(drawpanel.width div 2-d, h div 2,mymessage);
end;

procedure TSzekvenc.loadText(memo:TMemo;filename:string);
var
  c:{string{}char;
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

procedure TSzekvenc.setN(n:integer);
begin
  self.n:=n;
end;

procedure TSzekvenc.setMit(mit:integer);
begin
  self.mit:=mit;
end;

procedure TSzekvenc.execute;
var
  i,d:integer;
begin
  d:=(drawpanel.Width - ((n+1)*hezag)) div n;
  i:=1;
  while (i<=n) do begin
    if (mit<>tomb[i]) then begin
      golyo.hide;
      seged_negyzet.settext(intToStr(tomb[i+1]));
      if i<n then
        golyo.setX(hezag+i*(hezag+d))
      else golyo.setX(hezag+15*(hezag+d));
      seged_negyzet.setX(golyo.getx);
      negyzet[i].setColors(clSilver,clBlack);
      repaint;
      sleep(alvas);
    end
    else begin
      golyo.hide;
      golyo.setColors(clRed,clMaroon);
      repaint;
      if mit in [1,5] then
        if i in [1,5] then
           mymessage:='Az '+intToStr(mit)+' az '+intToStr(i)+'. pozíción található!'
        else
           mymessage:='Az '+intToStr(mit)+' a '+intToStr(i)+'. pozíción található!'
      else
        if i in [1,5] then
           mymessage:='A '+intToStr(mit)+' az '+intToStr(i)+'. pozíción található!'
        else
           mymessage:='A '+intToStr(mit)+' a '+intToStr(i)+'. pozíción található!';
      repaint;
      break;
    end;
    if (terminated) then begin
      mymessage:='A keresés félbeszakadt!';
      Repaint;
      break;
    end;
    inc(i);
  end;

  if i>n then begin
    if mit in [1,5] then
      mymessage:='Az '+intToStr(mit)+' nem található a tömbben!'
    else
      mymessage:='A '+intToStr(mit)+' nem található a tömbben!';
    Repaint;
  end;
  over;
end;

destructor TSzekvenc.destroy;
var
  i:integer;
begin
  inherited destroy;
  for i:=1 to n do
    negyzet[i].destroy;
  seged_negyzet.Destroy;
  golyo.Destroy;
end;

end.
