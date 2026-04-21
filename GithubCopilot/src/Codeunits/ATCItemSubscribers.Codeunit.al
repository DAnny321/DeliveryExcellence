// Codeunit that subscribes to the OnAfterValidateEvent of the "Description" field on the Item table.
// "Description" is the technical field name for the item Name displayed in the Business Central UI.
// When the field is validated (UI edit, import, or integration), "ATC Name Validated" is set to TRUE.
// Direct assignment is used (no Rec.Validate) to avoid recursion or side effects.
codeunit 50300 "ATC Item Subscribers"
{
    [EventSubscriber(ObjectType::Table, Database::Item, 'OnAfterValidateEvent', 'Description', false, false)]
    local procedure OnAfterValidateItemDescription(var Rec: Record Item; var xRec: Record Item; CurrFieldNo: Integer)
    begin
        if not Rec."ATC Name Validated" then
            Rec."ATC Name Validated" := true;
    end;
}
