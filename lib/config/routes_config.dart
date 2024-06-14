import 'package:lime/config/route_names.dart';
import 'package:lime/pages/book.dart';
import 'package:lime/pages/chart.dart';
import 'package:lime/pages/dtail.dart';
import 'package:lime/pages/individual.dart';
import '../pages/home_page.dart';
import 'package:lime/pages/record.dart';
import 'package:lime/pages/user_pages/register_page.dart';
import 'package:lime/pages/welcome_page.dart';

/// 底部标签页命名路由参数配置
final routes = {
  // 主页
  homeRouteName: () => Home(),

  // 底部标签栏
  '/dtail': () => Dtail(),
  '/chart': () => Chart(),
  '/record': () => Record(),
  '/book': () => Book(),
  '/individual': () => Individual(),

  // 注册页
  registerRouteName: () => RegisterPage(),

  // 引导页
  welcomeRouteName: () => WelcomePage(),
};
