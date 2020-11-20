unit AdatokDialog;

interface

uses
  Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, Golyo, Szekvenc, ComCtrls, jpeg;

type
  TAdatok = class(TForm)
    OKBtn: TButton;
    mainImage: TImage;
    mainBevel: TBevel;
    kezdetLabel: TLabel;
    elemszam_Label: TLabel;
    keresett_Label: TLabel;
    elemszambox: TComboBox;
    miniBevel: TBevel;
    elemszam2box: TComboBox;
    Button1: TButton;
    procedure OKBtnClick(sender: TObject);
  end;

implementation

{$R *.dfm}

procedure TAdatok.OKBtnClick(sender: TObject);
begin
  Hide;
end;

end.
