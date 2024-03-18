import 'package:intl/intl.dart';

class Course {
  final int id;
  final String name;
  final String? description;
  final String day;
  final String startTime;
  final String endTime;
  final int availablePlaces;
  final String status;

  Course({
    required this.id,
    required this.name,
    this.description,
    required this.day,
    required this.startTime,
    required this.endTime,
    required this.availablePlaces,
    required this.status,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    DateFormat inputFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss+00:00");
    DateFormat outputFormat = DateFormat("HH:mm");
    DateTime startDateTime = inputFormat.parse(json['heureDebut']);
    DateTime endDateTime = inputFormat.parse(json['heureFin']);
    String startTime = outputFormat.format(startDateTime);
    String endTime = outputFormat.format(endDateTime);

    return Course(
      id: json['id'],
      name: json['nom'],
      description: json['description'],
      day: json['jour'],
      startTime: startTime,
      endTime: endTime,
      availablePlaces: json['placesDisponibles'],
      status: json['status'],
    );
  }
}