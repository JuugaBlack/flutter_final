import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lime/widgets/app_large_text.dart';

/// 文本输入框
class AppTextField extends StatelessWidget {
  final double width;
  final double height;
  final String prefixText;
  final String hintText;
  final bool isPasswordTextField;

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
    return SizedBox(
      width: width,
      height: height,
      child: Flexible(
        child: TextField(
          obscureText: isPasswordTextField,
          decoration: InputDecoration(
            prefixIcon: Padding(
              padding: EdgeInsets.only(right: 20.w),
              child: AppLargeText(prefixText, size: 16.sp),
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 5),
            hintText: hintText,
            isDense: true,
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
