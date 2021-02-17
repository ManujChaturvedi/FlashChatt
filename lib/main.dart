import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flash_chat/screens/chat_screen.dart';

import 'screens/welcome_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(FlashChat());
}

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        textTheme: TextTheme(
          body1: TextStyle(color: Colors.black54),
        ),
      ),

      //can't use home and initial route at the same time because they do the same thing so they will conflict.
      // home: WelcomeScreen(),

      initialRoute: WelcomeScreen.id,

      // A map of routes that takes a anms_Function and build the specified screen.

      routes: {
        WelcomeScreen.id: (context)=>WelcomeScreen(),
        LoginScreen.id: (context)=>LoginScreen(),
        RegistrationScreen.id: (context)=>RegistrationScreen(),
        ChatScreen.id:(context)=>ChatScreen(),
      },

    );
  }
}
