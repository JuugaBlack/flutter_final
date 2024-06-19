import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

class Record extends StatefulWidget {
  Record({Key? key}) : super(key: key);

  @override
  State<Record> createState() => _RecordState();
}

class _RecordState extends State<Record> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

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
        leading: Container(
          margin: EdgeInsets.only(left: 16),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('日常账本'),
              Icon(Icons.expand_more),
            ],
          ),
        ),
        leadingWidth: 100,
        centerTitle: true,
        title: TabBar(
          isScrollable: true,
          controller: _tabController,
          indicatorSize: TabBarIndicatorSize.label,
          indicatorColor: HexColor('#54C395'),
          tabs: [
            Text(
              '支出',
              style: TextStyle(
                fontSize: 17,
                color: HexColor('#333333'),
              ),
            ),
            Text(
              '收入',
              style: TextStyle(
                fontSize: 17,
                color: HexColor('#333333'),
              ),
            ),
          ],
        ),
        actions: [
          InkWell(
            onTap: (() {
              Navigator.pop(context);
            }),
            child: Container(
              margin: EdgeInsets.only(right: 16),
              alignment: Alignment.center,
              child: Text('取消'),
            ),
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Container(
            margin: EdgeInsets.only(
              left: 35,
              right: 35,
            ),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                    top: 20,
                    bottom: 40,
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 44,
                            height: 66,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CircleAvatar(
                                  backgroundColor: HexColor('#F3F3F3'),
                                  child: Icon(Icons.home,
                                      color: HexColor('#54C395')),
                                ),
                                Text('早餐')
                              ],
                            ),
                          ),
                          Container(
                            width: 44,
                            height: 66,
                            child: Column(
                              children: [
                                CircleAvatar(
                                  backgroundColor: HexColor('#F3F3F3'),
                                  child: Icon(Icons.home,
                                      color: HexColor('#54C395')),
                                ),
                                Text('早餐')
                              ],
                            ),
                          ),
                          Container(
                            width: 44,
                            height: 66,
                            child: Column(
                              children: [
                                CircleAvatar(
                                  backgroundColor: HexColor('#F3F3F3'),
                                  child: Icon(Icons.home,
                                      color: HexColor('#54C395')),
                                ),
                                Text('早餐')
                              ],
                            ),
                          ),
                          Container(
                            width: 44,
                            height: 66,
                            child: Column(
                              children: [
                                CircleAvatar(
                                  backgroundColor: HexColor('#F3F3F3'),
                                  child: Icon(Icons.home,
                                      color: HexColor('#54C395')),
                                ),
                                Text('早餐')
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 44,
                            height: 66,
                            child: Column(
                              children: [
                                CircleAvatar(
                                  backgroundColor: HexColor('#F3F3F3'),
                                  child: Icon(Icons.home,
                                      color: HexColor('#54C395')),
                                ),
                                Text('早餐')
                              ],
                            ),
                          ),
                          Container(
                            width: 44,
                            height: 66,
                            child: Column(
                              children: [
                                CircleAvatar(
                                  backgroundColor: HexColor('#F3F3F3'),
                                  child: Icon(Icons.home,
                                      color: HexColor('#54C395')),
                                ),
                                Text('早餐')
                              ],
                            ),
                          ),
                          Container(
                            width: 44,
                            height: 66,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CircleAvatar(
                                  backgroundColor: HexColor('#F3F3F3'),
                                  child: Icon(Icons.home,
                                      color: HexColor('#54C395')),
                                ),
                                Text('早餐')
                              ],
                            ),
                          ),
                          Container(
                            width: 44,
                            height: 66,
                            child: Column(
                              children: [
                                CircleAvatar(
                                  backgroundColor: HexColor('#F3F3F3'),
                                  child: Icon(Icons.home,
                                      color: HexColor('#54C395')),
                                ),
                                Text('早餐')
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('账户'),
                    Text('现金'),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('上传图片'),
                      ],
                    ),
                    Text('图片'),
                  ],
                ),
              ],
            ),
          ),
          Center(
            child: Text('2'),
          ),
        ],
      ),
    );
  }
}
