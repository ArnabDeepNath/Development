
import 'package:dio/dio.dart';

class APIProvider {
  Dio apiClient =
      Dio(BaseOptions(connectTimeout: 20000, receiveTimeout: 20000));
}
