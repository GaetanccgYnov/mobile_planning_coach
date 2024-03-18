import 'package:flutter/material.dart';
import 'package:planning_coaching/models/course.dart';
import 'package:planning_coaching/services/api_service.dart';

class PlanningScreen extends StatefulWidget {
  @override
  _PlanningScreenState createState() => _PlanningScreenState();
}

Map<String, List<Course>> groupCoursesByDay(List<Course> courses) {
  Map<String, List<Course>> map = {};
  for (var course in courses) {
    if (!map.containsKey(course.day)) {
      map[course.day] = [];
    }
    map[course.day]!.add(course);
  }
  return map;
}

class _PlanningScreenState extends State<PlanningScreen> {
  Future<List<Course>>? _coursesFuture;
  List<bool> _isOpen = [];

  @override
  void initState() {
    super.initState();
    _coursesFuture = ApiService.getCourses();
    _coursesFuture!.then((courses) {
      setState(() {
        _isOpen = List<bool>.filled(courses.length, false);
      });
    });
  }

  void _showDialog(Course course) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Inscription'),
          content: Text('Vous avez sélectionné le cours ${course.name} le ${course.day} de ${course.startTime} à ${course.endTime}.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Planning'),
        actions: <Widget>[
          TextButton(
            child: Text('Open All'),
            onPressed: () {
              setState(() {
                _isOpen = List<bool>.filled(_isOpen.length, true);
              });
            },
          ),
          TextButton(
            child: Text('Collapse All'),
            onPressed: () {
              setState(() {
                _isOpen = List<bool>.filled(_isOpen.length, false);
              });
            },
          ),
        ],
      ),
      body: FutureBuilder<Map<String, List<Course>>>(
        future: _coursesFuture?.then(groupCoursesByDay),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.keys.length,
              itemBuilder: (context, index) {
                final day = snapshot.data!.keys.elementAt(index);
                final courses = snapshot.data![day]!;
                return Container(
                  color: index % 2 == 0 ? Colors.grey[200] : Colors.white,
                  child: ExpansionTile(
                    initiallyExpanded: _isOpen[index],
                    onExpansionChanged: (isOpen) {
                      setState(() {
                        _isOpen[index] = isOpen;
                      });
                    },
                    title: Text(day),
                    children: courses.map((course) {
                      return ListTile(
                        title: Text(course.name),
                        subtitle: Text('${course.startTime} à ${course.endTime}'),
                        onTap: () => _showDialog(course),
                      );
                    }).toList(),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}