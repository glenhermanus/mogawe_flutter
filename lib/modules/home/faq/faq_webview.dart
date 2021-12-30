import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mogawe/modules/chat/chat_page.dart';
import 'package:mogawe/modules/inbox_notif/inbox/inbox/inbox_page.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewFAQ extends StatefulWidget {

  @override
  _WebviewFAQState createState() => _WebviewFAQState();
}

class _WebviewFAQState extends State<WebviewFAQ> {
  final Completer<WebViewController> _controller = Completer<WebViewController>();
  WebViewController? _myController;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('FAQ MoGawe Apps', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        leading: InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(Icons.clear, color: Colors.black54,)),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(

          onPressed: () => setState(() {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => InboxPage()),
            );
          }),
          elevation: 0,
          tooltip: 'Chat',
          child: Image.asset('assets/icon/ic_chat.png', width: 24,),
          backgroundColor: Colors.red,


        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      body: Builder(builder: (BuildContext context) {
        return WebView(
          initialUrl: 'https://mogawe.id/faq-mobile.html',
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
            webViewController.evaluateJavascript("javascript:var footer = document.getElementsByTagName('footer'); footer.parentNode.removeChild(footer); var header = document.getElementsByTagName('header'); header.parentNode.removeChild(header);");
          },

          onProgress: (int progress) {
            print('loading.. (progress : $progress%)');
          },
          javascriptChannels: <JavascriptChannel>{
            _toasterJavascriptChannel(context),
          },
          navigationDelegate: (NavigationRequest request) {
            print('allowing navigation to $request');
            return NavigationDecision.navigate;
          },
          onPageStarted: (String url) {
            print('Page started loading: $url');
          },
          onPageFinished: (String url) {
            print('Page finished loading: $url');
            _myController?.runJavascript("document.getElementsByTagName('header')[0].style.display='none'");
          },
          gestureNavigationEnabled: true,
        );
      }),
    );
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          // ignore: deprecated_member_use
          Scaffold.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        });
  }
}
