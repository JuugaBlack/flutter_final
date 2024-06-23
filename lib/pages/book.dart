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
    // 设置状态栏样式
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: HexColor('#fafafa'),
      statusBarIconBrightness: Brightness.dark, // 对于Android（深色图标）
      statusBarBrightness: Brightness.light, // 对于iOS（深色图标）
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
            icon: Icon(Icons.add), // 添加图标
            onPressed: () {
              _showAddDialog(context);
            },
          ),
          IconButton(
            icon: Icon(Icons.file_download), // 导出图标
            onPressed: () {
              _exportBooks(context);
            },
          ),
          IconButton(
            icon: Icon(Icons.sort), // 排序图标
            onPressed: () {
              _showSortDialog(context);
            },
          ),
          IconButton(
            icon: Icon(Icons.search), // 搜索图标
            onPressed: () {
              showSearch(context: context, delegate: BookSearchDelegate(books));
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

  // 构建账本卡片
  Widget _buildBookCard(BookItem book) {
    return Card(
      margin: EdgeInsets.all(10),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AccountingDetailPage(book: book),
            ),
          );
        },
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
                  // backgroundImage: bookAvatar != null
                  //     ? FileImage(bookAvatar!) as ImageProvider<Object>
                  //     : AssetImage('assets/default_avatar.png')
                  //         as ImageProvider<Object>,
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
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _showEditDialog(context, book);
                    },
                    child: Text('编辑'),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      _deleteBook(book);
                    },
                    child: Text('删除'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 显示添加账本的对话框
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

  // 显示编辑账本的对话框
  void _showEditDialog(BuildContext context, BookItem book) {
    TextEditingController nameController =
        TextEditingController(text: book.name);
    TextEditingController descController =
        TextEditingController(text: book.description);

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

  // 导出账本
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
              Navigator.pop(context); // 关闭确认对话框
              _performExport(context);
            },
            child: Text('确认'),
          ),
        ],
      ),
    );
  }

  // 执行导出逻辑
  void _performExport(BuildContext context) {
    // 显示一个SnackBar表示导出中
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('正在导出中...'),
      ),
    );
  }

  // 更改账本头像
  void _changeBookAvatar(BuildContext context, BookItem book) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        bookAvatar = File(pickedFile.path);
      });
    }
  }

  // 删除账本
  void _deleteBook(BookItem book) {
    setState(() {
      books.remove(book);
    });
  }

  // 显示排序对话框
  void _showSortDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('选择排序方式'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text('按名称升序'),
              onTap: () {
                _sortBooksByName(true);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('按名称降序'),
              onTap: () {
                _sortBooksByName(false);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  // 按名称排序账本
  void _sortBooksByName(bool ascending) {
    setState(() {
      if (ascending) {
        books.sort((a, b) => a.name.compareTo(b.name));
      } else {
        books.sort((a, b) => b.name.compareTo(a.name));
      }
    });
  }
}

class BookItem {
  String name;
  String description;
  List<String> accountingData; // 记账数据

  BookItem(
      {required this.name,
      required this.description,
      this.accountingData = const []});
}

// 搜索账本的代理类
class BookSearchDelegate extends SearchDelegate<BookItem> {
  final List<BookItem> books;

  BookSearchDelegate(this.books);

  @override
  String get searchFieldLabel => '搜索'; // 设置提示文字

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<BookItem> searchResults = books
        .where((book) => book.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return _buildBookList(searchResults);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<BookItem> suggestions = books
        .where((book) => book.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return _buildBookList(suggestions);
  }

  // 构建搜索结果或建议列表
  Widget _buildBookList(List<BookItem> books) {
    return ListView.builder(
      itemCount: books.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(books[index].name),
          subtitle: Text(books[index].description),
          onTap: () {
            close(context, books[index]);
          },
        );
      },
    );
  }
}

// 账本详情页面
class BookDetailPage extends StatelessWidget {
  final BookItem book;

  BookDetailPage({required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book.name),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              book.name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              book.description.isNotEmpty ? book.description : '暂无简介',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

class AccountingDetailPage extends StatelessWidget {
  final BookItem book;

  AccountingDetailPage({required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${book.name} - 记账详情'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '记账数据:',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: book.accountingData.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(book.accountingData[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
