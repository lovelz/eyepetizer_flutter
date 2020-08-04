

import 'package:eyepetizer_flutter/widgets/app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WidgetNotFound extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MyAppBar(
        centerTitle: '页面不存在',
      ),
      body: Center(
        child: Text('404 not found', style: TextStyle(fontSize: 20.0),),
      ),
    );
  }

}