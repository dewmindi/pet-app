import 'dart:ui';
import 'package:firstapp/screens/appointments.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:firstapp/screens/appointmentDetails.dart';

class DoctorDetailPage extends StatefulWidget {
  final String doctorName;
  final String doctorImage;
  final String doctorSpcl;

  DoctorDetailPage({
    required this.doctorName,
    required this.doctorImage,
    required this.doctorSpcl
  });

  @override
  State<StatefulWidget> createState() => _DoctorDetailState();
}

class _DoctorDetailState extends State<DoctorDetailPage> {
  String selectedDate = "21";
  String selectedTime = "08:30 AM";
  bool isLoading = false;

  void makeAppointment(){
    setState(() {
      isLoading = true;
    });

    Future.delayed(Duration(seconds: 2),(){
      setState(() {
        isLoading = false;
      });

      AppointmentDetails().doctorName = widget.doctorName;
      AppointmentDetails().date = selectedDate;
      AppointmentDetails().time = selectedTime;
      
      Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context)=>Appointments(
                doctorName: widget.doctorName,
                date: selectedDate,
                time: selectedTime,
              )
          )
      );

      showDialog(
          context: context,
          builder: (BuildContext context){
            return AlertDialog(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      'Appointment Confirmation',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w700,
                      ),
                  ),
                  Icon(Icons.check_circle_outline,color: Colors.green,)
                ],
              ),
              content: Container(
                width: MediaQuery.of(context).size.width,
                //height: MediaQuery.of(context).size.height * 0.3,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Doctor: ${widget.doctorName}'),
                    SizedBox(height: 10),
                    Text('Date: $selectedDate'),
                    SizedBox(height: 10),
                    Text('Time: $selectedTime'),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Close'),
                ),
              ],
            );
          }
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return initWidget(context);
  }

  Widget initWidget(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.indigoAccent,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        actions: [
          GestureDetector(
            child: Container(
              margin: EdgeInsets.only(right: 15),
              child: Icon(
                Icons.notifications_rounded,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                  color: Colors.indigoAccent,
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30))
              ),
              child: Container(
                margin: EdgeInsets.only(left: 30, bottom: 30),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 20),
                      child: Image.asset(
                        widget.doctorImage,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 30),
                            child: Text(widget.doctorName,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Text(
                            widget.doctorSpcl,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 15),
                            child: Text('Rating: 4.5',
                              style: TextStyle(
                                color: Colors.yellow,
                                fontSize: 15,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, top: 30),
              child: Text('June 2024',
                style: TextStyle(
                  color: Color(0xff363636),
                  fontSize: 25,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, top: 20, right: 20),
              height: 90,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  demoDates("Mon", "21"),
                  demoDates("Tue", "22"),
                  demoDates("Wed", "23"),
                  demoDates("Thur", "24"),
                  demoDates("Fri", "25"),
                  demoDates("Sat", "26"),
                  demoDates("Sun", "27"),
                  demoDates("Mon", "28"),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, top: 30),
              child: Text('Morning',
                style: TextStyle(
                  color: Color(0xff363636),
                  fontSize: 25,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 20),
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: 3,
                physics: NeverScrollableScrollPhysics(),
                childAspectRatio: 2.7,
                children: [
                  doctorTimingsData("08:30 AM"),
                  doctorTimingsData("09:00 AM"),
                  doctorTimingsData("09:30 AM"),
                  doctorTimingsData("10:00 AM"),
                  doctorTimingsData("10:30 AM"),
                  doctorTimingsData("11:00 AM"),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 25, top: 30),
              child: Text('Evening',
                style: TextStyle(
                  color: Color(0xff363636),
                  fontSize: 25,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 20),
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: 3,
                physics: NeverScrollableScrollPhysics(),
                childAspectRatio: 2.6,
                children: [
                  doctorTimingsData("05:00 PM"),
                  doctorTimingsData("05:30 PM"),
                  doctorTimingsData("06:00 PM"),
                  doctorTimingsData("06:30 PM"),
                  doctorTimingsData("07:00 PM"),
                  doctorTimingsData("07:30 PM"),
                ],
              ),
            ),
            GestureDetector(
              onTap: isLoading ? null : makeAppointment,
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                height: 54,
                margin: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.indigoAccent,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x17000000),
                      offset: Offset(0, 15),
                      blurRadius: 15,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: isLoading
                    ? CircularProgressIndicator( // Show circular progress indicator
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                )
                    :Text(
                  'Make An Appointment',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget demoDates(String day,String date){
    bool isSelected = selectedDate == date;
    return GestureDetector(
      onTap: (){
        setState(() {
          selectedDate = date;
        });
      },
      child: Container(
        width: 70,
        margin: EdgeInsets.only(right: 15),
        decoration: BoxDecoration(
          color: isSelected ? Colors.indigoAccent : Color(0xffEEEEEE),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Text(
                day,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                  fontSize: 20,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.all(7),
              child: Text(
                date,
                style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                    fontSize: 15,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.bold),
               ),
            ),
          ],
        ),
      ),
    );
  }

  Widget doctorTimingsData(String time){
    bool isSelected = selectedTime == time;
    return GestureDetector(
      onTap: (){
        setState(() {
          selectedTime = time;
        });
      },
      child: Container(
        margin: EdgeInsets.only(left: 20, top: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.indigoAccent : Color(0xffEEEEEE),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(right: 2),
              child: const Icon(
                Icons.access_time,
                color: Colors.black,
                size: 18,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 2),
              child: Text(
                time,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                  fontSize: 17,
                  fontFamily: 'Roboto',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
