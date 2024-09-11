import 'package:bloc/bloc.dart';
import 'package:flutterdemo/bloc/weather_event.dart';
import 'package:flutterdemo/bloc/weather_state.dart';

import '../constants/temperature.dart';
import '../model/custom_error.dart';
import '../repositories/weather_repository.dart';
import '../services/weather_api_services.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitialState()) {
    on<WeatherEvent>((event, emit) async {
      if (event is FetchWeather) {
        fetchWeather(event.cityName);
      }
    });
  }

  bool analyzeWeather(double currentTemp) {
    bool isHot = false;
    if (currentTemp > kCoolOrHot) {
      isHot = true;
    } else {
      isHot:
      false;
    }
    return isHot;
  }

  Future<void> fetchWeather(String cityName) async {
    emit(WeatherLoadingState());
    try {
      var weatherRepository = WeatherRepository(
          weatherApiServices: WeatherApiServices());
          await weatherRepository.fetchWeather(cityName).then((weather) {
        emit(WeatherSuccessState(
            weather: weather, isHot: analyzeWeather(weather.temp!)));
      });
    } on CustomError catch (e) {
      emit(WeatherErrorState(error: e));
    }
  }
}
