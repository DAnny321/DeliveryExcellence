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
        }
    }
}
