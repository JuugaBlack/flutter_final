import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// 状态栏颜色
class StatusBarColor extends SystemUiOverlayStyle {
  const StatusBarColor({
    super.statusBarColor = const Color(0xfffafafa),
    super.statusBarBrightness = Brightness.light,
    super.statusBarIconBrightness = Brightness.dark,
  });
}
