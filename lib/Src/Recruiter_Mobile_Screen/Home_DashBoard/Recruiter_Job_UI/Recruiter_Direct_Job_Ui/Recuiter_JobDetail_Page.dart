import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:getifyjobs/Models/DirectApplyListModel.dart';
import 'package:getifyjobs/Models/DirectCandidateListModel.dart';
import 'package:getifyjobs/Models/DirectDetailsModel.dart';
import 'package:getifyjobs/Src/Common_Widgets/Common_Button.dart';
import 'package:getifyjobs/Src/Common_Widgets/Common_Candidate_Profile.dart';
import 'package:getifyjobs/Src/Common_Widgets/Common_JodDetails.dart';
import 'package:getifyjobs/Src/Common_Widgets/Common_List.dart';
import 'package:getifyjobs/Src/Common_Widgets/Custom_App_Bar.dart';
import 'package:getifyjobs/Src/Common_Widgets/Image_Path.dart';
import 'package:getifyjobs/Src/Common_Widgets/Text_Form_Field.dart';
import 'package:getifyjobs/Src/Recruiter_Mobile_Screen/Home_DashBoard/Recruiter_Job_UI/Recruiter_Create_Job.dart';
import 'package:getifyjobs/Src/Recruiter_Mobile_Screen/Home_DashBoard/Recruiter_Job_UI/Recruiter_Direct_Job_Ui/List_Of_Candidates_Page.dart';
import 'package:getifyjobs/Src/Recruiter_Mobile_Screen/Home_DashBoard/Recruiter_Job_UI/Recruiter_Direct_Job_Ui/Recruiter_Candidate_Profile_View.dart';
import 'package:getifyjobs/Src/utilits/ApiService.dart';
import 'package:getifyjobs/Src/utilits/Common_Colors.dart';
import 'package:getifyjobs/Src/utilits/ConstantsApi.dart';
import 'package:getifyjobs/Src/utilits/Generic.dart';
import 'package:getifyjobs/Src/utilits/Text_Style.dart';

class Recruiter_JobDetail_Page extends ConsumerStatefulWidget {
  String? job_Id;

  Recruiter_JobDetail_Page({super.key, required this.job_Id});

  @override
  ConsumerState<Recruiter_JobDetail_Page> createState() =>
      _Recruiter_JobDetail_PageState();
}

