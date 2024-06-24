import 'package:firstapp/temp.dart';
import 'package:firstapp/tempMed.dart';
import 'package:flutter/material.dart';

class Medications extends StatefulWidget {
  const Medications({super.key});

  @override
  State<Medications> createState() => _MedicationsState();
}

class _MedicationsState extends State<Medications> {
  final Map<String, bool> _isHovered = {};
  final Map<String, bool> _isClicked = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30), topLeft: Radius.circular(30))
          ),
          margin: const EdgeInsets.only(top: 18, left: 24, right: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Hi, Sonu',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(Icons.person_2_sharp),
                ],
              ),
              Expanded(
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    SizedBox(height: 15),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: Container(
                        height: 150,
                        width: 200,
                        color: Colors.indigoAccent,
                      ),
                    ),
                    SizedBox(height: 30),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _cardMenu(
                          key: ValueKey('MEET A DOCTOR'),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Channel(),
                              ),
                            );
                          },
                          title: 'MEET A DOCTOR',
                          icon: 'assets/images/med.png',
                          fontColor: Colors.black,
                          color: Colors.indigoAccent,
                        ),
                        SizedBox(height: 15),
                        _cardMenu(
                          key: ValueKey('MED REMINDER'),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => tempMed(),
                              ),
                            );
                          },
                          title: 'MED REMINDER',
                          icon: 'assets/images/med.png',
                          fontColor: Colors.black,
                          color: Colors.indigoAccent,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _cardMenu({
    required ValueKey<String> key,
    required String title,
    required String icon,
    VoidCallback? onTap,
    Color color = Colors.white,
    Color fontColor = Colors.grey,
    double iconHeight = 50,
    double iconWidth = 50,
  }) {
    return MouseRegion(
      onEnter: (_) => _onHover(key.value, true),
      onExit: (_) => _onHover(key.value, false),
      child: GestureDetector(
        onTapDown: (_) => _onClick(key.value, true),
        onTapUp: (_) {
          _onClick(key.value, false);
          if (onTap != null) onTap();
        },
        onTapCancel: () => _onClick(key.value, false),
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(vertical: 30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: _isClicked[key.value] == true
                ? Colors.blueGrey
                : (_isHovered[key.value] == true ? Colors.blueGrey : color),
          ),
          child: Column(
            children: [
              Image.asset(
                icon,
                height: iconHeight,
                width: iconWidth,
              ),
              SizedBox(height: 10),
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: fontColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  void _onHover(String key, bool isHovered) {
    setState(() {
      _isHovered[key] = isHovered;
    });
  }

  void _onClick(String key, bool isClicked) {
    setState(() {
      _isClicked[key] = isClicked;
    });
  }
}
