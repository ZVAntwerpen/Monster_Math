unit Unit3;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons,
  Unit1, Unit2, Math,
  Vcl.Imaging.jpeg;

type
  TForm3 = class(TForm)
    pnlAbove_BG: TPanel;
    imgLife2: TImage;
    imgLife3: TImage;
    lblScore_ttl: TLabel;
    lblDiff_ttl: TLabel;
    lblScore: TLabel;
    lblLevel: TLabel;
    lblTime_ttl: TLabel;
    lblTime: TLabel;
    imglife1: TImage;
    pnlUnder_BG: TPanel;
    lblProblem_ttl: TLabel;
    lblProblem: TLabel;
    lblAnswer_ttl: TLabel;
    Button1: TButton;
    Button2: TButton;
    edtAntw: TEdit;
    tmrTime: TTimer;
    Button3: TButton;
    imgGame_BG: TImage;
    shpCount1: TShape;
    shpCount2: TShape;
    shpCount3: TShape;
    shpCount4: TShape;
    shpCount5: TShape;
    shpCount6: TShape;
    procedure Button3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure tmrTimeTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);

    procedure Multiply; // ctrl + Shift + C
    procedure Plus;
    procedure Minus;
    procedure Mixed;
    procedure Divide;

  private
    { Private declarations }
    iNum1, iNum2, iKorrek, iMode, iLose, iTime: integer;
    sTime: string;
  public
    { Public declarations }
    iScore: integer;
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}

// --------------------------ConfirmButton-------------------------------------
procedure TForm3.Button1Click(Sender: TObject);
var
  iAntw, iLength: integer;
begin
  iLength := Length(edtAntw.Text);

  edtAntw.SetFocus;

  if edtAntw.Text <> '' then
  begin

    if iLength < 5 then
    begin

      if iLose >= 3 then
      begin
        ShowMessage('You lost. Please try again.');
        tmrTime.Enabled := false;
        edtAntw.Text := '';
      end
      else
      begin
        iAntw := StrToInt(edtAntw.Text);

        if iKorrek = iAntw then
        begin
          tmrTime.Enabled := false;
          iKorrek := 0;

          // ========================Selection====================================
          if Form2.bPlus = true then
          begin
            Plus;
          end;

          if Form2.bMultiply = true then
          begin
            Multiply;
          end;

          if Form2.bMinus = true then
          begin
            Minus;
          end;

          if Form2.bDivide = true then
          begin
            Divide;
          end;

          if Form2.bMixed = true then
          begin
            Mixed;
          end;
          // =====================================================================

          iScore := iScore + iTime;
          lblScore.Caption := IntToStr(iScore);
          iMode := iMode + 1;
          iTime := 30;
          tmrTime.Enabled := true;
        end
        else
        begin
          iLose := iLose + 1;
          imgLife3.Visible := false;

          if iLose = 2 then
          begin
            imgLife2.Visible := false;
          end;

          if iLose = 3 then
          begin
            imglife1.Visible := false;
            ShowMessage('You LOSE');
            tmrTime.Enabled := false;
          end;
        end;

        edtAntw.Text := '';
      end;
    end;
  end;
end;

procedure TForm3.Button2Click(Sender: TObject);
begin
  edtAntw.Text := '';
end;

procedure TForm3.Button3Click(Sender: TObject);
var
  MyFile: TextFile;
  sLine: string;
