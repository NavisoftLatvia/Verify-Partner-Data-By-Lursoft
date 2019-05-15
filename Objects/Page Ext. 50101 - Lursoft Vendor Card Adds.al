pageextension 50101 "Lursoft Vendor Card Adds" extends "Vendor Card"
{
    layout
    {
        addafter("No.")
        {
            field("Registration No."; "Registration No.")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
    }
}
