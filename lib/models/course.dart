import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class Course {
  final int id;
  final String name;
  final String? description;
  final String day;
  final String startTime;
  final String endTime;
  final int? availablePlaces;
  final String status;
  final bool isParticular;

  Course({
    required this.id,
    required this.name,
    this.description,
    required this.day,
    required this.startTime,
    required this.endTime,
    this.availablePlaces,
    required this.status,
    this.isParticular = false,

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

  Map<String, dynamic> toJson() {
    DateFormat outputFormat = DateFormat.Hms(); // Format 24 heures
    String formattedStartTime = outputFormat.format(DateFormat.Hm().parse(startTime));
    String formattedEndTime = outputFormat.format(DateFormat.Hm().parse(endTime));

    return {
      'id': id,
      'nom': name,
      'description': description,
      'jour': day,
      'heureDebut': formattedStartTime,
      'heureFin': formattedEndTime,
      'placesDisponibles': availablePlaces,
      'status': status,
    };
  }

}

class ParticularCourse extends Course {

  ParticularCourse({
    required int id,
    required String name,
    required String description,
    required String day,
    required String startTime,
    required String endTime,
    required String status,
  }) : super(
    id: id,
    name: name,
    description: description,
    day: day,
    startTime: startTime,
    endTime: endTime,
    status: status,
    isParticular: true,
  );
}