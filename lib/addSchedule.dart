import 'package:flutter/material.dart';

class AddScheduleDialog extends StatefulWidget {
  final Function(Map<String, dynamic>) onSave;

  AddScheduleDialog({required this.onSave});

  @override
  _AddScheduleDialogState createState() => _AddScheduleDialogState();
}

class _AddScheduleDialogState extends State<AddScheduleDialog> {
  final _formKey = GlobalKey<FormState>();
  String _petName = '';
  TimeOfDay _feedingTime = TimeOfDay.now();
  TimeOfDay? _reminderTime;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Feeding Schedule'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Pet Name'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the pet\'s name';
                }
                return null;
              },
              onSaved: (value) {
                _petName = value!;
              },
            ),
            ListTile(
              title: Text('Feeding Time: ${_feedingTime.format(context)}'),
              trailing: Icon(Icons.access_time),
              onTap: () async {
                final pickedTime = await showTimePicker(
                  context: context,
                  initialTime: _feedingTime,
                );
                if (pickedTime != null && pickedTime != _feedingTime) {
                  setState(() {
                    _feedingTime = pickedTime;
                  });
                }
              },
            ),
            ListTile(
              title: Text('Reminder Time: ${_reminderTime?.format(context) ?? 'Not set'}'),
              trailing: Icon(Icons.notifications),
              onTap: () async {
                final pickedTime = await showTimePicker(
                  context: context,
                  initialTime: _reminderTime ?? _feedingTime,
                );
                if (pickedTime != null) {
                  setState(() {
                    _reminderTime = pickedTime;
                  });
                }
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              widget.onSave({
                'petName': _petName,
                'feedingTime': _feedingTime.format(context),
                'reminderTime': _reminderTime?.format(context),
              });
              Navigator.of(context).pop();
            }
          },
          child: Text('Save'),
        ),
      ],
    );
  }
}
