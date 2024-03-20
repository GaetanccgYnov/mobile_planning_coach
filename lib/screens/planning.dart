import 'package:flutter/material.dart';
import 'package:planning_coaching/models/course.dart';
import 'package:planning_coaching/services/api_service.dart';
import 'package:planning_coaching/screens/create_course_screen.dart';
import 'package:planning_coaching/screens/edit_course_screen.dart';

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
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 6,
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('Vous avez sélectionné le cours ${course.name}.'),
                if (course.description != null && course.description!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text('Description: ${course.description}'),
                  ),
                Text('Jour: ${course.day}'),
                Text('Horaires: ${course.startTime} à ${course.endTime}'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    TextButton(
                      child: Text('Fermer'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      child: Text('Modifier'),
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => EditCourseScreen(course: course)),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
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
              child: Text('Créer un cours'),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => CreateCourseScreen()),
                );
              }),
          TextButton(
            child: Text('Ouvrir Tout'),
            onPressed: () {
              setState(() {
                _isOpen = List<bool>.filled(_isOpen.length, true);
              });
            },
          ),
          TextButton(
            child: Text('Fermer Tout'),
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
                      return Container(
                        color: course.isParticular ? Colors.orange[200] : null,
                        child: ListTile(
                          title: Text(course.name),
                          subtitle: Text('${course.startTime} à ${course.endTime}'),
                          onTap: () => _showDialog(course),
                        ),
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