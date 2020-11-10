import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school/Store.dart';
import 'package:school/historyItem.dart';

class Create extends StatefulWidget {
  Create({Key key}) : super(key: key);

  @override
  _CreateState createState() => _CreateState();
}

class _CreateState extends State<Create> {
  TextEditingController _typeColl = new TextEditingController();
  TextEditingController _reason = new TextEditingController();
  TextEditingController _counselor = new TextEditingController();
  TextEditingController _issue = new TextEditingController();
  GlobalKey _formKey = new GlobalKey<FormState>();
  String startTime = '0:0:0';
  String endTime = '0:0:0';
  bool leave = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('创建新假条'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                        controller: _typeColl,
                        decoration:
                            InputDecoration(labelText: "类型", hintText: "请假类型"),
                        // 校验用户名
                        validator: (v) {
                          return v.trim().length > 0 ? null : "类型不能为空";
                        }),
                    Row(
                      children: [
                        OutlineButton(
                          child: Text('选择请假开始时间'),
                          onPressed: () async {
                            DateTime time = await showDatePicker(
                              context: context,
                              initialDate: new DateTime.now(),
                              firstDate: new DateTime.now()
                                  .subtract(new Duration(days: 30)), // 减 30 天
                              lastDate: new DateTime.now()
                                  .add(new Duration(days: 30)), // 加 30 天
                            );
                            TimeOfDay hs = await showTimePicker(
                                context: context, initialTime: TimeOfDay.now());
                            String timeStr = time.toString().split(' ')[0];

                            setState(() {
                              String m = '';
                              if (hs.minute < 10)
                                m = '0${hs.minute}';
                              else
                                m = hs.minute.toString();
                              startTime = "$timeStr ${hs.hour}:$m:00";
                            });
                          },
                        ),
                        Text(this.startTime)
                      ],
                    ),
                    Row(
                      children: [
                        OutlineButton(
                          child: Text('选择请假结束时间'),
                          onPressed: () async {
                            DateTime time = await showDatePicker(
                              context: context,
                              initialDate: new DateTime.now(),
                              firstDate: new DateTime.now()
                                  .subtract(new Duration(days: 30)), // 减 30 天
                              lastDate: new DateTime.now()
                                  .add(new Duration(days: 30)), // 加 30 天
                            );
                            TimeOfDay hs = await showTimePicker(
                                context: context, initialTime: TimeOfDay.now());
                            String timeStr = time.toString().split(' ')[0];

                            setState(() {
                              String m = '';
                              if (hs.minute < 10)
                                m = '0${hs.minute}';
                              else
                                m = hs.minute.toString();
                              endTime = "$timeStr ${hs.hour}:$m:00";
                            });
                          },
                        ),
                        Text(this.endTime)
                      ],
                    ),
                    Row(children: [
                      Text('是否离校'),
                      Switch(
                          value: leave,
                          onChanged: (vale) {
                            setState(() {
                              leave = vale;
                            });
                          })
                    ]),
                    TextFormField(
                        controller: _reason,
                        decoration:
                            InputDecoration(labelText: "原因", hintText: "请假原因"),
                        // 校验用户名
                        validator: (v) {
                          return v.trim().length > 0 ? null : "请假原因不能为空";
                        }),
                    TextFormField(
                        controller: _counselor,
                        decoration:
                            InputDecoration(labelText: "辅导员", hintText: "辅导员"),
                        // 校验用户名
                        validator: (v) {
                          return v.trim().length > 0 ? null : "辅导员不能为空";
                        }),
                    TextFormField(
                        controller: _issue,
                        decoration: InputDecoration(
                            labelText: "审批意见", hintText: "审批意见"))
                  ],
                )),
            FlatButton(
              onPressed: () {
                if (startTime != '0:0:0' &&
                    endTime != '0:0:0' &&
                    (_formKey.currentState as FormState).validate()) {
                  HistoryItem item = HistoryItem(
                      startTime: startTime,
                      endTime: endTime,
                      type: _typeColl.text,
                      counselor: _counselor.text,
                      reason: _reason.text,
                      issue: _issue.text,
                      leaveSchool: leave,
                      actionTime:
                          "${DateTime.now().month}-${DateTime.now().day}");
                  Provider.of<Store>(context, listen: false).allDatas.add(item);
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(title: Text('保存完成')));
                  Timer(Duration(seconds: 1), () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  });
                } else
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(title: Text('保存完成')));
              },
              child: Text('保存'),
              color: Colors.orange,
            )
          ],
        ),
      ),
    );
  }
}
