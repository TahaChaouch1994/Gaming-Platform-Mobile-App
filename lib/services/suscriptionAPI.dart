import 'dart:convert';

import "package:http/http.dart" as http;

class RequestResult
{
  bool ok;
  dynamic data;
  RequestResult(this.ok, this.data);
}

const PROTOCOL = "http";
const DOMAIN = "192.168.1.17:1337";

Future<RequestResult> get_sub(String route, [dynamic data]) async
{
  var dataStr = jsonEncode(data);
  var url = "$PROTOCOL://$DOMAIN/$route?data=$dataStr";
  var result = await http.get(url);
  return RequestResult(true, jsonDecode(result.body));
}
Future<RequestResult> post_sub(String route, [dynamic data]) async
{
  var url = "$PROTOCOL://$DOMAIN/$route";
  var dataStr = jsonEncode(data);
  var result = await http.post(url, body: dataStr, headers:{"Content-Type":"application/json"});
  return RequestResult(true, jsonDecode(result.body));
}
