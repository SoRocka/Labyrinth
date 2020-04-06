object Form1: TForm1
  Left = 419
  Top = 78
  BorderStyle = bsNone
  Caption = 'Form1'
  ClientHeight = 696
  ClientWidth = 649
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    649
    696)
  PixelsPerInch = 96
  TextHeight = 13
  object Output: TImage
    Left = 24
    Top = 80
    Width = 601
    Height = 601
    Align = alCustom
  end
  object Button1: TButton
    Left = 24
    Top = 16
    Width = 601
    Height = 52
    Anchors = [akLeft, akTop, akRight]
    Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100' '#1080#1079#1086#1073#1088#1072#1078#1077#1085#1080#1077'...'
    TabOrder = 0
    OnClick = Button1Click
  end
  object OpenDialog1: TOpenDialog
    Left = 585
    Top = 24
  end
end
