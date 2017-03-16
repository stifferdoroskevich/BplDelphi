unit UIFormSplash;

interface

type
  IFormSplash = interface
    ['{771D8C1F-424D-4CF0-A706-27DF46268ECA}']
    procedure Init();
    procedure Update(fileName: string);
    procedure SetInfo(ainfo: string);
    procedure CloseX();
  end;

implementation

end.
