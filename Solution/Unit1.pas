unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls, Spin, Menus;

const
  nmax = 9;

type
  TType = (V, H, P, X);
  Tmatr = array[1..nmax, 1..nmax] of TType;
  TForm1 = class(TForm)
    Enter: TStringGrid;
    lbl_enter: TLabel;
    lbl_Answer: TLabel;
    menu: TMainMenu;
    File1: TMenuItem;
    Open: TMenuItem;
    Save: TMenuItem;
    Save_as: TMenuItem;
    Clear: TMenuItem;
    Run: TMenuItem;
    Exit: TMenuItem;
    Open_Dialog: TOpenDialog;
    Save_Dialog: TSaveDialog;
    Coun_C: TSpinEdit;
    lbl_count: TLabel;
    procedure OpenClick(Sender: TObject);
    procedure LoToSG(name : string);
    procedure SaveClick(Sender: TObject);
    procedure Save_asClick(Sender: TObject);
    procedure SaveMatr(name : String);
    procedure ClearClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ExitClick(Sender: TObject);
    procedure RunClick(Sender: TObject);
    procedure Coun_CChange(Sender: TObject);
    procedure Coun_RKeyPress(Sender: TObject; var Key: Char);
    procedure EnterKeyPress(Sender: TObject; var Key: Char);
    function ConvertToChar(p_char : Ttype) : Char;
    function ConvertToType(p_char : Char) : Ttype;
    function CreateMatr() : Boolean;
  end;

var
  Form1: TForm1;
  File_Name : string;
  Count_size : Integer;
  matr : Tmatr;

implementation

{$R *.dfm}

procedure TForm1.OpenClick(Sender: TObject);
begin
  if Open_Dialog.Execute then
    begin
      File_Name := Open_Dialog.FileName;
      LoToSG(File_Name);
    end;
end;

procedure TForm1.LoToSG(name : string);
var
  f : TextFile;
  i, j: Integer;
  value : Char;
begin
  AssignFile(F, name);
  Reset(F);
  Readln(F, Count_size);
  Coun_C.Value := Count_size;
  for i := 1 to Count_size - 1 do
    for j := 1 to Count_size - 1 do
      begin
        Readln(F, value);
        Enter.Cells[j, i] := value
      end;
  CloseFile(F);
end;

procedure TForm1.SaveClick(Sender: TObject);
begin
  if File_Name <> ''
    then SaveMatr(File_Name)
    else Save_as.Click;
end;

function TForm1.CreateMatr() : Boolean;
var
  i, j : Integer;
begin
  Result := True;
  i := 1;
  while Result and (i < Count_size) do
    begin
      j := 1;
      while Result and (j < Count_size) do
        begin
          if Enter.Cells[j, i] <> ''
          then matr[i, j] := ConvertToType(Enter.Cells[j, i][1])
          else Result := False;
          Inc(j);
        end;
      Inc(i);
    end;
  if not Result
    then ShowMessage('Матрица заполнена не до конца!');
end;

procedure TForm1.SaveMatr(name : String);
var
  i, j : Integer;
  element : Char;
  F : TextFile;
begin
  if CreateMatr() then
  begin
    AssignFile(F, name);
    Rewrite(F);
    Writeln(F, Count_size - 1);
    for i := 1 to Count_size - 1 do
      for j := 1 to Count_size - 1 do
        begin
          element := ConvertToChar(matr[i, j]);
          Writeln(F, element);
        end;
    CloseFile(F);
  end;
end;

function TForm1.ConvertToChar(p_char : Ttype) : Char;
begin
  case p_char of
    V : Result := 'V';
    H : Result := 'H';
    P : Result := 'P';
    X : Result := 'X';
  end;
end;

function TForm1.ConvertToType(p_char : Char) : Ttype;
begin
  case p_char of
    'V' : Result := V;
    'H' : Result := H;
    'P' : Result := P;
    'X' : Result := X;
  end;
end;

procedure TForm1.Save_asClick(Sender: TObject);
begin
  if Save_Dialog.Execute then
    begin
      SaveMatr(Save_Dialog.FileName);
      File_Name := Save_Dialog.FileName;
    end;
end;

procedure TForm1.ClearClick(Sender: TObject);
var
  i : Integer;
begin
  Coun_C.Value := 6;
  for i := 1 to nmax - 1 do
    Enter.Rows[i].Clear;
  for i := 1 to 9 do
    Enter.Cells[0, i] := IntToStr(i) + ' player';
  for i := 1 to 9 do
    Enter.Cells[i, i] := 'X';
  File_Name := '';
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  i : Integer;
begin
  Count_size := 6;
  for i := 1 to 9 do
    Enter.Cells[0, i] := IntToStr(i) + ' player';
  for i := 1 to 9 do
    Enter.Cells[i, 0] := IntToStr(i) + ' player';
  for i := 1 to 9 do
    Enter.Cells[i, i] := 'X';
end;

procedure TForm1.ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TForm1.RunClick(Sender: TObject);
var
  i, j, temp, temp_index: Integer;
  ResArr, IndexArr : array[1..nmax] of Integer;
begin
  if CreateMatr() then
    begin
      lbl_Answer.Caption := 'Топ игроков: ';
      for i := 1 to nmax do
        ResArr[i] := 0;
      for i := 1 to Count_size do
        for j := 1 to Count_size do
          case matr[i, j] of
            H : ResArr[i] := ResArr[i] + 1;
            V : ResArr[i] := ResArr[i] + 2;
          end;

      for i := 1 to Count_size do
        IndexArr[i] := i;

      for i := 1 to Count_size do
        for j := i + 1 to Count_size do
          if ResArr[i] < ResArr[j] then
           begin
             temp := ResArr[i];
             ResArr[i] := ResArr[j];
             ResArr[j] := temp;

             temp_index := IndexArr[i];
             IndexArr[i] := IndexArr[j];
             IndexArr[j] := temp_index;
           end;

      lbl_Answer.Caption := lbl_Answer.Caption + IntToStr(IndexArr[1]) + ' игрок';
      for i := 2 to Count_size do
        lbl_Answer.Caption := lbl_Answer.Caption + ', ' + IntToStr(IndexArr[i]) + ' игрок';
    end;
end;

procedure TForm1.Coun_CChange(Sender: TObject);
begin
  Enter.ColCount := Coun_C.Value + 1;
  Count_size := Coun_C.Value + 1;
  Enter.RowCount := Coun_C.Value + 1;
end;

procedure TForm1.Coun_RKeyPress(Sender: TObject; var Key: Char);
begin
  Key := #0;
end;

procedure TForm1.EnterKeyPress(Sender: TObject; var Key: Char);
begin
  with Enter do
    if Col = Row
      then Key := #0
      else if not (Key in ['V', 'H', 'P', #08])
            then Key := #0
            else
              begin
                case Key of
                  #8  : Cells[Row, Col] := '';
                  'V' : Cells[Row, Col] := 'P';
                  'P' : Cells[Row, Col] := 'V';
                  'H' : Cells[Row, Col] := 'H';
                end;
                Cells[Col, Row] := Key;
              end;
end;

end.

