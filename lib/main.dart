// Packages and Dependencies
import 'package:carousel_slider/carousel_slider.dart';
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import 'package:rflutter_alert/rflutter_alert.dart';
// Custom made dependencies
import 'classes.dart';
import 'sharedRefs.dart';
import 'classesSaveLoad.dart';
import 'socialPage.dart';
import 'timeHandling.dart';

// IMPORTANT: CONSTANT KEYS FOR SAVE DATA IN SHARED PREFERENCES
// Main array for class keys
ClassKeys keyClasses = ClassKeys();
// KEY for class counts
String keyClassCount = 'classCount';

// Max and min values of semesters
const maxClasses = 7;
const minClasses = 1;

// TODO: create a system to choose lunches that has impact on which time the classes are.
// Times of classes (Lunch A for MVP)
ClassTimes classTimes = ClassTimes();

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

  // Arrays for saved and load lists of classes
  Classes classesSaved = Classes();
  Classes classesLoaded = Classes();

  // Total Classes in each semester
  SemClassCounts semClassCountsLoad = SemClassCounts();
  SemClassCounts semClassCountsSave = SemClassCounts();

  // Time calculation, and active class
  CheckTimes checkTimes = CheckTimes();
  var activeClass = 0;

  // async function to avoid returning Future<Instance>
  // IMPORTANT: without await the method will return Future<Instance>
  // TODO: Make a better solution to updating values, and loading them
  // Function for dealing with smester and class information
  loadSharedPrefs(int semester) async {
    // Update class counts
    try {
      setState(() {
        semClassCountsLoad.sem1ClassCount = semClassCountsSave.sem1ClassCount;
        semClassCountsLoad.sem2ClassCount = semClassCountsSave.sem2ClassCount;
      });
    } catch (exception) {
      print('loadSharedPrefs() semClassCounts Failed');
      print(exception);
    }

    // Update class data for each element in each semester
    if (semester == 0) {
      // Runs for the amount of either total semester classes
      for (int i = 0; i < semClassCountsLoad.sem1ClassCount; i++) {
        try {
          Class _class =
              Class.fromJson(await sharedPref.read(keyClasses.sem1Keys[i]));
          setState(() {
            classesLoaded.sem1Classes[i] = _class;
          });
        } catch (exception) {
          print('loadSharedPrefs() Failed');
          print(keyClasses.sem1Keys[i]);
          print(exception);
        }
      }
    } else if (semester == 1) {
      // Runs for the amount of either total semester classes
      for (int i = 0; i < semClassCountsLoad.sem2ClassCount; i++) {
        try {
          Class _class =
              Class.fromJson(await sharedPref.read(keyClasses.sem2Keys[i]));
          setState(() {
            classesLoaded.sem2Classes[i] = _class;
          });
        } catch (exception) {
          print('loadSharedPrefs() Failed');
          print(keyClasses.sem2Keys[i]);
          print(classesLoaded.sem2Classes[i].name);
          print(exception);
        }
      }
    }
  }

  // Compare times, and update active class if needed
  updateActiveClass() {
    activeClass = 0;
    int x = 1;
    while (activeClass < x) {
      x += 1;
      int status = checkIfUpdateNeeded(checkTimes.checkTimes[activeClass]);
      if (activeClass < classesLoaded.sem1Classes.length - 1) {
        if (status == 1) {
          activeClass += 1;
        } else {
          print(activeClass.toString() + ' no update needed');
          break;
        }
      } else {
        print('no more classes');
        break;
      }
    }
  }

  // Initial states, and load data required for home page
  @override
  void initState() {
    loadSharedPrefs(0);
    updateActiveClass();
    super.initState();
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
                                  "Current Class",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 45,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.all(10),
                                child: Text(
                                  '${classesLoaded.sem1Classes[activeClass].name}',
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
                                      Text(
                                        ' ${classesLoaded.sem1Classes[activeClass].room} ',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Icon(
                                        Icons.access_time,
                                        color: Colors.white,
                                      ),
                                      Text(' ${classTimes.times[activeClass]}',
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
            // Tasks for the day
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
                                Center(
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
                                )),
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
                                for (var i = 0;
                                    i < semClassCountsLoad.sem1ClassCount;
                                    i++)
                                  // Class card
                                  Container(
                                    decoration: new BoxDecoration(
                                      boxShadow: [
                                        new BoxShadow(
                                          color: Colors.black.withOpacity(0.5),
                                          blurRadius: 5.0,
                                        ),
                                      ],
                                    ),
                                    // content of container
                                    child: Card(
                                      color: Color(0xff5b5b5b),
                                      child: ListTile(
                                        title: Text.rich(
                                          TextSpan(
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                            children: [
                                              TextSpan(
                                                text:
                                                    '${i.toString()}.  ${classesLoaded.sem1Classes[i].name}   ',
                                              ),
                                              WidgetSpan(
                                                child: Icon(
                                                  Icons.meeting_room_outlined,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              TextSpan(
                                                text:
                                                    ' ${classesLoaded.sem1Classes[i].room}',
                                              ),
                                            ],
                                          ),
                                        ),
                                        trailing: Text.rich(
                                          TextSpan(
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                            children: [
                                              WidgetSpan(
                                                child: Icon(
                                                  Icons.access_time,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              TextSpan(
                                                text: ' ${classTimes.times[i]}',
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          child: ButtonBar(
                              alignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    TextButton(
                                      style: TextButton.styleFrom(
                                        primary: Colors.black.withOpacity(0.5),
                                        backgroundColor:
                                            Colors.black.withOpacity(0.5),
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
                                )
                              ]),
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
                            height: 620, //height of TabBarView
                            decoration: BoxDecoration(
                                border: Border(
                                    top: BorderSide(
                                        color: Colors.grey, width: 0.5))),
                            child: TabBarView(
                              children: <Widget>[
                                // Class container
                                Container(
                                  child: Column(
                                    children: [
                                      Center(
                                        child: Container(
                                          color: Color(0xFF121212),
                                          width: 500,
                                          height: 520,
                                          child: Container(
                                            width: 500,
                                            child: Container(
                                              child: Card(
                                                clipBehavior: Clip.antiAlias,
                                                color: Color(0xFF3b3b3b),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.0),
                                                ),
                                                child: Column(
                                                  children: [
                                                    Expanded(
                                                      child: Container(
                                                        padding:
                                                            EdgeInsets.all(10),
                                                        child: ListView(
                                                          scrollDirection:
                                                              Axis.vertical,
                                                          children: <Widget>[
                                                            // Dynamically create a class card for each element in the given array
                                                            for (var i = 0;
                                                                i <
                                                                    semClassCountsLoad
                                                                        .sem1ClassCount;
                                                                i++)
                                                              // Class card
                                                              Container(
                                                                decoration:
                                                                    new BoxDecoration(
                                                                  boxShadow: [
                                                                    new BoxShadow(
                                                                      color: Colors
                                                                          .black
                                                                          .withOpacity(
                                                                              0.5),
                                                                      blurRadius:
                                                                          5.0,
                                                                    ),
                                                                  ],
                                                                ),
                                                                child: Card(
                                                                  color: Color(
                                                                      0xff5b5b5b),
                                                                  child:
                                                                      ListTile(
                                                                    title: Text
                                                                        .rich(
                                                                      TextSpan(
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                        children: [
                                                                          TextSpan(
                                                                            text:
                                                                                '${i.toString()}.  ${classesLoaded.sem1Classes[i].name}   ',
                                                                          ),
                                                                          WidgetSpan(
                                                                            child:
                                                                                Icon(
                                                                              Icons.meeting_room_outlined,
                                                                              color: Colors.white,
                                                                            ),
                                                                          ),
                                                                          TextSpan(
                                                                            text:
                                                                                ' ${classesLoaded.sem1Classes[i].room}',
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    trailing:
                                                                        // The edit class button
                                                                        IconButton(
                                                                      icon:
                                                                          Icon(
                                                                        Icons
                                                                            .more_vert,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                      onPressed:
                                                                          () =>
                                                                              {
                                                                        _editClass(
                                                                            context,
                                                                            i,
                                                                            0),
                                                                      },
                                                                    ),
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
                                      FloatingActionButton(
                                        onPressed: () => {_addClass(0)},
                                        tooltip: 'Add Class',
                                        child: Icon(Icons.add),
                                        backgroundColor: Colors.blue,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Column(
                                    children: [
                                      Center(
                                        child: Container(
                                          color: Color(0xFF121212),
                                          width: 500,
                                          height: 520,
                                          child: Container(
                                            width: 500,
                                            child: Container(
                                              child: Card(
                                                clipBehavior: Clip.antiAlias,
                                                color: Color(0xFF3b3b3b),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.0),
                                                ),
                                                child: Column(
                                                  children: [
                                                    Expanded(
                                                      child: Container(
                                                        padding:
                                                            EdgeInsets.all(10),
                                                        child: ListView(
                                                          scrollDirection:
                                                              Axis.vertical,
                                                          children: <Widget>[
                                                            // Dynamically create a class card for each elemnt in the given array
                                                            for (var i = 0;
                                                                i <
                                                                    semClassCountsLoad
                                                                        .sem2ClassCount;
                                                                i++)
                                                              // Class card
                                                              Container(
                                                                decoration:
                                                                    new BoxDecoration(
                                                                  boxShadow: [
                                                                    new BoxShadow(
                                                                      color: Colors
                                                                          .black
                                                                          .withOpacity(
                                                                              0.5),
                                                                      blurRadius:
                                                                          5.0,
                                                                    ),
                                                                  ],
                                                                ),
                                                                child: Card(
                                                                  color: Color(
                                                                      0xff5b5b5b),
                                                                  child:
                                                                      ListTile(
                                                                    title: Text
                                                                        .rich(
                                                                      TextSpan(
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                        children: [
                                                                          TextSpan(
                                                                            text:
                                                                                '${i.toString()}.  ${classesLoaded.sem2Classes[i].name}   ',
                                                                          ),
                                                                          WidgetSpan(
                                                                            child:
                                                                                Icon(
                                                                              Icons.meeting_room_outlined,
                                                                              color: Colors.white,
                                                                            ),
                                                                          ),
                                                                          TextSpan(
                                                                            text:
                                                                                ' ${classesLoaded.sem2Classes[i].room}',
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    trailing:
                                                                        // The edit class button
                                                                        IconButton(
                                                                      icon:
                                                                          Icon(
                                                                        Icons
                                                                            .more_vert,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                      onPressed:
                                                                          () =>
                                                                              {
                                                                        _editClass(
                                                                            context,
                                                                            i,
                                                                            1),
                                                                      },
                                                                    ),
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
                                      FloatingActionButton(
                                        onPressed: () => {_addClass(1)},
                                        tooltip: 'Add Class',
                                        child: Icon(Icons.add),
                                        backgroundColor: Colors.blue,
                                      ),
                                    ],
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
      //Socials PAGE
      SocialPage(),
    ];
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          // Change notification, and device info bar to white
          systemOverlayStyle: SystemUiOverlayStyle.light,
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
              showSelectedLabels: true,
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
                BottomNavigationBarItem(
                  backgroundColor: Color(0xFF212121),
                  icon: Icon(
                    Icons.share,
                  ),
                  label: 'Social',
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
  _classEdit(int index, int semester) {
    if (semester == 0) {
      classesSaved.sem1Classes[index].name = classEditController.text;
      classesSaved.sem1Classes[index].room = classRoomEditController.text;
      sharedPref.save(
          keyClasses.sem1Keys[index], classesSaved.sem1Classes[index]);
      loadSharedPrefs(0);
    } else if (semester == 1) {
      print('semester 2');
      classesSaved.sem2Classes[index].name = classEditController.text;
      classesSaved.sem2Classes[index].room = classRoomEditController.text;
      sharedPref.save(
          keyClasses.sem2Keys[index], classesSaved.sem2Classes[index]);
      loadSharedPrefs(1);
    }
  }

  // This is the pop up for editing classes.
  // function called draws a pop up
  _editClass(context, int index, int semester) {
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
              _classEdit(index, semester),
              getCurrentTime()
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
        loadSharedPrefs(0);
        loadSharedPrefs(1);
      }
      if (_selectedIndex == 0) {
        updateActiveClass();
      }
    });
  }

  // Add Classes functionailty
  void _addClass(int semester) {
    // Semester 1 code
    if (semester == 0) {
      if (semClassCountsLoad.sem1ClassCount < maxClasses) {
        semClassCountsSave.sem1ClassCount += 1;
        sharedPref.save(keyClassCount, semClassCountsSave);
        loadSharedPrefs(0);
      }
      // Semecter 2 code
    } else if (semester == 1) {
      if (semClassCountsLoad.sem2ClassCount < maxClasses) {
        semClassCountsSave.sem2ClassCount += 1;
        sharedPref.save(keyClassCount, semClassCountsSave);
        loadSharedPrefs(1);
      }
    }
  }
}
