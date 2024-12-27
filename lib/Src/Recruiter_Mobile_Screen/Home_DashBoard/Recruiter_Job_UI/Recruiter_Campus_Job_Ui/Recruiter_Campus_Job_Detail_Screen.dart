import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:getifyjobs/Models/AppliedCampusCandidateListModel.dart';
import 'package:getifyjobs/Models/CampusJobdetailModel.dart';
import 'package:getifyjobs/Src/Common_Widgets/Common_Button.dart';
import 'package:getifyjobs/Src/Common_Widgets/Common_Candidate_Profile.dart';
import 'package:getifyjobs/Src/Common_Widgets/Common_JodDetails.dart';
import 'package:getifyjobs/Src/Common_Widgets/Common_List.dart';
import 'package:getifyjobs/Src/Common_Widgets/Custom_App_Bar.dart';
import 'package:getifyjobs/Src/Common_Widgets/Image_Path.dart';
import 'package:getifyjobs/Src/Common_Widgets/Text_Form_Field.dart';
import 'package:getifyjobs/Src/Recruiter_Mobile_Screen/Home_DashBoard/Recruiter_Job_UI/Bulk_Job.dart';
import 'package:getifyjobs/Src/Recruiter_Mobile_Screen/Home_DashBoard/Recruiter_Job_UI/Recruiter_Campus_Job_Ui/Recruiter_Campus_List_Candidates.dart';
import 'package:getifyjobs/Src/Recruiter_Mobile_Screen/Home_DashBoard/Recruiter_Job_UI/Recruiter_Direct_Job_Ui/List_Of_Candidates_Page.dart';
import 'package:getifyjobs/Src/Recruiter_Mobile_Screen/Home_DashBoard/Recruiter_Job_UI/Recruiter_Direct_Job_Ui/Recuiter_JobDetail_Page.dart';
import 'package:getifyjobs/Src/utilits/ApiService.dart';
import 'package:getifyjobs/Src/utilits/Common_Colors.dart';
import 'package:getifyjobs/Src/utilits/ConstantsApi.dart';
import 'package:getifyjobs/Src/utilits/Generic.dart';
import 'package:getifyjobs/Src/utilits/Text_Style.dart';

import 'Recruiter_Campus_Profile_Interview_Screen.dart';
class Recruiter_Campus_Job_Detail_Screen extends ConsumerStatefulWidget {
  String? jobId;
  String? campusId;
   Recruiter_Campus_Job_Detail_Screen({super.key,required this.jobId,required this.campusId});

  @override
  ConsumerState<Recruiter_Campus_Job_Detail_Screen> createState() => _Recruiter_Campus_Job_Detail_ScreenState();
}

