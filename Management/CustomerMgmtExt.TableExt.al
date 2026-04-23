tableextension 50200 "Customer Mgmt Ext." extends Customer
{
    fields
    {
        modify(Name)
        {
            trigger OnValidate()
            begin
                Rec.prova := 'APPROVATO';
            end;
        }
    }
}
