import 'package:dio/dio.dart';

class HttpLogInterceptor extends Interceptor {
  String USER_AGENT =
      "Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/31.0.1650.63";

  @override
  onRequest(RequestOptions options) {
    print(
        "######################### Request Start ###########################");
    options.headers['User-Agent'] = USER_AGENT;
    StringBuffer sb = StringBuffer();
    sb.write(
        "onRequest:method:${options.method},contentType:${options.contentType},responseType:${options.responseType},");
    sb.write("path:${options.path}");
    if (options.headers != null && options.headers.length > 0) {
      options.headers
          .forEach((key, value) => sb.write('header:key=$key, value=$value'));
    }
    print(sb);
    return options;
  }

  @override
  onResponse(Response response) {
    print("######################### Response End ###########################");
    if (response.request.responseType == ResponseType.plain) {
      var contentLength = (response.data as String).length;
      String bodySize = "$contentLength-byte";
      StringBuffer sb = StringBuffer();
      sb.write(response.statusCode);
      sb.write(" ");
      sb.write(response.statusMessage);
      sb.write(" ");
      //sb.write(tookMs);
      //sb.write("ms ");
      sb.write(", ");
      sb.write(bodySize);
      sb.write(" body:");
      sb.write(response.data);
      print(sb);
    } else {
      print("response:$response");
    }
    return response;
  }

  @override
  onError(DioError err) {
    print("onError:$err");
    return err;
  }
}
