unit koef;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, DB, ADODB, StdCtrls, Grids, DBGrids, ExtCtrls, DBCtrls,
  dblookup, RpDefine, RpCon, RpConDS, RpBase, RpSystem, RpRave, Series,
  TeEngine, TeeProcs, Chart, RpFiler, RvClass, RvProj, RvCsDraw, RvCsStd,
  jpeg, rptchart;

type
  TForm2 = class(TForm)
    ADOConnection1: TADOConnection;
    ADOQuery1: TADOQuery;
    ADOQuery2: TADOQuery;
    DataSource1: TDataSource;
    DataSource2: TDataSource;
    ADOQuery3: TADOQuery;
    DataSource3: TDataSource;
    ADOQuery4: TADOQuery;
    DataSource4: TDataSource;
    ADOQuery5: TADOQuery;
    DataSource5: TDataSource;
    ADOQuery6: TADOQuery;
    ADOQuery7: TADOQuery;
    DataSource6: TDataSource;
    DataSource7: TDataSource;
    DataSource8: TDataSource;
    ADOQuery8: TADOQuery;
    RvProject1: TRvProject;
    RvSystem1: TRvSystem;
    rvcExpData: TRvDataSetConnection;
    ChartCon: TRvCustomConnection;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    DBGrid1: TDBGrid;
    TabSheet3: TTabSheet;
    DBGrid2: TDBGrid;
    Panel1: TPanel;
    rbPolniy: TRadioButton;
    rbProver: TRadioButton;
    rschet: TButton;
    DBNavigator1: TDBNavigator;
    otchet: TButton;
    LEX: TLabeledEdit;
    LEY1: TLabeledEdit;
    LEY2: TLabeledEdit;
    LEY3: TLabeledEdit;
    update: TButton;
    TabSheet2: TTabSheet;
    Chart1: TChart;
    Series1: TLineSeries;
    Series2: TPointSeries;
    ADOQuery9: TADOQuery;
    DataSource9: TDataSource;
    Vrastvora: TLabeledEdit;
    Vprobi: TLabeledEdit;
    ADOQuery10: TADOQuery;
    DataSource10: TDataSource;
    ADOQuery3_1: TADOQuery;
    DataSource3_1: TDataSource;
    DBNavigator2: TDBNavigator;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure DBGrid1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGrid1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure rschetClick(Sender: TObject);
    procedure TabSheet3Enter(Sender: TObject);
    procedure rbPolniyMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure rbProverMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ADOQuery2BeforeOpen(DataSet: TDataSet);
    procedure ADOQuery3BeforeOpen(DataSet: TDataSet);
    procedure ADOQuery4BeforeOpen(DataSet: TDataSet);
    procedure PageControl1Change(Sender: TObject);
    procedure otchetClick(Sender: TObject);
    procedure printchar;
    procedure ChartConGetCols(Connection: TRvCustomConnection);
    procedure ChartConOpen(Connection: TRvCustomConnection);
    procedure ChartConGetRow(Connection: TRvCustomConnection);
    procedure updateClick(Sender: TObject);
    procedure VprobiKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure VrastvoraKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure LEY1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure LEY2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure LEXKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure LEY3KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);

  private
    procedure ExitESC( var Msg:TMessage); message WM_KEYDOWN;
     { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;
  Exp_K_ID, Exp_Type: longint;
  DATA, Title, OsnStR, RabStR, RrSravnenia, Diapazon, KFK, FacNumb, Lambda, L, Vpr: AnsiString;
  Ksp: AnsiString;
  bosp, ap, bp: AnsiString;
  Summ1p, KoeffSy2p, KoeffSa2p, KoeffSap, tap: AnsiString;
  V1p, t1p, V2p, t2p, Skp, Pp, a2p, b2p, Fp, kp: AnsiString;


implementation

{$R *.dfm}

procedure TForm2.ExitESC( var Msg:TMessage);
begin
showmessage('����������� F = ');
//adoquery5.SQL.Text
end;

procedure TForm2.LEY3KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
  var
  Vpr, Vrra, X, Y1, Y2, Y3: real;
begin
if key=13 then
begin
  Vpr  := StrToFloat(Vprobi.Text);
  Vrra := StrToFloat(Vrastvora.Text);
  X    := StrToFloat(LEX.Text);
  Y1   := StrToFloat(LEY1.Text);
  Y2   := StrToFloat(LEY2.Text);
  Y3   := StrToFloat(LEY3.Text);

  ADOQUERY2.Active := false;

  adoquery10.Parameters.ParamByName('K_ID').Value := Exp_K_ID;
  adoquery10.Parameters.ParamByName('Type').Value := Exp_Type;
  adoquery10.Parameters.ParamByName('X').Value := X;
  adoquery10.Parameters.ParamByName('Y1').Value := Y1;
  adoquery10.Parameters.ParamByName('Y2').Value := Y2;
  adoquery10.Parameters.ParamByName('Y3').Value := Y3;
  adoquery10.Parameters.ParamByName('Vpr').Value := Vpr;
  adoquery10.Parameters.ParamByName('Vrra').Value := Vrra;

  adoquery10.ExecSQL;

 adoconnection1.Connected :=false;

 adoconnection1.Connected :=true;

  ADOQUERY2.Active := TRUE;

  ADOQUERY1.Active := TRUE;


  Vrastvora.SetFocus;
end;
end;


procedure TForm2.printchar;
var
   MyPage: TRavePage;
    MyImg:TRaveBitmap;
begin
Series1.clear;
Series2.clear;

ADOQuery2.First;

while ADOQuery2.Eof = false do
begin
Series1.AddXY(ADOQuery2.FieldValues['Exp_X'] , ADOQuery2.FieldValues['Result_Y'], '', clRed);
Series2.AddXY(ADOQuery2.FieldValues['Exp_X'] , ADOQuery2.FieldValues['Result_Y'], '', clRed);
ADOQuery2.Next;
end;


//Vprobi.SetFocus;
//label1.Caption:= floattostr(dbgrid1.Fields[1].AsFloat);
//Chart1.SaveToBitmapFile('graf.bmp');

//image1.Picture.LoadFromFile('graf.bmp');



end;





procedure TForm2.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key = 27 then  koef.Form2.Visible := false;
//label1.Caption :=  inttostr( adoquery1.FieldValues['K_ID'] );
end;

procedure TForm2.DBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
FormKeyDown(Sender, Key, Shift);
//if key = 13 then  DataSource1.Edit;
end;

procedure TForm2.FormCreate(Sender: TObject);
var
  dir : string;
begin

Exp_K_ID :=1;

dir := GetCurrentDir;

RvProject1.ProjectFile:= dir + '\Lab.rav'; //  Provider=Microsoft.Jet.OLEDB.4.0;Data Source=D:\Projects\2000\Lab2000.mdb;Persist Security Info=False;Jet OLEDB:Engine Type=5

adoconnection1.ConnectionString:='Provider=Microsoft.Jet.OLEDB.4.0;Data Source=' + dir + '\Lab2000.mdb;Persist Security Info=False;';
ADOQuery1.Active := true;
//ADOQuery2.Active := true;


end;

procedure TForm2.DBGrid1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
Exp_K_ID :=  adoquery1.FieldValues['K_ID'];
Title    :=  adoquery1.FieldValues['K_Title'];
KFK      :=  adoquery1.FieldValues['K_KFK'];FacNumb  :=  adoquery1.FieldValues['K_Zavodskoy'];DATA     :=  adoquery1.FieldValues['K_Date'];OsnStR   :=  adoquery1.FieldValues['K_Based'];RabStR   :=  adoquery1.FieldValues['K_Worked'];Diapazon :=  adoquery1.FieldValues['K_Diapason'];Lambda   :=  adoquery1.FieldValues['K_Lambda'];L        :=  adoquery1.FieldValues['K_L'];Vpr      :=  adoquery1.FieldValues['K_Vpr'];RrSravnenia :=  adoquery1.FieldValues['K_Sravnenie'];

otchet.Enabled := false;
end;

procedure TForm2.DBGrid1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
Exp_K_ID := adoquery1.FieldValues['K_ID'];
Title    :=  adoquery1.FieldValues['K_Title'];
KFK      :=  adoquery1.FieldValues['K_KFK'];FacNumb  :=  adoquery1.FieldValues['K_Zavodskoy'];DATA     :=  adoquery1.FieldValues['K_Date'];OsnStR   :=  adoquery1.FieldValues['K_Based'];RabStR   :=  adoquery1.FieldValues['K_Worked'];Diapazon :=  adoquery1.FieldValues['K_Diapason'];Lambda   :=  adoquery1.FieldValues['K_Lambda'];L        :=  adoquery1.FieldValues['K_L'];Vpr      :=  adoquery1.FieldValues['K_Vpr'];RrSravnenia :=  adoquery1.FieldValues['K_Sravnenie'];

otchet.Enabled := false;
end;

procedure TForm2.rschetClick(Sender: TObject);

var
  SX, SY, SX2, SY2, SXY, m: Variant;
  Ks: integer;
  bo, a, b: double;
  Summ1, KoeffSy2, KoeffSa2, KoeffSa, ta: double;
  V1, t1, V2, t2, Sk, P, a2, b2, F, k: double;
               
begin

Vprobi.Visible := false;
Vrastvora.Visible := false;
LEX.Visible := false;
LEY1.Visible := false;
LEY2.Visible := false;
LEY3.Visible := false;

chart1.LeftAxis.Maximum := 0;
chart1.BottomAxis.Maximum := 0;

adoconnection1.Connected :=false;

adoconnection1.Connected :=true;

ADOQuery2.Active := false;

ADOQuery3.Active := false;

ADOQuery3_1.Active := false;

ADOQuery4.Active := false;

ADOQuery5.Active := false;

ADOQuery6.Active := false;

ADOQuery7.Active := false;

ADOQuery8.Active := false;

ADOQuery9.Active := false;

ADOQuery10.Active := false;



adoquery3.Parameters.ParamByName('K_ID').Value := Exp_K_ID;
adoquery3.Parameters.ParamByName('Type').Value := Exp_Type;

adoquery3_1.Parameters.ParamByName('K_ID').Value := Exp_K_ID;
adoquery3_1.Parameters.ParamByName('Type').Value := Exp_Type;


ADOQuery3.ExecSQL;


ADOQuery3_1.ExecSQL;


ADOQuery3.Active := false;

ADOQuery3_1.Active := false;

ADOQuery4.Active := true;



SX := ADOQuery4.FieldValues['SX'];
SY := ADOQuery4.FieldValues['SY'];
SX2 := ADOQuery4.FieldValues['SX2'];
SY2 := ADOQuery4.FieldValues['SY2'];

m := ADOQuery4.FieldValues['M'];

SXY := ADOQuery4.FieldValues['SXY'];

ADOQuery4.Active := false;


try
bo := SXY / SX2;
a := (SX2 * SY - SX * SXY) / (m * SX2 - SX * SX);
b := (m * SXY - SX * SY) / (m * SX2 - SX * SX);
Ks :=  m - 2;

except
showmessage('Delenie na nol');
end;


adoquery5.Parameters.ParamByName('K_ID').Value := Exp_K_ID;
adoquery5.Parameters.ParamByName('Type').Value := Exp_Type;

adoquery5.Parameters.ParamByName('ap').Value := a;
adoquery5.Parameters.ParamByName('bp').Value := b;




adoquery5.ExecSQL;



ADOQuery5.Active := false;




ADOQuery4.Active := true;


Summ1 := ADOQuery4.FieldValues['Summ1'];

ADOQuery4.Active := false;


KoeffSy2 := Summ1 / Ks;
KoeffSa2 := KoeffSy2 * SX2 / (m * SX2 - SX * SX);
KoeffSa := Sqrt(KoeffSa2);
ta := Abs(a) / KoeffSa;


adoquery6.Active := false;
adoquery7.Active := false;

adoquery6.Parameters.ParamByName('Ks').Value := Ks;
adoquery6.Parameters.ParamByName('ta').Value := ta;

adoquery7.Parameters.ParamByName('Ks').Value := Ks;
adoquery7.Parameters.ParamByName('ta').Value := ta;


adoquery6.Active := true;
adoquery7.Active := true;

showmessage(IntToStr(Ks));
showmessage(FloatToStr(ta));

V1 := ADOQuery6.FieldValues['Sk'];
t1 := ADOQuery6.FieldValues['t'];
V2 := ADOQuery7.FieldValues['Sk'];
t2 := ADOQuery7.FieldValues['t'];

Sk := V1 + (V2 - V1) * (ta - t1) / (t2 - t1);

adoquery6.Active := false;
adoquery7.Active := false;

Sk := round(Sk * 1000)/1000;


P := 2 * (1 - Sk);

a2 := a;
If P > 0.05 Then a2 := 0;

b2 := SXY / SX2;
F := Round((SX2 / SXY) * 1000) / 1000;
k := Round((a2 + b2) * 10000) / 10000;


adoquery8.Parameters.ParamByName('a2').Value := a2;
adoquery8.Parameters.ParamByName('b2').Value := b2;
adoquery8.Parameters.ParamByName('K_ID').Value := Exp_K_ID;
adoquery8.Parameters.ParamByName('Type').Value := Exp_Type;

adoquery8.ExecSQL;

ADOQuery8.Active := false;

showmessage('����������� F = ' + FloatToStr(F));

ap:=FloatToStr(a);
bp:=FloatToStr(b);
Ksp:=FloatToStr(Ks);
KoeffSy2p:=FloatToStr(KoeffSy2);
KoeffSa2p:=FloatToStr(KoeffSa2);
KoeffSap:=FloatToStr(KoeffSa);
tap:=FloatToStr(ta);
Skp:=FloatToStr(Sk);
Pp:=FloatToStr(P);
kp:=FloatToStr(k);
Fp:=FloatToStr(F);

ADOQuery2.Active := true;

ADOQuery1.Active := true;




printchar;


otchet.Enabled := true;

end;

procedure TForm2.TabSheet3Enter(Sender: TObject);
begin
ADOQuery2.Active := false;
if rbPolniy.Checked then Exp_Type := 1;
if rbProver.Checked then Exp_Type := 2;
adoquery2.Parameters.ParamByName('K_ID').Value := Exp_K_ID;
adoquery2.Parameters.ParamByName('Type').Value := Exp_Type;
ADOQuery2.Active := true;
end;

procedure TForm2.rbPolniyMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
ADOQuery2.Active := false;
if rbPolniy.Checked then Exp_Type := 2;
if rbProver.Checked then Exp_Type := 1;
ADOQuery2.Active := true;
end;

procedure TForm2.rbProverMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
ADOQuery2.Active := false;
if rbPolniy.Checked then Exp_Type := 2;
if rbProver.Checked then Exp_Type := 1;
ADOQuery2.Active := true;
end;

procedure TForm2.ADOQuery2BeforeOpen(DataSet: TDataSet);
begin
adoquery2.Parameters.ParamByName('K_ID').Value := Exp_K_ID;
adoquery2.Parameters.ParamByName('Type').Value := Exp_Type;
end;

procedure TForm2.ADOQuery3BeforeOpen(DataSet: TDataSet);
begin
adoquery3.Parameters.ParamByName('K_ID').Value := Exp_K_ID;
adoquery3.Parameters.ParamByName('Type').Value := Exp_Type;
end;

procedure TForm2.ADOQuery4BeforeOpen(DataSet: TDataSet);
begin
adoquery4.Parameters.ParamByName('K_ID').Value := Exp_K_ID;
adoquery4.Parameters.ParamByName('Type').Value := Exp_Type;
end;

procedure TForm2.PageControl1Change(Sender: TObject);
begin
ADOQuery2.Active := false;
if rbPolniy.Checked then Exp_Type := 1;
if rbProver.Checked then Exp_Type := 2;
adoquery2.Parameters.ParamByName('K_ID').Value := Exp_K_ID;
adoquery2.Parameters.ParamByName('Type').Value := Exp_Type;

ADOQuery2.Active := true;

//ADOQuery2.Next;
//dbgrid2.Fields[3].AsFloat
//label1.Caption:= floattostr(ADOQuery2.FieldValues['Exp_Y2']);
end;

procedure TForm2.otchetClick(Sender: TObject);
var
   MyPage: TRavePage;
    MyImg:TRaveBitmap;
begin

RvProject1.Open;

RvProject1.SelectReport('Report2', False);

RvProject1.SetParam('Title',Title);
RvProject1.SetParam('KFK',KFK);
RvProject1.SetParam('FacNumb',FacNumb);
RvProject1.SetParam('DATA',DATA);
RvProject1.SetParam('OsnStR',OsnStR);
RvProject1.SetParam('RabStR',RabStR);
RvProject1.SetParam('Diapazon',Diapazon);
RvProject1.SetParam('Lambda',Lambda);
RvProject1.SetParam('L',L);
RvProject1.SetParam('Vpr',Vpr);
RvProject1.SetParam('RrSravnenia',RrSravnenia);





RvProject1.SetParam('a',ap);
RvProject1.SetParam('b',bp);
RvProject1.SetParam('Ks',Ksp);
RvProject1.SetParam('KoeffSy2',KoeffSy2p);
RvProject1.SetParam('KoeffSa2',KoeffSa2p);
RvProject1.SetParam('KoeffSa',KoeffSap);
RvProject1.SetParam('ta',tap);
RvProject1.SetParam('Sk',Skp);
RvProject1.SetParam('P',Pp);
RvProject1.SetParam('k',kp);
RvProject1.SetParam('F',Fp);

{
With RvProject1.ProjMan do begin
   MyPage := FindRaveComponent('Report2.Page2',nil) as TRavePage;
   MyImg:=FindRaveComponent('Bitmap1',MyPage) as TRaveBitmap;
   MyImg.Image := Image1.Picture.Graphic;//
end;//with
}

RvProject1.Execute;

RvProject1.Close; 



end;

procedure TForm2.ChartConGetCols(Connection: TRvCustomConnection);
begin
  Connection.WriteField('Img', dtGraphic, 0,
    '������ ������� ��������� �����������', '');
end;

procedure TForm2.ChartConOpen(Connection: TRvCustomConnection);
begin
  Connection.DataRows := 1;
end;

procedure TForm2.ChartConGetRow(Connection: TRvCustomConnection);
begin
    WriteChartData(Connection, Chart1);
end;



procedure TForm2.updateClick(Sender: TObject);
begin

Vprobi.Visible := true;
Vrastvora.Visible := true;
LEX.Visible := true;
LEY1.Visible := true;
LEY2.Visible := true;
LEY3.Visible := true;

adoquery2.active := false;


adoquery9.Parameters.ParamByName('K_ID').Value := Exp_K_ID;
adoquery9.Parameters.ParamByName('Type').Value := Exp_Type;

adoquery9.ExecSQL;

adoquery2.active := true;

Vprobi.enabled := true;
Vprobi.SetFocus;



end;

procedure TForm2.VprobiKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key=13 then
  begin
    Vprobi.enabled := false;
    Vrastvora.SetFocus;
  end;
end;

procedure TForm2.VrastvoraKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key=13 then  LEX.SetFocus;
end;

procedure TForm2.LEY1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if key=13 then  LEY2.SetFocus;
end;

procedure TForm2.LEY2KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if key=13 then  LEY3.SetFocus;
end;

procedure TForm2.LEXKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if key=13 then  LEY1.SetFocus;
end;

end.
