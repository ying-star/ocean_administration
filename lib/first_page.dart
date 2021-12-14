import 'package:flutter/material.dart';
import 'package:ocean_administration/Device/device_home.dart';
import 'package:ocean_administration/Diary/diary_home_page.dart';
import 'package:ocean_administration/SeaLevel_Screem/TidePageInit.dart';
import 'package:ocean_administration/SeaLevel_Screem/sea_level_page.dart';
import 'package:ocean_administration/WeatherScreem/PageInit.dart';
import 'package:ocean_administration/WeatherScreem/weather_home.dart';
import 'package:ocean_administration/person_info.dart';


class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {

  bool isExpanded = false;
  int _currentIndex = 0;
  List<Widget> pages = new List();
  void initState() {
    pages
    ..add(PageInit())
      // ..add(WeatherHome())
      ..add(TidePageInit())
      // ..add(DiaryHome())
    ..add(DeviceHome())
    ..add(Person());


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.cloud,color: Colors.blue[800],),title: Text('天气')),
          BottomNavigationBarItem(
              icon: Icon(Icons.waves,color: Colors.blue[800]),title: Text('潮位')),
          // BottomNavigationBarItem(
          //     icon: Icon(Icons.insert_drive_file,color: Colors.blue[800]),title: Text('日志')),
          BottomNavigationBarItem(
              icon: Icon(Icons.phone_android,color: Colors.blue[800],),title: Text('设备')),
          BottomNavigationBarItem(
              icon: Icon(Icons.person,color: Colors.blue[800],),title: Text('天气')),
          // BottomNavigationBarItem(icon: Icon(Icons.person),title: Text('个人')),

        ],
        currentIndex: _currentIndex,
        onTap: (int i){
          setState(() {
            _currentIndex = i;
          });
        },
      ),
    );
  }
}
