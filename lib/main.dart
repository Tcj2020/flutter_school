/*
 * @LastEditors: wyswill
 * @Description: 文件描述
 * @Date: 2020-11-04 10:24:26
 * @LastEditTime: 2020-11-16 10:29:35
 */
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school/Store.dart';
import 'package:school/qingjia.dart';

void main() {
  Provider.debugCheckInvalidValueType = null;
  runApp(Provider<Store>(create: (_) => Store(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Qingjia(),
    );
  }
}
