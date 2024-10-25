import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:getifyjobs/Src/Common_Widgets/Common_Candidate_Profile.dart';
import 'package:getifyjobs/Src/Common_Widgets/Text_Form_Field.dart';
import 'package:getifyjobs/Src/utilits/Common_Colors.dart';
import 'package:getifyjobs/Src/utilits/Text_Style.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../Common_Widgets/Common_Qrcode_Scanner.dart';

class WebRecutierExperience extends StatefulWidget {
  const WebRecutierExperience({super.key});

  @override
  State<WebRecutierExperience> createState() => _WebRecutierExperienceState();
}

class _WebRecutierExperienceState extends State<WebRecutierExperience> {
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
                      builder: (context) => WebRecutierExperience()),
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
        return Container(
          child: AlertDialog(
            title: SingleChildScrollView(
              child: Center(
                child: Container(
                  color: Colors.blue,
                  child: Expanded(
                    child: Column(
                      children: [
                        Visibility(
                          visible: isReschedulePressed && !isYes && !isNo,
                          child: Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Text(
                              "You Scheduled Interview on",
                              style: Wgrey,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Visibility(
                          visible: !isReschedulePressed && !isYes && !isNo,
                          child: Text(
                            "9.00 AM, 02 Oct 2023",
                            style: Wgrey1,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Visibility(
                          visible: !isReschedulePressed && !isYes && !isNo,
                          child: Text(
                            "Candidate Requested for",
                            maxLines: 2,
                            style: Wbalck4,
                          ),
                        ),
                        Visibility(
                          visible: !isReschedulePressed && !isYes && !isNo,
                          child: Text(
                            " Reschedule?",
                            style: Wbalck4,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Visibility(
                          visible: !isReschedulePressed && !isYes && !isNo,
                          child: Text(
                            " Are you okay with the date & time?",
                            style: Wbalck5,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Visibility(
                          visible: !isReschedulePressed && !isYes && !isNo,
                          child: Text(
                            " 9.00 AM, 02 Oct 2023",
                            style: Wbalck5,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        YesNo(),
                        No(),
                        isyes(),
                        sumit(context),
                        Reject(),
                        uploadsumit(),
                        isreshuledpressed(),
                        click(),

                        SizedBox(
                          height: 10,
                        ),
                        // ElevatedButton(
                        //   onPressed: () {
                        //     _showDialog(context);
                        //   },
                        //   child: Text('Press Me'),
                        // ),
                        Container(
                            height: 200,
                            child: Expanded(
                                child: Direct_Candidate_Profile_Screen(
                                  TagContain: '', candidate_Id: '', job_Id: '',
                            ))),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                child: Text("Close"),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget isyes() {
    return Column(
      children: [
        Visibility(
          visible: isYes && !Uploadsumit && !Rejected && !show,
          child: Container(
            color: white1,
            width: double.infinity,
            child: Container(
              margin: EdgeInsets.only(
                top: 20,
                bottom: 20,
              ),
              child: Column(
                children: [
                  Visibility(
                    visible: !Click,
                    child: Text(
                      "Candidate Accepted the",
                      style: Wbalck4,
                    ),
                  ),
                  Visibility(
                    visible: !Click,
                    child: Text(
                      "Interview",
                      style: Wbalck4,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Visibility(
                    visible: !Click,
                    child: Container(
                      margin: EdgeInsets.only(right: 20, left: 5, bottom: 5),
                      decoration: BoxDecoration(
                        color: blue1,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    QRCodeScannerApp()), // Replace SecondScreen() with the screen you want to navigate to
                          );
                        },
                        // onTap: () {
                        //   setState(() {
                        //     Click = true;
                        //   }
                        //
                        //   );
                        // },
                        child: Container(
                          margin: EdgeInsets.only(
                              right: 38, left: 38, top: 16, bottom: 16),
                          child: Text(
                            "Click to Scan",
                            style: Homewhite3,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: !Click,
                    child: Container(
                      margin: EdgeInsets.only(right: 38, left: 38),
                      child: Text(
                        "When Candidate Reached Office ",
                        style: Wbalck2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        // Add the text below the container for isYes
        Visibility(
          visible: isYes &&
              !Click, // This makes sure the text is only shown for isYes
          child: Column(
            children: [
              Text(
                "You Scheduled Video Interview on",
                style: Wgrey,
              ),
              Text(
                "9.00 AM, 02 Oct 2023",
                style: Secblack,
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget click() {
    return Visibility(
        visible: Click && !Sumit && !Uploadsumit,
        child: Column(
          children: [
            Visibility(
              visible: Click &&
                  !Sumit, // This makes sure the text is only shown for isYes
              child: Column(
                children: [
                  Text(
                    "You Scheduled Video Interview on",
                    style: Wgrey,
                  ),
                  Text(
                    "9.00 AM, 02 Oct 2023",
                    style: Secblack,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            Container(
              color: white1,
              width: double.infinity,
              child: Container(
                margin: EdgeInsets.only(
                  top: 20,
                  bottom: 20,
                ),
                child: Column(
                  children: [
                    Text(
                      "Feedback about Candidate",
                      style: Wbalck4,
                    ),
                    Container(
                        margin: EdgeInsets.only(
                            right: 20, left: 20, top: 10, bottom: 15),
                        child: textfieldDescription(hintT: 'Write Feed Back',)),
                    Container(
                      margin: EdgeInsets.only(
                          right: 5, left: 5, top: 16, bottom: 20),
                      decoration: BoxDecoration(
                        color: blue1,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: InkWell(
                        //sumit
                        onTap: () {
                          setState(() {
                            Sumit = true;
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                              right: 60, left: 60, top: 16, bottom: 16),
                          child: Text(
                            "Sumit",
                            style: Homewhite3,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  Widget isreshuledpressed() {
    return Visibility(
        visible: isReschedulePressed,
        child: Column(
          children: [
            Visibility(
              visible: isReschedulePressed,
              // This makes sure the text is only shown for isYes
              child: Column(
                children: [
                  Text(
                    "You Scheduled Video Interview on",
                    style: Wgrey,
                  ),
                  Text(
                    "9.00 AM, 02 Oct 2023",
                    style: Secblack,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            Container(
              color: yellow2,
              width: double.infinity,
              child: Container(
                margin: EdgeInsets.only(
                  top: 20,
                  bottom: 20,
                ),
                child: Column(
                  children: [
                    Text(
                      "Waiting for Candidate",
                      style: Yellow,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Candidate",
                      style: Yellow,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  Widget uploadsumit() {
    return Visibility(
        visible: Uploadsumit,
        child: Container(
          color: green3,
          width: double.infinity,
          child: Container(
            margin: EdgeInsets.only(
              top: 20,
              bottom: 20,
            ),
            child: Column(
              children: [
                Text(
                  "You Selected the Candidate",
                  style: green12,
                ),
              ],
            ),
          ),
        ));
  }

  Widget Reject() {
    return Visibility(
        visible: Rejected,
        child: Container(
          color: red4,
          width: double.infinity,
          child: Container(
            margin: EdgeInsets.only(
              top: 20,
              bottom: 20,
            ),
            child: Center(
              child: Text(
                "You Rejected the Candidate",
                style: red12,
              ),
            ),
          ),
        ));
  }

  Widget sumit(BuildContext context) {
    return Visibility(
        visible: Sumit && !Uploadsumit && !Rejected,
        child: Column(
          children: [
            Visibility(
              visible: Sumit && !Uploadsumit,
              // This makes sure the text is only shown for isYes
              child: Column(
                children: [
                  Text(
                    "You Scheduled Video Interview on",
                    style: Wgrey,
                  ),
                  Text(
                    "9.00 AM, 02 Oct 2023",
                    style: Secblack,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            Container(
              color: white1,
              width: double.infinity,
              child: Container(
                margin: EdgeInsets.only(
                  top: 20,
                  bottom: 20,
                ),
                child: Column(
                  children: [
                    Text(
                      "Interview Result",
                      style: Wbalck4,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              right: 5, left: 20, top: 16, bottom: 16),
                          decoration: BoxDecoration(
                            border: Border.all(color: blue1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                Rejected = true;
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                  right: 38, left: 38, top: 16, bottom: 16),
                              child: Text(
                                "Reject",
                                style: bluetxt,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              Confirm = true;
                            });
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Container(
                                    margin:
                                        EdgeInsets.only(right: 10, left: 10),
                                    child: Column(
                                      children: [
                                        Text(
                                          "Are you sure to select him/",
                                          maxLines: 1,
                                          style: Wbalck4,
                                        ),
                                        Text(
                                          "her for an interview?",
                                          style: Wbalck4,
                                        ),
                                      ],
                                    ),
                                  ),
                                  content: Container(
                                    margin:
                                        EdgeInsets.only(right: 10, left: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(
                                              right: 5, top: 16, bottom: 16),
                                          decoration: BoxDecoration(
                                            border: Border.all(color: blue1),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                  right: 20,
                                                  left: 20,
                                                  top: 16,
                                                  bottom: 16),
                                              child: Text(
                                                "Cancel",
                                                style: bluetxt,
                                              ),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              Confirm = true;
                                            });
                                            Navigator.of(context)
                                                .pop(); // Close the first dialog
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: Container(
                                                      margin: EdgeInsets.only(
                                                          right: 20, left: 20),
                                                      child: DottedBorder(
                                                        borderType:
                                                            BorderType.RRect,
                                                        radius:
                                                            Radius.circular(10),
                                                        padding:
                                                            EdgeInsets.all(6),
                                                        color: grey5,
                                                        // Color of the dots and border
                                                        child: Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  top: 20,
                                                                  bottom: 20,
                                                                  left: 20,
                                                                  right: 20),
                                                          child: Center(
                                                              child: Text(
                                                                  "+ Upload Offer Letter",
                                                                  style:
                                                                      recblack3)), // Color inside the container
                                                        ),
                                                      )),
                                                  content: Row(
                                                    children: [
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            right: 5,
                                                            left: 20,
                                                            top: 16,
                                                            bottom: 16),
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                              color: blue1),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        child: InkWell(
                                                          onTap: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child: Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    right: 30,
                                                                    left: 30,
                                                                    top: 16,
                                                                    bottom: 16),
                                                            child: Text(
                                                              "Cancel",
                                                              style: bluetxt,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          setState(() {
                                                            Uploadsumit = true;
                                                          });
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  top: 16,
                                                                  bottom: 16),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: blue1,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                          child: Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    right: 35,
                                                                    left: 35,
                                                                    top: 16,
                                                                    bottom: 16),
                                                            child: Text(
                                                              "Sumit",
                                                              style: Homewhite3,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  actions: <Widget>[],
                                                );
                                              },
                                            );
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                right: 5, top: 16, bottom: 16),
                                            decoration: BoxDecoration(
                                              color: blue1,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                  right: 20,
                                                  left: 20,
                                                  top: 16,
                                                  bottom: 16),
                                              child: Text(
                                                "Confirm",
                                                style: Homewhite3,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                                right: 5, left: 20, top: 16, bottom: 16),
                            decoration: BoxDecoration(
                              color: blue1,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Container(
                              margin: EdgeInsets.only(
                                  right: 38, left: 38, top: 16, bottom: 16),
                              child: Text(
                                "Selected",
                                style: Homewhite3,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  Widget No() {
    return Visibility(
        visible: isNo,
        child: Column(
          children: [
            Container(
              color: grey4,
              width: MediaQuery.of(context).size.width * 0.35,
              child: Container(
                margin: EdgeInsets.only(
                  top: 20,
                  bottom: 20,
                ),
                child: Column(
                  children: [
                    Text(
                      "Candiate is not selected",
                      style: Homewhite4,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Candidate",
                      style: Homewhite4,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Visibility(
              visible: isNo, // This makes sure the text is only shown for isYes
              child: Column(
                children: [
                  Text(
                    "You Scheduled Video Interview on",
                    style: Wgrey,
                  ),
                  Text(
                    "9.00 AM, 02 Oct 2023",
                    style: Secblack,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Candidate Requested Video Interview on"),
                  Text(
                    "9.00 AM, 02 Oct 2023",
                    style: Secblack,
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  Widget YesNo() {
    return Visibility(
      visible: !isReschedulePressed && !isYes && !isNo,
      child: Center(
        child: Row(
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  isYes = true;
                });
              },
              child: Container(
                margin:
                    EdgeInsets.only(right: 5, left: 20, top: 16, bottom: 16),
                decoration: BoxDecoration(
                  color: blue1,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  margin:
                      EdgeInsets.only(right: 30, left: 30, top: 16, bottom: 16),
                  child: Text(
                    "Yes",
                    style: Homewhite3,
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  isReschedulePressed = true;
                });
              },
              child: Container(
                margin: EdgeInsets.only(right: 5, left: 5, top: 16, bottom: 16),
                decoration: BoxDecoration(
                  color: blue1,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  margin:
                      EdgeInsets.only(right: 30, left: 30, top: 16, bottom: 16),
                  child: Text(
                    "Reschedule",
                    style: Homewhite3,
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  isNo = true;
                });
              },
              child: GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Container(
                          color: red4,
                          width: double.infinity,
                          child: Container(
                            margin: EdgeInsets.only(
                              top: 20,
                              bottom: 20,
                            ),
                            child: Center(
                              child: Text(
                                "You Rejected the Candidate",
                                style: red12,
                              ),
                            ),
                          ),
                        ),
                        content: Text("Dialog Content"),
                        actions: [
                          TextButton(
                            child: Text("Close"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Container(
                  margin: EdgeInsets.only(
                    right: 20,
                    left: 5,
                    top: 16,
                    bottom: 16,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: blue1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    margin: EdgeInsets.only(
                      right: 30,
                      left: 30,
                      top: 14,
                      bottom: 14,
                    ),
                    child: Text(
                      "No",
                      style: bluetxt,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

//QR CODE
}

// import 'package:dotted_border/dotted_border.dart';
// import 'package:flutter/material.dart';
// import 'package:getifyjobs/Src/Candidate_Mobile_Screens/Job_Detail_Screens/Campus_Job_Detail_UI/Campus_Job_Detail_Page.dart';
// import 'package:getifyjobs/Src/Candidate_Mobile_Screens/Job_Detail_Screens/Qr_Page.dart';
// import 'package:getifyjobs/Src/Common_Widgets/Common_Candidate_Profile.dart';
// import 'package:getifyjobs/Src/Common_Widgets/Custom_App_Bar.dart';
// import 'package:getifyjobs/Src/Common_Widgets/Text_Form_Field.dart';
// import 'package:getifyjobs/Src/utilits/Common_Colors.dart';
// import 'package:getifyjobs/Src/utilits/Text_Style.dart';
// import 'package:qr_flutter/qr_flutter.dart';
//
// class WebRecuiterExperienece extends StatefulWidget {
//   const WebRecuiterExperienece({super.key});
//   @override
//   State<WebRecuiterExperienece> createState() =>
//       _WebRecuiterExperieneceState();
// }
//
// class _WebRecuiterExperieneceState extends State<WebRecuiterExperienece> {
//   String qrData = "https://example.com";
//   bool isReschedulePressed = false;
//   bool isYes = false;
//   bool isNo = false;
//   bool Click = false;
//   bool Sumit = false;
//   bool Confirm = false;
//   bool Uploadsumit = false;
//   bool Rejected = false;
//   bool show = false;
//   bool showCodeBlock = false;
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//           elevation: 0,
//           backgroundColor: white2,
//           title: Text("Profile", style: recbalck),
//           centerTitle: true,
//           leading: InkWell(
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) =>
//                           WebRecuiterExperienece()), // Replace SecondPage() with the actual widget you want to navigate to
//                 );
//                 ;
//               },
//               child: Icon(
//                 Icons.arrow_back_ios_new_rounded,
//                 color: Black,
//               ))),
//       body:
//        Center(
//           child:
//           SingleChildScrollView(
//             child: Container(
//               decoration: BoxDecoration(
//                   color: white1,
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(20.0),
//                   topRight: Radius.circular(20.0),
//                   bottomLeft: Radius.circular(20.0),
//                   bottomRight: Radius.circular(20.0),
//                 ),
//               ),
//               margin: EdgeInsets.only(top: 20, bottom: 20),
//               width: MediaQuery.of(context).size.width *0.35,
//               height: MediaQuery.of(context).size.height,
//
//               child: Column(
//                 children: [
//                   Custom_AppBar(isUsed: false, actions: [
//                     IconButton(onPressed: () {
//                       Navigator.of(context).pop();
//                     }, icon: Icon(Icons.close))
//                   ], isLogoUsed: false,
//                     isTitleUsed: false,title: "profile",),
//                   Visibility(
//                     visible: !isReschedulePressed && !isYes && !isNo,
//                     child: Container(
//                       margin: EdgeInsets.only(top: 20),
//                       child: Text(
//                         "You Scheduled Interview on",
//                         style: Wgrey,
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 5,
//                   ),
//                   Visibility(
//                     visible: !isReschedulePressed && !isYes && !isNo,
//                     child: Text(
//                       "9.00 AM, 02 Oct 2023",
//                       style: Wgrey1,
//                     ),
//                   ),
//                   SizedBox(
//                     height: 5,
//                   ),
//                   Visibility(
//                     visible: !isReschedulePressed && !isYes && !isNo,
//                     child: Text(
//                       "Candidate Requested for",
//                       maxLines: 2,
//                       style: Wbalck4,
//                     ),
//                   ),
//                   Visibility(
//                     visible: !isReschedulePressed && !isYes && !isNo,
//                     child: Text(
//                       " Reschedule?",
//                       style: Wbalck4,
//                     ),
//                   ),
//                   SizedBox(
//                     height: 5,
//                   ),
//                   Visibility(
//                     visible: !isReschedulePressed && !isYes && !isNo,
//                     child: Text(
//                       " Are you okay with the date & time?",
//                       style: Wbalck5,
//                     ),
//                   ),
//                   SizedBox(
//                     height: 5,
//                   ),
//                   Visibility(
//                     visible: !isReschedulePressed && !isYes && !isNo,
//                     child: Text(
//                       " 9.00 AM, 02 Oct 2023",
//                       style: Wbalck5,
//                     ),
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   YesNo(),
//                   No(),
//                   sumit(context),
//                   Reject(),
//                   uploadsumit(),
//                   isreshuledpressed(),
//                   click(),
//                   isyes(),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Expanded(child: Common_Candidate_Profile_Screen(isPdfNeeded: false, isCampus: false, TagContain: '',)),
//
//                 ],
//               ),
//             ),
//           ),
//         ),
//
//     );
//   }
//
//   Widget isyes() {
//     return Column(
//       children: [
//         Visibility(
//           visible: isYes && !Uploadsumit && !Rejected && !show,
//           child: Container(
//             color: white1,
//             width: double.infinity,
//             child: Container(
//               margin: EdgeInsets.only(
//                 top: 20,
//                 bottom: 20,
//               ),
//               child: Column(
//                 children: [
//                   Visibility(
//                     visible: !Click,
//                     child: Text(
//                       "Candidate Accepted the",
//                       style: Wbalck4,
//                     ),
//                   ),
//                   Visibility(
//                     visible: !Click,
//                     child: Text(
//                       "Interview",
//                       style: Wbalck4,
//                     ),
//                   ),
//                   SizedBox(
//                     height: 5,
//                   ),
//                   Visibility(
//                     visible: !Click,
//                     child: Container(
//                       margin: EdgeInsets.only(right: 20, left: 5, bottom: 5),
//                       decoration: BoxDecoration(
//                         color: blue1,
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: InkWell(
//                         onTap: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(builder: (context) => QRCodeScannerApp()), // Replace SecondScreen() with the screen you want to navigate to
//                           );
//                         },
//                         // onTap: () {
//                         //   setState(() {
//                         //     Click = true;
//                         //   }
//                         //
//                         //   );
//                         // },
//                         child: Container(
//                           margin: EdgeInsets.only(
//                               right: 38, left: 38, top: 16, bottom: 16),
//                           child: Text(
//                             "Click to Scan",
//                             style: Homewhite3,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Visibility(
//                     visible: !Click,
//                     child: Container(
//                       margin: EdgeInsets.only(right: 38, left: 38),
//                       child: Text(
//                         "When Candidate Reached Office ",
//                         style: Wbalck2,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//         SizedBox(
//           height: 10,
//         ),
//         // Add the text below the container for isYes
//         Visibility(
//           visible: isYes &&
//               !Click, // This makes sure the text is only shown for isYes
//           child: Column(
//             children: [
//               Text(
//                 "You Scheduled Video Interview on",
//                 style: Wgrey,
//               ),
//               Text(
//                 "9.00 AM, 02 Oct 2023",
//                 style: Secblack,
//               )
//             ],
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget click() {
//     return Visibility(
//         visible: Click && !Sumit && !Uploadsumit,
//         child: Column(
//           children: [
//             Visibility(
//               visible: Click &&
//                   !Sumit, // This makes sure the text is only shown for isYes
//               child: Column(
//                 children: [
//                   Text(
//                     "You Scheduled Video Interview on",
//                     style: Wgrey,
//                   ),
//                   Text(
//                     "9.00 AM, 02 Oct 2023",
//                     style: Secblack,
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//               color: white1,
//               width: double.infinity,
//               child: Container(
//                 margin: EdgeInsets.only(
//                   top: 20,
//                   bottom: 20,
//                 ),
//                 child: Column(
//                   children: [
//                     Text(
//                       "Feedback about Candidate",
//                       style: Wbalck4,
//                     ),
//                     Container(
//                         margin: EdgeInsets.only(
//                             right: 20, left: 20, top: 10, bottom: 15),
//                         child: textfieldDescription()),
//                     Container(
//                       margin: EdgeInsets.only(
//                           right: 5, left: 5, top: 16, bottom: 20),
//                       decoration: BoxDecoration(
//                         color: blue1,
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: InkWell(
//                         //sumit
//                         onTap: () {
//                           setState(() {
//                             Sumit = true;
//                           });
//                         },
//                         child: Container(
//                           margin: EdgeInsets.only(
//                               right: 60, left: 60, top: 16, bottom: 16),
//                           child: Text(
//                             "Sumit",
//                             style: Homewhite3,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ));
//   }
//
//   Widget isreshuledpressed() {
//     return Visibility(
//         visible: isReschedulePressed,
//         child: Column(
//           children: [
//             Visibility(
//               visible:
//               isReschedulePressed, // This makes sure the text is only shown for isYes
//               child: Column(
//                 children: [
//                   Text(
//                     "You Scheduled Video Interview on",
//                     style: Wgrey,
//                   ),
//                   Text(
//                     "9.00 AM, 02 Oct 2023",
//                     style: Secblack,
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//               color: yellow2,
//               width: double.infinity,
//               child: Container(
//                 margin: EdgeInsets.only(
//                   top: 20,
//                   bottom: 20,
//                 ),
//                 child: Column(
//                   children: [
//                     Text(
//                       "Waiting for Candidate",
//                       style: Yellow,
//                     ),
//                     SizedBox(
//                       height: 5,
//                     ),
//                     Text(
//                       "Candidate",
//                       style: Yellow,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ));
//   }
//
//   Widget uploadsumit() {
//     return Visibility(
//         visible: Uploadsumit,
//         child: Container(
//           color: green3,
//           width: double.infinity,
//           child: Container(
//             margin: EdgeInsets.only(
//               top: 20,
//               bottom: 20,
//             ),
//             child: Column(
//               children: [
//                 Text(
//                   "You Selected the Candidate",
//                   style: green12,
//                 ),
//               ],
//             ),
//           ),
//         ));
//   }
//
//   Widget Reject() {
//     return Visibility(
//         visible: Rejected,
//         child: Container(
//           color: red4,
//           width: double.infinity,
//           child: Container(
//             margin: EdgeInsets.only(
//               top: 20,
//               bottom: 20,
//             ),
//             child: Center(
//               child: Text(
//                 "You Rejected the Candidate",
//                 style: red12,
//               ),
//             ),
//           ),
//         ));
//   }
//
//   Widget sumit(BuildContext context) {
//     return Visibility(
//         visible: Sumit && !Uploadsumit && !Rejected,
//         child: Column(
//           children: [
//             Visibility(
//               visible: Sumit &&
//                   !Uploadsumit, // This makes sure the text is only shown for isYes
//               child: Column(
//                 children: [
//                   Text(
//                     "You Scheduled Video Interview on",
//                     style: Wgrey,
//                   ),
//                   Text(
//                     "9.00 AM, 02 Oct 2023",
//                     style: Secblack,
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//               color: white1,
//               width: double.infinity,
//               child: Container(
//                 margin: EdgeInsets.only(
//                   top: 20,
//                   bottom: 20,
//                 ),
//                 child: Column(
//                   children: [
//                     Text(
//                       "Interview Result",
//                       style: Wbalck4,
//                     ),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Container(
//                           margin: EdgeInsets.only(
//                               right: 5, left: 20, top: 16, bottom: 16),
//                           decoration: BoxDecoration(
//                             border: Border.all(color: blue1),
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           child: InkWell(
//                             onTap: () {
//                               setState(() {
//                                 Rejected = true;
//                               });
//                             },
//                             child: Container(
//                               margin: EdgeInsets.only(
//                                   right: 38, left: 38, top: 16, bottom: 16),
//                               child: Text(
//                                 "Reject",
//                                 style: bluetxt,
//                               ),
//                             ),
//                           ),
//                         ),
//                         GestureDetector(
//                           onTap: () {
//                             setState(() {
//                               Confirm = true;
//                             });
//                             showDialog(
//                               context: context,
//                               builder: (BuildContext context) {
//                                 return AlertDialog(
//                                   title: Container(
//                                     margin:
//                                     EdgeInsets.only(right: 10, left: 10),
//                                     child: Column(
//                                       children: [
//                                         Text(
//                                           "Are you sure to select him/",
//                                           maxLines: 1,
//                                           style: Wbalck4,
//                                         ),
//                                         Text(
//                                           "her for an interview?",
//                                           style: Wbalck4,
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   content: Container(
//                                     margin:
//                                     EdgeInsets.only(right: 10, left: 10),
//                                     child: Row(
//                                       mainAxisAlignment:
//                                       MainAxisAlignment.center,
//                                       children: [
//                                         Container(
//                                           margin: EdgeInsets.only(
//                                               right: 5, top: 16, bottom: 16),
//                                           decoration: BoxDecoration(
//                                             border: Border.all(color: blue1),
//                                             borderRadius:
//                                             BorderRadius.circular(10),
//                                           ),
//                                           child: InkWell(
//                                             onTap: () {
//                                               Navigator.of(context).pop();
//                                             },
//                                             child: Container(
//                                               margin: EdgeInsets.only(
//                                                   right: 20,
//                                                   left: 20,
//                                                   top: 16,
//                                                   bottom: 16),
//                                               child: Text(
//                                                 "Cancel",
//                                                 style: bluetxt,
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                         InkWell(
//                                           onTap: () {
//                                             setState(() {
//                                               Confirm = true;
//                                             });
//                                             Navigator.of(context)
//                                                 .pop(); // Close the first dialog
//                                             showDialog(
//                                               context: context,
//                                               builder: (BuildContext context) {
//                                                 return AlertDialog(
//                                                   title: Container(
//                                                       margin: EdgeInsets.only(
//                                                           right: 20, left: 20),
//                                                       child: DottedBorder(
//                                                         borderType:
//                                                         BorderType.RRect,
//                                                         radius:
//                                                         Radius.circular(10),
//                                                         padding:
//                                                         EdgeInsets.all(6),
//                                                         color:
//                                                         grey5, // Color of the dots and border
//                                                         child: Container(
//                                                           margin:
//                                                           EdgeInsets.only(
//                                                               top: 20,
//                                                               bottom: 20,
//                                                               left: 20,
//                                                               right: 20),
//                                                           child: Center(
//                                                               child: Text(
//                                                                   "+ Upload Offer Letter",
//                                                                   style:
//                                                                   recblack3)), // Color inside the container
//                                                         ),
//                                                       )),
//                                                   content: Row(
//                                                     children: [
//                                                       Container(
//                                                         margin: EdgeInsets.only(
//                                                             right: 5,
//                                                             left: 20,
//                                                             top: 16,
//                                                             bottom: 16),
//                                                         decoration:
//                                                         BoxDecoration(
//                                                           border: Border.all(
//                                                               color: blue1),
//                                                           borderRadius:
//                                                           BorderRadius
//                                                               .circular(10),
//                                                         ),
//                                                         child: InkWell(
//                                                           onTap: () {
//                                                             Navigator.of(
//                                                                 context)
//                                                                 .pop();
//                                                           },
//                                                           child: Container(
//                                                             margin:
//                                                             EdgeInsets.only(
//                                                                 right: 30,
//                                                                 left: 30,
//                                                                 top: 16,
//                                                                 bottom: 16),
//                                                             child: Text(
//                                                               "Cancel",
//                                                               style: bluetxt,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       ),
//                                                       InkWell(
//                                                         onTap: () {
//                                                           setState(() {
//                                                             Uploadsumit = true;
//                                                           });
//                                                           Navigator.of(context)
//                                                               .pop();
//                                                         },
//                                                         child: Container(
//                                                           margin:
//                                                           EdgeInsets.only(
//                                                               top: 16,
//                                                               bottom: 16),
//                                                           decoration:
//                                                           BoxDecoration(
//                                                             color: blue1,
//                                                             borderRadius:
//                                                             BorderRadius
//                                                                 .circular(
//                                                                 10),
//                                                           ),
//                                                           child: Container(
//                                                             margin:
//                                                             EdgeInsets.only(
//                                                                 right: 35,
//                                                                 left: 35,
//                                                                 top: 16,
//                                                                 bottom: 16),
//                                                             child: Text(
//                                                               "Sumit",
//                                                               style: Homewhite3,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                   actions: <Widget>[],
//                                                 );
//                                               },
//                                             );
//                                           },
//                                           child: Container(
//                                             margin: EdgeInsets.only(
//                                                 right: 5, top: 16, bottom: 16),
//                                             decoration: BoxDecoration(
//                                               color: blue1,
//                                               borderRadius:
//                                               BorderRadius.circular(10),
//                                             ),
//                                             child: Container(
//                                               margin: EdgeInsets.only(
//                                                   right: 20,
//                                                   left: 20,
//                                                   top: 16,
//                                                   bottom: 16),
//                                               child: Text(
//                                                 "Confirm",
//                                                 style: Homewhite3,
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 );
//                               },
//                             );
//                           },
//                           child: Container(
//                             margin: EdgeInsets.only(
//                                 right: 5, left: 20, top: 16, bottom: 16),
//                             decoration: BoxDecoration(
//                               color: blue1,
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             child: Container(
//                               margin: EdgeInsets.only(
//                                   right: 38, left: 38, top: 16, bottom: 16),
//                               child: Text(
//                                 "Selected",
//                                 style: Homewhite3,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ));
//   }
//
//   Widget No() {
//     return Visibility(
//         visible: isNo,
//         child: Column(
//           children: [
//             Container(
//               color: grey4,
//               width: double.infinity,
//               child: Container(
//                 margin: EdgeInsets.only(
//                   top: 20,
//                   bottom: 20,
//                 ),
//                 child: Column(
//                   children: [
//                     Text(
//                       "Candiate is not selected",
//                       style: Homewhite4,
//                     ),
//                     SizedBox(
//                       height: 5,
//                     ),
//                     Text(
//                       "Candidate",
//                       style: Homewhite4,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             Visibility(
//               visible: isNo, // This makes sure the text is only shown for isYes
//               child: Column(
//                 children: [
//                   Text(
//                     "You Scheduled Video Interview on",
//                     style: Wgrey,
//                   ),
//                   Text(
//                     "9.00 AM, 02 Oct 2023",
//                     style: Secblack,
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Text("Candidate Requested Video Interview on"),
//                   Text(
//                     "9.00 AM, 02 Oct 2023",
//                     style: Secblack,
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ));
//   }
//
//   Widget YesNo() {
//     return Visibility(
//       visible: !isReschedulePressed && !isYes && !isNo,
//       child: Center(
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             InkWell(
//               onTap: () {
//                 setState(() {
//                   isYes = true;
//                 });
//               },
//               child: Container(
//                 margin: EdgeInsets.only(right: 5, left: 20, top: 16, bottom: 16),
//                 decoration: BoxDecoration(
//                   color: blue1,
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: Container(
//                   margin:
//                   EdgeInsets.only(right: 30, left: 30, top: 16, bottom: 16),
//                   child: Text(
//                     "Yes",
//                     style: Homewhite3,
//                   ),
//                 ),
//               ),
//             ),
//             InkWell(
//               onTap: () {
//                 setState(() {
//                   isReschedulePressed = true;
//                 });
//               },
//               child: Container(
//                 margin: EdgeInsets.only(right: 5, left: 5, top: 16, bottom: 16),
//                 decoration: BoxDecoration(
//                   color: blue1,
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: Container(
//                   margin:
//                   EdgeInsets.only(right: 30, left: 30, top: 16, bottom: 16),
//                   child: Text(
//                     "Reschedule",
//                     style: Homewhite3,
//                   ),
//                 ),
//               ),
//             ),
//             InkWell(
//               onTap: () {
//                 setState(() {
//                   isNo = true;
//                 });
//               },
//               child: Container(
//                 margin: EdgeInsets.only(right: 20, left: 5, top: 16, bottom: 16),
//                 decoration: BoxDecoration(
//                   border: Border.all(color: blue1),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: Container(
//                   margin:
//                   EdgeInsets.only(right: 30, left: 30, top: 14, bottom: 14),
//                   child: Text(
//                     "No",
//                     style: bluetxt,
//                   ),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
//
// //QR CODE
// }
//
