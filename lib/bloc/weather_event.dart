import 'package:equatable/equatable.dart';

import '../model/weather.dart';

class WeatherEvent extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}

class FetchWeather extends WeatherEvent{
    String cityName;
    FetchWeather({required this.cityName});
}