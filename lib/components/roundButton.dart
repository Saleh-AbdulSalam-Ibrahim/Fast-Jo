import 'package:fast_jo_u/methods/login.dart';
import 'package:fast_jo_u/screens/login_screen.dart';
import 'package:fast_jo_u/screens/main_screen.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
    RoundedButton({required this.colour, required this.title, required this.onPressed});
  final String title;
  final Function onPressed;
  final Color colour;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: colour,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: onPressed.call(),
        child:  Text(title,
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
