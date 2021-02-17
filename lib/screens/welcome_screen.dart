import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flash_chat/Components/RoundedButton.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {

  //No need to create a object to use the id because it is now a static field i.e it's same for all the instances of class.
  static const String id = "Welcome_Screen";

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();

}
/*
    the animation in flutter require 3 things:

    1. The ticker : every time a ticker ticks a new set state is triggered and a new thing is rendered

    2. Animation Controller : Manager of animation. It tells the animation to start stop loop and stuff.

    3. An Animation Value : Actually does the animation

    mixin enable the class with different capabilities (abilities)
    SingleTickerProviderStateMixin enables the _WelcomeScreenState to act as the ticker provider

*/



class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin {

  AnimationController controller;
  Animation animation;

  @override
  void initState() {

    super.initState();
    controller = AnimationController(
      // in V sync we provide the ticker
      duration: Duration(seconds: 1),
      vsync:this,
    );
    // proceed the animation , a number between 0 to 1.
    controller.forward();
    animation=ColorTween(begin: Colors.blueGrey , end: Colors.white).animate(controller);
    //to see the animator changing the value , we add a listener.
    controller.addListener(() {
      setState(() {

      });
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                //Hero widget used for animating the lightning sign.
                Hero(
                  //tag property is used to identify where to transit this image on the target page.
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: 60.0,
                  ),
                ),
                TypewriterAnimatedTextKit(
                  text:['Flash ChaT'],
                  textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            RoundedButton(onPressed: ()  {Navigator.pushNamed(context, LoginScreen.id);}, title: "Log In", color: Colors.lightBlueAccent,),
            RoundedButton(onPressed: () {Navigator.pushNamed(context, RegistrationScreen.id);}, color: Colors.blueAccent, title: "Register",
            ),
          ],
        ),
      ),
    );
  }
}

