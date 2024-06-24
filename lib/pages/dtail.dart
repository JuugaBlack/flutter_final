import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Dtail extends StatefulWidget {
  const Dtail({Key? key}) : super(key: key);

  @override
  _DtailState createState() => _DtailState();
}

class _DtailState extends State<Dtail> {
  Map<String, dynamic>? jsonData;

  @override
  void initState() {
    super.initState();
    fetchJsonData();
  }

  Future<void> fetchJsonData() async {
    try {
      final response = await http.get(Uri.parse(
          'https://raw.githubusercontent.com/aweeiii/data.json/main/data.json'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          jsonData = data;
        });
      } else {
        throw Exception('Failed to load JSON data');
      }
    } catch (e) {
      // 如果请求失败，处理错误
      print('Error: $e');
      // 也许显示一个错误消息给用户，取决于你的具体需求
    }
  }

  @override
  Widget build(BuildContext context) {
    if (jsonData == null) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final header = jsonData!['header'];
    final records = jsonData!['records'];

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: HexColor('#FAFAFA'),
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ));

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: Card(
                color: HexColor('#54C395'),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.calendar_month, color: Colors.white),
                          Text('日常账本',
                              style:
                                  TextStyle(fontSize: 25, color: Colors.white)),
                          Icon(Icons.more_horiz, color: Colors.white),
                        ],
                      ),
                    ),
                    SizedBox(height: 40),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(header['year'],
                                  style: TextStyle(
                                      fontSize: 11, color: Colors.white)),
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  Text(header['month'],
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.white)),
                                  Icon(Icons.expand_more, color: Colors.white),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 1.5,
                            height: 20,
                            child: Container(color: Colors.white),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('支出',
                                  style: TextStyle(
                                      fontSize: 11, color: Colors.white)),
                              SizedBox(height: 5),
                              Text(header['expense'],
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white)),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('收入',
                                          style: TextStyle(
                                              fontSize: 11,
                                              color: Colors.white)),
                                      SizedBox(height: 5),
                                      Text('余额',
                                          style: TextStyle(
                                              fontSize: 11,
                                              color: Colors.white)),
                                    ],
                                  ),
                                  SizedBox(width: 5),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(header['income'],
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.white)),
                                      SizedBox(height: 7),
                                      Text(header['balance'],
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.white)),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: records.length,
                itemBuilder: (context, index) {
                  final record = records[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(record['date'],
                                style: TextStyle(
                                    fontSize: 11, color: HexColor('#999999'))),
                            Row(
                              children: [
                                Text('收入：${record['income']}',
                                    style: TextStyle(
                                        fontSize: 11,
                                        color: HexColor('#999999'))),
                                SizedBox(width: 10),
                                Text('支出：${record['expense']}',
                                    style: TextStyle(
                                        fontSize: 11,
                                        color: HexColor('#999999'))),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Divider(height: 1, color: HexColor('#CCCCCC')),
                      ...record['details'].map<Widget>((detail) {
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: HexColor('#F3F3F3'),
                            child: Icon(Icons.fastfood,
                                color: HexColor('#54C395')),
                          ),
                          title: Text(detail['type'],
                              style: TextStyle(
                                  fontSize: 14, color: HexColor('#666666'))),
                          subtitle: Text(detail['items'],
                              style: TextStyle(
                                  fontSize: 11, color: HexColor('#999999'))),
                          trailing: Text(detail['amount'],
                              style: TextStyle(
                                  fontSize: 14, color: HexColor('#666666'))),
                        );
                      }).toList(),
                    ],
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
