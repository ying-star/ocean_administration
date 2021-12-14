import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ocean_administration/Login_Signup/components.dart';
import 'package:ocean_administration/Login_Signup/login_page.dart';
import 'package:ocean_administration/Login_Signup/signup_page.dart';


class WelPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334, allowFontScaling: false);
    return Container(
      constraints: BoxConstraints.expand(),
      decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage('assets/ocean1.jpeg',)
          )
      ),
      child: Container(
          constraints: BoxConstraints(
            minHeight: ScreenUtil().setHeight(800),
            minWidth: double.infinity,),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          children:[
            SizedBox(height: ScreenUtil().setHeight(200),),
            Text('海洋物联网信息管理系统',
              style: TextStyle(
                decoration: TextDecoration.none,
                fontSize: ScreenUtil().setSp(60),
                fontWeight: FontWeight.bold,
                color: Colors.white,
            ),),
            SizedBox(height: ScreenUtil().setHeight(400),),
            LoginButtom(text: '登录',
              press: (){
                Navigator.push(
                  context, MaterialPageRoute(
                  builder: (context){
                    return LoginPage();
                  },
                ),
                );
              },),
            LoginButtom(text: '注册',
              press: (){
                Navigator.push(
                  context, MaterialPageRoute(
                  builder: (context){
                    return SignupPage();
                  },
                ),
                );
              },),
          ],
        ),
      ),
    );
  }
}
