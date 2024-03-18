// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:planning_coaching/models/course.dart';

// class ApiService {
//   static const String url = 'http://localhost:45111/api/cours';
//   static Future<List<Course>> getCourses() async {
//     try {
//       print("test2");
//       final response = await http.get(Uri.parse(url),
//           headers: <String, String>{
//             'Content-Type': 'application/json; charset=UTF-8',
//           });
//       print("test");
//       print(response.body);
//       print(response.statusCode);
//       if (response.statusCode == 200) {
//         List<Course> list = parseCourses(response.body);
//         return list;
//       } else {
//         throw Exception("Error with status code: ${response.statusCode}");
//       }
//     } catch (e) {
//       print(e);
//       throw Exception(e.toString());
//     }
//   }

import 'dart:convert';
import 'package:planning_coaching/models/course.dart';

class ApiService {

  static Future<List<Course>> getCourses() async {
    try {
      String jsonString = '[{"id":1,"nom":"Pied-poing Classe 1","description":null,"jour":"Lundi","heureDebut":"1970-01-01T19:00:00+00:00","heureFin":"1970-01-01T20:30:00+00:00","placesDisponibles":26,"status":"on"},{"id":2,"nom":"MMA V\u00e9t\u00e9ran","description":null,"jour":"Lundi","heureDebut":"1970-01-01T19:15:00+00:00","heureFin":"1970-01-01T20:15:00+00:00","placesDisponibles":33,"status":"on"},{"id":3,"nom":"Pied-poing Classe 2 et 3","description":null,"jour":"Lundi","heureDebut":"1970-01-01T20:30:00+00:00","heureFin":"1970-01-01T22:00:00+00:00","placesDisponibles":17,"status":"on"},{"id":4,"nom":"GRAPPLING MIXTE","description":null,"jour":"Mardi","heureDebut":"1970-01-01T18:30:00+00:00","heureFin":"1970-01-01T20:00:00+00:00","placesDisponibles":19,"status":"on"},{"id":5,"nom":"Body MMA (1)","description":null,"jour":"Mardi","heureDebut":"1970-01-01T19:30:00+00:00","heureFin":"1970-01-01T20:30:00+00:00","placesDisponibles":39,"status":"on"},{"id":6,"nom":"Enfants 5 \u00e0 8 ans","description":null,"jour":"Mercredi","heureDebut":"1970-01-01T14:00:00+00:00","heureFin":"1970-01-01T15:00:00+00:00","placesDisponibles":32,"status":"on"},{"id":7,"nom":"Enfants 8 \u00e0 12 ans","description":null,"jour":"Mercredi","heureDebut":"1970-01-01T15:00:00+00:00","heureFin":"1970-01-01T16:00:00+00:00","placesDisponibles":37,"status":"on"},{"id":8,"nom":"Classe ADO","description":null,"jour":"Mercredi","heureDebut":"1970-01-01T16:00:00+00:00","heureFin":"1970-01-01T17:30:00+00:00","placesDisponibles":32,"status":"on"},{"id":9,"nom":"Circuit Training (2)","description":null,"jour":"Mercredi","heureDebut":"1970-01-01T17:30:00+00:00","heureFin":"1970-01-01T18:30:00+00:00","placesDisponibles":24,"status":"on"},{"id":10,"nom":"MMA V\u00e9t\u00e9ran(1)","description":null,"jour":"Mercredi","heureDebut":"1970-01-01T19:15:00+00:00","heureFin":"1970-01-01T20:15:00+00:00","placesDisponibles":22,"status":"on"},{"id":11,"nom":"Pied-poing Classe 1","description":null,"jour":"Jeudi","heureDebut":"1970-01-01T19:00:00+00:00","heureFin":"1970-01-01T20:30:00+00:00","placesDisponibles":31,"status":"on"},{"id":12,"nom":"Pied-poing Classe 2 et 3","description":null,"jour":"Jeudi","heureDebut":"1970-01-01T20:30:00+00:00","heureFin":"1970-01-01T22:00:00+00:00","placesDisponibles":16,"status":"on"},{"id":13,"nom":"Sparring Assaut *","description":null,"jour":"Vendredi","heureDebut":"1970-01-01T18:30:00+00:00","heureFin":"1970-01-01T19:30:00+00:00","placesDisponibles":18,"status":"on"},{"id":14,"nom":"Body MMA (1)","description":null,"jour":"Vendredi","heureDebut":"1970-01-01T19:30:00+00:00","heureFin":"1970-01-01T20:30:00+00:00","placesDisponibles":26,"status":"on"},{"id":15,"nom":"Circuit Training (2)","description":null,"jour":"Vendredi","heureDebut":"1970-01-01T20:15:00+00:00","heureFin":"1970-01-01T21:15:00+00:00","placesDisponibles":31,"status":"on"},{"id":16,"nom":"Enfants 5 \u00e0 8 ans","description":null,"jour":"Samedi","heureDebut":"1970-01-01T09:00:00+00:00","heureFin":"1970-01-01T10:00:00+00:00","placesDisponibles":40,"status":"on"},{"id":17,"nom":"Enfants 8 \u00e0 12 ans","description":null,"jour":"Samedi","heureDebut":"1970-01-01T10:00:00+00:00","heureFin":"1970-01-01T11:00:00+00:00","placesDisponibles":26,"status":"on"},{"id":18,"nom":"Classe MMA Mixte ADO","description":null,"jour":"Samedi","heureDebut":"1970-01-01T11:00:00+00:00","heureFin":"1970-01-01T12:30:00+00:00","placesDisponibles":15,"status":"on"},{"id":19,"nom":"Classe MMA Mixte ADULTE","description":null,"jour":"Samedi","heureDebut":"1970-01-01T09:30:00+00:00","heureFin":"1970-01-01T11:00:00+00:00","placesDisponibles":38,"status":"on"},{"id":32,"nom":"Nouveau Cours","description":"Description du cours","jour":"Lundi","heureDebut":"1970-01-01T10:00:00+00:00","heureFin":"1970-01-01T12:00:00+00:00","placesDisponibles":20,"status":"on"},{"id":33,"nom":"Nouveau Cours","description":"Description du cours","jour":"Lundi","heureDebut":"1970-01-01T10:00:00+00:00","heureFin":"1970-01-01T12:00:00+00:00","placesDisponibles":20,"status":"on"}]';
      List<dynamic> list = jsonDecode(jsonString) as List<dynamic>;
      List<Course> courses = list.map((item) => Course.fromJson(item)).toList();
      return courses;
    } catch (e) {
      print(e);
      throw Exception(e.toString());
    }
  }
}