begin
  // --------------------------------TextFile-----------------------------------
  if FileExists('Plays.txt') = false then
  begin
    ShowMessage('File not Found!');
    Exit;
  end;

  AssignFile(MyFile, 'Plays.txt');

  Append(MyFile);

  Writeln(MyFile, 'User: ' + Form1.sUser);
  Writeln(MyFile, 'Gender: ' + Form1.sGender);

  if Form2.bPlus = true then
  begin
    Writeln(MyFile, 'Mode: Addition');
  end;

  if Form2.bMultiply = true then
  begin
    Writeln(MyFile, 'Mode: Multiply');
  end;

  if Form2.bMinus = true then
  begin
    Writeln(MyFile, 'Mode: Minus');
  end;

  if Form2.bDivide = true then
  begin
    Writeln(MyFile, 'Mode: Divide');
  end;

  if Form2.bMixed = true then
  begin
    Writeln(MyFile, 'Mode: Mixed');
  end;

  Writeln(MyFile, 'Score: ' + IntToStr(iScore));
  Writeln(MyFile, '========================');

  CloseFile(MyFile);
  // ---------------------------------------------------------------------------

  Form2.Show;
  iScore := 0;
  lblScore.Caption := IntToStr(iScore);
  imglife1.Visible := true;
  imgLife2.Visible := true;
  imgLife3.Visible := true;
  iLose := 0;
  iTime := 30;
  edtAntw.Text := '';
  iMode := 0;
  tmrTime.Enabled := false;
  iKorrek := 0;
  Form3.Close;

  // -----------Reset Color-----------
  shpCount1.Brush.Color := clGreen;
  shpCount2.Brush.Color := clGreen;
  shpCount3.Brush.Color := clGreen;
  shpCount4.Brush.Color := clGreen;
  shpCount5.Brush.Color := clGreen;
  shpCount6.Brush.Color := clGreen;
  // --------------------------------
end;

// ==============================Divide=========================================
procedure TForm3.Divide;
begin
  if iMode <= 10 then
  begin
    lblLevel.Caption := 'Easy';
    iNum1 := RandomRange(1, 5);
    iNum2 := RandomRange(1, 5);
  end;

  if (iMode > 10) AND (iMode <= 20) then
  begin
    lblLevel.Caption := 'Medium';
    iNum1 := RandomRange(2, 7);
    iNum2 := RandomRange(2, 7);
  end;

  if iMode > 20 then
  begin
    lblLevel.Caption := 'Hard';
    iNum1 := RandomRange(4, 12);
    iNum2 := RandomRange(4, 12);
  end;

  iKorrek := iNum1 * iNum2;

  lblProblem.Caption := IntToStr(iKorrek) + '�' + IntToStr(iNum1);

  iKorrek := iNum2;
end;
// =============================================================================

// -------------------------------Form.Show--------------------------------------
procedure TForm3.FormShow(Sender: TObject);
var
  iSelect: integer;
begin
  tmrTime.Enabled := true;
  iTime := 30;
  iLose := 0;
  iMode := 0;
  iKorrek := 0;
  iScore := 0;

  if Form2.bPlus = true then
  begin
    Plus;
  end;

  if Form2.bMultiply = true then
  begin
    Multiply;
  end;

  if Form2.bMinus = true then
  begin
    Minus;
  end;

  if Form2.bDivide = true then
  begin
    Divide;
  end;

  if Form2.bMixed = true then
  begin
    iSelect := RandomRange(0, 3);

    case iSelect of
      0:
        Multiply;
      1:
        Plus;
      2:
        Minus;
      3:
        Divide;
    end;
  end;
end;
// ------------------------------------------------------------------------------

// ==============================Minus==========================================
procedure TForm3.Minus;
begin
  if iMode <= 10 then
  begin
    lblLevel.Caption := 'Easy';
    iNum1 := RandomRange(10, 20);
    iNum2 := RandomRange(1, 10);
  end;

  if (iMode > 10) AND (iMode <= 20) then
  begin
    lblLevel.Caption := 'Medium';
    iNum1 := RandomRange(15, 25);
    iNum2 := RandomRange(5, 15);
  end;

  if iMode > 20 then
  begin
    lblLevel.Caption := 'Hard';
    iNum1 := RandomRange(15, 30);
    iNum2 := RandomRange(5, 15);
  end;

  iKorrek := iNum1 - iNum2;
  lblProblem.Caption := IntToStr(iNum1) + '-' + IntToStr(iNum2);

end;
// =============================================================================

// ==============================Mixed==========================================
procedure TForm3.Mixed;
var
  iSelect: integer;
begin
  iSelect := RandomRange(1, 5);

  case iSelect of
    1:
      Multiply;
    2:
      Plus;
    3:
      Minus;
    4:
      Divide;
  end;

end;
// =============================================================================

