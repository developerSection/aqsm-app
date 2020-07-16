import 'package:aqsm/aboutus.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class Misc extends StatefulWidget {
  @override
  _MiscState createState() => _MiscState();
}

class _MiscState extends State<Misc> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "About AQI Level",
            textAlign: TextAlign.center,
          ),
        ),
        elevation: 10,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: new Color(0xFFe8e8e8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFe8e8e8),
                      border: Border(
                          top: BorderSide.none,
                          left: BorderSide.none,
                          right: BorderSide.none,
                          bottom: BorderSide.none),
                    ),
                    height: 320.0,
                    child: ClipRect(
                      child: PhotoView.customChild(
                        child: Container(
                          decoration: const BoxDecoration(color: Colors.black),
                          // padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(
                                "images/table.png",
                                height: 300.0,
                              )
                            ],
                          ),
                        ),
                        initialScale: 1.0,
                        enableRotation: false,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: RaisedButton(
                elevation: 5,
                color: Colors.teal.shade300,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => new AboutUs()));
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 30, right: 30, top: 15, bottom: 15),
                  child: Text(
                    'Contact Us',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w300),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 100,
            )
          ],
        ),
      ),
    );
  }
}
