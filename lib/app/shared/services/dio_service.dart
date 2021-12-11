import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';

class DioService extends Disposable {
  static final BaseOptions _options = BaseOptions(
    baseUrl: baseUrl,
    responseType: ResponseType.bytes,
  );
  static const String baseUrl = "http://localhost:5000/api";

  final Dio client = Dio(_options);

  DioService() {
    client.interceptors.add(
      InterceptorsWrapper(
        onError: (DioError e, handler) {
          print(e.message);
          print(e.response!.data);
          return handler.next(e);
        },
      ),
    );
  }

  @override
  void dispose() {
    client.close();
  }
}
