import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:getifyjobs/Models/CampusListModel.dart';
import 'package:getifyjobs/Models/DirectListModel.dart';
import 'package:getifyjobs/Models/RecentAppliesModel.dart';
import 'package:getifyjobs/Models/ShortlistedModel.dart';
import 'package:getifyjobs/Src/Common_Widgets/Common_Candidate_Profile.dart';
import 'package:getifyjobs/Src/Common_Widgets/Common_List.dart';
import 'package:getifyjobs/Src/Common_Widgets/Custom_App_Bar.dart';
import 'package:getifyjobs/Src/Common_Widgets/Image_Path.dart';
import 'package:getifyjobs/Src/Common_Widgets/Text_Form_Field.dart';
import 'package:getifyjobs/Src/Recruiter_Mobile_Screen/Home_DashBoard/Notification_Page.dart';
import 'package:getifyjobs/Src/Recruiter_Mobile_Screen/Home_DashBoard/Wallet_Screens.dart';
import 'package:getifyjobs/Src/Recruiter_Mobile_Screen/Recruiter_Request_Call%20_Ui/Recruiter_Request_Call_Screen.dart';
import 'package:getifyjobs/Src/utilits/ApiService.dart';
import 'package:getifyjobs/Src/utilits/Common_Colors.dart';
import 'package:getifyjobs/Src/utilits/ConstantsApi.dart';
import 'package:getifyjobs/Src/utilits/Generic.dart';
import 'package:getifyjobs/Src/utilits/Text_Style.dart';
import 'package:intl/intl.dart';

class Recruiter_Home_Screen extends ConsumerStatefulWidget {
  @override
  _Recruiter_Home_ScreenState createState() => _Recruiter_Home_ScreenState();
}

