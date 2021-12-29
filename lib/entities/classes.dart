class Class {
  String name = '';
  String room = '';

  Class(this.name, this.room);

  Class.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    room = json['room'];
  }
}
