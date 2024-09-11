import 'package:flutter/cupertino.dart';
import 'package:flutterdemo/model/user.dart';
import 'package:hive/hive.dart';

class HiveUtil {

  insertData(String nameVal,
      String emailVal) async {
    Box box = await Hive.openBox('UserDetails');
    User user = User(
      name: nameVal,
      email: emailVal,
    );
    box.put("user_detail", user);
  }

   Future<User> fetchData() async {
    var box = Hive.box("UserDetails");
    User userData = box.get("user_detail");
    return userData;
  }

  clearData() async {
    Box box = await Hive.openBox('UserDetails');
    box.clear();
  }
}
