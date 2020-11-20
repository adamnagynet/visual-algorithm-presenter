unit Szamol;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, Golyo, Negyzet, Animacio, Vonal;

const
  hezag=20;
  PSEUDOTEXTFILE='data\szamolpsz.txt';
  MISCTEXTFILE='data\szamolleir.txt';

type
  TSzamol = class(TAnimacio)
    private
      golyo:TGolyo;
      negyzet,nindex,ujnegyzet:array [1..11] of TNegyzet;
      tomb,index,uj:array [1..11] of integer;
      vonal:TVonal;
      megszam:TNegyzet;
      n,h,d:integer;
      mymessage:string;
      mutat:array [1..11] of boolean;
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

procedure TSzamol.init;
var
  i:integer;
begin
  d:=(drawpanel.Width - ((n+1)*hezag)) div n;
  h:=(drawpanel.Height - 3*d) div 4;
  for i:=1 to n do
    tomb[i]:=random(29)+1;
  for i:=1 to n do
    index[i]:=1;

  for i:=1 to n+1 do begin
    negyzet[i]:=TNegyzet.create;
    if i<=n then {a vibralas es a 0-as miatt}
      negyzet[i].setx(hezag+(i-1)*(hezag+d))
    else
      negyzet[i].setx(hezag+15*(hezag+d));
    negyzet[i].sety(3*h+2*d);
    negyzet[i].setd(d);
    negyzet[i].setCanvas(canvas);
    negyzet[i].setText(intToStr(tomb[i]));
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

  for i:=1 to n+1 do begin
    nindex[i]:=TNegyzet.create;
    if i<=n then {a vibralas es a 0-as miatt}
      nindex[i].setx(hezag+(i-1)*(hezag+d))
    else
      nindex[i].setx(hezag+15*(hezag+d));
    nindex[i].sety(h);
    nindex[i].setd(d);
    nindex[i].setCanvas(canvas);
    nindex[i].setColors(clBtnFace, clNavy);
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

procedure TSzamol.Repaint;
var
  i:integer;
begin
  for i:=1 to n+1 do begin
    negyzet[i].show;
    nindex[i].setText(intToStr(index[i]));
    nindex[i].show;
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

procedure TSzamol.loadText(memo:TMemo;filename:string);
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

procedure TSzamol.setN(n:integer);
begin
  self.n:=n;
end;                                 

procedure TSzamol.execute;
var
  i,j:integer;
  szakadt:boolean;
begin
  szakadt:=false;
  //repaint;
  for i:=2 to n do begin
    for j:=1 to i-1 do begin
      vonal.setDelay(alvas div 600);
      vonal.setColor(clRed);
      vonal.setCoord(negyzet[i].getx+(d div 2),negyzet[i].gety+d+1,negyzet[j].getx+(d div 2),negyzet[j].gety+d+1);
      vonal.setLineType('bum');
      repaint;
      sleep(alvas div 3);
      vonal.hidebum(h div 2);
      if tomb[i]>tomb[j] then begin
        vonal.setDelay(alvas div 500);
        vonal.setColor(clNavy);
        vonal.setCoord(negyzet[i].getx+(d div 2),negyzet[i].gety-1,nindex[i].getx+(d div 2),nindex[i].gety+d+1);
        vonal.setLineType('z');
        repaint;
        inc(index[i]);
        repaint;
        vonal.hidez;
        sleep(alvas div 3);
      end
      else begin
        vonal.setDelay(alvas div 500);
        vonal.setColor(clNavy);
        vonal.setCoord(negyzet[i].getx+(d div 2),negyzet[i].gety-1,nindex[j].getx+(d div 2),nindex[j].gety+d+1);
        vonal.setLineType('z');
        repaint;
        inc(index[j]);
        repaint;
        vonal.hidez;
        sleep(alvas div 3);
      end;
      if terminated then begin
        mymessage:='A rendezés félbeszakadt!';
        repaint;
        szakadt:=true;
        exit;
      end;
    end;
    sleep(alvas);
  end;
  if not szakadt then begin
    for i:=1 to n do
      uj[index[i]]:=tomb[i];
    for j:=1 to n{+1} do begin
      if j<n+1 then begin
        vonal.setDelay(alvas div 500);
        vonal.setColor(clNavy);
        vonal.setCoord(nindex[j].getx+(d div 2),nindex[j].gety+d+1,ujnegyzet[j].getx+(d div 2),ujnegyzet[j].gety-1);
        vonal.setLineType('yx');
        repaint;
        vonal.setCoord(negyzet[index[j]].getx+(d div 2),negyzet[index[j]].gety-1,ujnegyzet[j].getx+(d div 2),ujnegyzet[j].gety+d+1);
        vonal.setLineType('z');
        mutat[j]:=true;
        repaint;
        vonal.setCoord(nindex[j].getx+(d div 2),nindex[j].gety+d+1,ujnegyzet[j].getx+(d div 2),ujnegyzet[j].gety-1);
        vonal.hideyx;
        vonal.setCoord(negyzet[index[j]].getx+(d div 2),negyzet[index[j]].gety-1,ujnegyzet[j].getx+(d div 2),ujnegyzet[j].gety+d+1);
        vonal.hidez;
        sleep(alvas div 2);
      end;
    end;
    mymessage:='A rendezés megtörtént!';
    vonal.setLineType('none');
    repaint;
  end;
  over;
end;

//MessageDlg('Az '+intToStr(mit)+' a '+intToStr(i)+'. pozíción található!', mtInformation, [mbOK], 0);

destructor TSzamol.destroy;
var
  i:integer;
begin
  inherited destroy;
  for i:=1 to n do
    negyzet[i].destroy;
  for i:=1 to n do
    ujnegyzet[i].destroy;
  for i:=1 to n do
    nindex[i].destroy;
  vonal.Destroy;
end;

end.
