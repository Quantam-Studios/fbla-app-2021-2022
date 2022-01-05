import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewContainer extends StatefulWidget {
  final url;
  final index;
  WebViewContainer(this.url, this.index);
  @override
  createState() => _WebViewContainerState(this.url, this.index);
}

//TODO: Create a cleaner method for this
final socialStrings = ['CCHS Instagram', 'CCHS Twitter'];

class _WebViewContainerState extends State<WebViewContainer> {
  var _url;
  var _index;
  final _key = UniqueKey();
  _WebViewContainerState(this._url, int this._index);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF212121),
          title: Text(socialStrings[_index]),
        ),
        body: Column(
          children: [
            Expanded(
                child: WebView(
                    key: _key,
                    javascriptMode: JavascriptMode.unrestricted,
                    initialUrl: _url))
          ],
        ));
  }
}
