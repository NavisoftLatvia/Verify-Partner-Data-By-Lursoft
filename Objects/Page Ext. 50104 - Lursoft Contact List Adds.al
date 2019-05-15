pageextension 50104 "Lursoft Contact List Adds" extends "Contact List"
{
    layout
    {
        addafter(Name)
        {
            field("Registration No."; "Registration No.")
            {
                ApplicationArea = All;
            }
            field("VAT Registration No."; "VAT Registration No.")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter(History)
        {
            group("Lursoft")
            {
                CaptionML = ENU = 'Lursoft',
                            LVI = 'Lursoft';
                Image = ICPartner;
                action("Lursoft Communication Setup")
                {
                    ApplicationArea = All;
                    CaptionML = ENU = 'Lursoft Communication Setup',
                                LVI = 'Lursoft Komunikācijas uzstādījumi';
                    Image = LogSetup;
                    RunObject = page "Lursoft Communication Setup";
                }
            }
        }
    }
}