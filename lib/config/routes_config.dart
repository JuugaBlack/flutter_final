import 'package:lime/config/route_names.dart';
import 'package:lime/pages/book.dart';
import 'package:lime/pages/chart.dart';
import 'package:lime/pages/dtail.dart';
import 'package:lime/pages/home_page.dart';
import 'package:lime/pages/individual/AboutPage.dart';
import 'package:lime/pages/individual/AccountManagementPage.dart';
import 'package:lime/pages/individual/ContactUsPage.dart';
import 'package:lime/pages/individual/HelpPage.dart';
import 'package:lime/pages/individual/ImportExportPage.dart';
import 'package:lime/pages/individual/PersonalizationPage.dart';
import 'package:lime/pages/individual/SettingsPage.dart';
import 'package:lime/pages/individual/individual.dart';
import 'package:lime/pages/nav_pages/main_page.dart';
import 'package:lime/pages/record.dart';
import 'package:lime/pages/user_pages/register_page.dart';
import 'package:lime/pages/welcome_page.dart';

/// 底部标签页命名路由参数配置
final routes = {
  // 主页
  homeRouteName: () => MainPage(),

  '/main': () => Home(),

  // // 底部标签栏
  '/dtail': () => Dtail(),
  '/chart': () => Chart(),
  '/record': () => Record(),
  '/book': () => Book(),
  '/individual': () => Individual(),

  // 注册页
  '/register': () => RegisterPage(),

  // 引导页
  welcomeRouteName: () => WelcomePage(),

  '/personalization': () => PersonalizationPage(),
  '/account_management': () => AccountManagementPage(),
  '/contact_us': () => ContactUsPage(),
  '/settings': () => SettingsPage(),
  '/about': () => AboutPage(),
  '/help': () => HelpPage(),
  '/import_export': () => ImportExportPage(),
};
