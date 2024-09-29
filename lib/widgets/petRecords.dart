import 'package:firstapp/temp.dart';
import 'package:firstapp/tempMed.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firstapp/widgets/addVaccine.dart';

class PetProfilePage extends StatefulWidget {
  final Map<String, dynamic> petData;
  final String petId; // Pass the pet ID here

  const PetProfilePage({required this.petId, required this.petData});

  @override
  _PetProfilePageState createState() => _PetProfilePageState();
}

class _PetProfilePageState extends State<PetProfilePage> {
  String _activeTab = 'Vaccines';

  String calculateAge(String birthDateStr) {
    try {
      DateTime birthDate = DateTime.parse(birthDateStr);
      DateTime today = DateTime.now();

      int years = today.year - birthDate.year;
      int months = today.month - birthDate.month;
      int days = today.day - birthDate.day;

      if (months < 0 || (months == 0 && days < 0)) {
        years--;
        months = (months + 12) % 12;
      }

      if (days < 0) {
        final lastMonth = DateTime(today.year, today.month - 1, 0);
        days = lastMonth.day - birthDate.day + today.day;
        months--;
      }

      return '$years years, $months months';
    } catch (e) {
      return 'Unknown';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.indigoAccent.shade400,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection('pets').doc(widget.petId).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(child: Text('No data available'));
          }

          final petData = snapshot.data!.data() as Map<String, dynamic>;

          final petName = petData['petName'] ?? 'Unknown';
          final petType = petData['petType'] ?? 'Unknown';
          final petBirthDate = petData['petBirthDate'] ?? 'Unknown';

          final petAge = petBirthDate != 'Unknown' ? calculateAge(petBirthDate) : 'Unknown';

          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.indigoAccent.shade400,
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
                ),
                width: 350,
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('assets/pet.jpg'),
                    ),
                    SizedBox(height: 10),
                    Text(
                      petName,
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '$petAge OLD | $petType',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildTabItem(context, 'Reports', _activeTab == 'Reports'),
                    _buildTabItem(context, 'Appointments', _activeTab == 'Appointments'),
                    _buildTabItem(context, 'Vaccines', _activeTab == 'Vaccines'),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: _buildContent(petData),
              ),
            ],
          );
        },
      ),
      floatingActionButton: _activeTab == 'Vaccines'
          ? FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => VaccineDetailPage(petId: widget.petId)),
          );
        },
        backgroundColor: Colors.indigoAccent.shade400,
        child: Icon(Icons.add),
      )
          : _activeTab == 'Appointments'
          ? FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Channel(),
            ),
          );
        },
        backgroundColor: Colors.indigoAccent.shade400,
        child: Icon(Icons.add),
      ) : null,
    );
  }

  Widget _buildTabItem(BuildContext context, String title, bool isActive) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _activeTab = title;
        });
      },
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              color: isActive ? Colors.indigoAccent.shade400 : Colors.grey.shade500,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          if (isActive)
            Container(
              height: 3,
              width: 60,
              margin: EdgeInsets.only(top: 4),
              color: Colors.indigoAccent.shade400,
            ),
        ],
      ),
    );
  }

  Widget _buildContent(Map<String, dynamic> petData) {
    if (_activeTab == 'Reports') {
      return _buildReportsContent();
    } else if (_activeTab == 'Appointments') {
      return _buildAppointmentsContent();
    } else {
      return _buildVaccinesContent(petData);
    }
  }

  Widget _buildReportsContent() {
    return Center(
      child: Text(
        'Reports Content',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget _buildAppointmentsContent() {
    return Center(
      child: Text(
        'Appointments Content',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget _buildVaccinesContent(Map<String, dynamic> petData) {
    final vaccines = petData['vaccines'] as List<dynamic>?;

    if (vaccines == null || vaccines.isEmpty) {
      return Center(child: Text('No vaccines found'));
    }

    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16),
      itemCount: vaccines.length,
      itemBuilder: (context, index) {
        final vaccine = vaccines[index] as Map<String, dynamic>;
        final vaccineName = vaccine['name'] ?? 'Unknown';
        final interval = vaccine['interval'] ?? 'Unknown';
        final nextDueDate = vaccine['nextDueDate'] ?? 'Unknown';

        return _buildVaccineCard(vaccineName, 'EVERY $interval · NEXT $nextDueDate');
      },
    );
  }

  Widget _buildVaccineCard(String vaccineName, String vaccineDetails) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 2,
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        leading: Icon(Icons.vaccines, color: Colors.indigoAccent.shade400, size: 36),
        title: Text(
          vaccineName,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.black87,
          ),
        ),
        subtitle: Text(
          vaccineDetails,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade600,
          ),
        ),
      ),
    );
  }
}
