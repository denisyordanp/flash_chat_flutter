import 'package:flutter/material.dart';

import '../constants.dart';
import '../widgets/primary_button.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  static const id = "registration_screen";

  @override
  RegistrationScreenState createState() => RegistrationScreenState();
}

class RegistrationScreenState extends State<RegistrationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Hero(
              tag: kLogoHeroTag,
              child: SizedBox(
                height: 200.0,
                child: Image.asset('images/logo.png'),
              ),
            ),
            const SizedBox(
              height: 48.0,
            ),
            TextField(
              onChanged: (value) {
                //Do something with the user input.
              },
              decoration: kDefaultInputDecoration.copyWith(
                  hintText: "Enter you email"
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            TextField(
              onChanged: (value) {
                //Do something with the user input.
              },
              decoration: kDefaultInputDecoration.copyWith(
                  hintText: "Enter you password"
              ),
            ),
            const SizedBox(
              height: 24.0,
            ),
            PrimaryButton(
              text: 'Register',
              color: Colors.blueAccent,
              onPressed: () { },
            ),
          ],
        ),
      ),
    );
  }
}
