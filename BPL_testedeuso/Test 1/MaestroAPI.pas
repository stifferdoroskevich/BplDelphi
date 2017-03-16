unit MaestroAPI;

interface

uses
  UIFormSplash, Forms,
  System.IniFiles, System.SysUtils, System.StrUtils, System.Generics.Collections, System.IOUtils
  ;

type
  TMaestroConfig = class
  protected
    const Section_VERSAO = 'VERSAO_ATUAL';
  public
    Produto: String;//produto
    Versao: String; //versao atual
    BPL: String;
  public
    constructor Create(); reintroduce; virtual;
  end;

  /// MAESTRO API - BOOTSTRAP
  TMaestroApi = class
  protected
    class procedure InternalLoad(f: TForm);
  public
    class procedure Load();
    class procedure ReloadLoad();
  end;

implementation

uses
  AsyncCalls, Splash, ShellApi, Windows,
  System.Classes,
  System.RTTI;

//function GetInitialClass(): TClass;
//var
//  c: TClass;
//  ctx: TRttiContext;
//  typ: TRttiType;
//begin
//  ctx := TRttiContext.Create;
//  typ := ctx.FindType('Unit2.TForm2');
//  if (typ <> nil) and (typ.IsInstance) then c := typ.AsInstance.MetaClassType;
//  ctx.Free;
//
//  if c = nil then
//    c:= GetClass('TForm2');
//  Result:= c;
//end;

{ TMaestroConfig }

constructor TMaestroConfig.Create();
var
  ini: TIniFile;
begin
  // Create INI Object and open or create file test.ini
  ini := TIniFile.Create(IncludeTrailingBackslash(ExtractFilePath(ParamStr(0)))+'maestro.ini');
  try
    Produto:= ini.ReadString('Section_VERSAO', 'PRODUTO', 'dolphin-desktop');
    Versao:= ini.ReadString('Section_VERSAO', 'VERSAO', '17.1.1');
    BPL:= ini.ReadString('Section_VERSAO', 'BPL', 'bplForm-17.1.1.bpl');

    //teste recrea
    ini.WriteString('Section_VERSAO', 'PRODUTO', Produto);
    ini.WriteString('Section_VERSAO', 'VERSAO', Versao);
    ini.WriteString('Section_VERSAO', 'BPL', BPL);

    ini.UpdateFile();
  finally
    ini.Free;
  end;
end;

{ TMaestroApi }

procedure InitializePackageX();
type
  TPackageLoad = procedure;
var
  PackageLoad: TPackageLoad;
  Module: HMODULE;
begin
  Module:= LoadPackage('bplForm2.bpl');

  @PackageLoad := GetProcAddress(Module, 'InitX'); //Do not localize
  if Assigned(PackageLoad) then
    PackageLoad();
end;


function funcCallBackXX(const Arg: IInterface): Integer;
var
  count: Integer;
  config: TMaestroConfig;
  i: IFormSplash;
begin
  i:= Arg as IFormSplash;
  config:= TMaestroConfig.Create(); //configs...

  i.Init();
  i.SetInfo(Format('Atualizando %s%s', [config.Produto, config.Versao]));{sync a tela}
  //loop wait...
  for count := 1 to 10 do
  begin
    i.Update(Format('Arquivo%2d', [count]));{sync a tela}
    Sleep(200);
  end;
  i.CloseX();


  //simulado download...
  CopyFile(PWideChar('.\'+config.Versao+'\'+config.BPL), '.\lib\bplForm2.bpl', false);
  SetCurrentDir('.\lib');
  //carrega BPLS....
  InitializePackageX();
  //cria dinamico o form

end;


class procedure TMaestroApi.Load();
begin
  TMaestroApi.InternalLoad( TFormSplashUI.Create(nil) );
end;

class procedure TMaestroApi.ReloadLoad();
var
  appName: PChar;
begin
  //close....
  appName:= PChar(Application.ExeName);
  Application.Destroy();//??

  ShellExecute(0, nil, appName, nil, nil, SW_SHOWNORMAL);
end;

class procedure TMaestroApi.InternalLoad(f: TForm);
var
  i: IFormSplash;
begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;


  //inicializa o SPLASH
  f.Show();
  f.GetInterface(IFormSplash, i);

  //ATUALIZA VERSAO...
  AsyncCalls.AsyncCall(
      funcCallBackXX,
      i{params}
  );
  Application.Run;
end;


end.
