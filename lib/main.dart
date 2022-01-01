// Packages and Dependencies
import 'package:carousel_slider/carousel_slider.dart';
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Shared Preferences Configuration for global use
// CONSTANT KEYS FOR SAVE DATA IN SHARED PREFERENCES
const keyClasses = 'classes';
List<String> classes = List.filled(7, 'Class');

//TEST
const keyTest = 'test';
int testVal = 0;

class SharedPrefs {
  // Main handling of shared prefs
  static SharedPreferences? _sharedPrefs;
  // Because this class won't always create a new instance Factory must be used because it can return caches.
  factory SharedPrefs() => SharedPrefs._internal();

  SharedPrefs._internal();

  // Update shared prefs with changes
  Future<void> init() async {
    _sharedPrefs ??= await SharedPreferences.getInstance();
  }

  // TEST
  int? get _testVal => _sharedPrefs!.getInt(keyTest);

  set _testVal(value) {
    _sharedPrefs!.setInt(keyTest, value);
  }

  // Class Card Update Methods
  List<String>? get Classes => _sharedPrefs!.getStringList(keyClasses);

  set Classes(value) {
    _sharedPrefs!.setStringList(keyClasses, value);
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefs().init();
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    //return _MyAppState();
    return TestAppState();
  }
}

class TestAppState extends State<MyApp> {
  // Bottom Navigation
  int _selectedIndex = 0;
  // Edit Class Pop Up controller
  final classEditController = TextEditingController(text: '');
  // clean up closed pop up widget controllers.
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    classEditController.dispose();
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
                                                        Card(
                                                          color: Colors.blue,
                                                          child: ListTile(
                                                            title: Text(
                                                              'US History',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                            trailing: Icon(
                                                              Icons.more_vert,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                        Card(
                                                          color:
                                                              Color(0xff5b5b5b),
                                                          child: ListTile(
                                                            title: Text(
                                                              'US History',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                            trailing: Icon(
                                                              Icons.more_vert,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                        Card(
                                                          color:
                                                              Color(0xff5b5b5b),
                                                          child: ListTile(
                                                            title: Text(
                                                              'US History',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                            trailing: Icon(
                                                              Icons.more_vert,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                        Card(
                                                          color:
                                                              Color(0xff5b5b5b),
                                                          child: ListTile(
                                                            title: Text(
                                                              'US History',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                            trailing: Icon(
                                                              Icons.more_vert,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                        Card(
                                                          color:
                                                              Color(0xff5b5b5b),
                                                          child: ListTile(
                                                            title: Text(
                                                              'US History',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                            trailing: Icon(
                                                              Icons.more_vert,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                        Card(
                                                          color:
                                                              Color(0xff5b5b5b),
                                                          child: ListTile(
                                                            title: Text(
                                                              'US History',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                            trailing: Icon(
                                                              Icons.more_vert,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                        Card(
                                                          color:
                                                              Color(0xff5b5b5b),
                                                          child: ListTile(
                                                            title: Text(
                                                              'US History',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                            trailing:
                                                                IconButton(
                                                              icon: Icon(
                                                                Icons.more_vert,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                              onPressed: () => {
                                                                _editClass(
                                                                    context, 0),
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
                                                            i < test.length;
                                                            i++)
                                                          // Class card
                                                          Card(
                                                            color: Color(
                                                                0xff5b5b5b),
                                                            child: ListTile(
                                                              title: Text(
                                                                ' Class: ${SharedPrefs()._testVal}',
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

  // SAVED DATA
  // test saved data
  List test = List<int>.filled(7, 4);

  // Save Classes
  _classEdit(int index) {
    SharedPrefs().Classes![index] = classEditController.text;
  }

  // TEST
  _testEdit(int index) {
    SharedPrefs()._testVal = int.parse(classEditController.text);
  }

  // _saveClassEdit(int index) async {
  //   final key = 'hi';
  //   final value = int.parse(classEditController.text);
  //   prefs.setInt(key, value);
  //   print('saved $value at index: $index');
  // }

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
              print(index.toString()),
              _testEdit(index),
              print("Success"),
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
    });
  }
}
