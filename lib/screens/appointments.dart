import 'package:firstapp/screens/appointmentDetails.dart';
import 'package:flutter/material.dart';

class Appointments extends StatelessWidget {
  final  String doctorName;
  final String date;
  final String time;

  const Appointments({
    required this.doctorName,
    required this.date,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    final storedDetails = AppointmentDetails();

    final displayDoctorName = doctorName.isNotEmpty ? doctorName : storedDetails.doctorName;
    final displayDate = date.isNotEmpty ? date : storedDetails.date;
    final displayTime = time.isNotEmpty ? time : storedDetails.time;
    return Scaffold(
      appBar: AppBar(
        title: Text('Appointments'),
        backgroundColor: Colors.indigoAccent,
      ),
      body: Container(
        margin: EdgeInsets.only(top: 10, bottom: 5, left: 10, right: 10),
        width: MediaQuery.of(context ).size.width,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.grey,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Doctor: $displayDoctorName'),
              Text('Date: $displayDate'),
              Text('Time: $displayTime'),
            ],
          ),
        ),
      ),
    );
  }
}
