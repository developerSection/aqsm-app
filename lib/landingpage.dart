import 'package:aqsm/main.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_spinkit/flutter_spinkit.dart';



class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
  
}

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    Timer(
      Duration(milliseconds: 2500),
      () => {
        Navigator.of(context).pushReplacement(new MaterialPageRoute(
          builder: (BuildContext context) => new MyHomePage(),
        )),
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFF0D1F35)
              ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                          backgroundColor: Color(0xFF0D1F35),
                          radius: 100,
                          child: Container(
                            decoration: BoxDecoration(
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                    color: Color(0xFF0D1F35),
                                    offset: Offset(1.0, 5.0),
                                    blurRadius: 20,
                                  )
                                ],
                                image: DecorationImage(
                                  image: ExactAssetImage(
                                      'images/logo.png'),
                                  fit: BoxFit.contain,
                                ),
                                borderRadius: BorderRadius.circular(10)),
                          )),
                      Padding(
                        padding: EdgeInsets.only(
                          top: 35,
                        ),
                      ),
                      // SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(left: 40, right: 40),
                        child: Center(
                          child: Text(
                            "AIR QUALITY SENSING AND MONITORING SYSTEM",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color(0xFFFFBA02),
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 3,
                              fontFamily: 'Monospace',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SpinKitWanderingCubes(
                      color: const Color(0xFFFFBA02),
                      size: 40,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                    ),
                    SizedBox(height: 15,),
                    Text('Loading...', style: TextStyle(color: Colors.white),)
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
