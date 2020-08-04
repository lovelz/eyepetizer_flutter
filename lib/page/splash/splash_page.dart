

import 'package:eyepetizer_flutter/routers/fluro_navigator.dart';
import 'package:eyepetizer_flutter/routers/routers.dart';
import 'package:eyepetizer_flutter/widgets/load_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SplashPage extends StatefulWidget {

  @override
  _SplashPageState createState() => _SplashPageState();

}

class _SplashPageState extends State<SplashPage> with SingleTickerProviderStateMixin {

  AnimationController _controller;
  Animation<double> _animation;
  Animation<double> _alphaAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(duration: Duration(milliseconds: 3000), vsync: this);
    final Animation curve = CurvedAnimation(parent: _controller, curve: Curves.linear);
    _animation = Tween<double>(begin: 1.0, end: 1.2).animate(curve);
    _alphaAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(curve)
    ..addStatusListener((state) {
        if (state == AnimationStatus.completed) {
          NavigatorUtils.push(context, Routes.main, clearStack: true);
        }
    });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: <Widget>[
          ScaleTransition(
            scale: _animation,
            child: LoadAssetImage('bg_splash', format: 'jpeg', width: double.infinity, height: double.infinity, fit: BoxFit.fill,),
          ),
          Center(
            child: FadeTransition(
              opacity: _alphaAnimation,
              child: LoadAssetImage('ic_logo_slogan', width: 178.0, height: 63.0,),
            ),
          ),
        ],
      ),
    );
  }

}