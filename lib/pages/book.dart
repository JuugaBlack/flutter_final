import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/services.dart';
import 'package:lime/main.dart';

class Book extends StatefulWidget {
  Book({Key? key}) : super(key: key);

  @override
  State<Book> createState() => _BookState();
}

class _BookState extends State<Book> with TickerProviderStateMixin {
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
        actions: [Text('导出账本')],
      ),
      body: Column(
        children: [
          Card(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 50,
                  height: 50,
                  color: Colors.red,
                ),
                Column(
                  children: [
                    Text('日常账本'),
                    Text('简介'),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('使用中'),
                ),
              ],
            ),
          ),
          Card(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 50,
                  height: 50,
                  color: Colors.red,
                ),
                Column(
                  children: [
                    Text('日常账本'),
                    Text('简介'),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('使用中'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
