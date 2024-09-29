import 'package:flutter/material.dart';


class Pettrack extends StatefulWidget {
  const Pettrack({super.key});

  @override
  State<Pettrack> createState() => _PettrackState();
}

class _PettrackState extends State<Pettrack> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Track'),
        backgroundColor: Colors.indigoAccent,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)
          ),
        ),
        child: Row(
          children: [
              Image(image: AssetImage('assets/images/map.png'),
                height: 300,
                width: MediaQuery.of(context).size.width,
              )
          ],
        ),
      ),
    );
  }
}
