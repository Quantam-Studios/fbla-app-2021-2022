import 'package:flutter/material.dart';
import 'web_view_container.dart';

class SocialPage extends StatelessWidget {
  final _links = ['https://www.instagram.com/cchs165/?hl=en'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF121212),
        body: SafeArea(
            child: SingleChildScrollView(
                child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: _links.map((link) => _urlButton(context, link)).toList(),
        ))));
  }

  Widget _urlButton(BuildContext context, String url) {
    return Center(
        heightFactor: 2,
        child: MaterialButton(
          color: Colors.blue,
          shape: CircleBorder(),
          elevation: 2,
          onPressed: () => _handleURLButtonPress(context, url),
          child: Padding(
            padding: const EdgeInsets.all(80),
            child: Text(
              'CCHS Instagram',
              style: TextStyle(color: Colors.white, fontSize: 28),
              textAlign: TextAlign.center,
            ),
          ),
        ));
  }

  //onPressed: () => _handleURLButtonPress(context, url),
  void _handleURLButtonPress(BuildContext context, String url) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => WebViewContainer(url)));
  }
}
