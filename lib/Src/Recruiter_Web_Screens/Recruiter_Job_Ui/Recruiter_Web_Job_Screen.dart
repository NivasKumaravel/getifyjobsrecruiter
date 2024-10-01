import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:getifyjobs/Models/CampusListModel.dart';
import 'package:getifyjobs/Models/DirectListModel.dart';
import 'package:getifyjobs/Src/Common_Widgets/Common_List.dart';
import 'package:getifyjobs/Src/Common_Widgets/Custom_App_Bar.dart';
import 'package:getifyjobs/Src/Common_Widgets/Image_Path.dart';
import 'package:getifyjobs/Src/Common_Widgets/Image_Widget.dart';
import 'package:getifyjobs/Src/Common_Widgets/Text_Form_Field.dart';
import 'package:getifyjobs/Src/Recruiter_Web_Screens/Recruiter_Job_Ui/Recruiter_Web_Campus_JobDetails_Ui/Recruiter_Web_College_Detail_Screen.dart';
import 'package:getifyjobs/Src/Recruiter_Web_Screens/Recruiter_Job_Ui/Recruiter_Web_Create_Job.dart';
import 'package:getifyjobs/Src/utilits/ApiService.dart';
import 'package:getifyjobs/Src/utilits/Common_Colors.dart';
import 'package:getifyjobs/Src/utilits/ConstantsApi.dart';
import 'package:getifyjobs/Src/utilits/Generic.dart';
import 'package:getifyjobs/Src/utilits/Text_Style.dart';
import 'package:intl/intl.dart';

import 'Recruiter_Web_Bulk_Job.dart';
import 'Recruiter_Web_Campus_JobDetails_Ui/Recruiter_Web_Campus_JobList_Page.dart';
import 'Recruiter_Web_Direct_JobDetails_Ui/Recruiter_Web_Direct_JobDetail_Screen.dart';

class Recruiter_Web_Job_screen extends ConsumerStatefulWidget {
  const Recruiter_Web_Job_screen({super.key});

  @override
  ConsumerState<Recruiter_Web_Job_screen> createState() =>
      _Recruiter_Web_Job_screenState();
}

