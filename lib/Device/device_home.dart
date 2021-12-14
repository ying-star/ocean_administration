import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ocean_administration/Device/sensor_freq.dart';
import 'package:ocean_administration/dio_main_page.dart';

class DeviceHome extends StatefulWidget {
  // String clearfreq = '5';
  // String meafreq ='4';
  // String COD;
  // String PH;
  // String Time;
  // String dianya;
  // String Do;
  // String sality;
  // DeviceHome({this.clearfreq='5',this.meafreq='4',this.Do,this.sality,this.PH,this.COD,this.dianya,this.Time});
  @override
  _DeviceHomeState createState() => _DeviceHomeState();
}

class _DeviceHomeState extends State<DeviceHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('设备'),
        // actions: [
        //   FlatButton(
        //       onPressed: (){},
        //       child: Text('绑定设备',
        //         style: TextStyle(color: Colors.white,fontSize: ScreenUtil().setSp(30)),))],
      ),
      body: Container(
        color: Colors.grey[300],
        child: ListView(
          children: [
            Container(

              color: Colors.grey[300],
              margin: EdgeInsets.all(15),
              padding: EdgeInsets.all(8),
              // height: ScreenUtil().setHeight(500),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('传感器：',
                          style: TextStyle(color: Colors.blue[600],fontSize: ScreenUtil().setSp(40),fontWeight: FontWeight.bold)),
                      FlatButton(
                          onPressed: (){
                            Navigator.push(
                              context, MaterialPageRoute(
                              builder: (context){
                                return SensorFreq();
                              },
                            ),
                            );
                          },
                          child: Text('更改频率',style: TextStyle(color: Colors.red,fontSize: ScreenUtil().setSp(35)))),
                      Row(
                        children: [
                          IconButton(icon: Icon(Icons.add_box,color:Colors.green ,), onPressed: (){}),
                          IconButton(icon: Icon(Icons.indeterminate_check_box_outlined,color:Colors.redAccent ,), onPressed: (){}),
                        ],
                      ),

                    ],
                  ),

             FutureBuilder(
              future:getHttpSensor(),
              builder: (BuildContext context,AsyncSnapshot snapshot){
                if(snapshot.connectionState == ConnectionState.done){
                  if(snapshot.hasError){
                    return Text("Error: ${snapshot.error}");
                  }else{
                    return Sensor(
                      clearfreq:snapshot.data["Freq"]["clear_freq"] ,
                        meafreq: snapshot.data["Freq"]["mea_freq"],
                        COD:snapshot.data["data"]["COD"],
                        PH: snapshot.data["data"]["PH"],
                        dianya: snapshot.data["data"]["dianya"],
                        sality: snapshot.data["data"]["sality"],
                        turb: snapshot.data["data"]["turb"],
                        Do:snapshot.data["data"]["do"],);
                  }
                }else{
                  return CircularProgressIndicator();
                }
              },
            ),
                ],
              ),
            ),
            Divider(height: 2.0,indent:10.0,endIndent:10.0,color: Colors.blue[700],thickness: 2.0,),
            Container(

              color: Colors.grey[300],
              margin: EdgeInsets.all(15),
              padding: EdgeInsets.all(8),
              // height: ScreenUtil().setHeight(500),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('泵的工作状态：',
                          style: TextStyle(color: Colors.blue[600],fontSize: ScreenUtil().setSp(40),fontWeight: FontWeight.bold)),
                      Row(
                        children: [
                          IconButton(icon: Icon(Icons.add_box,color:Colors.green ,), onPressed: (){}),
                          IconButton(icon: Icon(Icons.indeterminate_check_box_outlined,color:Colors.redAccent ,), onPressed: (){}),
                        ],
                      ),
                    ],
                  ),
                  FutureBuilder(
                    future:getHttpPump(),
                    builder: (BuildContext context,AsyncSnapshot snapshot){
                      if(snapshot.connectionState == ConnectionState.done){
                        if(snapshot.hasError){
                          return Text("Error: ${snapshot.error}");
                        }else{
                          return Container(
                            height: ScreenUtil().setHeight(500),
                            child: ListView.builder(
                                itemCount: snapshot.data.length,
                                itemBuilder: (context,index){
                                  return pump(
                                    mode: snapshot.data[index]['mode'],
                                    frequency: snapshot.data[index]["Frequency"],
                                    status: snapshot.data[index]["status"],
                                    pumptype: snapshot.data[index]["Pump_type"],
                                    voltage: snapshot.data[index]["Voltage"],
                                  );
                                }),
                          );
                        }
                      }else{
                        return CircularProgressIndicator();
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}

Widget Sensor ({
  String clearfreq,
  String meafreq,
  String COD,
  String PH,
  String Time,
  String dianya,
  String Do,
  String sality,
String turb}){
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(10))
    ),
    height: ScreenUtil().setHeight(200),
    padding: EdgeInsets.all(15),

    child:
    Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                Text('测量频率:',
                    style: TextStyle(color: Colors.black,fontSize: ScreenUtil().setSp(35))),
                Text(meafreq,
                    style: TextStyle(color: Colors.black,fontSize: ScreenUtil().setSp(35))),
              ],
            ),

            Row(
              children: [
                Text('清洗频率:',
                    style: TextStyle(color: Colors.black,fontSize: ScreenUtil().setSp(35))),
                Text(clearfreq,
                    style: TextStyle(color: Colors.black,fontSize: ScreenUtil().setSp(35))),
              ],
            ),
            SizedBox(width: 15,),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
          Text('COD:', style: TextStyle(color: Colors.black,fontSize: ScreenUtil().setSp(35))),
          Text(COD, style: TextStyle(color: Colors.black,fontSize: ScreenUtil().setSp(35))),
          Text('PH:', style: TextStyle(color: Colors.black,fontSize: ScreenUtil().setSp(35))),
          Text(PH, style: TextStyle(color: Colors.black,fontSize: ScreenUtil().setSp(35))),
          Text('电压:', style: TextStyle(color: Colors.black,fontSize: ScreenUtil().setSp(35))),
          Text(dianya, style: TextStyle(color: Colors.black,fontSize: ScreenUtil().setSp(35))),
        ],),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
          Text('盐度:', style: TextStyle(color: Colors.black,fontSize: ScreenUtil().setSp(35)),),
          Text(sality, style: TextStyle(color: Colors.black,fontSize: ScreenUtil().setSp(35))),
          Text('浊度:', style: TextStyle(color: Colors.black,fontSize: ScreenUtil().setSp(35))),
          Text(turb, style: TextStyle(color: Colors.black,fontSize: ScreenUtil().setSp(35))),
          Text('溶解氧:', style: TextStyle(color: Colors.black,fontSize: ScreenUtil().setSp(35))),
          Text(Do, style: TextStyle(color: Colors.black,fontSize: ScreenUtil().setSp(35))),
        ],)

      ],
    ),
  );
}

