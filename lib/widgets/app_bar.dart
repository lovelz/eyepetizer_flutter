import 'package:eyepetizer_flutter/res/colors.dart';
import 'package:eyepetizer_flutter/res/dimens.dart';
import 'package:eyepetizer_flutter/res/gaps.dart';
import 'package:eyepetizer_flutter/util/theme_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// 自定义app bar
class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color backgroundColor;
  final String title;
  final String centerTitle;
  final String backImg;
  final bool isBack;
  final String actionName;
  final VoidCallback onPressed;

  const MyAppBar({
    Key key,
    this.backgroundColor,
    this.title: '',
    this.centerTitle: '',
    this.backImg: 'assets/images/ic_back_black.png',
    this.isBack: true,
    this.actionName: '',
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color _backgroundColor;

    if (backgroundColor == null) {
      _backgroundColor = ThemeUtils.getBackgroundColor(context);
    } else {
      _backgroundColor = backgroundColor;
    }

    ///沉浸式状态栏设置相关
    SystemUiOverlayStyle _overlayStyle =
        ThemeData.estimateBrightnessForColor(_backgroundColor) == Brightness.dark
            ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark;

    ///返回键
    var back = isBack ? IconButton(
      onPressed: () {
        FocusScope.of(context).unfocus();
        Navigator.maybePop(context);
      },
      tooltip: '返回',
      padding: const EdgeInsets.all(12.0),
      icon: Image.asset(
        backImg,
      ),
    ) : Gaps.empty;

    ///右侧操作功能按钮
    var action = actionName.isNotEmpty ? Positioned(
      right: 0.0,
      child: Theme(
        data: Theme.of(context).copyWith(
          buttonTheme: ButtonThemeData(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            minWidth: 60.0,
          ),
        ),
        child: FlatButton(
          child: Text(
            actionName,
            key: const Key('actionName'),
          ),
          textColor: Colours.text,
          onPressed: onPressed,
        ),
      ),
    ) : Gaps.empty;

    return AnnotatedRegion(
      //修改状态栏字体颜色
      value: _overlayStyle,
      child: Material(
        color: _backgroundColor,
        child: SafeArea(
          child: Stack(
            alignment: Alignment.centerLeft,
            children: <Widget>[
              Container(
                alignment: centerTitle.isEmpty ? Alignment.centerLeft : Alignment.center,
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 48.0),
                child: Text(
                  title.isEmpty ? centerTitle : title,
                  style: TextStyle(
                    fontSize: Dimens.font_sp18,
                  ),
                ),
              ),
              back,
              action,
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(48.0);
}
