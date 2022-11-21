import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat_flutter/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../constants.dart';
import '../widgets/primary_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const id = "login_screen";

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  String password = "";
  String email = "";
  bool isShowSpinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: isShowSpinner,
        child: Padding(
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
                  email = value;
                },
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                decoration: kDefaultInputDecoration.copyWith(
                  hintText: "Enter you email"
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                onChanged: (value) {
                  password = value;
                },
                textAlign: TextAlign.center,
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                decoration: kDefaultInputDecoration.copyWith(
                    hintText: "Enter you password",
                ),
              ),
              const SizedBox(
                height: 24.0,
              ),
              PrimaryButton(
                text: 'Log In',
                onPressed: () async {
                  setSpinner(true);
                  try {
                    await _auth.signInWithEmailAndPassword(email: email, password: password);
                    _goToChatScreen();
                    setSpinner(false);
                  } catch(e) {
                    print(e);
                    setSpinner(false);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void setSpinner(bool isShow) {
    setState(() {
      isShowSpinner = isShow;
    });
  }

  void _goToChatScreen() {
    Navigator.pushNamed(context, ChatScreen.id);
  }
}