Widget pump({
  String pumptype,
  String type,
  String voltage,
  String frequency,
  String status,
  bool flag,
  String mode,
}){

  if(status == "ON"){
    flag = true;
  }else{
    flag = false;
  }

  if(pumptype == "qingyu"){
    type = "清淤";
  }else{
    type = "增氧";
  }
  return Container(
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(15))
    ),
    height: ScreenUtil().setHeight(200),
    padding: EdgeInsets.all(10),
    margin: EdgeInsets.symmetric(vertical: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('类型：', style: TextStyle(color: Colors.black,fontSize: ScreenUtil().setSp(35))),
            Text(type, style: TextStyle(color: Colors.black,fontSize: ScreenUtil().setSp(35))),
            SizedBox(width: 10,),
            Text('状态：', style: TextStyle(color: Colors.black,fontSize: ScreenUtil().setSp(35))),
            Switch(value: flag,activeColor: Colors.blue[600], onChanged: (flag){}),
            IconButton(icon: Icon(Icons.settings,color: Colors.black45,), onPressed: (){}),
          ],),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('工作模式:', style: TextStyle(color: Colors.black,fontSize: ScreenUtil().setSp(35)),),
            Text(mode, style: TextStyle(color: Colors.black,fontSize: ScreenUtil().setSp(35))),
            Text('电压数值:', style: TextStyle(color: Colors.black,fontSize: ScreenUtil().setSp(35))),
            Text(voltage, style: TextStyle(color: Colors.black,fontSize: ScreenUtil().setSp(35))),
          ],),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('循环时间间隔:', style: TextStyle(color: Colors.black,fontSize: ScreenUtil().setSp(35))),
            Text(frequency, style: TextStyle(color: Colors.black,fontSize: ScreenUtil().setSp(35))),
            Text('次/s', style: TextStyle(color: Colors.black,fontSize: ScreenUtil().setSp(35))),
          ],
        ),

      ],
    ),
  );
}