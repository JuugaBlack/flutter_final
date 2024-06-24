import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class ImportExportPage extends StatelessWidget {
  const ImportExportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('账单导入导出'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 导入账单部分
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '导入账单',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      '请选择要导入的账单文件：',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton.icon(
                      onPressed: () async {
                        FilePickerResult? result =
                            await FilePicker.platform.pickFiles(
                          type: FileType.custom,
                          allowedExtensions: ['csv', 'xls', 'xlsx'],
                        );

                        if (result != null) {
                          // 处理导入文件的逻辑
                          final file = result.files.first;
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('导入成功：${file.name}')),
                          );
                        } else {
                          // 用户取消了文件选择
                        }
                      },
                      icon: const Icon(Icons.file_upload),
                      label: const Text('选择文件'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            // 导出账单部分
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '导出账单',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      '点击下方按钮导出账单文件：',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton.icon(
                      onPressed: () {
                        // 处理导出文件的逻辑
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('账单导出成功')),
                        );
                      },
                      icon: const Icon(Icons.file_download),
                      label: const Text('导出文件'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
