import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:charts_flutter/flutter.dart'as charts;

class Sealevel extends StatefulWidget {
  String city;
  String port;
  String updatetime ;
  List tidelist;
  Sealevel({this.tidelist,this.updatetime,this.city});
  @override
  _SealevelState createState() => _SealevelState();
}

class _SealevelState extends State<Sealevel> {



  @override
  Widget build(BuildContext context) {
    var dateFormat = DateFormat("yyy-MM-dd hh:mm"); // you can change the format here
    var utcDate = dateFormat.format(DateTime.parse(widget.updatetime)); // pass the UTC time here
    var localDate = dateFormat.parse(utcDate, true).toLocal().toString();
    String createdDate = dateFormat.format(DateTime.parse(localDate));
    return Container(
      height: ScreenUtil().setHeight(1200),
      child: Container(
        padding: EdgeInsets.all(10.0),
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [Colors.blue[400],Colors.blue[200]],
            )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.city,style: TextStyle(fontSize: ScreenUtil().setSp(50),color: Colors.white),),
            Row(
              children: [
                Text('更新时间：',style: TextStyle(fontSize: ScreenUtil().setSp(35),color: Colors.white),),
                Text(createdDate.toString(),style: TextStyle(fontSize: ScreenUtil().setSp(35),color: Colors.white),),
              ],
            ),
            SizedBox(height: 10,),
            Container(
              height: ScreenUtil().setHeight(800),
              margin: EdgeInsets.symmetric(vertical:8.0),
              padding: EdgeInsets.symmetric(vertical: 15.0,horizontal: 15.0),
              decoration: BoxDecoration(
                color: Color(0x33ffffff),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: ListView.builder(
                  itemCount: widget.tidelist.length,
                  itemBuilder: (context,index){
                    return _bottomWidget(
                      utctime: widget.tidelist[index]['fxTime'],
                      height: widget.tidelist[index]['height']
                        );
                  }),
            ),

            // Row(
            //   children: [
            //     Icon(Icons.waves,color: Colors.white,size: 40,),
            //     Text(' 潮位：',style: TextStyle(fontSize: ScreenUtil().setSp(35),color: Colors.white),),
            //     Text(' 5',style: TextStyle(fontSize: ScreenUtil().setSp(35),color: Colors.white),),
            //   ],
            // ),
            // Row(
            //   children: [
            //     Container(
            //         height: ScreenUtil().setHeight(35),
            //         width: ScreenUtil().setHeight(35),
            //         child: Image.asset('assets/icons/longitude.png',fit: BoxFit.fill,)),
            //     Text(' 经度：',style: TextStyle(fontSize: ScreenUtil().setSp(35),color: Colors.white),),
            //     Text('E119°38′9.39″',style: TextStyle(fontSize: ScreenUtil().setSp(35),color: Colors.white),),
            //   ],
            // ),
            // Row(
            //   children: [
            //     Container(
            //       height: ScreenUtil().setHeight(35),
            //       width: ScreenUtil().setHeight(35),
            //       child: Image.asset('assets/icons/longitude.png',fit: BoxFit.fill,)),
            //     Text(' 纬度：',style: TextStyle(fontSize: ScreenUtil().setSp(35),color: Colors.white),),
            //     Text('E119°38′9.39″',style: TextStyle(fontSize: ScreenUtil().setSp(35),color: Colors.white),),
            //   ],
            // ),

            // Container(
            //   height: ScreenUtil().setHeight(500),
            //     width: ScreenUtil().setHeight(700),
            //     child: _simpleLine()),
          ],
        ),
      ),
    );
  }
}
Widget _bottomWidget({String utctime, String height, }) {
  var dateFormat = DateFormat("yyy-MM-dd hh:mm"); // you can change the format here
  var utcDate = dateFormat.format(DateTime.parse(utctime)); // pass the UTC time here
  var localDate = dateFormat.parse(utcDate, true).toLocal().toString();
  String createdDate = dateFormat.format(DateTime.parse(localDate));
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Text('时间：', style: TextStyle(color: Colors.white)),
                Text(createdDate, style: TextStyle(color: Colors.white)),
              ],
            ),
            Row(
              children: [
                Text('潮汐高度：', style: TextStyle(color: Colors.white,fontSize: ScreenUtil().setSp(45))),
                Text(height, style: TextStyle(color: Colors.white,fontSize: ScreenUtil().setSp(45))),
              ],
            ),
          ],
        ),
        // SizedBox(width: ScreenUtil().setWidth(20)),


        // Image.asset(icon, width: ScreenUtil().setSp(55), fit: BoxFit.fill),
      ],
    ),
  );
}


