import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lime/route/routes.dart';
import './config/settings_notifier.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await ScreenUtil.ensureScreenSize();

  final prefs = await SharedPreferences.getInstance();
  final int? initScreen = prefs.getInt('initScreen');
  await prefs.setInt('initScreen', 1);

  runApp(
    ChangeNotifierProvider(
      create: (context) => SettingsNotifier(),
      child: MainApp(initScreen),
    ),
  );
}

class MainApp extends StatelessWidget {
  final int? initScreen;

  const MainApp(this.initScreen, {super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp(
        initialRoute: '/main',
        onGenerateRoute: onGenerateRoute,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.white,
              statusBarIconBrightness: Brightness.dark,
              statusBarBrightness: Brightness.light,
            ),
            centerTitle: true,
            elevation: 1,
            iconTheme: IconThemeData(color: Colors.black),
          ),
        ),
        darkTheme: ThemeData.dark(),
        themeMode: Provider.of<SettingsNotifier>(context).themeMode,
        locale: Provider.of<SettingsNotifier>(context).locale,
        supportedLocales: const [
          Locale('zh', 'CN'),
          Locale('en', 'US'),
          Locale('es', 'ES'),
        ],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
      ),
    );
  }
}
