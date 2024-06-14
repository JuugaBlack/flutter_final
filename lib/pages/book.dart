import 'package:flutter/material.dart'; // 引入Flutter的核心Material库
import 'package:hexcolor/hexcolor.dart'; // 引入HexColor插件，用于解析十六进制颜色值
import 'package:flutter/services.dart'; // 引入系统服务，如状态栏设置
import 'package:lime/main.dart'; // 导入项目的主入口或其他相关配置

/// `Book` 类，表示账本的 StatefulWidget，用于构建账本界面。
class Book extends StatefulWidget {
  Book({Key? key}) : super(key: key);

  @override
  State<Book> createState() => _BookState(); // 创建State类的实例
}

/// `_BookState` 类，继承自`State<Book>`并混入`TickerProviderStateMixin`，用于管理`Book`的界面状态和动画。
class _BookState extends State<Book> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    // 设置系统状态栏样式，如颜色和图标亮度，确保与应用界面协调一致
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: HexColor('#fafafa'), // 状态栏颜色
      statusBarIconBrightness: Brightness.dark, // Android上状态栏图标颜色（深色）
      statusBarBrightness: Brightness.light, // iOS上状态栏图标颜色（深色）
    ));

    // 构建Scaffold作为页面的基础布局
    return Scaffold(
      appBar: AppBar(
        // 应用栏配置
        backgroundColor: HexColor('#fafafa'), // 应用栏背景颜色
        foregroundColor: HexColor('#000000'), // 文本和图标的颜色
        elevation: 1, // 应用栏阴影的深度
        title: Text('账本'), // 应用栏标题
        centerTitle: true, // 标题居中显示
      ),
      body: Column(
        // 页面主体内容，垂直列表布局
        children: [
          // 第一个账本卡片
          Card(
            child: Row(
              // 卡片内部水平布局
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // 子元素在水平方向两端对齐
              children: [
                // 账本图标占位
                Container(width: 50, height: 50, color: Colors.red),
                // 账本信息
                Column(
                  children: [
                    Text('日常账本'), // 账本名称
                    Text('简介'), // 简短描述
                  ],
                ),
                // 使用状态按钮
                ElevatedButton(onPressed: () {}, child: Text('使用中')), // 点击事件未实现
              ],
            ),
          ),
          // 第二个账本卡片，结构与第一个相同
          Card(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(width: 50, height: 50, color: Colors.red),
                Column(
                  children: [
                    Text('日常账本'),
                    Text('简介'),
                  ],
                ),
                ElevatedButton(onPressed: () {}, child: Text('使用中')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
