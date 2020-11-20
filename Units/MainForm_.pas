unit MainForm_;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, StdCtrls, ExtCtrls, ComCtrls, Buttons, StdActns, ToolWin,
  Drawpanel, Szekvenc, Animacio, Binaris, KeresesDialog, MeghatarozasDialog,
  Buborekos, About, XPStyleActnCtrls, ActnList, ActnMan, ActnCtrls, ActnMenus,
  ExtActns, ImgList, HatekonysagDialog, B_IsmertetesDialog, H_IsmertetesDialog,
  exit, Szamol, Hanoi, Kannibalok, Kiralyno, Kivalaszto, Mergesort,
  Quicksort, Beszur, AdatokDialog;

type
  TMainForm = class(TForm)
    CodeMemo: TMemo;
    CommentMemo: TMemo;
    MainStatusBar: TStatusBar;
    SpeedLabel: TLabel;
    FastLabel: TLabel;
    SlowLabel: TLabel;
    SpeedTrackBar: TTrackBar;
    ActionMainMenuBar: TActionMainMenuBar;
    AMBevezetes: TAction;
    AMAlgoritmusok: TAction;
    AMSzekvencialis: TAction;
    AMTartalom: THelpContents;
    AMBinaris: TAction;
    AMBuborekos: TAction;
    AMBeszurasos: TAction;
    AMKivalaszto: TAction;
    AMSzamolasos: TAction;
    AMExit: TAction;
    AMABout: TAction;
    AMKannibalok: TAction;
    AM8Kiralyno: TAction;
    AMHatekonysag: TAction;
    AMHanoi: TAction;
    AMH_Ismertetes: TAction;
    AMQuicksort: TAction;
    AMMergeSort: TAction;
    MainImageList: TImageList;
    Pausebut: TBitBtn;
    Playbut: TBitBtn;
    Stopbut: TBitBtn;
    AMB_Ismertet: TAction;
    k: TActionManager;
    procedure FormCreate(Sender: TObject);
    procedure PlaybutxClick(Sender: TObject);
    procedure PausebutxClick(Sender: TObject);
    procedure StopbutxClick(Sender: TObject);
    procedure SpeedTrackBarChange(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure AMABoutExecute(Sender: TObject);
    procedure AMBevezetesExecute(Sender: TObject);
    procedure AMSzekvencialisExecute(Sender: TObject);
    procedure AMBinarisExecute(Sender: TObject);
    procedure AMBuborekosExecute(Sender: TObject);
    procedure AMExitExecute(Sender: TObject);
    procedure AMHatekonysagExecute(Sender: TObject);
    procedure AMB_IsmertetExecute(Sender: TObject);
    procedure AMH_IsmertetesExecute(Sender: TObject);
    procedure AMBeszurasosExecute(Sender: TObject);
    procedure AMKivalasztoExecute(Sender: TObject);
    procedure AMSzamolasosExecute(Sender: TObject);
    procedure AMQuicksortExecute(Sender: TObject);
    procedure AMMergeSortExecute(Sender: TObject);
    procedure AMTartalomExecute(Sender: TObject);
    procedure AM8KiralynoExecute(Sender: TObject);
    procedure AMHanoiExecute(Sender: TObject);
    procedure AMKannibalokExecute(Sender: TObject);
    private
      deskPanel:TDrawPanel;
  end;

var
  mainForm:TMainForm;
  animacio:TAnimacio;

implementation

{$R *.dfm}

procedure TMainForm.FormCreate(Sender: TObject);
begin
  deskPanel:=TDrawPanel.create(self);
  deskPanel.parent:=self;
  deskPanel.bevelInner:=bvLowered;
  deskPanel.bevelOuter:=bvNone;
  deskPanel.bevelWidth:=1;
  deskPanel.setBounds(10,32,529,277);
  commentMemo.clear;
  codeMemo.clear;
  playbut.enabled:=false;
  pausebut.enabled:=false;
  stopbut.enabled:=false;
  speedTrackBar.enabled:=false;
  mainStatusBar.panels[3].text:='Még nem indult animáció...';
end;

procedure TMainForm.PlaybutxClick(Sender: TObject);
begin
  pauseBut.enabled:=true;
  stopBut.enabled:=true;
  mainStatusBar.panels[2].text:='Az animáció mûködésben van...';
  playBut.enabled:=false;
  speedTrackBar.enabled:=true;
  animacio.Resume;
end;

procedure TMainForm.PausebutxClick(Sender: TObject);
begin
  animacio.suspend;
  mainStatusBar.Panels[2].Text:='Az animáció szünetel...';
  playBut.enabled:=true;
  stopBut.enabled:=true;
  pauseBut.enabled:=false;
  speedTrackBar.enabled:=false;
end;

procedure TMainForm.StopbutxClick(Sender: TObject);
begin
  animacio.terminate;
  mainStatusBar.Panels[2].text:='Az animáció megállt...';
  stopBut.enabled:=false;
  pauseBut.enabled:=false;
  playBut.enabled:=false;
  speedTrackBar.enabled:=false;
end;

procedure TMainForm.SpeedTrackBarChange(Sender: TObject);
var
  alv:integer;
begin
  alv:=speedTrackBar.position;
  animacio.setAlvas(alv);
  mainStatusBar.panels[3].text:='Animáció sebessége: '+intToStr(100*sqr(alv))+' ms';
end;

procedure TMainForm.FormPaint(Sender: TObject);
begin
  deskPanel.repaint;
end;

procedure TMainForm.AMABoutExecute(Sender: TObject);
var
  dialog:TAboutDlg;
begin
  dialog:=TAboutDlg.create(MainForm);
  dialog.showmodal;
  dialog.destroy;
end;

procedure TMainForm.AMBevezetesExecute(Sender: TObject);
var
  dialog:TMeghatDlg;
begin
  dialog:=TMeghatDlg.Create(MainForm);
  dialog.showModal;
  dialog.destroy;
end;

procedure TMainForm.AMSzekvencialisExecute(Sender: TObject);
var
  mit,n:integer;
  dialog:TKezdoAdat;
begin
  if animacio<>nil then
    animacio.destroy;
  dialog:=TKezdoAdat.create(MainForm);
  repeat
    dialog.showModal;
    n:=strToInt(dialog.elemszamBox.text);
    mit:=strToInt(dialog.keresett.text);
  until ((n in [5..10])and(mit in [1..30]))or(dialog.ModalResult=mrCancel);
  if dialog.ModalResult<>mrCancel then begin
    playbut.enabled:=true;
    animacio:=TSzekvenc.create(true);
    TSzekvenc(animacio).setN(n);
    TSzekvenc(animacio).setMit(mit);
    animacio.setDrawPanel(deskPanel);
    animacio.setButtons(playbut,stopbut,pausebut,speedTrackBar);
    deskPanel.setRepaintMethod(TSzekvenc(animacio).repaint);
    animacio.setPseudoMemo(codeMemo);
    animacio.setMiscMemo(commentMemo);
    animacio.init;
    animacio.setAlvas(5);
    speedTrackBar.enabled:=true;
    speedTrackBar.position:=5;
    mainStatusBar.panels[1].text:='Szekvenciális keresés';
    mainStatusBar.panels[2].text:='Az animáció futtatásra készen áll!';
    SpeedTrackBarChange(Sender);
  end;
  dialog.destroy;
end;

procedure TMainForm.AMBinarisExecute(Sender: TObject);
var
  mit,n:integer;
  dialog:TKezdoAdat;
begin
  if animacio<>nil then
    animacio.destroy;
  dialog:=TKezdoAdat.create(MainForm);
  repeat
    dialog.showModal;
    n:=strToInt(dialog.elemszamBox.text);
    mit:=strToInt(dialog.keresett.text);
  until ((n in [5..10])and(mit in [1..30]))or(dialog.ModalResult=mrCancel);
  if dialog.ModalResult<>mrCancel then begin
    playbut.enabled:=true;
    animacio:=TBinaris.create(true);
    TBinaris(animacio).setN(n);
    TBinaris(animacio).setMit(mit);
    animacio.setDrawPanel(deskPanel);
    animacio.setButtons(playbut,stopbut,pausebut,speedTrackBar);
    deskPanel.setRepaintMethod(TBinaris(animacio).repaint);
    animacio.setPseudoMemo(codeMemo);
    animacio.setMiscMemo(commentMemo);
    animacio.init;
    animacio.setAlvas(5);
    speedTrackBar.position:=5;
    speedTrackBar.enabled:=true;
    mainStatusBar.panels[1].text:='Bináris keresés';
    mainStatusBar.panels[2].text:='Az animáció futtatásra készen áll!';
    speedTrackBarChange(Sender);
  end;
  dialog.destroy;
end;

procedure TMainForm.AMBuborekosExecute(Sender: TObject);
var
  n:integer;
  dialog:TKezdoAdat;
begin
  if animacio<>nil then
    animacio.destroy;
  dialog:=TKezdoAdat.create(MainForm);
  dialog.keresett_label.hide;
  dialog.keresett.hide;
  repeat
    dialog.showModal;
    n:=strToInt(dialog.elemszamBox.Text);
  until (n in [5..10])or(dialog.ModalResult=mrCancel);
  dialog.keresett_label.show;
  dialog.keresett.show;
  if dialog.ModalResult<>mrCancel then begin
    playbut.enabled:=true;
    animacio:=TBuborek.create(true);
    TBuborek(animacio).setN(n);
    animacio.setDrawPanel(deskPanel);
    animacio.setButtons(playbut,stopbut,pausebut,speedTrackBar);
    deskPanel.setRepaintMethod(TBuborek(animacio).repaint);
    animacio.setPseudoMemo(codeMemo);
    animacio.setMiscMemo(commentMemo);
    animacio.init;
    animacio.setAlvas(4);
    speedTrackBar.position:=4;
    speedTrackBar.enabled:=true;
    mainStatusBar.panels[1].text:='Buborékos rendezés';
    mainStatusBar.panels[2].text:='Az animáció futtatásra készen áll!';
    speedTrackBarChange(Sender);
  end;
  dialog.destroy;
end;

procedure TMainForm.AMExitExecute(Sender: TObject);
var
  dialog:TExitForm;
begin
  dialog:=TExitForm.Create(MainForm);
  dialog.showModal;
  dialog.destroy;
  if dialog.ModalResult = mrYes then
    Close;
end;

procedure TMainForm.AMHatekonysagExecute(Sender: TObject);
var
  dialog:THatekonyDlg;
begin
  dialog:=THatekonyDlg.Create(MainForm);
  dialog.showModal;
  dialog.destroy;
end;

procedure TMainForm.AMB_IsmertetExecute(Sender: TObject);
var
  dialog:TBIsmDlg;
begin
  dialog:=TBIsmDlg.Create(MainForm);
  dialog.showModal;
  dialog.destroy;
end;

procedure TMainForm.AMH_IsmertetesExecute(Sender: TObject);
var
  dialog:THIsmDlg;
begin
  dialog:=THIsmDlg.Create(MainForm);
  dialog.showModal;
  dialog.destroy;
end;

procedure TMainForm.AMBeszurasosExecute(Sender: TObject);
var
  n:integer;
  dialog:TKezdoAdat;
begin
  if animacio<>nil then
    animacio.destroy;
  dialog:=TKezdoAdat.create(MainForm);
  dialog.keresett_label.hide;
  dialog.keresett.hide;
  repeat
    dialog.showModal;
    n:=strToInt(dialog.elemszamBox.Text);
  until (n in [5..10])or(dialog.ModalResult=mrCancel);
  dialog.keresett_label.show;
  dialog.keresett.show;
  if dialog.ModalResult<>mrCancel then begin
    playbut.enabled:=true;
    animacio:=TBeszur.create(true);
    TBeszur(animacio).setN(n);
    animacio.setDrawPanel(deskPanel);
    animacio.setButtons(playbut,stopbut,pausebut,speedTrackBar);
    deskPanel.setRepaintMethod(TBeszur(animacio).repaint);
    animacio.setPseudoMemo(codeMemo);
    animacio.setMiscMemo(commentMemo);
    animacio.init;
    animacio.setAlvas(4);
    speedTrackBar.position:=4;
    speedTrackBar.enabled:=true;
    mainStatusBar.panels[1].text:='Beszúrásos rendezés';
    mainStatusBar.panels[2].text:='Az animáció futtatásra készen áll!';
    speedTrackBarChange(Sender);
  end;
  dialog.destroy;
end;

procedure TMainForm.AMKivalasztoExecute(Sender: TObject);
var
  n:integer;
  dialog:TKezdoAdat;
begin
  if animacio<>nil then
    animacio.destroy;
  dialog:=TKezdoAdat.create(MainForm);
  dialog.keresett_label.hide;
  dialog.keresett.hide;
  repeat
    dialog.showModal;
    n:=strToInt(dialog.elemszamBox.Text);
  until (n in [5..10])or(dialog.ModalResult=mrCancel);
  dialog.keresett_label.show;
  dialog.keresett.show;
  if dialog.ModalResult<>mrCancel then begin
    playbut.enabled:=true;
    animacio:=TKivalaszt.create(true);
    TKivalaszt(animacio).setN(n);
    animacio.setDrawPanel(deskPanel);
    animacio.setButtons(playbut,stopbut,pausebut,speedTrackBar);
    deskPanel.setRepaintMethod(TKivalaszt(animacio).repaint);
    animacio.setPseudoMemo(codeMemo);
    animacio.setMiscMemo(commentMemo);
    animacio.init;
    animacio.setAlvas(4);
    speedTrackBar.position:=4;
    speedTrackBar.enabled:=true;
    mainStatusBar.panels[1].text:='Minimumkiválasztásos rendezés';
    mainStatusBar.panels[2].text:='Az animáció futtatásra készen áll!';
    speedTrackBarChange(Sender);
  end;
  dialog.destroy;
end;

procedure TMainForm.AMSzamolasosExecute(Sender: TObject);
var
  n:integer;
  dialog:TKezdoAdat;
begin
  if animacio<>nil then
    animacio.destroy;
  dialog:=TKezdoAdat.create(MainForm);
  dialog.keresett_label.hide;
  dialog.keresett.hide;
  repeat
    dialog.showModal;
    n:=strToInt(dialog.elemszamBox.Text);
  until (n in [5..10])or(dialog.ModalResult=mrCancel);
  dialog.keresett_label.show;
  dialog.keresett.show;
  if dialog.ModalResult<>mrCancel then begin
    playbut.enabled:=true;
    animacio:=TSzamol.create(true);
    TSzamol(animacio).setN(n);
    animacio.setDrawPanel(deskPanel);
    animacio.setButtons(playbut,stopbut,pausebut,speedTrackBar);
    deskPanel.setRepaintMethod(TSzamol(animacio).repaint);
    animacio.setPseudoMemo(codeMemo);
    animacio.setMiscMemo(commentMemo);
    animacio.init;
    animacio.setAlvas(4);
    speedTrackBar.position:=4;
    speedTrackBar.enabled:=true;
    mainStatusBar.panels[1].text:='Számolásos rendezés';
    mainStatusBar.panels[2].text:='Az animáció futtatásra készen áll!';
    speedTrackBarChange(Sender);
  end;
  dialog.destroy;
end;

procedure TMainForm.AMQuicksortExecute(Sender: TObject);
var
  n:integer;
  dialog:TKezdoAdat;
begin
  if animacio<>nil then
    animacio.destroy;
  dialog:=TKezdoAdat.create(MainForm);
  dialog.keresett_label.hide;
  dialog.keresett.hide;
  repeat
    dialog.showModal;
    n:=strToInt(dialog.elemszamBox.Text);
  until (n in [5..10])or(dialog.ModalResult=mrCancel);
  dialog.keresett_label.show;
  dialog.keresett.show;
  if dialog.ModalResult<>mrCancel then begin
    playbut.enabled:=true;
    animacio:=TQuicksort.create(true);
    TQuicksort(animacio).setN(n);
    animacio.setDrawPanel(deskPanel);
    animacio.setButtons(playbut,stopbut,pausebut,speedTrackBar);
    deskPanel.setRepaintMethod(TQuicksort(animacio).repaint);
    animacio.setPseudoMemo(codeMemo);
    animacio.setMiscMemo(commentMemo);
    animacio.init;
    animacio.setAlvas(4);
    speedTrackBar.position:=4;
    speedTrackBar.enabled:=true;
    mainStatusBar.panels[1].text:='Quicksort';
    mainStatusBar.panels[2].text:='Az animáció futtatásra készen áll!';
    speedTrackBarChange(Sender);
  end;
  dialog.destroy;
end;

procedure TMainForm.AMMergeSortExecute(Sender: TObject);
var
  n,m:integer;
  dialog:TAdatok;
  //t1,t2:TStrings;
begin
  if animacio<>nil then
    animacio.destroy;
  dialog:=TAdatok.create(MainForm);
  //dialog.elemszambox.Items.:=('5','6','7','8','9','10');
  dialog.elemszam_label.caption:='Elso tomb eleminek szama:';
  dialog.keresett_label.caption:='Masodik tomb eleminek szama:';
  dialog.keresett_label.show;
  dialog.elemszam_label.show;
  dialog.elemszambox.show;
  repeat
    dialog.showModal;
    n:=strToInt(dialog.elemszamBox.Text);
    m:=strToInt(dialog.elemszam2Box.Text);
  until ((n in [5..10])and(m in [5..10]))or(dialog.ModalResult=mrCancel);
  dialog.elemszam_label.caption:='Elso tomb eleminek szama:';
  dialog.keresett_label.caption:='Masodik tomb eleminek szama:';
  dialog.keresett_label.hide;
  dialog.elemszam_label.show;
  dialog.elemszam2box.hide;
  if dialog.ModalResult<>mrCancel then begin
    playbut.enabled:=true;
    animacio:=TMergesort.create(true);
    TMergesort(animacio).setN(n);
    TMergesort(animacio).setM(m);
    animacio.setDrawPanel(deskPanel);
    animacio.setButtons(playbut,stopbut,pausebut,speedTrackBar);
    deskPanel.setRepaintMethod(TMergesort(animacio).repaint);
    animacio.setPseudoMemo(codeMemo);
    animacio.setMiscMemo(commentMemo);
    animacio.init;
    animacio.setAlvas(4);
    speedTrackBar.position:=4;
    speedTrackBar.enabled:=true;
    mainStatusBar.panels[1].text:='Mergesort';
    mainStatusBar.panels[2].text:='Az animáció futtatásra készen áll!';
    speedTrackBarChange(Sender);
  end;
  dialog.destroy;
end;

procedure TMainForm.AMTartalomExecute(Sender: TObject);
begin
  application.helpCommand(help_contents, 0);
end;

procedure TMainForm.AM8KiralynoExecute(Sender: TObject);
var
  n:integer;
  dialog:TAdatok;
begin
  if animacio<>nil then
    animacio.destroy;
  dialog:=TAdatok.create(MainForm);
  dialog.keresett_label.hide;
  dialog.elemszam2box.hide;
  repeat
    dialog.showModal;
    n:=strToInt(dialog.elemszamBox.Text);
  until ((n=4)or(n=8))or(dialog.ModalResult=mrCancel);
  dialog.keresett_label.show;
  dialog.elemszam2box.show;
  if dialog.ModalResult<>mrCancel then begin
    playbut.enabled:=true;
    animacio:=TKiralyno.create(true);
    TKiralyno(animacio).setN(n);
    animacio.setDrawPanel(deskPanel);
    animacio.setButtons(playbut,stopbut,pausebut,speedTrackBar);
    deskPanel.setRepaintMethod(TKiralyno(animacio).repaint);
    animacio.setPseudoMemo(codeMemo);
    animacio.setMiscMemo(commentMemo);
    animacio.init;
    animacio.setAlvas(4);
    speedTrackBar.position:=4;
    speedTrackBar.enabled:=true;
    mainStatusBar.panels[1].text:='8 Királynõ feladata';
    mainStatusBar.panels[2].text:='Az animáció futtatásra készen áll!';
    speedTrackBarChange(Sender);
  end;
  dialog.destroy;
end;

procedure TMainForm.AMHanoiExecute(Sender: TObject);
var
  n:integer;
  dialog:TAdatok;
begin
  if animacio<>nil then
    animacio.destroy;
  dialog:=TAdatok.create(MainForm);
  dialog.elemszam_label.caption:='Korongok száma';
  dialog.keresett_label.hide;
  dialog.elemszam2box.hide;
  repeat
    dialog.showModal;
    n:=strToInt(dialog.elemszamBox.Text);
  until (n in [2..5])or(dialog.ModalResult=mrCancel);
  dialog.elemszam_label.caption:='Királynõk száma';
  dialog.keresett_label.show;
  dialog.elemszam2box.show;
  if dialog.ModalResult<>mrCancel then begin
    playbut.enabled:=true;
    animacio:=THanoi.create(true);
    THanoi(animacio).setN(n);
    animacio.setDrawPanel(deskPanel);
    animacio.setButtons(playbut,stopbut,pausebut,speedTrackBar);
    deskPanel.setRepaintMethod(THanoi(animacio).repaint);
    animacio.setPseudoMemo(codeMemo);
    animacio.setMiscMemo(commentMemo);
    animacio.init;
    animacio.setAlvas(4);
    speedTrackBar.position:=4;
    speedTrackBar.enabled:=true;
    mainStatusBar.panels[1].text:='Hanoi feladata';
    mainStatusBar.panels[2].text:='Az animáció futtatásra készen áll!';
    speedTrackBarChange(Sender);


  end;
  dialog.destroy;
end;

procedure TMainForm.AMKannibalokExecute(Sender: TObject);
var
  missz,kan:integer;
  dialog:TAdatok;
begin
  if animacio<>nil then
    animacio.destroy;
  dialog:=TAdatok.create(MainForm);
  dialog.elemszam_label.caption:='Kannibálok száma:';
  dialog.keresett_label.show;
  dialog.elemszam2box.show;
  repeat
    dialog.showModal;
    kan:=strToInt(dialog.elemszamBox.Text);
    missz:=strToInt(dialog.elemszam2Box.Text);
  until ((missz>=kan)and(missz in [2..5])and(kan in [2..5]))or(dialog.ModalResult=mrCancel);
  dialog.elemszam_label.caption:='Királynõk száma';
  dialog.keresett_label.hide;
  dialog.elemszam2box.hide;
  if dialog.ModalResult<>mrCancel then begin
    playbut.enabled:=true;
    animacio:=TKannibalok.create(true);
    TKannibalok(animacio).setKan(kan);
    TKannibalok(animacio).setMissz(missz);
    animacio.setDrawPanel(deskPanel);
    animacio.setButtons(playbut,stopbut,pausebut,speedTrackBar);
    deskPanel.setRepaintMethod(TKannibalok(animacio).repaint);
    animacio.setPseudoMemo(codeMemo);
    animacio.setMiscMemo(commentMemo);
    animacio.init;
    animacio.setAlvas(4);
    speedTrackBar.position:=4;
    speedTrackBar.enabled:=true;
    mainStatusBar.panels[1].text:='Kannibálok és misszionáriusok feladata';
    mainStatusBar.panels[2].text:='Az animáció futtatásra készen áll!';
    speedTrackBarChange(Sender);
  end;
  dialog.destroy;
end;

end.
// search in help for >> canvas.brush.color:=dark;

