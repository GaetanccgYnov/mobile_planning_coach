import 'package:flutter/material.dart';
import 'package:planning_coaching/models/course.dart';
import 'package:planning_coaching/services/api_service.dart';
import 'package:planning_coaching/services/day_selector_service.dart';
import 'package:planning_coaching/services/time_format_service.dart';

class CreateCourseScreen extends StatefulWidget {
  @override
  _CreateCourseScreenState createState() => _CreateCourseScreenState();
}

class _CreateCourseScreenState extends State<CreateCourseScreen> {
  final DaySelectorService _daySelectorService = DaySelectorService();
  final TimeFormatService _timeFormatService = TimeFormatService();
  TimeOfDay _startTime = TimeOfDay.now();
  TimeOfDay _endTime = TimeOfDay.fromDateTime(DateTime.now().add(Duration(hours: 1)));
  String _selectedDay = 'Lundi';
  bool isParticularCourse = false;

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

  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _description = '';
  int i = 34;

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Course newCourse;
      if (isParticularCourse) {
        newCourse = ParticularCourse(
          id : i++,
          name: _name,
          description: _description,
          day: _selectedDay,
          startTime: _timeFormatService.formatTimeOfDay24(_startTime),
          endTime: _timeFormatService.formatTimeOfDay24(_endTime),
          status: 'on',
        );
      } else {
        newCourse = Course(
          id : i++,
          name: _name,
          description: _description,
          day: _selectedDay,
          startTime: _timeFormatService.formatTimeOfDay24(_startTime),
          endTime: _timeFormatService.formatTimeOfDay24(_endTime),
          status: 'on',
        );
      }
      ApiService.addCourse(newCourse);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Créer un cours'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'Nom'),
              onSaved: (value) => _name = value!,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Description'),
              onSaved: (value) => _description = value!,
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
              onSaved: (value) => _selectedDay = value!,
            ),
            TextFormField(
              readOnly: true,
              decoration: InputDecoration(labelText: 'Début'),
              onTap: () => _selectTime(context, true),
              controller: TextEditingController(text: _timeFormatService.formatTimeOfDay24(_startTime)),
              onSaved: (value) => _startTime,
            ),
            TextFormField(
              readOnly: true,
              decoration: InputDecoration(labelText: 'Fin'),
              onTap: () => _selectTime(context, false),
              controller: TextEditingController(text: _timeFormatService.formatTimeOfDay24(_endTime)),
              onSaved: (value) => _endTime,
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
            Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: ElevatedButton(
                child: Text('Sauvegarder'),
                onPressed: _submit,
              ),
            ),
          ],
        ),
      ),
    );
  }
}