class _Recruiter_JobDetail_PageState
    extends ConsumerState<Recruiter_JobDetail_Page>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  DirectDetailsData? DirectJobDetailResponseData;
  DirectCandidateListData? allListResponseData;
  DirectCandidateListData? shortlistedListResponseData;
  DirectCandidateListData? scheduledListResponseData;
  DirectCandidateListData? rejectedListResponseData;
  bool? allListStatus;
  bool? shortlisteStatus;
  bool? scheduleStatus;
  bool? rejectStatus;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      DirectJobDetailResponse();
    });
    AllListResponse();
    allListStatus = true;
    shortlisteStatus = true;
    scheduleStatus = true;
    rejectStatus=true;
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
              itemBuilder: (BuildContext context) => [
                    PopupMenuItem(
                        child: InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    _DownloadPopUp(context),
                              );
                            },
                            child: Text(
                              'Download',
                              style: refferalCountT,
                            ))),
                    PopupMenuItem(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CreateJob(
                                        DirectJobDetailResponseData:
                                            DirectJobDetailResponseData,
                                        isEdit: true,
                                        Job_Id: DirectJobDetailResponseData
                                                ?.jobId ??
                                            "",
                                      ))).then((value) =>
                              ref.refresh(DirectJobDetailResponse()));
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
        isLogoUsed: true,
        isTitleUsed: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Common_job_Deatil_Section(),
            Padding(
              padding: const EdgeInsets.only(
                  top: 5, bottom: 15, left: 20, right: 20),
              child: Text(
                "List of Candidates",
                style: pdfT,
              ),
            ),
            Container(
              color: white1,
              // width: MediaQuery.of(context).size.width,
              height: 50,
              child:
              TabBar(
                onTap: (index){
                  if(index == 0){
                    AllListResponse();
                  }else if(index == 1){
                    ShortListResponse();
                  }else if(index == 2){
                    ScheduledListResponse();
                  }else if(index == 3){
                    RejectedListResponse();
                  }
                },
                controller: _tabController,
                labelColor: white1,
                labelStyle: TabT,
                indicator: BoxDecoration(color: blue1),
                labelPadding: EdgeInsets.all(2),
                indicatorColor: grey4,
                unselectedLabelColor: grey4,
                indicatorPadding: EdgeInsets.zero,
                isScrollable: false,
                indicatorSize: TabBarIndicatorSize.tab,
                tabs: [
                  Container(
                    width: MediaQuery.of(context).size.width /
                        5, // Equal width for each tab
                    child: Tab(
                      text: 'All',
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width /
                        4.8, // Equal width for each tab
                    child: Tab(
                      text: 'Shortlisted',
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width /
                        5, // Equal width for each tab
                    child: Tab(
                      text: 'Scheduled',
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width /
                        5, // Equal width for each tab
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
                  allListStatus == true? allList():NoDataMobileWidget(content: "Unlock New Possibilities"),
                shortlisteStatus == true? shortListedList():NoDataMobileWidget(content: "Unlock New Possibilities"),
                  scheduleStatus == true?scheduledList():NoDataMobileWidget(content: "Unlock New Possibilities"),
                 rejectStatus == true? rejectedList():NoDataMobileWidget(content: "Unlock New Possibilities"),
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
                                    List_Of_Candidates_Page(
                                      job_Id: widget.job_Id,
                                      job_Name: DirectJobDetailResponseData?.jobTitle ?? "",
                                      posted_Date: DirectJobDetailResponseData?.createdDate ?? "",))).then((value) => ref.refresh(AllListResponse()));
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
    );
  }

  Widget _Common_job_Deatil_Section() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //JOB TITLE
              Text(
                DirectJobDetailResponseData?.jobTitle ?? "",
                style: TitleT5,
              ),
              //COMPANY LOGO AND NAME
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: buildCompanyInfoRow(
                    DirectJobDetailResponseData?.logo ?? "", DirectJobDetailResponseData?.companyName ?? "", TBlack, 50, 50,
                    isMapLogo: false),
              ),
              //POSTED DATE
              Padding(
                padding: const EdgeInsets.only(top: 12, bottom: 8),
                child: Text(
                  "Posted on : " +
                      "${DirectJobDetailResponseData?.createdDate ?? ""}",
                  style: posttxt,
                ),
              ),
              //POSTED DATE
              Text(
                "Deadline : " +"${DirectJobDetailResponseData?.expiryDate ?? ""}",
                style: deadtxt,
              ),
              SizedBox(
                height: 5,
              ),
              //JOB DESCRIPTIONS
              _JobDescriptionContainer()
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }

  //DIRECT JOB DETAIL RESPONSE
  DirectJobDetailResponse() async {
    final directJobDetailApiService = ApiService(ref.read(dioProvider));
    var formData = FormData.fromMap({
      'job_id':widget.job_Id,
      "user_type":"recruiter",
    });
    final directJobDetailApiResponse =
        await directJobDetailApiService.post<DirectDetailsModel>(
            context, ConstantApi.directJobDetailsUrl, formData);

    if (directJobDetailApiResponse?.status == true) {
      print('DIRECT DETAIL SUCESS');
      setState(() {
        DirectJobDetailResponseData = directJobDetailApiResponse.data;
      });
      print("RESPONSE : ${DirectJobDetailResponseData?.jobId ?? ""}");
    }else{
      print('DIRECT DETAIL ERROR');

      ShowToastMessage(directJobDetailApiResponse.message ?? "");

    }
  }

  //ALL LIST RESPONSE
  AllListResponse()async{
    final allListApiService = ApiService(ref.read(dioProvider));
    var formData = FormData.fromMap({
      "recruiter_id":await getRecruiterId(),
      "job_id":widget.job_Id,
      "no_of_records":10,
      "page_no":1,
      "status":1,
    });
    final allListApiResponse = await allListApiService.post<DirectCandidateListModel>(context,
        ConstantApi.directCandidateListUrl, formData);
    if(allListApiResponse?.status == true){
      print("ALL CANDIDATE LISTED SUCESS");
      setState(() {
        allListStatus = true;
        allListResponseData = allListApiResponse.data;
      });
    }else{
      print("ALL CANDIDATE LISTED ERROR");
      setState(() {
        allListStatus = false;
      });
      ShowToastMessage(allListApiResponse.message ?? "");
    }
  }

  //SHORTLISTEED LIST RESPONSE
  ShortListResponse()async{
    final allListApiService = ApiService(ref.read(dioProvider));
    var formData = FormData.fromMap({
      "recruiter_id":await getRecruiterId(),
      "job_id":widget.job_Id,
      "no_of_records":10,
      "page_no":1,
      "status":2,
    });
    final allListApiResponse = await allListApiService.post<DirectCandidateListModel>(context,
        ConstantApi.directCandidateListUrl, formData);
    if(allListApiResponse?.status == true){
      print("SHORTLISTED CANDIDATE LISTED SUCESS");
      setState(() {
        shortlisteStatus = true;
        shortlistedListResponseData = allListApiResponse.data;
      });
    }else{
      print("SHORTLISTED CANDIDATE LISTED ERROR");
      setState(() {
        shortlisteStatus = false;
      });
      ShowToastMessage(allListApiResponse.message ?? "");
    }
  }

  //SCHEDULED LIST RESPONSE
  ScheduledListResponse()async{
    final allListApiService = ApiService(ref.read(dioProvider));
    var formData = FormData.fromMap({
      "recruiter_id":await getRecruiterId(),
      "job_id":widget.job_Id,
      "no_of_records":10,
      "page_no":1,
      "status":3,
    });
    final allListApiResponse = await allListApiService.post<DirectCandidateListModel>(context,
        ConstantApi.directCandidateListUrl, formData);
    if(allListApiResponse?.status == true){
      print("SCHEDULED CANDIDATE LISTED SUCESS");
      setState(() {
        scheduleStatus = true;
        scheduledListResponseData = allListApiResponse.data;
      });
    }else{
      print("SCHEDULED CANDIDATE LISTED ERROR");
      setState(() {
        scheduleStatus = false;
      });
      ShowToastMessage(allListApiResponse.message ?? "");
    }
  }

  //REJECTED LIST RESPONSE
  RejectedListResponse()async{
    final allListApiService = ApiService(ref.read(dioProvider));
    var formData = FormData.fromMap({
      "recruiter_id":await getRecruiterId(),
      "job_id":widget.job_Id,
      "no_of_records":10,
      "page_no":1,
      "status":4,
    });
    final allListApiResponse = await allListApiService.post<DirectCandidateListModel>(context,
        ConstantApi.directCandidateListUrl, formData);
    if(allListApiResponse?.status == true){
      print("REJECTED CANDIDATE LISTED SUCESS");
      setState(() {
        rejectStatus = true;
        rejectedListResponseData = allListApiResponse.data;
      });
    }else{
      print("REJECTED CANDIDATE LISTED ERROR");
      setState(() {
        rejectStatus = false;
      });
      ShowToastMessage(allListApiResponse.message ?? "");
    }
  }

  Widget _JobDescriptionContainer() {
    return Container(
      color: white1,
      child: Padding(
        padding:
            const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _JobDescriptionSection1(),
            //JOB DESCRIPTION CONTENT
            Text(
              "Job Description",
              style: TitleT,
            ),
            Text(
              DirectJobDetailResponseData?.jobDescription ?? "",
              style: desctxt,
            ),
            SizedBox(
              height: 20,
            ),
             textWithheader(
                headertxt: "Skill Set",
                subtxt: DirectJobDetailResponseData?.skills ?? ""),
            textWithheader(
                headertxt: "Qualification",
                subtxt: DirectJobDetailResponseData?.qualification ?? ""),

            DirectJobDetailResponseData?.specialization == null ? Container() :
            textWithheader(
                headertxt: "Specialization",
                subtxt: DirectJobDetailResponseData?.specialization ?? ""),


            DirectJobDetailResponseData?.currentArrears == ''
                ? Container()
                : textWithheader(
                    headertxt: "Current Arrears",
                    subtxt: DirectJobDetailResponseData?.currentArrears ?? ""),
            DirectJobDetailResponseData?.historyOfArrears == ''
                ? Container()
                : textWithheader(
                    headertxt: "History of Arrears",
                    subtxt:
                        DirectJobDetailResponseData?.historyOfArrears ?? ""),
            DirectJobDetailResponseData?.requiredPercentage == null
                ? Container()
                : textWithheader(
                    headertxt: "Required Percentage/CGPA",
                    subtxt:
                        DirectJobDetailResponseData?.requiredPercentage ?? ""),
            textWithheader(
                headertxt: "Work Type",
                subtxt: DirectJobDetailResponseData?.workType ?? ""),
            DirectJobDetailResponseData?.workMode == "Please Select"
                ? Container()
                : textWithheader(
                    headertxt: "Work Mode",
                    subtxt: DirectJobDetailResponseData?.workMode ?? ""),
            textWithheader(
                headertxt: "Shift Details",
                subtxt: DirectJobDetailResponseData?.shiftDetails ?? ""),

            // DirectJobDetailResponseData?.salaryFrom == '' && DirectJobDetailResponseData?.salaryTo == '' ? Container() :
            // textWithheader(
            //     headertxt: "Salary Range",
            //     subtxt: '₹${DirectJobDetailResponseData?.salaryFrom ?? ""} - ₹${DirectJobDetailResponseData?.salaryTo ?? ""}'),

            DirectJobDetailResponseData?.statutoryBenefits == ''
                ? Container()
                : textWithheader(
                    headertxt: "Statutory Benefits",
                    subtxt:
                        DirectJobDetailResponseData?.statutoryBenefits ?? ""),
            DirectJobDetailResponseData?.socialBenefits == ''
                ? Container()
                : textWithheader(
                    headertxt: "Social Benefits",
                    subtxt: DirectJobDetailResponseData?.socialBenefits ?? ""),
            DirectJobDetailResponseData?.otherBenefits == ''
                ? Container()
                : textWithheader(
                    headertxt: "Other Benefits",
                    subtxt: DirectJobDetailResponseData?.otherBenefits ?? ""),


          ],
        ),
      ),
    );
  }

  Widget _JobDescriptionSection1() {
    return Column(
      children: [
        SizedBox(
          height: 5,
        ),
        SahreWithText(
            iconimg: "bag.svg",
            icontext: DirectJobDetailResponseData?.experience ?? ""),

        //LOCATION
        _IconWithText(
            iconimg: "map-pin.svg",
            icontext: DirectJobDetailResponseData?.location ?? ""),
        //SALARY
        _IconWithText(
            iconimg: "wallet.svg",
            icontext:
                '₹ ${DirectJobDetailResponseData?.salaryFrom ?? ""} - ${DirectJobDetailResponseData?.salaryTo ?? ""} LPA')
      ],
    );
  }

  Widget _IconWithText({required String iconimg, required String icontext}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          ImgPathSvg(iconimg),
          SizedBox(
            width: 5,
          ),
          Expanded(child: Text(icontext, style: posttxt))
        ],
      ),
    );
  }
  Widget SahreWithText({required String iconimg, required String icontext}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          ImgPathSvg(iconimg),
          SizedBox(
            width: 5,
          ),
          Expanded(child: Text(icontext, style: posttxt)),
          const Spacer(),
          ImgPathSvg('share.svg'),
        ],
      ),
    );
  }

  Widget allList() {
    return ListView.builder(
      itemCount: allListResponseData?.items?.length ?? 0,
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                     Direct_Candidate_Profile_Screen(
                       TagContain:allListResponseData?.items?[index].jobStatus ?? "",
                       candidate_Id: allListResponseData?.items?[index].candidateId ?? "",
                       job_Id: widget.job_Id,)),
              ).then((value) => ref.refresh(AllListResponse()));
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 15, right: 20, left: 20),
              child: AppliesList(context,
                  CandidateImg: allListResponseData?.items?[index].profilePic ?? "",
                  CandidateName: allListResponseData?.items?[index].name ?? "",
                  Jobrole: allListResponseData?.items?[index].jobTitle ?? "",
                  color: white1,
                  isWeb: false, isTagNeeded: true, isTagName: allListResponseData?.items?[index].jobStatus ?? ""),
            ));
      },
    );
  }

  Widget shortListedList() {
    return ListView.builder(
      itemCount: shortlistedListResponseData?.items?.length ?? 0,
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        Direct_Candidate_Profile_Screen(
                          TagContain: 'Shortlisted',
                          candidate_Id: allListResponseData?.items?[index].candidateId ?? "",
                          job_Id: widget.job_Id,)),
              ).then((value) => ref.refresh(ShortListResponse()));

            },
            child: Padding(
              padding: const EdgeInsets.only(top: 15, right: 20, left: 20),
              child: AppliesList(context,
                  CandidateImg: shortlistedListResponseData?.items?[index].profilePic ?? "",
                  CandidateName: shortlistedListResponseData?.items?[index].name ?? "",
                  Jobrole: shortlistedListResponseData?.items?[index].jobTitle ?? "",
                  color: white1,
                  isWeb: false, isTagNeeded: false, isTagName: ''),
            ));
      },
    );
  }

  Widget scheduledList() {
    return ListView.builder(
      itemCount: scheduledListResponseData?.items?.length ?? 0,
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        Direct_Candidate_Profile_Screen(
                        TagContain: scheduledListResponseData?.items?[index].jobStatus ?? "",
                          candidate_Id: scheduledListResponseData?.items?[index].candidateId ?? "",
                          job_Id: widget.job_Id,)),
              ).then((value) => ref.refresh(ScheduledListResponse()));

            },
            child: Padding(
              padding: const EdgeInsets.only(top: 15, right: 20, left: 20),
              child: AppliesList(context,
                  CandidateImg:scheduledListResponseData?.items?[index].profilePic ?? "",
                  CandidateName: scheduledListResponseData?.items?[index].name ?? "",
                  Jobrole: scheduledListResponseData?.items?[index].jobTitle ?? "",
                  color: white1,
                  isWeb: false, isTagNeeded: false, isTagName: ''),
            ));
      },
    );
  }

  Widget rejectedList() {
    return ListView.builder(
      itemCount: rejectedListResponseData?.items?.length ?? 0,
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        Direct_Candidate_Profile_Screen(
                          TagContain: 'Rejected',
                          candidate_Id: rejectedListResponseData?.items?[index].candidateId ?? "",
                          job_Id: widget.job_Id,)),
              ).then((value) => ref.refresh(RejectedListResponse()));
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 15, right: 20, left: 20),
              child: AppliesList(context,
                  CandidateImg: rejectedListResponseData?.items?[index].profilePic ?? "",
                  CandidateName: rejectedListResponseData?.items?[index].name ?? "",
                  Jobrole: rejectedListResponseData?.items?[index].jobTitle ?? "",
                  color: white1,
                  isWeb: false, isTagNeeded: false, isTagName: ''),
            ));
      },
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
