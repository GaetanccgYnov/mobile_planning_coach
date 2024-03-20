import 'package:flutter/material.dart';
import 'package:planning_coaching/models/course.dart';

class EditCourseScreen extends StatefulWidget {
  final Course course;

  EditCourseScreen({required this.course});

  @override
  _EditCourseScreenState createState() => _EditCourseScreenState();
}

class _EditCourseScreenState extends State<EditCourseScreen> {
  late TextEditingController _nameController;
  late TextEditingController _dayController;
  late TextEditingController _startTimeController;
  late TextEditingController _endTimeController;
  late TextEditingController _descriptionController;
  bool isParticularCourse = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.course.name);
    _dayController = TextEditingController(text: widget.course.day);
    _startTimeController = TextEditingController(text: widget.course.startTime);
    _endTimeController = TextEditingController(text: widget.course.endTime);
    _descriptionController = TextEditingController(text: widget.course.description);
    isParticularCourse = widget.course is ParticularCourse;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modifier le cours'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Nom du cours'),
            ),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            TextFormField(
              controller: _dayController,
              decoration: InputDecoration(labelText: 'Jour du cours'),
            ),
            TextFormField(
              controller: _startTimeController,
              decoration: InputDecoration(labelText: 'Heure de début'),
            ),
            TextFormField(
              controller: _endTimeController,
              decoration: InputDecoration(labelText: 'Heure de fin'),
            ),
            ListTile(
              title: const Text('Course'),
              leading: Radio<bool>(
                value: false,
                groupValue: isParticularCourse,
                onChanged: (bool? value) {
                  setState(() {
                    isParticularCourse = value!;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('ParticularCourse'),
              leading: Radio<bool>(
                value: true,
                groupValue: isParticularCourse,
                onChanged: (bool? value) {
                  setState(() {
                    isParticularCourse = value!;
                  });
                },
              ),
            ),
            ElevatedButton(
              child: Text('Sauvegarder'),
              onPressed: () {
                // TODO: Implement update functionality here
                // NEED API TO USE THE UPDATE TO UPDTAE THE COURSE IN THE DATABASE
              },
            ),
          ],
        ),
      ),
    );
  }
}