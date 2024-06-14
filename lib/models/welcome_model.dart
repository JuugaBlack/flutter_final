import 'package:flutter/widgets.dart';

/// [WelcomeModel] 类用于封装引导页展示的数据模型。
/// 每个实例代表引导页面上的一个特定视图块，包括图标、背景图片、标题、副标题及详细内容描述。
class WelcomeModel {
  /// 图标数据，使用来自`font_awesome_flutter`包的`IconData`来表示。
  final IconData icon;

  /// 背景图片的资源路径，通常是项目中的资产文件路径。
  final String image;

  /// 页面的主标题，简短概括该页面的主题。
  final String title;

  /// 副标题，进一步阐述或补充主标题信息。
  final String subTitle;

  /// 内容描述，提供关于该页面更详细的信息或介绍。

  final String content;

  /// 构造函数，用于创建[WelcomeModel]实例。
  /// 所有参数均为必须参数，确保模型被正确且完整地初始化。
  WelcomeModel({
    required this.icon,
    required this.image,
    required this.title,
    required this.subTitle,
    required this.content,
  });
}
