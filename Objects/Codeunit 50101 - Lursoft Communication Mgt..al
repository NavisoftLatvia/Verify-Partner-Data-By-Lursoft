codeunit 50101 "Lursoft Communication Mgt."
{
    trigger OnRun();
    var
        content: Text;
    begin
        // 'nsoft_xml', 'Navi$oft2017LS'
        content := StartLursoftSession();
        //error(content);
    end;

    local procedure ErrorifNoUserName(LursoftStp: Record "Lursoft Communication Setup")
    begin
        LursoftStp.TestField(User);
    end;

    local procedure ErrorINoPassword(LursoftStp: Record "Lursoft Communication Setup")
    begin
        LursoftStp.TestField(Password);
    end;

    local procedure CallWebService(var Arguments: Record "REST Web Service Arguments" temporary) Success: Boolean
    var
        RESTWebService: Codeunit "REST Web Service Management";
    begin
        Success := RESTWebService.CallRESTWebService(Arguments);
    end;

    local procedure TestAndSaveResult(var Arguments: Record "REST Web Service Arguments") Response: Text;
    begin
        Response := Arguments.GetResponseContentAsText();
    end;

    local procedure InitArguments(var Arguments: Record "REST Web Service Arguments" temporary; data: Text; LursoftCommunicationSetup: Record "Lursoft Communication Setup")
    var
        RequestContent: HttpContent;
        RequestHeaders: HttpHeaders;
    begin
        Arguments.URL := 'https://www.lursoft.lv/server3';
        Arguments.RestMethod := Arguments.RestMethod::post;

        RequestContent.WriteFrom(data);
        RequestContent.GetHeaders(RequestHeaders);
        RequestHeaders.Remove('Content-Type');
        RequestHeaders.Add('Content-Type', 'application/x-www-form-urlencoded');

        Arguments.SetRequestContent(RequestContent);
    end;

    [TryFunction]
    local procedure GetLoginInfo(var userName: Text; var Password: Text)
    var
        LursoftCommunicationSetup: Record "Lursoft Communication Setup";
    begin
        LursoftCommunicationSetup.Get();
        ErrorifNoUserName(LursoftCommunicationSetup);
        ErrorINoPassword(LursoftCommunicationSetup);
        userName := LursoftCommunicationSetup.User;
        password := LursoftCommunicationSetup.GetPassword();
    end;

    local procedure StartLursoftSession() SessionKey: Text;
    var
        Arguments: Record "REST Web Service Arguments";
        LursoftCommunicationSetup: Record "Lursoft Communication Setup";
        JSONMethods: Codeunit "JSON Methods";
        TypeHelper: Codeunit "Type Helper";
        JSONResult: JsonObject;
        _xmlNode: XmlNode;
        _xmlNodeList: XmlNodeList;
        _xlmElement: XmlElement;
        _xmlDoc: XmlDocument;
        _xmlProcessor: XmlNamespaceManager;
        _xmlBuffer: Record "XML Buffer";
        data: Text;
        MessageText: Text;
        userName: Text;
        password: Text;
        ResponseText: Text;
    begin
        if not GetLoginInfo(userName, password) then
            error(GetLastErrorText);

        data := StrSubstNo('act=LOGINXML&Userid=%1&Password=%2&utf=1',
                TypeHelper.UrlEncode(userName),
                TypeHelper.UrlEncode(password)
                );

        InitArguments(Arguments, data, LursoftCommunicationSetup);
        if not CallWebService(Arguments) then
            exit;

        ResponseText := TestAndSaveResult(Arguments);
        if not XmlDocument.ReadFrom(ResponseText, _xmlDoc) then
            error('Text is not valid XML!');

        _xmlDoc.GetChildNodes().Get(1, _xmlNode);

        _xmlProcessor.NameTable(_xmlDoc.NameTable());
        _xmlProcessor.AddNamespace('soap', 'http://www.w3.org/2001/09/soap-envelope');
        _xmlProcessor.AddNamespace('Lursoft', 'x-schema:/schemas/lursoft_header.xsd');

        _xmlDoc.GetRoot(_xlmElement);
        _xlmElement.SelectSingleNode('//soap:Envelope/soap:Header/Lursoft:SessionId', _xmlProcessor, _xmlNode);
        SessionKey := _xmlNode.AsXmlElement.InnerText;

        exit(SessionKey);
    end;

    [EventSubscriber(ObjectType::Table, Database::Customer, 'OnAfterValidateEvent', 'Registration No.', true, true)]
    local procedure OnAfterValidateCustomerRegNo(var Rec: Record Customer; var xRec: Record Customer; CurrFieldNo: Integer);
    begin
        if Rec.ISTEMPORARY then
            exit;

        if Rec."Registration No." = '' then
            exit;

        if Rec."Registration No." = xRec."Registration No." then
            exit;

        CustomerGetDataFromLursoft(Rec);
    end;

    [EventSubscriber(ObjectType::Table, Database::Vendor, 'OnAfterValidateEvent', 'Registration No.', true, true)]
    local procedure OnAfterValidateVendorRegNo(var Rec: Record Vendor; var xRec: Record Vendor; CurrFieldNo: Integer);
    begin
        if Rec.ISTEMPORARY then
            exit;

        if Rec."Registration No." = '' then
            exit;

        if Rec."Registration No." = xRec."Registration No." then
            exit;

        VendorGetDataFromLursoft(Rec);
    end;

    [EventSubscriber(ObjectType::Table, Database::Contact, 'OnAfterValidateEvent', 'Registration No.', true, true)]
    local procedure OnAfterValidateContactRegNo(var Rec: Record Contact; var xRec: Record Contact; CurrFieldNo: Integer);
    begin
        if Rec.ISTEMPORARY then
            exit;

        if Rec."Registration No." = '' then
            exit;

        if Rec."Registration No." = xRec."Registration No." then
            exit;

        ContactGetDataFromLursoft(Rec);
    end;

    local procedure CustomerGetDataFromLursoft(var Rec: Record Customer)
    var
        myInt: Integer;
    begin

    end;

    local procedure VendorGetDataFromLursoft(var Rec: Record Vendor)
    var
        myInt: Integer;
    begin

    end;

    local procedure ContactGetDataFromLursoft(var Rec: Record Contact)
    var
        myInt: Integer;
    begin

    end;
}