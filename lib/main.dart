import 'package:aqsm/alertbox.dart';
import 'package:aqsm/landingpage.dart';
import 'package:aqsm/misc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';


// Main Class
class AqiInfo {
  String createdAt;
  String pm25; //field1
  String pm10; //field2
  String o3; //field3
  String no2; //field4
  String so2; //field5
  String co; //field6
  String temperature; //field7
  String humidity; //field8

  AqiInfo(
      {this.createdAt,
      this.pm25,
      this.pm10,
      this.o3,
      this.no2,
      this.so2,
      this.co,
      this.temperature,
      this.humidity});

  factory AqiInfo.fromJson(Map<String, dynamic> json) {
    return AqiInfo(
        createdAt: json["created_at"],
        pm25: json["field1"],
        pm10: json["field2"],
        o3: json["field3"],
        no2: json["field4"],
        so2: json["field5"],
        co: json["field6"],
        temperature: json["field7"],
        humidity: json["field8"]);
  }
}

// reading list from API

Future<List<AqiInfo>> getData() async {
  List<AqiInfo> list;
  var reverserest;
  String link =
      "https://api.thingspeak.com/channels/1034797/feeds.json?api_key=XT3ISBE05JRUQFFD";
  var res = await http
      .get(Uri.encodeFull(link), headers: {"Accept": "application/json"});
  // print(res.body);
  if (res.statusCode == 200) {
    var data = json.decode(res.body);
    var rest = data["feeds"] as List;
    reverserest = rest.reversed;
    list = reverserest.map<AqiInfo>((json) => AqiInfo.fromJson(json)).toList();
  }
  return list;
}


//functions 

List<String> _getdate(String dt) {
  var date = dt.split("T");
  var datearr = date[0].split('-');
  return datearr;
}

int _gethrs(String dt) {
  var date = dt.split("T");
  var time = date[1].split("Z");
  var hrs = time[0].split(":");
  var hrsint = int.parse(hrs[0]);
  return hrsint;
}

String _splitDate(String dte) {
  var date = dte.split("T");
  var time = date[1].split("Z");
  var hrs = time[0].split(":");
  var hrsint = int.parse(hrs[0]) + 5;
  var hrsconverted;
  String ampm;
  if (hrsint == 0) {
    hrsconverted = 12;
    ampm = "AM";
  } else if (hrsint > 0 && hrsint <= 12) {
    hrsconverted = hrsint;
    if (hrsint == 12) {
      ampm = "PM";
    } else
      ampm = "AM";
  } else if (hrsint > 12) {
    hrsconverted = hrsint - 12;
    ampm = "PM";
  }
  return "${date[0]}" + " , " + "$hrsconverted:${hrs[1]}" + " $ampm";
}



