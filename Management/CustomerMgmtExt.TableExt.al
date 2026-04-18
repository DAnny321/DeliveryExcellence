tableextension 50200 "Customer Mgmt Ext." extends Customer
{
    fields
    {
        modify(Description)
        {
            trigger OnValidate()
            begin
                Rec.prova := 'APPROVATO';
            end;
        }
    }
}
