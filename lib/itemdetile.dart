/*
 * @LastEditors: wyswill
 * @Description: 文件描述
 * @Date: 2020-11-04 16:23:35
 * @LastEditTime: 2020-11-05 10:16:32
 */
import 'dart:async';

import 'package:flutter/material.dart';

import 'historyItem.dart';

// ignore: must_be_immutable
class ItemDetile extends StatefulWidget {
  ItemDetile({Key key, this.item}) : super(key: key);
  HistoryItem item;
  @override
  _ItemDetileState createState() => _ItemDetileState();
}

class _ItemDetileState extends State<ItemDetile> {
  String currentTime = '';
  @override
  void initState() {
    DateTime now = DateTime.now();
    setState(() {
      currentTime =
          '${now.year}-${now.month}-${now.day} ${now.hour}:${now.minute}:${now.second}';
    });
    Timer.periodic(Duration(seconds: 1), (asdasd) {
      DateTime now = DateTime.now();
      setState(() {
        currentTime =
            '${now.year}-${now.month}-${now.day} ${now.hour}:${now.minute}:${now.second}';
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text('请假详情', style: TextStyle(color: Colors.black)),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            FlatButton(
                child: Text('反馈', style: TextStyle(color: Colors.cyan)),
                onPressed: () {})
          ]),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            mainTitle(),
            info(),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text('请假详情', style: TextStyle(color: Colors.white))),
            myAcion(),
            status()
          ],
        ),
      ),
    );
  }

  Widget mainTitle() {
    TextStyle textStyle = TextStyle(color: Colors.white, fontSize: 18);
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.green, Colors.lightGreen],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          tileMode: TileMode.repeated,
        ),
      ),
      // color: Colors.grey,
      child: Column(
        children: [
          Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.check_circle, color: Colors.white),
                    Text('审批已通过', style: textStyle)
                  ])),
          Text('正在休假中', style: TextStyle(color: Colors.white, fontSize: 30)),
          Opacity(
            opacity: 0.5,
            child: Container(
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Text('当前时间:$currentTime',
                  style: TextStyle(color: Colors.white, fontSize: 13)),
            ),
          )
        ],
      ),
    );
  }

  Widget info() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              option('请假类型', widget.item.type,
                  margin: EdgeInsets.only(right: 100)),
              option('需要离校', widget.item.leaveSchool ? '离校' : '不离校')
            ],
          ),
          option('销假规则', widget.item.rule, color: Colors.orange),
          option('实际休假时间', ' - '),
        ],
      ),
    );
  }

  Widget option(String opt, String value,
      {EdgeInsetsGeometry margin, Color color}) {
    return Container(
      margin: margin,
      child: Row(
        children: [
          Text('$opt:', style: TextStyle(color: Colors.grey)),
          Text(value, style: TextStyle(color: color)),
        ],
      ),
    );
  }

  Widget myAcion() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('我的申请'),
          option('开始时间', widget.item.timeFormat(widget.item.startTime)),
          option('结束时间', widget.item.timeFormat(widget.item.endTime)),
          option('审批流程', '共一步'),
          option('紧急联系人', widget.item.contact),
          option('请假原因', widget.item.reason),
          option('发起位置', '中国湖北省荆州市荆州区G8(沪聂线)', color: Colors.blue),
          option('抄送人', '无'),
        ],
      ),
    );
  }

  Widget status() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      color: Colors.white,
      child: Column(
        children: [],
      ),
    );
  }
}
