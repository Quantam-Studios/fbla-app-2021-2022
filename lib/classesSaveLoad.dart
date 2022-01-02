import 'classes.dart';

class Classes {
  List sem1Classes = List.filled(7, Class());
  List sem2Classes = List.filled(7, Class());
  Classes();

  Map<String, dynamic> toJson() => {
        'sem1Classes': sem1Classes,
        'sem2Classes': sem2Classes,
      };

  Classes.fromJson(Map<String, dynamic> json)
      : sem1Classes = json['sem1Classes'],
        sem2Classes = json['sem2Classes'];
}

class ClassKeys {
  List sem1Keys = [
    '1class1',
    '1class2',
    '1class3',
    '1class4',
    '1class5',
    '1class6',
    '1class7'
  ];
  List sem2Keys = [
    '2class1',
    '2class2',
    '2class3',
    '2class4',
    '2class5',
    '2class6',
    '2class7'
  ];
  ClassKeys();

  Map<String, dynamic> toJson() => {
        'sem1Keys': sem1Keys,
        'sem2Keys': sem2Keys,
      };

  ClassKeys.fromJson(Map<String, dynamic> json)
      : sem1Keys = json['sem1Keys'],
        sem2Keys = json['sem2Keys'];
}

class SemKeys {
  List keys = List.filled(7, String);
  SemKeys();

  Map<String, dynamic> toJson() => {
        'keys': keys,
      };

  SemKeys.fromJson(Map<String, dynamic> json) : keys = json['keys'];
}

class SemClassCounts {
  int sem1ClassCount = 1;
  int sem2ClassCount = 1;
  SemClassCounts();

  Map<String, dynamic> toJson() => {
        'sem1Keys': sem1ClassCount,
        'sem2Keys': sem2ClassCount,
      };

  SemClassCounts.fromJson(Map<String, dynamic> json)
      : sem1ClassCount = json['sem1ClassCount'],
        sem2ClassCount = json['sem2ClassCount'];
}