class _Recruiter_Home_ScreenState extends ConsumerState<Recruiter_Home_Screen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  RecentAppliesData? RecentAppliesResponseData;
  RecentAppliesData? tempjobLists; //

  ShortlistedData? shortlistedResponseData;
  bool? Shortlist;
  bool? isRecentApplies;

  ScrollController _todayController = ScrollController();
  int todayTotalCount = 0;
  int todaypage = 1;
  int switchIndex = 0;
  bool isSearching = false;
  List<DirectListItems>? tempDirectItemList = [];
  List<DirectListItems>? directItemList = [];
  List<CampusListItems>? tempCampusResponseData = [];
  List<CampusListItems>? campusResponseData = [];

  @override
  void initState() {
    super.initState();
    // _todayController.addListener(_todayScrollListener());

    // print("Recur :::: ${ await getRecruiterId()}");
    _tabController = TabController(length: 2, vsync: this);
    RecentApplyListResponse();
    Shortlist = true;
    isRecentApplies = true;
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
        isUsed: false,
        actions: [
          Row(
            children: [
              Text(
                RecentAppliesResponseData?.coins?.coins ?? "",
                style: TitleT,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20, left: 10),
                child: InkWell(
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Wallet_Coin_Screen()));
                  },
                    child: ImgPathSvg("coin.svg")),
              ),
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Recruiter_Request_Call_Screen()));
                  },
                  icon: Icon(
                    Icons.call_outlined,
                    size: 25,
                  )),
              Padding(
                padding: const EdgeInsets.only(right: 20, left: 15),
                child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const NotificationScreen()),
                      );
                    },
                    child: ImgPathSvg("bellalert.svg")),
              ),
            ],
          ),
        ],
        isLogoUsed: false,
        isTitleUsed: true,
        title: '',
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(top: 10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  right: 20, left: 20, top: 20, bottom: 20),
              child: textFormFieldSearchBar(
                  keyboardtype: TextInputType.text,
                  hintText: "Search ...",
                  Controller: null,
                  validating: null,
                  onChanged: (value) {
                    setState(() {
                      if (switchIndex == 0) {
                        if (value != "" && tempDirectItemList != []) {
                          isSearching = true;
                          directItemList = tempDirectItemList!
                              .where((job) =>
                              job.jobTitle!.toLowerCase().contains(value))
                              .toList();
                        } else {
                          directItemList = tempDirectItemList;
                          isSearching = false;
                        }
                      } else {
                        if (value != "" && tempCampusResponseData != []) {
                          isSearching = true;
                          campusResponseData = tempCampusResponseData!
                              .where((job) =>
                              job.name!.toLowerCase().contains(value))
                              .toList();
                        } else {
                          campusResponseData = tempCampusResponseData;
                          isSearching = false;
                        }
                      }
                    });
                  }),
            ),
            Container(
              color: white1,
              width: MediaQuery.of(context).size.width,
              child: TabBar(
                controller: _tabController,
                labelColor: white1,
                onTap: (index) {
                  if (index == 0) {
                    RecentApplyListResponse();
                  } else if (index == 1) {
                    ShortlistedResponse();
                  }
                },
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
                      text: 'Applied',
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width /
                        2, // Equal width for each tab
                    child: Tab(
                      text: 'Shortlisted',
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  isRecentApplies == true?  SingleChildScrollView(
                      child: Padding(
                    padding: const EdgeInsets.only(bottom: 50),
                    child: appliesList(context, RecentAppliesResponseData,
                        isWeb: false),
                  )):Center(
                      child:
                      NoDataMobileWidget(content: "Unlock New Possibilities")),
                  Shortlist == true
                      ? SingleChildScrollView(
                          child: Padding(
                          padding: const EdgeInsets.only(bottom: 50),
                          child: shortListedTabContent(shortlistedResponseData),
                        ))
                      : Center(
                          child:
                              NoDataMobileWidget(content: "Unlock New Possibilities")),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //DIRECT APPLIED LIST RESPONSE
  RecentApplyListResponse() async {
    final ApplyListApiService = ApiService(ref.read(dioProvider));
    var formData = FormData.fromMap({
      'recruiter_id': await getRecruiterId(),
      "no_of_records": '10',
      "page_no": 1,
    });
    final ApplyListApiResponse =
        await ApplyListApiService.post<RecentAppliesModel>(
            context, ConstantApi.recentAppliedListUrl, formData);
    print("JOB ID : ${ApplyListApiResponse.data?.all?.items?[0].jobId ?? ''}");
    if (ApplyListApiResponse.status == true) {
      print('SUCESS');
      setState(() {
        isRecentApplies = true;
        RecentAppliesResponseData = ApplyListApiResponse?.data;
      });
    } else {
      ShowToastMessage(ApplyListApiResponse.message ?? "");
      print('ERROR');
      setState(() {
        isRecentApplies = false;
      });
    }
  }

  //SHORTLISTED LIST RESPONSE
  ShortlistedResponse() async {
    final ShortlistedApiService = ApiService(ref.read(dioProvider));
    var formData = FormData.fromMap({
      'recruiter_id': await getRecruiterId(),
      "no_of_records": '10',
      "page_no": '1',
    });
    final ShortlistedApiResponse =
        await ShortlistedApiService.post<ShortlistedModel>(
            context, ConstantApi.shortlistedUrl, formData);
    print("JOB ID : ${ShortlistedApiResponse.data?.items?[0].jobId ?? ''}");
    if (ShortlistedApiResponse.status == true) {
      print('SHORTLISTED SUCESS');
      setState(() {
        Shortlist = true;

        shortlistedResponseData = ShortlistedApiResponse.data;
      });
    } else {
      ShowToastMessage(ShortlistedApiResponse.message ?? "");
      print('SHORTLISTED ERROR');
      setState(() {
        Shortlist = false;
      });
    }
  }

  Widget appliesList(context, RecentAppliesData? RecentAppliesResponseData,
      {required bool isWeb}) {
    return Container(
      color: white2,
      child: Column(
        children: [
          Padding(
            padding:
            const EdgeInsets.only(top: 25, bottom: 15, left: 20, right: 20),
            child: Container(
              alignment: Alignment.topLeft,
              child: Text(
                "Today's Applies",
                style: profileTitle,
              ),
            ),
          ),
          Container(
              width: MediaQuery.of(context).size.width,
              height:
              ((RecentAppliesResponseData?.today?.items?.length ?? 0) * 110),
              color: white1,
              child: todayApplies(
                RecentAppliesResponseData,
                isWeb: isWeb,
              )),
          Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(top: 20, left: 20),
              child: Text(
                "Applies",
                style: profileTitle,
              )),
          Container(
            // height: 500,
              child:
              AppliesListCandidate(RecentAppliesResponseData, isWeb: isWeb))
        ],
      ),
    );
  }

  Widget todayApplies(RecentAppliesData? RecentAppliesResponseData,
      {required bool isWeb}) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: RecentAppliesResponseData?.today?.items?.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Direct_Candidate_Profile_Screen(
                      TagContain: '',
                      candidate_Id: RecentAppliesResponseData?.today?.items?[index].candidateId ?? "",
                      job_Id: RecentAppliesResponseData
                          ?.today?.items?[index].jobId ??
                          "",
                    )),
              ).then((value) => ref.refresh(RecentApplyListResponse()));
              },
            child: AppliesList(context,
                CandidateImg:
                RecentAppliesResponseData?.today?.items?[index].profilePic ??
                    "",
                CandidateName:
                RecentAppliesResponseData?.today?.items?[index].name ?? "",
                Jobrole:
                RecentAppliesResponseData?.today?.items?[index].jobTitle ??
                    "",
                color: white2,
                isWeb: isWeb, isTagNeeded: false, isTagName: ''),
          ),
        );
      },
    );


  }
}





