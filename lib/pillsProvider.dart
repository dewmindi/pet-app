import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class pillsProvider with ChangeNotifier {
  List<Map<String, dynamic>> _schedulesPills = [];

  List<Map<String, dynamic>> get schedules => _schedulesPills;

  pillsProvider() {
    _loadSchedules();
  }

  Future<void> _loadSchedules() async {
    final prefs = await SharedPreferences.getInstance();
    final schedulesString = prefs.getString('schedules');
    if (schedulesString != null) {
      _schedulesPills = List<Map<String, dynamic>>.from(json.decode(schedulesString));
      notifyListeners();
    }
  }

  Future<void> _saveSchedules() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('schedules', json.encode(_schedulesPills));
  }

  void addSchedule(Map<String, dynamic> schedule) {
    _schedulesPills.add(schedule);
    _saveSchedules();
    notifyListeners();
  }

  void deleteSchedule(int index) {
    _schedulesPills.removeAt(index);
    _saveSchedules();
    notifyListeners();
  }
}
