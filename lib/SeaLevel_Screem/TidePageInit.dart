import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:ocean_administration/SeaLevel_Screem/sea_level_page.dart';
import 'package:ocean_administration/dio_main_page.dart';


class TidePageInit extends StatefulWidget {
  @override
  _TidePageInitState createState() => _TidePageInitState();
}

class _TidePageInitState extends State<TidePageInit> {

  TextEditingController cityController = TextEditingController();
  Future<dynamic> _loadingFuture;
  String city = '北京';

  @override

  void initState() {
    _loadingFuture = getHttpTide(city);
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('潮位'),
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
                        city = cityController.text;
                        setState(() {
                          _loadingFuture = getHttpTide(city);
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
                    return Text("Error: ${snapshot.error}");
                  }else{
                    return Sealevel(
                      city: city,
                      tidelist: snapshot.data["tideHourly"],
                      updatetime: snapshot.data["updateTime"],);
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
