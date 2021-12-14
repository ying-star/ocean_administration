import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:ocean_administration/Device/device_home.dart';
import 'package:shared_preferences/shared_preferences.dart';


void getHttpSignup(String phone, String password,String email,String nickname) async {

  Dio dio;
  String url = "http://www.zjuois.tech/api/usr/register";



  dio = Dio();

  Response response = await dio.post(
    url,
    data:{'email':email,'phone':phone,'pcode':1234,'password':password,'nickname':nickname},);

  Map<String,dynamic> responsejson = jsonDecode(response.data);
  int message = responsejson['code'];
  String token = responsejson['data']['token'];
  Map user = responsejson['data']['user'];

  print(message,);
  print(token,);
  print(user);

  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('token',token);
  prefs.setString('phone',phone);
  prefs.setString('email',email);
  prefs.setString('nickname',nickname);

}

void getHttpLogin(String phone, String password,) async {

  Dio dio;
  String url = "http://www.zjuois.tech/api/usr/login";

  // var data = FormData.fromMap(map);

  dio = Dio(
  );
  Response response = await dio.post(url,data: {"phone":phone,"password":password});
  Map<String,dynamic> responsejson = jsonDecode(response.data);
  int code = responsejson['code'];
  String token = responsejson['data']['token'];
  Map user = responsejson['data']['user'];
  String email = responsejson['data']['user']["email"];
  String nickname = responsejson['data']['user']["nickname"];
  String uid = responsejson['data']['user']["uid"];
  print(code);
  print(token,);
  print(user);
  print(email);
  print(nickname);

  //缓存
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('token',token);
  prefs.setString('phone',phone);
  prefs.setString('email',email);
  prefs.setString('nickname',nickname);
  prefs.setString('deviceid',uid);

}

Future<dynamic> getHttpWeather(String location) async {

  Dio dio;
  String url = "http://www.zjuois.tech/api/data/weather";
  dio = Dio();

  Response response = await dio.get(url,queryParameters: {"location":location});

  Map<String,dynamic> responsejson = jsonDecode(response.data);
  print(responsejson);
  String city = responsejson["result"]["city"];
  Map realtime = responsejson["result"]["realtime"];
  List future = responsejson["result"]["future"];
  String temperature = responsejson["result"]["realtime"]["temperature"];
  // print(city);
  // print(temperature);
  // print(future);



  return Future.delayed(Duration(seconds: 2), (){
    return responsejson;
  });

// print(token);

  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // prefs.setString('token',token);
}

Future<dynamic> getHttpTide(String location) async {

  Dio dio;
  String url = "http://www.zjuois.tech/api/data/sea_level";
  dio = Dio();



  Response response = await dio.get(url,queryParameters: {"location":location});

  Map<String,dynamic> responsejson = jsonDecode(response.data);
  // print(responsejson);

  List tideHourly = responsejson["tideHourly"];
  String updatetime = responsejson["updateTime"];



  return Future.delayed(Duration(seconds: 2), (){
    return responsejson;
  });

// print(token);

  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // prefs.setString('token',token);
}

Future<dynamic> getHttpPump() async {

  Dio pumpdio;

  String pumpurl = "http://www.zjuois.tech/api/command/pump_status";

  pumpdio = Dio();

  Map<String,dynamic> pump1;
  Map<String,dynamic> pump2;
  List<Map> pumplist =List();

  String device_id = 'hy001';

  String mode;
  String type1;
  String type2;

  Response response = await pumpdio.get(pumpurl,queryParameters: {"device_id":device_id});

  Map<String,dynamic> responsejson = jsonDecode(response.data);
  print(responsejson);
  Map _mode = responsejson["Mode"];
  if(_mode.containsKey("Circulate")){
    mode = '循环模式';
  }else{
    mode = '定时模式';
  }
  String frequency1 = responsejson["Mode"]["Circulate"]["Frequency"][0];
  String frequency2 = responsejson["Mode"]["Circulate"]["Frequency"][1];
  String status1 = responsejson["Mode"]["Circulate"]["status"][0];
  String status2 = responsejson["Mode"]["Circulate"]["status"][1];
  String pump_type1 = responsejson["data"]["Pump_type"][0];
  String pump_type2 = responsejson["data"]["Pump_type"][1];
  String voltage1 = responsejson["data"]["Voltage"][0];
  String voltage2 = responsejson["data"]["Voltage"][1];
  pump1 = {
    "mode" : mode,
    "Frequency" : frequency1,
    "status" : status1,
    "Pump_type" :pump_type1,
    "Voltage" :voltage1,
  };
  print(pump1);
  pump2 = {
    "mode" : mode,
    "Frequency" : frequency2,
    "status" : status2,
    "Pump_type" :pump_type2,
    "Voltage" :voltage2,
  };
  print(pump2);
  pumplist.add(pump1);
  pumplist.add(pump2);
 print(pumplist);
  // if(_mode.contains('Circulate')){
  //   mode = '循环模式';
  // }else{
  //   mode = '定时模式';
  // }

  return Future.delayed(Duration(seconds: 2), (){
    return pumplist;
  });

// print(token);

  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // prefs.setString('token',token);
}

Future<dynamic> getHttpSensor() async {


  Dio sensordio;
  String sensorurl = "http://www.zjuois.tech/api/usr/sensor_now";
  sensordio = Dio();
  String device_id = 'hy001';
  String token;

  SharedPreferences prefs = await SharedPreferences.getInstance();
  token = prefs.getString('token');
  print(token);

  Response response = await sensordio.post(sensorurl,data: {"device_id":device_id,"token":token});

  Map<String,dynamic> responsejson = jsonDecode(response.data);
  print(responsejson);


  return Future.delayed(Duration(seconds: 2), (){
    return responsejson;
  });

// print(token);

  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // prefs.setString('token',token);
}

void getHttpConnectDevice(String deviceid,) async {

  Dio dio;
  String url = "http://www.zjuois.tech/api/usr/connect_device";
  String token;
  // var data = FormData.fromMap(map);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  token = prefs.getString('token');
  prefs.setString('deviceid',deviceid);
  print(token);
  print(deviceid);
  dio = Dio();

  Response response = await dio.post(url,data: {"device_id":deviceid,});
  Map<String,dynamic> responsejson = jsonDecode(response.data);

  print(responsejson);



}

Future<dynamic> getHttpSensorFreq(String changefreq,String changeclear) async {

  Dio dio;
  String url = "http://www.zjuois.tech/api/command/sensorfreq";
  dio = Dio();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String deviceid = prefs.getString('deviceid');
  Response response = await dio.get(
      url,
      queryParameters: {"device_id":deviceid,"change_freq":changefreq,"change_clear":changeclear});

  Map<String,dynamic> responsejson = jsonDecode(response.data);
  print(responsejson);
  String message = responsejson["message"];
  print(message);
  // print(future);



  return Future.delayed(Duration(seconds: 2), (){
    return responsejson;
  });

}