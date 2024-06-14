import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lime/common/colors.dart';
import 'package:lime/pages/nav_pages/add_page.dart';
import 'package:lime/pages/nav_pages/book_page.dart';
import 'package:lime/pages/nav_pages/chart_page.dart';
import 'package:lime/pages/nav_pages/home_page.dart';
import 'package:lime/pages/nav_pages/my_page.dart';
import 'package:lime/pages/record.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 底部 Nav 页
class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // Nav Item Pages
  final List _pages = const [
    HomePage(),
    ChartPage(),
    AddPage(),
    BookPage(),
    MyPage()
  ];

  // 当前页 Index
  int _currentIndex = 0;

  // onTap Function
  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // 屏幕尺寸及字体大小适配
    ScreenUtil.init(
      context,
      // iphone 13 尺寸
      designSize: const Size(390, 844),
      // 是否根据宽度/高度中的最小值适配文字
      minTextAdapt: true,
      // 支持分屏尺寸
      splitScreenMode: true,
    );

    return Scaffold(
      // 设置背景颜色为白色，提供简洁的视觉基础。
      backgroundColor: Colors.white,
      // 根据_currentIndex展示_pages列表中对应的页面，实现页面间的切换。
      body: _pages[_currentIndex],
      // 定义底部固定类型的导航栏，提升用户体验和导航效率。
      bottomNavigationBar: BottomNavigationBar(
        // 选择固定样式展示底部导航栏。
        type: BottomNavigationBarType.fixed,
        // 底部导航栏的背景颜色也设为白色，与整体背景统一。
        backgroundColor: Colors.white,
        // 触发页面切换的回调函数，根据点击的索引更新_currentIndex。
        onTap: _onTap,
        // 当前被选中页面的索引，用于高亮显示正确的导航项。
        currentIndex: _currentIndex,
        // 选中导航项时的颜色，使用自定义主题色。
        selectedItemColor: AppColors.mainColor,
        // 未选中导航项时的颜色，采用半透明灰色，保持视觉柔和。
        unselectedItemColor: Colors.grey.withOpacity(0.5),
        // 隐藏未选中导航项的文字标签，仅显示图标，简化界面。
        showUnselectedLabels: false,
        // 设置未被选中项的字体大小为0，进一步确保文字不显示。
        unselectedFontSize: 0,
        // 取消底部导航栏的阴影效果，保持界面的扁平和简洁风格。
        elevation: 0,
        // 定义底部导航栏的各项，包括图标和标签文本。
        items: const [
          // 第一项：明细，使用文章图标表示。
          BottomNavigationBarItem(label: '明细', icon: Icon(Icons.article)),
          // 第二项：报表，使用图表图标表示。
          BottomNavigationBarItem(label: '报表', icon: Icon(Icons.addchart)),
          // 第三项：记账，直接使用加号图标表示添加操作。
          BottomNavigationBarItem(label: '记账', icon: Icon(Icons.add)),
          // 第四项：账本，使用故事书图标象征记录与回顾。
          BottomNavigationBarItem(label: '账本', icon: Icon(Icons.auto_stories)),
          // 第五项：我的，采用人像图标代表个人中心或账户信息。
          BottomNavigationBarItem(label: '我的', icon: Icon(Icons.person)),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   elevation: 0,
      //   onPressed: () => {Navigator.of(context).push(_createRoute())},
      //   child: Icon(Icons.add),
      //   splashColor: Colors.white,
      //   backgroundColor: HexColor('#54C395'),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  // Route _createRoute() {
  //   return PageRouteBuilder(
  //     pageBuilder: (context, animation, secondaryAnimation) => Record(),
  //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
  //       const begin = Offset(0, 1);
  //       const end = Offset.zero;
  //       const curve = Curves.ease;

  //       var tween =
  //           Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

  //       return SlideTransition(
  //         position: animation.drive(tween),
  //         child: child,
  //       );
  //     },
  //   );
  // }
}
