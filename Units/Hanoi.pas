unit Hanoi;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  StdCtrls, ComCtrls, ExtCtrls, Animacio, Korongok, StackInt;

const
  hezag=20;
  PSEUDOTEXTFILE='data\hanoipsz.txt';
  MISCTEXTFILE='data\hanoileir.txt';

type
  THanoi = class(TAnimacio)
    private
      n,h,m,sz:integer;
      oszlop1,oszlop2,oszlop3:TKorong;
      sta,stb,stc:TStackInt;
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

procedure THanoi.init;
var
  i:integer;
begin
  sta:=TStackInt.create;
  sta.init;
  stb:=TStackInt.create;
  stb.init;
  stc:=TStackInt.create;
  stc.init;
  for i:=1 to n do
    sta.push((n-i+1)*20);//!!
  h:=drawpanel.height-hezag;
  m:=h div (n+2);
  sz:=m div (2*n+1);

  oszlop1:=TKorong.create;
  oszlop1.setCanvas(canvas);
  oszlop1.setIndex(1);
  oszlop1.setx((drawpanel.Width div 4));
  oszlop1.sety(hezag);
  oszlop1.setM(m);
  oszlop1.setH(h);

  oszlop2:=TKorong.create;
  oszlop2.setCanvas(canvas);
  oszlop2.setIndex(2);
  oszlop2.setx(2*(drawpanel.Width div 4));
  oszlop2.sety(hezag);
  oszlop2.setM(m);
  oszlop2.setH(h);

  oszlop3:=TKorong.create;
  oszlop3.setCanvas(canvas);
  oszlop3.setIndex(3);
  oszlop3.setx(3*(drawpanel.Width div 4));
  oszlop3.sety(hezag);
  oszlop3.setM(m);
  oszlop3.setH(h);

  repaint;
  loadText(pseudoMemo,PSEUDOTEXTFILE);
  loadText(miscMemo,MISCTEXTFILE);
end;

procedure THanoi.Repaint;
begin
  canvas.Brush.color:=clBtnFace;
  canvas.Pen.color:=clBtnFace;
  canvas.Rectangle(5, 5, drawpanel.Width-5, drawpanel.Height-5);
  oszlop1.show(sta);
  oszlop2.show(stb);
  oszlop3.show(stc);
  canvas.brush.color:=clBtnFace;
  if length(mymessage)<>0 then
    canvas.TextOut(drawpanel.width div 2-m, hezag div 2,mymessage);
end;

procedure THanoi.loadText(memo:TMemo;filename:string);
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

procedure THanoi.setN(n:integer);
begin
  self.n:=n;
end;

procedure THanoi.execute;

  procedure Hanoi(n:integer;a,b,c:char);
  begin
    if terminated then begin
      over;
      exit;
    end;
    if n=1 then begin
      if (a='a')and(c='b') then stb.push(sta.pop) else
      if (a='a')and(c='c') then stc.push(sta.pop) else
      if (a='b')and(c='a') then sta.push(stb.pop) else
      if (a='b')and(c='c') then stc.push(stb.pop) else
      if (a='c')and(c='a') then sta.push(stc.pop) else
      if (a='c')and(c='b') then stb.push(stc.pop);
      repaint;
      sleep(alvas);
    end
    else begin
      hanoi(n-1,a,c,b);
      hanoi(1, a,b,c);
      hanoi(n-1,b,a,c);
    end;
  end;


begin
  hanoi(n,'a','b','c');
  canvas.brush.color:=clBtnFace;
  mymessage:='A korongok a helyukre kerultek!';
  repaint;
  over;
end;

destructor THanoi.destroy;
begin
  inherited destroy;
  oszlop1.destroy;
  oszlop2.destroy;
  oszlop3.destroy;
end;

end.
