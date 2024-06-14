import 'package:flutter/material.dart'; // 引入Flutter的Material库组件
import 'package:hexcolor/hexcolor.dart'; // 引入HexColor库，用于处理十六进制颜色
import 'package:flutter/services.dart'; // 引入系统服务，如设置系统UI样式
import 'nested_tabbar.dart'; // 导入自定义的NestedTabbar组件

/// `Chart` 类，表示一个展示图表的 StatefulWidget，包含顶部Tab导航和两个子视图页面。
class Chart extends StatefulWidget {
  Chart({Key? key}) : super(key: key);

  @override
  State<Chart> createState() => _ChartState(); // 创建State的实例
}

/// `_ChartState` 类，管理`Chart`的状态，包含Tab控制器和字体大小切换标志。
class _ChartState extends State<Chart> with TickerProviderStateMixin {
  // 混入TickerProviderStateMixin以提供ticker
  late TabController _tabController; // Tab控制器，用于管理TabBar的切换
  bool _fontSizeFlage = false; // 字体大小切换标志，默认关闭

  @override
  void initState() {
    super.initState();
    // 初始化TabController，长度为2，用于同步TabBar和TabBarView
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    // 清理TabController资源
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 设置系统状态栏样式
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: HexColor('#fafafa'), // 状态栏颜色
      statusBarIconBrightness: Brightness.dark, // Android状态栏图标颜色（深色）
      statusBarBrightness: Brightness.light, // iOS状态栏图标颜色（浅色）
    ));

    return Scaffold(
      appBar: AppBar(
        // 应用栏配置
        elevation: 1, // 减小阴影效果
        backgroundColor: HexColor('#fafafa'), // 应用栏背景颜色
        title: Align(
          // 居中对齐的TabBar
          alignment: Alignment.center,
          child: TabBar(
            // TabBar配置
            isScrollable: true, // 允许滚动
            controller: _tabController,
            indicatorSize: TabBarIndicatorSize.label, // 指示器大小跟随标签
            indicatorColor: HexColor('#54C395'), // 选中指示器颜色
            onTap: (index) {
              // 切换Tab时的回调
              setState(() => {_fontSizeFlage = !_fontSizeFlage}); // 切换字体大小标志状态
            },
            tabs: [
              // Tab项
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0), // 左右各添加16像素的间距
                child: Text(
                  '支出',
                  style: TextStyle(fontSize: 17, color: HexColor('#333333')),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0), // 左右各添加16像素的间距
                child: Text(
                  '收入',
                  style: TextStyle(fontSize: 17, color: HexColor('#333333')),
                ),
              ),
            ],
          ),
        ),
      ),
      body: TabBarView(
        // Tab内容视图
        physics: const NeverScrollableScrollPhysics(), // 禁止滑动
        controller: _tabController,
        children: [
          NestedTabbar(), // 第一个子页面，嵌套的TabBar
          Center(child: Text("It's rainy here")), // 第二个子页面，示例文本
        ],
      ),
    );
  }
}
