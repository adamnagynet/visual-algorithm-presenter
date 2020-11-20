unit exit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, jpeg;

type
  TExitForm = class(TForm)
    ExitImage: TImage;
    Bevel1: TBevel;
    Label1: TLabel;
    ExitButton: TButton;
    BackButton: TButton;
  end;

var
  ExitForm: TExitForm;

implementation

{$R *.dfm}

end.
