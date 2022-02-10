import Text "mo:base/Text";

// 单纯分析url，无callback版本
actor http {
    type HeaderField = (Text, Text);
    type StreamingCallbackHttpResponse = {
        body: Blob;
        token: ?Token;
    };
    type Token = {};
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

    public query func http_request(request: HttpRequest): async HttpResponse {
        if(request.url == "/xun") {
            {
                status_code = 200;
                headers = [];
                body = Text.encodeUtf8("xiaoyuanxun");
                streaming_strategy = null;
            }
        } else {
            {
                status_code = 404;
                headers = [];
                body = Text.encodeUtf8("worng url");
                streaming_strategy = null;
            }
        }
    };
};