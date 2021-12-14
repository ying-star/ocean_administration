import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ocean_administration/Login_Signup/connect_device.dart';
import 'package:ocean_administration/Login_Signup/login_page.dart';
import 'package:ocean_administration/dio_main_page.dart';

import 'components.dart';
import 'text_field.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {

  //手机号的控制器
  TextEditingController phoneController = TextEditingController();

  //密码的控制器
  TextEditingController passController = TextEditingController();
//邮箱
  TextEditingController emailController = TextEditingController();
//昵称
  TextEditingController nicknameController = TextEditingController();
//验证码
//   TextEditingController _vcodeController = TextEditingController();

  final FocusNode _nodeVCode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('新用户注册',),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
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
                child: EmailInputTextField(hinttext: '设置昵称',controller: nicknameController,),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: EmailInputTextField(hinttext: '设置邮箱',controller: emailController,),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: PasswordInputTextField(hinttext: '设置密码',controller: passController,),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: EmailInputTextField(hinttext: '请输入手机号（登录账号）',controller: phoneController,),
              ),//下方验证码
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: MyTextField(
              //     focusNode: _nodeVCode,
              //     placeHolder: '请输入验证码',
              //     maxLength: 6,
              //     controller: _vcodeController,
              //     keyboardType: TextInputType.phone,
              //     getVCode: () {
              //       print('获取验证码');
              //     },
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text('已有账号？',
                      style: TextStyle(color: Colors.grey,fontSize:ScreenUtil().setSp(30)),
                    ),
                    LoginSignupSwitch(text: '去登录',
                      ontap: (){
                      Navigator.push(
                        context, MaterialPageRoute(
                        builder: (context){
                          return LoginPage();
                        },
                      ),
                      );
                    },)
                  ],
                ),
              ),
              LoginButtom(
                press:(){
                  _login();
                },
                text: '注册',),

            ],
          ),
        ),
      ),
    );
  }
  void _login() async{
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
      getHttpSignup(
          phoneController.text,
          passController.text,
          emailController.text,
          nicknameController.text
      );
      // showDialog(
      //     context: context,
      //     builder: (context) => AlertDialog(
      //       title: Text('绑定'),
      //     ));
      Navigator.push(
        context, MaterialPageRoute(
        builder: (context){
          return ConnectDevice();
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
