import 'dart:async';

import 'package:dio/dio.dart';



class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {

    switch (err.type) {
      case DioExceptionType.connectionTimeout:
        throw DioException(requestOptions: err.requestOptions);
      case DioExceptionType.sendTimeout:
        throw DioException(requestOptions: err.requestOptions);
      case DioExceptionType.receiveTimeout:
        throw TimeoutException(requestOptions: err.requestOptions);
      case DioExceptionType.connectionError:
        throw NoInternetException(requestOptions: err.requestOptions);
      case DioExceptionType.badCertificate:
        throw DioException(requestOptions: err.requestOptions);
      case DioExceptionType.badResponse:
        throw DioException(requestOptions: err.requestOptions);
      case DioExceptionType.cancel:
        throw DioException(requestOptions: err.requestOptions);
      case DioExceptionType.unknown:
        throw UnknownErrorException(requestOptions: err.requestOptions);
    }
  }
  }

class TimeoutException extends DioException {
  TimeoutException({required super.requestOptions});

  @override
  String toString() {
    return "Connection timeout. Please try again later";
  }
}

class UnknownErrorException extends DioException {
  UnknownErrorException({required super.requestOptions});

  @override
  String toString() {
    return "Unknown error occured. Please try again later";
  }
}

class NoInternetException extends DioException {
  NoInternetException({required super.requestOptions});

  @override
  String toString() {
    return "No internet detected, please check your connection";
  }
}
