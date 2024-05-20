import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet_app/pages/path.dart';

import '../models/cats.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> categories = ['Cats', 'Dogs', 'Birds'];
  String category = 'Cats';
  int selectedPage = 0;
  List<IconData> icons = [
    Icons.home_outlined,
    Icons.favorite_outline_rounded,
    Icons.chat_outlined,
    Icons.person_outline_rounded
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 30),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text('Hi', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black.withOpacity(0.6)),),

                          SizedBox(width: 10),
                          const Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: Colors.blue,
                            size: 18,
                          ),
                        ],
                      ),
                      Text.rich(
                        TextSpan(
                            children: [
                              TextSpan(
                                  text: 'User',
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold
                                  )
                              ),
                            ]
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.search),
                const SizedBox(width: 10),
                Stack(
                  children: [
                     Icon(Icons.notifications_outlined),
                    Positioned(
                      right: 5,
                      top: 5,
                      child: Container(
                        height: 7,
                        width: 7,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.red),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Container(
                height: 150,
                width: MediaQuery.of(context).size.width,
                color: Colors.blue.withOpacity(0.6),
                child: Stack(
                    children: [
                      Positioned(
                          bottom: -10,
                          right: 10,
                          width: 100,
                          height: 150,
                          child: Transform.rotate(
                            angle: 12 ,
                            child: Image.asset('paw/paws.png', height:300,
                              color: Colors.blue,
                            ),
                          )
                      )
                    ]),
              ),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Text(
                  'Categories',
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                const Spacer(),
                Row(
                  children: [
                    Text(
                      'View All',
                      style: TextStyle(fontSize: 12, color: Colors.orange),
                    ),
                    const SizedBox(width: 10),
                    Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.orange),
                        child: const Icon(
                          Icons.keyboard_arrow_right_rounded,
                          size: 14,
                          color: Colors.white,
                        ))
                  ],
                )
              ],
            ),
          ),
          Row(
            children:
              List.generate(categories.length,
                      (index) => Padding(
                        padding: index == 0
                        ? const EdgeInsets.only(left: 20, right: 15)
                        : const EdgeInsets.only(left: 20, right: 15),
                        child: Container(
                                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color: Colors.blue,
                                            boxShadow: const[BoxShadow(
                        offset: Offset(0, 3),
                        color: Colors.blue,
                        spreadRadius: 0,
                        blurRadius: 10,
                                            ),
                                            ]
                                        ),
                                        child: Text(
                                          categories[index],
                                          style: TextStyle(
                        color: Colors.white,
                        fontSize: 16
                                          ),
                                        ),
                                      ),
                      ),

          )),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Text(
                  'Adopt Me',
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                const Spacer(),
                Row(
                  children: [
                    Text(
                      'View All',
                      style: TextStyle(fontSize: 12, color: Colors.orange),
                    ),
                    const SizedBox(width: 10),
                    Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.orange),
                        child: const Icon(
                          Icons.keyboard_arrow_right_rounded,
                          size: 14,
                          color: Colors.white,
                        ))
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 10),

          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                cats.length,
                    (index) => Padding(
                  padding: index == 0
                      ? const EdgeInsets.only(left: 20, right: 20)
                      : const EdgeInsets.only(right: 20),
                  child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    pathScreen()));
                      },
                      child: CatItem(cat: cats[index])),
                ),
              ),
            ),
          )
      ]
      ),
      bottomNavigationBar: Container(
        height: 40,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
              icons.length,
                  (index) => GestureDetector(
                onTap: () {
                  setState(() {
                    selectedPage = index;
                  });
                },
                child: Container(
                  height: 40,
                  width: 50,
                  padding: const EdgeInsets.all(5),
                  child: Stack(
                    children: [
                      SizedBox(
                        height: 60,
                        width: 50,
                        child: Column(
                          children: [
                            Icon(
                              icons[index],
                              color: selectedPage == index
                                  ? Colors.blue
                                  : Colors.black.withOpacity(0.6),
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            selectedPage == index
                                ? Container(
                              height: 5,
                              width: 5,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.blue),
                            )
                                : Container()
                          ],
                        ),
                      ),
                      index == 2
                          ? Positioned(
                        right: 0,
                        top: -5,
                        child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: Colors.blue),
                            child: Text(
                              '6',
                              style: TextStyle(color: Colors.white),
                            )),
                      )
                          : Container()
                    ],
                  ),
                ),
              )),
        ),
      ),

    );

  }
}

class CatItem extends StatelessWidget {
  final Cat cat;
  const CatItem({
    Key? key,
    required this.cat,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Container(
        color: Colors.green.withOpacity(0.6),
        height: MediaQuery.of(context).size.height*0.3,
        width: MediaQuery.of(context).size.width*0.5,
        child: Stack(
          children: [
            Positioned(
              bottom: -8,
            right: 5,
              child: Image.asset(
                  'cats/cat1.png',
                height: MediaQuery.of(context).size.height*0.25,
              ),
            )
          ],
        ),
    ),
    );
  }
}

