

class ResponseMessage<T> {
  final int statusCode;
  final String? responseMessage;
  final T? originalResponse;


  ResponseMessage({
    required this.statusCode,
    required this.responseMessage,
    required this.originalResponse,
  });

}