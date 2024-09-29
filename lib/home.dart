import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/addpetdetails.dart';
import 'package:firstapp/feeding.dart';
import 'package:firstapp/pet_list.dart';
import 'package:firstapp/tempMed.dart';
import 'package:firstapp/trackpet/pettotrack.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:firstapp/screens/navbar.dart';

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
    tempHome(),
    PetList(),
    Feeding(),
    tempMed(),
    CatTrackApp(),
  ];

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
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: Container(
        child: IndexedStack(
          index: _currentIndex,
          children: _screens,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context)=>(PetDetails()))
          );
        },
        child: Icon(Icons.add, color: Colors.red,),
        backgroundColor: Colors.white,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}


class tempHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => tempHomeState();
}

class tempHomeState extends State<tempHome> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? _userName;

  @override
  void initState() {
    super.initState();
    _fetchUserName();
  }

  Future<void> _fetchUserName() async {
    final User? user = _auth.currentUser;
    if (user != null) {
      final DocumentSnapshot userData = await _firestore.collection('users').doc(user.uid).get();
      setState(() {
        _userName = userData['name'];
      });
    }
  }
  final Map<String, bool> _isHovered = {};
  final Map<String, bool> _isClicked = {};
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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context)=>(CatTrackApp()))
                );
              },
              child: Container(
                margin: EdgeInsets.only(right: 10),
                child: Icon(
                  Icons.person_pin,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
      drawer: Navbar(),

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
                            _userName != null ? 'Hello, $_userName!' : 'Hello!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Roboto'
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'WHAT ARE YOU LOOKING FOR?',
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
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                child: ListView(
                  children: [
                    _categoryItem(
                      // "assets/images/adopt.png",
                      // "ADOPT",
                        key: ValueKey("ADOPT"),
                        title: 'ADOPT',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PetList(),
                            ),
                          );
                        },
                        icon: "assets/images/adopt.png"

                    ),
                    _categoryItem(
                        key: ValueKey("FEED"),
                        title: 'FEED',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Feeding(),
                            ),
                          );
                        },
                        icon: "assets/images/meal.png"
                    ),
                    _categoryItem(
                        key: ValueKey("MEDICATIONS"),
                        title: 'MEDICATIONS',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => tempMed(),
                            ),
                          );
                        },
                        icon: "assets/images/med.png"
                    ),
                    _categoryItem(
                        key: ValueKey("TRACK"),
                        title: 'TRACK',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CatTrackApp(),
                            ),
                          );
                        },
                        icon: "assets/images/track.png"
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _categoryItem({
    required ValueKey<String> key,
    required String title,
    required String icon,
    VoidCallback? onTap,
    Color color = Colors.indigoAccent,
  }) {
    var size = MediaQuery.of(context).size;
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
          height: 90,
          // width: size.width,
          margin: EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
            //color: Colors.indigoAccent,
            borderRadius: BorderRadius.circular(5),
            color: _isClicked[key.value] == true
                ? Colors.blueGrey
                : (_isHovered[key.value] == true ? Colors.blueGrey : color),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(left: 20),
                height: 90,
                width: 50,
                child: Image.asset(icon),
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
                        title,
                        style: TextStyle(
                          color: Color(0xff363636),
                          fontSize: 17,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
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