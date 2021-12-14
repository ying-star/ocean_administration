import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ocean_administration/dio_main_page.dart';

class SensorFreq extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController clearController = TextEditingController();
    TextEditingController meaController = TextEditingController();
    dynamic respond;
    return Scaffold(
      appBar: AppBar(
        title: Text('修改传感器频率'),
      ),
      body: Container(
        margin: EdgeInsets.all(15),
        child: Column(
          children: [
            Row(
              children: [
                Text("清洗频率：",style: TextStyle(fontSize: ScreenUtil().setSp(35),color: Colors.blue[700]),),
                Container(
                  width: ScreenUtil().setWidth(500),
                  // height: ScreenUtil().setHeight(60),
                  child: TextField(
                    controller: clearController,
                    decoration: InputDecoration(
                      hintText: '输入清洗频率',
                      hintStyle: TextStyle(color: Colors.grey),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text("测量频率：",style: TextStyle(fontSize: ScreenUtil().setSp(35),color: Colors.blue[700]),),
                Container(
                  width: ScreenUtil().setWidth(500),
                  // height: ScreenUtil().setHeight(60),
                  child: TextField(
                    controller: meaController,
                    decoration: InputDecoration(
                      hintText: '输入测量频率',
                      hintStyle: TextStyle(color: Colors.grey),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15))
              ),
              width: ScreenUtil().setWidth(450),
              child: FlatButton(
                  color: Colors.blue[600],
                  onPressed: ()async{
                   getHttpSensorFreq(
                        meaController.text,
                        clearController.text).then((value){
                          respond = value;
                          print(respond);
                          if(respond["message"] =="SUCCESS"){
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text('修改成功'),
                                ));
                          }
                        });


                  },
                  child: Text(
                    '更改',
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(40),
                      color: Colors.white,
                    ),)),
            ),
          ],
        ),
      ),
    );
  }
}


