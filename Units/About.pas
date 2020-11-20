unit About;

interface

uses
  Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls, 
  Buttons, ExtCtrls, jpeg;

type
  TAboutDlg = class(TForm)
    OKBtn: TButton;
    MainBevel: TBevel;
    Image1: TImage;
    MiniBevel: TBevel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure OKBtnClick(Sender: TObject);
  end;

implementation

{$R *.dfm}

procedure TAboutDlg.OKBtnClick(Sender: TObject);
begin
  Close;
end;

end.
