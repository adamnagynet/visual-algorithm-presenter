unit HatekonysagDialog;

interface

uses
  Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, jpeg, ComCtrls, Menus;

const ALGODEF='data\algo.txt';

type
  THatekonyDlg = class(TForm)
    OKBtn: TButton;
    TitleLabel: TLabel;
    MainBevel: TBevel;
    MiniBevel: TBevel;
    TitleImage: TImage;
    CodeMemo: TMemo;
    Image1: TImage;
    Bevel1: TBevel;
    procedure OKBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  end;

implementation

{$R *.dfm}

procedure THatekonyDlg.OKBtnClick(Sender: TObject);
begin
  close;
end;

procedure THatekonyDlg.FormCreate(Sender: TObject);
var
  f:textfile;
  c:char;
begin
end;

end.
