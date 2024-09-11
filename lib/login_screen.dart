import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterdemo/home_page.dart';
import 'package:flutterdemo/register_screen.dart';
import 'package:flutterdemo/utils/CoreUtil.dart';
import 'package:flutterdemo/utils/custom_button.dart';
import 'package:flutterdemo/utils/custom_textfields.dart';
import 'package:flutterdemo/utils/hiveUtil.dart';
import 'package:flutterdemo/utils/route_util.dart';

import 'firebase/fire_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<LoginScreen> {
  var mapData = {};
  String value = "";
  final formKey = GlobalKey<FormState>();
  HiveUtil hiveUtil = HiveUtil();
  TextEditingController Password_controller = TextEditingController();
  TextEditingController emailId_controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 40, left: 10, right: 10),
                  child: Text(
                    "Welcome Back",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const Text("Enter your credential to login",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: CustomTextField(
                      label: "Enter Email Id",
                      viewType: "email",
                      controller: emailId_controller,
                      onChanged: (value) {
                        mapData["EmailId"] = value;
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: CustomTextField(
                      label: "Enter Password",
                      viewType: "password",
                      controller: Password_controller,
                      onChanged: (value) {
                        print("value :: ${value}");
                        mapData["Password"] = value;
                      }),
                ),
                CustomButton(
                  title: "Login",
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      CoreUtil.showLoaderDialog(context);
                      User? user = await FireAuth.signInUsingEmailPassword(
                        email: emailId_controller.text,
                        password: Password_controller.text,
                        context: context,
                      );
                      if (user != null) {
                        await hiveUtil.insertData(
                            user.displayName!, user.email!);
                        print(user.displayName!);
                        /*  await SharedUtil.insertData("email", user.email!);
                        await SharedUtil.insertData("name", user.displayName!);*/
                        CoreUtil.hideLoaderDialog(context);
                        RouteUtil.navigateTo(context, const HomePage());
                      } else {
                        CoreUtil.hideLoaderDialog(context);
                      }
                    }
                  },
                ),
                InkWell(
                  onTap: () {
                    RouteUtil.navigateTo(context, const RegisterUser());
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: 'Do not have an Account? ',
                            style: TextStyle(color: Colors.black),
                          ),
                          TextSpan(
                            text: 'Register',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
