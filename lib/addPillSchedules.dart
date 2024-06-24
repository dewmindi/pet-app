import 'package:flutter/material.dart';

class addPillDialog extends StatefulWidget {
  final Function(Map<String, dynamic>) onSave;

  addPillDialog({required this.onSave});

  @override
  State<addPillDialog> createState() => _addPillDialogState();
}

class _addPillDialogState extends State<addPillDialog> {
  final _formKey = GlobalKey<FormState>();
  String _petName = '';
  TimeOfDay _pillTime = TimeOfDay.now();
  TimeOfDay? _reminderTime;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Pills & Medication Schedule'),
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
              title: Text('Pill Time: ${_pillTime.format(context)}'),
              trailing: Icon(Icons.access_time),
              onTap: () async {
                final pickedTime = await showTimePicker(
                  context: context,
                  initialTime: _pillTime,
                );
                if (pickedTime != null && pickedTime != _pillTime) {
                  setState(() {
                    _pillTime = pickedTime;
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
                  initialTime: _reminderTime ?? _pillTime,
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
                'pillTime': _pillTime.format(context),
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
