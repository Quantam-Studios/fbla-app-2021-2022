import 'package:flutter_application_1/classes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

// TEST
// import 'classes.dart';

class SharedPref {
  read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString(key) != null) {
      return json.decode(prefs.getString(key) ?? 'Missing');
    } else {
      print('read($key) Failed');
      return 'Failed';
    }
  }

  save(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(value));
  }

  remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  test(String key) async {
    final prefs = await SharedPreferences.getInstance();
    print(json.decode(prefs.getString(key) ?? 'Missing').toString());
  }
}

// // TEST
// List<Class> classListTEST = List.filled(7, Class());

// class testSharedPref {
//   read(String key, int index) async {
//     final prefs = await SharedPreferences.getInstance();
//     if (prefs.getString(key) != null) {
//       return json.decode(prefs.getString(key) ?? 'Missing');
//     } else {
//       print('read($key) Failed');
//       return 'Failed';
//     }
//   }

//   save(String key, value, int index) async {
//     final prefs = await SharedPreferences.getInstance();
//     prefs.setString(key, json.encode(value));
//   }

//   remove(String key, int index) async {
//     final prefs = await SharedPreferences.getInstance();
//     prefs.remove(key);
//   }

//   test(int index) async {
//     print('TEST test() ran');
//     final prefs = await SharedPreferences.getInstance();
//     final String? classListKey = prefs.getString('classList');
//     if (classListKey != null) {
//       final List<Class> classList = Class.decode(classListKey);
//       print('TEST INFO of index: $index ' +
//           'Room: ' +
//           classList[index].room +
//           'Name: ' +
//           classList[index].name);
//     } else {
//       print('TEST test() failed because classListKey was null');
//     }
//   }

//   setString(String s, String encodedData) async {
//     final prefs = await SharedPreferences.getInstance();
//     prefs.setString(s, encodedData);
//   }

//   getString(String s) async {
//     final prefs = await SharedPreferences.getInstance();
//     prefs.getString(s);
//   }
// }

// // MAJOR TESTING
// void main() {
//   final String encodedData = ClassTEST.encode([
//     ClassTEST(name: 'none', room: 'none'),
//     ClassTEST(name: 'none', room: 'none'),
//     ClassTEST(name: 'none', room: 'none'),
//   ]);

//   final List<ClassTEST> decodedData = ClassTEST.decode(encodedData);

//   print(decodedData);
// }

// class ClassTEST {
//   final String name, room;

//   ClassTEST({
//     this.name = '',
//     this.room = '',
//   });

//   factory ClassTEST.fromJson(Map<String, dynamic> jsonData) {
//     return ClassTEST(
//       name: jsonData['name'],
//       room: jsonData['room'],
//     );
//   }

//   static Map<String, dynamic> toMap(ClassTEST classTest) => {
//         'name': classTest.name,
//         'room': classTest.room,
//       };

//   static String encode(List<ClassTEST> classListTEST) => json.encode(
//         classListTEST
//             .map<Map<String, dynamic>>(
//                 (classTest) => ClassTEST.toMap(classTest))
//             .toList(),
//       );

//   static List<ClassTEST> decode(String classTests) =>
//       (json.decode(classTests) as List<dynamic>)
//           .map<ClassTEST>((item) => ClassTEST.fromJson(item))
//           .toList();
// }
