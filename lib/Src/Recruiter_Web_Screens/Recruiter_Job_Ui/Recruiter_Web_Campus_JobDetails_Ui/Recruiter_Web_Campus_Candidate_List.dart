import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:getifyjobs/Models/AppliedCampusCandidateListModel.dart';
import 'package:getifyjobs/Models/CampusJobdetailModel.dart';
import 'package:getifyjobs/Src/Common_Widgets/Common_List.dart';
import 'package:getifyjobs/Src/Common_Widgets/Custom_App_Bar.dart';
import 'package:getifyjobs/Src/Common_Widgets/Image_Path.dart';
import 'package:getifyjobs/Src/Recruiter_Web_Screens/Recruiter_Candidate_Profile_WebView_Popup.dart';
import 'package:getifyjobs/Src/utilits/ApiService.dart';
import 'package:getifyjobs/Src/utilits/Common_Colors.dart';
import 'package:getifyjobs/Src/utilits/ConstantsApi.dart';
import 'package:getifyjobs/Src/utilits/Generic.dart';
import 'package:getifyjobs/Src/utilits/Text_Style.dart';

import 'Recruiter_Web_Campus_Candidate_Profile.dart';


class Recruiter_Web_Campus_List_Candidate extends ConsumerStatefulWidget {
  String? jobId;
  String? campusId;
  Recruiter_Web_Campus_List_Candidate({required this.jobId,required this.campusId});
  @override
  _Recruiter_Web_Campus_List_CandidateState createState() => _Recruiter_Web_Campus_List_CandidateState();
}

class _Recruiter_Web_Campus_List_CandidateState extends ConsumerState<Recruiter_Web_Campus_List_Candidate>
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
        title: 'List of Candidates',
        isTitleUsed: true,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20,right: 20),
              child: NoOfCandidatesSection(
                  context,
                  jobName: campusJobDetailResponseData?.jobTitle ?? "",
                  noOfCandidates: campusJobDetailResponseData?.vacancies ?? "",
                  postedDate:  campusJobDetailResponseData?.createdDate ?? "", isWeb: true, status: 'Active'
              ),
            ),
            SizedBox(height: 15,),
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
                      text: 'Accept',
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
                    child: appliedList(),
                  )
                      : NoDataWidget(content: "No Data Availabale"),
                  isEnrolled == true
                      ? Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: enrolledList(),
                  )
                      : NoDataWidget(content: "No Data Availabale"),
                  isShortlisted == true
                      ? Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: shortListedList(),
                  )
                      : NoDataWidget(content: "No Data Availabale"),
                  isSelected == true
                      ? Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: acceptedList(),
                  )
                      : NoDataWidget(content: "No Data Availabale"),
                  isRejected == true
                      ? Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: rejectedList(),
                  )
                      : NoDataWidget(content: "No Data Availabale"),
                ],
              ),
            ),
          ],
        ),
      ),
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
        ShowToastMessage(appliedCandidateResponse.message ?? "");

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
        ShowToastMessage(appliedCandidateResponse.message ?? "");

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
        ShowToastMessage(appliedCandidateResponse.message ?? "");
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
        ShowToastMessage(appliedCandidateResponse.message ?? "");
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
        ShowToastMessage(appliedCandidateResponse.message ?? "");
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
      ShowToastMessage(campusJobDetailResponse.message ?? "");

    }
  }
  Widget appliedList() {
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
                    Campus_Id:widget.campusId.toString(),
                    Round: '',
                    candidate_Id: appliedCandidateResponseData?.items?[index].candidate_id ?? "" ,
                    Job_Id:widget.jobId.toString()),
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
