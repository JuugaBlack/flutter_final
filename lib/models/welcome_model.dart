import 'package:flutter/widgets.dart';

/// 引导页
/// `WelcomeModel` 类用于表示引导页的数据模型。
///
/// 每个`WelcomeModel`实例包含了引导页展示所需的所有信息，
/// 如图标、背景图片、标题、副标题及详细内容，以提供统一且清晰的初始化界面给用户。
///
/// 参数说明：
/// - `icon`：[IconData] 类型，表示页面的图标。
/// - `image`：[String] 类型，表示背景图片的资源路径或URL。
/// - `title`：[String] 类型，表示页面的主标题。
/// - `subTitle`：[String] 类型，表示页面的副标题。
/// - `content`：[String] 类型，表示页面的具体描述内容。
class WelcomeModel {
  IconData icon;
  String image;
  String title;
  String subTitle;
  String content;

  /// 构造函数，用于创建一个具有完整引导信息的数据模型实例。
  ///
  /// 所有参数均为必须提供，确保引导页内容的完整性。
  WelcomeModel({
    required this.icon,
    required this.image,
    required this.title,
    required this.subTitle,
    required this.content,
  });
}
