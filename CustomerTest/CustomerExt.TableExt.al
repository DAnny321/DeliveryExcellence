tableextension 50100 "Customer Ext." extends Customer
{
    fields
    {
        field(50100; prova; Text[250])
        {
            Caption = 'prova';
            DataClassification = CustomerContent;
        }
    }
}
