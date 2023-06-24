

class ResponseWrap<T> {
  final int statusCode;
  final T? data;
  final T? originalResponse;


  ResponseWrap({
    required this.statusCode,
    required this.data,
    required this.originalResponse,
  });

}
