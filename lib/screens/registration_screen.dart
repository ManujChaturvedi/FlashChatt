
import 'package:firebase_core/firebase_core.dart';
import 'package:flash_chat/Components/RoundedButton.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegistrationScreen extends StatefulWidget {

  //No need to create a object to use the id because it is now a static field i.e it's same for all the instances of class.
  static const String id = "Registration_Screen";

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();

}

class _RegistrationScreenState extends State<RegistrationScreen> {

  bool spinner=false;
  final _auth=FirebaseAuth.instance;
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: spinner,
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
                style: TextStyle(color: Colors.black54),
                textAlign: TextAlign.center,
                onChanged: (value) {
                  //Do something with the user input.
                  email=value;
                },
                decoration: InputDecoration(
                  hintText: 'Enter your email',
                  hintStyle: TextStyle(color: Colors.black54),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
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
                textAlign: TextAlign.center,
                onChanged: (value) {
                  //Do something with the user input.
                  password=value;
                },
                decoration: InputDecoration(
                  hintText: 'Enter your password',
                  hintStyle: TextStyle(color: Colors.black54),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                ),
              ),
              SizedBox(
                height: 24.0,
              ),
              // we convert the on pressed to async because it will work with a future .
              RoundedButton(onPressed: () async {
                // print(email);
                // print(password);
                setState(() {
                  spinner=true;
                });
                // built in method to sign in via firebase auth package and store the new user detail in the variable .
                try{
                  final newUser= await _auth.createUserWithEmailAndPassword(email: email, password: password);
                  if(newUser!=null) {
                      Navigator.pushNamed(context, ChatScreen.id);
                    }
                    setState(() {
                      spinner=false;
                    });
                }catch(e){
                  print(1);
                }

              },title: "Register",color: Colors.blueAccent,),
            ],
          ),
        ),
      ),
    );
  }
}
