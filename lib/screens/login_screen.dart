import 'package:fast_chat/resources/constants.dart';
import 'package:fast_chat/resources/routes_manger.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../components/rounded_button.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _email=TextEditingController();
  final TextEditingController _password=TextEditingController();
  bool _showSpinner=false;
  FirebaseAuth _auth=FirebaseAuth.instance;
  Future<void> loginUser()async{

    try{
      setState(() {
        _showSpinner=true;
      });
      await _auth.signInWithEmailAndPassword(email: _email.text, password: _password.text);
      Navigator.pushNamed(context, RoutesNames.chatRoute);
    setState(() {
      _showSpinner=false;
    });
    }on FirebaseAuthException catch(e){
      if(kDebugMode){
        print(e);
      }
      setState(() {
        _showSpinner=false;
      });
    }finally{
      setState(() {
        _showSpinner=false;
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
              Hero(tag: "logo", child:  Container(
                height: 200.0,
                child: Image.asset('images/logo.png'),
              ),),
        
              SizedBox(
                height: 48.0,
              ),
              TextField(
                controller: _email,
                onChanged: (value) {
                  //Do something with the user input.
                },
                decoration: KTextFieldDecoration.copyWith(hintText: "Enter Your Email")
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                controller: _password,
                onChanged: (value) {
                  //Do something with the user input.
                },
                decoration:KTextFieldDecoration.copyWith(hintText: "Enter Your Password")
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(onPressed: (){loginUser();},text: "Login",colour:Colors.lightBlueAccent,),
            ],
          ),
        ),
      ),
    );
  }
}


