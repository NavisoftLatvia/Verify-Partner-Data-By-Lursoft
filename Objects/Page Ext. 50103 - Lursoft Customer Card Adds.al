pageextension 50103 "Lursoft Customer Card Adds" extends "Customer Card"
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
