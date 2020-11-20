unit Disztrib;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, Golyo, Negyzet, Animacio;

const
  //n=10;
  hezag=20;
  PSEUDOTEXTFILE='data\disztribpsz.txt';
  MISCTEXTFILE='data\disztribleir.txt';

type
  TDisztrib = class(TAnimacio)
    private
      golyo:TGolyo;
      negyzet,ujnegyzet,darabok:array [1..20{n}] of TNegyzet;
      tomb,darab,uj:array [1..20] of integer;
      n:integer;
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
//!

procedure TDisztrib.init;
var
  i,d:integer;
begin
  d:=(drawpanel.Width - ((n+1)*hezag)) div n;
  for i:=1 to n do
    tomb[i]:=random(29)+1;
  for i:=1 to n do
    darab[i]:=0;  
  repaint;
  loadText(pseudoMemo,PSEUDOTEXTFILE);
  loadText(miscMemo,MISCTEXTFILE);
end;

procedure TDisztrib.Repaint;
//szukseg lenne egy parameterre, mely a kereses jelenlegi poziciojara mutat
var
  j,d:integer;
begin
  d:=(drawpanel.Width - ((n+1)*hezag)) div n;
  for j:=1 to n+1 do begin
    negyzet[j]:=TNegyzet.create;
    if j<=n then            {a vibralas miatt}
      negyzet[j].setx(hezag+(j-1)*(hezag+d))
    else
      negyzet[j].setx(hezag+15*(hezag+d));
    negyzet[j].sety(200);
    //negyzet[j].setColors(clMoneyGreen,clTeal);
    negyzet[j].setd(d);
    negyzet[j].setCanvas(canvas);
    negyzet[j].setText(intToStr(tomb[j]));
    negyzet[j].show;
  end;
end;

procedure TDisztrib.loadText(memo:TMemo;filename:string);
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

procedure TDisztrib.setN(n:integer);
begin
  self.n:=n;
end;

procedure TDisztrib.execute;
var
  i,d:integer;
begin
  d:=(drawpanel.Width - ((n+1)*hezag)) div n;
 {for i:=0 to 5 do
    darab[i]:=0;      }
  for i:=1 to n do
    inc(darab[tomb[i]]);
  for i:=1 to 5 do
    inc(darab[i],darab[i-1]);
  for i:=1 to n do begin
    uj[darab[tomb[i]]]:=tomb[i];
    dec(darab[tomb[i]]);
  end;

  tomb:=uj;
  repaint;
//  writeln('A rendezett sorozat:');
end;
//MessageDlg('Az '+intToStr(mit)+' a '+intToStr(i)+'. pozíción található!', mtInformation, [mbOK], 0);

destructor TDisztrib.destroy;
var
  i:integer;
begin
  inherited destroy;
  for i:=1 to n do
    negyzet[i].destroy;
end;

end.
