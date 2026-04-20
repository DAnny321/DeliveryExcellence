codeunit 50250 "Product Photo Capture"
{
    procedure CapturePhotoForItem(var Item: Record Item)
    var
        Camera: Codeunit Camera;
        TempBlob: Codeunit "Temp Blob";
        InStr: InStream;
        OutStr: OutStream;
    begin
        if not Camera.HasCamera() then begin
            Message(NoCameraLbl);
            exit;
        end;

        TempBlob.CreateOutStream(OutStr);
        if Camera.GetPicture(OutStr) then begin
            TempBlob.CreateInStream(InStr);
            Item.Picture.ImportStream(InStr, Item."No." + '_' + Format(CurrentDateTime(), 0, '<Year4><Month,2><Day,2>_<Hours24,2><Minutes,2><Seconds,2>') + '.jpg');
            Item.Modify(true);
            Message(PhotoSavedLbl, Item."No.");
        end else
            Message(PhotoCancelledLbl);
    end;

    var
        NoCameraLbl: Label 'No camera is available on this device.';
        PhotoSavedLbl: Label 'Photo captured and saved to item %1.', Comment = '%1 = Item No.';
        PhotoCancelledLbl: Label 'Photo capture was cancelled or did not complete successfully.';
}
