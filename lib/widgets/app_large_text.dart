import 'package:flutter/material.dart';

/// [AppLargeText] 是一个 StatelessWidget，用于展示大号加粗文本。
/// 该组件旨在提供统一风格的大字体显示，简化大标题或重要文本信息的样式设置。
///
/// 属性:
/// - `text`: 要展示的文本内容。
/// - `size`: 文本的字号，默认为30逻辑像素，适合突出显示。
/// - `color`: 文本颜色，默认为黑色，可以根据设计需求调整。
///
/// 示例用法:
/// ```dart
/// AppLargeText("欢迎", size: 36, color: Colors.blue);
/// ```
class AppLargeText extends StatelessWidget {
  final double size;
  final String text;
  final Color color;

  /// 构造函数，初始化 [AppLargeText] 组件的属性。
  const AppLargeText(
    this.text, {
    super.key,
    this.size = 30,
    this.color = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    // 返回一个 Text 组件，应用了大号、加粗的指定样式
    return Text(
      text,
      style: TextStyle(
        color: color, // 使用传入的颜色
        fontSize: size, // 使用传入的字号
        fontWeight: FontWeight.bold, // 设置字体加粗
      ),
    );
  }
}
