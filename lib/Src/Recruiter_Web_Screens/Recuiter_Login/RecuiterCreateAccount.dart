import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:getifyjobs/Src/Common_Widgets/Common_Candidate_Profile.dart';
import 'package:getifyjobs/Src/Common_Widgets/Text_Form_Field.dart';
import 'package:getifyjobs/Src/utilits/Common_Colors.dart';
import 'package:getifyjobs/Src/utilits/Text_Style.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'WebRecutierProfileExperence.dart';

class WebRecutierExperience1 extends StatefulWidget {
  const WebRecutierExperience1({super.key});
  @override
  State<WebRecutierExperience1> createState() =>
      _WebRecutierExperience1State();
}

class _WebRecutierExperience1State extends State<WebRecutierExperience1> {
  String qrData = "https://example.com";
  bool isReschedulePressed = false;
  bool isYes = false;
  bool isNo = false;
  bool Click = false;
  bool Sumit = false;
  bool Confirm = false;
  bool Uploadsumit = false;
  bool Rejected = false;
  bool show = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: white2,
          title: Text("Profile", style: recbalck),
          centerTitle: true,
          leading: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          WebRecutierExperience1()), // Replace SecondPage() with the actual widget you want to navigate to
                );
                ;
              },
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Black,
              ))),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _showDialog(context);
          },
          child: Text('Press Me'),
        ),
      ),
    );
  }
  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Container(
              width: MediaQuery.of(context).size.width * 0.50,
              height: MediaQuery.of(context).size.height,
              child: WebRecuiterProfileExperence()),
          actions: <Widget>[
            ElevatedButton(
              child: Text("Close"),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

//QR CODE
}


