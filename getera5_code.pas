unit getera5_code;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, ListFilterEdit, Forms, Controls, Graphics,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, Spin, Buttons, CheckLst, LCLIntf,
  FileCtrl, Process, IniFiles, DateUtils, Math, getera5_settings;

type

  { Tfrmmain }

  Tfrmmain = class(TForm)
    btnDownload: TButton;
    btnScript: TBitBtn;
    btnSettings: TButton;
    cbDataset: TComboBox;
    cgDay: TCheckListBox;
    cgLevel: TCheckListBox;
    cgMonth: TCheckListBox;
    cgParameter: TCheckListBox;
    cgTime: TCheckListBox;
    cgYear: TCheckListBox;
    gbMonth: TGroupBox;
    gbMonth1: TGroupBox;
    gbMonth2: TGroupBox;
    gbYear: TGroupBox;
    GroupBox12: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    lbAllLevels: TLabel;
    lbAllParameters: TLabel;
    lbAllYears: TLabel;
    lbAllMonth: TLabel;
    lbAllDays: TLabel;
    lbAllHours: TLabel;
    cgParamaterFilter: TListFilterEdit;
    mLog: TMemo;
    PageControl1: TPageControl;
    rgGrid: TRadioGroup;
    rgStream: TRadioGroup;
    sexmax: TSpinEdit;
    sexmin: TSpinEdit;
    seymax: TSpinEdit;
    seymin: TSpinEdit;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;


    procedure btnSettingsClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnDownloadClick(Sender: TObject);
    procedure btnScriptClick(Sender: TObject);
    procedure cbDatasetChange(Sender: TObject);
    procedure lbAllDaysClick(Sender: TObject);
    procedure lbAllHoursClick(Sender: TObject);
    procedure lbAllLevelsClick(Sender: TObject);
    procedure lbAllMonthClick(Sender: TObject);
    procedure lbAllParametersClick(Sender: TObject);
    procedure lbAllYearsClick(Sender: TObject);
    procedure rgStreamClick(Sender: TObject);

  private
    procedure GetVariablesSurface;
    procedure GetVariablesPressure;
    procedure ERA5GetScript;

  public
    procedure RunScript(ExeFlag:integer; cmd:string; Sender:TMemo);
  end;

resourcestring
  SJan = 'January';  SFeb = 'February'; SMar = 'March'; SApr = 'April';
  SMay = 'May'; SJun = 'Jun'; SJul = 'July'; SAug = 'August';
  SSep = 'September'; SOct ='October'; SNov = 'November'; SDec = 'December';

  SSelectProduct   = 'Please, select at least one product';
  SSelectVariable  = 'Please, select at least one variable';
  SSelectLevel     = 'Please, select at least one level';
  SSelectYear      = 'Please, select at least one year';
  SSelectMonth     = 'Please, select at least one month';
  SSelectDay       = 'Please, select at least one day';
  SSelectHour      = 'Please, select at least one hour';

  SNoPython        = 'Python is not found';
  SFileExists      = 'File exists. Rewrite anyway?';
  SNoKey           = 'CDS key is not found. Please, input and save it';


var
  frmmain: Tfrmmain;
  GlobalPath, IniFileName, ERA5Path: string;

const
  buf_len = 3000;

implementation

{$R *.lfm}

{ Tfrmmain }

procedure Tfrmmain.FormShow(Sender: TObject);
Var
  Ini: TIniFile;
  k: integer;
  yy, mn, dd: word;
begin
 mLog.Clear; //clean the log memo

  (* Define global path to the *.exe file *)
  GlobalPath:=ExtractFilePath(Application.ExeName);

  (* Settings file *)
   IniFileName:=GetUserDir+'.climateshell';
    if not FileExists(IniFileName) then begin
      Ini:=TIniFile.Create(IniFileName);
      Ini.WriteInteger('main', 'Language', 0);
      Ini.Free;
    end;

  (* Define global delimiter *)
  DefaultFormatSettings.DecimalSeparator := '.';

   (* Check for existing essencial program folders *)
  if not DirectoryExists(GlobalPath+'data') then
     CreateDir(GlobalPath+'data');

  ERA5Path:=GlobalPath+'data'+PathDelim+'era5'+PathDelim;
  if not DirectoryExists(ERA5Path) then CreateDir(ERA5Path);

  DecodeDate(now, yy, mn, dd);

    for k:=1979 to yy do begin
     cgYear.Items.Add(InttoStr(k));
     cgYear.Checked[k-1979]:=true;
    end;

    for k:=1 to 12 do begin
     case k of
      1:  cgMonth.Items.Add(SJan);
      2:  cgMonth.Items.Add(SFeb);
      3:  cgMonth.Items.Add(SMar);
      4:  cgMonth.Items.Add(SApr);
      5:  cgMonth.Items.Add(SMay);
      6:  cgMonth.Items.Add(SJun);
      7:  cgMonth.Items.Add(SJul);
      8:  cgMonth.Items.Add(SAug);
      9:  cgMonth.Items.Add(SSep);
      10: cgMonth.Items.Add(SOct);
      11: cgMonth.Items.Add(SNov);
      12: cgMonth.Items.Add(SDec);
     end;
     cgMonth.Checked[k-1]:=true;
    end;

    cgDay.Items.Clear;
     for k:=1 to 31 do begin
       cgDay.Items.Add(InttoStr(k));
       cgDay.Checked[k-1]:=true;
     end;

     cgTime.Items.Clear;
     for k:=0 to 23 do begin
        if k<10 then cgTime.Items.Add('0'+InttoStr(k)+':00') else
                     cgTime.Items.Add(InttoStr(k)+':00');
       cgTime.Checked[k]:=true;
     end;
