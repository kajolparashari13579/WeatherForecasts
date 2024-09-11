import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String label, viewType;
  final Function(String) onChanged;
  TextEditingController controller;

  CustomTextField(
      {super.key,
        required this.label,
        required this.viewType,
        required this.onChanged,
        required this.controller});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      child: TextFormField(
        key: UniqueKey(),
        controller: widget.controller,
        decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                )),
            filled: true,
            fillColor: Colors.blue[100],
            hintText: widget.label,
            hintStyle: const TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.bold)),
        keyboardType: checkKeyboardType(widget.viewType),
        obscureText: widget.viewType == "password" ? true : false,
        maxLength: widget.viewType == "password" ? 6 : 50,
        validator: (text) {
          if (!isValid(widget.viewType, text!)) {
            return checkErrorType(widget.viewType, text);
          }
          return null;
        },
        onChanged: (value) {
          widget.onChanged(value);
        },
      ),
    );
  }

  TextInputType checkKeyboardType(String type) {
    if (type == "normal") {
      return TextInputType.text;
    } else if (type == "email") {
      return TextInputType.emailAddress;
    } else if (type == "numeric") {
      return TextInputType.number;
    } else if (type == "password") {
      return TextInputType.visiblePassword;
    } else {
      return TextInputType.text;
    }
  }

  bool isValid(String type, String value) {
    bool isValidField = false;
    if (type == "normal") {
      if (value.length < 5 || value.isEmpty) {
        isValidField = false;
      } else {
        isValidField = true;
      }
      return isValidField;
    } else if (type == "email") {
      if (!value.contains(".") || !value.contains("@") || value.isEmpty) {
        isValidField = false;
      } else {
        isValidField = true;
      }
      return isValidField;
    } else if (type == "numeric") {
      if (value.isEmpty) {
        isValidField = false;
      } else {
        isValidField = true;
      }
      return isValidField;
    } else if (type == "password") {
      if (value.length < 5 || value.isEmpty) {
        isValidField = false;
      } else {
        isValidField = true;
      }
      return isValidField;
    } else {
      return isValidField;
    }
  }

  String? checkErrorType(String type, String value) {
    String msg = "";
    if (type == "normal") {
      if (value.length < 5 || value.isEmpty) {
        msg = "Enter valid name of more then 5 characters!";
      }
      return msg;
    } else if (type == "email") {
      if (!value.contains(".") || !value.contains("@") || value.isEmpty) {
        msg = "Enter valid email address";
      }
      return msg;
    } else if (type == "numeric") {
      return "Enter valid number";
    } else if (type == "password") {
      if (value.length < 5 || value.isEmpty) {
        msg = "Enter valid password";
      }
      return msg;
    } else {
      return null;
    }
  }
}