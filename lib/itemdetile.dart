import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'historyItem.dart';

// ignore: must_be_immutable
class ItemDetile extends StatefulWidget {
  ItemDetile({Key key, this.item}) : super(key: key);
  HistoryItem item;
  @override
  _ItemDetileState createState() => _ItemDetileState();
}

class _ItemDetileState extends State<ItemDetile>
    with SingleTickerProviderStateMixin {
  String currentTime = '';
  Timer t;
  TextStyle style = TextStyle(fontWeight: FontWeight.bold, fontSize: 17);
  AnimationController controller;
  Animation<double> animation;
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
    controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    animation = new Tween(begin: -40.0, end: 40.0).animate(controller)
      ..addListener(() {
        setState(() {});
        if (animation.status == AnimationStatus.completed)
          controller.reset();
        else if (animation.status == AnimationStatus.dismissed) {
          controller.forward();
        }
      });
    controller.forward();
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
          title: GestureDetector(
            onTap: qingjiaInfo,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  child: Image.asset('images/icon.png'),
                ),
                Text('请假详情', style: TextStyle(color: Colors.black))
              ],
            ),
          ),
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
            help(),
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
              child: AnimatedCrossFade(
                duration: const Duration(seconds: 1),
                firstChild: OutlineButton(
                  padding: EdgeInsets.symmetric(horizontal: 160, vertical: 10),
                  shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  child: Text(
                    '转发',
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                  onPressed: () {
                    widget.item.isFinish = !widget.item.isFinish;
                  },
                ),
                secondChild: FlatButton(
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
                  onPressed: () {
                    widget.item.isFinish = !widget.item.isFinish;
                  },
                ),
                crossFadeState: widget.item.isFinish
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget help() => widget.item.isFinish
      ? Container()
      : GestureDetector(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 4),
            color: Colors.grey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 15,
                  child: Image.asset('images/wenh.png'),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  child: Text('如何销假？', style: TextStyle(color: Colors.white)),
                ),
                Transform.rotate(
                    angle: pi / 1,
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 17,
                    ))
              ],
            ),
          ),
        );
  Widget mainTitle() {
    TextStyle textStyle = TextStyle(color: Colors.white, fontSize: 18);
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment
              .bottomCenter, // 10% of the width, so there are ten blinds.
          colors: widget.item.isFinish
              ? [
                  const Color.fromRGBO(106, 112, 127, 1),
                  const Color.fromRGBO(156, 166, 179, 1),
                ]
              : [
                  const Color.fromRGBO(16, 159, 96, 1),
                  const Color.fromRGBO(1, 223, 116, 1),
                ], // red to yellow
          tileMode: TileMode.repeated, // repeats the gradient over the canvas
        ),
      ),
      child: Stack(
        children: [
          alert(animation.value - 80),
          alert(animation.value - 160),
          alert(animation.value - 240),
          alert(animation.value),
          alert(animation.value + 80),
          alert(animation.value + 160),
          alert(animation.value + 240),
          alert(animation.value + 320),
          alert(animation.value + 400),
          alert(animation.value + 480),
          Column(
            children: [
              Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.check_circle, color: Colors.white),
                        Text('审批已通过', style: textStyle)
                      ])),
              Text(widget.item.isFinish ? "已完成" : '正在休假中',
                  style: TextStyle(color: Colors.white, fontSize: 30)),
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
              ),
            ],
          ),
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
                  margin: EdgeInsets.only(right: 50)),
              option('需要离校', widget.item.leaveSchool ? '离校' : '不离校')
            ],
          ),
          option('销假规则', widget.item.rule,
              color: Color.fromRGBO(244, 169, 38, 1)),
          option('', '查看  >', color: Colors.blue, more: true),
          option(
              '实际休假时间',
              widget.item.isFinish
                  ? '${widget.item.durationToDay(widget.item.preSetTIme)}'
                  : ' - '),
        ],
      ),
    );
  }

  Widget option(String opt, String value,
      {EdgeInsetsGeometry margin,
      Color color,
      bool more = false,
      Widget expand}) {
    return Container(
      margin: margin,
      child: Row(
        children: [
          Container(
            width: 97,
            child: Text(more ? '$opt' : '$opt:',
                style: TextStyle(color: Colors.grey, fontSize: 15)),
          ),
          Text(
            value,
            style: TextStyle(color: color),
          ),
          expand ?? Container()
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
          Text(
            '我的请假申请',
            style: style,
          ),
          option('开始时间', widget.item.timeFormat(widget.item.startTime)),
          option('结束时间', widget.item.timeFormat(widget.item.endTime)),
          option('审批流程', '共1步',
              expand: Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text('查看  >', style: TextStyle(color: Colors.blue)),
              )),
          option('紧急联系人', widget.item.contact),
          option('请假原因', widget.item.reason),
          option('发起位置', widget.item.location, color: Colors.blue),
          option('抄送人', '无'),
        ],
      ),
    );
  }

  Widget status() {
    return Container(
      margin: EdgeInsets.only(top: 13),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '审批状态',
            style: style,
          ),
          timeLine(),
          widget.item.isFinish
              ? Container(
                  decoration: BoxDecoration(
                      border: Border(
                    bottom: BorderSide(width: 1, color: Colors.grey),
                    top: BorderSide(width: 1, color: Colors.grey),
                  )),
                  child: ListTile(
                    title: Text(
                      '销假信息',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              : Container(),
          widget.item.isFinish
              ? ListTile(
                  title: Text(
                    '定位',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(widget.item.location),
                  shape: BorderDirectional(
                    top: BorderSide(width: 1, color: Colors.grey),
                    bottom: BorderSide(width: 1, color: Colors.grey),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  Widget timeLine() {
    double h = 20;
    TextStyle style = TextStyle(color: Colors.grey, fontFamily: "firacode");
    return Container(
        child: Column(
      children: [
        Row(
          children: [
            Container(
              width: h,
              height: h,
              margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              decoration: BoxDecoration(
                border: Border.all(width: 2, color: Colors.blue),
                borderRadius: BorderRadius.all(Radius.circular(h)),
              ),
            ),
            Text(
              '${widget.item.persopn} —— 发起申请',
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
              margin: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
              decoration: BoxDecoration(
                border: Border.all(width: 2, color: Colors.green),
                borderRadius: BorderRadius.all(Radius.circular(h)),
              ),
            ),
            Text(
              '一级:[辅导员]${widget.item.counselor} —— 审批',
              style: style,
            ),
            Text('通过',
                style: TextStyle(
                    color: Color.fromRGBO(46, 187, 132, 1),
                    fontWeight: FontWeight.bold)),
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
              margin: EdgeInsets.only(top: 10),
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
        ),
        widget.item.isFinish
            ? Row(
                children: [
                  Container(
                    width: h,
                    height: h,
                    margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    decoration: BoxDecoration(
                      border: Border.all(width: 2, color: Colors.blue),
                      borderRadius: BorderRadius.all(Radius.circular(h)),
                    ),
                  ),
                  Text(
                    '${widget.item.persopn} —— 销假成功',
                    style: style,
                  ),
                  Expanded(child: Container()),
                  Text('${widget.item.timeFormat(widget.item.endTime)}',
                      style: style),
                ],
              )
            : Container(),
      ],
    ));
  }

  Widget alert(double left) {
    return Positioned(
      bottom: -18,
      left: left,
      child: Container(
        child: Transform.rotate(
          angle: -pi / 8,
          child: RaisedButton(
            color: Colors.white,
            shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.circular(100)),
            onPressed: () {},
          ),
        ),
      ),
    );
  }

  void qingjiaInfo() {
    showDialog(
      context: context,
      barrierColor: Color.fromRGBO(0, 0, 0, 0.4),
      child: Stack(
        children: [
          AlertDialog(
            elevation: 0,
            content: Container(
              height: 270,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 40, bottom: 10),
                    child: Text('安全应用认证', style: TextStyle(fontSize: 22)),
                  ),
                  Text(
                    '该应用已使用https协议，最佳程度保护了用户数据隐私，请放心使用',
                    style: TextStyle(fontSize: 18),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 40),
                    child: FlatButton(
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('我知道了', style: TextStyle(fontSize: 19)),
                      color: Color.fromRGBO(36, 219, 229, 1),
                      textColor: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            left: 150,
            top: 135,
            child: Image.asset(
              'images/alertIcon.png',
              width: 100,
            ),
          ),
        ],
      ),
    );
  }
}
