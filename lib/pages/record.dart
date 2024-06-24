import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

class Record extends StatefulWidget {
  Record({Key? key}) : super(key: key);

  @override
  State<Record> createState() => _RecordState();
}

List<String> expenseTypes = [
  '早餐',
  '午餐',
  '晚餐',
  '出行',
  '游玩',
  '衣物',
  '教育',
  '医疗'
]; // 假设这是您的消费类型列表
String selectedExpenseType = '早餐'; // 假设初始值为'早餐'
Map<String, double> expenseTypeAmounts = {
  '早餐': 0.0,
  '午餐': 0.0,
  '晚餐': 0.0,
  '出行': 0.0,
  '游玩': 0.0,
  '衣物': 0.0,
  '教育': 0.0,
  '医疗': 0.0,
};
Map<String, double> incomeTypeAmounts = {
  '工资': 0.0,
  '奖金': 0.0,
  '利息': 0.0,
  '股票': 0.0,
  '其他收入': 0.0,
};
List<String> incomeTypes = ['工资', '奖金', '利息', '股票', '其他收入'];
String selectedIncomeType = '工资'; // 假设初始值为'工资'

class Transaction {
  String type;
  double amount;

  Transaction({required this.type, required this.amount});
}

class _RecordState extends State<Record> with TickerProviderStateMixin {
  late TabController _tabController;
  TextEditingController _expenseController = TextEditingController();
  TextEditingController _incomeController = TextEditingController();
  List<String> expenseRecords = [];
  List<String> incomeRecords = [];
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    expenseTypeAmounts.keys.forEach((type) {
      expenseTypeAmounts[type] = 0.0; // 初始化为0.0
    });
  }

  void addIncomeRecord(String type, double amount) {
    setState(() {
      incomeRecords.add('$type: $amount'); // 添加记录
      if (incomeTypeAmounts[type] != null) {
        incomeTypeAmounts[type] = incomeTypeAmounts[type]! + amount; // 更新收入类型金额
      }
    });
  }

  void addExpenseRecord(String type, double amount) {
    setState(() {
      expenseRecords.add('$type: $amount'); // 添加记录
      if (expenseTypeAmounts[type] != null) {
        expenseTypeAmounts[type] =
            expenseTypeAmounts[type]! + amount; // 更新消费类型金额
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
    _expenseController.dispose();
    _incomeController.dispose();
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
          margin: EdgeInsets.only(left: 5),
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
                fontSize: 16,
                color: HexColor('#333333'),
              ),
            ),
            Text(
              '收入',
              style: TextStyle(
                fontSize: 16,
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
            margin: const EdgeInsets.only(
              left: 35,
              right: 35,
            ),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(
                    top: 10,
                    bottom: 20,
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 44,
                            height: 65,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CircleAvatar(
                                  backgroundColor: HexColor('#F3F3F3'),
                                  child: Icon(Icons.free_breakfast,
                                      color: HexColor('#54C395')),
                                ),
                                Text('早餐')
                              ],
                            ),
                          ),
                          Container(
                            width: 44,
                            height: 65,
                            child: Column(
                              children: [
                                CircleAvatar(
                                  backgroundColor: HexColor('#F3F3F3'),
                                  child: Icon(Icons.lunch_dining,
                                      color: HexColor('#54C395')),
                                ),
                                Text('午餐')
                              ],
                            ),
                          ),
                          Container(
                            width: 44,
                            height: 65,
                            child: Column(
                              children: [
                                CircleAvatar(
                                  backgroundColor: HexColor('#F3F3F3'),
                                  child: Icon(Icons.dinner_dining,
                                      color: HexColor('#54C395')),
                                ),
                                const Text('晚餐')
                              ],
                            ),
                          ),
                          Container(
                            width: 44,
                            height: 65,
                            child: Column(
                              children: [
                                CircleAvatar(
                                  backgroundColor: HexColor('#F3F3F3'),
                                  child: Icon(Icons.tour,
                                      color: HexColor('#54C395')),
                                ),
                                Text('出行')
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
                            height: 65,
                            child: Column(
                              children: [
                                CircleAvatar(
                                  backgroundColor: HexColor('#F3F3F3'),
                                  child: Icon(Icons.gamepad,
                                      color: HexColor('#54C395')),
                                ),
                                Text('游玩')
                              ],
                            ),
                          ),
                          Container(
                            width: 44,
                            height: 65,
                            child: Column(
                              children: [
                                CircleAvatar(
                                  backgroundColor: HexColor('#F3F3F3'),
                                  child: Icon(Icons.work_sharp,
                                      color: HexColor('#54C395')),
                                ),
                                Text('衣物')
                              ],
                            ),
                          ),
                          Container(
                            width: 44,
                            height: 65,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CircleAvatar(
                                  backgroundColor: HexColor('#F3F3F3'),
                                  child: Icon(Icons.book,
                                      color: HexColor('#54C395')),
                                ),
                                Text('教育')
                              ],
                            ),
                          ),
                          Container(
                            width: 44,
                            height: 65,
                            child: Column(
                              children: [
                                CircleAvatar(
                                  backgroundColor: HexColor('#F3F3F3'),
                                  child: Icon(Icons.medical_information,
                                      color: HexColor('#54C395')),
                                ),
                                Text('医疗')
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // 下拉菜单用于选择消费类型
                DropdownButton<String>(
                  value: selectedExpenseType,
                  items: expenseTypes.map((String type) {
                    return DropdownMenuItem<String>(
                      value: type,
                      child: Text(type),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedExpenseType = newValue ?? '早餐';
                    });
                  },
                ),
                TextField(
                  controller: _expenseController,
                  decoration: InputDecoration(labelText: '输入支出金额'),
                ),
                ElevatedButton(
                  onPressed: () {
                    String? selectedType = selectedExpenseType;
                    double amount = double.parse(_expenseController.text);
                    if (selectedType != null) {
                      addExpenseRecord(selectedType, amount);
                    }
                    _expenseController.clear();
                  },
                  child: Text('确认'),
                ),

                // 添加记录列表
                Expanded(
                  child: ListView.builder(
                    itemCount: expenseRecords.length,
                    itemBuilder: (context, index) {
                      String record = expenseRecords[index];
                      String type = record.split(': ')[0];
                      double amount = double.parse(record.split(': ')[1]);

                      return Dismissible(
                        key: Key(expenseRecords[index]),
                        onDismissed: (direction) {
                          setState(() {
                            if (expenseTypeAmounts.containsKey(type)) {
                              expenseTypeAmounts[type] =
                                  (expenseTypeAmounts[type] ?? 0) - amount;
                            }

                            expenseRecords.removeAt(index);
                          });
                        },
                        background: Container(
                          color: Colors.red,
                          child: Icon(Icons.delete),
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.only(right: 20),
                        ),
                        child: ListTile(
                          title: Text(
                              '${record}    $type总金额 ${expenseTypeAmounts[type]}'),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              left: 35,
              right: 35,
            ),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(
                    top: 10,
                    bottom: 15,
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            width: 44,
                            height: 65,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CircleAvatar(
                                  backgroundColor: HexColor('#F3F3F3'),
                                  child: Icon(Icons.monetization_on,
                                      color: HexColor('#54C395')),
                                ),
                                Text('工资')
                              ],
                            ),
                          ),
                          Container(
                            width: 44,
                            height: 65,
                            child: Column(
                              children: [
                                CircleAvatar(
                                  backgroundColor: HexColor('#F3F3F3'),
                                  child: Icon(Icons.price_check,
                                      color: HexColor('#54C395')),
                                ),
                                Text('奖金')
                              ],
                            ),
                          ),
                          Container(
                            width: 44,
                            height: 65,
                            child: Column(
                              children: [
                                CircleAvatar(
                                  backgroundColor: HexColor('#F3F3F3'),
                                  child: Icon(Icons.handshake,
                                      color: HexColor('#54C395')),
                                ),
                                const Text('投资')
                              ],
                            ),
                          ),
                          Container(
                            width: 44,
                            height: 65,
                            child: Column(
                              children: [
                                CircleAvatar(
                                  backgroundColor: HexColor('#F3F3F3'),
                                  child: Icon(Icons.back_hand,
                                      color: HexColor('#54C395')),
                                ),
                                Text('利息')
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
                            height: 65,
                            child: Column(
                              children: [
                                CircleAvatar(
                                  backgroundColor: HexColor('#F3F3F3'),
                                  child: Icon(Icons.work_history,
                                      color: HexColor('#54C395')),
                                ),
                                Text('兼职')
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // 下拉菜单用于选择消费类型
                DropdownButton<String>(
                  value: selectedIncomeType,
                  items: incomeTypes.map((String type) {
                    return DropdownMenuItem<String>(
                      value: type,
                      child: Text(type),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedIncomeType = newValue ?? '工资';
                    });
                  },
                ),
                TextField(
                  controller: _incomeController,
                  decoration: InputDecoration(labelText: '输入收入金额'),
                ),

                ElevatedButton(
                  onPressed: () {
                    String? selectedType = selectedIncomeType; // 修复此处选择的类型
                    double amount = double.parse(_incomeController.text);
                    if (selectedType != null) {
                      addIncomeRecord(
                          selectedType, amount); // 使用 addIncomeRecord
                    }
                    _incomeController.clear();
                  },
                  child: Text('确认'),
                ),

                // 添加记录列表
                Expanded(
                  child: ListView.builder(
                    itemCount: incomeRecords.length,
                    itemBuilder: (context, index) {
                      String record = incomeRecords[index];
                      String type = record.split(': ')[0];
                      double amount = double.parse(record.split(': ')[1]);

                      return Dismissible(
                        key: Key(incomeRecords[index]),
                        onDismissed: (direction) {
                          setState(() {
                            if (incomeTypeAmounts.containsKey(type)) {
                              incomeTypeAmounts[type] =
                                  (incomeTypeAmounts[type] ?? 0) - amount;
                            }

                            incomeRecords.removeAt(index);
                          });
                        },
                        background: Container(
                          color: Colors.red,
                          child: Icon(Icons.delete),
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.only(right: 20),
                        ),
                        child: ListTile(
                          title: Text(
                              '${record}     $type金额 ${incomeTypeAmounts[type]}'),
                        ),
                      );
                    },
                  ),
                ),

                // 每个支出类型下显示金额
              ],
            ),
          ),
        ],
      ),
    );
  }
}
