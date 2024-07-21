unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Imaging.jpeg, Vcl.ExtCtrls, Vcl.Imaging.pngimage, Unit4;

type
  TForm2 = class(TForm)
    Button1: TButton;
    shpUnder_BG: TShape;
    imgLesson_BG: TImage;
    imgSelect_BG: TImage;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    shpAbove_BG: TShape;
    lblUser_ttl: TLabel;
    lblUser: TLabel;
    lblScore_ttl: TLabel;
    lblScore: TLabel;
    procedure Button7Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button6Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    bMultiply, bDivide, bMixed, bPlus, bMinus: boolean;
  end;

var
  Form2: TForm2;

implementation

uses
  Unit1, Unit3;
{$R *.dfm}

procedure TForm2.Button1Click(Sender: TObject);
begin
  bMultiply := true;
  Form3.Show;
  Form2.Hide;
end;

procedure TForm2.Button2Click(Sender: TObject);
begin
  bPlus := true;
  Form3.Show;
  Form2.Hide;
end;

procedure TForm2.Button3Click(Sender: TObject);
begin
  bMixed := true;
  Form3.Show;
  Form2.Hide;
end;

procedure TForm2.Button4Click(Sender: TObject);
begin
  bDivide := true;
  Form3.Show;
  Form2.Hide;
end;

procedure TForm2.Button5Click(Sender: TObject);
begin
  bMinus := true;
  Form3.Show;
  Form2.Hide;
end;

procedure TForm2.Button6Click(Sender: TObject);
begin
  Form4.Show;
end;

procedure TForm2.Button7Click(Sender: TObject);
begin
  Form2.Close;
  Form1.Show;
end;

procedure TForm2.FormShow(Sender: TObject);
begin

  lblUser.Caption := Form1.sUser;
  lblScore.Caption := IntToStr((Form3.iScore));

  // ----------Reset Booleans---------
  bMultiply := false;
  bDivide := false;
  bPlus := false;
  bMinus := false;
  bMixed := false;
  // ---------------------------------
end;

end.
