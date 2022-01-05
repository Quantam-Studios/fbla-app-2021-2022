import 'package:flutter/material.dart';
import 'web_view_container.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
          ),
        ),
      ),
    );
  }

  Widget _urlButton(BuildContext context, String url) {
    return Center(
      heightFactor: 2,
      child: Card(
        color: Color(0xff5b5b5b),
        child: ListTile(
          leading: GradientIcon(
            FontAwesomeIcons.instagram,
            40.0,
            LinearGradient(
              colors: <Color>[
                Color(0xffF58529),
                Color(0xffDD2A7B),
                Color(0xff8134AF),
                Color(0xff515BD4),
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
          title: Text.rich(
            TextSpan(
              style: TextStyle(
                color: Colors.white,
              ),
              children: [
                TextSpan(
                  text: 'View the CCHS Instagram',
                ),
              ],
            ),
          ),
          onTap: () => _handleURLButtonPress(context, url),
        ),
      ),
    );
  }

  //onPressed: () => _handleURLButtonPress(context, url),
  void _handleURLButtonPress(BuildContext context, String url) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => WebViewContainer(url)));
  }
}

class GradientIcon extends StatelessWidget {
  GradientIcon(
    this.icon,
    this.size,
    this.gradient,
  );

  final IconData icon;
  final double size;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      child: SizedBox(
        width: size * 1.2,
        height: size * 1.2,
        child: FaIcon(
          icon,
          size: size,
          color: Colors.white,
        ),
      ),
      shaderCallback: (Rect bounds) {
        final Rect rect = Rect.fromLTRB(0, 0, size, size);
        return gradient.createShader(rect);
      },
    );
  }
}
