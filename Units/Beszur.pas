unit Beszur;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, Golyo, Negyzet, Animacio, Vonal;

const
  hezag=20;
  PSEUDOTEXTFILE='data\beszurpsz.txt';
  MISCTEXTFILE='data\beszurleir.txt';

type
  TBeszur = class(TAnimacio)
    private
      golyo:TGolyo;
      negyzet:array [1..11] of TNegyzet;
      tomb:array [1..11] of integer;
      n,d,h:integer;
      vonal:TVonal;
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

procedure TBeszur.init;
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

procedure TBeszur.Repaint;
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
      if vonal.getLineType='bum' then
        vonal.showbum(d div 2);
  golyo.show;
  canvas.brush.color:=clBtnFace;
  canvas.pen.color:=clBtnFace;
  if length(mymessage)<>0 then
    canvas.TextOut(drawpanel.width div 2-d, h div 2,mymessage);
end;

procedure TBeszur.loadText(memo:TMemo;filename:string);
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

procedure TBeszur.setN(n:integer);
begin
  self.n:=n;
end;

procedure TBeszur.execute;
var
  i,j,be:integer;
  szakadt:boolean;
begin
  szakadt:=false;
  golyo.hide;
  for i:=2 to n do begin
    j:=i-1;
    be:=tomb[i];
  //  golyo.hide;
    if (j>0)and(be<tomb[j]) then begin
      golyo.setX(hezag+j*(hezag+d));
      vonal.setColor(clNavy);
      vonal.setDelay(alvas div 500);
      vonal.setCoord(negyzet[i].getx+(d div 2),{*} negyzet[i].gety-1{*},negyzet[i].getx+(d div 2){*},golyo.getY+(golyo.getR));
      vonal.setlinetype('yx');
      negyzet[i].setcolors(clSilver, clBlack);
      repaint;
      golyo.setText(intToStr(be));
      repaint;
      sleep(alvas div 2);
      vonal.hideyx;

    end;
    while (j>0)and(be<tomb[j]) do begin
      vonal.setColor(clTeal);
      vonal.setDelay(alvas div 500);
      vonal.setCoord(negyzet[j].getx+(d div 2),{*} negyzet[j].gety+d+1{*},negyzet[j+1].getx+(d div 2){*},negyzet[j].gety + d+1);
      vonal.setlinetype('bum');
      repaint;
      tomb[j+1]:=tomb[j];
      negyzet[i].setcolors(clMoneyGreen, clTeal);
      repaint;
      sleep(alvas div 2);
      vonal.hidebum(d div 2){yx};
      dec(j);
    end;

    if (i-1>0)and(be<tomb[i-1]) then begin
      vonal.setColor(clNavy);
      vonal.setDelay(alvas div 500);
      vonal.setCoord(golyo.getx-1,golyo.getY+(golyo.getR div 2)+1, negyzet[j+1].getx+(d div 2), negyzet[j+1].gety-1);
      vonal.setlinetype('xy');
      repaint;
      tomb[j+1]:=be;
      repaint;
      sleep(alvas div 2);
      vonal.hidexy;
      golyo.hide;
    end;
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
  golyo.hide;
  vonal.hidexy;
  over;
end;

destructor TBeszur.destroy;
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
