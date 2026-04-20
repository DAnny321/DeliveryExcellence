pageextension 50250 "Item Card Photo Ext" extends "Item Card"
{
    actions
    {
        addlast(processing)
        {
            action(CaptureItemPhoto)
            {
                ApplicationArea = All;
                Caption = 'Capture Item Photo';
                Image = Camera;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Capture a photo using the device camera and save it as the item picture.';

                trigger OnAction()
                var
                    PhotoCapture: Codeunit "Product Photo Capture";
                begin
                    PhotoCapture.CapturePhotoForItem(Rec);
                end;
            }
        }
    }
}
