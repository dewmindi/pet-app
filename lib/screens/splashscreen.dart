import 'dart:async';
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
      Duration(seconds: 3),
        () => Navigator.push(context, MaterialPageRoute(builder: (context)=> WelcomeScreen(),))
    );
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
            image: AssetImage('assets/splash_images/dog.jpg'),
            fit: BoxFit.cover,
            opacity: 0.4,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage(
                    //'assets/splash_images/iconDog.png',
                    'assets/splash_images/Dogicon.png',
                ),
                height: 200,
                width: 200,
                color: Colors.black54,
              ),
              Text(
                  'Baw Baw',
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
