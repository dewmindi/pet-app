import 'package:firstapp/adopt.dart';
import 'package:firstapp/feeding.dart';
import 'package:firstapp/medications.dart';
import 'package:firstapp/trackpet/tracking.dart';
import 'package:firstapp/vetChannel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _currentIndex = 0;
  final _items = [
    SalomonBottomBarItem(icon: Icon(Icons.home), title: Text('Home')),
    SalomonBottomBarItem(icon: Icon(Icons.pets), title: Text('Adopt')),
    SalomonBottomBarItem(icon: Icon(Icons.food_bank), title: Text('Feed')),
    SalomonBottomBarItem(icon: Icon(Icons.medication), title: Text('Medication')),
    SalomonBottomBarItem(icon: Icon(Icons.map), title: Text('Track')),
  ];


  final List<Widget> _screens = [
    Homepage(),
    PetAdopt(),
    Feeding(),
    Medications(),
    Pettrack(),
  ];

  final Map<String, bool> _isHovered = {};
  final Map<String, bool> _isClicked = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Card(
        elevation: 6,
        margin: const EdgeInsets.all(5.0),
        child: SalomonBottomBar(
          items: _items,
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => _screens[index]),
            );
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(top: 18, left: 24, right: 24),
          child: Column(
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
                    //SizedBox(height: 10),
                    // Center(
                    //   child: Text(
                    //     'Baw Baw',
                    //     style: TextStyle(
                    //       fontSize: 25,
                    //       fontWeight: FontWeight.bold,
                    //     ),
                    //   ),
                    // ),
                    SizedBox(height: 10),
                    Text(
                      "SERVICES",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _cardMenu(
                          key: ValueKey('ADOPT'),
                          onTap: () {},
                          title: 'ADOPT',
                          icon: 'assets/images/adopt.png',
                          color: Colors.indigoAccent,
                          fontColor: Colors.black,
                        ),
                        _cardMenu(
                          key: ValueKey('FEED'),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Feeding(),
                              ),
                            );
                          },
                          title: 'FEED',
                          icon: 'assets/images/meal.png',
                          fontColor: Colors.black,
                          color: Colors.indigoAccent,
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _cardMenu(
                          key: ValueKey('MEDICATIONS'),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>  Medications(),
                              ),
                            );
                          },
                          title: 'MEDICATIONS',
                          icon: 'assets/images/med.png',
                          fontColor: Colors.black,
                          color: Colors.indigoAccent,
                        ),
                        _cardMenu(
                          key: ValueKey('TRACK'),
                          title: 'TRACK',
                          icon: 'assets/images/track.png',
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
          width: 150,
          padding: EdgeInsets.symmetric(vertical: 50),
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
