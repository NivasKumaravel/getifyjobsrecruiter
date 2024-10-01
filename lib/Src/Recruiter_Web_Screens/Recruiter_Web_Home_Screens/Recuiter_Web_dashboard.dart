import 'package:flutter/material.dart';
import 'package:getifyjobs/Src/Common_Widgets/Image_Path.dart';
import 'package:getifyjobs/Src/Common_Widgets/Text_Form_Field.dart';
import 'package:getifyjobs/Src/Recruiter_Web_Screens/Recruiter_Web_Dashboard_UI/Recruiter_Web_Dashboard_Joblist.dart';
import 'package:getifyjobs/Src/utilits/Common_Colors.dart';

import '../../utilits/Text_Style.dart';

class WebDashBoard extends StatefulWidget {
  const WebDashBoard({super.key});

  @override
  State<WebDashBoard> createState() => _WebDashBoardState();
}

class _WebDashBoardState extends State<WebDashBoard> {
  final List<_CompanyData> companyData = [
    _CompanyData('Applied', 350, blue1),
    _CompanyData('Shortlisted', 150, gdarkblue),
    _CompanyData('Selected', 180, ggreen),
    _CompanyData('WaitingList', 250, gyellow),
    _CompanyData('Rejected', 200, red1),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grey1,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: white1),
              margin: EdgeInsets.only(top: 10, right: 20, left: 20, bottom: 10),
              width: MediaQuery.of(context).size.width / 1.2,
              //  height: MediaQuery.of(context).size.height,

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 20, bottom: 10, top: 5),
                    child: Text(
                      "Today’s Interviews",
                      style: black21,
                    ),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        generateCustomContainer(
                          containerColor: voliet,
                          titleStyle: TitleT2,
                          // TextStyle for title
                          subtitleStyle: TitleT2,
                          // TextStyle for subtitle
                          valueStyle: Tvoilet,
                          // TextStyle for value
                          title: "Today’s Scheduled    \nInterviews",
                          // subtitle: "Interviews",
                          value: "120",
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        generateCustomContainer(
                          containerColor: orange5,
                          titleStyle: TitleT2,
                          // TextStyle for title
                          subtitleStyle: TitleT2,
                          // TextStyle for subtitle
                          valueStyle: Torange,
                          // TextStyle for value
                          title: "Candidates Confirmed\ntheir arrival",
                          // subtitle: "their arrival",
                          value: "30",
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        generateCustomContainer(
                          containerColor: blue55,
                          titleStyle: TitleT2,
                          // TextStyle for title
                          subtitleStyle: TitleT2,
                          // TextStyle for subtitle
                          valueStyle: Tgreen,
                          // TextStyle for value
                          title: "Candidates On the   \nway",
                          // subtitle: "way",
                          value: "24",
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        generateCustomContainer(
                          containerColor: darkblue,
                          titleStyle: TitleT2,
                          // TextStyle for title
                          subtitleStyle: TitleT2,
                          // TextStyle for subtitle
                          valueStyle: darkblue12,
                          // TextStyle for value
                          title: "Currently Running    \nInterviews ",
                          // subtitle: "Interviews",
                          value: "24",
                        ),
                        SizedBox(
                          width: 20,
                        )
                      ]),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 2.5,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10), color: white1),
                  margin:
                      EdgeInsets.only(top: 10, right: 20, left: 20, bottom: 10),
                  // height: MediaQuery.of(context).size.height *0.30,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 20, bottom: 10, top: 5),
                        child: Text(
                          "Action Required",
                          style: black21,
                        ),
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            generateCustomContainer1(
                              containerColor: voliet,
                              titleStyle: TitleT2,
                              // TextStyle for title
                              // TextStyle for subtitle
                              valueStyle: Tvoilet,
                              // TextStyle for value
                              title: "Today’s Applies ",
                              value: "30",
                            ),
                            // SizedBox(
                            //   width: 5,
                            // ),
                            generateCustomContainer1(
                              containerColor: orange5,
                              titleStyle: TitleT2,
                              // TextStyle for title
                              // TextStyle for subtitle
                              valueStyle: Torange,
                              // TextStyle for value
                              title: "Total Waitlist     ",
                              value: "20",
                            ),
                            SizedBox(
                              width: 20,
                            ),
                          ]),
                      SizedBox(
                        width: 10,
                      )
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 2.5,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10), color: white1),
                  margin:
                      EdgeInsets.only(top: 10, right: 20, left: 20, bottom: 10),
                  // height: MediaQuery.of(context).size.height *0.35,

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 20, bottom: 10, top: 5),
                        child: Text(
                          "Today’s Result",
                          style: black21,
                        ),
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            generateCustomContainer1(
                              containerColor: voliet,
                              titleStyle: TitleT2,
                              // TextStyle for title// TextStyle for subtitle
                              valueStyle: Tvoilet,
                              // TextStyle for value
                              title: "Today’s Selected",
                              value: "4",
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            generateCustomContainer1(
                              containerColor: orange5,
                              titleStyle: TitleT2,
                              // TextStyle for title// TextStyle for subtitle
                              valueStyle: Torange,
                              // TextStyle for value
                              title: "Today’s Rejected",
                              value: "3",
                            ),
                            SizedBox(
                              width: 20,
                            ),
                          ]),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Overview",
                      style: black21,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: white1),
                        margin: EdgeInsets.only(top: 20, bottom: 20),
                        width: MediaQuery.of(context).size.width / 2.5,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                margin: EdgeInsets.only(left: 20),
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin:
                                          EdgeInsets.only(top: 10, bottom: 10),
                                      child: Row(
                                        children: [
                                          ImgPathSvg("refresh.svg"),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: Container(
                                                // margin: EdgeInsets.only(right: 100),
                                                child: InkWell(
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  Recruiter_Web_Dashboard_Joblist()));
                                                    },
                                                    child: Text(
                                                      "Change",
                                                      style: blue6,
                                                    ))),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                        width:
                                            MediaQuery.sizeOf(context).width /
                                                5,
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "Flutter Developer",
                                          style: Wbalck4,
                                          maxLines: 2,
                                        )),
                                    Container(
                                        margin: EdgeInsets.only(
                                            right: 40, top: 5, bottom: 15),
                                        child: Text(
                                          "5 Candidates",
                                          style: blu,
                                        )),
                                  ],
                                )),
                            Spacer(),
                            Container(
                                margin: EdgeInsets.only(right: 15, top: 10),
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "Posted: 23 Sep 2023",
                                  style: grey55,
                                )),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  width: 30,
                ),
                // Container(
                //   width: MediaQuery.of(context).size.width /2.5,
                //   height: MediaQuery.of(context).size.height /3,
                //   child: SfCartesianChart(
                //     primaryXAxis: CategoryAxis(),
                //     // Chart title
                //     title: ChartTitle(text: ''),
                //     // Enable legend
                //     legend: Legend(isVisible: false),
                //     // Enable tooltip
                //     tooltipBehavior: TooltipBehavior(enable: false),
                //     series: <ChartSeries<_CompanyData, String>>[
                //       ColumnSeries<_CompanyData, String>(
                //         dataSource: companyData,
                //         xValueMapper: (_CompanyData sales, _) =>
                //         sales.companyName,
                //         yValueMapper: (_CompanyData sales, _) => sales.sales,
                //         pointColorMapper: (_CompanyData sales, _) =>
                //         sales.color, // Use the color property
                //       )
                //     ],
                //   ),
                // ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}

class _CompanyData {
  _CompanyData(this.companyName, this.sales, this.color);

  final String companyName;
  final double sales;
  final Color color;
}
