class AppointmentDetails {
  static final AppointmentDetails _instance = AppointmentDetails._internal();

  String doctorName = '';
  String date = '';
  String time = '';

  factory AppointmentDetails() {
    return _instance;
  }

  AppointmentDetails._internal();
}
