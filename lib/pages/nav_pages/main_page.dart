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
      backgroundColor: Colors.white,
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        onTap: _onTap,
        currentIndex: _currentIndex,
        selectedItemColor: AppColors.mainColor,
        unselectedItemColor: Colors.grey.withOpacity(0.5),
        showUnselectedLabels: false,
        unselectedFontSize: 0,
        // showSelectedLabels: false,
        // selectedFontSize: 0,
        elevation: 0,
        items: const [
          BottomNavigationBarItem(label: '明细', icon: Icon(Icons.article)),
          BottomNavigationBarItem(label: '报表', icon: Icon(Icons.addchart)),
          BottomNavigationBarItem(label: '记账', icon: Icon(Icons.add)),
          BottomNavigationBarItem(label: '账本', icon: Icon(Icons.auto_stories)),
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
