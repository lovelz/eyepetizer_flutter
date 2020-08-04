

import 'package:eyepetizer_flutter/res/dimens.dart';
import 'package:eyepetizer_flutter/res/gaps.dart';
import 'package:eyepetizer_flutter/util/image_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///统一的空状态页面管理
class StateLayout extends StatefulWidget {

  final StateType type;
  final String hintText;

  const StateLayout({Key key, @required this.type, this.hintText}) : super(key: key);

  @override
  _StateLayoutState createState() => _StateLayoutState();

}

class _StateLayoutState extends State<StateLayout> {

  /// 空页面图标，没有则不需要
  String _img;
  /// 空页面提示文字
  String _hintText;

  @override
  Widget build(BuildContext context) {
    switch (widget.type) {
      case StateType.network:
        _img = '';
        _hintText = '无网络连接';
        break;
      case StateType.loading:
        _img = '';
        _hintText = '';
        break;
      case StateType.empty:
        _img = '';
        _hintText = '';
        break;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        widget.type == StateType.loading ? const CupertinoActivityIndicator(radius: 16.0,) :
        (widget.type == StateType.empty ? Gaps.empty :
        Container(
          height: 120.0,
          width: 120.0,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: ImageUtils.getAssetImage('state/$_img'),
            ),
          ),
        )),
        Padding(
          padding: EdgeInsets.only(top: 16.0, bottom: 50.0),
          child: Text(
            widget.hintText ?? _hintText,
            style: Theme.of(context).textTheme.subtitle2.copyWith(fontSize: Dimens.font_sp14),
          ),
        ),
      ],
    );

  }

}

/// 状态类型
enum StateType {
  /// 无网络
  network,
  /// 加载中
  loading,
  /// 空
  empty,
}