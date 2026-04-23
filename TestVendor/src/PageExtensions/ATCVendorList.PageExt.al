// PageExtension on Vendor List (Page 27).
// Displays the "ATC Stato Fornitore" field as a column.
pageextension 50352 "ATC Vendor List Ext." extends "Vendor List"
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
