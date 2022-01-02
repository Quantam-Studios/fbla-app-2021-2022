// THIS FILE CONTAINS SNIPPETS OF CODE THAT MIGHT BE USEFUL LAYER ON IN DEVELOPMENT

// TEST FILE SAVING WITH PATH PACKAGE
  // String state;
  // Future<Directory> _appDocDir;

  // @override
  // void initState() {
  //   super.initState();
  //   widget.storage.readData().then((String value) {
  //     setState(() {
  //       state = value;
  //     });
  //   });
  // }

  // Future<File> writeData() async {
  //   setState(() {
  //     state = classEditController.text;
  //     classEditController.text = '';
  //   });

  //   return widget.storage.writeData(state);
  // }

  // void getAppDirectory() {
  //   setState(() {
  //     _appDocDir = getApplicationDocumentsDirectory();
  //   });
  // }

// // TEST
// class TestClass {
//   final String name;
//   final String room;
//   TestClass({required this.name, required this.room});
// }

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

// Storage class
// class Storage {
//   Future<String> get localPath async {
//     final dir = await getApplicationDocumentsDirectory();
//     return dir.path;
//   }

//   Future<File> get localFile async {
//     final path = await localPath;
//     return File('$path/db.txt');
//   }

//   Future<String> readData() async {
//     try {
//       final file = await localFile;
//       String body = await file.readAsString();

//       return body;
//     } catch (e) {
//       return e.toString();
//     }
//   }

//   Future<File> writeData(String data) async {
//     final file = await localFile;
//     return file.writeAsString("$data");
//   }
// }


/*
class _MyAppState extends State<MyApp> {
  List<String> products = ['Asuka', 'hi'];

  @override
  build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          backgroundColor: (Color(0xFF212121)),
          appBar: AppBar(
            backgroundColor: Color(0xFF212121),
            title: Text('FBLA'),
          ),
          body: Column(
            children: [
              Container(
                margin: EdgeInsets.all(10.0),
                child: OutlinedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Color(0xFF303030)),
                      overlayColor:
                          MaterialStateProperty.all<Color>(Color(0xFF000000)),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Color(0xFFffffff))),
                  onPressed: () {
                    setState(() {
                      products.add('ur mom');
                    });
                  },
                  child: Text('Add Class'),
                ),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      spreadRadius: 0.5,
                      blurRadius: 5,
                      offset: Offset(0, 0),
                    )
                  ],
                ),
              ),
              Column(
                children: products
                    .map((element) => Card(
                          color: Color(0x121212),
                          child: Column(
                            children: <Widget>[
                              Text(
                                element,
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                        ))
                    .toList(),
              ),
            ],
          )),
    );
  }

  static Route<Object?> _dialogBuilder(
      BuildContext context, Object? arguments) {
    return DialogRoute<void>(
      context: context,
      builder: (BuildContext context) =>
          const AlertDialog(title: Text('Material Alert!')),
    );
  }
} 
STUFF FOR ORANGE CARDS
Container(
            color: Color(0xFFffffff),
            width: 400,
            height: 600,
            child: Container(
                width: 500,
                child: Container(
                    width: 100,
                    margin: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Color(0xFFff6600),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30.0),
                        bottomLeft: Radius.circular(30.0),
                        topLeft: Radius.circular(30.0),
                        bottomRight: Radius.circular(30.0),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.6),
                          spreadRadius: 4,
                          blurRadius: 6,
                          offset: Offset(0, 0),
                        )
                      ],
                    )))),
        Container(
            color: Color(0xFFffffff),
            width: 400,
            height: 600,
            child: Container(
                width: 100,
                margin: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Color(0xFFff6600),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                    topLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.6),
                      spreadRadius: 4,
                      blurRadius: 6,
                      offset: Offset(0, 0),
                    )
                  ],
                ))),


    STUFF FOR GRADIENT BACKGROUND
     Container(
            height: 600,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: FractionalOffset.bottomCenter,
                colors: [Colors.purple, Colors.deepPurple],
                stops: [0, 1],
              ),
            ),
),
      ])

*/ 
