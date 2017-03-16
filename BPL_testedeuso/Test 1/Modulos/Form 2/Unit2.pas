unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Menus,
  Vcl.Buttons;

type
  TForm2 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    BitBtn1: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

uses
  ShellApi;

procedure ReloadLoad();
var
  appName: PChar;
begin
  //close....
  appName:= PChar(Application.ExeName);
  Application.Destroy();//??

  ShellExecute(0, nil, appName, nil, nil, SW_SHOWNORMAL);
end;

procedure TForm2.BitBtn1Click(Sender: TObject);
begin
  ReloadLoad();
end;

procedure InitX(); stdcall;
begin
  with TForm2.Create(Application) do
    begin
      ShowModal();
      Application.Terminate();
      Halt(0);
    end;
end;

exports
  InitX;

end.
