/*
 * @LastEditors: wyswill
 * @Description: 文件描述
 * @Date: 2020-11-04 15:12:57
 * @LastEditTime: 2020-11-16 11:21:24
 */
import 'package:flutter/material.dart';
import 'package:school/historyItem.dart';

class Store with ChangeNotifier {
  List<HistoryItem> allDatas = [];
  String person = '', phone = '', counselor = '', positon = '';
  double titleSize = 0, contentSize = 0;
}
