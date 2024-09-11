import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
   String title;
   VoidCallback onPressed;
   CustomButton({super.key, required this.title,required this.onPressed});

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        widget.onPressed.call();
      },
      child: Text(
        widget.title,
        style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600),
      ),
    );
  }
}
