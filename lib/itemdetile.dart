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
  Timer t;
  @override
  void initState() {
    DateTime now = DateTime.now();
    setState(() {
      currentTime =
          '${now.year}-${now.month}-${now.day} ${now.hour}:${now.minute}:${now.second}';
    });
    t = Timer.periodic(Duration(seconds: 1), (asdasd) {
      DateTime now = DateTime.now();
      setState(() {
        currentTime =
            '${now.year}-${now.month}-${now.day} ${now.hour}:${now.minute}:${now.second}';
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    t.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(245, 246, 248, 1),
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
                child: Text('请假详情',
                    style: TextStyle(color: Color.fromRGBO(189, 193, 195, 1)))),
            myAcion(),
            status(),
            Container(
              margin: EdgeInsets.only(top: 30, bottom: 20),
              alignment: Alignment.center,
              child: FlatButton(
                minWidth: MediaQuery.of(context).size.width - 40,
                height: 50,
                shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                textColor: Colors.white,
                child: Text(
                  '去销假',
                  style: TextStyle(fontSize: 18),
                ),
                color: Color.fromRGBO(68, 130, 241, 1),
                onPressed: () {},
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget mainTitle() {
    TextStyle textStyle = TextStyle(color: Colors.white, fontSize: 18);
    return Container(
      color: Color.fromRGBO(28, 151, 104, 1),
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
          option('销假规则', widget.item.rule,
              color: Color.fromRGBO(244, 169, 38, 1)),
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
          option('审批流程', '共1步'),
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
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [Text('审批状态'), timeLine()],
      ),
    );
  }

  Widget timeLine() {
    double h = 25;
    TextStyle style = TextStyle(color: Colors.grey);
    return Container(
        child: Column(
      children: [
        Row(
          children: [
            Container(
              width: h,
              height: h,
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                border: Border.all(width: 2, color: Colors.blue),
                borderRadius: BorderRadius.all(Radius.circular(h)),
              ),
            ),
            Text(
              '雷玉矫 - 发起申请',
              style: style,
            ),
            Expanded(child: Container()),
            Text('${widget.item.timeFormat(widget.item.startTime)}',
                style: style),
          ],
        ),
        Row(
          children: [
            Container(
              width: h,
              height: h,
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              decoration: BoxDecoration(
                border: Border.all(width: 2, color: Colors.green),
                borderRadius: BorderRadius.all(Radius.circular(h)),
              ),
            ),
            Text(
              '雷玉矫 - 发起申请',
              style: style,
            ),
            Expanded(child: Container()),
            Text(
                '${widget.item.timeFormat(widget.item.startTime.add(Duration(hours: 3)))}',
                style: style),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width - 130,
              padding: EdgeInsets.only(top: 8, left: 10),
              height: 40,
              decoration: BoxDecoration(
                color: Color.fromRGBO(246, 247, 249, 1),
                border: Border.all(
                    width: 1, color: Color.fromRGBO(218, 221, 224, 1)),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Text('审批意见:${widget.item.issue}'),
            )
          ],
        )
      ],
    ));
  }
}
