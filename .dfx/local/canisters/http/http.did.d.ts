import type { Principal } from '@dfinity/principal';
export interface CallbackToken { 'index' : bigint }
export type HeaderField = [string, string];
export interface HttpRequest {
  'url' : string,
  'method' : string,
  'body' : Array<number>,
  'headers' : Array<HeaderField>,
}
export interface HttpResponse {
  'body' : Array<number>,
  'headers' : Array<HeaderField>,
  'streaming_strategy' : [] | [StreamingStrategy],
  'status_code' : number,
}
export interface StreamingCallbackHttpResponse {
  'token' : [] | [CallbackToken],
  'body' : Array<number>,
}
export type StreamingStrategy = {
    'Callback' : { 'token' : CallbackToken, 'callback' : [Principal, string] }
  };
export interface _SERVICE {
  'http_request' : (arg_0: HttpRequest) => Promise<HttpResponse>,
  'streamingCallback' : (arg_0: CallbackToken) => Promise<
      StreamingCallbackHttpResponse
    >,
}
