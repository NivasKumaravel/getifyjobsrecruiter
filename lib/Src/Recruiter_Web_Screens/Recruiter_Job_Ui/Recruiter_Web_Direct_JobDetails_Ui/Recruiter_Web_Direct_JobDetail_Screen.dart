import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:getifyjobs/Models/DirectDetailsModel.dart';
import 'package:getifyjobs/Src/Common_Widgets/Common_Button.dart';
import 'package:getifyjobs/Src/Common_Widgets/Common_List.dart';
import 'package:getifyjobs/Src/Common_Widgets/Common_PopUp_Widgets.dart';
import 'package:getifyjobs/Src/Common_Widgets/Custom_App_Bar.dart';
import 'package:getifyjobs/Src/Common_Widgets/Image_Path.dart';
import 'package:getifyjobs/Src/Common_Widgets/Image_Widget.dart';
import 'package:getifyjobs/Src/Common_Widgets/Text_Form_Field.dart';
import 'package:getifyjobs/Src/Recruiter_Web_Screens/Recruiter_Candidate_Profile_WebView_Popup.dart';
import 'package:getifyjobs/Src/Recruiter_Web_Screens/Recruiter_Job_Ui/Recruiter_Web_Create_Job.dart';
import 'package:getifyjobs/Src/utilits/ApiService.dart';
import 'package:getifyjobs/Src/utilits/Common_Colors.dart';
import 'package:getifyjobs/Src/utilits/ConstantsApi.dart';
import 'package:getifyjobs/Src/utilits/Text_Style.dart';

import 'Recruiter_Web_Direct_List_Candidate.dart';

class Recruiter_Web_Direct_JobDetail extends ConsumerStatefulWidget {
  String? jobId;

  Recruiter_Web_Direct_JobDetail({required this.jobId});

  @override
  _Recruiter_Web_Direct_JobDetailState createState() =>
      _Recruiter_Web_Direct_JobDetailState();
}

