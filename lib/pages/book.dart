import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Book(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Book extends StatefulWidget {
  Book({Key? key}) : super(key: key);

  @override
  State<Book> createState() => _BookState();
}

class _BookState extends State<Book> {
  List<BookItem> books = [
    BookItem(name: '日常账本1', description: '这是日常账本1的简介'),
    BookItem(name: '日常账本2', description: '这是日常账本2的简介'),
  ];

  File? bookAvatar; // 账本头像

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: HexColor('#fafafa'),
      statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
      statusBarBrightness: Brightness.light, // For iOS (dark icons)
    ));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor('#fafafa'),
        foregroundColor: HexColor('#000000'),
        elevation: 1,
        title: Text('账本'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _showAddDialog(context);
            },
          ),
          IconButton(
            icon: Icon(Icons.file_download), // Export icon
            onPressed: () {
              _exportBooks(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            for (var book in books) _buildBookCard(book),
          ],
        ),
      ),
    );
  }

  Widget _buildBookCard(BookItem book) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                _changeBookAvatar(context, book);
              },
              child: CircleAvatar(
                radius: 25,
                backgroundImage: bookAvatar != null
                    ? FileImage(bookAvatar!) as ImageProvider<Object>
                    : AssetImage('assets/default_avatar.png') as ImageProvider<Object>,
                backgroundColor: Colors.grey[200],
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(book.name, style: TextStyle(fontSize: 18)),
                  Text(
                    book.description.isNotEmpty ? book.description : '暂无简介',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _showEditDialog(context, book);
              },
              child: Text('编辑'),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddDialog(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController descController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('添加日常账本'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: '账本名称'),
            ),
            TextField(
              controller: descController,
              decoration: InputDecoration(labelText: '账本简介'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              String name = nameController.text.trim();
              String description = descController.text.trim();
              if (name.isNotEmpty) {
                setState(() {
                  books.add(BookItem(name: name, description: description));
                });
                Navigator.pop(context); // 关闭对话框
              }
            },
            child: Text('添加'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // 关闭对话框
            },
            child: Text('取消'),
          ),
        ],
      ),
    );
  }

  void _showEditDialog(BuildContext context, BookItem book) {
    TextEditingController nameController = TextEditingController(text: book.name);
    TextEditingController descController = TextEditingController(text: book.description);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('编辑账本'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: '账本名称'),
              onChanged: (value) {
                setState(() {
                  book.name = value;
                });
              },
            ),
            TextField(
              controller: descController,
              decoration: InputDecoration(labelText: '账本简介'),
              onChanged: (value) {
                setState(() {
                  book.description = value;
                });
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // 关闭对话框
            },
            child: Text('保存'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // 关闭对话框
            },
            child: Text('取消'),
          ),
        ],
      ),
    );
  }

  void _exportBooks(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('确认导出账本'),
        content: Text('您确定要导出账本吗?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // 关闭对话框
            },
            child: Text('取消'),
          ),
          TextButton(
            onPressed: () {
              // 执行实际的导出逻辑
              Navigator.pop(context); // 关闭确认对话框
              _performExport(context);
            },
            child: Text('确认'),
          ),
        ],
      ),
    );
  }

  void _performExport(BuildContext context) {
    // 在这里执行导出逻辑，比如向服务器发送请求、生成文件等操作
    // 这里只是一个示例，显示一个SnackBar表示导出中
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('正在导出中...'), // 替换为实际的导出逻辑
      ),
    );
  }

  void _changeBookAvatar(BuildContext context, BookItem book) async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        bookAvatar = File(pickedFile.path);
      });
    }
  }
}

class BookItem {
  String name;
  String description;

  BookItem({required this.name, required this.description});
}
