

import 'package:eyepetizer_flutter/page/main_page.dart';
import 'package:eyepetizer_flutter/routers/404.dart';
import 'package:eyepetizer_flutter/routers/router_init.dart';
import 'package:eyepetizer_flutter/routers/webview_page.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';

class Routes {

  static String main = '/main';
  static String webViewPage = '/webview';

  static List<IRouterProvider> _listRouter = [];

  static void configureRoutes(Router router) {
    /// 统一路由跳转错误页面
    router.notFoundHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) {
        debugPrint('未找到目标页');
        return WidgetNotFound();
      }
    );

    router.define(main, handler: Handler(handlerFunc:
        (BuildContext context, Map<String, List<String>> params) => MainPage()));

    router.define(webViewPage, handler: Handler(handlerFunc: (_, params) {
      String title = params['title']?.first;
      String url = params['url']?.first;
      return WebViewPage(title: title, url: url);
    }));
  }

}