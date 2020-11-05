import 'package:flutter/material.dart';
import 'package:school/create.dart';
import 'package:school/qingjiaList.dart';

class Qingjia extends StatefulWidget {
  Qingjia({Key key}) : super(key: key);

  @override
  _QingjiaState createState() => _QingjiaState();
}

class _QingjiaState extends State<Qingjia> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('长江大学工程技术学院', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Row(
        children: [
          FlatButton(
            color: Colors.blue,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Create(),
                  ));
            },
            child: Text('创建新假条', style: TextStyle(color: Colors.white)),
          ),
          FlatButton(
            color: Colors.blue,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QingjiaList(),
                  ));
            },
            child: Text('请假', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
