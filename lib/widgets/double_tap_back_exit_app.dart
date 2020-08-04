

import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DoubleTapBackExitApp extends StatefulWidget {

  final Widget child;
  final Duration duration;

  const DoubleTapBackExitApp({
    Key key,
    @required this.child,
    this.duration : const Duration(milliseconds: 2500)
  }) : super(key: key);

  @override
  _DoubleTapBackExitAppState createState() => _DoubleTapBackExitAppState();

}

class _DoubleTapBackExitAppState extends State<DoubleTapBackExitApp> {

  DateTime _lastTime;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _isExit,
      child: widget.child,
    );
  }

  Future<bool> _isExit() {
    if (_lastTime == null || DateTime.now().difference(_lastTime) > widget.duration) {
      _lastTime = DateTime.now();
      Fluttertoast.showToast(msg: '再次点击退出应用');
      return Future.value(false);
    }
    Fluttertoast.cancel();
    return Future.value(true);
  }

}