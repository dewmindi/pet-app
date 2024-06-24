import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class FeedingScheduleProvider with ChangeNotifier {
  List<Map<String, dynamic>> _schedules = [];

  List<Map<String, dynamic>> get schedules => _schedules;

  FeedingScheduleProvider() {
    _loadSchedules();
  }

  Future<void> _loadSchedules() async {
    final prefs = await SharedPreferences.getInstance();
    final schedulesString = prefs.getString('schedules');
    if (schedulesString != null) {
      _schedules = List<Map<String, dynamic>>.from(json.decode(schedulesString));
      notifyListeners();
    }
  }

  Future<void> _saveSchedules() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('schedules', json.encode(_schedules));
  }

  void addSchedule(Map<String, dynamic> schedule) {
    _schedules.add(schedule);
    _saveSchedules();
    notifyListeners();
  }

  void deleteSchedule(int index) {
    _schedules.removeAt(index);
    _saveSchedules();
    notifyListeners();
  }
}
