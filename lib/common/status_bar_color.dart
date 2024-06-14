import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// `StatusBarColor` 类用于自定义状态栏的样式。
///
/// 通过此类可以设置状态栏的颜色、亮度和图标的亮度。
/// 这对于在Flutter应用中实现与主题相匹配的状态栏样式非常有用。
class StatusBarColor extends SystemUiOverlayStyle {
  /// 构造函数用于创建一个状态栏颜色对象。
  ///
  /// 提供了三个可配置的参数：
  /// - `statusBarColor` 状态栏的背景颜色，默认为白色。
  /// - `statusBarBrightness` 状态栏的亮度，默认为明亮模式。
  /// - `statusBarIconBrightness` 状态栏图标的亮度，默认为黑暗模式。
  const StatusBarColor({
    super.statusBarColor = const Color(0xfffafafa),
    super.statusBarBrightness = Brightness.light,
    super.statusBarIconBrightness = Brightness.dark,
  });
}
