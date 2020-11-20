unit splash;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls;

type
  TSplashForm = class(TForm)
    SplashImage: TImage;
  end;

var
  SplashForm: TSplashForm;

implementation

{$R *.dfm}

end.
