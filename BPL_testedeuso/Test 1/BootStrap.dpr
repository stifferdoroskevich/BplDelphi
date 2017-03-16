program BootStrap;

uses
  Vcl.Forms,
  Splash in 'Splash.pas' {FormSplashUI},
  AsyncCalls in 'AsyncCalls.pas',
  MaestroAPI in 'MaestroAPI.pas',
  UIFormSplash in 'UIFormSplash.pas';

{$R *.res}

begin
  TMaestroApi.Load();
end.
