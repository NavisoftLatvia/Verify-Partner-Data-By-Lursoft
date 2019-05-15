pageextension 50102 "Lursoft Customer List Adds" extends "Customer List"
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