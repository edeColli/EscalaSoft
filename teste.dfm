object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Teste ESCALASOFT'
  ClientHeight = 512
  ClientWidth = 508
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 508
    Height = 512
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Teste 1'
      object Button1: TButton
        Left = 8
        Top = 95
        Width = 75
        Height = 25
        Caption = '1'#186' Algoritmo'
        TabOrder = 0
        OnClick = Button1Click
      end
      object Button4: TButton
        Left = 89
        Top = 95
        Width = 75
        Height = 25
        Caption = 'Limpar Grids'
        TabOrder = 1
        OnClick = Button4Click
      end
      object StringGrid2: TStringGrid
        Left = 8
        Top = 313
        Width = 473
        Height = 159
        ColCount = 6
        RowCount = 6
        TabOrder = 2
      end
      object StringGrid1: TStringGrid
        Left = 8
        Top = 126
        Width = 473
        Height = 159
        ColCount = 6
        RowCount = 6
        TabOrder = 3
      end
      object RadioGroup1: TRadioGroup
        Left = 8
        Top = 3
        Width = 473
        Height = 78
        Caption = 'Modelos de Matriz'
        Columns = 3
        ItemIndex = 0
        Items.Strings = (
          'Modelo 1'
          'Modelo 2'
          'Modelo 3')
        TabOrder = 4
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Teste 2'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 835
      ExplicitHeight = 0
      object Button2: TButton
        Left = 14
        Top = 43
        Width = 75
        Height = 25
        Caption = '2'#186' Algoritmo'
        TabOrder = 0
        OnClick = Button2Click
      end
      object Memo1: TMemo
        Left = 14
        Top = 74
        Width = 307
        Height = 391
        TabOrder = 1
      end
      object Button3: TButton
        Left = 95
        Top = 43
        Width = 75
        Height = 25
        Caption = 'Limpar Memo'
        TabOrder = 2
        OnClick = Button3Click
      end
    end
  end
end
