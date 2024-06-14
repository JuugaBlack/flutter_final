import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lime/config/route_names.dart';
import 'package:lime/route/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 应用程序的入口点。
/// 异步执行屏幕适配初始化，并检查应用是否是首次启动，以决定是否显示引导页。
/// 启动入口
void main() async {
  // 初始化屏幕适配
  // flutter 屏幕适配方案
  await ScreenUtil.ensureScreenSize();

  // 获取SharedPreferences实例，用于存储和读取应用配置信息
  final prefs = await SharedPreferences.getInstance();
  // 检查应用是否是首次启动，如果是，则记录已启动，并跳转到引导页
  final int? initScreen = prefs.getInt('initScreen');
  await prefs.setInt('initScreen', 1);

  // 运行应用，传入引导页显示的判断条件
  runApp(Main(initScreen));
}

/// 主应用类。
/// 该类初始化了应用的屏幕适配和主题配置，并根据应用是否是首次启动来决定显示的初始路由。
class Main extends StatelessWidget {
  /// 是否是应用的首次启动。
  final int? initScreen;

  /// Main类的构造函数。
  const Main(this.initScreen, {super.key});

  /// 构建应用的用户界面。
  @override
  Widget build(BuildContext context) {
    // 初始化屏幕适配参数
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp(
        // 设置应用的初始路由
        initialRoute: homeRouteName, // 我认为离线使用不需要注册和引导页面，所以就直接跳转到主页面了
        // 定义路由生成策略
        onGenerateRoute: onGenerateRoute,
        // 禁止显示Debug banner
        debugShowCheckedModeBanner: false,
        // 应用的主题配置
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
              backgroundColor: Colors.white,
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.white,
                statusBarIconBrightness: Brightness.dark,
                statusBarBrightness: Brightness.light,
              ),
              centerTitle: true,
              elevation: 1,
              iconTheme: IconThemeData(color: Colors.black)),
        ),
      ),
    );
  }
}
