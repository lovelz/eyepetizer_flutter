import 'package:eyepetizer_flutter/routers/application.dart';
import 'package:eyepetizer_flutter/routers/routers.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';

class NavigatorUtils {

  ///正常页面跳转
  static push(BuildContext context, String path,
      {bool replace = false, bool clearStack = false})
  {
    FocusScope.of(context).unfocus();
    Application.router.navigateTo(
        context,
        path,
        replace: replace,
        clearStack: clearStack,
        transition: TransitionType.native);
  }

  ///带返回结果的页面跳转
  static pushResult(
      BuildContext context, String path, Function(Object) function,
      {bool replace = false, bool clearStack = false})
  {
    FocusScope.of(context).unfocus();
    Application.router.navigateTo(
      context,
      path,
      replace: replace,
      clearStack: clearStack,
      transition: TransitionType.native
    ).then((result) {
      if (result == null) {
        return;
      }
      function(result);
    }).catchError((error) {
      print('$error');
    });
  }

  ///正常返回
  static void goBack(BuildContext context) {
    FocusScope.of(context).unfocus();
    Navigator.pop(context);
  }

  ///带参数返回
  static void goBackWithParams(BuildContext context, result) {
    FocusScope.of(context).unfocus();
    Navigator.pop(context, result);
  }

  ///跳转到WebView页面
  static void goWebViewPage(BuildContext context, String title, String url) {
    //fluro 不支持传中文,需转换
    push(context, '${Routes.webViewPage}?title=${Uri.encodeComponent(title)}&url=${Uri.encodeComponent(url)}');
  }

}
