import 'package:flutter/material.dart';

/// [AppText] 是一个 StatelessWidget，用于展示统一风格的文本信息。
/// 它简化了 `Text` 组件的使用，预设了默认的字体大小和颜色，
/// 使得整个应用程序的文本展示更加统一和便于管理。
///
/// 属性:
/// - `text`: 要展示的文本内容。
/// - `size`: 文本的字号，默认为16逻辑像素，可以根据需要进行调整。
/// - `color`: 文本的颜色，默认为`Colors.black54`，即一种较淡的黑色。
class AppText extends StatelessWidget {
  final String text;
  final double size;
  final Color color;

  /// 构造函数，初始化 [AppText] 组件的基本属性。
  const AppText(
    this.text, {
    super.key,
    this.size = 16,
    this.color = Colors.black54,
  });

  @override
  Widget build(BuildContext context) {
    // 返回一个 Text 组件，应用了指定的样式
    return Text(
      text,
      style: TextStyle(
        color: color, // 使用传入的颜色
        fontSize: size, // 使用传入的字号
      ),
    );
  }
}
