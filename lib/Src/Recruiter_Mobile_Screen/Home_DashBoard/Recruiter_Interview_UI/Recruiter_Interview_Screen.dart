import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:getifyjobs/Models/InterviewModel.dart';
import 'package:getifyjobs/Src/Common_Widgets/Common_Button.dart';
import 'package:getifyjobs/Src/Common_Widgets/Common_Candidate_Profile.dart';
import 'package:getifyjobs/Src/Common_Widgets/Common_List.dart';
import 'package:getifyjobs/Src/Common_Widgets/Custom_App_Bar.dart';
import 'package:getifyjobs/Src/Common_Widgets/Image_Path.dart';
import 'package:getifyjobs/Src/Common_Widgets/Text_Form_Field.dart';
import 'package:getifyjobs/Src/Recruiter_Mobile_Screen/Home_DashBoard/Recruiter_Interview_UI/Recruiter_Interview_Card.dart';
import 'package:getifyjobs/Src/utilits/ApiService.dart';
import 'package:getifyjobs/Src/utilits/Common_Colors.dart';
import 'package:getifyjobs/Src/utilits/ConstantsApi.dart';
import 'package:getifyjobs/Src/utilits/Generic.dart';
import 'package:getifyjobs/Src/utilits/Text_Style.dart';
import 'package:intl/intl.dart';

import 'Recruiter_Result_Card.dart';

class Recuiter_Interview_Screen extends ConsumerStatefulWidget {
  const Recuiter_Interview_Screen({super.key});

  @override
  ConsumerState<Recuiter_Interview_Screen> createState() =>
      _Recuiter_Interview_ScreenState();
}

