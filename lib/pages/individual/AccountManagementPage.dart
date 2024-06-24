import 'package:flutter/material.dart';

class AccountManagementPage extends StatefulWidget {
  const AccountManagementPage({super.key});

  @override
  _AccountManagementPageState createState() => _AccountManagementPageState();
}

class _AccountManagementPageState extends State<AccountManagementPage> {
  final List<String> _accounts = ['账本1', '账本2', '账本3'];

  void _addAccount() {
    showDialog(
      context: context,
      builder: (context) {
        String newAccount = '';
        return AlertDialog(
          title: const Text('添加新账本'),
          content: TextField(
            onChanged: (value) {
              newAccount = value;
            },
            decoration: const InputDecoration(hintText: '请输入账本名称'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('取消'),
            ),
            TextButton(
              onPressed: () {
                if (newAccount.isNotEmpty) {
                  setState(() {
                    _accounts.add(newAccount);
                  });
                  Navigator.of(context).pop();
                }
              },
              child: const Text('添加'),
            ),
          ],
        );
      },
    );
  }

  void _editAccount(int index) {
    showDialog(
      context: context,
      builder: (context) {
        String updatedAccount = _accounts[index];
        return AlertDialog(
          title: const Text('编辑账本'),
          content: TextField(
            onChanged: (value) {
              updatedAccount = value;
            },
            controller: TextEditingController(text: _accounts[index]),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('取消'),
            ),
            TextButton(
              onPressed: () {
                if (updatedAccount.isNotEmpty) {
                  setState(() {
                    _accounts[index] = updatedAccount;
                  });
                  Navigator.of(context).pop();
                }
              },
              child: const Text('保存'),
            ),
          ],
        );
      },
    );
  }

  void _deleteAccount(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('删除账本'),
          content: const Text('确定要删除这个账本吗？'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('取消'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _accounts.removeAt(index);
                });
                Navigator.of(context).pop();
              },
              child: const Text('删除'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('账本管理'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _addAccount,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _accounts.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_accounts[index]),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => _editAccount(index),
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => _deleteAccount(index),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
