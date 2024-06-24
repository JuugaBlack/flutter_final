import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../config/settings_notifier.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<SettingsNotifier>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('设置'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ListTile(
            title: const Text('通知'),
            trailing: Switch(
              value: settings.notificationsEnabled,
              onChanged: (bool value) {
                settings.setNotificationsEnabled(value);
              },
            ),
          ),
          ListTile(
            title: const Text('主题'),
            trailing: DropdownButton<ThemeMode>(
              value: settings.themeMode,
              onChanged: (ThemeMode? newValue) {
                if (newValue != null) {
                  settings.setThemeMode(newValue);
                }
              },
              items: ThemeMode.values
                  .map<DropdownMenuItem<ThemeMode>>((ThemeMode value) {
                return DropdownMenuItem<ThemeMode>(
                  value: value,
                  child: Text(value == ThemeMode.light
                      ? '浅色模式'
                      : value == ThemeMode.dark
                          ? '深色模式'
                          : '系统默认'),
                );
              }).toList(),
            ),
          ),
          ListTile(
            title: const Text('语言'),
            trailing: DropdownButton<String>(
              value: settings.locale.languageCode,
              onChanged: (String? newValue) {
                if (newValue != null) {
                  Locale newLocale;
                  switch (newValue) {
                    case 'en':
                      newLocale = const Locale('en', 'US');
                      break;
                    case 'es':
                      newLocale = const Locale('es', 'ES');
                      break;
                    case 'zh':
                    default:
                      newLocale = const Locale('zh', 'CN');
                      break;
                  }
                  settings.setLocale(newLocale);

                  // 通知应用程序重新加载
                  WidgetsBinding.instance!.addPostFrameCallback((_) {
                    Provider.of<SettingsNotifier>(context, listen: false)
                        .setLocale(newLocale);
                  });
                }
              },
              items: <String>['zh', 'en', 'es']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value == 'zh'
                      ? '简体中文'
                      : value == 'en'
                          ? 'English'
                          : 'Español'),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('设置已保存'),
                ),
              );
            },
            child: const Text('保存设置'),
          ),
        ],
      ),
    );
  }
}