Widget TideLine(
    List<dynamic> tidelist,
    ){
  List<dynamic> tidelistuse = [];
  // Map<String,dynamic> tide =Map();
  int i;
  for(i = 0; i<tidelist.length;i++){
    var dateFormat = DateFormat("hh:mm"); // you can change the format here
    var utcDate = dateFormat.format(DateTime.parse(tidelist[i]["fxTime"])); // pass the UTC time here
    var localDate = dateFormat.parse(utcDate, true).toLocal().toString();
    String createdDate = dateFormat.format(DateTime.parse(localDate));

    Map<String,dynamic> tide = {'fxTime':createdDate,'height':tidelist[i]['height']};
    print(tide);
    tidelistuse.add(tide);
    // tidelistuse.add(TideData(tidelist[i]['height'],createdDate));
    // tide.clear();
    }
  print(tidelistuse[0]['fxTime']);

  // return SfCartesianChart(
  //   primaryXAxis: CategoryAxis(
  //     title:AxisTitle(text: '时间',),
  //     isVisible: true,
  //     opposedPosition: false,
  //     isInversed: false,
  //   ),
  //   primaryYAxis: CategoryAxis(
  //     title: AxisTitle(text:'潮汐高度'),
  //     opposedPosition: false,
  //     isInversed: false,
  //   ),
  //   title: ChartTitle(text:'潮汐'),
  //   selectionType: SelectionType.series,
  //   isTransposed: false,
  //   selectionGesture: ActivationMode.singleTap,
  //   legend: Legend(
  //     isVisible: true,
  //     iconHeight: 10,
  //     iconWidth: 10,
  //     toggleSeriesVisibility: true,
  //     position: LegendPosition.bottom,
  //     overflowMode: LegendItemOverflowMode.wrap,
  //     alignment: ChartAlignment.center,
  //   ),
  //   trackballBehavior: TrackballBehavior(
  //     lineType: TrackballLineType.vertical,
  //     activationMode: ActivationMode.singleTap,
  //     enable: true,
  //     tooltipAlignment: ChartAlignment.near,
  //     shouldAlwaysShow: true,
  //     tooltipDisplayMode: TrackballDisplayMode.groupAllPoints,
  //   ),
  //   tooltipBehavior: TooltipBehavior(
  //     enable: true,
  //     shared: true,
  //     activationMode: ActivationMode.singleTap,
  //   ),
  //   series: <ChartSeries<TideData,String>>[
  //     LineSeries<TideData, String>(
  //         name: '潮汐信息',
  //         dataSource:<TideData>[
  //           TideData('00:00', '4'),
  //           TideData('00:30', '3'),
  //           TideData('01:00', '37'),
  //           TideData('01:30', '35'),
  //           TideData('23:30', '20')
  //          // TideData(tidelistuse[0]['fxTime'], tidelistuse[0]['height']),
  //          // TideData(tidelistuse[1]['fxTime'], tidelistuse[1]['height']),
  //          // TideData(tidelistuse[2]['fxTime'], tidelistuse[2]['height']),
  //          // TideData(tidelistuse[3]['fxTime'], tidelistuse[3]['height']),
  //          //  TideData(tidelistuse[4]['fxTime'], tidelistuse[4]['height'])
  //     ],
  //         xValueMapper: (TideData manner ,_) => manner.height,
  //         yValueMapper: (TideData manner ,_) => int.tryParse(manner.time),
  //         // markerSettings: MarkerSettings(isVisible: true),
  //         // dataLabelSettings: DataLabelSettings(
  //         //   isVisible: false,
  //         // ),
  //     ),
  //
  //   ],
  // );
}

Widget _simpleLine() {

  var data = [
    TideData('00:00', '44'),
    TideData('00:30', '33'),
    TideData('01:00', '37'),
    TideData('01:30', '35'),
    TideData('23:30', '20')
  ];

  var seriesList = [
    charts.Series<TideData, int>(
      id: 'Sales',
      colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
      domainFn: (TideData sales, _) => int.tryParse(sales.time),
      measureFn: (TideData sales, _) => int.tryParse(sales.height),
      data: data,
    )
  ];

  return charts.LineChart(seriesList, animate: true);
}


class TideData {
  TideData(this.height, this.time);
  final String time;
  final String height;
}