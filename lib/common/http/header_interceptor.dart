import 'package:dio/dio.dart';

class HeaderInterceptor extends Interceptor {
  static const String USER_AGENT =
      "Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/31.0.1650.63";

  @override
  onRequest(RequestOptions options) {
    options.headers['User-Agent'] = USER_AGENT;
    return options;
  }

  @override
  onResponse(Response response) {
    return response;
  }

  @override
  onError(DioError err) {
    return err;
  }
}
