// The Class() class is defined here.

class Class {
  String name = 'Tap the three dots to edit...';
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
}
