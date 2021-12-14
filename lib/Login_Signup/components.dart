import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmailInputTextField extends StatelessWidget {

  String hinttext;

  TextEditingController controller;
  EmailInputTextField({this.hinttext,this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hinttext,
        ),
      ),
    );
  }
}


class PasswordInputTextField extends StatelessWidget {

  String hinttext;

  TextEditingController controller;

  PasswordInputTextField({this.hinttext,this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        controller: controller,
        obscureText: true,
        decoration: InputDecoration(
          hintText: hinttext,
        ),
      ),
    );
  }
}
class LoginButtom extends StatelessWidget {
  String text;
  Function press;
  LoginButtom({this.text,this.press});
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: ScreenUtil().setHeight(60),
        minWidth: double.infinity,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FlatButton(
          shape:RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))
          ),
          color: Colors.blue[800],
          onPressed: press,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
            child: Text(text,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: ScreenUtil().setSp(35),
              fontWeight: FontWeight.w500),),
          ),
        ),
      ),
    );
  }
}

class LoginSignupSwitch extends StatelessWidget {

  String text;
  Function ontap;
  LoginSignupSwitch({this.text,this.ontap});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: ontap,
          child: Text(text,
            style: TextStyle(
                color: Colors.blue[800],
                fontSize:ScreenUtil().setSp(30)),
          )
      ),
    );
  }
}
