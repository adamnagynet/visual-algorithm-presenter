unit KeresesDialog;

interface

uses
  Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, Golyo, Szekvenc, ComCtrls, jpeg;

type
  TKezdoAdat = class(TForm)
    OKBtn: TButton;
    mainImage: TImage;
    mainBevel: TBevel;
    keresett: TEdit;
    kezdetLabel: TLabel;
    elemszam_Label: TLabel;
    keresett_Label: TLabel;
    elemszambox: TComboBox;
    miniBevel: TBevel;
    CancelBut: TButton;
    procedure OKBtnClick(sender: TObject);
  end;

implementation

{$R *.dfm}

procedure TKezdoAdat.OKBtnClick(sender: TObject);
begin
  Hide;
end;

end.
