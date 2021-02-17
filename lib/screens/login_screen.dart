import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/Components/RoundedButton.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {

  //No need to create a object to use the id because it is now a static field i.e it's same for all the instances of class.
  static const String id = "Login_Screen";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _auth= FirebaseAuth.instance;
  String email;
  String password;
  bool _spinner=false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _spinner,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  //tag property is used to identify where to transition this image on the target page.
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                // obscureText: true,
                style: TextStyle(color: Colors.black54),
                onChanged: (value) {
                  //Do something with the user input.
                  email=value;
                },
                decoration: InputDecoration(
                  hintText: "Enter your email here ... ",
                  hintStyle: TextStyle(color: Colors.black54),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.lightBlueAccent, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.lightBlueAccent, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                style: TextStyle(color: Colors.black54),
                onChanged: (value) {
                  //Do something with the user input.
                  password=value;
                },
                decoration: InputDecoration(
                  hintText: 'Enter your password.',
                  hintStyle: TextStyle(color: Colors.black54),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.lightBlueAccent, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.lightBlueAccent, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                ),
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(onPressed: () async {
                try{
                  setState(() {
                    _spinner=true;
                  });
                  final user= await _auth.signInWithEmailAndPassword(email: email, password: password);
                  if(user!=null) Navigator.pushNamed(context, ChatScreen.id);
                  setState(() {
                    _spinner=false;
                  });
                }catch(e){
                  print(e);
                }
              },title: "Log In",color: Colors.lightBlueAccent,),
            ],
          ),
        ),
      ),
    );
  }
}
