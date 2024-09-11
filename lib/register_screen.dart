
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutterdemo/login_screen.dart';
import 'package:flutterdemo/utils/CoreUtil.dart';
import 'package:flutterdemo/utils/custom_button.dart';
import 'package:flutterdemo/utils/custom_textfields.dart';
import 'package:flutterdemo/utils/route_util.dart';

import 'firebase/fire_auth.dart';




class RegisterUser extends StatefulWidget {
  const RegisterUser({super.key});

  @override
  State<RegisterUser> createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {
  var mapData = {};
  String value = "";
  bool _validate = false;
  final formKey = GlobalKey<FormState>();
  TextEditingController userName_controller = TextEditingController();
  TextEditingController Password_controller = TextEditingController();
  TextEditingController emailId_controller = TextEditingController();

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
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: const Text("Enter your credential to Register",
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40, left: 10, right: 10),
                  child: CustomTextField(
                      label: "Enter User Name",
                      viewType: "normal",
                      controller: userName_controller,
                      onChanged: (value) {
                        print("value :: ${value}");
                        mapData["UserName"] = value;
                      }),
                ),
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
                Text(value),
                CustomButton(
                  title: "Register",
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      CoreUtil.showLoaderDialog(context);
                      User? user = await FireAuth.registerUsingEmailPassword(
                          name: userName_controller.text,
                          email: emailId_controller.text,
                          password: Password_controller.text);
                      if (user != null) {
                        CoreUtil.hideLoaderDialog(context);
                        RouteUtil.navigateTo(context, const LoginScreen());
                      } else {
                        CoreUtil.hideLoaderDialog(context);
                      }
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}