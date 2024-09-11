import 'dart:convert';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutterdemo/network/ErrorInterceptors.dart';
import 'package:flutterdemo/network/Urls.dart';
import 'package:http/http.dart' as http;

import '../exceptions/weather_exception.dart';
import '../model/weather.dart';
import 'http_error_handler.dart';

class WeatherApiServices {
  Future<Weather> getWeather(String city) async {
    try {
      var dio = Dio();
      final response = await dio.request(
        "${Urls.BaseUrl}${Urls.path}",
        options: Options(
          method: 'GET',
        ),
        queryParameters: {
          'q': city,
          'appid': "f7ac7c32e551705d01f1c4bdd546109b",
        },
      );
      ErrorInterceptor interceptor = ErrorInterceptor();
      dio.interceptors.addAll({interceptor});
      if (response.statusCode == 200) {
        return Weather.fromJson(response.data);
      } else {
        throw WeatherException('Cannot get the weather of the city');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
