import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'components.dart';
import 'text_field.dart';

class ForgetPassPage extends StatefulWidget {
  @override
  _ForgetPassPageState createState() => _ForgetPassPageState();
}

class _ForgetPassPageState extends State<ForgetPassPage> {

  //手机号的控制器
  TextEditingController phoneController = TextEditingController();

  //密码的控制器
  TextEditingController passController = TextEditingController();

  //验证码
  TextEditingController _vcodeController = TextEditingController();

  final FocusNode _nodeVCode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('重置密码'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
                constraints: BoxConstraints(
                  minHeight: ScreenUtil().setHeight(400),
                  minWidth: double.infinity,
                ),
                child: Image.asset('assets/oceam.jpeg')
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: EmailInputTextField(hinttext: '请输入手机号',controller: phoneController,),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: PasswordInputTextField(hinttext: '请输入新密码',controller: passController,),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MyTextField(
                focusNode: _nodeVCode,
                placeHolder: '请输入验证码',
                maxLength: 6,
                controller: _vcodeController,
                keyboardType: TextInputType.phone,
                getVCode: () {
                  print('获取验证码');
                },
              ),
            ),
            LoginButtom(press:(){},text: '重置密码',),
          ],
        ),
      ),
    );
  }
}
