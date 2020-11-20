unit Animacio;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, Buttons;
type
  TAnimacio = class(TThread)
    protected
      drawPanel:TPanel;
      pseudoMemo:TMemo;
      miscMemo:TMemo;
      canvas:TCanvas;
      alvas:integer;
      plb:TBitBtn;
      pb:TBitBtn;
      sb:TBitBtn;
      tb:TTrackBar;
    public
      procedure Init; virtual; abstract;
      procedure setMiscMemo(p:TMemo);
      procedure setPseudoMemo(p:TMemo);
      procedure setDrawPanel(p:TPanel);
      procedure setAlvas(alvas:integer);
      procedure repaint; virtual; abstract;
      procedure loadText(memo:TMemo;filename:string); virtual; abstract;
      procedure setButtons(b1,b2,b3:TBitBtn; t1:TTrackBar);
      procedure over;
  end;

implementation

procedure TAnimacio.setDrawPanel(p:TPanel);
begin
  drawPanel:=p;
  canvas:=TCanvas.create;
  canvas.handle:=getDC(drawPanel.handle);
end;

procedure TAnimacio.setPseudoMemo(p:TMemo);
begin
  pseudoMemo:=p;
end;

procedure TAnimacio.setAlvas(alvas:integer);
begin
  self.alvas:=100*sqr(alvas);
end;

procedure TAnimacio.setMiscMemo(p:TMemo);
begin
  miscMemo:=p;
end;

procedure TAnimacio.setButtons(b1,b2,b3:TBitBtn; t1:TTrackBar);
begin
  self.plb:=b1;
  self.pb:=b2;
  self.sb:=b3;
  self.tb:=t1;
end;

procedure TAnimacio.over;
begin
  plb.enabled:=false;
  pb.enabled:=false;
  sb.enabled:=false;
  tb.enabled:=false;
end;

end.

