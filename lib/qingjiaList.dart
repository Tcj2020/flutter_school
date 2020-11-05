import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school/Store.dart';
import 'package:school/historyItem.dart';
import 'package:school/itemdetile.dart';

class QingjiaList extends StatefulWidget {
  QingjiaList({Key key}) : super(key: key);

  @override
  _QingjiaListState createState() => _QingjiaListState();
}

class _QingjiaListState extends State<QingjiaList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white,
            centerTitle: true,
            title: Text('请假', style: TextStyle(color: Colors.black)),
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
        body: ListView.builder(
            itemCount: Provider.of<Store>(context).allDatas.length,
            itemBuilder: (context, int index) =>
                listItems(Provider.of<Store>(context).allDatas[index])));
  }

  Widget listItems(HistoryItem item) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ItemDetile(item: item)));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 7),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("我的 ${item.type}申请",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Text('${item.actionTime}',
                      style: TextStyle(color: Colors.grey))
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 7),
              child: Text(
                '请假时间 : ${item.timeFormat(item.startTime)} ~ ${item.timeFormat(item.endTime)} (共${item.durationToDay(item.preSetTIme)})',
                style: TextStyle(color: Colors.grey),
              ),
            )
          ],
        ),
      ),
    );
  }
}
