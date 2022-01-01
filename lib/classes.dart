class Class {
  String name = '';
  String room = '';
  Class();

  Class.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        room = json['room'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'room': room,
      };
}
