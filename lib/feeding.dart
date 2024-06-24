import 'package:firstapp/addSchedule.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firstapp/feedingProvider.dart';


class Feeding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final scheduleProvider = Provider.of<FeedingScheduleProvider>(context);
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
        child: scheduleProvider.schedules.isEmpty
            ? Center(child: Text('No schedules available.'))
            : ListView.builder(
          itemCount: scheduleProvider.schedules.length,
          itemBuilder: (context, index) {
            final schedule = scheduleProvider.schedules[index];
            return ListTile(
              title: Text('${schedule['petName']} - ${schedule['feedingTime']}'),
              subtitle: schedule['reminderTime'] != null
                  ? Text('Reminder: ${schedule['reminderTime']}')
                  : null,
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  scheduleProvider.deleteSchedule(index);
                },
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddScheduleDialog(context),
        child: Icon(Icons.add),
        backgroundColor: Colors.indigoAccent,
      ),
    );
  }

  void _showAddScheduleDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AddScheduleDialog(
        onSave: (schedule) {
          Provider.of<FeedingScheduleProvider>(context, listen: false).addSchedule(schedule);
        },
      ),
    );
  }
}