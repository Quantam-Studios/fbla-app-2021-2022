// Packages and Dependencies

import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:path_provider/path_provider.dart';
// Custom made dependencies
import 'classes.dart';
import 'sharedRefs.dart';

// IMPORTANT: CONSTANT KEYS FOR SAVE DATA IN SHARED PREFERENCES
const keyClasses = [
  'class1',
  'class2',
  'class3',
  'class4',
  'class5',
  'class6',
  'class7'
];
List<String> classes = List<String>.filled(7, 'Name');

List<Class> classesList =
    List<Class>.filled(7, Class(name: 'blank', room: 'blank'));

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  // General set up of states
  @override
  State<StatefulWidget> createState() {
    return TestAppState();
  }
}

class TestAppState extends State<MyApp> {
  // Shared Preferences Configuration
  SharedPref sharedPref = SharedPref();

  // Functions for loading class info
  Class classSave = Class();
  Class classLoad = Class();
  List<Class> classesSaved =
      List<Class>.filled(7, Class(name: 'blank', room: 'blank'));
  List<Class> classesLoad =
      List<Class>.filled(7, Class(name: 'blank', room: 'blank'));

  // async function to avoid returning Future<Instance>
  // IMPORTANT: without await the method will return Future<Instance>
  loadSharedPrefs() async {
    for (int i = 0; i < keyClasses.length; i++) {
      try {
        Class _class = Class.fromJson(await sharedPref.read(keyClasses[i]));
        setState(() {
          classesLoad[i] = _class;
          sharedPref.test(keyClasses[i]);
        });
      } catch (Exception) {
        print('loadSharedPrefs() Failed');
        sharedPref.test(keyClasses[i]);
      }
    }
  }

  // Bottom Navigation
  int _selectedIndex = 0;
  // Edit Class Pop Up controllers
  // Class controller
  final classEditController = TextEditingController(text: '');
  // Room Controller
  final classRoomEditController = TextEditingController(text: '');

