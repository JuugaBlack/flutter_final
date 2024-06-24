import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ufo/common/colors.dart';
import 'package:ufo/widgets/app_text.dart';
import 'package:ufo/widgets/app_text_field.dart';

/// 注册页面组件，用于用户创建新账户。
class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    // 创建Scaffold作为页面基础框架
    return Scaffold(
      // 防止页面在软键盘弹出时自动调整大小
      resizeToAvoidBottomInset: false,
      // 自定义AppBar，包含返回按钮和标题
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back_ios), // 返回按钮图标
        title: Text(
          '注册',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      // 页面主体内容
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        decoration: const BoxDecoration(
          color: Colors.white, // 背景色
          image: DecorationImage(
            // 底部背景图
            alignment: Alignment.bottomCenter,
            image: AssetImage('assets/images/register_background.png'),
            fit: BoxFit.fitWidth,
            opacity: 0.2, // 图片透明度
          ),
        ),
        child: Column(
          children: [
            // 顶部间距
            SizedBox(height: 40.h),
            // 用户名输入框
            const AppTextField(prefixText: '用户名', hintText: '请输入用户名'),
            // 输入框间距
            SizedBox(height: 20.h),
            // 密码输入框
            const AppTextField(prefixText: '密码', hintText: '请输入密码'),
            // 下方间距
            SizedBox(height: 40.h),
            // 注册按钮，点击时打印日志
            InkWell(
              onTap: () {
                print('object');
                Navigator.pushNamed(context, '/welcome');
              },
              child: Container(
                width: 270.w,
                height: 40.h,
                decoration: BoxDecoration(
                  color: AppColors.mainColor, // 按钮背景色
                  borderRadius: BorderRadius.circular(20.r), // 圆角
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center, // 文本居中
                  children: const [AppText('注册', color: Colors.white)], // 按钮文本
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
