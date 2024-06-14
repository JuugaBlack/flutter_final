import 'package:flutter/material.dart';

/// `AddPage` 是一个无状态部件（StatelessWidget），
/// 用于展示一个简单的添加页面。
///
/// 页面中央显示静态文本"AddPage"，作为占位符或者简单页面提示。
class AddPage extends StatelessWidget {
  /// 构造函数，允许传入[Key]用于在 widget 树中唯一标识此部件。
  const AddPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// 此方法构建部件的UI。
    /// 返回一个常量[Center]部件，其中心对齐一个文本部件显示"AddPage"。
    return const Center(child: Text('AddPage'));
  }
}
