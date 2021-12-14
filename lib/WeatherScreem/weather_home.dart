

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ocean_administration/Login_Signup/components.dart';

class WeatherHome extends StatefulWidget {

  String city;
  String nowtemp;
  String nowhumidity;
  String nowinfo;
  String nowwid;
  String nowdirect;
  String nowpower;
  String nowaqi;
  List futureweather;

  WeatherHome({this.city,this.nowaqi,this.nowdirect,this.nowhumidity,this.nowinfo,this
  .nowpower,this.nowtemp,this.nowwid,this.futureweather});


  @override
  _WeatherHomeState createState() => _WeatherHomeState();
}

class _WeatherHomeState extends State<WeatherHome> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(1200),
      child: Container(
        padding: EdgeInsets.all(10.0),
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [Colors.blue[400],Colors.blue[200]],
          )
        ),
        child: Column(
          children: [
            Row(
              children: [
                Text(widget.city,style: TextStyle(fontSize: ScreenUtil().setSp(50),color: Colors.white),),
                SizedBox(width: 10,),
                Text(widget.nowinfo,style: TextStyle(fontSize: ScreenUtil().setSp(35),color: Colors.white),),
              ],
            ),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.nowtemp,
                  style: TextStyle(fontSize: ScreenUtil().setSp(180),color: Colors.white,fontWeight: FontWeight.bold),
                ),
                Text('℃',
                  style: TextStyle(fontSize: ScreenUtil().setSp(50),color: Colors.white,fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text(widget.nowinfo,style: TextStyle(fontSize: ScreenUtil().setSp(35),color: Colors.white),),
                // Text('  |  ', style: TextStyle(fontSize: ScreenUtil().setSp(45),color: Colors.white)),
                // Text('更新时间：',style: TextStyle(fontSize: ScreenUtil().setSp(35),color: Colors.white),),
                // Text('2020-12-06  星期日',style: TextStyle(fontSize: ScreenUtil().setSp(35),color: Colors.white),),
                // Text('℃',style: TextStyle(fontSize: ScreenUtil().setSp(30),color: Colors.white),),
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 15.0),
              decoration: BoxDecoration(
                color: Color(0x33ffffff),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                children: [
                  _centerWidget(icon: 'assets/icons/winddirection.png',title: '风向',data: widget.nowdirect),
                  _centerWidget(icon: 'assets/icons/humidity.png',title: '相对湿度',data: widget.nowhumidity),
                  _centerWidget(icon: 'assets/icons/windscale.png',title: '风力等级',data: widget.nowpower),
                  _centerWidget(icon: 'assets/icons/windspeed.png',title: '空气质量',data: widget.nowaqi),
                ],
              ),
            ),//row2
            // Container(
            //   margin: EdgeInsets.symmetric(vertical:8.0),
            //   padding: EdgeInsets.symmetric(vertical: 15.0),
            //   decoration: BoxDecoration(
            //     color: Color(0x33ffffff),
            //     borderRadius: BorderRadius.circular(8.0),
            //   ),
            //   child: Row(
            //     children: [
            //       _centerWidget(icon: 'assets/icons/feelslike.png',title: '体感温度',data: '14℃'),
            //       _centerWidget(icon: 'assets/icons/humidity.png',title: '相对湿度',data: '76'),
            //       _centerWidget(icon: 'assets/icons/visibility.png',title: '能见度',data: '16.09'),
            //       _centerWidget(icon: 'assets/icons/pressure.png',title: '压力',data: '1018'),
            //       _centerWidget(icon: 'assets/icons/clouds.png',title: '云量',data: '90'),
            //     ],
            //   ),
            // ),
            //row2
            Container(
              height: 350,
              margin: EdgeInsets.symmetric(vertical:8.0),
              padding: EdgeInsets.symmetric(vertical: 15.0,horizontal: 15.0),
              decoration: BoxDecoration(
                color: Color(0x33ffffff),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: ListView.builder(
                itemCount: widget.futureweather.length,
                  itemBuilder: (context,index){
                  return _bottomWidget(
                    date: widget.futureweather[index]['date'].toString(),
                  temp: widget.futureweather[index]['temperature'],
                  weather: widget.futureweather[index]['weather'],
                  direct: widget.futureweather[index]['direct']);
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _centerWidget({String icon, String title, String data}) {
  return Expanded(
    child: Column(
      children: <Widget>[
        Image.asset(icon, width: ScreenUtil().setSp(55), fit: BoxFit.fill),
        SizedBox(height: ScreenUtil().setHeight(5)),
        Text(title, style: TextStyle(color: Colors.white)),
        SizedBox(height:ScreenUtil().setHeight(5)),
        Text(data, style: TextStyle(color: Colors.white)),
      ],
    ),
  );
}

Widget _bottomWidget({String wid, String weathericon, String temp, String date,String weather,String direct}) {
  if(wid == '00'){
    weathericon = 'assets/icons/sunny.png';
  }else if(wid == '13'||wid=='14'||wid=='15'||wid=='16'||wid=='17'||wid == '26'||wid=='27'||wid=='28'){
    weathericon='assets/icons/snow.png';
  }else if(wid=='18'||wid=='53'){
    weathericon = 'assets/icons/fog.png';
  }else if(wid=='29'||wid=='30'||wid=='31'||wid=='20'){
    weathericon='assets/icons/sand.png';
  }else if(wid == '01'||wid=='02'){
    weathericon='assets/icons/clouds.png';
  }else{
    weathericon='assets/icons/rain.png';
  }
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(date, style: TextStyle(color: Colors.white)),
            Text(temp, style: TextStyle(color: Colors.white,fontSize: ScreenUtil().setSp(45))),
          ],
        ),
        // SizedBox(width: ScreenUtil().setWidth(20)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(weathericon, width: ScreenUtil().setSp(50), fit: BoxFit.fill),
            Text(weather, style: TextStyle(color: Colors.white,fontSize: ScreenUtil().setSp(25))),
          ],
        ),
        // SizedBox(width: ScreenUtil().setWidth(20)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [

          Image.asset('assets/icons/winddirection.png', width: ScreenUtil().setSp(50), fit: BoxFit.fill),
          Text(direct, style: TextStyle(color: Colors.white,fontSize: ScreenUtil().setSp(25))),
        ],)

        // Image.asset(icon, width: ScreenUtil().setSp(55), fit: BoxFit.fill),
      ],
    ),
  );
}