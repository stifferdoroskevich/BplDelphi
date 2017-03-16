unit Splash;

interface

uses
  UIFormSplash,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.Imaging.jpeg, Vcl.Imaging.pngimage;

type
  TFormSplashUI = class(TForm, IFormSplash)
    Panel1: TPanel;
    Image1: TImage;
    Image2: TImage;
    Label1: TLabel;
    LabelInfo: TLabel;
  private
    procedure Init();
    procedure Update(fileName: string);
    procedure SetInfo(ainfo: string);
    procedure CloseX();
  public
    { Public declarations }
  end;

var
  FormSplashUI: TFormSplashUI;

implementation

{$R *.dfm}


procedure TFormSplashUI.CloseX;
begin
  Self.Close();
end;

procedure TFormSplashUI.Init;
begin
  Label1.Caption:= 'Inicializando...';
end;

procedure TFormSplashUI.Update(fileName: string);
begin
  Label1.Caption:= fileName;
  Application.ProcessMessages();
end;

procedure TFormSplashUI.SetInfo(ainfo: string);
begin
  LabelInfo.Caption:= ainfo;
end;

end.
