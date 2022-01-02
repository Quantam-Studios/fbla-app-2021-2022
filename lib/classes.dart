// The Class() class is defined here.

class Class {
  String name = '';
  String room = '';
  // TEST parameters
  // {String room = '', String name = ''}}
  Class({String room = 'missing', String name = 'missing'});

  Class.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        room = json['room'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'room': room,
      };

  // static Map<String, dynamic> toMap(Class Class) => {
  //       'name': Class.name,
  //       'room': Class.name,
  //     };

  // static String encode(List<Class> classList) => json.encode(
  //       classList.map<Map<String, dynamic>>((c) => Class.toMap(c)).toList(),
  //     );

  // static List<Class> decode(String classList) =>
  //     (json.decode(classList) as List<dynamic>)
  //         .map<Class>((item) => Class.fromJson(item))
  //         .toList();
}

// // TEST
// class TestClass {
//   final String name;
//   final String room;
//   TestClass({required this.name, required this.room});
// }
