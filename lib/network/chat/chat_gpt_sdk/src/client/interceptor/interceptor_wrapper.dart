import 'package:creative_production_desktop/network/chat/chat_gpt_sdk/src/utils/token_builder.dart';
import 'package:dio/dio.dart';

import '../../utils/constants.dart';

class InterceptorWrapper extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers.addAll(kHeader("${TokenBuilder.build.token}"));

    return handler.next(options); // super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    //debugPrint('http status code => ${response.statusCode} \nresponse data => ${response.data}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    //debugPrint('have Error [${err.response?.statusCode}] => Data: ${err.response?.data}');
    super.onError(err, handler);
  }
}
