import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ocean_administration/Login_Signup/components.dart';
import 'package:ocean_administration/Login_Signup/forget_password_page.dart';
import 'package:ocean_administration/Login_Signup/signup_page.dart';
import 'package:ocean_administration/dio_main_page.dart';
import 'package:ocean_administration/first_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  //手机号的控制器
  TextEditingController phoneController = TextEditingController();

  //密码的控制器
  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('登录',),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              constraints: BoxConstraints(
                minHeight: ScreenUtil().setHeight(400),
                minWidth: double.infinity,
              ),
              child: Image.asset('assets/oceam.jpeg',fit: BoxFit.fill,)
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: EmailInputTextField(hinttext: '请输入手机号',controller: phoneController,),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: PasswordInputTextField(hinttext: '请输入密码',controller: passController,),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text('还没账号？',
                    style: TextStyle(color: Colors.grey,fontSize:ScreenUtil().setSp(30)),
                  ),
                  LoginSignupSwitch(text: '去注册',ontap: (){
                    Navigator.push(
                      context, MaterialPageRoute(
                      builder: (context){
                        return SignupPage();
                      },
                    ),
                    );
                  },),
                  SizedBox(width: ScreenUtil().setWidth(330),),
                  LoginSignupSwitch(text: '忘记密码',
                    ontap: (){
                    Navigator.push(
                      context, MaterialPageRoute(
                      builder: (context){
                        return ForgetPassPage();
                      },
                    ),
                    );
                  },)
                ],
              ),
            ),
            LoginButtom(
              press:_login,
              text: '登录',),

          ],
        ),
      ),
    );
  }
   void _login() {
    print({'phone': phoneController.text, 'password': passController.text});
    if (phoneController.text.length != 11) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('手机号码格式不对'),
          ));
    } else if (passController.text.length == 0) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('请填写密码'),
          ));
    } else {
      getHttpLogin(phoneController.text, passController.text);

      Navigator.push(
        context, MaterialPageRoute(
        builder: (context){
          return FirstPage();
        },
      ),
      );
      phoneController.clear();
    }
  }

  void onTextClear() {
    setState(() {
      phoneController.clear();
      passController.clear();
    });
  }

}


