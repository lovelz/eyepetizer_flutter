
import 'package:eyepetizer_flutter/res/dimens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 间隔
class Gaps {

  static const Widget hGap4 = const SizedBox(width: Dimens.gap_dp4);
  static const Widget hGap10 = const SizedBox(width: Dimens.gap_dp10);
  static const Widget hGap16 = const SizedBox(width: Dimens.gap_dp16);

  static Widget line = const Divider();

  static Widget vLine = const SizedBox(
    width: 0.6,
    height: 24.0,
    child: const VerticalDivider(),
  );

  static const Widget empty = const SizedBox.shrink();

}