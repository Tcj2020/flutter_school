/*
 * @LastEditors: wyswill
 * @Description: 文件描述
 * @Date: 2020-11-04 15:12:57
 * @LastEditTime: 2020-11-13 17:32:48
 */
import 'package:flutter/material.dart';
import 'package:school/historyItem.dart';

class Store with ChangeNotifier {
  List<HistoryItem> allDatas = [];
  String person = '', phone = '', counselor = '', positon = '';
}
