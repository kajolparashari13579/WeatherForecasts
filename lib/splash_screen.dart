import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutterdemo/into_page.dart';
import 'package:flutterdemo/login_screen.dart';
import 'package:flutterdemo/utils/route_util.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primaryFixed,
                    Theme.of(context).colorScheme.surfaceDim,
                  ],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
          ),
          Image.asset("assets/images/weather_appicon.png", width: 150, height: 150),
          SizedBox(height: 20),
          const Center(
            child: Text("Weather",
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const Center(
            child: Text("Forecasts",
              style: TextStyle(
                  fontSize: 22,
                  color: Colors.green,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }

  void getUserData() {
    Timer(const Duration (seconds: 2), () {
      RouteUtil.navigateTo(context, IntroPage());
    });
  }
}
