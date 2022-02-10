import Text "mo:base/Text";
import Blob "mo:base/Blob";

// callback版本
actor http {
    let ans: [Text] = ["xx","ww","cc","yy","hh"];
    type HeaderField = (Text, Text);
    type StreamingCallbackHttpResponse = {
        body: Blob;
        token: ?CallbackToken;
    };
    type CallbackToken = {
        index: Nat;
    };
    type StreamingStrategy = {
        #Callback: {
            callback: query (CallbackToken) -> async (StreamingCallbackHttpResponse);
            token: CallbackToken;
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

    public query func streamingCallback(tk: CallbackToken): async StreamingCallbackHttpResponse{
        if(tk.index <= 3) return {
            body = Text.encodeUtf8(ans[tk.index]);
            token = ?{index = tk.index + 1;}
        };
        {
            body = Text.encodeUtf8("gggg");
            token = null;
        }
    };

    private func _workContent(index: Nat,size: Nat): (Blob, ?CallbackToken) {
        let payload = Text.encodeUtf8(ans[index]);
        if(index == size) return (payload, null);
        (payload, ?{index = index + 1;})
    };

    public query func http_request(request: HttpRequest): async HttpResponse {
        if(request.url == "/xun") {
            let (payload, token) = _workContent(1,3);
            {
                status_code = 200;
                headers = [("Content-Type", "txt")];
                body = payload;
                streaming_strategy = switch(token) {
                    case(null) {null;};
                    case(?tk) {
                        ?#Callback({
                            callback = streamingCallback;
                            token = tk;
                        })
                    }
                }
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