// calculate aqi
String _calculateAQI(List<AqiInfo> list) {
  List<String> createdat = List();
  List<String> filteredates = List();
  List<String> pm25 = List();
  List<String> pm10 = List();
  List<String> o3 = List();
  List<String> no2 = List();
  List<String> so2 = List();
  List<String> co = List();
  var splitdate = list[0].createdAt.split('-'); 
  var today = splitdate[2].split('T');

  for (var i = 0; i < list.length; i++) {
    if ((int.parse(today[0]) - 1) == int.parse(_getdate(list[i].createdAt)[2]) &&
        int.parse(splitdate[1]) == int.parse(_getdate(list[i].createdAt)[1])) {
      if (_gethrs(splitdate[2]) < _gethrs(list[i].createdAt))
        createdat.add(list[i].createdAt);
    }
    createdat.add(list[i].createdAt);
  }
  for (var i = 0; i < list.length; i++) {
    if (filteredates.length == 0) {
      filteredates.add(createdat[i]);
      list[i].pm25 != null ? pm25.add(list[i].pm25) : pm25.add('0');
      list[i].pm10 != null ? pm10.add(list[i].pm10) : pm10.add('0');
      list[i].o3 != null ? o3.add(list[i].o3) : o3.add('0');
      list[i].no2 != null ? no2.add(list[i].no2) : no2.add('0');
      list[i].so2 != null ? so2.add(list[i].so2) : so2.add('0');
      list[i].co != null ? co.add(list[i].co) : co.add('0');
    } else if (filteredates.length != 0) {
      if (_gethrs(filteredates[filteredates.length - 1]) !=
          _gethrs(createdat[i])) {
        filteredates.add(createdat[i]);
        list[i].pm25 != null ? pm25.add(list[i].pm25) : pm25.add('0');
        list[i].pm10 != null ? pm10.add(list[i].pm10) : pm10.add('0');
        list[i].o3 != null ? o3.add(list[i].o3) : o3.add('0');
        list[i].no2 != null ? no2.add(list[i].no2) : no2.add('0');
        list[i].so2 != null ? so2.add(list[i].so2) : so2.add('0');
        list[i].co != null ? co.add(list[i].co) : co.add('0');
      } else if (_gethrs(filteredates[filteredates.length - 1]) ==
          _gethrs(createdat[i])) {
        filteredates[filteredates.length - 1] = createdat[i];
        list[i].pm25 != null ? pm25[pm25.length - 1] = list[i].pm25 : pm25[pm25.length - 1] = '0';
        list[i].pm10 != null ? pm10[pm10.length - 1] = list[i].pm10 : pm10[pm10.length - 1] = '0';
        list[i].o3 != null ? o3[o3.length - 1] = list[i].o3 : o3[o3.length - 1] = '0';
        list[i].no2 != null ? no2[no2.length - 1] = list[i].no2 : no2[no2.length - 1] = '0';
        list[i].so2 != null ? so2[so2.length - 1] = list[i].so2 : so2[so2.length - 1] = '0';
        list[i].co != null ? co[co.length - 1] = list[i].co : co[co.length - 1] = '0';
      }
    }
  }
  var trecord = filteredates.length;
  double tpm25 = 0;
  double tpm10 = 0;
  double to3 = 0;
  double tso2 = 0;
  double tno2 = 0;
  double tco = 0;
  for (int i = 0; i < trecord; i++) {
    tpm25 = tpm25 + double.parse(pm25[i]);
    tpm10 = tpm10 + double.parse(pm10[i]);
    to3 = to3 + double.parse(o3[i]);
    tso2 = tso2 + double.parse(so2[i]);
    tno2 = tno2 + double.parse(no2[i]);
    tco = tco + double.parse(co[i]);
  }
  List<double> avgall = List();
  avgall.add(tpm25 / trecord);
  avgall.add(tpm10 / trecord);
  avgall.add(to3 / trecord);
  avgall.add(tso2 / trecord);
  avgall.add(tno2 / trecord);
  avgall.add(tco / trecord);
  var maxvalue = avgall[0];
  for (int i = 1; i < 6; i++) {
    if (maxvalue < avgall[i]) {
      maxvalue = avgall[i];
    }
  }
  return maxvalue.floor().toString();
}




void main() => runApp(MyApp());

