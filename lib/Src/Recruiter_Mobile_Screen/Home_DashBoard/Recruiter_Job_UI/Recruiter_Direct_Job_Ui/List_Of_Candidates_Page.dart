import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:getifyjobs/Models/DirectCandidateListModel.dart';
import 'package:getifyjobs/Src/Common_Widgets/Common_Candidate_Profile.dart';
import 'package:getifyjobs/Src/Common_Widgets/Common_List.dart';
import 'package:getifyjobs/Src/Common_Widgets/Custom_App_Bar.dart';
import 'package:getifyjobs/Src/Common_Widgets/Image_Path.dart';
import 'package:getifyjobs/Src/Common_Widgets/Text_Form_Field.dart';
import 'package:getifyjobs/Src/Recruiter_Mobile_Screen/Home_DashBoard/Recruiter_Job_UI/Recruiter_Direct_Job_Ui/Recruiter_Candidate_Profile_View.dart';
import 'package:getifyjobs/Src/utilits/ApiService.dart';
import 'package:getifyjobs/Src/utilits/Common_Colors.dart';
import 'package:getifyjobs/Src/utilits/ConstantsApi.dart';
import 'package:getifyjobs/Src/utilits/Generic.dart';
import 'package:getifyjobs/Src/utilits/Text_Style.dart';
class List_Of_Candidates_Page extends ConsumerStatefulWidget {
  final String? job_Id;
  final String? job_Name;
  final String? posted_Date;
  const List_Of_Candidates_Page({super.key,required this.job_Id,required this.job_Name,required this.posted_Date});

  @override
  ConsumerState<List_Of_Candidates_Page> createState() => _List_Of_Candidates_PageState();
}

class _List_Of_Candidates_PageState extends ConsumerState<List_Of_Candidates_Page>
    with SingleTickerProviderStateMixin{
  late TabController _tabController;
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
        title: "List of Candidates",
        isUsed: true,
        actions: [],
        isLogoUsed: true,
        isTitleUsed: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20,right: 20),
            child: NoOfCandidatesSection(
              context,
                jobName: widget.job_Name.toString(),
                noOfCandidates: "3 Candidates",
                postedDate: widget.posted_Date.toString(), isWeb: false, status: ''
            ),
          ),
          SizedBox(height: 15,),
          Container(
            color: white1,
            width: MediaQuery.of(context).size.width,
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
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                allListStatus == true? Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: allList(),
                ):NoDataMobileWidget(content: "No Data Available"),
                shortlisteStatus == true? Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: shortListedList(),
                ):NoDataMobileWidget(content: "No Data Available"),
                scheduleStatus == true?Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: scheduledList(),
                ):NoDataMobileWidget(content: "No Data Available"),
                rejectStatus == true? Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: rejectedList(),
                ):NoDataMobileWidget(content: "No Data Available"),
              ],
            ),
          ),
        ],
      ),
    );
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

  Widget allList() {
    return ListView.builder(
      itemCount: allListResponseData?.items?.length ?? 0,
      physics: const ScrollPhysics(),
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
                          TagContain: allListResponseData?.items?[index].jobStatus ?? "",
                          candidate_Id: allListResponseData?.items?[index].candidateId ?? "",
                          job_Id: widget.job_Id,)),
              ).then((value) => ref.refresh(AllListResponse()));
            },
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20, right: 20, left: 20),
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
      physics: const ScrollPhysics(),
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
              padding: const EdgeInsets.only(bottom: 20, right: 20, left: 20),
              child: AppliesList(context,
                  CandidateImg: shortlistedListResponseData?.items?[index].profilePic ?? "",
                  CandidateName: shortlistedListResponseData?.items?[index].name ?? "",
                  Jobrole: shortlistedListResponseData?.items?[index].jobTitle ?? "",
                  color: white1,
                  isWeb: false, isTagNeeded: false, isTagName: shortlistedListResponseData?.items?[index].jobStatus ?? ""),
            ));
      },
    );
  }

  Widget scheduledList() {
    return ListView.builder(
      itemCount: scheduledListResponseData?.items?.length ?? 0,
      physics: const ScrollPhysics(),
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
                          candidate_Id: allListResponseData?.items?[index].candidateId ?? "",
                          job_Id: widget.job_Id,)),
              ).then((value) => ref.refresh(ScheduledListResponse()));

            },
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20, right: 20, left: 20),
              child: AppliesList(context,
                  CandidateImg:scheduledListResponseData?.items?[index].profilePic ?? "",
                  CandidateName: scheduledListResponseData?.items?[index].name ?? "",
                  Jobrole: scheduledListResponseData?.items?[index].jobTitle ?? "",
                  color: white1,
                  isWeb: false, isTagNeeded: false, isTagName: scheduledListResponseData?.items?[index].jobStatus ?? ""),
            ));
      },
    );
  }

  Widget rejectedList() {
    return ListView.builder(
      itemCount: rejectedListResponseData?.items?.length ?? 0,
      physics: const ScrollPhysics(),
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
                          TagContain: 'Rejected the Candidate',
                          candidate_Id: allListResponseData?.items?[index].candidateId ?? "",
                          job_Id: widget.job_Id,)),
              ).then((value) => ref.refresh(RejectedListResponse()));
            },
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20, right: 20, left: 20),
              child: AppliesList(context,
                  CandidateImg: rejectedListResponseData?.items?[index].profilePic ?? "",
                  CandidateName: rejectedListResponseData?.items?[index].name ?? "",
                  Jobrole: rejectedListResponseData?.items?[index].jobTitle ?? "",
                  color: white1,
                  isWeb: false, isTagNeeded: false, isTagName: rejectedListResponseData?.items?[index].jobStatus ?? ""),
            ));
      },
    );
  }
}
