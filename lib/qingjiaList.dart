/*
 * @LastEditors: wyswill
 * @Description: 文件描述
 * @Date: 2020-11-04 11:08:19
 * @LastEditTime: 2020-11-13 11:37:40
 */
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
            listItems(Provider.of<Store>(context).allDatas[index], index),
      ),
    );
  }

  Widget listItems(HistoryItem item, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ItemDetile(item: item)));
      },
      onLongPress: () {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text('提示'),
            content: Text('是否确定删除假条？一旦删除无法恢复！！'),
            actions: [
              TextButton(
                  onPressed: () {
                    Provider.of<Store>(context, listen: false)
                        .allDatas
                        .removeAt(index);
                    Navigator.pop(context);
                    setState(() {});
                  },
                  child: Text('确定删除', style: TextStyle(color: Colors.red))),
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('取消删除', style: TextStyle(color: Colors.green))),
            ],
          ),
        );
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
