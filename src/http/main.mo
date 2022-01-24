import Text "mo:base/Text";
actor http {
    let ans: [Text] = ["xiaoyuanxun","xun1","xun2","xun3"];
    type HeaderField = (Text, Text);
    type StreamingCallbackHttpResponse = {
        body: Blob;
        token: ?Token;
    };
    type Token = {
        index: Nat;
    };
    type StreamingStrategy = {
        #Callback: {
            callback: shared (Token) -> async (StreamingCallbackHttpResponse);
            token: Token;
        }
    };
    type HttpRequest =  {
        method: Text;
        url: Text;
        headers: [HeaderField];        
        body: Blob;
    };
    type HttpResponse = {
        status_code: Nat16;
        headers: [HeaderField];
        body: Blob;
        streaming_strategy: ?StreamingStrategy;
    };
    public shared func tokencallback(tokenrequest: Token): async StreamingCallbackHttpResponse {
        if(tokenrequest.index == 3) {
            {
                body = Text.encodeUtf8(ans[tokenrequest.index]);
                token = null;
            }
        } else {
            {
                body = Text.encodeUtf8(ans[tokenrequest.index]);
                token = ?{ index = tokenrequest.index + 1; };
            }
        }
    };

    private func new_strategy(): StreamingStrategy {
        let tk: Token = {
            index = 1;
        };
        let ss: StreamingStrategy = #Callback({
            callback = tokencallback;
            token = tk;
        });
        return ss;
    };

    public query func http_request(request: HttpRequest): async HttpResponse {
        {
            status_code = 200;
            headers = [];
            body = Text.encodeUtf8("xiaoyuanxun");
            streaming_strategy = ?new_strategy();
        }
    };

    public shared func http_request_update(request: HttpRequest): async HttpResponse {
        {
            status_code = 200;
            headers = [];
            body = Text.encodeUtf8("xiaoyuanxun");
            streaming_strategy = ?new_strategy();
        }
    };
};