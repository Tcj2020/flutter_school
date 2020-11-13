/*
 * @LastEditors: wyswill
 * @Description: 文件描述
 * @Date: 2020-11-04 10:59:12
 * @LastEditTime: 2020-11-13 16:44:21
 */
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:school/create.dart';
import 'package:school/createConfig.dart';
import 'package:school/qingjiaList.dart';

class Qingjia extends StatefulWidget {
  Qingjia({Key key}) : super(key: key);

  @override
  _QingjiaState createState() => _QingjiaState();
}

class _QingjiaState extends State<Qingjia> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), () {
      showDialog(
        barrierDismissible: false,
        context: context,
        child: AlertDialog(
          title: Text("警告！！！", style: TextStyle(color: Colors.red)),
          content: Container(
            height: 200,
            child: Column(
              children: [
                Text(
                  '此app仅为紧急需求时使用，使用此app的任何责任将由使用者承担！！',
                  style: TextStyle(color: Colors.red),
                ),
                Text(
                  '道路千万条，安全第一条！',
                  style: TextStyle(color: Colors.red),
                ),
                Text(
                  '使用不规范，亲人两行泪！',
                  style: TextStyle(color: Colors.red),
                ),
              ],
            ),
          ),
          actions: [
            FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("我已知晓风险，谨慎使用！"),
              color: Colors.red,
            )
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('长江大学工程技术学院', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Row(
        children: [
          FlatButton(
            color: Colors.green,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreateConfig(),
                ),
              );
            },
            child: Text('假条常用信息配置', style: TextStyle(color: Colors.white)),
          ),
          FlatButton(
            color: Colors.blue,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Create(),
                  ));
            },
            child: Text('创建新假条', style: TextStyle(color: Colors.white)),
          ),
          FlatButton(
            color: Colors.purple,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => QingjiaList(),
                ),
              );
            },
            child: Text('假条列表', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
