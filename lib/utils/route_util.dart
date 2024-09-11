import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RouteUtil {

  static navigateTo(BuildContext context, Widget widget){
    Navigator.pushReplacement(context,
      MaterialPageRoute(builder: (context) =>  widget),);
  }


}