end;


procedure Tfrmmain.cbDatasetChange(Sender: TObject);
begin
mLog.Clear;

  if (cbDataset.ItemIndex=0) or (cbDataset.ItemIndex=2) then begin
     cgLevel.Items.Clear;
     cgLevel.Columns:=1;
     cgLevel.Items.Add('Surface');
     cgLevel.Checked[0]:=true;
     cgLevel.Enabled:=false;
     GetVariablesSurface;
  end;

  if (cbDataset.ItemIndex=1) or (cbDataset.ItemIndex=3) then begin
     cgLevel.Clear;
     cgLevel.Columns:=10;
     With cgLevel.Items do begin
         Add('1000');
         Add('975');
         Add('950');
         Add('925');
         Add('900');
         Add('875');
         Add('850');
         Add('825');
         Add('800');
         Add('775');
         Add('750');
         Add('700');
         Add('650');
         Add('600');
         Add('550');
         Add('500');
         Add('450');
         Add('400');
         Add('350');
         Add('300');
         Add('250');
         Add('225');
         Add('200');
         Add('175');
         Add('150');
         Add('125');
         Add('100');
         Add('70');
         Add('50');
         Add('30');
         Add('20');
         Add('10');
         Add('7');
         Add('5');
         Add('3');
         Add('2');
         Add('1');
     end;
     cgLevel.Enabled:=true;
     GetVariablesPressure;
  end;

  if cbDataset.ItemIndex>=2 then begin
     cgDay.Enabled:=true;

     rgStream.Items.Clear;
     with rgStream.Items do begin
       Add('Ensemble mean');
       Add('Ensemble members');
       Add('Ensemble spread');
       Add('Reanalysis');
     end;
  end;


  if cbDataset.ItemIndex<2 then begin;
   cgDay.Enabled:=false;

   rgStream.Items.Clear;
    with rgStream.Items do begin
     Add('Monthly averaged ensemble members');
     Add('Monthly averaged ensemble members by hour of day');
     Add('Monthly averaged reanalysis');
     Add('Monthly averaged reanalysis by hour of day');
    end;
  end;

  cgParamaterFilter.FilteredListBox:=nil;
  cgParamaterFilter.FilteredListBox:=cgParameter;

  PageControl1.Enabled:=false;
end;



procedure Tfrmmain.rgStreamClick(Sender: TObject);
Var
  k: integer;
begin
 if (cbDataset.ItemIndex<2) and ((rgStream.ItemIndex=0) or (rgStream.ItemIndex=2)) then begin
     for k:=1 to 23 do begin
       cgTime.Checked[k]:=false;
       cgTime.ItemEnabled[k]:=false;
     end;
 end;

 if ((cbDataset.ItemIndex<2) and (rgStream.ItemIndex=1)) or
    ((cbDataset.ItemIndex>=2) and (rgStream.ItemIndex<3)) then begin
     for k:=0 to 23 do begin
       if (k in [0,3,6,9,12,15,18,21]) then begin
         cgTime.Checked[k]:=true;
         cgTime.ItemEnabled[k]:=true;
       end else begin
         cgTime.Checked[k]:=false;
         cgTime.ItemEnabled[k]:=false;
       end;
     end;
 end;

 if ((cbDataset.ItemIndex<2) and (rgStream.ItemIndex=3)) or
    (cbDataset.ItemIndex>=2) and (rgStream.ItemIndex=3) then begin
     for k:=0 to 23 do begin
       cgTime.Checked[k]:=true;
       cgTime.ItemEnabled[k]:=true;
     end;
 end;

 PageControl1.Enabled:=true;
 btnScript.Enabled:=true;
 btnDownload.Enabled:=true;
end;



procedure Tfrmmain.ERA5GetScript;
Var
  dat: text;
  k, fl: integer;
  e5year, e5month, e5day, e5hour, e5variable, e5area, e5grid, e5level:string;
  e5reanalysis, e5product, par_str, mn_str, dd_str, grid_str: string;
