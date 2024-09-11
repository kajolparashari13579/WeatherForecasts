import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutterdemo/home_page.dart';
import 'package:flutterdemo/login_screen.dart';
import 'package:flutterdemo/register_screen.dart';
import 'package:flutterdemo/utils/custom_button.dart';
import 'package:flutterdemo/utils/route_util.dart';


List<String> image = [
  'assets/images/weather1.png',
  'assets/images/weather3.png',
  'assets/images/weather2.png'
];

List<String> title = [
  'Check Daily Weather',
  'Realtime Updates',
  'Personalize your app',
];

List<String> text = [
  'Get forecasts for your location',
  'Experience the weather in real-time',
  'Customize your app with your preferred units'
];

class IntroPage extends StatefulWidget {
  @override
  State<IntroPage> createState() => IntroPageState();
}

class IntroPageState extends State<IntroPage> {
  late CarouselSlider carouselSlider;
  int carouselIndex = 0;
  CarouselSliderController buttonCarouselController =
      CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    carouselSlider = CarouselSlider(
      carouselController: buttonCarouselController,
      items: <Widget>[
        CarouselComponent(
          col1: Theme.of(context).colorScheme.surfaceContainerLow,
          col2: Theme.of(context).colorScheme.inversePrimary,
          imgUrl: image[0],
          ttl: title[0],
          txt: text[0],
        ),
        CarouselComponent(
          col1: Theme.of(context).colorScheme.surfaceContainerLow,
          col2: Theme.of(context).colorScheme.tertiaryContainer,
          imgUrl: image[1],
          ttl: title[1],
          txt: text[1],
        ),
        CarouselComponent(
          col1: Theme.of(context).colorScheme.surfaceContainerLow,
          col2: Theme.of(context).colorScheme.errorContainer,
          imgUrl: image[2],
          ttl: title[2],
          txt: text[2],
        ),
      ],
      options: CarouselOptions(
        viewportFraction: 1.0,
        enableInfiniteScroll: false,
        height: MediaQuery.of(context).size.height,
        onPageChanged: (index, _) {
          setState(() {
            carouselIndex = index;
          });
        },
      ),
    );

    return Scaffold(
      floatingActionButton: carouselIndex == 2
          ? Container()
          : new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                  CustomButton(
                      title: "SKIP",
                      onPressed: () {
                        RouteUtil.navigateTo(context, const HomePage());
                      }),
                  CustomButton(
                      title: "NEXT",
                      onPressed: () {
                        buttonCarouselController.nextPage(
                            duration: const Duration(milliseconds: 100),
                            curve: Curves.linear);
                        // navigateToRegisterPage(context);
                      })
                ]),
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          carouselSlider,
          carouselIndex == 2
              ? Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                          margin: const EdgeInsets.only(bottom: 10.0),
                          child: CustomButton(
                              title: "HOME",
                              onPressed: () {
                                RouteUtil.navigateTo(context, const HomePage());
                              })),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 10.0),
                        child: CustomButton(
                          title: "LOGIN",
                          onPressed: () {
                            RouteUtil.navigateTo(context, const LoginScreen());
                          })
                      ),
                    ),
                  ],
                )
              : Positioned(
                  bottom: 30,
                  child: Row(
                    children: <Widget>[
                      Indicator(
                        carouselIndex: carouselIndex,
                        indicatorIndex: 0,
                      ),
                      Indicator(
                        carouselIndex: carouselIndex,
                        indicatorIndex: 1,
                      ),
                      Indicator(
                        carouselIndex: carouselIndex,
                        indicatorIndex: 2,
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}

Future navigateToRegisterPage(context) async {
  //logic to proceed to register page
  print("Register button clicked");
}

Future navigateToLoginPage(context) async {
  //logic to proceed to register page
  print("Login button clicked");
}

class CarouselComponent extends StatelessWidget {
  final col1, col2, imgUrl, ttl, txt;

  CarouselComponent({this.col1, this.col2, this.imgUrl, this.ttl, this.txt});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.only(right: 0),
      color: col2,
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [col1, col2],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        )),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 100,
            ),
            SizedBox(
              height: 100,
            ),
            Image.asset(
              imgUrl,
              height: 150,
            ),
            const SizedBox(
              height: 60,
            ),
            Text(
              ttl,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.only(left: 30.0, right: 30.0),
              child: Text(
                txt,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
            ),

            //Show divider line close to the bottom
            const Expanded(
              child: Padding(
                padding: EdgeInsets.only(bottom: 60.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Divider(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Indicator extends StatelessWidget {
  final carouselIndex, indicatorIndex;

  Indicator({this.carouselIndex, this.indicatorIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 13,
      width: 13,
      margin: EdgeInsets.all(4),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: carouselIndex == indicatorIndex ? Colors.white : Colors.grey,
      ),
    );
  }
}
