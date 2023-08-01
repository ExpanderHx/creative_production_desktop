

class ResponseMessage<T> {
  final int statusCode;
  final String? responseMessage;
  final T? originalResponse;
  final int? code;
  final int? version;
  final String? errMsg;



  ResponseMessage({
    required this.statusCode,
    required this.responseMessage,
    required this.originalResponse,
    required this.code,
    required this.version,
    required this.errMsg,
  });

}