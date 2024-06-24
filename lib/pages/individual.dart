import 'package:flutter/material.dart';

class Individual extends StatelessWidget {
  const Individual({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // 用户信息部分
          Container(
            margin: const EdgeInsets.only(
                top: 40, left: 0, right: 16, bottom: 0), // 设置 margin
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  // 用户头像
                  CircleAvatar(
                    radius: 40,
                    backgroundImage:
                        AssetImage('../../assets/images/user_avatar.png'),
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
                _buildListItem(Icons.person, '个性化', context),
                _buildListItem(Icons.book, '账本管理', context),
                _buildListItem(Icons.import_export, '账单导入导出', context),
                _buildListItem(Icons.settings, '设置', context),
                _buildListItem(Icons.help, '使用帮助', context),
                _buildListItem(Icons.info, '关于', context),
                _buildListItem(Icons.contact_mail, '联系我们', context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 创建每一个列表项的小部件
  Widget _buildListItem(IconData icon, String title, BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        print('点击了$title');
      },
    );
  }
}
