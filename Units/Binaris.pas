unit Binaris;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, Golyo, Negyzet, Animacio;

const
  hezag=20;
  PSEUDOTEXTFILE='data\binpsz.txt';
  MISCTEXTFILE='data\binleir.txt';

type
  TBinaris = class(TAnimacio)
    private
      golyo:TGolyo;
      negyzet:array [1..11] of TNegyzet;
      seged_Negyzet:TNegyzet;
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

procedure TBinaris.init;

  procedure buborek;
  var
    i,k,seged:integer;
    mutato:boolean;
  begin
    k:=0;
    repeat
      mutato:=true;
      for i:=1 to n-k-1 do
        if tomb[i]>tomb[i+1] then begin
          seged:=tomb[i];
          tomb[i]:=tomb[i+1];
          tomb[i+1]:=seged;
          mutato:=false;
        end;
        inc(k);
    until mutato;
  end;

var
  i:integer;
begin
  d:=(drawpanel.Width - ((n+1)*hezag)) div n;
  h:=(drawpanel.Height - 3*d) div 2;
  for i:=1 to n do
    tomb[i]:=random(29)+1;
  buborek;
  mymessage:='';
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

procedure TBinaris.Repaint;
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

procedure TBinaris.loadText(memo:TMemo;filename:string);
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

procedure TBinaris.setN(n:integer);
begin
  self.n:=n;
end;

procedure TBinaris.setMit(mit:integer);
begin
  self.mit:=mit;
end;

procedure TBinaris.execute;
var
  k,e,u,a,j:integer;
begin
  e:=1;u:=n;k:=0;
  repeat
    golyo.hide;
    a:=k;
    k:=(e+u) div 2;
    golyo.setX(negyzet[1].getX+(k-1)*(hezag+d));
    seged_negyzet.setX(negyzet[1].getX+(k-1)*(hezag+d));
    seged_negyzet.settext(intToStr(tomb[k]));
    repaint;
    sleep(alvas);
    if mit<tomb[k] then begin
      u:=k-1;
      for j:=u to n do
        negyzet[j].setColors(clSilver,clBlack);
      for j:=k to u do
        negyzet[j].setColors(clMoneyGreen,clTeal);
    end
    else
      if mit>tomb[k] then begin
        e:=k+1;
        for j:=1 to e-1 do
          negyzet[j].setColors(clSilver,clBlack);
        for j:=e to u do
          negyzet[j].setColors(clMoneyGreen,clTeal);
      end;
    if (terminated) then break;
  until (e>u)or(mit=tomb[k]);

  if e>u then begin
    if mit in [1,5] then
      mymessage:='Az '+intToStr(mit)+' nem található a tömbben!'
    else
      mymessage:='A '+intToStr(mit)+' nem található a tömbben!';
    repaint;
  end
  else begin
      golyo.hide;
      golyo.setColors(clRed,clMaroon);
      repaint;
      if mit in [1,5] then begin
        mymessage:='Az '+intToStr(mit)+' a '+intToStr(k)+'. pozíción található!';
      end
      else
        mymessage:='A '+intToStr(mit)+' a '+intToStr(k)+'. pozíción található!';
      Repaint;
    end;
  over;
end;

destructor TBinaris.destroy;
var
  i:integer;
begin
  inherited destroy;
  for i:=1 to n do
    negyzet[i].destroy;
  golyo.destroy;
  seged_negyzet.destroy;
end;

end.
