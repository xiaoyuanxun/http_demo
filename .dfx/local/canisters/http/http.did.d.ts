import type { Principal } from '@dfinity/principal';
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
  'token' : [] | [Token],
  'body' : Array<number>,
}
export type StreamingStrategy = {
    'Callback' : { 'token' : Token, 'callback' : [Principal, string] }
  };
export interface Token { 'index' : bigint }
export interface _SERVICE {
  'http_request' : (arg_0: HttpRequest) => Promise<HttpResponse>,
  'http_request_update' : (arg_0: HttpRequest) => Promise<HttpResponse>,
  'tokencallback' : (arg_0: Token) => Promise<StreamingCallbackHttpResponse>,
}
