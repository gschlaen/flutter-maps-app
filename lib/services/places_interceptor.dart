import 'package:dio/dio.dart';

class PlacesInterceptor extends Interceptor {
  final accessToken = 'pk.eyJ1IjoicnNjaGxhZW4iLCJhIjoiY2w0NGo0OGpxNTNhazNlcDdnM2dtbmhrNCJ9.TnJBsCWO4w9IIW3czIn1hA';
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.queryParameters.addAll({
      'access_token': accessToken,
      'lenguage': 'es',
    });

    super.onRequest(options, handler);
  }
}
