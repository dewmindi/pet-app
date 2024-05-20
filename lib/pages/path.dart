import 'package:flutter/material.dart';

class pathScreen extends StatelessWidget {
  const pathScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text('Leo', style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold
          ),),
          SizedBox(height: 20),
          Image.asset('cats/cat1.png'),
        ],
      ),
    );
  }
}
