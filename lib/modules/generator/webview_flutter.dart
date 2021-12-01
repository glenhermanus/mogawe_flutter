import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewFlutter extends StatefulWidget {
  const WebviewFlutter({Key? key}) : super(key: key);

  @override
  _WebviewFlutterState createState() => _WebviewFlutterState();
}

class _WebviewFlutterState extends State<WebviewFlutter> {

  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: 'https://flutter.dev',
    );
  }
}
