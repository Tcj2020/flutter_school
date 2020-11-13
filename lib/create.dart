import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:school/Store.dart';
import 'package:school/historyItem.dart';

class Create extends StatefulWidget {
  Create({Key key}) : super(key: key);

  @override
  _CreateState createState() => _CreateState();
}

class _CreateState extends State<Create> {
  GlobalKey _formKey = new GlobalKey<FormState>();
  String startTime = '0:0:0',
      endTime = '0:0:0',
      type = '',
      reason = '',
      counselor = '',
      issue = '',
      location = '',
      contace = '',
      person = '';
  DateTime st, et;
  bool leave = true;
  @override
  void dispose() {
    super.dispose();
    _formKey = null;
  }

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
                        initialValue: Provider.of<Store>(context).person,
                        maxLength: 4,
                        onSaved: (newValue) => person = newValue,
                        decoration:
                            InputDecoration(labelText: "请假人", hintText: "请假人"),
                        // 校验用户名
                        validator: (v) {
                          return v.trim().length > 0 ? null : "请假人不能为空";
                        }),
                    TextFormField(
                        maxLength: 10,
                        onSaved: (newValue) => type = newValue,
                        decoration:
                            InputDecoration(labelText: "类型", hintText: "请假类型"),
                        // 校验用户名
                        validator: (v) {
                          return v.trim().length > 0 ? null : "类型不能为空";
                        }),
                    TextFormField(
                        maxLength: 12,
                        initialValue: Provider.of<Store>(context).phone,
                        onSaved: (newValue) => contace = newValue,
                        decoration: InputDecoration(
                            labelText: "联系人电话", hintText: "联系人电话"),
                        keyboardType: TextInputType.number,
                        validator: (v) {
                          return v.trim().length > 0 ? null : "联系人电话不能为空";
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
                            time = time.add(
                                Duration(hours: hs.hour, minutes: hs.minute));
                            setState(() {
                              startTime = time.toString();
                              st = time;
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
                            time = time.add(
                                Duration(hours: hs.hour, minutes: hs.minute));
                            setState(() {
                              endTime = time.toString();
                              et = time;
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
                        onSaved: (newValue) => reason = newValue,
                        maxLength: 10,
                        decoration:
                            InputDecoration(labelText: "原因", hintText: "请假原因"),
                        // 校验用户名
                        validator: (v) {
                          return v.trim().length > 0 ? null : "请假原因不能为空";
                        }),
                    TextFormField(
                        initialValue: Provider.of<Store>(context).counselor,
                        onSaved: (newValue) => counselor = newValue,
                        maxLength: 4,
                        decoration: InputDecoration(
                          labelText: "辅导员",
                          hintText: "辅导员",
                        ),
                        // 校验用户名
                        validator: (v) {
                          return v.trim().length > 0 ? null : "辅导员不能为空";
                        }),
                    TextFormField(
                        onSaved: (newValue) =>
                            issue = newValue == "" ? '无' : newValue,
                        maxLength: 10,
                        decoration: InputDecoration(
                            labelText: "审批意见(可选)", hintText: "审批意见")),
                    TextFormField(
                      initialValue: Provider.of<Store>(context).positon,
                      onSaved: (newValue) {
                        location = newValue;
                      },
                      maxLength: 20,
                      validator: (v) {
                        return v.trim().length > 0 ? null : "定位不能为空";
                      },
                      decoration:
                          InputDecoration(labelText: "定位", hintText: "定位"),
                    ),
                  ],
                )),
            FlatButton(
              onPressed: () {
                if (startTime != '0:0:0' &&
                    endTime != '0:0:0' &&
                    (_formKey.currentState as FormState).validate()) {
                  (_formKey.currentState as FormState).save();
                  HistoryItem item = HistoryItem(
                      startTime: st,
                      contact: contace,
                      endTime: et,
                      type: type,
                      counselor: counselor,
                      reason: reason,
                      issue: issue,
                      leaveSchool: leave,
                      persopn: person,
                      location: location,
                      actionTime:
                          "${DateTime.now().month}-${DateTime.now().day}");
                  Provider.of<Store>(context, listen: false).allDatas.add(item);
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(title: Text('保存完成')));
                  Timer(Duration(seconds: 1), () {
                    Navigator.pop(context);
                  });
                } else
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(title: Text('假条创建失败')));
                Timer(Duration(seconds: 1), () => Navigator.pop(context));
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
