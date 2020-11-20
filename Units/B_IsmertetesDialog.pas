unit B_IsmertetesDialog;

interface

uses
  Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, jpeg, ComCtrls, Menus;

const
  BACKISM='data\backism.txt';
  BACKPSZ='data\backpsz.txt';

type
  TBIsmDlg = class(TForm)
    OKBtn: TButton;
    mainMemo: TMemo;
    mainBevel: TBevel;
    miniBevel: TBevel;
    mainImage: TImage;
    TitelLabel: TLabel;
    MiniMemo: TMemo;
    ndMainBevel: TBevel;
    ndMiniBevel: TBevel;
    ndLabel: TLabel;
    MiniImage: TImage;
    procedure OKBtnClick(sender: TObject);
    procedure formCreate(sender: TObject);
  end;

implementation

{$R *.dfm}

procedure TBIsmDlg.OKBtnClick(Sender: TObject);
begin
  close;
end;

procedure TBIsmDlg.FormCreate(Sender: TObject);
var
  f:textfile;
  c:char;
begin
  assignfile(f,BACKISM);
  reset(f);
  mainMemo.scrollBars:=ssVertical;
  while not eof(f) do begin
    read(f,c);
    mainMemo.text:=mainMemo.text+c;
  end;
  closefile(f);
  assignfile(f,BACKPSZ);
  reset(f);
  while not eof(f) do begin
    read(f,c);
    miniMemo.text:=miniMemo.text+c;
  end;
  closefile(f);
end;

end.
