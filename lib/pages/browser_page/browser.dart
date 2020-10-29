
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BrowserPage extends StatefulWidget {
  static const String routeName = 'BrowserPage';
  final BrowserArgument argument;
  const BrowserPage(this.argument);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _BrowserSate();
  }

}
class _BrowserSate extends State<BrowserPage>{
  final Completer<WebViewController> _controller =
  Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.widget.argument.url),
      ),
      body: WebView(
        initialUrl: this.widget.argument.url,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
        },
      ),
    );
  }
}

class BrowserArgument {
  final String url;
  const BrowserArgument(this.url);
}