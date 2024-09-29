import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'postAdforAdopt.dart';

class PetList extends StatelessWidget {
  const PetList({Key? key}) : super(key: key);

  // Fetch username from 'Users' collection based on document ID (userId)
  Future<String> _getUsername(String userId) async {
    try {
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
      if (userDoc.exists && userDoc.data() != null) {
        return userDoc.data()!['name'] ?? 'Unknown User';
      } else {
        return 'Unknown User';
      }
    } catch (e) {
      return 'Unknown User'; // In case of any errors
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 300.0,
              floating: false,
              pinned: false,
              stretch: true,
              flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  collapseMode: CollapseMode.parallax,
                  title: const Text("",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16.0,
                      )),
                  background: Image.asset(
                    "assets/images/adopt.jpg",
                    fit: BoxFit.cover,
                  )),
            ),
          ];
        },
        body: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 400),
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('AdoptPets')
                  .orderBy('datePosted', descending: true)
                  .snapshots(), // Fetch ads from 'AdoptPets'
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text("No ads available"));
                }
                final ads = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: ads.length,
                  itemBuilder: (BuildContext context, int index) {
                    var ad = ads[index];
                    return FutureBuilder(
                      future: _getUsername(ad['postedBy']), // Fetch username
                      builder: (context, AsyncSnapshot<String> usernameSnap) {
                        if (usernameSnap.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        return Container(
                          height: 170,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 4.0),
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: const Color(0xFFE0E0E0)),
                              borderRadius: BorderRadius.circular(8.0)),
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            children: [
                              Expanded(
                                  child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Display Ad Title in bold
                                  Text(
                                    ad['adTitle'] ?? 'No Title',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 8),

                                  // Display Location Address
                                  Text(
                                    ad['location'] ?? 'No Address Provided',
                                    style: const TextStyle(fontSize: 14.0),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 8),

                                  // Display Username (fetched) and Telephone
                                  Text(
                                    "${usernameSnap.data ?? 'Unknown'} · ${ad['phone'] ?? 'No Phone'}",
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  const SizedBox(height: 8),

                                  // Display Date and Time in small text
                                  Text(
                                    ad['datePosted'] ?? 'No Date Provided',
                                    style: const TextStyle(
                                        fontSize: 12.0, color: Colors.grey),
                                  ),
                                ],
                              )),
                              // Display Image
                              Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(8.0),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(ad['imageUrl'] ??
                                        'https://via.placeholder.com/100'),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context)=>(PostAdPage()))
          );
        },
        child: Icon(Icons.add, color: Colors.red,),
        backgroundColor: Colors.white,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
