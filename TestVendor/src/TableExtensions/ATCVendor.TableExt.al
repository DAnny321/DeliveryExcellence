// TableExtension on Vendor (Table 18).
// Adds a Text field "ATC Stato Fornitore" that is automatically set to 'Approvato'
// when the Name field (field 2) is validated.
tableextension 50350 "ATC Vendor Ext." extends Vendor
{
    fields
    {
        field(50350; "ATC Stato Fornitore"; Text[100])
        {
            Caption = 'Stato Fornitore';
            DataClassification = CustomerContent;
        }
        modify(Name)
        {
            trigger OnAfterValidate()
            begin
                Rec."ATC Stato Fornitore" := ApprovatoLbl;
            end;
        }
    }

    var
        ApprovatoLbl: Label 'Approvato', Locked = true;
}
