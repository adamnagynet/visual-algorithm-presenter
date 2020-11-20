unit Kannibalok;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, Vonal, Animacio, Folyo;

const
  hezag=20;
  PSEUDOTEXTFILE='data\backpsz.txt';
  MISCTEXTFILE='data\kaniballeir.txt';

type
  TKannibalok = class(TAnimacio)
    private
      n,h,d:integer;
      mk1,mk2,mm1,mm2:integer;
      mymessage:string;
      v:array [1..30,1..5] of integer;
      patak:TFolyopart;
    public
      procedure setMissz(missz:integer);
      procedure setKan(kan:integer);
      destructor Destroy; override;
      procedure init; override;
      procedure repaint; override;
      procedure loadText(memo:TMemo;filename:string); override;
    protected
      procedure Execute; override;
  end;

implementation

procedure TKannibalok.init;
begin
  n:=mk1+mm1;
//  n:=mk2+mm2;
  d:=(drawpanel.Width - ((n+1)*hezag)) div n;
  h:=(drawpanel.Height - 3*d) div 4;

  patak:=TFolyoPart.create;
  patak.setCanvas(canvas);
  patak.setN(n);
  patak.setD(d);
  patak.setH(h);
  patak.setHezag(hezag);

  {mk1:=0;} mk2:=0;
  {mm1:=0;} mm2:=0;

  repaint;
  loadText(pseudoMemo,PSEUDOTEXTFILE);
  loadText(miscMemo,MISCTEXTFILE);
end;

procedure TKannibalok.Repaint;
begin
  canvas.brush.color:=clBtnFace;
  canvas.pen.Color:=clBtnFace;
  canvas.roundRect(5, 5, hezag+(n)*(hezag+d), 3*h+3*d+3, d div 2, d div 2);
  patak.setPartok(mk1,mm1,mk2,mm2);
  patak.show;
  canvas.brush.color:=clBtnFace;
  canvas.pen.color:=clBtnFace;
  if length(mymessage)<>0 then
    canvas.TextOut(drawpanel.width div 4, h div 2,mymessage);
end;

procedure TKannibalok.loadText(memo:TMemo;filename:string);
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

procedure TKannibalok.setMissz(missz:integer);
begin
  self.mm1:=missz;
end;

procedure TKannibalok.setKan(kan:integer);
begin
  self.mk1:=kan;
end;

procedure TKannibalok.execute;

  procedure init(var k:integer);
  begin
     v[k,1]:=0;
     v[k,2]:=mk1;
     v[k,3]:=mm1;
     v[k,4]:=mk2;
     v[k,5]:=mm2;
  end;

  procedure kovetkezo(var van:boolean;k:integer);
  begin
    if v[k,1]<5 then begin
      inc(v[k,1]);
      van:=true;
    end
    else van:=false;
  end;

  procedure kiir(k:integer);
  var
    i:integer;
  begin
    mymessage:='Megoldas!';
    for i:=1 to k do begin
         //for j:=1 to 5 do begin
             mk1:=v[k,2];
             mm1:=v[k,3];
             mk2:=v[k,4];
             mm2:=v[k,5];
             repaint;
             sleep(alvas div 3);
        // end;
    end;
  end;

  procedure ellenoriz(var jo:boolean;k:integer);
  var
    i:integer;
  begin
    jo:=true;
    mk1:=v[k,2];
    mm1:=v[k,3];
    mk2:=v[k,4];
    mm2:=v[k,5];
    if k mod 2=0 then
        case v[k,1] of
             1:begin
                    dec(mk2,2);
                    inc(mk1,2);
          //          repaint;
           //         sleep(alvas div 3);
               end;
             2:begin
                    dec(mm2,2);
                    inc(mm1,2);
             //      repaint;
               //     sleep(alvas div 3);
               end;
             3:begin
                    dec(mm2);
                    inc(mm1);
                 //   repaint;
           //         sleep(alvas div 3);
                    dec(mk2);
                    inc(mk1);
        //            repaint;
          //          sleep(alvas div 3);
               end;
             4:begin
                    dec(mk2);
                    inc(mk1);
            //        repaint;
              //      sleep(alvas div 3);
               end;
             5:begin
                    dec(mm2);
                    inc(mm1);
                //    repaint;
                 //   sleep(alvas div 3);
               end;
        end
        else
            case v[k,1] of
                 1:begin
                        dec(mk1,2);
                        inc(mk2,2);
                   //     repaint;
                     //   sleep(alvas div 3);
                   end;
                 2:begin
                        dec(mm1,2);
                        inc(mm2,2);
                 //       repaint;
                  //  sleep(alvas div 3);
                   end;
                 3:begin
                        dec(mm1);
                        inc(mm2);
                     //   repaint;
                   // sleep(alvas div 3);
                        dec(mk1);
                        inc(mk2);
              //          repaint;
               //     sleep(alvas div 3);
                   end;
                 4:begin
                        dec(mk1);
                        inc(mk2);
                 //       repaint;
                  //  sleep(alvas div 3);
                   end;
                 5:begin
                        dec(mm1);
                        inc(mm2);
                    //    repaint;
                 //   sleep(alvas div 3);
                   end;
            end;

        if (mk1<0)or(mk2<0)or(mm1<0)or(mm2<0)or((mm1>0)and(mk1>mm1))or((mm2>0)and(mk2>mm2)) then
          jo:=false;
        if k>2 then begin
          if v[k,1]=v[k-1,1] then
            jo:=false
          else
            for i:=1 to k-1 do
              if (v[i,2]=v[k,2])and(v[i,3]=v[k,3])and((k-i) mod 2 =0) then
                jo:=false;
        end;
end;

var
  k:integer;
  van,jo:boolean;

begin
  k:=1;
  init(k);
  while k>0 do begin
    if terminated then exit;  
    repeat
      kovetkezo(van,k);
      if van then
        ellenoriz(jo,k);
    until (not van)or(van and jo);
    if van then
      if (mk1=0)and(mm1=0)and (abs(mk1-mk2)=0) and (abs(mm1-mm2)=0) then begin
        kiir(k);
      end
      else begin
        inc(k);
        init(k);
      end
    else dec(k);
  end;

  mymessage:='A misszionariusok es a kannibalok sikeresen atszaltak a masik partra!';
  repaint;
  over;
end;

destructor TKannibalok.destroy;
begin
  inherited destroy;
  patak.destroy;
end;

end.
