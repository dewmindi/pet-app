import 'package:flutter/material.dart';

import 'adminHomePage.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image with Opacity
          Opacity(
            opacity: 0.6, // Set opacity between 0.0 to 1.0
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/splash_images/startScreen.jpg"), // Replace with your image asset path
                  fit: BoxFit.cover, // Makes the image cover the entire screen
                ),
              ),
            ),
          ),
          // Foreground content (Login form)
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 30),
                // Email TextField
                TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person, color: Colors.white,),
                    hintText: 'Username',
                    hintStyle: TextStyle(
                      color: Colors.white, // Change hint text color
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.white, // Change default border color
                        width: 1.5,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                // Password TextField
                TextField(
                  style: TextStyle(
                      color: Colors.white
                  ),
                  obscureText: true,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock, color: Colors.white,),
                    hintText: 'Password',
                    hintStyle: TextStyle(
                      color: Colors.white, // Change hint text color
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    suffixText: 'Forgot?',
                  ),
                ),
                SizedBox(height: 50),
                // Login button
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>AdminHomePage()));
                  },
                  child: Text('Login'),
                  style: ElevatedButton.styleFrom(
                    shadowColor: Colors.indigoAccent,
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 100),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
