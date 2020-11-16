/*
 * @LastEditors: wyswill
 * @Description: 创建假条常用信息本地配置
 * @Date: 2020-11-13 16:42:21
 * @LastEditTime: 2020-11-16 11:21:56
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school/Store.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateConfig extends StatefulWidget {
  CreateConfig({Key key}) : super(key: key);

  @override
  _CreateConfigState createState() => _CreateConfigState();
}

class _CreateConfigState extends State<CreateConfig> {
  String person, phone, counselor, positon;
  double titleSiez = 10, contentSize = 10;
  GlobalKey _formKey = new GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _formKey = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('假条常用信息配置'),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
                initialValue: Provider.of<Store>(context).person,
                maxLength: 4,
                onSaved: (newValue) => person = newValue,
                decoration: InputDecoration(labelText: "请假人"),
                validator: (v) {
                  return v.trim().length > 0 ? null : "请假人不能为空";
                }),
            TextFormField(
                maxLength: 12,
                initialValue: Provider.of<Store>(context).phone,
                onSaved: (newValue) => phone = newValue,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: "电话"),
                validator: (v) {
                  return v.trim().length > 0 ? null : "电话不能为空";
                }),
            TextFormField(
                maxLength: 4,
                initialValue: Provider.of<Store>(context).counselor,
                onSaved: (newValue) => counselor = newValue,
                decoration: InputDecoration(labelText: "辅导员"),
                validator: (v) {
                  return v.trim().length > 0 ? null : "辅导员不能为空";
                }),
            TextFormField(
                maxLength: 20,
                initialValue: Provider.of<Store>(context).positon,
                onSaved: (newValue) => positon = newValue,
                decoration: InputDecoration(labelText: "定位"),
                validator: (v) {
                  return v.trim().length > 0 ? null : "定位不能为空";
                }),
            Row(
              children: [
                Text('标题字体大小:   '),
                Text(titleSiez.round().toString()),
                Slider(
                  value: titleSiez,
                  min: 10,
                  max: 25,
                  label: titleSiez.round().toString(),
                  onChanged: (value) {
                    setState(() {
                      titleSiez = value;
                    });
                  },
                ),
              ],
            ),
            Row(
              children: [
                Text('内容字体大小:   '),
                Text(contentSize.round().toString()),
                Slider(
                  value: contentSize,
                  min: 10,
                  max: 25,
                  label: contentSize.round().toString(),
                  onChanged: (value) {
                    setState(() {
                      contentSize = value;
                    });
                  },
                ),
              ],
            ),
            FlatButton(
              child: Text('保存'),
              color: Colors.blue,
              textColor: Colors.white,
              minWidth: MediaQuery.of(context).size.width - 30,
              height: 50,
              onPressed: save,
            )
          ],
        ),
      ),
    );
  }

  void save() async {
    FormState state = _formKey.currentState;
    if (state.validate()) {
      state.save();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('person', person);
      prefs.setString('phone', phone);
      prefs.setString('counselor', counselor);
      prefs.setString('positon', positon);
      prefs.setInt('titleSiez', titleSiez.round());
      prefs.setInt('contentSiez', contentSize.round());
      Provider.of<Store>(context, listen: false).person = person;
      Provider.of<Store>(context, listen: false).phone = phone;
      Provider.of<Store>(context, listen: false).counselor = counselor;
      Provider.of<Store>(context, listen: false).positon = positon;
      Provider.of<Store>(context, listen: false).titleSize = titleSiez;
      Provider.of<Store>(context, listen: false).contentSize = contentSize;
      showDialog(
        context: context,
        child: SimpleDialog(
          title: Text('提示'),
          children: [Center(child: Text('保存成功！'))],
        ),
      );
    } else {
      showDialog(
        context: context,
        child: SimpleDialog(
          title: Text('提示'),
          children: [Center(child: Text('保存失败！'))],
        ),
      );
    }
  }
}
