import 'package:firstapp/screens/appointments.dart';
import 'package:firstapp/screens/signin_screen.dart';
import 'package:firstapp/screens/welcome_screen.dart';
import 'package:firstapp/services/authentication.dart';
import 'package:flutter/material.dart';
import 'package:firstapp/screens/appointmentDetails.dart';

import '../edituserprofile.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
              accountName: Text('Prasad', style: TextStyle(fontWeight: FontWeight.w500),),
              accountEmail: Text('prasad@gmail.com',style: TextStyle(fontWeight: FontWeight.w400),),
              currentAccountPicture: CircleAvatar(
                child: ClipOval(
                  //child: Image.asset('assets/pet_placeholder.jpg'),
                ),
              ),
            decoration: const BoxDecoration(
              color: Colors.indigoAccent,
              // image: DecorationImage(
              //   image: AssetImage('assets/splash_images/bgimg.jpg'),
              //   fit: BoxFit.cover,
              // ),
            ),
          ),
          ListTile(
            onTap: (){
              final storedDetails = AppointmentDetails();
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context)=>Edituserprofile())
              );
            },
            leading: Icon(Icons.settings),
            title: Text('Settings'),
          ),
          ListTile(
            onTap: (){
              final storedDetails = AppointmentDetails();
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context)=>Appointments(
                    doctorName: storedDetails.doctorName,
                    date: storedDetails.date,
                    time: storedDetails.time,
                  ))
              );
            },
            leading: Icon(Icons.calendar_month_outlined),
            title: Text('Appointments'),
          ),
          const ListTile(
            leading: Icon(Icons.settings_remote_sharp),
            title: Text('Connected Pets'),
          ),
          ListTile(
              onTap: () async{
                await AuthMethod().signOut();
              //final storedDetails = AppointmentDetails();
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context)=>SignInScreen()
                  )
              );
            },
            leading: Icon(Icons.logout),
            title: Text('Logout'),
          ),
        ],
      ),
    );
  }
}
