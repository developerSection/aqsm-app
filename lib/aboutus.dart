import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';
import 'package:flutter/gestures.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            color: Color(0xffe8e8e8),
          ),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.teal,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    "CONTACT US",
                    textScaleFactor: 1,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                // Supervisor
                Container(
                  decoration: BoxDecoration(
                      color: Colors.blue.shade300,
                      borderRadius: BorderRadius.circular(8)),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, top: 10, bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Supervisor:",
                          textScaleFactor: 1,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1),
                        ),
                        Text(
                          "\nDr Sajjad Ali Haider,",
                          textScaleFactor: 1,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "Assosiate Professor, \nComsats University Islamabad,",
                          textScaleFactor: 1,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w300),
                        ),
                        Text(
                          "Email: sajjadali@ciitwah.edu.pk",
                          textScaleFactor: 1,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                // Project Members
                Container(
                  decoration: BoxDecoration(
                      color: Colors.blue.shade300,
                      borderRadius: BorderRadius.circular(8)),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, top: 10, bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Project Members:\n",
                          textScaleFactor: 1,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "1.\t Junaid khan",
                          textScaleFactor: 1,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w400),
                        ),
                        Text(
                          "\tEmail: mrjunaidkhan@gmail.com \n\tCell no : +923048970987",
                          textScaleFactor: 1,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w300),
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Text(
                          "2.\t Sohaib Bajwa ",
                          textScaleFactor: 1,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w400),
                        ),
                        Text(
                          "\tEmail: Sohaib10bajwa@gmail.com \n\tCell no : +923028142669",
                          textScaleFactor: 1,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w300),
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Text(
                          "3.\t Anum Mumtaz ",
                          textScaleFactor: 1,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w400),
                        ),
                        Text(
                          "\tEmail: anum3245@gmail.com",
                          textScaleFactor: 1,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w300),
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Text(
                          "4.\t Aqsa Sultana",
                          textScaleFactor: 1,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w400),
                        ),
                        Text(
                          "\tEmail: aqsakhan8989@gmail.com",
                          textScaleFactor: 1,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                // Organization
                Container(
                  padding: const EdgeInsets.only(
                      left: 15, right: 15, top: 10, bottom: 10),
                  decoration: BoxDecoration(
                      color: Colors.orangeAccent.shade200,
                      borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Organization:",
                        textScaleFactor: 1,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Comsats University Islamabad Wah Campus",
                        textScaleFactor: 1,
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.teal.shade300,
                    borderRadius: BorderRadius.circular(6)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: new Center(
                      child: new RichText(
                        text: new TextSpan(
                          children: [
                            new TextSpan(
                              text: 'Click here to visit Website.',
                              style: new TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400),
                              recognizer: new TapGestureRecognizer()
                                ..onTap = () {
                                  launch('https://aqsm.netlify.app/');
                                },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
