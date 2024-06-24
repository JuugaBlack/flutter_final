import 'package:ufo/config/route_names.dart';
import 'package:ufo/pages/book.dart';
import 'package:ufo/pages/chart.dart';
import 'package:ufo/pages/dtail.dart';
import 'package:ufo/pages/home_page.dart';
import 'package:ufo/pages/individual/AboutPage.dart';
import 'package:ufo/pages/individual/AccountManagementPage.dart';
import 'package:ufo/pages/individual/ContactUsPage.dart';
import 'package:ufo/pages/individual/HelpPage.dart';
import 'package:ufo/pages/individual/ImportExportPage.dart';
import 'package:ufo/pages/individual/PersonalizationPage.dart';
import 'package:ufo/pages/individual/SettingsPage.dart';
import 'package:ufo/pages/individual/individual.dart';
import 'package:ufo/pages/nav_pages/main_page.dart';
import 'package:ufo/pages/record.dart';
import 'package:ufo/pages/user_pages/register_page.dart';
import 'package:ufo/pages/welcome_page.dart';

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
