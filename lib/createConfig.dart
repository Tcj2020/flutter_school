/*
 * @LastEditors: wyswill
 * @Description: 创建假条常用信息本地配置
 * @Date: 2020-11-13 16:42:21
 * @LastEditTime: 2020-11-13 17:35:54
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
      body: SingleChildScrollView(
          child: FutureBuilder(
        future: _loadData(),
        builder: (context, snapshot) => Form(
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
      )),
    );
  }

  _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Provider.of<Store>(context, listen: false).person =
        prefs.getString('person');
    Provider.of<Store>(context, listen: false).phone = prefs.getString('phone');
    Provider.of<Store>(context, listen: false).counselor =
        prefs.getString('counselor');
    Provider.of<Store>(context, listen: false).positon =
        prefs.getString('positon');
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
      Provider.of<Store>(context, listen: false).person = person;
      Provider.of<Store>(context, listen: false).phone = phone;
      Provider.of<Store>(context, listen: false).counselor = counselor;
      Provider.of<Store>(context, listen: false).positon = positon;
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