  // clean up closed pop up widget controllers.
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    classEditController.dispose();
    classRoomEditController.dispose();
    super.dispose();
  }

  @override
  build(BuildContext context) {
    // Force portrait
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    List<Widget> _pages = <Widget>[
      // HOME PAGE STUFF
      Scaffold(
        body: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Container(
              color: Color(0xff121212),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30.0),
                  bottomRight: Radius.circular(30.0),
                ),
                child: Container(
                  height: 400,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: FractionalOffset.bottomCenter,
                      colors: [Color(0xff54BFF8), Color(0xff4C8CF2)],
                      stops: [0, 1],
                    ),
                  ),
                  child: CarouselSlider(
                    items: [
                      //1st container of Slider
                      // ACTIVITY (Class, lunch, club...)
                      Container(
                        margin: EdgeInsets.all(6.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Container(
                          width: 400,
                          height: 600,
                          child: Column(
                            children: [
                              Container(
                                width: 400,
                                child: Text(
                                  "Activity",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 50,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.all(10),
                                child: Text(
                                  "AP Biology",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              //INFO (Room number, times)
                              Container(
                                  margin: const EdgeInsets.all(10),
                                  alignment: Alignment.center,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.meeting_room_outlined,
                                        color: Colors.white,
                                      ),
                                      Text(" D201 ",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.white,
                                          )),
                                      Icon(
                                        Icons.access_time,
                                        color: Colors.white,
                                      ),
                                      Text(" 7:30-8:20",
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.white,
                                          ))
                                    ],
                                  )),
                              // More Details Button
                              Container(
                                height: 60,
                                alignment: Alignment.bottomCenter,
                                child: OutlinedButton.icon(
                                  label: Text(
                                    'Classes',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  icon:
                                      Icon(Icons.format_list_bulleted_rounded),
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Color(0xFF303030)),
                                      overlayColor:
                                          MaterialStateProperty.all<Color>(
                                              Color(0xFF000000)),
                                      foregroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Color(0xFFffffff))),
                                  onPressed: () {
                                    setState(() {
                                      _onItemTapped(2);
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      //2nd container of Slider
                      //Lunch of the day
                      Container(
                        margin: EdgeInsets.all(6.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Container(
                          width: 400,
                          height: 600,
                          child: Column(
                            children: [
                              Container(
                                width: 400,
                                child: Text(
                                  "Lunch",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 50,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.all(10),
                                child: Text(
                                  "Pizza, and other things...",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              //INFO (Room number, times)
                              Container(
                                  margin: const EdgeInsets.all(5),
                                  alignment: Alignment.center,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.access_time,
                                        color: Colors.white,
                                      ),
                                      Text(" 11:30-12:00",
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.white,
                                          ))
                                    ],
                                  )),
                              // More Details Button
                              Container(
                                height: 60,
                                alignment: Alignment.bottomCenter,
                                child: OutlinedButton.icon(
                                  label: Text(
                                    'Next Lunch',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  icon: Icon(Icons.fastfood_rounded),
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Color(0xFF303030)),
                                      overlayColor:
                                          MaterialStateProperty.all<Color>(
                                              Color(0xFF000000)),
                                      foregroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Color(0xFFffffff))),
                                  onPressed: () {
                                    setState(() {
                                      print("Next Lunch");
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      //3rd container of Slider
                      // Clubs after school
                      Container(
                        margin: EdgeInsets.all(6.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Container(
                          width: 400,
                          height: 600,
                          child: Column(
                            children: [
                              Container(
                                width: 400,
                                child: Text(
                                  "After School",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 48,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.all(10),
                                child: Text(
                                  "Makers Club",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              // More Details Button
                              Container(
                                height: 60,
                                alignment: Alignment.bottomCenter,
                                child: OutlinedButton.icon(
                                  label: Text(
                                    'Details',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  icon: Icon(Icons.assignment_rounded),
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Color(0xFF303030)),
                                      overlayColor:
                                          MaterialStateProperty.all<Color>(
                                              Color(0xFF000000)),
                                      foregroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Color(0xFFffffff))),
                                  onPressed: () {
                                    setState(() {
                                      print("scroll to details");
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],

                    //Slider Container properties
                    options: CarouselOptions(
                      height: 300.0,
                      enlargeCenterPage: true,
                      autoPlay: true,
                      aspectRatio: 16 / 9,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enableInfiniteScroll: true,
                      autoPlayAnimationDuration: Duration(milliseconds: 700),
                      viewportFraction: 0.8,
                    ),
                  ),
                ),
              ),
            ),
            // classes for the day
            Container(
              color: Color(0xFF121212),
              width: 400,
              height: 600,
              child: Container(
                width: 600,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                        bottomLeft: Radius.circular(25),
                        bottomRight: Radius.circular(25)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 7,
                        offset: Offset(0, 0), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    color: Color(0xFF3b3b3b),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          title: Center(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.format_list_bulleted_rounded,
                                  color: Colors.white,
                                ),
                                Text(
                                  ' Your classes for the day.',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: ListView(
                              scrollDirection: Axis.vertical,
                              children: <Widget>[
                                Card(
                                  color: Color(0xff5b5b5b),
                                  child: ListTile(
                                    title: Text(
                                      'US History',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                Card(
                                  color: Color(0xff5b5b5b),
                                  child: ListTile(
                                    title: Text(
                                      'US History',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                Card(
                                  color: Color(0xff5b5b5b),
                                  child: ListTile(
                                    title: Text(
                                      'US History',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                Card(
                                  color: Color(0xff5b5b5b),
                                  child: ListTile(
                                    title: Text(
                                      'US History',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                Card(
                                  color: Color(0xff5b5b5b),
                                  child: ListTile(
                                    title: Text(
                                      'US History',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                Card(
                                  color: Color(0xff5b5b5b),
                                  child: ListTile(
                                    title: Text(
                                      'US History',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                Card(
                                  color: Color(0xff5b5b5b),
                                  child: ListTile(
                                    title: Text(
                                      'US History',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        ButtonBar(
                          alignment: MainAxisAlignment.start,
                          children: [
                            TextButton(
                              style: TextButton.styleFrom(
                                primary: Colors.black.withOpacity(0.8),
                                shape: const BeveledRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                // go to the classes page
                                _onItemTapped(2);
                              },
                              child: Row(
                                children: [
                                  const Text(
                                    'View All Classes',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_rounded,
                                    color: Colors.white,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  width: 100,
                  margin: EdgeInsets.all(20),
                ),
              ),
            ),
            Container(
              color: Color(0xFF121212),
              width: 400,
              height: 600,
              child: Container(
                width: 500,
                child: Container(
                  width: 100,
                  margin: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Color(0xFF3b3b3b),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30.0),
                      bottomLeft: Radius.circular(30.0),
                      topLeft: Radius.circular(30.0),
                      bottomRight: Radius.circular(30.0),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 8,
                        blurRadius: 10,
                        offset: Offset(0, 0),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      //PLANNER PAGE
      //TODO: (Create page)
      Icon(
        Icons.calendar_today_rounded,
        size: 150,
        color: Colors.deepPurple,
      ),
      //CLASSES PAGE
      Scaffold(
        backgroundColor: Color(0xFF121212),
        body: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: MediaQuery.of(context).size.width,
                minHeight: MediaQuery.of(context).size.height,
              ),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SizedBox(height: 20.0),
                    Text('Classes',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 22, color: Colors.white)),
                    DefaultTabController(
                      length: 2, // length of tabs
                      initialIndex: 0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Container(
                            child: TabBar(
                              labelColor: Colors.blue,
                              unselectedLabelColor: Colors.white,
                              tabs: [
                                Tab(text: 'Semester 1'),
                                Tab(text: 'Semester 2'),
                              ],
                            ),
                          ),
                          Container(
                            height: 520, //height of TabBarView
                            decoration: BoxDecoration(
                                border: Border(
                                    top: BorderSide(
                                        color: Colors.grey, width: 0.5))),
                            child: TabBarView(
                              children: <Widget>[
                                Container(
                                  child: Center(
                                    child: Container(
                                      color: Color(0xFF121212),
                                      width: 600,
                                      height: 520,
                                      child: Container(
                                        width: 500,
                                        child: Container(
                                          child: Card(
                                            clipBehavior: Clip.antiAlias,
                                            color: Color(0xFF3b3b3b),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                            ),
                                            child: Column(
                                              children: [
                                                Expanded(
                                                  child: Container(
                                                    padding: EdgeInsets.all(10),
                                                    child: ListView(
                                                      scrollDirection:
                                                          Axis.vertical,
                                                      children: <Widget>[
                                                        // Dynamically create a class card for each elemnt in the given array
                                                        for (var i = 0;
                                                            i < classes.length;
                                                            i++)
                                                          // Class card
                                                          Card(
                                                            color: Color(
                                                                0xff5b5b5b),
                                                            child: ListTile(
                                                              title: Text(
                                                                '${classesLoad[i].name} Room: ${classesLoad[i].room}',
                                                                key:
                                                                    UniqueKey(),
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                              trailing:
                                                                  // The edit class button
                                                                  IconButton(
                                                                icon: Icon(
                                                                  Icons
                                                                      .more_vert,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                                onPressed: () =>
                                                                    {
                                                                  _editClass(
                                                                      context,
                                                                      i),
                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          width: 100,
                                          margin: EdgeInsets.all(20),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Center(
                                    child: Container(
                                      color: Color(0xFF121212),
                                      width: 600,
                                      height: 520,
                                      child: Container(
                                        width: 500,
                                        child: Container(
                                          child: Card(
                                            clipBehavior: Clip.antiAlias,
                                            color: Color(0xFF3b3b3b),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                            ),
                                            child: Column(
                                              children: [
                                                Expanded(
                                                  child: Container(
                                                    padding: EdgeInsets.all(10),
                                                    child: ListView(
                                                      scrollDirection:
                                                          Axis.vertical,
                                                      children: <Widget>[
                                                        // Dynamically create a class card for each elemnt in the given array
                                                        for (var i = 0;
                                                            i < classes.length;
                                                            i++)
                                                          // Class card
                                                          Card(
                                                            color: Color(
                                                                0xff5b5b5b),
                                                            child: ListTile(
                                                              title: Text(
                                                                '${classesLoad[i].name} Room: ${classesLoad[i].room}',
                                                                key:
                                                                    UniqueKey(),
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                              trailing:
                                                                  // The edit class button
                                                                  IconButton(
                                                                icon: Icon(
                                                                  Icons
                                                                      .more_vert,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                                onPressed: () =>
                                                                    {
                                                                  _editClass(
                                                                      context,
                                                                      i),
                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          width: 100,
                                          margin: EdgeInsets.all(20),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ),
      //CLUBS PAGE
      //TODO: (Create page)
      Icon(
        Icons.local_activity_rounded,
        size: 150,
        color: Colors.deepPurple,
      ),
    ];
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          brightness: Brightness.dark,
        ),
      ),
      home: Scaffold(
        backgroundColor: Color(0xFF121212),
        // Top Navigation Bar
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xFF212121),
          title: Text('CCHS Hub'),
          shadowColor: Colors.black.withOpacity(0.5),
          actions: <Widget>[
            // Settings
            Builder(
              builder: (context) => IconButton(
                icon: Icon(
                  Icons.settings,
                  color: Colors.white,
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
            ),
          ],
        ),
        // Bottom Bar
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  spreadRadius: 0,
                  blurRadius: 10),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
            child: BottomNavigationBar(
              backgroundColor: Color(0xFF212121),
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
              selectedItemColor: Colors.blue,
              unselectedItemColor: Colors.white,
              type: BottomNavigationBarType.shifting,
              items: [
                BottomNavigationBarItem(
                  backgroundColor: Color(0xFF212121),
                  icon: new Icon(
                    Icons.house_rounded,
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  backgroundColor: Color(0xFF212121),
                  icon: new Icon(
                    Icons.calendar_today_rounded,
                  ),
                  label: 'Planner',
                ),
                BottomNavigationBarItem(
                  backgroundColor: Color(0xFF212121),
                  icon: Icon(
                    Icons.format_list_bulleted_rounded,
                  ),
                  label: 'Classes',
                ),
                BottomNavigationBarItem(
                  backgroundColor: Color(0xFF212121),
                  icon: Icon(
                    Icons.local_activity_rounded,
                  ),
                  label: 'Clubs',
                ),
              ],
            ),
          ),
        ),
        body: Center(
          child: _pages.elementAt(_selectedIndex), //New
        ),
        // Settings Menu
        drawer: new Drawer(
          child: Container(
            color: Color(0xFF121212),
            child: ListView(
              padding: EdgeInsets.all(0),
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Color(0xFF3b3b3b),
                  ),
                  child: Text('Settings',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      )),
                ),
                ListTile(
                  leading: Icon(
                    Icons.portrait_rounded,
                    color: Colors.white,
                  ),
                  title: Text(
                    'Name',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.color_lens,
                    color: Colors.white,
                  ),
                  title: Text(
                    'Theme',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // TODO: prevent updating all class cards for performance
  // Save classes when edited
  _classEdit(int index) {
    classesSaved[index].name = classEditController.text;
    classesSaved[index].room = classRoomEditController.text;
    sharedPref.save(keyClasses[index], classesSaved[index]);
    loadSharedPrefs();
  }

  // This is the pop up for editing classes.
  // function called draws a pop up
  _editClass(context, int index) {
    // Actual pop up object
    Alert(
        style: AlertStyle(
          backgroundColor: Color(0xff3b3b3b),
          titleStyle: TextStyle(color: Colors.white),
        ),
        context: context,
        title: "Edit Class",
        content: Column(
          children: <Widget>[
            // Class name input feild
            TextField(
              controller: classEditController,
              // limit the string size to a maximum of 20
              inputFormatters: [
                LengthLimitingTextInputFormatter(20),
              ],
              style: TextStyle(
                color: Colors.white,
              ),
              decoration: InputDecoration(
                icon: Icon(
                  Icons.format_list_bulleted_rounded,
                  color: Colors.white,
                ),
                labelText: 'Class',
                labelStyle: TextStyle(color: Colors.white),
              ),
            ),
            // room input feild
            TextField(
              controller: classRoomEditController,
              // limit the string size to a maximum of 4
              inputFormatters: [
                LengthLimitingTextInputFormatter(4),
              ],
              style: TextStyle(
                color: Colors.white,
              ),
              decoration: InputDecoration(
                icon: Icon(
                  Icons.meeting_room_outlined,
                  color: Colors.white,
                ),
                labelText: 'Room',
                labelStyle: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        // Confirm button
        buttons: [
          DialogButton(
            onPressed: () => {
              // get rid of pop up
              Navigator.pop(context),
              // save the data
              print('The index of the save data is $index'),
              _classEdit(index)
            },
            child: Text(
              "Confirm",
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
          )
        ]).show();
  }

  //Bottom Bar functionaity
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      // Grab previous session data for classes page only when the page is active
      if (_selectedIndex == 2) {
        loadSharedPrefs();
      }
    });
  }
}

class Storage {
  Future<String> get localPath async {
    final dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }

  Future<File> get localFile async {
    final path = await localPath;
    return File('$path/db.txt');
  }

  Future<String> readData() async {
    try {
      final file = await localFile;
      String body = await file.readAsString();

      return body;
    } catch (e) {
      return e.toString();
    }
  }

  Future<File> writeData(String data) async {
    final file = await localFile;
    return file.writeAsString("$data");
  }
}
