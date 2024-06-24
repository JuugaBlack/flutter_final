import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ufo/widgets/app_large_text.dart';

/// [AppTextField] 是一个 StatelessWidget，用于创建具有定制化样式的文本输入框。
/// 此输入框支持前缀图标（通过文字表示）、占位提示文本，并可配置为密码输入模式。
///
/// 属性:
/// - `width`: 输入框的宽度，默认为300逻辑像素。
/// - `height`: 输入框的高度，默认为26逻辑像素。
/// - `prefixText`: 输入框前缀的文本内容，用于显示图标或提示信息。
/// - `hintText`: 输入框的占位提示文本。
/// - `isPasswordTextField`: 是否将输入框设置为密码模式，默认为`false`。
class AppTextField extends StatelessWidget {
  final double width;
  final double height;
  final String prefixText;
  final String hintText;
  final bool isPasswordTextField;

  /// 构造函数，初始化 [AppTextField] 组件的属性。
  const AppTextField({
    super.key,
    this.width = 300,
    this.height = 26,
    required this.prefixText,
    required this.hintText,
    this.isPasswordTextField = false,
  });

  @override
  Widget build(BuildContext context) {
    // 创建一个SizedBox以限制输入框的尺寸，并使用Flexible保证输入框内容的弹性布局
    return SizedBox(
      width: width,
      height: height,
      child: Flexible(
        child: TextField(
          // 根据属性决定是否遮掩输入内容（密码模式）
          obscureText: isPasswordTextField,
          decoration: InputDecoration(
            // 设置前缀图标为AppLargeText组件
            prefixIcon: Padding(
              padding: EdgeInsets.only(right: 20.w),
              child: AppLargeText(prefixText, size: 16.sp),
            ),
            // 输入框内边距及样式配置
            contentPadding: const EdgeInsets.symmetric(vertical: 5),
            hintText: hintText,
            isDense: true,
            // 占位符文本样式
            hintStyle: TextStyle(
              color: Colors.grey.withOpacity(0.5),
              fontSize: 12.sp,
            ),
          ),
        ),
      ),
    );
  }
}
