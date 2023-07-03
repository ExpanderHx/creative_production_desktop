

import 'package:bot_toast/bot_toast.dart';
import 'package:creative_production_desktop/utilities/language_util.dart';
import 'package:dio/dio.dart';

import '../../config/response_wrap.dart';

class ChatHttp {
  static final ChatHttp _instance = ChatHttp._internal();
  // 单例模式使用Http类，
  factory ChatHttp() => _instance;

  static late final Dio dio;
  CancelToken _cancelToken = new CancelToken();

  ChatHttp._internal() {
    // BaseOptions、Options、RequestOptions 都可以配置参数，优先级别依次递增，且可以根据优先级别覆盖参数
    BaseOptions options = new BaseOptions();

    dio = Dio(options);

    dio.interceptors.add(LogInterceptor(
      request: false,
      requestHeader: false,
      responseBody: true,
      responseHeader: false
    ));

    // // 添加request拦截器
    // dio.interceptors.add(RequestInterceptor());
    // // 添加error拦截器
    // dio.interceptors.add(ErrorInterceptor());
    // // // 添加cache拦截器
    // dio.interceptors.add(NetCacheInterceptor());
    // // // 添加retry拦截器
    // dio.interceptors.add(
    //   RetryOnConnectionChangeInterceptor(
    //     requestRetrier: DioConnectivityRequestRetrier(
    //       dio: dio,
    //       connectivity: Connectivity(),
    //     ),
    //   ),
    // );

    // 在调试模式下需要抓包调试，所以我们使用代理，并禁用HTTPS证书校验
    // if (PROXY_ENABLE) {
    //   (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
    //       (client) {
    //     client.findProxy = (uri) {
    //       return "PROXY $PROXY_IP:$PROXY_PORT";
    //     };
    //     //代理工具会提供一个抓包的自签名证书，会通不过证书校验，所以我们禁用证书校验
    //     client.badCertificateCallback =
    //         (X509Certificate cert, String host, int port) => true;
    //   };
    // }
  }

  ///初始化公共属性
  ///
  /// [baseUrl] 地址前缀
  /// [connectTimeout] 连接超时赶时间
  /// [receiveTimeout] 接收超时赶时间
  /// [interceptors] 基础拦截器
  ChatHttp init({
    String? baseUrl,
    Duration connectTimeout = const Duration(seconds:360),
    Duration receiveTimeout = const Duration(seconds:360),
    Map<String, String>? headers,
    List<Interceptor>? interceptors,
  }) {
    dio.options = dio.options.copyWith(
      baseUrl: baseUrl,
      connectTimeout: connectTimeout,
      receiveTimeout: receiveTimeout,
      headers: headers ?? const {},
    );
    // 在初始化http类的时候，可以传入拦截器
    if (interceptors != null && interceptors.isNotEmpty) {
      dio.interceptors..addAll(interceptors);
    }
    return this;
  }

  void updateBaseUrl(String baseUrl){
    dio.options = dio.options.copyWith(
      baseUrl: baseUrl,
    );
  }

  // 关闭dio
  void cancelRequests({required CancelToken token}) {
    _cancelToken.cancel("cancelled");
  }

  // 添加认证
  // 读取本地配置
  Map<String, dynamic>? getAuthorizationHeader() {
    Map<String, dynamic>? headers;
    // 从getx或者sputils中获取
    // String accessToken = Global.accessToken;
    String accessToken = "";
    if (accessToken != null) {
      headers = {
        'Authorization': 'Bearer $accessToken',
      };
    }
    return headers;
  }

  Future request(
      String path, String method,{
        data,
        Map<String, dynamic>? params,
        Options? options,
        CancelToken? cancelToken,
        bool showErrorToast = true
      }) async {
    Options requestOptions = options ?? Options();
    requestOptions.method = method;

    // Map<String, dynamic>? _authorization = getAuthorizationHeader();
    // if (_authorization != null) {
    //   requestOptions = requestOptions.copyWith(headers: _authorization);
    // }
    int? statusCode;
    var responseData;
    var originalResponse;
    try{
      originalResponse = await dio.request(
        path,
        data: data,
        queryParameters: params,
        options: requestOptions,
        cancelToken: cancelToken ?? _cancelToken,
      );
      statusCode = originalResponse.statusCode;
      responseData = originalResponse.data;
    }on DioException catch(error){
      if(null!=error){
        if(showErrorToast){
          BotToast.showText(text:error.message??"network_request_exception".tr());
        }
        if(error is DioException){
          statusCode = error.response?.statusCode;
        }
      }else{
        statusCode = 500;
      }
    }catch(e){
      print(e);
      if(null!=e){
        if(showErrorToast){
          BotToast.showText(text:e.toString()??"network_request_exception".tr());
        }
      }
      statusCode = 500;
    }
    ResponseWrap responseWrap = ResponseWrap(statusCode:(statusCode!=null?statusCode:500),data: responseData,originalResponse:originalResponse);

    return responseWrap;
  }

  Future get(
      String path, {
        Map<String, dynamic>? params,
        Options? options,
        CancelToken? cancelToken,
        bool refresh = false,
        bool noCache = !false,
        String? cacheKey,
        bool cacheDisk = false,
        bool showErrorToast = true
      }) async {
    Options requestOptions = options ?? Options();
    requestOptions = requestOptions.copyWith(
      extra: {
        "refresh": refresh,
        "noCache": noCache,
        "cacheKey": cacheKey,
        "cacheDisk": cacheDisk,
      },
    );
    return request(path, "GET",
        options:requestOptions,
        cancelToken:cancelToken,
        showErrorToast: showErrorToast,
    );
  }

  Future post(
      String path, {
        Map<String, dynamic>? params,
        data,
        Options? options,
        CancelToken? cancelToken,
        bool showErrorToast = true
      }) async {
    return request(path, "POST",
      data:data,
      params:params,
      options:options,
      cancelToken:cancelToken,
      showErrorToast: showErrorToast,
    );
  }

  Future put(
      String path, {
        data,
        Map<String, dynamic>? params,
        Options? options,
        CancelToken? cancelToken,
        bool showErrorToast = true,
      }) async {
    return request(path, "PUT",
      data:data,
      params:params,
      options:options,
      cancelToken:cancelToken,
      showErrorToast: showErrorToast,
    );
  }

  Future patch(
      String path, {
        data,
        Map<String, dynamic>? params,
        Options? options,
        CancelToken? cancelToken,
        bool showErrorToast = true,
      }) async {
    Options requestOptions = options ?? Options();
    Map<String, dynamic>? _authorization = getAuthorizationHeader();
    if (_authorization != null) {
      requestOptions = requestOptions.copyWith(headers: _authorization);
    }
    var response = await dio.patch(
      path,
      data: data,
      queryParameters: params,
      options: requestOptions,
      cancelToken: cancelToken ?? _cancelToken,
    );
    return response.data;
  }

  Future delete(
      String path, {
        data,
        Map<String, dynamic>? params,
        Options? options,
        CancelToken? cancelToken,
        bool showErrorToast = true,
      }) async {
    return request(path, "DELETE",
      data:data,
      params:params,
      options:options,
      cancelToken:cancelToken,
      showErrorToast: showErrorToast,
    );
  }
}
