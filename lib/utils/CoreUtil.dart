import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CoreUtil {
  static showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: SizedBox(
        width: 100,
        height: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  margin: EdgeInsets.only(left: 7), child: Text("Loading...")),
            ),
          ],
        ),
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static hideLoaderDialog(BuildContext context) {
    Navigator.pop(context);
  }
}