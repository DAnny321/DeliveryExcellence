// PageExtension on Vendor Card (Page 26).
// Displays the "ATC Stato Fornitore" field in the General FastTab.
pageextension 50351 "ATC Vendor Card Ext." extends "Vendor Card"
{
    layout
    {
        addafter(Name)
        {
            field("ATC Stato Fornitore"; Rec."ATC Stato Fornitore")
            {
                ApplicationArea = All;
                Caption = 'Stato Fornitore';
                ToolTip = 'Specifica lo stato del fornitore. Viene impostato automaticamente a Approvato alla modifica del campo Nome.';
            }
        }
    }
}