begin
  // reanalysis
  case cbDataset.ItemIndex of
   0: e5reanalysis:='reanalysis-era5-single-levels-monthly-means';
   1: e5reanalysis:='reanalysis-era5-pressure-levels-monthly-means';
   2: e5reanalysis:='reanalysis-era5-single-levels';
   3: e5reanalysis:='reanalysis-era5-pressure-levels';
  end;
  e5reanalysis:=QuotedStr(e5reanalysis);

  // product type
  if rgStream.Items.Strings[rgStream.ItemIndex]='Monthly averaged ensemble members' then
     e5product:=QuotedStr('members-monthly-means-of-daily-means');
  if rgStream.Items.Strings[rgStream.ItemIndex]='Monthly averaged ensemble members by hour of day' then
     e5product:=QuotedStr('members-synoptic-monthly-means');
  if rgStream.Items.Strings[rgStream.ItemIndex]='Monthly averaged reanalysis' then
     e5product:=QuotedStr('reanalysis-monthly-means-of-daily-means');
  if rgStream.Items.Strings[rgStream.ItemIndex]='Monthly averaged reanalysis by hour of day' then
     e5product:=QuotedStr('reanalysis-synoptic-monthly-means');
  if rgStream.Items.Strings[rgStream.ItemIndex]='Ensemble mean' then
     e5product:=QuotedStr('ensemble_mean');
  if rgStream.Items.Strings[rgStream.ItemIndex]='Ensemble members' then
     e5product:=QuotedStr('ensemble_members');
  if rgStream.Items.Strings[rgStream.ItemIndex]='Ensemble spread' then
     e5product:=QuotedStr('ensemble_spread');
  if rgStream.Items.Strings[rgStream.ItemIndex]='Reanalysis' then
     e5product:=QuotedStr('reanalysis');

  // variables
  e5variable:=''; fl:=0;
  for k:=0 to cgParameter.Items.Count-1 do
    if cgParameter.Checked[k]=true then begin
      par_str:=LowerCase(cgParameter.Items.Strings[k]);
      par_str:=copy(par_str, 1, Pos('[', par_str)-2);
      par_str:=StringReplace(par_str, ' ', '_', [rfReplaceAll]);
      par_str:=StringReplace(par_str, '-', '_', [rfReplaceAll]);
      e5variable:=e5variable+QuotedStr(par_str)+',';
      inc(fl);
  end;
  if fl=0 then begin
   if MessageDlg(SSelectVariable, mtWarning, [mbOk], 0)=mrOk then exit;
  end else begin
   e5variable:=Copy(e5variable,1, length(e5variable)-1);
    if fl>1 then e5variable:='['+e5variable+']';
  end;

  // levels
  e5level:=''; fl:=0;
  for k:=0 to cgLevel.Items.Count-1 do
    if cglevel.Checked[k]=true then begin
      e5level:=e5level+QuotedStr(cgLevel.Items.Strings[k])+',';
      inc(fl);
  end;
  if fl=0 then begin
   if MessageDlg(SSelectLevel, mtWarning, [mbOk], 0)=mrOk then exit;
  end else begin
   e5level:=Copy(e5level,1, length(e5level)-1);
   if fl>1 then e5level:='['+e5level+']';
  end;


  // years
  e5year:=''; fl:=0;
  for k:=0 to cgYear.Items.Count-1 do
    if cgYear.Checked[k]=true then begin
      e5year:=e5year+QuotedStr(cgYear.Items.Strings[k])+',';
      inc(fl);
  end;
  if fl=0 then begin
   if MessageDlg(SSelectYear, mtWarning, [mbOk], 0)=mrOk then exit;
  end else begin
   e5year:=Copy(e5year,1, length(e5year)-1);
   if fl>1 then e5year:='['+e5year+']';
  end;


  // month
  e5month:=''; fl:=0;
  for k:=0 to cgMonth.Items.Count-1 do
    if cgMonth.Checked[k]=true then begin
     mn_str:=InttoStr(k+1);
     if length(mn_str)<2 then mn_str:='0'+mn_str;
      e5month:=e5month+QuotedStr(mn_str)+',';
      inc(fl);
  end;
  if fl=0 then begin
   if MessageDlg(SSelectMonth, mtWarning, [mbOk], 0)=mrOk then exit;
  end else begin
   e5month:=Copy(e5month,1, length(e5month)-1);
   if fl>1 then e5month:='['+e5month+']';
  end;


  // days
  e5day:=''; fl:=0;
  for k:=0 to cgDay.Items.Count-1 do
    if cgDay.Checked[k]=true then begin
     dd_str:=cgDay.Items.Strings[k];
     if length(dd_str)<2 then dd_str:='0'+dd_str;
      e5day:=e5day+QuotedStr(dd_str)+',';
      inc(fl);
  end;
  if fl=0 then begin
   if MessageDlg(SSelectDay, mtWarning, [mbOk], 0)=mrOk then exit;
  end else begin
   e5day:=Copy(e5day,1, length(e5day)-1);
     if fl>1 then e5day:='['+e5day+']';
  end;


  // hours
  e5hour:=''; fl:=0;
  for k:=0 to cgTime.Items.Count-1 do
    if cgTime.Checked[k]=true then begin
      e5hour:=e5hour+QuotedStr(cgTime.Items.Strings[k])+',';
      inc(fl);
  end;
  if fl=0 then begin
   if MessageDlg(SSelectHour, mtWarning, [mbOk], 0)=mrOk then exit;
  end else begin
   e5hour:=Copy(e5hour,1, length(e5hour)-1);
   if fl>1 then e5hour:='['+e5hour+']';
  end;


  // region
  e5area:='['+seymax.Text+', '+sexmin.Text+', '+seymin.Text+', '+sexmax.Text+']';

  // grid
  grid_str:=rgGrid.Items.Strings[rgGrid.ItemIndex];
  e5grid:='['+grid_str+' ,'+grid_str+']';


  AssignFile(dat, ERA5Path+'getera5.py'); rewrite(dat);
   writeln(dat, 'import subprocess');
   writeln(dat, 'import sys');
   writeln(dat, '');
   writeln(dat, 'try:');
   writeln(dat, '    import cdsapi');
   writeln(dat, 'except ImportError:');
   writeln(dat, '    subprocess.call([sys.executable, "-m", "pip", "install", "cdsapi"])');
   writeln(dat, '    import cdsapi');
   writeln(dat, '');
   writeln(dat, 'c = cdsapi.Client()');
   writeln(dat, '');
   writeln(dat, 'c.retrieve(');
   writeln(dat, '    '+e5reanalysis+',');
   writeln(dat, '    {');
   writeln(dat, '        '+QuotedStr('product_type')+':'+e5product+',');
   writeln(dat, '        '+QuotedStr('format')+':'+QuotedStr('netcdf')+',');
   writeln(dat, '        '+QuotedStr('variable')+':'+e5variable+',');
   if cgLevel.Enabled=true then
   writeln(dat, '        '+QuotedStr('pressure_level')+':'+e5level+',');
   writeln(dat, '        '+QuotedStr('year')+':'+e5year+',');
   writeln(dat, '        '+QuotedStr('month')+':'+e5month+',');
   if cgDay.Enabled=true then
   writeln(dat, '        '+QuotedStr('day')+':'+e5day+',');
   writeln(dat, '        '+QuotedStr('time')+':'+e5hour+',');
   writeln(dat, '        '+QuotedStr('area')+':'+e5area+',');
   writeln(dat, '        '+QuotedStr('grid')+':'+e5grid);
   writeln(dat, '    },');
   writeln(dat, '    '+QuotedStr(ERA5Path+'download.nc')+')');
  CloseFile(dat);
