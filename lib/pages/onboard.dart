import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pet_app/const.dart';
import '../models/onboard_models.dart';
//import 'home.dart';
import 'HomePage.dart';

class OnBoardPage extends StatefulWidget {
  const OnBoardPage({super.key});

  @override
  State<OnBoardPage> createState() => _OnBoardPageState();
}

class _OnBoardPageState extends State<OnBoardPage> {
  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              height: MediaQuery.of(context).size.height*0.75,
              color: Colors.white,
              child: PageView.builder(
                  onPageChanged: (value){
                    setState(() {
                      currentPage = value;
                    });
                  },
                  itemCount: onBoardData.length,
                  itemBuilder: (context, index) =>OnBoardContent(onBoard:
                  onBoardData[index],
                  )
              ),
            ),
          ),
          GestureDetector(
            onTap: (){
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context)=> Home()),
                      (route) => false);
            },
            child: Container(
              height: 50,
              width: MediaQuery.of(context).size.width*0.6,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10), boxShadow: [BoxShadow(
                  offset: Offset(0, 3),
                  color: Colors.blue,
                  spreadRadius: 0,
                blurRadius: 10,

                )
              ]
              ),
              child: Center(
                child: Text(
                    currentPage == onBoardData.length-1
                     ? 'Get Started':
                    'Continue', style: TextStyle(
                   color: Colors.white, fontSize: 16
                  )
                ),
              ),
            ),
          ),
          SizedBox(height:20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...List.generate(onBoardData.length, (index) => indicator(index: index))
            ],
          ),
        ],
      ),
    );
  }
  AnimatedContainer indicator({int? index }){
    return AnimatedContainer(duration: Duration(milliseconds: 500), width:
    currentPage==index?20:6,
      height: 6,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(3),
      color: currentPage==index?Colors.orange: Colors.black.withOpacity(0.6)
      ),
    );
  }
}
class OnBoardContent extends StatelessWidget {
  final OnBoards onBoard;

  const OnBoardContent({super.key, required this.onBoard});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: MediaQuery.of(context).size.height*0.5,
          width: MediaQuery.of(context).size.width-40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))
          ),
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width-40,
                    color: Colors.orangeAccent,
                    child: Stack(
                      children: [

                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                  bottom: 0,
                  right: 45,
                  child: Image.asset('girls/girl-onboard1.png', height:300,)
              )
            ],
          ),
        ),
         SizedBox(height: 10),
         Text.rich(
            TextSpan(
                style: TextStyle(fontSize: 32.0, height: 1.2),
                children:[
                  TextSpan(text: 'Find Your ',style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: 'Dream\n', style: TextStyle(fontWeight: FontWeight.bold) ),
                  TextSpan(text: 'Pet Here', style: TextStyle(fontWeight: FontWeight.bold)),
                ]),
              textAlign: TextAlign.center,
        ),
        SizedBox(height: 2),
        Text(
          onBoard.text,
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.indigo.withOpacity(0.6)),
        )
      ],
    );
  }
}
