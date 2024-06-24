import 'package:flutter/material.dart';

class Individual extends StatelessWidget {
  const Individual({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // 用户信息部分
          Container(
            margin:
                const EdgeInsets.only(top: 40, left: 16, right: 16, bottom: 0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  // 用户头像
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(
                      'https://p1.ssl.qhimg.com/t016204b7be28b33e82.jpg',
                    ),
                  ),
                  const SizedBox(width: 16),
                  // 用户昵称
                  const Text(
                    '我的昵称',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          // 功能列表
          Expanded(
            child: ListView(
              children: [
                _buildListItem(
                    Icons.person, '个性化', context, '/personalization'),
                _buildListItem(
                    Icons.book, '账本管理', context, '/account_management'),
                _buildListItem(
                    Icons.import_export, '账单导入导出', context, '/import_export'),
                _buildListItem(Icons.settings, '设置', context, '/settings'),
                _buildListItem(Icons.help, '使用帮助', context, '/help'),
                _buildListItem(Icons.info, '关于', context, '/about'),
                _buildListItem(
                    Icons.contact_mail, '联系我们', context, '/contact_us'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 创建每一个列表项的小部件
  Widget _buildListItem(
      IconData icon, String title, BuildContext context, String route) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        Navigator.pushNamed(context, route); // 导航到对应页面
      },
    );
  }
}
