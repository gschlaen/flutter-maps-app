import 'package:dio/dio.dart';

class TrafficInterceptor extends Interceptor {
  final accessToken = 'pk.eyJ1IjoicnNjaGxhZW4iLCJhIjoiY2w0NGo0OGpxNTNhazNlcDdnM2dtbmhrNCJ9.TnJBsCWO4w9IIW3czIn1hA';
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.queryParameters.addAll({
      'alternatives': true,
      'geometries': 'polyline6',
      'overview': 'simplified',
      'steps': false,
      'access_token': accessToken,
    });

    super.onRequest(options, handler);
  }
}