const PrimaryColor = const Color(0xFFe8e8e8);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AQSM',
      theme: ThemeData(
        primaryColor: PrimaryColor,
      ),
      home: LandingPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void initState() {
    super.initState();
    getData();
  }

  String _currentSelectedLocation = "Comsats University Islamabad, Wah Cantt";
  Color changeaqibg(double value) {
    Color _color;
    if (value <= 50) {
      _color = Color(0xFF01E401);
    } else if (value > 50 && value <= 100) {
      _color = Color(0xFFFFFF01);
    } else if (value > 100 && value <= 150) {
      _color = Color(0xFFFE9000);
    } else if (value > 150 && value <= 200) {
      _color = Color(0xFFFE0000);
    } else if (value > 200 && value <= 300) {
      _color = Color(0xFF98004B);
    } else if (value > 300) {
      _color = Color(0xFF7E0123);
    }
    return _color;
  }

  String _returnclean(String str) {
    var strdouble = double.parse(str);
    return strdouble.toString();
  }

  Widget listViewWidget(List<AqiInfo> aqiinfo) {
    return Container(
      child: ListView.builder(
          itemCount: 1,
          padding: const EdgeInsets.all(2.0),
          itemBuilder: (context, position) {
            return Container(
              // height: double.infinity,
              padding: EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 20),
              decoration: BoxDecoration(
                color: Color(0xFFE8E8E8),
              ),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  // nav bar
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.blueGrey,
                        ),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(1.0),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(1, 3),
                          )
                        ]),
                    width: double.infinity,
                    height: 47,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(
                            icon: Icon(Icons.sync),
                            tooltip: "Auto Sync On",
                            onPressed: () {}),
                        Text(
                          "Dashboard",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w400),
                        ),
                        IconButton(
                            icon: Icon(Icons.info_outline),
                            tooltip: "Info",
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          new Misc()));
                            })
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 13,
                  ),
                  // main tile
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.blueGrey,
                        ),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(1.0),
                            spreadRadius: 2,
                            blurRadius: 2,
                            offset: Offset(1, 3),
                          )
                        ]),
                    width: double.infinity,
                    height: 190,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            // location info
                            Row(
                              children: <Widget>[
                                IconButton(
                                  icon: Icon(Icons.location_on),
                                  onPressed: () {},
                                  color: Colors.blue,
                                ),
                                Text(
                                  _currentSelectedLocation,
                                  textScaleFactor: 1.0,
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.only(left: 15),
                                    child: Row(
                                      children: <Widget>[
                                        // last updated
                                        Text(
                                          "Last Updated:  ",
                                          textScaleFactor: 1.0,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13),
                                        ),
                                        Text(
                                          "${_splitDate(aqiinfo[position].createdAt)}",
                                          textScaleFactor: 1.0,
                                          style: TextStyle(fontSize: 15),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 45,
                                  ),
                                  Container(
                                      padding: EdgeInsets.only(left: 0),
                                      child: FlatButton(
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                CustomDialog(
                                              title: _currentSelectedLocation,
                                              description: null,
                                              buttonText: "Okay",
                                            ),
                                          );
                                        },
                                        child: Text(
                                          "Change Location",
                                          textScaleFactor: 1.0,
                                          style: TextStyle(
                                              color: Colors.redAccent,
                                              fontSize: 17),
                                        ),
                                      ))
                                ],
                              ),
                            ),
                            // aqi info
                            Container(
                              width: 135,
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    "AQI",
                                    textScaleFactor: 1.0,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: changeaqibg(double.parse(
                                            _calculateAQI(aqiinfo))),
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    width: 90,
                                    height: 90,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          _calculateAQI(aqiinfo),
                                          textScaleFactor: 1.0,
                                          style: TextStyle(
                                              fontSize: 35,
                                              color: Colors.white),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // sub tiles
                  // row 1 temp , humidity, Ozone
                  Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.blueGrey,
                                ),
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(1.0),
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                    offset: Offset(0, 4),
                                  )
                                ]),
                            width: 122,
                            height: 130,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "Temperature",
                                  textScaleFactor: 1.0,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                                aqiinfo[position].temperature == null
                                    ? Text("0", style: TextStyle(fontSize: 23))
                                    : Text("${aqiinfo[position].temperature}",
                                        style: TextStyle(fontSize: 23)),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                              // padding: EdgeInsets.only(top: 30),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Colors.blueGrey,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(1.0),
                                      spreadRadius: 1,
                                      blurRadius: 5,
                                      offset: Offset(0, 4),
                                    )
                                  ]),
                              width: 122,
                              height: 130,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    "Humidity",
                                    textScaleFactor: 1.0,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                  aqiinfo[position].humidity == null
                                      ? Text("0",
                                          style: TextStyle(fontSize: 23))
                                      : Text(
                                          "${_returnclean(aqiinfo[position].humidity)}",
                                          style: TextStyle(fontSize: 23)),
                                ],
                              )),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Colors.blueGrey,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(1.0),
                                      spreadRadius: 1,
                                      blurRadius: 5,
                                      offset: Offset(0, 4),
                                    )
                                  ]),
                              width: 122,
                              height: 130,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    "Ozone",
                                    textScaleFactor: 1.0,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                  aqiinfo[position].o3 == null
                                      ? Text("0",
                                          style: TextStyle(fontSize: 23))
                                      : Text("${aqiinfo[position].o3}",
                                          style: TextStyle(fontSize: 23)),
                                ],
                              )),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 13,
                  ),
                  // row 2 no2, so2, co
                  Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Colors.blueGrey,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(1.0),
                                      spreadRadius: 1,
                                      blurRadius: 5,
                                      offset: Offset(0, 4),
                                    )
                                  ]),
                              width: 122,
                              height: 130,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    "NO₂",
                                    textScaleFactor: 1.0,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                  aqiinfo[position].no2 == null
                                      ? Text("0",
                                          style: TextStyle(fontSize: 23))
                                      : Text("${aqiinfo[position].no2}",
                                          style: TextStyle(fontSize: 23)),
                                ],
                              )),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Colors.blueGrey,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(1.0),
                                      spreadRadius: 1,
                                      blurRadius: 5,
                                      offset: Offset(0, 4),
                                    )
                                  ]),
                              width: 122,
                              height: 130,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    "SO₂",
                                    textScaleFactor: 1.0,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                  aqiinfo[position].so2 == null
                                      ? Text("0",
                                          style: TextStyle(fontSize: 23))
                                      : Text("${aqiinfo[position].so2}",
                                          style: TextStyle(fontSize: 23)),
                                ],
                              )),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Colors.blueGrey,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(1.0),
                                      spreadRadius: 1,
                                      blurRadius: 5,
                                      offset: Offset(0, 4),
                                    )
                                  ]),
                              width: 122,
                              height: 130,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    "CO",
                                    textScaleFactor: 1.0,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                  aqiinfo[position].co == null
                                      ? Text("0",
                                          style: TextStyle(fontSize: 23))
                                      : Text("${aqiinfo[position].co}",
                                          style: TextStyle(fontSize: 23)),
                                ],
                              )),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 13,
                  ),
                  // row 3 pm 2.5, pm 10
                  Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          SizedBox(
                            width: 25,
                          ),
                          Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Colors.blueGrey,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(1.0),
                                      spreadRadius: 1,
                                      blurRadius: 5,
                                      offset: Offset(0, 4),
                                    )
                                  ]),
                              width: 122,
                              height: 130,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    "PM 2.5",
                                    textScaleFactor: 1.0,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                  aqiinfo[position].pm25 == null
                                      ? Text("0",
                                          style: TextStyle(fontSize: 23))
                                      : Text("${aqiinfo[position].pm25}",
                                          style: TextStyle(fontSize: 23)),
                                ],
                              )),
                          Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Colors.blueGrey,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(1.0),
                                      spreadRadius: 1,
                                      blurRadius: 5,
                                      offset: Offset(0, 4),
                                    )
                                  ]),
                              width: 122,
                              height: 130,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    "PM 10",
                                    textScaleFactor: 1.0,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                  aqiinfo[position].pm10 == null
                                      ? Text("0",
                                          style: TextStyle(fontSize: 23))
                                      : Text("${aqiinfo[position].pm10}",
                                          style: TextStyle(fontSize: 23)),
                                ],
                              )),
                          SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    // rebuildAllChildren(context);
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
            future: getData(),
            builder: (context, snapshot) {
              return snapshot.data != null
                  ? listViewWidget(snapshot.data)
                  : Center(
                      child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SpinKitWanderingCubes(
                          color: const Color(0xFFFFBA02),
                          size: 40,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text("Updating data...")
                      ],
                    ));
            }),
      ),
    );
  }
}
