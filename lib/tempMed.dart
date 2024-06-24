import 'package:firstapp/pillSchedule.dart';
import 'package:firstapp/temp.dart';
import 'package:flutter/material.dart';

import 'package:firstapp/tempDoc.dart';
import 'package:flutter/material.dart';

class tempMed extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => tempMedState();
}

class tempMedState extends State<tempMed> {
  @override
  Widget build(BuildContext context) {
    return initScreen();
  }

  Widget initScreen() {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.indigoAccent,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.indigoAccent,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        actions: [
          GestureDetector(
            child: Container(
              margin: EdgeInsets.only(right: 10),
              child: Icon(
                Icons.notifications_rounded,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30), topLeft: Radius.circular(30))
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: 50, left: 20, right: 20),
              width: size.width,
              height: 150,

              child: Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: Container(
                      margin: EdgeInsets.only(left: 10, right: 10),
                      child: Column(
                        children: [
                          Text(
                              'Easily Connect With Vets & Schedule Pet Medications'
                                  ' With Reminders',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Roboto'
                            ),
                          ),
                          SizedBox(height: 30),
                          Text(
                            'Ensure Top Care Of Your Furry Friend',
                            style: TextStyle(
                              color: Color(0xff363636),
                              fontSize: 15,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                child: ListView(
                  children: [
                    _categoryItem(
                      "assets/images/vet.png",
                      "Meet a Doctor",
                      "Channel Now",
                        (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> Channel()));
                        }
                    ),
                    _categoryItem(
                      "assets/images/pills.png",
                      "Schedule pills",
                      "Set Reminders",
                            (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> pillSchedule()));
                        }
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }


  Widget _categoryItem(String img, String name, String txt, Function() onTap) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      // onTap: () {
      //   Navigator.push(context, MaterialPageRoute(builder: (context) => Channel()));
      // },
      onTap: onTap,
      child: Container(
        height: 90,
        // width: size.width,
        margin: EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          color: Colors.indigoAccent,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: 20),
              height: 90,
              width: 50,
              child: Image.asset(img),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Text(
                      name,
                      style: TextStyle(
                        color: Color(0xff363636),
                        fontSize: 17,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Row(
                      children: [
                        Text(
                          txt,
                          style: TextStyle(
                            color: Color(0xffababab),
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}