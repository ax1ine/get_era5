unit dl_era5_settings;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Spin;

type

  { Tfrmsettings }

  Tfrmsettings = class(TForm)
    btnInstallPackages: TButton;
    eKey: TEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Memo1: TMemo;
    OD: TOpenDialog;
    seUID: TSpinEdit;

    procedure btnInstallPackagesClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);

  private
    procedure SaveSettings;
  public

  end;

var
  frmsettings: Tfrmsettings;

implementation

{$R *.lfm}

{ Tfrmsettings }

uses dl_era5_code;


procedure Tfrmsettings.FormShow(Sender: TObject);
Var
  dat:text;
  st:string;
begin
  if FileExists(GetUserDir+'.cdsapirc') then begin
    AssignFile(dat, GetUserDir+'.cdsapirc'); reset(dat);
     readln(dat, st);
     readln(dat, st);
     st:=copy(st, 5, length(st));
     seUID.Text:=trim(copy(st, 1, Pos(':', st)-1));
     eKey.Text:=trim(copy(st, Pos(':', st)+1, length(st)));
    CloseFile(dat);
  end;
end;

procedure Tfrmsettings.SaveSettings;
Var
  dat:text;
begin
  if trim(eKey.Text)<>'' then begin
    AssignFile(dat, GetUserDir+'.cdsapirc'); rewrite(dat);
     writeln(dat, 'url: https://cds.climate.copernicus.eu/api/v2');
     writeln(dat, 'key: '+seUID.Text+':'+eKey.Text);
    CloseFile(dat);
  end;
end;

procedure Tfrmsettings.btnInstallPackagesClick(Sender: TObject);
begin
  memo1.Clear;
  memo1.Visible:=true;
  frmmain.RunScript(1, '-m pip install cdsapi', memo1);
end;

procedure Tfrmsettings.FormClose(Sender: TObject; var CloseAction: TCloseAction
  );
begin
  SaveSettings;
end;

end.

