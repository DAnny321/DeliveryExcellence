// TableExtension on Item (Table 27).
// Adds a Boolean field "ATC Name Validated" that tracks whether the Description
// (displayed as "Name" in the UI) has ever been validated by the user or an integration.
// Note: In Business Central the technical field name for the item "Name" is "Description" (field 3).
tableextension 50300 "ATC Item Ext." extends Item
{
    fields
    {
        field(50300; "ATC Name Validated"; Boolean)
        {
            Caption = 'Name Validated';
            DataClassification = CustomerContent;
        }
    }
}
