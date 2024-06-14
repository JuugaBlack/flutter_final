import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lime/common/colors.dart';
import 'package:lime/widgets/app_text.dart';
import 'package:lime/widgets/app_text_field.dart';

/// `RegisterPage` 类用于实现用户注册界面。
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    // 创建Scaffold作为页面的基础框架
    return Scaffold(
      // 防止页面在键盘弹出时自动调整大小
      resizeToAvoidBottomInset: false,
      // 自定义AppBar，包含返回按钮和标题
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back_ios), // 左侧返回按钮
        title: Text(
          '注册',
          style: TextStyle(
            // 标题样式
            color: Colors.black,
            fontSize: 20.sp, // 使用屏幕适配单位
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      // 页面主体内容
      body: Container(
        width: double.maxFinite, // 全宽
        height: double.maxFinite, // 全高
        decoration: const BoxDecoration(
          // 背景装饰
          color: Colors.white, // 背景色
          image: DecorationImage(
            // 底部叠加的背景图片
            alignment: Alignment.bottomCenter, // 图片对齐方式
            image:
                AssetImage('assets/images/register_background.png'), // 图片资源路径
            fit: BoxFit.fitWidth, // 图片缩放模式
            opacity: 0.2, // 图片透明度
          ),
        ),
        child: Column(
          // 垂直布局容器
          children: [
            SizedBox(height: 40.h), // 间距
            const AppTextField(prefixText: '用户名', hintText: '请输入用户名'), // 用户名输入框
            SizedBox(height: 20.h), // 间距
            const AppTextField(prefixText: '密码', hintText: '请输入密码'), // 密码输入框
            SizedBox(height: 40.h), // 间距
            // 注册按钮，使用InkWell实现点击效果
            InkWell(
              onTap: () {
                print('object'); // 点击时的回调，此处仅为示例输出
                Navigator.pushNamed(context, '/welcome');
              },
              child: Container(
                // 按钮容器
                width: 270.w, // 宽度适配
                height: 40.h, // 高度适配
                decoration: BoxDecoration(
                  // 按钮背景样式
                  color: AppColors.mainColor, // 主题色背景
                  borderRadius: BorderRadius.circular(20.r), // 圆角
                ),
                child: Row(
                  // 按钮内部文本布局
                  mainAxisAlignment: MainAxisAlignment.center, // 主轴居中对齐
                  children: const [
                    AppText('注册', color: Colors.white)
                  ], // 显示文本“注册”
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