class _Recuiter_Interview_ScreenState
    extends ConsumerState<Recuiter_Interview_Screen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  String? isTagUsed;

  InterviewModel? interviewResponsemodel;
  InterviewModel? jobresultResponsemodel;

  @override
  void initState() {
    super.initState();
    print("object");
    _tabController = TabController(length: 2, vsync: this);

    InterviewDetailsResponse();
  }

  //DIRECT APPLIED LIST RESPONSE
  InterviewDetailsResponse() async {
    final ApplyListApiService = ApiService(ref.read(dioProvider));
    var formData = FormData.fromMap({
      'recruiter_id': await getRecruiterId(),
      "no_of_records": '20',
      "page_no": "1",
      "status": "all"
    });
    final interviewApiResponse = await ApplyListApiService.post<InterviewModel>(
        context, ConstantApi.allinterviewjobstatus, formData);
    print("JOB ID : ${interviewApiResponse.data?.items?[0].jobId ?? ''}");
    if (interviewApiResponse.status == true) {
      print('SUCESS');
      setState(() {
        interviewResponsemodel = interviewApiResponse;
      });
    } else {
      ShowToastMessage(interviewApiResponse.message ?? "");
      print('ERROR');
    }
  }

  InterviewJobResultsResponse() async {
    final ApplyListApiService = ApiService(ref.read(dioProvider));
    var formData = FormData.fromMap({
      'recruiter_id': await getRecruiterId(),
      "no_of_records": '20',
      "page_no": "1",
      "status": "all"
    });
    final jobResultApiResponse = await ApplyListApiService.post<InterviewModel>(
        context, ConstantApi.alljobresult, formData);
    print("JOB ID : ${jobResultApiResponse.data?.items?[0].jobId ?? ''}");
    if (jobResultApiResponse.status == true) {
      print('SUCESS');
      setState(() {
        jobresultResponsemodel = jobResultApiResponse;
      });
    } else {
      ShowToastMessage(jobResultApiResponse.message ?? "");
      print('ERROR');
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  RegExp onlyText = RegExp(r'^[a-zA-Z ]+$');
  TextEditingController _From = TextEditingController();
  TextEditingController _location = TextEditingController();
  TextEditingController _jobTitle = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white2,
      appBar: Custom_AppBar(
        isUsed: true,
        actions: [
          // Padding(
          //     padding: EdgeInsets.only(right: 20),
          //     child: InkWell(
          //       onTap: (){
          //         showDialog(
          //           context: context,
          //           builder: (BuildContext context) =>
          //               InterviewSchedulePopup(context),
          //         );
          //       },
          //         child: ImgPathSvg("filter.svg")))
        ],
        isLogoUsed: false,
        title: "",
        isTitleUsed: true,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Container(
              color: white1,
              width: MediaQuery.of(context).size.width,
              child: TabBar(
                onTap: (index) {
                  if (index == 0) {
                  } else {
                    InterviewJobResultsResponse();
                  }
                },
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
                      text: 'Result',
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  //INTERVIEW
                  SingleChildScrollView(
                      child: Padding(
                    padding: const EdgeInsets.only(bottom: 50),
                    child: _Interview(),
                  )),

                  //RESULTS
                  SingleChildScrollView(
                      child: Padding(
                    padding: const EdgeInsets.only(bottom: 50),
                    child: _result(),
                  )),
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
          padding:
              const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 20),
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Recruiter_Interview_Card(
                              CardType: "Schedule Accepted"))).then((value) => ref.refresh(InterviewDetailsResponse())).then((value) => null);
                },
                child: customCard(
                  context,
                  number:
                      "${interviewResponsemodel?.data?.count?.accepted ?? 0}",
                  labelText: 'Schedule Accepted',
                  labelColor: green3,
                  labelTextStyle: green,
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Recruiter_Interview_Card(
                              CardType: "Schedule Requested"))).then((value) => ref.refresh(InterviewDetailsResponse()));
                },
                child: customCard(
                  context,
                  number:
                      "${interviewResponsemodel?.data?.count?.requested ?? 0}",
                  labelText: 'Schedule Requested',
                  labelColor: blue2,
                  labelTextStyle: blue,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Recruiter_Interview_Card(
                              CardType: "Reschedule Requested"))).then((value) => ref.refresh(InterviewDetailsResponse()));
                },
                child: customCard(
                  context,
                  number:
                      "${interviewResponsemodel?.data?.count?.reschedule ?? 0}",
                  labelText: 'Reschedule Requested',
                  labelColor: grey4,
                  labelTextStyle: grey,
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Recruiter_Interview_Card(
                              CardType: "Schedule Rejected"))).then((value) => ref.refresh(InterviewDetailsResponse()));
                },
                child: customCard(
                  context,
                  number:
                      "${interviewResponsemodel?.data?.count?.rejected ?? 0}",
                  labelText: 'Schedule Rejected',
                  labelColor: pink3,
                  labelTextStyle: red,
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 20, top: 25),
          child: Text(
            "All",
            style: TitleT,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        interviewResponsemodel?.data?.items?.length != 0
            ? allInterviewResult(
                context,
                userItems: interviewResponsemodel?.data?.items ?? [],
                isWeb: false,
              )
            : NoDataMobileWidget(content: "Unlock New Possibilities"),
      ],
    );
  }

  //RESULTS
  Widget _result() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 20),
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              Recruiter_Result_Card(CardType: "Wait List"))).then((value) => ref.refresh(InterviewJobResultsResponse()));
                },
                child: customCard(
                  context,
                  number:
                      "${jobresultResponsemodel?.data?.count?.waiting_list ?? 0}",
                  labelText: 'Wait List',
                  labelColor: orange3,
                  labelTextStyle: orange,
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              Recruiter_Result_Card(CardType: "Selected"))).then((value) => ref.refresh(InterviewJobResultsResponse()));
                },
                child: customCard(
                  context,
                  number:
                      "${jobresultResponsemodel?.data?.count?.selected ?? 0}",
                  labelText: 'Selected',
                  labelColor: green3,
                  labelTextStyle: green,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              Recruiter_Result_Card(CardType: "Rejected"))).then((value) => ref.refresh(InterviewJobResultsResponse()));
                },
                child: customCard(
                  context,
                  number:
                      "${jobresultResponsemodel?.data?.count?.rejected ?? 0}",
                  labelText: 'Rejected',
                  labelColor: pink3,
                  labelTextStyle: red,
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              Recruiter_Result_Card(CardType: "Not Attended"))).then((value) => ref.refresh(InterviewJobResultsResponse()));
                },
                child: customCard(
                  context,
                  number:
                      "${jobresultResponsemodel?.data?.count?.not_attend ?? 0}",
                  labelText: 'Not Attended',
                  labelColor: grey4,
                  labelTextStyle: grey,
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 20, top: 25),
          child: Text(
            "All",
            style: TitleT,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        allInterviewResult(
          context,
          userItems: jobresultResponsemodel?.data?.items ?? [],
          isWeb: false,
        ),
      ],
    );
  }

  Widget InterviewSchedulePopup(
      BuildContext context,
      ) {
    return Container(
      child: AlertDialog(
        surfaceTintColor: white1,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Multiple selection of ${"Job title, Location, Salary etc"}",
              style: Wbalck1,
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 10,
              ),
              child: textFormField(
                hintText: 'Job Title',
                keyboardtype: TextInputType.text,
                inputFormatters: null,
                Controller: _jobTitle,
                focusNode: null,
                validating: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please Enter Job Title";
                  } else if (!onlyText.hasMatch(value)) {
                    return "(Special Characters are Not Allowed)";
                  }
                  return null;
                },
                onChanged: null,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: textFormField(
                hintText: 'Name',
                keyboardtype: TextInputType.text,
                inputFormatters: null,
                Controller: _location,
                focusNode: null,
                validating: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please Enter Name";
                  } else if (!onlyText.hasMatch(value)) {
                    return "(Special Characters are Not Allowed)";
                  }
                  return null;
                },
                onChanged: null,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Container(
                width: MediaQuery.sizeOf(context).width,
                child: TextFieldDatePicker(
                    Controller: _From,
                    onChanged: (value) {},
                    validating: (value) {
                      if (value!.isEmpty) {
                        return 'Please select  Date';
                      } else {
                        return null;
                      }
                    },
                    onTap: () async {
                      FocusScope.of(context).unfocus();
                      DateTime? pickdate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1980),
                          lastDate: DateTime(2050));
                      if (pickdate != null) {
                        String formatdate =
                        DateFormat("yyyy-MM-dd").format(pickdate!);
                        if (mounted) {
                          setState(() {
                            _From.text = formatdate;
                            print(_From.text);
                          });
                        }
                      }
                    },
                    hintText: 'Form',
                    isDownArrow: false),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width / 3.5,
                      child: PopButton(context, "Cancel", () {
                        Navigator.pop(context);
                      })),
                  Container(
                      width: MediaQuery.of(context).size.width / 3.5,
                      child: PopButton(context, "Okay", () {
                        //jobLists = [];
                        //tempjobLists = [];
                        //_visibleItemCount = 0;

                        // directJobListResponse(
                        //     JobT: _jobTitle.text,
                        //     location: _location.text,
                        //     Fdate: _From.text,
                        //     Tdate: _To.text,
                        //     ExpT: _careerStatus.text,
                        //     CompanyT: _CompanyName.text,
                        //     isFilter: true,
                        //     SalaryT: _SalaryRange.text);
                      })),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //ALL INTERVIEW RESULT

  Widget allInterviewResult(context,
      {required List<UserItems> userItems, required bool isWeb}) {
    return userItems.length != 0
        ? ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: userItems.length,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>
                Direct_Candidate_Profile_Screen(
                    TagContain: userItems[index].jobStatus ?? "",
                    candidate_Id:userItems[index].candidateId ?? "",
                    job_Id: userItems[index].jobId ?? ""))).then((value) => ref.refresh(InterviewDetailsResponse()));
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 20,right: 20),
            child: customListItem(context,
                badgeText: userItems[index].name ?? "",
                appliedRole: userItems[index].jobTitle ?? "",
                interviewTime:"${userItems[index].scheduleData?.interviewDate ?? ""}, ${userItems[index].scheduleData?.interviewTime ?? ""}",
                status: userItems[index].jobStatus ?? "",
                badgeTextStyle: ProfileT,
                countTextStyle: W1grey,
                interviewTimeTextStyle: Wgrey,
                statusColor: grey1,
                isWeb: isWeb,
                profileImg: userItems[index].profilePic ?? ""),
          ),
        );
      },
    )
        : NoDataMobileWidget(content: "Unlock New Possibilities");
  }
}

