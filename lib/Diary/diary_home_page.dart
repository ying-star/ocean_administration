import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ocean_administration/Diary/text_expend.dart';

class DiaryHome extends StatefulWidget {
  @override
  _DiaryHomeState createState() => _DiaryHomeState();
}

class _DiaryHomeState extends State<DiaryHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('日志'),
        actions: [
          IconButton(icon: Icon(Icons.add), onPressed: (){}),
        ],
      ),
      body: Container(
        child: ListView(
          children: [
            DiaryTile('这个模块只在APP上有，web端不需要，类似一个有标准格式的记事本，用于记录日常。这个模块只在APP上有，web端不需要，类似一个有标准格式的记事本，用于记录日常。'),
          ],
        ),
      ),
    );
  }
}

Widget DiaryTile (String data){

return Container(
  margin: EdgeInsets.all(10),
  padding: EdgeInsets.all(15),
  decoration: BoxDecoration(
    color: Colors.blue[100],
    borderRadius: BorderRadius.all(Radius.circular(15))
  ),
  child:   Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        padding: EdgeInsets.all(5),
        width: ScreenUtil().setWidth(600),
        child: TextLimitDisplay(
          text: data,
          textStyle: TextStyle(fontSize: ScreenUtil().setSp(20)),
          shrinkText: '展开',
          expandText: '收起',
          keyColor: Colors.blue[600],
          minLines: 2,
        ),
      ),
      Column(
        children: [
          Text(
              '编辑',
              style: TextStyle(color: Colors.indigo,fontSize: ScreenUtil().setSp(25))),
          Text(
              '删除',
              style: TextStyle(color: Colors.red,fontSize: ScreenUtil().setSp(25))),

        ],
      )
    ],
  ),
);
}