class _Recruiter_Web_Direct_JobDetailState
    extends ConsumerState<Recruiter_Web_Direct_JobDetail>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  DirectDetailsData? DirectJobDetailResponseData;


  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    DirectJobDetailResponse();
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
      appBar: Custom_AppBar(
        isUsed: true,
        actions: null,
        isLogoUsed: true,
        isTitleUsed: true,
        title: '',
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery
              .of(context)
              .size
              .width,
          height: MediaQuery
              .of(context)
              .size
              .height + MediaQuery
              .of(context)
              .size
              .height,
          child: Column(
            children: [
              //JOB POST DETAILS
              Container(
                margin: EdgeInsets.only(left: 150, right: 150),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: white1,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 15),
                        child: Row(
                          children: [
                            //COMPANY LOGO
                            Container(
                              height: 50,
                              width: 50,
                              child: buildImage(
                                  DirectJobDetailResponseData?.logo ?? "",
                                  border: const Radius.circular(25),
                                  fit: BoxFit.cover),
                            ),
                            //COLLEGE NAME AND LOCATION
                            Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      child: Text(
                                        DirectJobDetailResponseData?.jobTitle ??
                                            "",
                                        style: TBlack,
                                      )),
                                  Row(
                                    children: [
                                      Container(
                                        height: 20,
                                        width: 20,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(25),
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    "lib/assets/map-pin (1).png"),
                                                fit: BoxFit.cover)),
                                      ),
                                      Text(
                                        "Innova new Technology",
                                        style: Homegrey2,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            PopupMenuButton(
                                surfaceTintColor: white1,
                                icon: Icon(Icons.more_vert_outlined),
                                itemBuilder: (BuildContext context) =>
                                [
                                  PopupMenuItem(child: InkWell(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              _DownloadPopUp(context),
                                        );
                                      },
                                      child: Text(
                                        'Download', style: refferalCountT,))),
                                  //EDIT
                                  PopupMenuItem(
                                      onTap: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Recruiter_Web_CreateJob(
                                                      DirectJobDetailResponseData: DirectJobDetailResponseData,
                                                      isEdit: true,
                                                      Job_Id:DirectJobDetailResponseData?.jobId ?? "",)));
                                      },
                                      child: Text(
                                        'Edit', style: refferalCountT,)),
                                  //CLONE
                                  PopupMenuItem(child: Text(
                                    'Clone', style: refferalCountT,)),
                                  //PAUSE
                                  PopupMenuItem(child: Text(
                                    'Pause', style: refferalCountT,)),
                                  PopupMenuItem(child: Text(
                                    'Stop', style: refferalCountT,)),
                                  PopupMenuItem(child: Text(
                                    'Delete', style: refferalCountT,)),
                                  // PopupMenuItem(child: Text('Download',style: refferalCountT,)),
                                ]),
                          ],
                        ),
                      ),
                      Text(
                        "Posted on : ${DirectJobDetailResponseData
                            ?.createdDate ?? ""}",
                        style: Homegrey2,
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 15),
                        child: Text(
                          "Deadline: 23 Oct 2023",
                          style: deadtxt,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              //JOB DETAILS
              Container(
                margin:
                EdgeInsets.only(top: 25, left: 150, right: 150, bottom: 25),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5), color: white1),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      _IconWithText(
                          iconimg: "bag.svg",
                          icontext: DirectJobDetailResponseData?.experience ??
                              ""),
                      //LOCATION
                      _IconWithText(
                          iconimg: "map-pin.svg",
                          icontext: DirectJobDetailResponseData?.location ??
                              ""),
                      //SALARY
                      _IconWithText(
                          iconimg: "wallet.svg",
                          icontext: '₹ ${DirectJobDetailResponseData
                              ?.salaryFrom ??
                              ""} - ${DirectJobDetailResponseData?.salaryTo ??
                              ""} LPA'),

                      textWithheader(
                          headertxt: "Job Description",
                          subtxt: DirectJobDetailResponseData?.jobDescription ??
                              ""),
                      textWithheader(
                          headertxt: "Skill Set",
                          subtxt: DirectJobDetailResponseData?.skills ?? ""),
                      textWithheader(
                          headertxt: "Qualification",
                          subtxt: DirectJobDetailResponseData?.qualification ??
                              ""),
                      textWithheader(
                          headertxt: "Specialization",
                          subtxt: DirectJobDetailResponseData?.specialization ??
                              ""),

                      DirectJobDetailResponseData?.currentArrears == null
                          ? Container()
                          : textWithheader(
                          headertxt: "Current Arrears",
                          subtxt: DirectJobDetailResponseData?.currentArrears ??
                              ""),

                      DirectJobDetailResponseData?.historyOfArrears == null
                          ? Container()
                          : textWithheader(
                          headertxt: "History of Arrears",
                          subtxt: DirectJobDetailResponseData
                              ?.historyOfArrears ?? ""),
                      DirectJobDetailResponseData?.requiredPercentage == null
                          ? Container()
                          : textWithheader(
                          headertxt: "Required Percentage/CGPA",
                          subtxt: DirectJobDetailResponseData
                              ?.requiredPercentage ?? ""),
                      textWithheader(
                          headertxt: "Work Type",
                          subtxt: DirectJobDetailResponseData?.workType ?? ""),
                      DirectJobDetailResponseData?.workMode == ""?Container(): textWithheader(
                          headertxt: "Work Mode",
                          subtxt: DirectJobDetailResponseData?.workMode ?? ""),
                      textWithheader(headertxt: "Shift Details",
                          subtxt: DirectJobDetailResponseData?.shiftDetails ??
                              ""),

                      DirectJobDetailResponseData?.statutoryBenefits == null
                          ? Container()
                          : textWithheader(
                          headertxt: "Statutory Benefit",
                          subtxt: DirectJobDetailResponseData
                              ?.statutoryBenefits ?? ""),

                      DirectJobDetailResponseData?.socialBenefits == null
                          ? Container()
                          : textWithheader(
                          headertxt: "Social Benefits",
                          subtxt: DirectJobDetailResponseData?.socialBenefits ??
                              ""),

                      DirectJobDetailResponseData?.otherBenefits == null
                          ? Container()
                          : textWithheader(
                          headertxt: "Other Benefits",
                          subtxt: DirectJobDetailResponseData?.otherBenefits ??
                              ""),
                    ],
                  ),
                ),
              ),

              Container(
                color: white1,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
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
                      child: Tab(
                        text: 'All',
                      ),
                    ),
                    Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width /
                          2, // Equal width for each tab
                      child: Tab(
                        text: 'Shortlisted',
                      ),
                    ),
                    Container(
                      child: Tab(
                        text: 'Scheduled',
                      ),
                    ),
                    Container(
                      child: Tab(
                        text: 'Reject',
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    allList(),
                    shortListedList(),
                    scheduledList(),
                    rejectedList(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20, top: 15, bottom: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Recruiter_Web_Direct_List_Candidate()));
                        },
                        child: Text(
                          "View all",
                          style: noOfCandidatesStyle,
                        )),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  //DIRECT JOB DETAIL RESPONSE
  DirectJobDetailResponse() async {
    final directJobDetailApiService = ApiService(ref.read(dioProvider));
    var formData = FormData.fromMap({
      'job_id': widget.jobId
    });
    final directJobDetailApiResponse = await directJobDetailApiService.post<
        DirectDetailsModel>(context, ConstantApi.directJobDetailsUrl, formData);

    if (directJobDetailApiResponse?.status == true) {
      print('SUCESS');
      setState(() {
        DirectJobDetailResponseData = directJobDetailApiResponse.data;
      });
      print("RESPONSE : ${DirectJobDetailResponseData?.jobId ?? ""}");
    }
  }

  Widget _IconWithText({required String iconimg, required String icontext}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          ImgPathSvg(iconimg),
          SizedBox(
            width: 5,
          ),
          Text(icontext, style: posttxt)
        ],
      ),
    );
  }

  Widget allList() {
    return ListView.builder(
      itemCount: 3,
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) => ProfilePopup(context),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 15, right: 20, left: 20),
              child: AppliesList(context,
                  CandidateImg: 'candidateImg.png',
                  CandidateName: 'Karthik Raja S',
                  Jobrole: 'Augmented Reality (AR) Journey Builder‍',
                  color: white1,
                  isWeb: true, isTagNeeded: null, isTagName: ''),
            ));
      },
    );
  }

  Widget shortListedList() {
    return ListView.builder(
      itemCount: 3,
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) => ProfilePopup(context),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 15, right: 20, left: 20),
              child: AppliesList(context,
                  CandidateImg: 'candidateImg.png',
                  CandidateName: 'Karthik Raja S',
                  Jobrole: 'Augmented Reality (AR) Journey Builder‍',
                  color: white1,
                  isWeb: true, isTagNeeded: null, isTagName: ''),
            ));
      },
    );
  }

  Widget scheduledList() {
    return ListView.builder(
      itemCount: 3,
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) => ProfilePopup(context),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 15, right: 20, left: 20),
              child: AppliesList(context,
                  CandidateImg: 'candidateImg.png',
                  CandidateName: 'Karthik Raja S',
                  Jobrole: 'Augmented Reality (AR) Journey Builder‍',
                  color: white1,
                  isWeb: true, isTagNeeded: null, isTagName: ''),
            ));
      },
    );
  }

  Widget rejectedList() {
    return ListView.builder(
      itemCount: 3,
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) => ProfilePopup(context),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 15, right: 20, left: 20),
              child: AppliesList(context,
                  CandidateImg: 'candidateImg.png',
                  CandidateName: 'Karthik Raja S',
                  Jobrole: 'Augmented Reality (AR) Journey Builder‍',
                  color: white1,
                  isWeb: true, isTagNeeded: null, isTagName: ''),
            ));
      },
    );
  }

  Widget ProfilePopup(BuildContext context) {
    return AlertDialog(
      surfaceTintColor: white1,
      content: SingleChildScrollView(
        child: Container(
          width: 400,
          height: MediaQuery
              .of(context)
              .size
              .height,
          child: Recruiter_Candidate_Profile_WebView_Popup(isPdfNeeded: true,
            isCampus: false,
            TagContain: '',
            isBottomNeeded: true,
            isAppbarNeeded: true,),
          // child: Recruiter_Candidate_Profile_View(),
        ),
      ),
    );
  }
}
//DOWNLOAD POPUP
Widget _DownloadPopUp(BuildContext context) {
  return AlertDialog(
    backgroundColor: white1,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10))),
    titlePadding: EdgeInsets.all(0),
    title: Container(
        alignment: Alignment.topRight, child: IconButton(onPressed: () {
      Navigator.pop(context);
    }, icon: ImgPathSvg("xcancel.svg"))),
    contentPadding: EdgeInsets.only(right: 20, left: 20, bottom: 0),
    content: Container(
      height: 150,
      width: 350,
      child: Column(
        children: [
          Text("Click to download the ", style: walletT,),
          Text("Job Summary", style: profileTitle,),
          const SizedBox(height: 15,),
          CommonElevatedButton(context, "Download", () {})
        ],
      ),
    ),
  );
}