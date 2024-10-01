import 'package:flutter/material.dart';
import 'package:getifyjobs/Src/Common_Widgets/Image_Path.dart';
import 'package:getifyjobs/Src/Recruiter_Mobile_Screen/Home_DashBoard/Recruiter_Interview_UI/Recruiter_Interview_Screen.dart';
import 'package:getifyjobs/Src/utilits/Common_Colors.dart';
import 'package:getifyjobs/Src/utilits/Text_Style.dart';

class Recruiter_Web_Interview_Screen extends StatefulWidget {
  @override
  _Recruiter_Web_Interview_ScreenState createState() =>
      _Recruiter_Web_Interview_ScreenState();
}

class _Recruiter_Web_Interview_ScreenState
    extends State<Recruiter_Web_Interview_Screen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String isStatus = 'Schedule Accepted';
  String isStatus1 = 'Wait list';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    isStatus = 'Schedule Accepted';
    isStatus1 = 'Wait list';
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white2,
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 20, left: 150, right: 150),
              color: white1,
              width: MediaQuery.of(context).size.width,
              child: TabBar(
                controller: _tabController,
                labelColor: white1,
                labelStyle: TabT,
                indicator: BoxDecoration(color: blue1),
                indicatorColor: grey4,
                unselectedLabelColor: grey4,
                indicatorPadding: EdgeInsets.zero,
                indicatorSize: TabBarIndicatorSize.tab,
                tabs: [
                  Container(
                    width: MediaQuery.of(context).size.width /
                        2, // Equal width for each tab
                    child: Tab(
                      text: 'Interview',
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width /
                        2, // Equal width for each tab
                    child: Tab(
                      text: 'Results',
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          bottom: 50, left: 150, right: 150),
                      child: _Interview(),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          bottom: 50, left: 150, right: 150),
                      child: _ResultTab(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //INTERVIEW SCREENS
  Widget _Interview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _AllCard(),
              const SizedBox(
                width: 20,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    isStatus = 'Schedule Accepted';
                  });
                },
                child: customCardWeb(
                  context,
                  number: '81',
                  labelText: 'Schedule Accepted',
                  labelColor: green3,
                  labelTextStyle: green,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    isStatus = "Schedule Requested";
                  });
                },
                child: customCardWeb(
                  context,
                  number: '24',
                  labelText: 'Schedule Requested',
                  labelColor: blue2,
                  labelTextStyle: blue,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    isStatus = "Reschedule Requested";
                  });
                },
                child: customCardWeb(
                  context,
                  number: '81',
                  labelText: 'Reschedule Requested',
                  labelColor: grey4,
                  labelTextStyle: grey,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    isStatus = "Schedule Cancelled";
                  });
                },
                child: customCardWeb(
                  context,
                  number: '81',
                  labelText: 'Schedule Cancelled',
                  labelColor: pink3,
                  labelTextStyle: red,
                ),
              ),
              const Spacer(),
              ImgPathSvg("filter.svg")
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        isStatus == "Schedule Accepted"
            ? allInterviewResult(
                context,
                userItems: [],
                // CandidateName: 'Praveen M',
                // AppliedRole: 'Augmented Reality (AR) Journey Builder‍',
                // InterviewTime: '09:00AM, 24 Oct 2023',
                // Status: 'Schedule Accepted',
                isWeb: true,
              )
            : isStatus == "Schedule Requested"
                ? allInterviewResult(
                    context,
                    userItems: [],
                    // CandidateName: 'Madhan Kumar P',
                    // AppliedRole: 'Augmented Reality (AR) Journey Builder‍',
                    // InterviewTime: '09:00AM, 24 Oct 2023',
                    // Status: 'Schedule Requested',
                    isWeb: true,
                  )
                : isStatus == "Reschedule Requested"
                    ? allInterviewResult(
                        context,
                        userItems: [],
                        // CandidateName: 'Nivas k',
                        // AppliedRole: 'Augmented Reality (AR) Journey Builder‍',
                        // InterviewTime: '09:00AM, 24 Oct 2023',
                        // Status: 'Reschedule Requested',
                        isWeb: true,
                      )
                    : isStatus == "Schedule Cancelled"
                        ? allInterviewResult(
                            context,
                            userItems: [],
                            // CandidateName: 'Kumar v',
                            // AppliedRole:
                            //     'Augmented Reality (AR) Journey Builder‍',
                            // InterviewTime: '09:00AM, 24 Oct 2023',
                            // Status: 'Schedule Cancelled',
                            isWeb: true,
                          )
                        : Container(),
      ],
    );
  }

  //RESULT TAB
  Widget _ResultTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _AllCard(),
              const SizedBox(
                width: 20,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    isStatus1 = 'Wait list';
                  });
                },
                child: customCardWeb(
                  context,
                  number: '24',
                  labelText: 'Wait list',
                  labelColor: orange3,
                  labelTextStyle: orange,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    isStatus1 = "Selected";
                  });
                },
                child: customCardWeb(
                  context,
                  number: '81',
                  labelText: 'Selected',
                  labelColor: green3,
                  labelTextStyle: green,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    isStatus1 = "Rejected";
                  });
                },
                child: customCardWeb(
                  context,
                  number: '81',
                  labelText: 'Rejected',
                  labelColor: pink3,
                  labelTextStyle: red,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    isStatus1 = "Not Attended";
                  });
                },
                child: customCardWeb(
                  context,
                  number: '81',
                  labelText: 'Not Attended',
                  labelColor: grey4,
                  labelTextStyle: grey,
                ),
              ),
              const Spacer(),
              ImgPathSvg("filter.svg")
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        isStatus1 == "Wait list"
            ? allInterviewResult(
                context,
                userItems: [],
                // CandidateName: 'Praveen M',
                // AppliedRole: 'Augmented Reality (AR) Journey Builder‍',
                // InterviewTime: '09:00AM, 24 Oct 2023',
                // Status: 'Wait list',
                isWeb: true,
              )
            : isStatus1 == "Selected"
                ? allInterviewResult(
                    context,
                    userItems: [],
                    // CandidateName: 'Madhan Kumar P',
                    // AppliedRole: 'Augmented Reality (AR) Journey Builder‍',
                    // InterviewTime: '09:00AM, 24 Oct 2023',
                    // Status: 'Selected',
                    isWeb: true,
                  )
                : isStatus1 == "Rejected"
                    ? allInterviewResult(
                        context,
                        userItems: [],
                        // CandidateName: 'Nivas k',
                        // AppliedRole: 'Augmented Reality (AR) Journey Builder‍',
                        // InterviewTime: '09:00AM, 24 Oct 2023',
                        // Status: 'Rejected',
                        isWeb: true,
                      )
                    : isStatus1 == "Not Attended"
                        ? allInterviewResult(
                            context,
                            userItems: [],
                            // CandidateName: 'Kumar v',
                            // AppliedRole:
                            //     'Augmented Reality (AR) Journey Builder‍',
                            // InterviewTime: '09:00AM, 24 Oct 2023',
                            // Status: 'Not Attended',
                            isWeb: true,
                          )
                        : Container(),
      ],
    );
  }
}

//ALL CARD
Widget _AllCard() {
  return Container(
    width: 180,
    height: 100,
    decoration:
        BoxDecoration(borderRadius: BorderRadius.circular(10), color: white1),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.center,
          child: Text(
            'All',
            style: Ngrey,
          ),
        ),
      ],
    ),
  );
}
