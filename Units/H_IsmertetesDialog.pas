unit H_IsmertetesDialog;

interface

uses
  Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, jpeg, ComCtrls, Menus;

const
  DIMISM='data\dimism.txt';

type
  THIsmDlg = class(TForm)
    OKBtn: TButton;
    mainMemo: TMemo;
    mainBevel: TBevel;
    miniBevel: TBevel;
    mainImage: TImage;
    TitelLabel: TLabel;
    procedure OKBtnClick(sender: TObject);
    procedure formCreate(sender: TObject);
  end;

implementation

{$R *.dfm}

procedure THIsmDlg.OKBtnClick(Sender: TObject);
begin
  close;
end;

procedure THIsmDlg.FormCreate(Sender: TObject);
var
  f:textfile;
  c:char;
begin
  assignfile(f,DIMISM);
  reset(f);
  while not eof(f) do begin
    read(f,c);
    mainMemo.text:=mainMemo.text+c;
  end;
end;

end.
