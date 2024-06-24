import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PetAdopt extends StatefulWidget {
  const PetAdopt({super.key});

  @override
  State<PetAdopt> createState() => _PetAdoptState();
}

class _PetAdoptState extends State<PetAdopt> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.indigoAccent,
      appBar: AppBar(
        backgroundColor: Colors.indigoAccent,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)
          ),
        ),
      ),
    );
  }
}
