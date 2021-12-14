

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ocean_administration/Login_Signup/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Person extends StatefulWidget {
  @override
  _PersonState createState() => _PersonState();
}

class _PersonState extends State<Person> {

  String nickname = 'nickname';
  String phone =' 请获取信息';
  String email ='请获取信息';
  String deviceid = '请获取信息';

  // _load() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   nickname = prefs.getString('nickname');
  //   phone = prefs.getString('phone');
  //   email = prefs.getString('email');
  //   deviceid = prefs.getString('deviceid');
  // }


  @override
  void initState() {
    // TODO: implement initState
    // Future.delayed(Duration.zero,()=> _load());
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('个人主页'),
      ),
      body: Container(
       margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(100),vertical: ScreenUtil().setHeight(100)),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.blue[700],
                borderRadius: BorderRadius.all(Radius.circular(10))
              ),
              height: ScreenUtil().setHeight(500),
              width: ScreenUtil().setWidth(550),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.person,color: Colors.white,size: ScreenUtil().setSp(100),),
                  Text(nickname,style: TextStyle(fontSize: ScreenUtil().setSp(50),color: Colors.white,fontWeight: FontWeight.bold),),

                  Text("手机号：${phone}",style: TextStyle(fontSize: ScreenUtil().setSp(35),color: Colors.white),),
                  Text('邮箱：${email}',style: TextStyle(fontSize: ScreenUtil().setSp(35),color: Colors.white),),
                  Text("设备号：${deviceid}",style: TextStyle(fontSize: ScreenUtil().setSp(35),color: Colors.white),),
                ],
              ),
            ),
            SizedBox(height: ScreenUtil().setHeight(50),),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15))
              ),
              width: ScreenUtil().setWidth(450),
              child: FlatButton(
                  color: Colors.blue[600],
                  onPressed: ()async{
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    nickname = prefs.getString('nickname');
                    phone = prefs.getString('phone');
                    email = prefs.getString('email');
                    deviceid = prefs.getString('deviceid');
                    setState(() {});
                  },
                  child: Text(
                    '获取信息',
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(40),
                      color: Colors.white,
                    ),)),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15))
              ),
              width: ScreenUtil().setWidth(450),
              child: FlatButton(
                color: Colors.red,
                  onPressed: (){
                    Navigator.push(
                      context, MaterialPageRoute(
                      builder: (context){
                        return LoginPage();
                      },
                    ),
                    );
                  },
                  child: Text(
                    '退出登录',
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
