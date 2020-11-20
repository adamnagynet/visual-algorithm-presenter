unit MeghatarozasDialog;

interface

uses
  Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, jpeg, ComCtrls, Menus;

const
  ALGODEF='data\algo.txt';
  ALGOTUL='data\algotul.txt';

type
  TMeghatDlg = class(TForm)
    OKBtn: TButton;
    mainMemo: TMemo;
    titleLabel: TLabel;
    miniMemo: TMemo;
    mainBevel: TBevel;
    ndMainBevel: TBevel;
    miniTitle: TLabel;
    ndMiniBevel: TBevel;
    miniBevel: TBevel;
    ndMainImage: TImage;
    mainImage: TImage;
    procedure OKBtnClick(sender: TObject);
    procedure formCreate(sender: TObject);
  end;

implementation

{$R *.dfm}

procedure TMeghatDlg.OKBtnClick(Sender: TObject);
begin
  close;
end;

procedure TMeghatDlg.FormCreate(Sender: TObject);
var
  f:textfile;
  c:char;
begin
  assignfile(f,ALGODEF);
  reset(f);
  mainMemo.scrollBars:=ssVertical;
  while not eof(f) do begin
    read(f,c);
    mainMemo.text:=mainMemo.text+c;
  end;
  closefile(f);
  assignfile(f,ALGOTUL);
  reset(f);
  while not eof(f) do begin
    read(f,c);
    miniMemo.text:=miniMemo.text+c;
  end;
  closefile(f);
end;

end.
