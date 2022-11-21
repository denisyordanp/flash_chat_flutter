
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    Key? key, required this.text, required this.onPressed, this.color = Colors.lightBlueAccent
  }) : super(key: key);

  final VoidCallback onPressed;
  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: color,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
              text,
            style: const TextStyle(
              color: Colors.white
            ),
          ),
        ),
      ),
    );
  }
}
