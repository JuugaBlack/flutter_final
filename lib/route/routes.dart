import 'package:flutter/material.dart';
import 'package:ufo/config/routes_config.dart';

/// 动态路由生成器，根据传入的路由设置创建并返回相应的页面路由。
var onGenerateRoute = (RouteSettings settings) {
  // 提取路由设置中的路由名称
  String? routeName = settings.name;

  // 在路由配置表`routes`中查找与路由名称对应的页面构建函数
  Function? pageFn = routes[routeName];

  // 如果找到了对应的页面构建函数
  if (pageFn != null) {
    // 判断是否有传递参数
    if (settings.arguments != null) {
      // 如果有参数，使用`MaterialPageRoute`创建一个带有参数的路由
      // 并通过`arguments`将参数传递给页面构建函数
      return MaterialPageRoute(
        builder: (context) => pageFn(context, arguments: settings.arguments),
      );
    } else {
      // 如果没有参数，直接使用页面构建函数创建路由
      return MaterialPageRoute(builder: (context) => pageFn());
    }
  }
};
