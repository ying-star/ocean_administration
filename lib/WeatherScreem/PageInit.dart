
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ocean_administration/WeatherScreem/weather_home.dart';
import 'package:ocean_administration/dio_main_page.dart';

class PageInit extends StatefulWidget {

  @override
  _PageInitState createState() => _PageInitState();
}

class _PageInitState extends State<PageInit> {
  TextEditingController cityController = TextEditingController();
  Future<dynamic> _loadingFuture;
  String city = '北京';
  @override
  void initState() {
    _loadingFuture = getHttpWeather(city);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('天气'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [Colors.blue[400],Colors.blue[200]],
          ),
        ),
        child: ListView(
          children: [
         Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
             Container(
               width: ScreenUtil().setWidth(550),
               height: ScreenUtil().setHeight(60),
               child: TextField(
                 controller: cityController,
                 decoration: InputDecoration(
                   icon: Icon(Icons.search,color: Colors.white,size: ScreenUtil().setSp(50),),
                   hintText: '输入查询城市',
                   hintStyle: TextStyle(color: Colors.grey),
                   fillColor: Colors.white,
                   filled: true,
                 ),
               ),
             ),
             Container(
               width: ScreenUtil().setWidth(120),
               child: FlatButton(
                   color: Colors.blue[600],
                   onPressed: (){
                     // getHttpWeather(cityController.text='福州');
                     city = cityController.text;
                     setState(() {
                       _loadingFuture = getHttpWeather(city);
                     });
                   },
                   child: Text('查询',style: TextStyle(color: Colors.white),)),
             )
           ],
         ),
            FutureBuilder(
              future:_loadingFuture,
              builder: (BuildContext context,AsyncSnapshot snapshot){
              if(snapshot.connectionState == ConnectionState.done){
                  if(snapshot.hasError){
                    print(snapshot.error);
                    return Text("Error: ${snapshot.error}");
                  }else{
                    return WeatherHome(
                        city: snapshot.data["result"]['city'],
                        nowaqi: snapshot.data["result"]["realtime"]['aqi'],
                        nowdirect: snapshot.data["result"]["realtime"]["direct"],
                        nowhumidity: snapshot.data["result"]["realtime"]["humidity"],
                        nowinfo: snapshot.data["result"]["realtime"]["info"],
                        nowwid: snapshot.data["result"]["realtime"]["wid"],
                        nowpower:snapshot.data["result"]["realtime"]["power"],
                        nowtemp: snapshot.data["result"]["realtime"]["temperature"],
                        futureweather: snapshot.data["result"]["future"],
                      );
                    Text("Error: ${snapshot.data}");
                  }
                }else{
                  return CircularProgressIndicator();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}