end;



procedure Tfrmmain.btnScriptClick(Sender: TObject);
begin
  mLog.Clear;
    ERA5GetScript;
  mLog.Lines.LoadFromFile(ERA5Path+'getera5.py');
end;


procedure Tfrmmain.btnDownloadClick(Sender: TObject);
begin
  if not FileExists(GetUserDir+'.cdsapirc') then
   if MessageDlg(SNoKey, mtWarning, [mbOk], 0)=mrOk then exit;

  mLog.Clear;
  ERA5GetScript;

    RunScript(1, ERA5Path+'getera5.py', mLog);
  OpenDocument(ERA5Path);
end;


(* Launching scripts *)
procedure Tfrmmain.RunScript(ExeFlag:integer; cmd:string; Sender:TMemo);
Var
  Ini:TIniFile;
  P:TProcess;
  ExeName, buf, s: string;
  WaitOnExit:boolean;
  i, j: integer;
begin
(*
  ExeFlag = 0 /Random executable file
  ExeFlag = 1 /Python
  ExeFlag = 2 /Surfer
  ExeFlag = 3 /Grapher
  ExeFlag = 4 /CDO
  ExeFlag = 5 /NCO
*)

{$IFDEF WINDOWS}
  Ini := TIniFile.Create(IniFileName);
  try
    case ExeFlag of
     0: begin
        ExeName:='';
        WaitOnExit:=false;
     end;
     1: begin
        ExeName:=Ini.ReadString('main', 'PythonPath', '');
        WaitOnExit:=false;
        if not FileExists(ExeName) then
           if Messagedlg(SNoPython, mtwarning, [mbOk], 0)=mrOk then exit;
     end;
   {  2: begin
        ExeName:=Ini.ReadString('main', 'SurferPath',  '');
        WaitOnExit:=true;
        if not FileExists(ExeName) then
           if Messagedlg(SNoSurfer, mtwarning, [mbOk], 0)=mrOk then exit;
     end;
     3: begin
        ExeName:=Ini.ReadString('main', 'GrapherPath', '');
        WaitOnExit:=true;
        if not FileExists(ExeName) then
           if Messagedlg(SNoGrapher, mtwarning, [mbOk], 0)=mrOk then exit;
     end;
     4: begin
        ExeName:=GlobalSupportPath+PathDelim+'cdo'+PathDelim+'cdo.exe';
       // showmessage(exename);
        WaitOnExit:=true;
        if not FileExists(ExeName) then
           if Messagedlg(SNoCDO,    mtwarning, [mbOk], 0)=mrOk then exit;
     end; }
    end;
  finally
   ini.Free;
  end;
{$ENDIF}

