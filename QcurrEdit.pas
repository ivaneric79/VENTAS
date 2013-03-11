unit QcurrEdit;
{
TCurrEdit:  This is an usefull CLX component based on an Edit
            control for Currency ($-CA$H-$) input coded
            in Delphi 7.0. It should also work in Kylix X.
            Be free to Update, modify or distribute it
            (Please, dont remove the credits  :-) ) and
            to send me your updates or changes... I'll be
            more happy.....

Author:   Matias Surdi  (Matiass@interlap.com.ar)
Created: 21/11/2002
Version: 1.1
License: you can freely use and distribute the included code
         for any purpouse, but you cannot remove this copyright
         notice. Send me any comment and update, they are really
         appreciated.
Contact: matiass@interlap.com.ar

ChangeLog:  *21/11/2002 - Released V 1.00
            *24/11/2002 - Added Regional Decimal separator support ( "." and ",")


}


interface

uses
  SysUtils, Classes, QControls, QStdCtrls,Qdialogs,strUtils;

type
    TcurrEdit = class(TEdit)
    private
        FPrefix : string;
        fSufix : string;
        sMask : string;
        FValue : real;
        procedure UptText;
        procedure SetValue(NewValue : real);

    protected
        procedure Loaded; override;
        procedure KeyPress(var Key: Char); override;
        procedure doEnter; override;
        procedure doExit; override;
        procedure Click; override;

    public
        constructor Create(Aowner : TComponent);override;
        procedure Clear; override;

    published
        property Value : real read Fvalue write SetValue;
        property Prefix : string read fPrefix write fPrefix;
        property Sufix : string read fSufix write fSufix;
        property Mask : string read sMask write sMask;
    end;

procedure Register;

implementation

procedure Register;
begin
    RegisterComponents('Standard', [TcurrEdit]);
end;

constructor TCurrEdit.create(Aowner:tcomponent);
begin
    inherited Create(Aowner);
    Alignment := taRightJustify;
    Prefix := '';
    Sufix := '';
    Mask := '#,##0.00';
    Text := FormatFloat(sMask,FValue);
end;

procedure TCurrEdit.Loaded;
begin
inherited;
    UptText;
end;

procedure TCurrEdit.Clear;
var ch:char;
begin
    ch := Chr(8);
    KeyPress(ch);
end;

procedure TCurrEdit.SetValue(NewValue : real);
begin
    fValue := NewValue;
    Text := FloatToStr(fValue);

    Alignment:=taRightJustify;
    SelLength:=0;

    if (Text='') or (Text = DecimalSeparator) then

        Text:='0';

    Fvalue := StrToFloat(Text);

    Text := Prefix + FormatFloat(sMask,FValue) + Sufix;

    if Focused then begin

        Alignment := taLeftJustify;

        Text := FloatToStr(fValue);

        SelStart := 0;

        SelLength := Length(Text);

    end;
end;
 procedure TCurrEdit.UptText;
begin
    Text := Prefix + FormatFloat(sMask,FValue) + Sufix;
end;

procedure TCurrEdit.Click;
begin

//Doenter;

end;


procedure TCurrEdit.DoEnter;

begin

    if Alignment = taLeftJustify then

        Exit;   {avoid double entering!!}

    Alignment := taLeftJustify;

    Text := FloatToStr(fValue);

    SelStart := 0;

    SelLength := Length(Text);

    inherited;

end;


procedure TCurrEdit.DoExit;

begin

    Alignment:=taRightJustify;

    SelLength:=0;

    if (Text='') or (Text = DecimalSeparator) then

        Text:='0';

    Fvalue := StrToFloat(Text);

    Text := Prefix + FormatFloat(sMask,FValue) + Sufix;

    inherited;

end;



procedure TCurrEdit.KeyPress(var Key: Char);

begin
    if not (Ord(key) in [8, Ord(DecimalSeparator),45,48..57]) then begin
        Key := Chr(0);
        Exit;
    end;

    //Si la tecla pulsada es '-' ó separador de decimales y ya existe en el texto
    if ((Ord(Key) = 45) or (Key = DecimalSeparator)) and (Pos(Key,Text) > 0) then
        if(Length(Self.SelText) <> Length(Text)) then 
            Key := Chr(0);

    inherited;
end;

end.
