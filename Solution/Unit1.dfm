object Form1: TForm1
  Left = 166
  Top = 208
  Width = 578
  Height = 320
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = menu
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lbl_enter: TLabel
    Left = 13
    Top = 7
    Width = 288
    Height = 16
    Caption = '???????? ???????? ? ??????? ??? ????????? :'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Verdana'
    Font.Style = [fsItalic]
    ParentFont = False
  end
  object lbl_Answer: TLabel
    Left = 5
    Top = 246
    Width = 103
    Height = 13
    Caption = '??? ????? ?????!'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clTeal
    Font.Height = -11
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbl_count: TLabel
    Left = 350
    Top = 216
    Width = 126
    Height = 15
    Caption = '?????????? ???????:'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Enter: TStringGrid
    Left = 7
    Top = 25
    Width = 538
    Height = 184
    ColCount = 7
    DefaultColWidth = 75
    RowCount = 7
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing, goTabs]
    TabOrder = 0
    OnKeyPress = EnterKeyPress
    RowHeights = (
      24
      24
      24
      24
      24
      24
      24)
  end
  object Coun_C: TSpinEdit
    Left = 488
    Top = 208
    Width = 45
    Height = 22
    MaxValue = 9
    MinValue = 2
    TabOrder = 1
    Value = 6
    OnChange = Coun_CChange
    OnKeyPress = Coun_RKeyPress
  end
  object menu: TMainMenu
    Left = 393
    Top = 65535
    object File1: TMenuItem
      Caption = 'File'
      object Open: TMenuItem
        Caption = 'Open'
        OnClick = OpenClick
      end
      object Save: TMenuItem
        Caption = 'Save'
        OnClick = SaveClick
      end
      object Save_as: TMenuItem
        Caption = 'Save as'
        OnClick = Save_asClick
      end
      object Clear: TMenuItem
        Caption = 'Clear'
        OnClick = ClearClick
      end
    end
    object Run: TMenuItem
      Caption = 'Run'
      OnClick = RunClick
    end
    object Exit: TMenuItem
      Caption = 'Exit'
      OnClick = ExitClick
    end
  end
  object Open_Dialog: TOpenDialog
    Left = 439
    Top = 65535
  end
  object Save_Dialog: TSaveDialog
    Left = 491
    Top = 65535
  end
end
