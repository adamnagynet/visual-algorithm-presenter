program VAP;

uses
  forms,
  sysutils,
  splash in 'Units\splash.pas' {SplashForm},
  MainForm_ in 'units\MainForm_.pas' {MainForm},
  MeghatarozasDialog in 'units\MeghatarozasDialog.pas' {MeghatDlg},
  Szekvenc in 'units\Szekvenc.pas',
  Binaris in 'units\Binaris.pas',
  Buborekos in 'units\Buborekos.pas',
  Beszur in 'Units\Beszur.pas',
  Kivalaszto in 'Units\Kivalaszto.pas',
  Szamol in 'Units\Szamol.pas',
  B_IsmertetesDialog in 'units\B_IsmertetesDialog.pas' {BIsmDlg},
  Kiralyno in 'Units\kiralyno.pas',
  Kannibalok in 'Units\Kannibalok.pas',
  H_IsmertetesDialog in 'units\H_IsmertetesDialog.pas' {HIsmDlg},
  Hanoi in 'Units\Hanoi.pas',
  Quicksort in 'Units\Quicksort.pas',
  Mergesort in 'Units\Mergesort.pas',
  HatekonysagDialog in 'units\HatekonysagDialog.pas' {HatekonyDlg},
  AdatokDialog in 'Units\AdatokDialog.pas' {Adatok},
  KeresesDialog in 'Units\KeresesDialog.pas' {KezdoAdat},
  About in 'units\About.pas' {AboutDlg},
  Exit in 'Units\exit.pas' {ExitForm},
  Animacio in 'units\Animacio.pas',
  Drawpanel in 'units\DrawPanel.pas',
  Golyo in 'units\Golyo.pas',
  Negyzet in 'units\Negyzet.pas',
  Vonal in 'units\Vonal.pas',
  SakkTabla in 'Units\SakkTabla.pas',
  Korongok in 'Units\Korongok.pas',
  Folyo in 'Units\Folyo.pas',
  StackInt in 'Units\StackInt.pas';

{$R *.res}

begin
  sleep(1000);
  application.initialize;
  splashForm:=TSplashForm.create(application);
  splashForm.show;
  splashForm.update;
  sleep(7000);
  splashForm.hide;
  splashForm.free;
  randomize;
  Application.Title := 'Visual Algorithm Presenter';
  Application.HelpFile := 'vaphelp.chm';
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TSplashForm, SplashForm);
  application.run;
end.