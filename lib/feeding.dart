import 'package:firstapp/addSchedule.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class Feeding extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final User? user = _auth.currentUser;
    return Scaffold(
      backgroundColor: Colors.indigoAccent,
      appBar: AppBar(
        backgroundColor: Colors.indigoAccent,
        title: Text('Feeding Schedules'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _showAddScheduleDialog(context),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30), topLeft: Radius.circular(30))
        ),
        child: StreamBuilder(
          stream: _firestore
              .collection('feeding_schedules')
              .where('userId', isEqualTo: user!.uid) // Filter by logged-in user ID
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
            if(!snapshot.hasData){
              return Center(child: CircularProgressIndicator());
            }
            final schedules = snapshot.data!.docs;
            if(schedules.isEmpty){
              return Center(child: Text('No schedules available'));
            }
            return ListView.builder(
                itemCount: schedules.length,
                itemBuilder: (context, index){
                  final schedule = schedules[index];
                  bool isReminderOn = schedule['reminderTime'] != null;
                  
                  return Dismissible(
                      key: Key(schedule.id),
                      direction: DismissDirection.endToStart, // Slide to delete
                      confirmDismiss: (direction) async {
                        final bool? shouldDelete = await _confirmDelete(context);
                        return shouldDelete ?? false; // If user cancels, return false
                      },
                      onDismissed: (direction) {
                        // Show confirmation dialog before deleting
                        _firestore.collection('feeding_schedules').doc(schedule.id).delete();
                      },
                      background: Container(
                        color: Colors.lightBlueAccent,
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Icon(Icons.delete, color: Colors.white),
                      ),
                      child: ListTile(
                        title: Text('${schedule['petName']} - ${schedule['feedingTime']}'),
                        subtitle: isReminderOn
                            ? Text('Reminder: ${schedule['reminderTime']}')
                            : null,
                        trailing: Switch(
                          value: isReminderOn,
                          onChanged: (value){
                            _toggleReminder(schedule, value);
                          },
                        ),
                      )
                  );
                }
            );
          },
        )
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddScheduleDialog(context),
        child: Icon(Icons.add),
        backgroundColor: Colors.indigoAccent,
      ),
    );
  }

  void _toggleReminder(DocumentSnapshot schedule, bool value) {
    if (value) {
      // Turn on the reminder and restore the original reminder time
      _firestore.collection('feeding_schedules').doc(schedule.id).update({
        'reminderTime': schedule['originalReminderTime'], // Restore the original time
      });
    } else {
      // Turn off the reminder by setting the time to null and storing the original time
      _firestore.collection('feeding_schedules').doc(schedule.id).update({
        'originalReminderTime': schedule['reminderTime'], // Save the original time
        'reminderTime': null,
      });
    }
  }

  Future<bool?> _confirmDelete(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Reminder'),
        content: Text('Are you sure you want to delete this reminder?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _showAddScheduleDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AddScheduleDialog(
        onSave: (schedule) async{
          final User ? user = _auth.currentUser;
          final DocumentSnapshot userData = await _firestore.collection('users').doc(user!.uid).get();
          final String username = userData['name'];
          await _firestore.collection('feeding_schedules').add({
            'petName': schedule['petName'],
            'feedingTime': schedule['feedingTime'],
            'reminderTime': schedule['reminderTime'],
            'originalReminderTime': schedule['reminderTime'],
            'userName': username,
            'userId': user.uid,
          });
        },
      ),
    );
  }
}