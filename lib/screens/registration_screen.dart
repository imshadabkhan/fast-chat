import 'package:fast_chat/components/rounded_button.dart';
import 'package:fast_chat/resources/constants.dart';
import 'package:fast_chat/resources/routes_manger.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _showSpinner=false;

  Future _registerUserWithFirebase() async {
    setState(() {
      _showSpinner=true;
    });
    try {
      await _auth.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text);
     Navigator.pushNamed(
    context, RoutesNames.chatRoute);
     setState(() {
       _showSpinner=false;
     });
      print("User Registered successfully");
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      setState(() {
        _showSpinner=false;
      });
    }finally{

      setState(() {
        _showSpinner=false ;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: _showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Hero(
                tag: "logo",
                child: Container(
                  height: 200.0,
                  child: Image.asset('images/logo.png'),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                keyboardType:TextInputType.emailAddress ,
                  controller: _emailController,
                  onChanged: (value) {
                    //Do something with the user input.
                  },
                  decoration: KTextFieldDecoration.copyWith(
                      hintText: "Enter Your Email")),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                  controller: _passwordController,
                  onChanged: (value) {
                    //Do something with the user input.
                  },
                  decoration: KTextFieldDecoration.copyWith(
                      hintText: "Enter Your Password")),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                colour: Colors.blueAccent,
                text: 'Register',
                onPressed: () {
                  _registerUserWithFirebase();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
