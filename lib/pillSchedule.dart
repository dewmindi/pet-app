import 'package:firstapp/addPillSchedules.dart';
import 'package:firstapp/pillsProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

  class pillSchedule extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final scheduleProvider = Provider.of<pillsProvider>(context);
    return Scaffold(
      backgroundColor: Colors.indigoAccent,
      appBar: AppBar(
        backgroundColor: Colors.indigoAccent,
        title: Text('Feeding Schedules'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _showPillScheduleDialog(context),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(30), topLeft: Radius.circular(30))
        ),
        child: scheduleProvider.schedules.isEmpty
            ? const Center(child: Text('No schedules available.'))
            : ListView.builder(
          itemCount: scheduleProvider.schedules.length,
          itemBuilder: (context, index) {
            final schedule = scheduleProvider.schedules[index];
            return ListTile(
              title: Text('${schedule['petName']} - ${schedule['pillTime']}'),
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
        onPressed: () => _showPillScheduleDialog(context),
        child: Icon(Icons.add),
        backgroundColor: Colors.indigoAccent,
      ),
    );
  }

  void _showPillScheduleDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => addPillDialog(
        onSave: (schedule) {
          Provider.of<pillsProvider>(context, listen: false).addSchedule(schedule);
        },
      ),
    );
  }
}
