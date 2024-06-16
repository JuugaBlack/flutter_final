import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:http/http.dart' as http;

class Incomes extends StatefulWidget {
  Incomes({Key? key}) : super(key: key);

  @override
  State<Incomes> createState() => _IncomesState();
}

class _IncomesState extends State<Incomes> with TickerProviderStateMixin {
  late TabController _tabController;
  int? touchedIndex;
  Map<String, dynamic>? jsonData;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _fetchChartData();
  }

  Future<void> _fetchChartData() async {
    final url =
        'https://raw.githubusercontent.com/JuugaBlack/data_for_flutter/main/incomes.json';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        setState(() {
          jsonData = json.decode(response.body);
        });
      } else {
        throw Exception('Failed to load JSON data');
      }
    } catch (e) {
      print('Error loading JSON: $e');
    }
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (jsonData == null) {
      return Center(child: CircularProgressIndicator());
    }

    List<String> weeks = List<String>.from(jsonData!['weeks']);
    Map<String, dynamic> statistics = jsonData!['statistics'];
    List<dynamic> pieChartData = jsonData!['pieChartData'];
    List<dynamic> incomeSources = jsonData!['incomeSources'];

    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 15),
            child: TabBar(
              isScrollable: true,
              padding: EdgeInsets.zero,
              indicatorPadding: EdgeInsets.only(bottom: 2),
              labelPadding: EdgeInsets.symmetric(horizontal: 0),
              indicator: BoxDecoration(
                color: HexColor('#54C395'),
                borderRadius: BorderRadius.circular(45),
                border: Border.all(width: 0, color: HexColor('#A1A2A9')),
              ),
              unselectedLabelColor: Colors.black,
              indicatorSize: TabBarIndicatorSize.label,
              labelColor: Colors.white,
              controller: _tabController,
              tabs: [
                Container(
                  width: 90,
                  height: 23,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(45),
                    border: Border.all(width: 1, color: HexColor('#A1A2A9')),
                  ),
                  child: Text('周'),
                ),
                Container(
                  width: 90,
                  height: 23,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(45),
                    border: Border.all(width: 1, color: HexColor('#A1A2A9')),
                  ),
                  child: Text('月'),
                ),
                Container(
                  width: 90,
                  height: 23,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(45),
                    border: Border.all(width: 1, color: HexColor('#A1A2A9')),
                  ),
                  child: Text('年'),
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _tabController,
              children: [
                _buildWeeklyData(
                    weeks, statistics, pieChartData, incomeSources),
                _buildMonthlyData(
                    weeks, statistics, pieChartData, incomeSources),
                _buildYearlyData(
                    weeks, statistics, pieChartData, incomeSources),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeeklyData(List<String> weeks, Map<String, dynamic> statistics,
      List<dynamic> pieChartData, List<dynamic> incomeSources) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          height: 27,
          alignment: Alignment.center,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: weeks.map((week) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  week,
                  style: TextStyle(color: HexColor('#999999'), fontSize: 11),
                ),
              );
            }).toList(),
          ),
        ),
        Divider(),
        Expanded(
          child: ListView(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '总支出：${statistics['totalExpenditure']}',
                          style: TextStyle(
                              color: HexColor('#000000'), fontSize: 11),
                        ),
                        SizedBox(height: 5),
                        Text(
                          '平均支出(天)：${statistics['averageIncomePerDay']}',
                          style: TextStyle(
                              color: HexColor('#000000'), fontSize: 11),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '总收入：${statistics['totalIncome']}',
                          style: TextStyle(
                              color: HexColor('#000000'), fontSize: 11),
                        ),
                        SizedBox(height: 5),
                        Text(
                          '结余：${statistics['balance']}',
                          style: TextStyle(
                              color: HexColor('#000000'), fontSize: 11),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              AspectRatio(
                aspectRatio: 1.3,
                child: Card(
                  elevation: 0,
                  color: Color(0xfffafafa),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: PieChart(
                      PieChartData(
                        pieTouchData: PieTouchData(touchCallback:
                            (FlTouchEvent event, pieTouchResponse) {
                          setState(() {
                            if (!event.isInterestedForInteractions ||
                                pieTouchResponse == null ||
                                pieTouchResponse.touchedSection == null) {
                              touchedIndex = -1;
                              return;
                            }
                            touchedIndex = pieTouchResponse
                                .touchedSection!.touchedSectionIndex;
                          });
                        }),
                        borderData: FlBorderData(
                          show: false,
                        ),
                        sectionsSpace: 0,
                        centerSpaceRadius: 0,
                        sections: showingSections(pieChartData),
                      ),
                    ),
                  ),
                ),
              ),
              Column(
                children: incomeSources.map((income) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: HexColor('#F3F3F3'),
                      child: Icon(Icons.home, color: HexColor('#54C395')),
                    ),
                    title: Text(
                      income['description'],
                      style:
                          TextStyle(fontSize: 14, color: HexColor('#666666')),
                    ),
                    trailing: Text(
                      income['amount'],
                      style:
                          TextStyle(fontSize: 12, color: HexColor('#54C395')),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMonthlyData(List<String> weeks, Map<String, dynamic> statistics,
      List<dynamic> pieChartData, List<dynamic> incomeSources) {
    return Column(
      children: [
        Container(
          height: 27,
          alignment: Alignment.center,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: weeks.map((week) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  week,
                  style: TextStyle(color: HexColor('#999999'), fontSize: 11),
                ),
              );
            }).toList(),
          ),
        ),
        Divider(),
        Expanded(
          child: ListView(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '总支出：${statistics['totalExpenditure']}',
                          style: TextStyle(
                              color: HexColor('#000000'), fontSize: 11),
                        ),
                        SizedBox(height: 5),
                        Text(
                          '平均支出(天)：${statistics['averageIncomePerDay']}',
                          style: TextStyle(
                              color: HexColor('#000000'), fontSize: 11),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '总收入：${statistics['totalIncome']}',
                          style: TextStyle(
                              color: HexColor('#000000'), fontSize: 11),
                        ),
                        SizedBox(height: 5),
                        Text(
                          '结余：${statistics['balance']}',
                          style: TextStyle(
                              color: HexColor('#000000'), fontSize: 11),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              AspectRatio(
                aspectRatio: 1.3,
                child: Card(
                  elevation: 0,
                  color: Color(0xfffafafa),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: PieChart(
                      PieChartData(
                        pieTouchData: PieTouchData(touchCallback:
                            (FlTouchEvent event, pieTouchResponse) {
                          setState(() {
                            if (!event.isInterestedForInteractions ||
                                pieTouchResponse == null ||
                                pieTouchResponse.touchedSection == null) {
                              touchedIndex = -1;
                              return;
                            }
                            touchedIndex = pieTouchResponse
                                .touchedSection!.touchedSectionIndex;
                          });
                        }),
                        borderData: FlBorderData(
                          show: false,
                        ),
                        sectionsSpace: 0,
                        centerSpaceRadius: 0,
                        sections: showingSections(pieChartData),
                      ),
                    ),
                  ),
                ),
              ),
              Column(
                children: incomeSources.map((income) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: HexColor('#F3F3F3'),
                      child: Icon(Icons.home, color: HexColor('#54C395')),
                    ),
                    title: Text(
                      income['description'],
                      style:
                          TextStyle(fontSize: 14, color: HexColor('#666666')),
                    ),
                    trailing: Text(
                      income['amount'],
                      style:
                          TextStyle(fontSize: 12, color: HexColor('#54C395')),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildYearlyData(List<String> weeks, Map<String, dynamic> statistics,
      List<dynamic> pieChartData, List<dynamic> incomeSources) {
    return Column(
      children: [
        Container(
          height: 27,
          alignment: Alignment.center,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: weeks.map((week) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  week,
                  style: TextStyle(color: HexColor('#999999'), fontSize: 11),
                ),
              );
            }).toList(),
          ),
        ),
        Divider(),
        Expanded(
          child: ListView(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '总支出：${statistics['totalExpenditure']}',
                          style: TextStyle(
                              color: HexColor('#000000'), fontSize: 11),
                        ),
                        SizedBox(height: 5),
                        Text(
                          '平均支出(天)：${statistics['averageIncomePerDay']}',
                          style: TextStyle(
                              color: HexColor('#000000'), fontSize: 11),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '总收入：${statistics['totalIncome']}',
                          style: TextStyle(
                              color: HexColor('#000000'), fontSize: 11),
                        ),
                        SizedBox(height: 5),
                        Text(
                          '结余：${statistics['balance']}',
                          style: TextStyle(
                              color: HexColor('#000000'), fontSize: 11),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              AspectRatio(
                aspectRatio: 1.3,
                child: Card(
                  elevation: 0,
                  color: Color(0xfffafafa),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: PieChart(
                      PieChartData(
                        pieTouchData: PieTouchData(touchCallback:
                            (FlTouchEvent event, pieTouchResponse) {
                          setState(() {
                            if (!event.isInterestedForInteractions ||
                                pieTouchResponse == null ||
                                pieTouchResponse.touchedSection == null) {
                              touchedIndex = -1;
                              return;
                            }
                            touchedIndex = pieTouchResponse
                                .touchedSection!.touchedSectionIndex;
                          });
                        }),
                        borderData: FlBorderData(
                          show: false,
                        ),
                        sectionsSpace: 0,
                        centerSpaceRadius: 0,
                        sections: showingSections(pieChartData),
                      ),
                    ),
                  ),
                ),
              ),
              Column(
                children: incomeSources.map((income) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: HexColor('#F3F3F3'),
                      child: Icon(Icons.home, color: HexColor('#54C395')),
                    ),
                    title: Text(
                      income['description'],
                      style:
                          TextStyle(fontSize: 14, color: HexColor('#666666')),
                    ),
                    trailing: Text(
                      income['amount'],
                      style:
                          TextStyle(fontSize: 12, color: HexColor('#54C395')),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  List<PieChartSectionData> showingSections(List<dynamic> pieChartData) {
    return pieChartData.asMap().entries.map((entry) {
      int i = entry.key;
      var pieData = entry.value;

      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 25.0 : 16.0;
      final double radius = isTouched ? 60.0 : 50.0;

      return PieChartSectionData(
        color: HexColor(pieData['color']),
        value: pieData['value'].toDouble(),
        title: pieData['title'],
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: const Color(0xffffffff),
        ),
      );
    }).toList();
  }
}