{$IFDEF UNIX}
  Case ExeFlag of
    1: ExeName :='python3';
    4: ExeName :='cdo';
    5: ExeName :='nco';
  end;
{$ENDIF}

 try
  P:=TProcess.Create(Nil);
  P.Commandline:=trim(ExeName+' '+cmd);
//  showmessage(P.CommandLine);
  P.Options:= [poUsePipes, poNoConsole, poStderrToOutPut];

  if WaitOnExit=true then P.Options:=P.Options+[poWaitOnExit];
  P.Execute;

  repeat
   SetLength(buf, buf_len);
   SetLength(buf, p.output.Read(buf[1], length(buf))); //waits for the process output
   // cut the incoming stream to lines:
   s:=s + buf; //add to the accumulator
   repeat //detect the line breaks and cut.
     i:=Pos(#13, s);
     j:=Pos(#10, s);
     if i=0 then i:=j;
     if j=0 then j:=i;
     if j = 0 then Break; //there are no complete lines yet.
     if (Sender<> nil) then begin
       Sender.Lines.Add(Copy(s, 1, min(i, j) - 1)); //return the line without the CR/LF characters
       Application.ProcessMessages;
     end;
     s:=Copy(s, max(i, j) + 1, length(s) - max(i, j)); //remove the line from accumulator
   until false;
 until buf = '';
 if (s <> '') and (Sender<>nil) then begin
   Sender.Lines.Add(s);
   Application.ProcessMessages;
 end;
finally
 P.Free;
end;
end;


procedure Tfrmmain.lbAllParametersClick(Sender: TObject);
Var
  k:integer;
begin
  for k:=0 to cgParameter.Count-1 do
    cgParameter.Checked[k]:= not cgParameter.Checked[k];
end;

procedure Tfrmmain.lbAllLevelsClick(Sender: TObject);
Var
  k:integer;
begin
  if cgLevel.Enabled=true then
  for k:=0 to cgLevel.Count-1 do
    cgLevel.Checked[k]:= not cgLevel.Checked[k];
end;


procedure Tfrmmain.lbAllYearsClick(Sender: TObject);
Var
  k:integer;
begin
  for k:=0 to cgYear.Count-1 do
    cgYear.Checked[k]:= not cgYear.Checked[k];
end;


procedure Tfrmmain.lbAllMonthClick(Sender: TObject);
Var
  k:integer;
begin
  for k:=0 to cgMonth.Count-1 do
    cgMonth.Checked[k]:= not cgMonth.Checked[k];
end;


procedure Tfrmmain.lbAllDaysClick(Sender: TObject);
Var
  k:integer;
begin
  for k:=0 to cgDay.Count-1 do
    cgDay.Checked[k]:= not cgDay.Checked[k];
end;


procedure Tfrmmain.lbAllHoursClick(Sender: TObject);
Var
  k:integer;
begin
  for k:=0 to cgTime.Count-1 do
    cgTime.Checked[k]:= not cgTime.Checked[k];
end;


procedure Tfrmmain.btnSettingsClick(Sender: TObject);
begin
frmsettings:= Tfrmsettings.Create(Self);
 try
  if not frmsettings.ShowModal = mrOk then exit;
 finally
  frmsettings.Free;
  frmsettings := nil;
 end;
end;


Procedure Tfrmmain.GetVariablesSurface;
begin
  cgParameter.Clear;
  With cgParameter.Items do begin
   Add('100m u-component of wind [m s-1]');
   Add('100m v-component of wind [m s-1]');
   Add('10m u-component of neutral wind [m s-1]');
   Add('10m u-component of wind [m s-1]');
   Add('10m v-component of neutral wind [m s-1]');
   Add('10m v-component of wind [m s-1]');
   Add('10m wind speed [m s-1]');
   Add('2m dewpoint temperature [K]');
   Add('2m temperature [K]');
   Add('Air density over the oceans [kg m-3]');
   Add('Angle of sub-gridscale orography [radians]');
   Add('Anisotropy of sub-gridscale orography [~]');
   Add('Benjamin-feir index [dimensionless]');
   Add('Boundary layer dissipation [J m-2]');
   Add('Boundary layer height [m]');
   Add('Charnock [~]');
   Add('Clear-sky direct solar radiation at surface [J m-2]');
   Add('Cloud base height [m]');
   Add('Coefficient of drag with waves [dimensionless]');
   Add('Convective available potential energy [J kg-1]');
   Add('Convective inhibition [J kg-1]');
   Add('Convective precipitation [m]');
   Add('Convective rain rate [kg m-2 s-1]');
   Add('Convective snowfall [m of water equivalent]');
   Add('Convective snowfall rate water equivalent [kg m-2 s-1]');
   Add('Downward UV radiation at the surface [J m-2]');
   Add('Duct base height [m]');
   Add('Eastward gravity wave surface stress [N m-2 s]');
   Add('Eastward turbulent surface stress [N m-2 s]');
   Add('Evaporation [m of water equivalent]');
   Add('Forecast albedo [(0 - 1)]');
   Add('Forecast logarithm of surface roughness for heat [~]');
   Add('Forecast surface roughness [m]');
   Add('Free convective velocity over the oceans [m s-1]');
   Add('Friction velocity [m s-1]');
   Add('Gravity wave dissipation [J m-2]');
   Add('High cloud cover [(0 - 1)]');
   Add('High vegetation cover [(0 - 1)]');
   Add('Ice temperature layer 1 [K]');
   Add('Ice temperature layer 2 [K]');
   Add('Ice temperature layer 3 [K]');
   Add('Ice temperature layer 4 [K]');
   Add('Instantaneous 10m wind gust [m s-1]');
   Add('Instantaneous eastward turbulent surface stress [N m-2]');
   Add('Instantaneous large-scale surface precipitation fraction [(0 - 1)]');
   Add('Instantaneous moisture flux [kg m-2 s-1]');
   Add('Instantaneous northward turbulent surface stress [N m-2]');
   Add('Instantaneous surface sensible heat flux [W m-2]');
   Add('K index [K]');
   Add('Lake bottom temperature [K]');
   Add('Lake cover [(0 - 1)]');
   Add('Lake depth [m]');
   Add('Lake ice depth [m]');
   Add('Lake ice temperature [K]');
   Add('Lake mix-layer depth [m]');
   Add('Lake mix-layer temperature [K]');
   Add('Lake shape factor [dimensionless]');
   Add('Lake total layer temperature [K]');
   Add('Land-sea mask [(0 - 1)]');
   Add('Large scale rain rate [kg m-2 s-1]');
   Add('Large scale snowfall rate water equivalent [kg m-2 s-1]');
   Add('Large-scale precipitation [m]');
   Add('Large-scale precipitation fraction [s]');
   Add('Large-scale snowfall [m of water equivalent]');
   Add('Leaf area index, high vegetation [m2 m-2]');
   Add('Leaf area index, low vegetation [m2 m-2]');
   Add('Low cloud cover [(0 - 1)]');
   Add('Low vegetation cover [(0 - 1)]');
   Add('Magnitude of turbulent surface stress [N m-2 s]');
   Add('Maximum individual wave height [m]');
   Add('Mean boundary layer dissipation [W m-2]');
   Add('Mean convective precipitation rate [kg m-2 s-1]');
   Add('Mean convective snowfall rate [kg m-2 s-1]');
   Add('Mean direction of total swell [degrees]');
   Add('Mean direction of wind waves [degrees]');
   Add('Mean eastward gravity wave surface stress [N m-2]');
   Add('Mean eastward turbulent surface stress [N m-2]');
   Add('Mean evaporation rate [kg m-2 s-1]');
   Add('Mean gravity wave dissipation [W m-2]');
   Add('Mean large-scale precipitation fraction [Proportion]');
   Add('Mean large-scale precipitation rate [kg m-2 s-1]');
   Add('Mean large-scale snowfall rate [kg m-2 s-1]');
   Add('Mean magnitude of turbulent surface stress [N m-2]');
   Add('Mean northward gravity wave surface stress [N m-2]');
   Add('Mean northward turbulent surface stress [N m-2]');
   Add('Mean period of total swell [s]');
   Add('Mean period of wind waves [s]');
   Add('Mean potential evaporation rate [kg m-2 s-1]');
   Add('Mean runoff rate [kg m-2 s-1]');
   Add('Mean sea level pressure [Pa]');
   Add('Mean snow evaporation rate [kg m-2 s-1]');
   Add('Mean snowfall rate [kg m-2 s-1]');
   Add('Mean snowmelt rate [kg m-2 s-1]');
   Add('Mean square slope of waves [dimensionless]');
   Add('Mean sub-surface runoff rate [kg m-2 s-1]');
   Add('Mean surface direct short-wave radiation flux [W m-2]');
   Add('Mean surface direct short-wave radiation flux, clear sky [W m-2]');
   Add('Mean surface downward UV radiation flux [W m-2]');
   Add('Mean surface downward long-wave radiation flux [W m-2]');
   Add('Mean surface downward long-wave radiation flux, clear sky [W m-2]');
   Add('Mean surface downward short-wave radiation flux [W m-2]');
   Add('Mean surface downward short-wave radiation flux, clear sky [W m-2]');
   Add('Mean surface latent heat flux [W m-2]');
   Add('Mean surface net long-wave radiation flux [W m-2]');
   Add('Mean surface net long-wave radiation flux, clear sky [W m-2]');
   Add('Mean surface net short-wave radiation flux [W m-2]');
   Add('Mean surface net short-wave radiation flux, clear sky [W m-2]');
   Add('Mean surface runoff rate [kg m-2 s-1]');
   Add('Mean surface sensible heat flux [W m-2]');
   Add('Mean top downward short-wave radiation flux [W m-2]');
   Add('Mean top net long-wave radiation flux [W m-2]');
   Add('Mean top net long-wave radiation flux, clear sky [W m-2]');
   Add('Mean top net short-wave radiation flux [W m-2]');
   Add('Mean top net short-wave radiation flux, clear sky [W m-2]');
   Add('Mean total precipitation rate [kg m-2 s-1]');
   Add('Mean vertical gradient of refractivity inside trapping layer [m-1]');
   Add('Mean vertically integrated moisture divergence [kg m-2 s-1]');
   Add('Mean wave direction [degree true]');
   Add('Mean wave direction of first swell partition [degrees]');
   Add('Mean wave direction of second swell partition [degrees]');
   Add('Mean wave direction of third swell partition [degrees]');
   Add('Mean wave period [s]');
   Add('Mean wave period based on first moment [s]');
   Add('Mean wave period based on first moment for swell [s]');
   Add('Mean wave period based on first moment for wind waves [s]');
   Add('Mean wave period based on second moment for swell [s]');
   Add('Mean wave period based on second moment for wind waves [s]');
   Add('Mean wave period of first swell partition [s]');
   Add('Mean wave period of second swell partition [s]');
   Add('Mean wave period of third swell partition [s]');
   Add('Mean zero-crossing wave period [s]');
   Add('Medium cloud cover [(0 - 1)]');
   Add('Minimum vertical gradient of refractivity inside trapping layer [m-1]');
   Add('Model bathymetry [m]');
   Add('Near IR albedo for diffuse radiation [(0 - 1)]');
   Add('Near IR albedo for direct radiation [(0 - 1)]');
   Add('Normalized energy flux into ocean [dimensionless]');
   Add('Normalized energy flux into waves [dimensionless]');
   Add('Normalized stress into ocean [dimensionless]');
   Add('Northward gravity wave surface stress [N m-2 s]');
   Add('Northward turbulent surface stress [N m-2 s]');
   Add('Orography [m2 s-2]');
   Add('Peak wave period [s]');
   Add('Period corresponding to maximum individual wave height [s]');
   Add('Potential evaporation [m]');
   Add('Precipitation type [GRIB code table 4.201]');
   Add('Runoff [m]');
   Add('Sea surface temperature [K]');
   Add('Sea-ice cover [(0 - 1)]');
   Add('Significant height of combined wind waves and swell [m]');
   Add('Significant height of total swell [m]');
   Add('Significant height of wind waves [m]');
   Add('Significant wave height of first swell partition [m]');
   Add('Significant wave height of second swell partition [m]');
   Add('Significant wave height of third swell partition [m]');
   Add('Skin reservoir content [m of water equivalent]');
   Add('Skin temperature [K]');
   Add('Slope of sub-gridscale orography [~]');
   Add('Snow albedo [(0 - 1)]');
   Add('Snow density [kg m-3]');
   Add('Snow depth [m of water equivalent]');
   Add('Snow evaporation [m of water equivalent]');
   Add('Snowfall [m of water equivalent]');
   Add('Snowmelt [m of water equivalent]');
   Add('Soil temperature level 1 [K]');
   Add('Soil temperature level 2 [K]');
   Add('Soil temperature level 3 [K]');
   Add('Soil temperature level 4 [K]');
   Add('Soil type [~]');
   Add('Standard deviation of filtered subgrid orography [m]');
   Add('Standard deviation of orography [~]');
   Add('Sub-surface runoff [m]');
   Add('Surface latent heat flux [J m-2]');
   Add('Surface net solar radiation [J m-2]');
   Add('Surface net solar radiation, clear sky [J m-2]');
   Add('Surface net thermal radiation [J m-2]');
   Add('Surface net thermal radiation, clear sky [J m-2]');
   Add('Surface pressure [Pa]');
   Add('Surface runoff [m]');
   Add('Surface sensible heat flux [J m-2]');
   Add('Surface solar radiation downward, clear sky [J m-2]');
   Add('Surface solar radiation downwards [J m-2]');
   Add('Surface thermal radiation downward, clear sky [J m-2]');
   Add('Surface thermal radiation downwards [J m-2]');
   Add('TOA incident solar radiation [J m-2]');
   Add('Temperature of snow layer [K]');
   Add('Top net solar radiation [J m-2]');
   Add('Top net solar radiation, clear sky [J m-2]');
   Add('Top net thermal radiation [J m-2]');
   Add('Top net thermal radiation, clear sky [J m-2]');
   Add('Total cloud cover [(0 - 1)]');
   Add('Total column cloud ice water [kg m-2]');
   Add('Total column cloud liquid water [kg m-2]');
   Add('Total column ozone [kg m-2]');
   Add('Total column rain water [kg m-2]');
   Add('Total column snow water [kg m-2]');
   Add('Total column supercooled liquid water [kg m-2]');
   Add('Total column water [kg m-2]');
   Add('Total column water vapour [kg m-2]');
   Add('Total precipitation [m]');
   Add('Total sky direct solar radiation at surface [J m-2]');
   Add('Total totals index [K]');
   Add('Trapping layer base height [m]');
   Add('Trapping layer top height [m]');
   Add('Type of high vegetation [~]');
   Add('Type of low vegetation [~]');
   Add('U-component stokes drift [m s-1]');
   Add('UV visible albedo for diffuse radiation [(0 - 1)]');
   Add('UV visible albedo for direct radiation [(0 - 1)]');
   Add('V-component stokes drift [m s-1]');
   Add('Vertical integral of divergence of cloud frozen water flux [kg m-2 s-1]');
   Add('Vertical integral of divergence of cloud liquid water flux [kg m-2 s-1]');
   Add('Vertical integral of divergence of geopotential flux [W m-2]');
   Add('Vertical integral of divergence of kinetic energy flux [W m-2]');
   Add('Vertical integral of divergence of mass flux [kg m-2 s-1]');
   Add('Vertical integral of divergence of moisture flux [kg m-2 s-1]');
   Add('Vertical integral of divergence of ozone flux [kg m-2 s-1]');
   Add('Vertical integral of divergence of thermal energy flux [W m-2]');
   Add('Vertical integral of divergence of total energy flux [W m-2]');
   Add('Vertical integral of eastward cloud frozen water flux [kg m-1 s-1]');
   Add('Vertical integral of eastward cloud liquid water flux [kg m-1 s-1]');
   Add('Vertical integral of eastward geopotential flux [W m-1]');
   Add('Vertical integral of eastward heat flux [W m-1]');
   Add('Vertical integral of eastward kinetic energy flux [W m-1]');
   Add('Vertical integral of eastward mass flux [kg m-1 s-1]');
   Add('Vertical integral of eastward ozone flux [kg m-1 s-1]');
   Add('Vertical integral of eastward total energy flux [W m-1]');
   Add('Vertical integral of eastward water vapour flux [kg m-1 s-1]');
   Add('Vertical integral of energy conversion [W m-2]');
   Add('Vertical integral of kinetic energy [J m-2]');
   Add('Vertical integral of mass of atmosphere [kg m-2]');
   Add('Vertical integral of mass tendency [kg m-2 s-1]');
   Add('Vertical integral of northward cloud frozen water flux [kg m-1 s-1]');
   Add('Vertical integral of northward cloud liquid water flux [kg m-1 s-1]');
   Add('Vertical integral of northward geopotential flux [W m-1]');
   Add('Vertical integral of northward heat flux [W m-1]');
   Add('Vertical integral of northward kinetic energy flux [W m-1]');
   Add('Vertical integral of northward mass flux [kg m-1 s-1]');
   Add('Vertical integral of northward ozone flux [kg m-1 s-1]');
   Add('Vertical integral of northward total energy flux [W m-1]');
   Add('Vertical integral of northward water vapour flux [kg m-1 s-1]');
   Add('Vertical integral of potential and internal energy [J m-2]');
   Add('Vertical integral of potential, internal and latent energy [J m-2]');
   Add('Vertical integral of temperature [K kg m-2]');
   Add('Vertical integral of thermal energy [J m-2]');
   Add('Vertical integral of total energy [J m-2]');
   Add('Vertically integrated moisture divergence [kg m-2]');
   Add('Volumetric soil water layer 1 [m3 m-3]');
   Add('Volumetric soil water layer 2 [m3 m-3]');
   Add('Volumetric soil water layer 3 [m3 m-3]');
   Add('Volumetric soil water layer 4 [m3 m-3]');
   Add('Wave spectral directional width [dimensionless]');
   Add('Wave spectral directional width for swell [dimensionless]');
   Add('Wave spectral directional width for wind waves [dimensionless]');
   Add('Wave spectral kurtosis [dimensionless]');
   Add('Wave spectral peakedness [dimensionless]');
   Add('Wave spectral skewness [dimensionless]');
   Add('Zero degree level [m]');
  end;
end;


procedure Tfrmmain.GetVariablesPressure;
begin
  With cgParameter.Items do begin
   Clear;
   Add('Divergence [s-1]');
   Add('Fraction of cloud cover [(0 - 1)]');
   Add('Geopotential [m2 s-2]');
   Add('Ozone mass mixing ratio [kg kg-1]');
   Add('Potential vorticity [K m2 kg-1 s-1]');
   Add('Relative humidity [%]');
   Add('Specific cloud ice water content [kg kg-1]');
   Add('Specific cloud liquid water content [kg kg-1]');
   Add('Specific humidity [kg kg-1]');
   Add('Specific rain water content [kg kg-1]');
   Add('Specific snow water content [kg kg-1]');
   Add('Temperature [K]');
   Add('U-component of wind [m s-1]');
   Add('V-component of wind [m s-1]');
   Add('Vertical velocity [m s-1]');
   Add('Vorticity (relative) [s-1]');
  end;
end;


end.