class _Recruiter_Campus_Job_Detail_ScreenState extends ConsumerState<Recruiter_Campus_Job_Detail_Screen>
    with SingleTickerProviderStateMixin{
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
        title: "",
        isUsed: true,
        actions: [
          PopupMenuButton(
              surfaceTintColor: white1,
              icon: Icon(Icons.more_vert_outlined),
              itemBuilder: (BuildContext context)=>[
                // PopupMenuItem(child: InkWell(
                //     onTap: (){
                //       showDialog(
                //         context: context,
                //         builder: (BuildContext context) => _DownloadPopUp(context),
                //       );
                //     },
                //     child: Text('Download',style: refferalCountT,))),
                PopupMenuItem(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute
                      (builder: (context)=>
                        BulkJobs(job_Id: campusJobDetailResponseData?.jobId ?? "", 
                          campus_Id: campusJobDetailResponseData?.college?.campusId ?? "",
                          campusJobDetailResponseData: campusJobDetailResponseData, 
                          isEditBulk: true,))).then((value) => ref.refresh(CampusJobDetailResponse()));
                    },
                    child: Text('Edit',style: refferalCountT,)),
                PopupMenuItem(child: InkWell(
                    onTap: (){
                    },
                    child: Text('Clone',style: refferalCountT,))),
                // PopupMenuItem(child: InkWell(
                //     onTap: (){
                //     },
                //     child: Text('Pause',style: refferalCountT,))),
                // PopupMenuItem(child: InkWell(
                //     onTap: (){
                //     },
                //     child: Text('Stop',style: refferalCountT,))),
                // PopupMenuItem(child: InkWell(
                //     onTap: (){
                //     },
                //     child: Text('Delete',style: refferalCountT,))),
                // PopupMenuItem(child: Text('Download',style: refferalCountT,)),
              ]),
        ],
        isLogoUsed: true,
        isTitleUsed: true,
      ),
      body:
      campusJobDetailResponseData?.college != null
          ?  SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 5,bottom: 15),
              child: CampusList2(
                isTag: 'Assigned',
                iscampTag: 'Assigned',
                isUsed: true,
                isOnCampus: true,
                companyName: campusJobDetailResponseData?.college?.name ?? "",
                companyLogo: campusJobDetailResponseData?.college?.logo ?? "",
                companyLocation: campusJobDetailResponseData?.college?.location ?? "",
              ),
            ),
            _Common_job_Deatil_Section(),
            Padding(
              padding: const EdgeInsets.only(top:5,bottom: 15,left: 20,right: 20),
              child: Text("List of Candidates",style: pdfT,),
            ),
            Container(
              color: white1,
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: TabBar(
                onTap: (index){
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
                labelPadding: EdgeInsets.all(2),
                indicator: BoxDecoration(
                    color: blue1
                ),
                indicatorColor: grey4,
                unselectedLabelColor: grey4,
                indicatorPadding: EdgeInsets.zero,
                isScrollable: false,
                indicatorSize: TabBarIndicatorSize.tab,
                tabs: [
                  Container(
                    width: MediaQuery.of(context).size.width / 5, // Equal width for each tab
                    child: Tab(
                      text: 'Applied',
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 5, // Equal width for each tab
                    child: Tab(
                      text: 'Enrolled',
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 4.8, // Equal width for each tab
                    child: Tab(
                      text: 'Shortlisted',
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 5, // Equal width for each tab
                    child: Tab(
                      text: 'Selected',
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 5, // Equal width for each tab
                    child: Tab(
                      text: 'Rejected',
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 300,
              // color: Colors.cyan,
              child: TabBarView(
                controller: _tabController,
                children: [
                 isApplied == true? appliedList(appliedCandidateResponseData,widget.campusId,widget.jobId):NoDataMobileWidget(content: 'Unlock New Possibilities'),
                  isEnrolled==true?enrolledList(enrolledCandidateResponseData,widget.campusId,widget.jobId):NoDataMobileWidget(content: 'Unlock New Possibilities'),
                 isShortlisted == true? shortListedList(shortlistedCandidateResponseData,widget.campusId,widget.jobId):NoDataMobileWidget(content: 'Unlock New Possibilities'),
                 isSelected == true? selectedList(selectCandidateResponseData,widget.campusId,widget.jobId):NoDataMobileWidget(content: 'Unlock New Possibilities'),
                  isRejected == true?rejectedList(rejectCandidateResponseData,widget.campusId,widget.jobId):NoDataMobileWidget(content: 'Unlock New Possibilities'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20,top: 15,bottom: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(onPressed: (){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Recruiter_Campus_List_Candidates
                          (campusId: widget.campusId, jobId: widget.jobId,)));
                  },
                      child: Text("View all",style: noOfCandidatesStyle,)),
                ],
              ),
            )
          ],
        ),
      ):NoDataWidget(content: "Unlock New Possibilities"),
    );
  }
  //APPLIED CANDIDATE RESPONSE
  AppliedCandidateResponse() async {
    final appliedCandidateApiService = ApiService(ref.read(dioProvider));
    var formData = FormData.fromMap({
      "recruiter_id": await getRecruiterId(),
      "campus_id": widget.campusId,
      "job_id": widget.jobId,
      "no_of_records": "10",
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
      "no_of_records": "10",
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
      "no_of_records": "10",
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
      "no_of_records": "10",
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
      "no_of_records": "10",
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

  Widget _Common_job_Deatil_Section(){
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20,right: 20),
          child:
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //JOB TITLE
              Text(campusJobDetailResponseData?.jobTitle ?? "",style: TitleT,),
              //COMPANY LOGO AND NAME
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: buildCompanyInfoRow(
                    campusJobDetailResponseData?.logo ?? "",
                    campusJobDetailResponseData?.companyName ?? "",
                    TBlack,
                    50, 50, isMapLogo: false),
              ),
              //POSTED DATE
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Text("Posted on: "+ "${campusJobDetailResponseData?.createdDate ?? ""}",style: posttxt,),
              ),
              //POSTED DATE
              SizedBox(height: 5,),
              //JOB DESCRIPTIONS
              _JobDescriptionContainer()
            ],
          ),
        ),
        SizedBox(height: 10,),

      ],
    );

  }


  Widget _JobDescriptionContainer(){
    return Container(
      color: white1,
      child: Padding(
        padding: const EdgeInsets.only(left: 15,right: 15,top: 15,bottom: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _JobDescriptionSection1(),
            //JOB DESCRIPTION CONTENT
            Text("Job Description",style: TitleT,),
            Text(campusJobDetailResponseData?.jobDescription ?? "".toString(),style:desctxt,textAlign: TextAlign.justify,),
            SizedBox(height: 20,),
            textWithheader(headertxt: "No of Vacancies", subtxt: campusJobDetailResponseData?.vacancies ?? ""),
            textWithheader(headertxt: "No of Rounds", subtxt: campusJobDetailResponseData?.rounds ?? ""),
            textWithheader(headertxt: "Qualification", subtxt: campusJobDetailResponseData?.qualification ?? ""),
            textWithheader(headertxt: "Specialization", subtxt: campusJobDetailResponseData?.specialization ?? ""),
            campusJobDetailResponseData?.currentArrears == "" ?Container():textWithheader(headertxt: "Current Arrears", subtxt: campusJobDetailResponseData?.currentArrears ?? ""),
            campusJobDetailResponseData?.historyOfArrears == "" ?Container():textWithheader(headertxt: "History of Arrears", subtxt: campusJobDetailResponseData?.historyOfArrears ?? ""),
            campusJobDetailResponseData?.requiredPercentage == ""? Container():textWithheader(headertxt: "Required Percentage/CGPA", subtxt: campusJobDetailResponseData?.requiredPercentage ?? ""),
            campusJobDetailResponseData?.statutoryBenefits == ""? Container():textWithheader(headertxt: "Statutory Benefits", subtxt:campusJobDetailResponseData?.statutoryBenefits ?? ""),
            campusJobDetailResponseData?.socialBenefits ==""?Container(): textWithheader(headertxt: "Social Benefits", subtxt:campusJobDetailResponseData?.socialBenefits ?? ""),
            campusJobDetailResponseData?.otherBenefits ==""?Container(): textWithheader(headertxt: "Other Benefits", subtxt: campusJobDetailResponseData?.otherBenefits ?? ""),
          ],
        ),
      ),
    );
  }

  Widget _JobDescriptionSection1(){
    return Column(
      children: [
        SizedBox(height: 5,),
        //LOCATION
        _IconWithText(iconimg: "map-pin.svg", icontext: campusJobDetailResponseData?.location ?? ""),
        //SALARY
        _IconWithText(iconimg: "wallet.svg", icontext: '₹ ${campusJobDetailResponseData?.salaryFrom ?? ""} - ${campusJobDetailResponseData?.salaryTo ?? ""} Per Annum')
      ],
    );
  }

  Widget _IconWithText({required String iconimg,required String icontext}){
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          ImgPathSvg(iconimg),
          SizedBox(width: 5,),
          Expanded(child: Text(icontext,style: posttxt))
        ],
      ),
    );
  }

  Widget appliedList(AppliedCandidateData? appliedCandidateResponseData, String? campusId, String? jobId){
    return ListView.builder(
      itemCount: appliedCandidateResponseData?.items?.length ?? 0,
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
            onTap: (){
              // Navigator.push(context, MaterialPageRoute(builder: (context)=>Job_Details()));
            },
            child: Padding(
              padding: const EdgeInsets.only(top:15,right: 20,left: 20),
              child: InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>
                      Recruiter_Campus_Peofile_Interview_Screen(
                        TagContain: appliedCandidateResponseData?.items?[index].round ?? "",
                        candidate_Id:  appliedCandidateResponseData?.items?[index].candidate_id ?? "",
                        Job_Id: jobId,
                        Campus_Id: campusId, Round: '', time: '', interviewDate: '',))).then((value) => ref.refresh(AppliedCandidateResponse()));
                },
                child: AppliesList(
                    context,
                    CandidateImg: appliedCandidateResponseData?.items?[index].profilePic ?? "",
                    CandidateName:  appliedCandidateResponseData?.items?[index].name ?? "",
                    Jobrole:   appliedCandidateResponseData?.items?[index].job_title ?? "",
                    color: white1, isWeb: false, isTagNeeded: true, isTagName: appliedCandidateResponseData?.items?[index].round ?? ""),
              ),
            ));
      },);
  }

  Widget shortListedList(AppliedCandidateData? shortlistedCandidateResponseData, String? campusId, String? jobId){
    return ListView.builder(
      itemCount: shortlistedCandidateResponseData?.items?.length ?? 0,
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Recruiter_Campus_Peofile_Interview_Screen(
                TagContain: shortlistedCandidateResponseData?.items?[index].round ?? "",
                candidate_Id: shortlistedCandidateResponseData?.items?[index].candidate_id ?? "",
                Job_Id: jobId,
                Campus_Id: campusId, Round: shortlistedCandidateResponseData?.items?[index].round ?? "",
                time: shortlistedCandidateResponseData?.items?[index].interviewTime ?? "",
                interviewDate: shortlistedCandidateResponseData?.items?[index].interviewDate ?? "",))).then((value) => ref.refresh(ShortlistedCandidateResponse()));
            },
            child: Padding(
                padding: const EdgeInsets.only(top:15,right: 20,left: 20),
                child: AppliesListWithTag(
                    context,
                    CandidateImg: shortlistedCandidateResponseData?.items?[index].profilePic ?? "",
                    CandidateName: shortlistedCandidateResponseData?.items?[index].name ?? "",
                    Jobrole: shortlistedCandidateResponseData?.items?[index].job_title ?? "",
                    color: white1, round:
                shortlistedCandidateResponseData?.items?[index].round == "Final Round"?
                "${shortlistedCandidateResponseData?.items?[index].round ?? ""}":shortlistedCandidateResponseData?.items?[index].round == "Call For Interview"?"${shortlistedCandidateResponseData?.items?[index].round ?? ""}":"Round ${shortlistedCandidateResponseData?.items?[index].round ?? ""}")
            ));
      },);
  }

  Widget enrolledList(AppliedCandidateData? enrolledCandidateResponseData, String? campusId, String? jobId){
    return ListView.builder(
      itemCount: enrolledCandidateResponseData?.items?.length ?? 0,
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>
                  Recruiter_Campus_Peofile_Interview_Screen(
                    TagContain: '',
                    candidate_Id: enrolledCandidateResponseData?.items?[index].candidate_id ?? "",
                    Job_Id: jobId,
                    Campus_Id: campusId, Round: '', time: '', interviewDate: '',))).then((value) => ref.refresh(EnrolledCandidateResponse()));
            },
            child: Padding(
              padding: const EdgeInsets.only(top:15,right: 20,left: 20),
              child: AppliesList(
                  context,
                  CandidateImg: enrolledCandidateResponseData?.items?[index].profilePic ?? "",
                  CandidateName: enrolledCandidateResponseData?.items?[index].name ?? "",
                  Jobrole: enrolledCandidateResponseData?.items?[index].job_title ?? "",
                  color: white1, isWeb: false, isTagNeeded: false, isTagName: ''),
            ));
      },);
  }

  Widget selectedList(AppliedCandidateData? selectCandidateResponseData, String? campusId, String? jobId){
    return ListView.builder(
      itemCount: selectCandidateResponseData?.items?.length ?? 0,
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>
                  Recruiter_Campus_Peofile_Interview_Screen(
                    TagContain: 'Selected', candidate_Id: selectCandidateResponseData?.items?[index].candidate_id ?? "",
                    Job_Id:jobId,
                    Campus_Id: campusId, Round: '', time: '', interviewDate: '',))).then((value) => ref.refresh(SelectCandidateResponse()));
            },
            child: Padding(
              padding: const EdgeInsets.only(top:15,right: 20,left: 20),
              child: AppliesList(
                  context,
                  CandidateImg: selectCandidateResponseData?.items?[index].profilePic ?? "",
                  CandidateName:  selectCandidateResponseData?.items?[index].name ?? "",
                  Jobrole: selectCandidateResponseData?.items?[index].job_title ?? "",
                  color: white1, isWeb: false, isTagNeeded: false, isTagName: ''),
            ));
      },);
  }

  Widget rejectedList(AppliedCandidateData? rejectCandidateResponseData, String? campusId, String? jobId){
    return ListView.builder(
      itemCount: rejectCandidateResponseData?.items?.length ?? 0,
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>
                  Recruiter_Campus_Peofile_Interview_Screen(
                    TagContain: 'Rejected the Candidate', candidate_Id: rejectCandidateResponseData?.items?[index].candidate_id ?? '',
                    Job_Id: jobId,
                    Campus_Id: campusId, Round: '', time: '', interviewDate: '',))).then((value) => ref.refresh(RejectCandidateResponse()));
            },
            child: Padding(
              padding: const EdgeInsets.only(top:15,right: 20,left: 20),
              child: AppliesList(
                  context,
                  CandidateImg: rejectCandidateResponseData?.items?[index].profilePic ?? '',
                  CandidateName: rejectCandidateResponseData?.items?[index].name ?? '',
                  Jobrole: rejectCandidateResponseData?.items?[index].job_title ?? '',
                  color: white1, isWeb: false, isTagNeeded: false, isTagName: ''),
            ));
      },);
  }
}


//DOWNLOAD POPUP
Widget _DownloadPopUp(BuildContext context) {
  return AlertDialog(
    backgroundColor: white1,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
    titlePadding: EdgeInsets.all(0),
    title: Container(alignment:Alignment.topRight,child: IconButton(onPressed: (){
      Navigator.pop(context);
    }, icon: ImgPathSvg("xcancel.svg"))),
    contentPadding: EdgeInsets.only(right: 20,left: 20,bottom: 0),
    content: Container(
      height: 150,
      width: 350,
      child: Column(
        children: [
          Text("Click to download the ",style: walletT,),
          Text("Job Summary",style: profileTitle,),
          const SizedBox(height: 15,),
          CommonElevatedButton(context, "Download", () { })
        ],
      ),
    ),
  );
}