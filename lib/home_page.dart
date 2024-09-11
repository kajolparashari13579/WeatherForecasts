import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterdemo/bloc/weather_bloc.dart';
import 'package:flutterdemo/settings_page.dart';
import 'package:flutterdemo/temp_settings/temp_settings_cubit.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import '../widgets/widgets.dart';
import 'bloc/weather_state.dart';
import 'search_page.dart';

enum _HomePageSession { destination, temp, description }

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    getLocationAddress();
  }

  getLocationAddress() async {
    String? cityName = await _determinePosition();
    if (cityName != null) {
      context.read<WeatherBloc>().fetchWeather(cityName ?? '');
    }
  }

  Future<String?> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
      forceAndroidLocationManager: true,
      timeLimit: const Duration(seconds: 10),
    );

    print("Location :: ${position.latitude} -- ${position.longitude}");
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    return placemarks.first.locality;
  }

  @override
  Widget build(BuildContext context) {
    String? cityName;

    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.white70.withOpacity(0.85),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: const Text('Weather',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                Navigator.of(context).push(createRoute(const SettingsPage()));
              },
            ),
          ],
        ),
        body: BlocConsumer<WeatherBloc, WeatherState>(
          listener: (context, state) {
            if (state is WeatherErrorState) {
              errorDialog(context, state.error.errMsg);
            }
          },
          builder: (context, state) {
            if (state is WeatherLoadingState) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.green,
                ),
              );
            } else if (state is WeatherSuccessState) {
              return Container(
                constraints: const BoxConstraints.expand(),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: state.isHot == true
                        ? const AssetImage("assets/images/hot.png")
                        : const AssetImage("assets/images/cool.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      state.weather.destination ?? "N/A",
                      style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 200.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          _showTemperature(context, state.weather.temp),
                          style: const TextStyle(
                              fontSize: 23, fontWeight: FontWeight.bold),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${_showTemperature(context, state.weather.tempMax)} (max)',
                              style: const TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 10.0),
                            Text(
                              '${_showTemperature(context, state.weather.tempMin)} (min)',
                              style: const TextStyle(fontSize: 16),
                            )
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Spacer(),
                        _showIcon(state.weather.weatherStateIcon),
                        Text(
                          state.weather.weatherStateDescription ?? 'N/A',
                          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                      ],
                    )
                  ],
                )),
              );
            } else {
              return const Center(
                child: Text(
                  'Tap the 🔍 icon to find a city.',
                  style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16),
                ),
              );
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white.withOpacity(0.8),
          onPressed: () async {
            cityName = await Navigator.of(context)
                .push(createRoute(const SearchPage()));
            if (context.mounted) {
              if (cityName != null) {
                context.read<WeatherBloc>().fetchWeather(cityName ?? '');
              }
            }
          },
          child: const Icon(Icons.search, color: Colors.black),
        ),
      ),
    );
  }
}

Widget _showIcon(String? icon) {
  return FadeInImage.assetNetwork(
    placeholder: 'assets/images/loading.gif',
    image: 'http://openweathermap.org/img/wn/$icon@2x.png',
    imageErrorBuilder: (context, error, stackTrace) {
      return const Icon(Icons.error_outline);
    },
    height: 100,
    width: 100,
  );
}

///Helper method to show temperature in Celsius or Fahrenheit.
String _showTemperature(BuildContext context, double? temperature) {
  final tempUnit = context.watch<TempSettingsCubit>().state.tempUnit;
  if (temperature != null) {
    if (tempUnit == TempUnit.Fahrenheit) {
      return '${((temperature - 273.15) * 1.8 + 32).toStringAsFixed(2)}℉';
    } else {
      return '${(temperature - 273.15).toStringAsFixed(2)}℃';
    }
  } else {
    return 'N/A';
  }
}

/*
///Helper method to show text color based on the [TextThemeState] state.
Color _textColor(BuildContext context) {
  final textTheme = context.watch<TextThemeCubit>().state.textTheme;
  if (textTheme == TextThemes.Light) {
    return Colors.white;
  }
  return Colors.black.withOpacity(0.8);
}
*/

/*extension CopyTextStyles on TextStyle {
  ///Extension method for copying [TextStyle] with a new color according to the associated [BuildContext]
  ///and the [TextThemeState] state.
  TextStyle change(BuildContext ctx) => copyWith(color: _textColor(ctx));
}*/
