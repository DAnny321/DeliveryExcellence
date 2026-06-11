pageextension 50100 "Customer Card Ext." extends "Customer Card"
{
    layout
    {
        addlast(General)
        {
            field(prova; Rec.prova)
            {
                ApplicationArea = All;
                Caption = 'prova';
                ToolTip = 'Specifies the value of the prova field.';
            }
            field(TEST2; Rec.TEST2)
            {
                ApplicationArea = All;
                Caption = 'TEST2';
                ToolTip = 'Specifies the value of the TEST2 field.';
            }
        }
    }
}
