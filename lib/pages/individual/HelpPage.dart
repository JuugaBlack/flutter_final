import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('使用帮助'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ExpansionTile(
            title: const Text('如何添加账本？'),
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '要添加一个新账本，请前往“账本管理”页面，点击右上角的加号按钮。在弹出的对话框中输入账本名称，然后点击“添加”按钮。',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
          ExpansionTile(
            title: const Text('如何导入导出账单？'),
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '要导入或导出账单，请前往“账单导入导出”页面，选择相应的选项并按照提示操作。您可以导入支持的文件格式，也可以将账单导出为文件。',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
          ExpansionTile(
            title: const Text('如何设置个性化选项？'),
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '要设置个性化选项，请前往“个性化”页面。您可以更改主题颜色、字体大小等设置，并实时预览效果。',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
          ExpansionTile(
            title: const Text('如何联系我们？'),
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '如果您需要帮助或有任何问题，可以前往“联系我们”页面填写表单并提交。我们的团队会尽快与您联系。',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
          ExpansionTile(
            title: const Text('如何查看隐私政策？'),
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '要查看隐私政策，请前往“关于”页面并点击“查看隐私政策”按钮。您将看到详细的隐私政策说明。',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
