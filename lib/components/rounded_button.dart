import 'package:flutter/material.dart';
class RoundedButton extends StatelessWidget {
  RoundedButton({this.colour,this.text, required this.onPressed});
  final Color? colour;
  final String? text;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        // color: Colors.lightBlueAccent,
        color: colour,
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        elevation: 5.0,
        child: MaterialButton(
          onPressed:onPressed,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            text!,
          ),
        ),
      ),
    );
  }
}