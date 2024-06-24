import 'package:flutter/material.dart';
import 'package:ufo/common/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// [WelcomeButton] 是一个 StatelessWidget，用于创建具有特定样式和功能的按钮，
/// 主要设计用于引导页中，但也可灵活应用于其他场景。
/// 按钮包含一个图标，并支持自定义大小、图标和点击事件。
class WelcomeButton extends StatelessWidget {
  /// 按钮的宽度，默认根据需求传入。
  final double? width;

  /// 按钮的高度，默认为60逻辑像素。
  final double height;

  /// 按钮上显示的图标，默认为向右箭头图标。
  final IconData icon;

  /// 是否响应式调整大小。如果为`true`，按钮大小可能根据父布局动态调整。
  final bool isResponsive;

  /// 点击按钮时触发的回调函数。
  final void Function()? onTab;

  const WelcomeButton({
    super.key,
    required this.width,
    this.height = 60,
    this.icon = FontAwesomeIcons.chevronRight,
    this.isResponsive = false,
    this.onTab,
  });

  @override
  Widget build(BuildContext context) {
    // 使用GestureDetector包裹Container以捕获点击事件
    return GestureDetector(
      onTap: onTab, // 触发点击回调
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), // 圆角装饰
          color: AppColors.mainColor, // 使用自定义主题色填充背景
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center, // 图标居中显示
          children: [
            FaIcon(icon, color: Colors.white, size: 18), // 显示图标
          ],
        ),
      ),
    );
  }
}
