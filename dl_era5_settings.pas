unit getera5_settings;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { Tfrmsettings }

  Tfrmsettings = class(TForm)
    btnInstallPackages: TButton;
    eKEY: TEdit;
    eURL: TEdit;
    GroupBox1: TGroupBox;
    GroupBox5: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Memo1: TMemo;

    procedure FormShow(Sender: TObject);
    procedure btnInstallPackagesClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);

  private
    procedure SaveSettings;
  public

  end;

var
  frmsettings: Tfrmsettings;

implementation

{$R *.lfm}

{ Tfrmsettings }

uses getera5_code;


procedure Tfrmsettings.FormShow(Sender: TObject);
Var
  dat:text;
  st:string;
begin
  if FileExists(GetUserDir+'.cdsapirc') then begin
    AssignFile(dat, GetUserDir+'.cdsapirc'); reset(dat);
     readln(dat, st);
     eURL.Text:=trim(copy(st, 5, length(st)));
     readln(dat, st);
     eKEY.Text:=trim(copy(st, 5, length(st)));
    CloseFile(dat);
  end;
end;


procedure Tfrmsettings.SaveSettings;
Var
  dat:text;
begin
  if trim(eKEY.Text)<>'' then begin
    AssignFile(dat, GetUserDir+'.cdsapirc'); rewrite(dat);
     writeln(dat, 'url: '+eURL.Text);
     writeln(dat, 'key: '+eKEY.Text);
    CloseFile(dat);
  end;
end;

procedure Tfrmsettings.btnInstallPackagesClick(Sender: TObject);
begin
  memo1.Clear;
  frmmain.RunScript(1, '-m pip install cdsapi', memo1);
end;

procedure Tfrmsettings.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  SaveSettings;
end;

end.

