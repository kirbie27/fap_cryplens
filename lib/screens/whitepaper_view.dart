import 'dart:async';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WhitepaperView extends StatefulWidget {
  final String whitepaperURL;
  WhitepaperView(
      {required this.whitepaperURL}); //Gets the url from the news page

  @override
  _WhitepaperViewState createState() => _WhitepaperViewState();
}

class _WhitepaperViewState extends State<WhitepaperView> {
  final Completer<WebViewController> _completer = Completer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text('CryptoPaper')],
        ),
        actions: [
          //Only used to adjust the spacing of the appbar title
          Opacity(
            opacity: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: FaIcon(FontAwesomeIcons.solidNewspaper),
            ),
          )
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: WebView(
          javascriptMode: JavascriptMode
              .unrestricted, //To make sure that the webview of the url is loaded
          initialUrl: widget.whitepaperURL,
          onWebViewCreated: (WebViewController webViewController) {
            _completer.complete(webViewController);
          },
        ),
      ),
    );
  }
}
