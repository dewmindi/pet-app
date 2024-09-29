import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/widgets/petRecords.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(CatTrackApp());
}

class CatTrackApp extends StatefulWidget {
  @override
  State<CatTrackApp> createState() => _CatTrackAppState();
}

class _CatTrackAppState extends State<CatTrackApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? _userName;
  String? _ownerId;
  String? _imageUrl;

  @override
  void initState() {
    super.initState();
    _fetchUserNameAndOwnerId();
  }

  Future<void> _fetchUserNameAndOwnerId() async {
    final User? user = _auth.currentUser;
    if (user != null) {
      final DocumentSnapshot userData = await _firestore.collection('users').doc(user.uid).get();
      setState(() {
        _userName = userData['name'] ?? 'User';
        _ownerId = user.uid;
        _imageUrl = userData['imageUrl'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple.shade50,
      appBar: AppBar(
        backgroundColor: Colors.indigoAccent.shade400,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        elevation: 0,
        title: const Text(
          'PetTrack',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 5),
            width: 375,
            padding: EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
              color: Colors.indigoAccent.shade400,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20), bottom: Radius.circular(20)),
            ),
            child: Column(
              children: [
                 CircleAvatar(
                  backgroundImage: _imageUrl != null && _imageUrl!.isNotEmpty
                      ? NetworkImage(_imageUrl!) // Load the user's profile image from Firebase
                      : AssetImage('assets/pet_placeholder.jpg') as ImageProvider, // replace with your profile image path
                  radius: 50,
                ),
                SizedBox(height: 10),
                Text(
                  _userName != null ? 'Welcome, $_userName!' : 'Welcome!',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 5),
                const Text(
                  "Let's see what your furry friends have been up to...",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestore
                  .collection('pets')
                  .where('ownerId', isEqualTo: _ownerId)  // Filter by ownerId
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Error loading pets.'));
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text('No pets found.'));
                }

                final pets = snapshot.data!.docs;

                return ListView.builder(
                  padding: EdgeInsets.all(20),
                  itemCount: pets.length,
                  itemBuilder: (context, index) {
                    final petData = pets[index].data() as Map<String, dynamic>;
                    final petId = pets[index].id; // Get the pet ID
                    return Column(
                      children: [
                        PetCard(
                          petData: petData,
                          petId: petId, // Pass pet ID to PetCard
                        ),
                        SizedBox(height: 10),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class PetCard extends StatelessWidget {
  final Map<String, dynamic> petData;
  final String petId; // Pet ID to pass

  const PetCard({required this.petData, required this.petId});

  @override
  Widget build(BuildContext context) {
    final String petName = petData['petName'] ?? 'Unknown';
    final String petType = petData['petType'] ?? 'Unknown';
    final String petWeight = petData['petWeight'] ?? 'Unknown';
    final String petGender = petData['petGender'] ?? 'Unknown';
    final String petBirthDate = petData['petBirthDate'] ?? 'Unknown';
    final String imageUrl = petData['imageUrl'] ?? '';
    final String owner = petData['owner'] ?? 'Unknown';

    // Calculate age based on petBirthDate
    String age = 'Unknown';
    if (petBirthDate != 'Unknown') {
      try {
        DateTime birthDate = DateTime.parse(petBirthDate);
        Duration ageDuration = DateTime.now().difference(birthDate);
        int years = ageDuration.inDays ~/ 365;
        int months = (ageDuration.inDays % 365) ~/ 30;
        age = '${years} yr ${months} mon';
      } catch (e) {
        age = 'Unknown';
      }
    }

    // Check if device is connected
    bool isDeviceConnected = petData.containsKey('deviceId') && petData.containsKey('deviceName');
    final String distanceTravelled = petData['distanceTravelled'] ?? '0 km travelled';

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: imageUrl.isNotEmpty
                  ? NetworkImage(imageUrl) // Load image from Firebase
                  : AssetImage('assets/pet_placeholder.jpg') as ImageProvider,
              radius: 40,
            ),
            SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    petName,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text('$petType • $age'),
                  SizedBox(height: 5),
                  Text('$petWeight Kg • $petGender'),
                  SizedBox(height: 5),
                  Text(
                    distanceTravelled,
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      if (isDeviceConnected) ...[
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              // Navigate to Live Tracker screen
                            },
                            child: Text('Live Tracker'),
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.only(right: 5),
                              backgroundColor: Colors.indigoAccent.shade100,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 5),
                      ],
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PetProfilePage(petId: petId, petData: petData),
                              ),
                            );
                          },
                          child: Text('View Records'),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.only(right: 5),
                            backgroundColor: Colors.indigoAccent.shade100,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
