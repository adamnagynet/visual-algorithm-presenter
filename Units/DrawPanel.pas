unit DrawPanel;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, StdCtrls, ExtCtrls, ComCtrls, Buttons, StdActns, ToolWin,
  ActnMan, ActnCtrls, ActnMenus;

type
  TMethod = procedure of object;

type
  TDrawPanel = class(TPanel)
    private
      fctptr:TMethod;
    public
      procedure setRepaintMethod(fctptr:TMethod); {fuggvenyre mutato pointer}
      procedure Repaint; override;
  end;

implementation

procedure TDrawpanel.setRepaintMethod(fctptr:TMethod);
begin
  self.fctptr:=fctptr;
end;

procedure TDrawpanel.Repaint;
begin
  inherited repaint;
  if @fctptr<>nil then
    fctptr;
end;

end.