class _Recruiter_Web_Job_screenState
    extends ConsumerState<Recruiter_Web_Job_screen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  CampusListData? campusResponseData;
  DirectListData? directResponseData;
  bool? isCampusList;
  bool? isDirectList;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    DirectResponse();
    isCampusList = true;
    isDirectList = true;
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
            Padding(
              padding: const EdgeInsets.only(right: 150, left: 150, top: 20),
              child: textFormFieldSearchBar(
                keyboardtype: TextInputType.text,
                hintText: "Search ...",
                Controller: null,
                validating: null,
                onChanged: null,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  right: 150, bottom: 15, top: 15, left: 20),
              child: Row(
                children: [
                  Spacer(),
                  PopupMenuButton(
                      surfaceTintColor: white1,
                      itemBuilder: (BuildContext context) => [
                            PopupMenuItem(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Recruiter_Web_CreateJob(
                                                DirectJobDetailResponseData:null,
                                                isEdit: false,
                                                Job_Id: '',
                                              ))).then(
                                      (value) => ref.read(DirectResponse())).then((value) => ref.read(DirectResponse()));
                                },
                                child: Text(
                                  'Single Job',
                                  style: refferalCountT,
                                )),
                          ],
                      child: Text(
                        "+Create Job",
                        style: addMoreT,
                      )),
                ],
              ),
            ),
            Container(
              color: white1,
              margin: EdgeInsets.only(left: 150, right: 150),
              width: MediaQuery.of(context).size.width,
              child: TabBar(
                onTap: (index) async{
                  if(index == 0){
                    DirectResponse();
                  }else if(index == 1){
                    CampusResponse();
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
                    width: 80, // Equal width for each tab
                    child: Tab(
                      text: 'Direct',
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context)
                        .size
                        .width, // Equal width for each tab
                    child: Tab(
                      text: 'Campus',
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(

                controller: _tabController,
                children: [
                  isDirectList == true
                      ? SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                bottom: 50, left: 150, right: 150),
                            child: _jobsList(directResponseData),
                          ),
                        )
                      : NoDataWidget(content: 'No Data Available'),
                  isCampusList == true
                      ? SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                bottom: 50, left: 150, right: 150),
                            child: _campusList(),
                          ),
                        )
                      : NoDataWidget(content: 'No Data Available'),
                  // AppliesListCandidate(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //DIRECT LIST
  DirectResponse() async {
    final directListApiService = ApiService(ref.read(dioProvider));
    var formData = FormData.fromMap({
      'recruiter_id': await getRecruiterId(),
      "no_of_records": "10",
      "page_no": '1',
    });
    final directListResponse = await directListApiService.post<DirectListModel>(
        context, ConstantApi.directListUrl, formData);
    if (directListResponse.status == true) {
      isDirectList = true;
      setState(() {
        directResponseData = directListResponse.data;
      });
      print(
          "DIRECT LIST RESPONSE ${directResponseData?.items?[0].jobId ?? ""}");
    } else {
      ShowToastMessage(directListResponse.message ?? "");
      isDirectList = false;
      print("ERROR");
    }
  }

  //CAMPUS LIST
  CampusResponse() async {
    final campusListApiService = ApiService(ref.read(dioProvider));
    var formData = FormData.fromMap({
      'recruiter_id': await getRecruiterId(),
      "no_of_records": "10",
      "page_no": '1',
    });
    final campusListResponse = await campusListApiService.post<CampusListModel>(
        context, ConstantApi.campusListUrl, formData);
    if (campusListResponse.status == true) {
      isCampusList = true;
      setState(() {
        campusResponseData = campusListResponse.data;
      });
      print(
          'CAMPUS ID  : ${campusListResponse.data?.items?[0].campusId ?? ""}');
    } else {
      ShowToastMessage(campusListResponse.message ?? "");
      isCampusList = false;
      print("ERROR");
    }
  }

  Widget _jobsList(DirectListData? directResponseData) {
    return ListView.builder(
        itemCount: directResponseData?.items?.length ?? 0,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          final data = directResponseData?.items?[index];

          DateTime start =
          new DateFormat("dd MMM yyyy").parse(data?.createdDate ?? "");

          String previousDate = index > 0
              ? DateFormat('dd MMM yyyy').format(DateFormat("dd MMM yyyy").parse(
              directResponseData?.items?[index - 1].createdDate ??
                  ""))
              : '';
          String date = DateFormat('dd MMM yyyy').format(start);
          return Column(
            children: [
              date != previousDate
                  ? Container(
                padding: EdgeInsets.only(top: 20),
                alignment: Alignment.topLeft,
                child: Text(date),
              )
                  : SizedBox(),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Recruiter_Web_Direct_JobDetail(
                                jobId:
                                    directResponseData?.items?[index].jobId ?? "",
                              ))).then((value) => ref.refresh(DirectResponse()));
                },
                child: NoOfCandidatesSection(context,
                    jobName: directResponseData?.items?[index]?.jobTitle ?? "",
                    noOfCandidates:
                        "${directResponseData?.items?[index]?.appliedCandidate ?? 0}",
                    postedDate:
                        "Posted: ${directResponseData?.items?[index]?.createdDate ?? ""}",
                    isWeb: true,
                    status: directResponseData?.items?[index].job_status ?? ""),
              ),
            ],
          );
        });
  }

  Widget _campusList() {
    return ListView.builder(
        itemCount: campusResponseData?.items?.length ?? 0,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
              onTap: () {
                campusResponseData?.items?[index].status == "Assigned"
                    ? Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                Recruiter_Web_Campus_JobList_Page(
                                  campusId: campusResponseData
                                          ?.items?[index]?.campusId ??
                                      "",
                                )))
                    : Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                Recruiter_Web_College_Detail_Screen(
                                  campus_id: campusResponseData
                                          ?.items?[index]?.campusId ??
                                      "",
                                )));
              },
              child: _campusCollegeList(
                context,
                isTag: campusResponseData?.items?[index].status ?? "",
                iscampTag: campusResponseData?.items?[index].status ?? "",
                CollegeName: campusResponseData?.items?[index].name ?? "",
                collegeLogo: campusResponseData?.items?[index].logo ?? "",
                location: campusResponseData?.items?[index].location ?? "",
              ));
        });
  }
}

//CAMPUS COLLEGE LIST WEB
Widget _campusCollegeList(context,
    {required String? isTag,
    required String? iscampTag,
    required String CollegeName,
    required String collegeLogo,
    required String location}) {
  return Container(
    margin: EdgeInsets.only(
      top: 15,
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      color: Colors.white, // Set the color here
    ),
    child: Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //COMPANY LOGO
          Container(
            height: 50,
            width: 50,
            child: buildImage(collegeLogo,
                border: const Radius.circular(25), fit: BoxFit.cover),
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
                      CollegeName,
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
                      location,
                      style: Homegrey2,
                    )
                  ],
                ),
              ],
            ),
          ),
          //TAG
          const Spacer(),
          Container(
            // width: 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: iscampTag == "Applied"
                    ? blue2
                    : iscampTag == "Assigned"
                        ? green3
                        : white1),
            child: Center(
                child: Padding(
              padding:
                  const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
              child: Text(
                iscampTag == "Applied"
                    ? 'Applied'
                    : iscampTag == "Assigned"
                        ? 'Assigned'
                        : '',
                style: isTag == "Applied"
                    ? appliedT
                    : isTag == "Assigned"
                        ? shortlistedT
                        : offCampusT,
              ),
            )),
          ),
        ],
      ),
    ),
  );
}
