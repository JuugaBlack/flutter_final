import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lime/common/colors.dart';
import 'package:lime/models/welcome_model.dart';
import 'package:lime/pages/home_page.dart';
import 'package:lime/widgets/app_large_text.dart';
import 'package:lime/widgets/app_text.dart';
import 'package:lime/widgets/welcome_button.dart';

/// 首页欢迎界面
///
/// 展示应用的主要特点和功能，通过滑动页面了解详情，最后进入主应用界面。
class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

/// 欢迎页面的状态管理类
class _WelcomePageState extends State<WelcomePage> {
  final PageController _pageController = PageController();

  /// 欢迎页面的数据列表，包含每个页面的图标、图片、标题、子标题和描述内容
  final List<WelcomeModel> _welcomeList = [
    // 清爽的UI设计
    WelcomeModel(
      icon: FontAwesomeIcons.heart,
      image: 'assets/images/welcome_1.png',
      title: '清爽',
      subTitle: 'UI 设计',
      content: '超级干净的UI界面设计，突显出了青柠记账App小而美设计理念。',
    ),
    // 简洁的布局
    WelcomeModel(
      icon: FontAwesomeIcons.anglesDown,
      image: 'assets/images/welcome_2.png',
      title: '简洁',
      subTitle: '布局合理',
      content: '分区设计，有序合理，在空间里保持一致，禅意悠然，营造独有的温暖氛围。',
    ),
    // 无广告打扰
    WelcomeModel(
      icon: FontAwesomeIcons.check,
      image: 'assets/images/welcome_3.png',
      title: '无广告',
      subTitle: '不打扰用户',
      content: '去除广告，意味着花费更多的时间脚踏实地，而不是投资在广告上。',
    ),
  ];

  /// 初始化状态时，设置系统UI模式为沉浸式
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    super.initState();
  }

  /// 销毁状态时，恢复系统UI模式为边缘对齐
  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    _pageController.dispose();
    super.dispose();
  }

  /// 构建欢迎页面的UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        // 滚动方向为垂直
        scrollDirection: Axis.vertical,
        // 页面数量
        itemCount: _welcomeList.length,
        // 页面控制器
        controller: _pageController,
        // 构建每个页面的内容
        itemBuilder: (_, index) {
          return Container(
            // 宽度和高度填充父容器
            width: double.maxFinite,
            height: double.maxFinite,
            decoration: BoxDecoration(
              // 背景图片装饰
              image: DecorationImage(
                image: AssetImage(_welcomeList.elementAt(index).image),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              // 内容区域的边距
              margin: EdgeInsets.only(top: 150.h, left: 20.w, right: 20.w),
              child: Row(
                // 主轴方向居中对齐
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // 左侧内容区域
                  Column(
                    // 垂直方向起始对齐
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 标题
                      AppLargeText(_welcomeList.elementAt(index).title,
                          size: 30.sp),
                      // 子标题
                      AppText(_welcomeList.elementAt(index).subTitle,
                          size: 30.sp),
                      // 标题与描述之间的间隔
                      SizedBox(height: 20.h),
                      // 描述内容
                      SizedBox(
                        width: 250.w,
                        child: AppText(
                          _welcomeList.elementAt(index).content,
                          color: AppColors.textColor2,
                          size: 14.sp,
                        ),
                      ),
                      // 描述与按钮之间的间隔
                      SizedBox(height: 40.h),
                      // 操作按钮
                      WelcomeButton(
                        width: 120.w,
                        height: 50.h,
                        icon: _welcomeList.elementAt(index).icon,
                        onTab: () {
                          // 根据当前页面索引决定操作：滑动到下一页或跳转到主应用界面
                          if (index != 2) {
                            if (_pageController.hasClients) {
                              _pageController.animateToPage(
                                index + 1,
                                duration: const Duration(milliseconds: 400),
                                curve: Curves.easeInOut,
                              );
                            }
                          } else {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) => Home()));
                          }
                        },
                      ),
                    ],
                  ),
                  // 右侧导航点区域
                  Column(
                    children: List.generate(
                      _welcomeList.length,
                      (indexDots) {
                        return Container(
                          // 导航点之间的间隔
                          margin: EdgeInsets.only(bottom: 2.h),
                          // 导航点的大小
                          width: 8.w,
                          height: index == indexDots ? 25.h : 8.h,
                          decoration: BoxDecoration(
                            // 圆角矩形
                            borderRadius: BorderRadius.circular(8.r),
                            // 导航点颜色
                            color: index == indexDots
                                ? AppColors.mainColor
                                : AppColors.mainColor.withOpacity(0.3),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
