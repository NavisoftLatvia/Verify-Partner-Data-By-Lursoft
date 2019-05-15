tableextension 50100 "Lursoft Vendor Adds" extends Vendor
{
    fields
    {
        field(25023370; "Registration No."; Code[30])
        {
            CaptionML = LVI = 'Reģistrācijas Nr.',
                        ENU = 'Registration No.';
        }
        field(25023371; "Has Lursoft warning"; Boolean)
        {
            CaptionML = LVI = 'Lursoft riska faktori',
                        ENU = 'Has Lursoft warning';
        }
        field(25023372; "Lursoft client URL"; Text[250])
        {
            ExtendedDatatype = URL;
            Editable = false;
            CaptionML = LVI = 'Saite uz partnera profilu Lursoft datu bāzē',
                        ENU = 'Lursoft client URL';
        }
    }
}