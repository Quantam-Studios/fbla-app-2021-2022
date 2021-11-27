//import 'dart:html';

// ignore: import_of_legacy_library_into_null_safe
//import 'dart:html';

import 'package:carousel_slider/carousel_slider.dart';
import "package:flutter/material.dart";

main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    //return _MyAppState();
    return TestAppState();
  }
}

class TestAppState extends State<MyApp> {
  int _selectedIndex = 0;
  @override
  build(BuildContext context) {
    List<Widget> _pages = <Widget>[
      // HOME PAGE STUFF
      Scaffold(
        body: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Container(
              height: 400,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: FractionalOffset.bottomCenter,
                  colors: [Colors.purple, Colors.deepPurple],
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
                              icon: Icon(Icons.format_list_bulleted_rounded),
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
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  viewportFraction: 0.8,
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
                        )))),
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
                        )))),
          ],
        ),
      ),
      //PLANNER PAGE
      //TODO (Create page)
      Icon(
        Icons.calendar_today_rounded,
        size: 150,
        color: Colors.deepPurple,
      ),
      //CLASSES PAGE
      //TODO (Create page)
      Icon(
        Icons.format_list_bulleted_rounded,
        size: 150,
        color: Colors.deepPurple,
      ),
      //CLUBS PAGE
      //TODO (Create page)
      Icon(
        Icons.local_activity_rounded,
        size: 150,
        color: Colors.deepPurple,
      ),
    ];
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xFF121212),
        appBar: AppBar(
          backgroundColor: Color(0xFF212121),
          title: Text('CCHS'),
          actions: <Widget>[
            // Settings
            IconButton(
              icon: Icon(
                Icons.settings,
                color: Colors.white,
              ),
              onPressed: () {
                // do something
              },
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Color(0xFF212121),
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          selectedItemColor: Colors.deepPurple,
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
        body: Center(
          child: _pages.elementAt(_selectedIndex), //New
        ),

        /*  */
      ),
    );
  }

  //Bottom Bar functionaity
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}

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