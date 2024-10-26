import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:getifyjobs/Models/AppliedCampusCandidateListModel.dart';
import 'package:getifyjobs/Models/CampusJobdetailModel.dart';
import 'package:getifyjobs/Src/Common_Widgets/Common_Button.dart';
import 'package:getifyjobs/Src/Common_Widgets/Common_List.dart';
import 'package:getifyjobs/Src/Common_Widgets/Custom_App_Bar.dart';
import 'package:getifyjobs/Src/Common_Widgets/Image_Path.dart';
import 'package:getifyjobs/Src/Common_Widgets/Image_Widget.dart';
import 'package:getifyjobs/Src/Common_Widgets/Text_Form_Field.dart';
import 'package:getifyjobs/Src/Recruiter_Web_Screens/Recruiter_Candidate_Profile_WebView_Popup.dart';
import 'package:getifyjobs/Src/Recruiter_Web_Screens/Recruiter_Job_Ui/Recruiter_Web_Bulk_Job.dart';
import 'package:getifyjobs/Src/utilits/ApiService.dart';
import 'package:getifyjobs/Src/utilits/Common_Colors.dart';
import 'package:getifyjobs/Src/utilits/ConstantsApi.dart';
import 'package:getifyjobs/Src/utilits/Generic.dart';
import 'package:getifyjobs/Src/utilits/Text_Style.dart';
import 'Recruiter_Web_Campus_Candidate_List.dart';
import 'Recruiter_Web_Campus_Candidate_Profile.dart';

class Recruiter_Web_Campus_JobDetail_Page extends ConsumerStatefulWidget {
  String? jobId;
  String? campusId;

  Recruiter_Web_Campus_JobDetail_Page(
      {required this.jobId, required this.campusId});

  @override
  _Recruiter_Web_Campus_JobDetail_PageState createState() =>
      _Recruiter_Web_Campus_JobDetail_PageState();
}

