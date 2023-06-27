import 'package:creative_production_desktop/network/chat/config/chat_config.dart';

class HttpSetup {
  Duration sendTimeout;
  Duration connectTimeout;
  Duration receiveTimeout;
  String baseUrl;
  String proxy;

  HttpSetup({
    this.sendTimeout = const Duration(seconds: 6),
    this.connectTimeout = const Duration(seconds: 6),
    this.receiveTimeout = const Duration(seconds: 6),
    this.baseUrl = '',
    this.proxy = '',
  });
}
