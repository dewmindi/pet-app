import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class Home extends StatelessWidget {
  const Home({super.key});

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
                    const Icon(Icons.notifications_outlined),
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
          SizedBox(height: 20),
          const SizedBox(height: 30),
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
            children: [
              Container(
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
                  'Dogs',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16
                  ),
                ),
              ),
              SizedBox(width: 5),
              Container(
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
                  'Dogs',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16
                  ),
                ),
              )

            ],
          ),
          SizedBox(height: 20),
          const SizedBox(height: 30),
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
        ],
      ),

    );
  }
}
