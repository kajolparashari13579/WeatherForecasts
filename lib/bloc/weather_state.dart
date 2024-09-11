import 'package:equatable/equatable.dart';

import '../model/custom_error.dart';
import '../model/weather.dart';

class WeatherState extends Equatable{

  WeatherState();

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}

class WeatherInitialState extends WeatherState{
}

class WeatherLoadingState extends WeatherState{
}


class WeatherErrorState extends WeatherState{
  final CustomError error;
  WeatherErrorState({required this.error});
}

class WeatherSuccessState extends WeatherState{
  final Weather weather;
  final bool isHot;

  WeatherSuccessState({required this.weather, required this.isHot});
}