// ==============================Multiply=======================================
procedure TForm3.Multiply;
begin
  if iMode <= 10 then
  begin
    lblLevel.Caption := 'Easy';
    iNum1 := RandomRange(0, 5);
    iNum2 := RandomRange(1, 5);
  end;

  if (iMode > 10) AND (iMode <= 20) then
  begin
    lblLevel.Caption := 'Medium';
    iNum1 := RandomRange(2, 7);
    iNum2 := RandomRange(2, 7);
  end;

  if iMode > 20 then
  begin
    lblLevel.Caption := 'Hard';
    iNum1 := RandomRange(4, 12);
    iNum2 := RandomRange(4, 12);
  end;

  iKorrek := iNum1 * iNum2;
  lblProblem.Caption := IntToStr(iNum1) + 'x' + IntToStr(iNum2);

end;
// =============================================================================

// =============================Plus============================================
procedure TForm3.Plus;
begin
  if iMode <= 10 then
  begin
    lblLevel.Caption := 'Easy';
    iNum1 := RandomRange(0, 12);
    iNum2 := RandomRange(1, 12);
  end;

  if (iMode > 10) AND (iMode <= 20) then
  begin
    lblLevel.Caption := 'Medium';
    iNum1 := RandomRange(10, 30);
    iNum2 := RandomRange(0, 12);
  end;

  if iMode > 20 then
  begin
    lblLevel.Caption := 'Hard';
    iNum1 := RandomRange(15, 40);
    iNum2 := RandomRange(5, 15);
  end;

  iKorrek := iNum1 + iNum2;
  lblProblem.Caption := IntToStr(iNum1) + '+' + IntToStr(iNum2);
end;
// =============================================================================

// ---------------------------Timer---------------------------------------------
procedure TForm3.tmrTimeTimer(Sender: TObject);
var
  iSelect: integer;
begin
  iTime := iTime - 1;

  lblTime.Caption := FormatDateTime('ss', iTime / SecsPerDay);

  // ========================Animation==========================================
  if iTime = 29 then
  begin
    shpCount1.Brush.Color := clGreen;
    shpCount2.Brush.Color := clGreen;
    shpCount3.Brush.Color := clGreen;
    shpCount4.Brush.Color := clGreen;
    shpCount5.Brush.Color := clGreen;
    shpCount6.Brush.Color := clGreen;
  end;

  if iTime = 25 then
  begin
    shpCount1.Brush.Color := clRed;
  end;

  if iTime = 20 then
  begin
    shpCount2.Brush.Color := clRed;
  end;

  if iTime = 15 then
  begin
    shpCount3.Brush.Color := clRed;
  end;

  if iTime = 10 then
  begin
    shpCount4.Brush.Color := clRed;
  end;

  if iTime = 5 then
  begin
    shpCount5.Brush.Color := clRed;
  end;

  if iTime = 0 then
  begin
    shpCount6.Brush.Color := clRed;
  end;
  // ===========================================================================

  if iTime = 0 then
  begin
    tmrTime.Enabled := false;
    iLose := iLose + 1;

    if iLose = 1 then

    begin
      imgLife3.Visible := false;
      iKorrek := 0;

      if Form2.bPlus = true then
      begin
        Plus;
      end;

      if Form2.bMultiply = true then
      begin
        Multiply;
      end;

      if Form2.bMinus = true then
      begin
        Minus;
      end;

      if Form2.bDivide = true then
      begin
        Divide;
      end;

      if Form2.bMixed = true then
      begin
        Mixed;
      end;

      iScore := iScore + iTime;
      lblScore.Caption := IntToStr(iScore);
      iMode := iMode + 1;
      iTime := 30;
      tmrTime.Enabled := true;
    end;

    if iLose = 2 then
    begin
      imgLife2.Visible := false;

      iKorrek := 0;

      if Form2.bPlus = true then
      begin
        Plus;
      end;

      if Form2.bMultiply = true then
      begin
        Multiply;
      end;

      if Form2.bMinus = true then
      begin
        Minus;
      end;

      if Form2.bMixed = true then
      begin
        Mixed;
      end;

      iScore := iScore + iTime;
      lblScore.Caption := IntToStr(iScore);
      iMode := iMode + 1;
      iTime := 30;
      tmrTime.Enabled := true;
    end;

    if iLose = 3 then
    begin
      imglife1.Visible := false;
      ShowMessage('You LOSE');
      tmrTime.Enabled := false;
    end;
  end;
  // ---------------------------------------------------------------------------
end;

end.
