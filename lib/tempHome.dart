import 'package:firstapp/adopt.dart';
import 'package:firstapp/feeding.dart';
import 'package:firstapp/tempMed.dart';
import 'package:firstapp/trackpet/tracking.dart';
import 'package:flutter/material.dart';


class tempHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => tempHomeState();
}

class tempHomeState extends State<tempHome> {
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "HI, USER",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            GestureDetector(
              child: Container(
                margin: const EdgeInsets.only(right: 10),
                child: const Icon(
                  Icons.notifications_rounded,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),

      body: Container(
        decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(30), topLeft: Radius.circular(30))
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 50, left: 20, right: 20),
              width: size.width,
              height: 150,

              child: Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: Container(
                      margin: const EdgeInsets.only(left: 10, right: 10),
                      child: const Column(
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
                          SizedBox(height: 10),
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
            const SizedBox(height: 5),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                child: ListView(
                  children: [
                    _categoryItem(
                        // "assets/images/adopt.png",
                        // "ADOPT",
                      key: const ValueKey("ADOPT"),
                      title: 'ADOPT',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PetAdopt(),
                            ),
                          );
                        },
                      icon: "assets/images/adopt.png"

                    ),
                    _categoryItem(
                        key: const ValueKey("FEED"),
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
                        key: const ValueKey("MEDICATIONS"),
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
                        key: const ValueKey("TRACK"),
                        title: 'TRACK',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Pettrack(),
                            ),
                          );
                        },
                        icon: "assets/images/track.png"
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


  Widget _categoryItem({
    required ValueKey<String> key,
    required String title,
    required String icon,
    VoidCallback? onTap,
    Color color = Colors.indigoAccent,
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
          height: 90,
          // width: size.width,
          margin: const EdgeInsets.only(top: 10),
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
                margin: const EdgeInsets.only(left: 20),
                height: 90,
                width: 50,
                child: Image.asset(icon),
              ),
              Container(
                margin: const EdgeInsets.only(left: 20, top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: Text(
                        title,
                        style: const TextStyle(
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