class _Recruiter_Web_Campus_JobDetail_PageState
    extends ConsumerState<Recruiter_Web_Campus_JobDetail_Page>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool? isApplied;
  bool? isEnrolled;
  bool? isShortlisted;
  bool? isSelected;
  bool? isRejected;
  CampusJobDetailData? campusJobDetailResponseData;
  AppliedCandidateData? appliedCandidateResponseData;
  AppliedCandidateData? enrolledCandidateResponseData;
  AppliedCandidateData? shortlistedCandidateResponseData;
  AppliedCandidateData? selectCandidateResponseData;
  AppliedCandidateData? rejectCandidateResponseData;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    CampusJobDetailResponse();
    AppliedCandidateResponse();
    isApplied = true;
    isEnrolled = true;
    isShortlisted = true;
    isSelected = true;
    isRejected = true;
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
      body: campusJobDetailResponseData?.college != null
          ? SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height +
                    MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    _campusCollegeList(
                      context,
                      isTag: 'Assigned',
                      iscampTag: 'Assigned',
                    ),
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
                              padding:
                                  const EdgeInsets.only(top: 20, bottom: 15),
                              child: Row(
                                children: [
                                  //COMAPNY LOGO
                                  Container(
                                    height: 50,
                                    width: 50,
                                    child: buildImage(
                                        campusJobDetailResponseData?.logo ?? "",
                                        border: const Radius.circular(25),
                                        fit: BoxFit.cover),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.only(left: 15),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        //JOB TITLE
                                        Container(
                                            child: Text(
                                          campusJobDetailResponseData
                                                  ?.jobTitle ??
                                              "",
                                          style: TBlack,
                                        )),
                                        //COMAPNY NAME
                                        Text(
                                          campusJobDetailResponseData
                                                  ?.companyName ??
                                              "",
                                          style: Homegrey2,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Spacer(),
                                  PopupMenuButton(
                                      surfaceTintColor: white1,
                                      icon: Icon(Icons.more_vert_outlined),
                                      itemBuilder: (BuildContext context) => [
                                            PopupMenuItem(
                                                child: InkWell(
                                                    onTap: () {
                                                      showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                                context) =>
                                                            _DownloadPopUp(
                                                                context),
                                                      );
                                                    },
                                                    child: Text(
                                                      'Download',
                                                      style: refferalCountT,
                                                    ))),
                                            PopupMenuItem(
                                              onTap: (){
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Recruiter_Web_BulkJob(
                                                              campus_Id: campusJobDetailResponseData
                                                                  ?.college
                                                                  ?.campusId ??
                                                                  "", 
                                                              campusJobDetailResponseData: campusJobDetailResponseData, 
                                                              job_Id: campusJobDetailResponseData?.jobId ?? "",
                                                              isEditBulk: true,))).then((value) => ref.read(CampusJobDetailResponse()));
                                              },
                                                child: Text(
                                                  'Edit',
                                                  style: refferalCountT,
                                                )),
                                            PopupMenuItem(
                                                child: InkWell(
                                                    onTap: () {},
                                                    child: Text(
                                                      'Clone',
                                                      style: refferalCountT,
                                                    ))),
                                            PopupMenuItem(
                                                child: InkWell(
                                                    onTap: () {},
                                                    child: Text(
                                                      'Pause',
                                                      style: refferalCountT,
                                                    ))),
                                            PopupMenuItem(
                                                child: InkWell(
                                                    onTap: () {},
                                                    child: Text(
                                                      'Stop',
                                                      style: refferalCountT,
                                                    ))),
                                            PopupMenuItem(
                                                child: InkWell(
                                                    onTap: () {},
                                                    child: Text(
                                                      'Delete',
                                                      style: refferalCountT,
                                                    ))),
                                            // PopupMenuItem(child: Text('Download',style: refferalCountT,)),
                                          ]),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: Text(
                                "Posted on : ${campusJobDetailResponseData?.createdDate ?? ""}",
                                style: Homegrey2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // JOB DETAILS
                    Container(
                      margin: EdgeInsets.only(
                          top: 25, left: 150, right: 150, bottom: 25),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: white1),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            //LOCATION
                            _IconWithText(
                                iconimg: "map-pin.svg",
                                icontext:
                                    campusJobDetailResponseData?.location ??
                                        ""),
                            //SALARY
                            _IconWithText(
                                iconimg: "wallet.svg",
                                icontext:
                                    '₹ ${campusJobDetailResponseData?.salaryFrom ?? ""} - ${campusJobDetailResponseData?.salaryTo ?? ""} LPA'),

                            textWithheader(
                                headertxt: "Job Description",
                                subtxt: campusJobDetailResponseData
                                        ?.jobDescription ??
                                    ""),
                            textWithheader(
                                headertxt: "No Of Vacancies",
                                subtxt:
                                    campusJobDetailResponseData?.vacancies ??
                                        ""),
                            textWithheader(
                                headertxt: "Qualification",
                                subtxt: campusJobDetailResponseData
                                        ?.qualification ??
                                    ""),
                            textWithheader(
                                headertxt: "Specialization",
                                subtxt: campusJobDetailResponseData
                                        ?.specialization ??
                                    ""),

                            campusJobDetailResponseData?.currentArrears == null
                                ? Container()
                                : textWithheader(
                                    headertxt: "Current Arrears",
                                    subtxt: campusJobDetailResponseData
                                            ?.currentArrears ??
                                        ""),

                            campusJobDetailResponseData?.historyOfArrears ==
                                    null
                                ? Container()
                                : textWithheader(
                                    headertxt: "History of Arrears",
                                    subtxt: campusJobDetailResponseData
                                            ?.historyOfArrears ??
                                        ""),

                            campusJobDetailResponseData?.requiredPercentage ==
                                    null
                                ? Container()
                                : textWithheader(
                                    headertxt: "Required Percentage/CGPA",
                                    subtxt: campusJobDetailResponseData
                                            ?.requiredPercentage ??
                                        ""),

                            textWithheader(
                                headertxt: "No of Rounds",
                                subtxt:
                                    campusJobDetailResponseData?.rounds ?? ""),
                            campusJobDetailResponseData?.statutoryBenefits ==
                                    null
                                ? Container()
                                : textWithheader(
                                    headertxt: "Statutory Benefits",
                                    subtxt: campusJobDetailResponseData
                                            ?.statutoryBenefits ??
                                        ""),

                            campusJobDetailResponseData?.socialBenefits == null
                                ? Container()
                                : textWithheader(
                                    headertxt: "Social Benefits",
                                    subtxt: campusJobDetailResponseData
                                            ?.socialBenefits ??
                                        ""),

                            campusJobDetailResponseData?.otherBenefits == null
                                ? Container()
                                : textWithheader(
                                    headertxt: "Other Benefits",
                                    subtxt: campusJobDetailResponseData
                                            ?.otherBenefits ??
                                        ""),
                          ],
                        ),
                      ),
                    ),

                    Container(
                      color: white1,
                      width: MediaQuery.of(context).size.width,
                      child: TabBar(
                        onTap: (index) async{
                          if(index == 0){
                            ref.refresh(AppliedCandidateResponse());
                          }else if(index == 1){
                            ref.refresh(EnrolledCandidateResponse());
                          }else if(index == 2){
                            ref.refresh(ShortlistedCandidateResponse());
                          }else if(index == 3){
                            ref.refresh(SelectCandidateResponse());
                          }else if(index == 4){
                            ref.refresh(RejectCandidateResponse());
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
                            child: Tab(
                              text: 'Applied',
                            ),
                          ),
                          Container(
                            child: Tab(
                              text: 'Enrolled',
                            ),
                          ),
                          Container(
                            child: Tab(
                              text: 'Shortlisted',
                            ),
                          ),
                          Container(
                            child: Tab(
                              text: 'Selected',
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
                          isApplied == true
                              ? Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: appliedList(widget.campusId,widget.jobId),
                                )
                              : SingleChildScrollView(child: NoDataWidget(content: "No Data Availabale")),
                          isEnrolled == true
                              ? Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: enrolledList(),
                                )
                              : SingleChildScrollView(child: NoDataWidget(content: "No Data Availabale")),
                          isShortlisted == true
                              ? Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: shortListedList(),
                                )
                              : SingleChildScrollView(child: NoDataWidget(content: "No Data Availabale")),
                          isSelected == true
                              ? Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: acceptedList(),
                                )
                              : SingleChildScrollView(child: NoDataWidget(content: "No Data Availabale")),
                          isRejected == true
                              ? Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: rejectedList(),
                                )
                              : SingleChildScrollView(child: NoDataWidget(content: "No Data Availabale")),
                        ],
                      ),
                    ),

                    Padding(
                      padding:
                          const EdgeInsets.only(right: 20, top: 10,bottom: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Recruiter_Web_Campus_List_Candidate(jobId: widget.jobId, campusId: widget.campusId,)));
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
            )
          : NoDataWidget(content: "Unlock New Possibilities"),
    );
  }

