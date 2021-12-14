import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ocean_administration/Login_Signup/components.dart';
import 'package:ocean_administration/dio_main_page.dart';
import 'package:ocean_administration/first_page.dart';

class ConnectDevice extends StatelessWidget {
  TextEditingController deviceController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('绑定设备'),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(15),
            height: ScreenUtil().setHeight(450),
            width: double.infinity,
            color: Colors.blue[600],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('请绑定设备',
                  style: TextStyle(color: Colors.white,fontSize: ScreenUtil().setSp(35)),),
                Text('以获取传感器和泵的信息',
                  style: TextStyle(color: Colors.white,fontSize: ScreenUtil().setSp(25)),),
                SizedBox(height: ScreenUtil().setHeight(60),),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: ScreenUtil().setWidth(20),),
                    Image.asset('assets/phone.png',scale: 1.5,),
                    Image.asset('assets/connect.png',scale: 2.5,),
                    Image.asset('assets/device.png',scale: 1.5,),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('设备号：',
                  style: TextStyle(
                      color: Colors.blue[700],
                      fontSize: ScreenUtil().setSp(30),
                      fontWeight: FontWeight.bold),),
                PasswordInputTextField(hinttext: '请输入设备号',controller: deviceController,),
              ],
            ),
          ),
          LoginButtom(
            press: ()async{
            getHttpConnectDevice(deviceController.text);
            Navigator.push(
              context, MaterialPageRoute(
              builder: (context){
                return FirstPage();
              },
            ),
            );
          },text: '绑定设备',)
        ],
      ),
    );
  }
}
