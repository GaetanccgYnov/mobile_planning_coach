import 'package:flutter/material.dart';
import 'package:planning_coaching/models/course.dart';
import 'package:planning_coaching/services/day_selector_service.dart';
import 'package:planning_coaching/services/time_format_service.dart';

class EditCourseScreen extends StatefulWidget {
  final Course course;

  EditCourseScreen({required this.course});

  @override
  _EditCourseScreenState createState() => _EditCourseScreenState();
}

class _EditCourseScreenState extends State<EditCourseScreen> {
  late TextEditingController _nameController;
  late TextEditingController _startTimeController;
  late TextEditingController _endTimeController;
  late TextEditingController _descriptionController;
  bool isParticularCourse = false;
  String _selectedDay = 'Lundi';
  final DaySelectorService _daySelectorService = DaySelectorService();
  final TimeFormatService _timeFormatService = TimeFormatService();
  TimeOfDay _startTime = TimeOfDay.now();
  TimeOfDay _endTime = TimeOfDay.fromDateTime(DateTime.now().add(Duration(hours: 1)));

  Future<void> _selectTime(BuildContext context, bool isStartTime) async {
    final TimeOfDay? picked = await _timeFormatService.selectTime(context, isStartTime ? _startTime : _endTime);
    if (picked != null) {
      setState(() {
        if (isStartTime) {
          _startTime = picked;
        } else {
          _endTime = picked;
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.course.name);
    _startTimeController = TextEditingController(text: widget.course.startTime);
    _endTimeController = TextEditingController(text: widget.course.endTime);
    _descriptionController = TextEditingController(text: widget.course.description);
    isParticularCourse = widget.course is ParticularCourse;
    _selectedDay = widget.course.day;
    _startTime = _timeFormatService.timeOfDayFromString(widget.course.startTime);
    _endTime = _timeFormatService.timeOfDayFromString(widget.course.endTime);
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
            DropdownButtonFormField<String>(
              decoration: InputDecoration(labelText: 'Jour'),
              value: _selectedDay,
              items: _daySelectorService.daysOfWeek.keys.map((String day) {
                return DropdownMenuItem<String>(
                  value: day,
                  child: Text(day),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedDay = newValue!;
                });
              },
            ),
            TextFormField(
              readOnly: true,
              decoration: InputDecoration(labelText: 'Heure de début'),
              onTap: () => _selectTime(context, true),
              controller: TextEditingController(text: _timeFormatService.formatTimeOfDay24(_startTime)),
            ),
            TextFormField(
              readOnly: true,
              decoration: InputDecoration(labelText: 'Heure de fin'),
              onTap: () => _selectTime(context, false),
              controller: TextEditingController(text: _timeFormatService.formatTimeOfDay24(_endTime)),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: ListTile(
                    title: const Text('Cours collectif'),
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
                ),
                Expanded(
                  child: ListTile(
                    title: const Text('Cours particulier'),
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
                ),
              ],
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