//APPLIED CANDIDATE RESPONSE
  AppliedCandidateResponse() async {
    final appliedCandidateApiService = ApiService(ref.read(dioProvider));
    var formData = FormData.fromMap({
      "recruiter_id": await getRecruiterId(),
      "campus_id": widget.campusId,
      "job_id": widget.jobId,
      "no_of_records": "1",
      "page_no": "1",
      "status": "1",
    });
    print("APPLIED LISTED CAMPUS ID : ${widget.campusId}");

    final appliedCandidateResponse =
        await appliedCandidateApiService.post<AppliedCampusCandidateModel>(
            context, ConstantApi.appliedCampusCandidateListUrl, formData);
    if (appliedCandidateResponse.status == true) {
      print("APPLIED LISTED SUCESS");
      setState(() {
        isApplied = true;
        appliedCandidateResponseData = appliedCandidateResponse.data;
      });
    } else {
      setState(() {
        isApplied = false;
      });
      print("ERROR LISTED SUCESS");
    }
  }

  EnrolledCandidateResponse() async {
    final appliedCandidateApiService = ApiService(ref.read(dioProvider));
    var formData = FormData.fromMap({
      "recruiter_id": await getRecruiterId(),
      "campus_id": widget.campusId,
      "job_id": widget.jobId,
      "no_of_records": "1",
      "page_no": "1",
      "status": "2",
    });

    final appliedCandidateResponse =
        await appliedCandidateApiService.post<AppliedCampusCandidateModel>(
            context, ConstantApi.appliedCampusCandidateListUrl, formData);
    if (appliedCandidateResponse.status == true) {
      print("ENROLLED LISTED SUCESS");
      setState(() {
        enrolledCandidateResponseData = appliedCandidateResponse.data;
        isEnrolled = true;
      });
    } else {
      setState(() {
        isEnrolled = false;
      });
      print("ENROLLED LISTED ERROR");
    }
  }

  ShortlistedCandidateResponse() async {
    final appliedCandidateApiService = ApiService(ref.read(dioProvider));
    var formData = FormData.fromMap({
      "recruiter_id": await getRecruiterId(),
      "campus_id": widget.campusId,
      "job_id": widget.jobId,
      "no_of_records": "1",
      "page_no": "1",
      "status": "3",
    });

    final appliedCandidateResponse =
        await appliedCandidateApiService.post<AppliedCampusCandidateModel>(
            context, ConstantApi.appliedCampusCandidateListUrl, formData);
    if (appliedCandidateResponse.status == true) {
      print("SHORLISTED LISTED SUCESS");
      setState(() {
        shortlistedCandidateResponseData = appliedCandidateResponse.data;
        isShortlisted = true;
      });
    } else {
      setState(() {
        isShortlisted = false;
      });
      print("SHORLISTED LISTED ERROR");
    }
  }

  SelectCandidateResponse() async {
    final appliedCandidateApiService = ApiService(ref.read(dioProvider));
    var formData = FormData.fromMap({
      "recruiter_id": await getRecruiterId(),
      "campus_id": widget.campusId,
      "job_id": widget.jobId,
      "no_of_records": "1",
      "page_no": "1",
      "status": "4",
    });

    final appliedCandidateResponse =
        await appliedCandidateApiService.post<AppliedCampusCandidateModel>(
            context, ConstantApi.appliedCampusCandidateListUrl, formData);
    if (appliedCandidateResponse.status == true) {
      print("SELECTED LISTED SUCESS");
      setState(() {
        selectCandidateResponseData = appliedCandidateResponse.data;
        isSelected = true;
      });
    } else {
      setState(() {
        isSelected = false;
      });
      print("SELECTED LISTED ERROR");
    }
  }

  RejectCandidateResponse() async {
    final appliedCandidateApiService = ApiService(ref.read(dioProvider));
    var formData = FormData.fromMap({
      "recruiter_id": await getRecruiterId(),
      "campus_id": widget.campusId,
      "job_id": widget.jobId,
      "no_of_records": "1",
      "page_no": "1",
      "status": "5",
    });

    final appliedCandidateResponse =
        await appliedCandidateApiService.post<AppliedCampusCandidateModel>(
            context, ConstantApi.appliedCampusCandidateListUrl, formData);
    if (appliedCandidateResponse.status == true) {
      print("REJECTED LISTED SUCESS");
      setState(() {
        rejectCandidateResponseData = appliedCandidateResponse.data;
        isRejected = true;
      });
    } else {
      setState(() {
        isRejected = false;
      });
      print("REJECTED LISTED ERROR");
    }
  }

  //CAMPUS JOB DETAIL RESPONSE
  CampusJobDetailResponse() async {
    final campusJobDetailApiService = ApiService(ref.read(dioProvider));
    var formData = FormData.fromMap({
      "job_id": widget.jobId,
    });
    final campusJobDetailResponse =
        await campusJobDetailApiService.post<CampusJobDetailModel>(
            context, ConstantApi.campusJobDetailUrl, formData);
    if (campusJobDetailResponse.status == true) {
      setState(() {
        campusJobDetailResponseData = campusJobDetailResponse.data;
      });
      print("SUCESS");
    } else {
      print("ERROR");
    }
  }

  //CAMPUS APPLIED LIST RESPONSE

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

  Widget appliedList(String? campusId, String? jobId) {
    return ListView.builder(
      itemCount: appliedCandidateResponseData?.items?.length ?? 0,
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) => ProfilePopup(context,
                    TagContain: '',
                    Campus_Id:campusId.toString(),
                    Round: '',
                    candidate_Id: appliedCandidateResponseData?.items?[index].candidate_id ?? "" , Job_Id:jobId.toString()),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 15, right: 20, left: 20),
              child: AppliesList(context,
                  CandidateImg:
                      appliedCandidateResponseData?.items?[index].profilePic ??
                          "",
                  CandidateName:
                      appliedCandidateResponseData?.items?[index].name ?? "",
                  Jobrole: appliedCandidateResponseData?.items?[index].job_title ?? "",
                  color: white1,
                  isWeb: true, isTagNeeded: false, isTagName: ''),
            ));
      },
    );
  }

  Widget enrolledList() {
    return ListView.builder(
      itemCount: enrolledCandidateResponseData?.items?.length ?? 0,
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) => ProfilePopup(
                    context,
                    TagContain: '',
                    Campus_Id: widget.campusId.toString(),
                    Round: '',
                    candidate_Id: enrolledCandidateResponseData?.items?[index].candidate_id ?? "",
                    Job_Id: widget.jobId.toString()),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 15, right: 20, left: 20),
              child: AppliesList(context,
                  CandidateImg:
                      enrolledCandidateResponseData?.items?[index].profilePic ??
                          "",
                  CandidateName:
                      enrolledCandidateResponseData?.items?[index].name ?? "",
                  Jobrole:enrolledCandidateResponseData?.items?[index].job_title ?? "",
                  color: white1,
                  isWeb: true, isTagNeeded: false, isTagName: ''),
            ));
      },
    );
  }

  Widget shortListedList() {
    return ListView.builder(
      itemCount: shortlistedCandidateResponseData?.items?.length ?? 0,
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) => ProfilePopup(
                    context,
                    TagContain: 'Shortlisted for Round',
                    Campus_Id: widget?.jobId ?? "",
                    Round: shortlistedCandidateResponseData?.items?[index].round ?? "",
                    candidate_Id:shortlistedCandidateResponseData?.items?[index].candidate_id ?? "",
                    Job_Id: widget.jobId ?? ""),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 15, right: 20, left: 20),
              child: AppliesListWithTag(
                  context,
                  CandidateImg: shortlistedCandidateResponseData?.items?[index].profilePic ?? "",
                  CandidateName: shortlistedCandidateResponseData?.items?[index].name ?? "",
                  Jobrole: shortlistedCandidateResponseData?.items?[index].job_title ?? "",
                  color: white1, round: shortlistedCandidateResponseData?.items?[index].round ?? ""),
            ));
      },
    );
  }

  Widget acceptedList() {
    return ListView.builder(
      itemCount: selectCandidateResponseData?.items?.length ?? 0,
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) => ProfilePopup(
                    context,
                    TagContain: 'Selected',
                    Campus_Id: widget.campusId ?? "",
                    Round: '',
                    candidate_Id: selectCandidateResponseData?.items?[index].candidate_id ?? "",
                    Job_Id: widget.jobId ?? ""),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 15, right: 20, left: 20),
              child: AppliesList(context,
                  CandidateImg:
                      selectCandidateResponseData?.items?[index].profilePic ??
                          "",
                  CandidateName:
                      selectCandidateResponseData?.items?[index].name ?? "",
                  Jobrole:selectCandidateResponseData?.items?[index].job_title ?? "",
                  color: white1,
                  isWeb: true, isTagNeeded: false, isTagName: ''),
            ));
      },
    );
  }

  Widget rejectedList() {
    return ListView.builder(
      itemCount: rejectCandidateResponseData?.items?.length ?? 0,
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) => ProfilePopup(context,
                    TagContain: 'Rejected the Candidate',
                    Campus_Id: widget.campusId ?? "",
                    Round: '',
                    candidate_Id: rejectCandidateResponseData?.items?[index].candidate_id ?? "",
                    Job_Id: widget.jobId ?? ""),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 15, right: 20, left: 20),
              child: AppliesList(context,
                  CandidateImg:
                      rejectCandidateResponseData?.items?[index].profilePic ??
                          "",
                  CandidateName:
                      rejectCandidateResponseData?.items?[index].name ?? "",
                  Jobrole:rejectCandidateResponseData?.items?[index].job_title ?? "",
                  color: white1,
                  isWeb: true, isTagNeeded: false, isTagName: ''),
            ));
      },
    );
  }

  //CAMPUS COLLEGE LIST WEB
  Widget _campusCollegeList(
    context, {
    required String? isTag,
    required String? iscampTag,
  }) {
    return Container(
      margin: EdgeInsets.only(top: 15, left: 150, right: 150, bottom: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white, // Set the color here
      ),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //COLLEGE LOGO
            Container(
              height: 50,
              width: 50,
              child: buildImage(
                  campusJobDetailResponseData?.college?.logo ?? "",
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
                      width: MediaQuery.of(context).size.width / 2,
                      child: Text(
                        campusJobDetailResponseData?.college?.name ?? "",
                        style: TBlack,
                      )),
                  Row(
                    children: [
                      Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            image: DecorationImage(
                                image: AssetImage("lib/assets/map-pin (1).png"),
                                fit: BoxFit.cover)),
                      ),
                      Text(
                        campusJobDetailResponseData?.college?.location ?? "",
                        style: Homegrey2,
                      )
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(),
            //TAG
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: iscampTag == "On Campus"
                      ? blue2
                      : iscampTag == "Applied"
                          ? blue2
                          : iscampTag == "Assigned"
                              ? green3
                              : iscampTag == "Off Campus"
                                  ? white2
                                  : white1),
              child: Center(
                  child: Padding(
                padding:
                    const EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
                child: Text(
                  iscampTag == "On Campus"
                      ? 'On Campus'
                      : iscampTag == "Off Campus"
                          ? 'Off Campus'
                          : iscampTag == "Applied"
                              ? 'Applied'
                              : iscampTag == "Assigned"
                                  ? 'Assigned'
                                  : '',
                  style: isTag == "Applied"
                      ? appliedT
                      : isTag == "Assigned"
                          ? shortlistedT
                          : isTag == "On Campus"
                              ? appliedT
                              : isTag == "OffCampus"
                                  ? offCampusT
                                  : offCampusT,
                ),
              )),
            ),
          ],
        ),
      ),
    );
  }

  Widget ProfilePopup(BuildContext context,{
    required String TagContain,
    required String Campus_Id,
    required String Round,
    required String candidate_Id,
    required String Job_Id,
  }) {
    return AlertDialog(
      surfaceTintColor: white1,
      content: Container(
        width: 400,
        height: MediaQuery.of(context).size.height,
        child: Recruiter_Web_Campus_Candidate_Profile(
          TagContain: TagContain, Campus_Id: Campus_Id, Round: Round, candidate_Id: candidate_Id, Job_Id: Job_Id,
        ),
        // child: Recruiter_Candidate_Profile_View(),
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
        alignment: Alignment.topRight,
        child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: ImgPathSvg("xcancel.svg"))),
    contentPadding: EdgeInsets.only(right: 20, left: 20, bottom: 0),
    content: Container(
      height: 150,
      width: 350,
      child: Column(
        children: [
          Text(
            "Click to download the ",
            style: walletT,
          ),
          Text(
            "Job Summary",
            style: profileTitle,
          ),
          const SizedBox(
            height: 15,
          ),
          CommonElevatedButton(context, "Download", () {})
        ],
      ),
    ),
  );
}
