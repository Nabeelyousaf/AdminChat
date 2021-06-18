import 'package:firebase_auth/firebase_auth.dart';
import 'package:flashscreen/ChatScreen.dart';
import 'package:flashscreen/Info.dart';
import 'package:flashscreen/constants.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

User loggedInUser;

final _auth = FirebaseAuth.instance;

class LoginScreen extends StatefulWidget {
  static const String id = 'LoginScreen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  void getCurrentUser() async {
    final user = await _auth.currentUser;
    if (user != null) {
      loggedInUser = user;
      // print(loggedInUser.email);
    }
  }

  final auth = FirebaseAuth.instance;
  bool spinnerShow = false;
  String email;
  String password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: 48.0,
              ),
              TextField(
                style: TextStyle(
                  color: Colors.pinkAccent,
                ),
                onChanged: (value) {
                  email = value;

                  //Do something with the user input.
                },
                decoration:
                    ktextFormField.copyWith(hintText: 'Enter Your Email'),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                style: TextStyle(
                  color: Colors.pinkAccent,
                ),
                onChanged: (value) {
                  password = value;
                  //Do something with the user input.
                },
                decoration: ktextFormField.copyWith(
                  hintText: 'Enter Your password',
                ),
              ),
              SizedBox(
                height: 24.0,
              ),
              Button(
                text: 'Login',
                onPressd: () async {
                  setState(() {
                    spinnerShow = true;
                  });
                  try {
                    final user = await auth.signInWithEmailAndPassword(
                        email: email, password: password);
                    // final user = await auth.signInAnonymously();

                    print('uid=' + auth.currentUser.uid);
                    getCurrentUser();
                    if (user != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => UserChat(),
                        ),
                      );
                    }
                    setState(() {
                      spinnerShow = false;
                    });
                  } catch (e) {
                    print(e);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Button extends StatelessWidget {
  final String text;
  final Function onPressd;

  const Button({this.text, this.onPressd});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: Colors.lightBlueAccent,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: onPressd,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            text,
          ),
        ),
      ),
    );
  }
}
