import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterdemo/bloc/weather_bloc.dart';
import 'package:flutterdemo/model/user.dart';
import 'package:flutterdemo/repositories/weather_repository.dart';
import 'package:flutterdemo/services/weather_api_services.dart';
import 'package:flutterdemo/splash_screen.dart';
import 'package:flutterdemo/temp_settings/temp_settings_cubit.dart';
import 'package:flutterdemo/theme/theme_bloc.dart';
import 'package:flutterdemo/theme/theme_custom.dart';
import 'package:flutterdemo/theme/theme_state.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import 'firebase/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());

  await Hive.openBox("UserDetails");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<WeatherBloc>(create: (context) => WeatherBloc()),
      BlocProvider<TempSettingsCubit>(create: (context) => TempSettingsCubit()),
    ], child: getMaterialApp());
  }

  Widget getMaterialApp() {
    return BlocProvider(
      create: (context) => ThemeBloc(),
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          var isDark = state.themeData.brightness == Brightness.dark;
          return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(useMaterial3: true, brightness:
            Brightness.light, colorScheme: MaterialTheme.lightScheme()),
            darkTheme: ThemeData(
              useMaterial3: true,
              brightness: Brightness.dark, colorScheme: MaterialTheme.darkScheme()
            ),
            themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