Widget customCard(
  context, {
  required String number,
  required String labelText,
  required Color labelColor,
  required TextStyle labelTextStyle,
}) {
  return Container(
    width: MediaQuery.of(context).size.width / 2.3,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: white1,
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(
            top: 15,
            bottom: 5,
          ),
          alignment: Alignment.center,
          child: Text(
            number,
            style: Ngrey,
          ),
        ),
        Container(
          color: labelColor,

          alignment: Alignment.center,
          padding: EdgeInsets.only(
              left: 10,
              right: 10,
              top: 5,
              bottom: 5), // Apply the provided padding
          margin: EdgeInsets.only(bottom: 15),
          child: Text(
            labelText,
            style: labelTextStyle,
          ),
        ),
      ],
    ),
  );
}

Widget customCardWeb(
  context, {
  required String number,
  required String labelText,
  required Color labelColor,
  required TextStyle labelTextStyle,
}) {
  return Container(
    width: MediaQuery.of(context).size.width / 7.5,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: white1,
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(
            top: 15,
            bottom: 5,
          ),
          alignment: Alignment.center,
          child: Text(
            number,
            style: Ngrey,
          ),
        ),
        Container(
          color: labelColor,

          alignment: Alignment.center,
          padding: EdgeInsets.only(
              left: 10,
              right: 10,
              top: 5,
              bottom: 5), // Apply the provided padding
          margin: EdgeInsets.only(bottom: 15),
          child: Text(
            labelText,
            style: labelTextStyle,
          ),
        ),
      ],
    ),
  );
}

//ALL INTERVIEW RESULT

Widget allInterviewResult(context,
    {required List<UserItems> userItems, required bool isWeb}) {
  return userItems.length != 0
      ? ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: userItems.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>
                    Direct_Candidate_Profile_Screen(
                        TagContain: userItems[index].jobStatus ?? "",
                        candidate_Id:userItems[index].candidateId ?? "", 
                        job_Id: userItems[index].jobId ?? "")));
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 20,right: 20),
                child: customListItem(context,
                    badgeText: userItems[index].name ?? "",
                    appliedRole: userItems[index].jobTitle ?? "",
                    interviewTime:"${userItems[index].scheduleData?.interviewDate ?? ""}, ${userItems[index].scheduleData?.interviewTime ?? ""}",
                    status: userItems[index].jobStatus ?? "",
                    badgeTextStyle: ProfileT,
                    countTextStyle: W1grey,
                    interviewTimeTextStyle: Wgrey,
                    statusColor: grey1,
                    isWeb: isWeb,
                    profileImg: userItems[index].profilePic ?? ""),
              ),
            );
          },
        )
      : NoDataMobileWidget(content: "Unlock New Possibilities");
}