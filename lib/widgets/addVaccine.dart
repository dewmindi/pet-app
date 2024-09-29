import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VaccineDetailPage extends StatefulWidget {
  final String petId; // Pass the pet ID to identify which pet to update

  VaccineDetailPage({required this.petId});

  @override
  _VaccineDetailPageState createState() => _VaccineDetailPageState();
}

class _VaccineDetailPageState extends State<VaccineDetailPage> {
  final TextEditingController _vaccineNameController = TextEditingController();
  String _selectedInterval = '1 year';
  DateTime _selectedDate = DateTime.now();

  Future<void> _saveVaccineDetails() async {
    final String vaccineName = _vaccineNameController.text;
    final String interval = _selectedInterval;
    final String date = '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}';

    if (vaccineName.isEmpty) {
      // Handle empty vaccine name error
      return;
    }

    try {
      // Update Firestore
      await FirebaseFirestore.instance.collection('pets').doc(widget.petId).update({
        'vaccines': FieldValue.arrayUnion([
          {
            'name': vaccineName,
            'interval': interval,
            'nextDueDate': date,
          }
        ]),
      });

      // Pop the page after saving
      Navigator.pop(context);
    } catch (e) {
      // Handle error
      print('Error updating vaccine details: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Text(
          'Add Vaccine Details',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveVaccineDetails,
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          TextFormField(
            controller: _vaccineNameController,
            decoration: InputDecoration(
              labelText: 'Vaccine Name',
            ),
          ),
          DatePickerWidget(selectedDate: _selectedDate, onDateChanged: (newDate) {
            setState(() {
              _selectedDate = newDate;
            });
          }),
          SizedBox(height: 20),
          Text('Repeat Interval'),
          ListTile(
            title: const Text('6 months'),
            leading: Radio<String>(
              value: '6 months',
              groupValue: _selectedInterval,
              onChanged: (value) {
                setState(() {
                  _selectedInterval = value!;
                });
              },
            ),
          ),
          ListTile(
            title: const Text('1 year'),
            leading: Radio<String>(
              value: '1 year',
              groupValue: _selectedInterval,
              onChanged: (value) {
                setState(() {
                  _selectedInterval = value!;
                });
              },
            ),
          ),
          ListTile(
            title: const Text('2 years'),
            leading: Radio<String>(
              value: '2 years',
              groupValue: _selectedInterval,
              onChanged: (value) {
                setState(() {
                  _selectedInterval = value!;
                });
              },
            ),
          ),
          ListTile(
            title: const Text('Custom'),
            leading: Radio<String>(
              value: 'Custom',
              groupValue: _selectedInterval,
              onChanged: (value) {
                setState(() {
                  _selectedInterval = value!;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

class DatePickerWidget extends StatelessWidget {
  final DateTime selectedDate;
  final Function(DateTime) onDateChanged;

  DatePickerWidget({required this.selectedDate, required this.onDateChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Date', style: TextStyle(fontSize: 16)),
        SizedBox(height: 8),
        InkWell(
          onTap: () async {
            final DateTime? picked = await showDatePicker(
              context: context,
              initialDate: selectedDate,
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
            );
            if (picked != null && picked != selectedDate) {
              onDateChanged(picked);
            }
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
          ),
        ),
      ],
    );
  }
}
