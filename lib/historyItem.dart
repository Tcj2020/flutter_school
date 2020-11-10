/*
 * @LastEditors: wyswill
 * @Description: 文件描述
 * @Date: 2020-11-04 11:27:11
 * @LastEditTime: 2020-11-10 10:28:00
 */
class HistoryItem {
  Duration preSetTIme; //请假时间
  Duration execTimes; //实际休假时间
  bool statu = true; //完成状态
  bool leaveSchool = true; //是否离校
  DateTime startTime;
  DateTime endTime;
  String type; //请假类型
  String rule = '离校请假需要销假,非离校请假无需销假'; //请假规则
  String contact = '15071844961'; //紧急联系人
  String reason = ''; //请假原因
  String cc = ''; //抄送人
  //审批状态 Approval Status
  String counselor = ''; //辅导员
  bool passStatu = true; //辅导员审批通过
  String issue = ''; //审批意见
  String actionTime = ''; //提交时间
  bool isFinish;
  HistoryItem({
    String startTime,
    String endTime,
    this.statu,
    this.type,
    this.reason,
    this.cc,
    this.counselor,
    this.passStatu,
    this.issue,
    this.leaveSchool,
    this.actionTime,
    this.isFinish = false,
  }) {
    DateTime st = DateTime.parse(startTime);
    DateTime et = DateTime.parse(endTime);
    this.startTime = st;
    this.endTime = et;
    this.preSetTIme = et.difference(st);
  }
  complitExcTime(String excStartTime, String excEndTime) {
    DateTime ect = DateTime.parse(excStartTime);
    DateTime eet = DateTime.parse(excEndTime);
    this.execTimes = eet.difference(ect);
  }

  timeFormat(DateTime time) {
    String s = '0';
    if (time.day < 10)
      s += "${time.day}";
    else
      s = '${time.day}';
    return '${time.month}-${time.day} ${time.hour}:$s';
  }

  durationToDay(Duration duration) {
    int hours = duration.inHours;
    int d = (hours / 24).floor();
    int h = hours - d * 24;
    String res = '';
    if (d > 0) res += '$d天';
    if (h > 0) res += '$h小时';
    return res;
  }
}
