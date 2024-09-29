import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../home.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {

  void initState(){
    super.initState();
    Timer(
      Duration(seconds: 10),
        () => _checkAuthentication(),
    );
  }

  Future<void> _checkAuthentication()async{
    User ? user = FirebaseAuth.instance.currentUser;
    if(user!=null){
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context)=> Homepage()),
      );
    }else {
      // User is not signed in, navigate to SignInScreen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => WelcomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Material(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.indigo,
          image: DecorationImage(
            image: AssetImage('assets/splash_images/startScreen.jpg'),
            fit: BoxFit.cover,
            opacity: 0.6,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage(
                    //'assets/splash_images/iconDog.png',
                    'assets/splash_images/animals.png',
                ),
                height: 150,
                width: 150,
                color: Colors.black54,
              ),
              Text(
                  'PetPal',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 50,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