//APPLIES
Widget AppliesListCandidate(RecentAppliesData? RecentAppliesResponseData,
    {required bool isWeb}) {
  return ListView.builder(
    scrollDirection: Axis.vertical,
    shrinkWrap: true,
    itemCount: RecentAppliesResponseData?.all?.items?.length ?? 0,
    physics: const NeverScrollableScrollPhysics(),
    itemBuilder: (BuildContext context, int index) {
      final data = RecentAppliesResponseData?.all?.items?[index];

      DateTime start =
          new DateFormat("dd MMM yyyy").parse(data?.appliedDate ?? "");

      String previousDate = index > 0
          ? DateFormat('dd MMM yyyy').format(DateFormat("dd MMM yyyy").parse(
              RecentAppliesResponseData?.all?.items?[index - 1].appliedDate ??
                  ""))
          : '';
      String date = DateFormat('dd MMM yyyy').format(start);
      return Column(
        children: [
          date != previousDate
              ? Container(
                  padding: EdgeInsets.only(left: 20, top: 20),
                  alignment: Alignment.topLeft,
                  child: Text(date),
                )
              : SizedBox(),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Direct_Candidate_Profile_Screen(
                            TagContain: '',
                            candidate_Id: RecentAppliesResponseData?.all?.items?[index].candidateId ?? "",
                            job_Id: RecentAppliesResponseData
                                    ?.all?.items?[index].jobId ??
                                "",
                          )),
                );
              },
              child: AppliesList(context,
                  CandidateImg: RecentAppliesResponseData
                          ?.all?.items?[index].profilePic ??
                      "",
                  CandidateName:
                      RecentAppliesResponseData?.all?.items?[index].name ?? "",
                  Jobrole:
                      RecentAppliesResponseData?.all?.items?[index].jobTitle ??
                          "",
                  color: white1,
                  isWeb: isWeb, isTagNeeded: false, isTagName: ''),
            ),
          )
        ],
      );
    },
  );
}

Widget shortListedTabContent(ShortlistedData? shortlistedResponseData) {
  return Column(
    children: [
      Row(
        children: [
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(right: 20, top: 15),
            child: ImgPathSvg('filter.svg'),
          ),
        ],
      ),
      SingleChildScrollView(
          child:
              shortlistedCandidatesList(shortlistedResponseData, isWeb: false))
    ],
  );
}

Widget shortlistedCandidatesList(ShortlistedData? shortlistedResponseData,
    {required bool isWeb}) {
  return Container(
    color: white1,
    child: ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: shortlistedResponseData?.items?.length ?? 0,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Direct_Candidate_Profile_Screen(
                          TagContain: '',
                          candidate_Id: shortlistedResponseData
                                  ?.items?[index].candidateId ??
                              "",
                          job_Id:
                              shortlistedResponseData?.items?[index].jobId ??
                                  "",
                        )),
              );
            },
            child: AppliesList(context,
                CandidateImg:
                    shortlistedResponseData?.items?[index].profilePic ?? "",
                CandidateName:
                    shortlistedResponseData?.items?[index].name ?? "",
                Jobrole: shortlistedResponseData?.items?[index].jobTitle ?? "",
                color: white2,
                isWeb: isWeb, isTagNeeded: false, isTagName: ''),
          ),
        );
      },
    ),
  );
}
