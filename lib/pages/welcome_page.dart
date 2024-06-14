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

/// 引导页
class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final PageController _pageController = PageController();

  /// 页面数据
  final List<WelcomeModel> _welcomeList = [
    WelcomeModel(
      icon: FontAwesomeIcons.heart,
      image: 'assets/images/welcome_1.png',
      title: '清爽',
      subTitle: 'UI 设计',
      content: '超级干净的UI界面设计，突显出了青柠记账App小而美设计理念。',
    ),
    WelcomeModel(
      icon: FontAwesomeIcons.anglesDown,
      image: 'assets/images/welcome_2.png',
      title: '简洁',
      subTitle: '布局合理',
      content: '分区设计，有序合理，在空间里保持一致，禅意悠然，营造独有的温暖氛围。',
    ),
    WelcomeModel(
      icon: FontAwesomeIcons.check,
      image: 'assets/images/welcome_3.png',
      title: '无广告',
      subTitle: '不打扰用户',
      content: '去除广告，意味着花费更多的时间脚踏实地，而不是投资在广告上。',
    ),
  ];

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: _welcomeList.length,
        controller: _pageController,
        itemBuilder: (_, index) {
          return Container(
            width: double.maxFinite,
            height: double.maxFinite,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(_welcomeList.elementAt(index).image),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              margin: EdgeInsets.only(top: 150.h, left: 20.w, right: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppLargeText(_welcomeList.elementAt(index).title, size: 30.sp),
                      AppText(_welcomeList.elementAt(index).subTitle, size: 30.sp),
                      SizedBox(height: 20.h),
                      SizedBox(
                        width: 250.w,
                        child: AppText(
                          _welcomeList.elementAt(index).content,
                          color: AppColors.textColor2,
                          size: 14.sp,
                        ),
                      ),
                      SizedBox(height: 40.h),
                      WelcomeButton(
                        width: 120.w,
                        height: 50.h,
                        icon: _welcomeList.elementAt(index).icon,
                        onTab: () {
                          if (index != 2) {
                            // 第一页和第二页点击跳转到下一页
                            if (_pageController.hasClients) {
                              _pageController.animateToPage(
                                index + 1,
                                duration: const Duration(milliseconds: 400),
                                curve: Curves.easeInOut,
                              );
                            }
                          } else {
                            // 引导页第三页按钮跳转到主页
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) => Home()));
                          }
                        },
                      ),
                    ],
                  ),
                  Column(
                    children: List.generate(
                      _welcomeList.length,
                      (indexDots) {
                        return Container(
                          margin: EdgeInsets.only(bottom: 2.h),
                          width: 8.w,
                          height: index == indexDots ? 25.h : 8.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
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
