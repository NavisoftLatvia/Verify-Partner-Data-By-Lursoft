pageextension 50101 "Lursoft Customer Card Adds" extends "Customer Card"
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
