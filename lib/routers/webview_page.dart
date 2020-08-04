

import 'dart:async';

import 'package:eyepetizer_flutter/widgets/app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// 通用的WebView加载页面
class WebViewPage extends StatefulWidget {

  final String title;
  final String url;

  const WebViewPage({Key key, @required this.title, @required this.url}) : super(key: key);

  @override
  _WebViewPageState createState() => _WebViewPageState();

}

class _WebViewPageState extends State<WebViewPage> {

  final Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WebViewController>(
      future: _controller.future,
      builder: (context, snapshot) {
        return WillPopScope(
          onWillPop: () async {
            if (snapshot.hasData) {
              bool canGoBack = await snapshot.data.canGoBack();
              if (canGoBack) {
                //网页可以自己返回时，优先返回上一页
                snapshot.data.goBack();
                return Future.value(false);
              }
              return Future.value(true);
            }
            return Future.value(true);
          },
          child: Scaffold(
            appBar: MyAppBar(
              centerTitle: widget.title,
            ),
            body: WebView(
              initialUrl: widget.url,
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {
                _controller.complete(webViewController);
              },
            ),
          ),
        );
      },
    );
  }

}