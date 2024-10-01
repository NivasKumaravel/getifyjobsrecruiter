import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:getifyjobs/Models/RecentAppliesModel.dart';
import 'package:getifyjobs/Src/Common_Widgets/Common_List.dart';
import 'package:getifyjobs/Src/Common_Widgets/Image_Path.dart';
import 'package:getifyjobs/Src/Common_Widgets/Text_Form_Field.dart';
import 'package:getifyjobs/Src/Recruiter_Web_Screens/Recruiter_Candidate_Profile_WebView_Popup.dart';
import 'package:getifyjobs/Src/utilits/ApiService.dart';
import 'package:getifyjobs/Src/utilits/Common_Colors.dart';
import 'package:getifyjobs/Src/utilits/ConstantsApi.dart';
import 'package:getifyjobs/Src/utilits/Generic.dart';
import 'package:getifyjobs/Src/utilits/Text_Style.dart';
import 'package:intl/intl.dart';

class Recruiter_Web_Recent_Applies extends ConsumerStatefulWidget {
  @override
  _Recruiter_Web_Recent_AppliesState createState() => _Recruiter_Web_Recent_AppliesState();
}

class _Recruiter_Web_Recent_AppliesState extends ConsumerState<Recruiter_Web_Recent_Applies>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  RecentAppliesData? RecentAppliesResponseData;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    RecentApplyListResponse();
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
              padding: const EdgeInsets.only(
                  right: 150, left: 150, top: 20),
              child: textFormFieldSearchBar(
                keyboardtype: TextInputType.text,
                hintText: "Search ...",
                Controller: null,
                validating: null,
                onChanged: null,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 25,left: 150,right: 150),
              color: white1,
              width: MediaQuery.of(context).size.width,
              child: TabBar(
                controller: _tabController,
                labelColor: white1,
                labelStyle: TabT,
                indicator: BoxDecoration(
                    color: blue1
                ),
                indicatorColor: grey4,
                unselectedLabelColor: grey4,
                indicatorPadding: EdgeInsets.zero,
                indicatorSize: TabBarIndicatorSize.tab,
                tabs: [
                  Container(
                    width: 80, // Equal width for each tab
                    child: Tab(
                      text: 'All',
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width , // Equal width for each tab
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
                  SingleChildScrollView(child:
                  Padding(
                    padding: const EdgeInsets.only(right: 150,left: 150,bottom: 50),
                    child: _appliesList(context, isWeb: true),
                  )),
                  SingleChildScrollView(child: Padding(
                    padding: const EdgeInsets.only(left: 150,right: 150,bottom: 50),
                    child: _shortListedTabContent(),
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _appliesList(context,{required bool isWeb}) {
    return SingleChildScrollView(
      child: Container(
        color: white2,
        child: Column(
          children: [
            Padding(
              padding:
              const EdgeInsets.only(top: 25, bottom: 15, right: 20),
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
                // height: 300,
                color: white1,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: _todayApplies(isWeb: isWeb),
                )),
            Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(top: 20,),
                child: Text(
                  "Applies",
                  style: profileTitle,
                )),
            Container(
              // height: 500,
                child:InkWell(
                    onTap: (){
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => ProfilePopup(context),
                      );
                    },
                    child: _AppliesListCandidate(isWeb: isWeb)))
          ],
        ),
      ),
    );
  }
  RecentApplyListResponse()async{
    final ApplyListApiService = ApiService(ref.read(dioProvider));
    var formData = FormData.fromMap({
      'recruiter_id':await getRecruiterId(),
      "no_of_records":'1',
      "page_no":"1"
    });
    final ApplyListApiResponse = await ApplyListApiService.post<RecentAppliesModel>(context, ConstantApi.recentAppliedListUrl, formData);
    print("JOB ID : ${ApplyListApiResponse.data?.all?.items?[0].jobId ?? ''}");
    if(ApplyListApiResponse.status == true){
      print('SUCESS');
      setState(() {
        RecentAppliesResponseData = ApplyListApiResponse?.data;
      });
    }else{
      ShowToastMessage(ApplyListApiResponse.message ?? "");
      print('ERROR');
    }
  }


  Widget _todayApplies({required bool isWeb}) {
    return ListView.builder(
      shrinkWrap: true,
      // scrollDirection: Axis.vertical,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: RecentAppliesResponseData?.today?.items?.length ?? 0,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
          child: InkWell(
            onTap: (){
              showDialog(
                context: context,
                builder: (BuildContext context) => ProfilePopup(context),
              );
            },
            child: AppliesList(context,
                CandidateImg: RecentAppliesResponseData?.today?.items?[index].profilePic ?? "",
                CandidateName: RecentAppliesResponseData?.today?.items?[index].name ?? "",
                Jobrole: RecentAppliesResponseData?.today?.items?[index].jobTitle ?? "", color: white2, isWeb: isWeb,
                isTagNeeded: null, isTagName: ''),
          ),
        );
      },
    );
  }

//APPLIES
  Widget _AppliesListCandidate({required bool isWeb}) {

    return ListView.builder(
      // scrollDirection: Axis.vertical,
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
              padding: EdgeInsets.only(top: 20),
              alignment: Alignment.topLeft,
              child: Text(date),
            )
                : SizedBox(),
            Padding(
              padding: const EdgeInsets.only( top: 15),
              child: AppliesList(context,
                  CandidateImg: RecentAppliesResponseData?.all?.items?[index].profilePic ?? "",
                  CandidateName: RecentAppliesResponseData?.all?.items?[index].name ?? "",
                  Jobrole: RecentAppliesResponseData?.all?.items?[index].jobTitle ?? "", color: white1, isWeb: isWeb, isTagNeeded: null, isTagName: ''
              ),
            ),
          ],
        );
      },
    );
  }
  Widget _shortListedTabContent(){
    return Column(
      children: [
        Row(
          children: [
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(right: 20,top: 15),
              child: ImgPathSvg('filter.svg'),
            ),
          ],
        ),
        SingleChildScrollView(child: _shortlistedCandidatesList(isWeb: false))
      ],
    );
  }
  Widget _shortlistedCandidatesList({required bool isWeb}) {
    return Container(
      color: white1,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 10,bottom: 10),
            child: InkWell(
              onTap: (){
                showDialog(
                  context: context,
                  builder: (BuildContext context) => ProfilePopup(context),
                );
              },
              child: AppliesList(context,
                  CandidateImg: 'candidateImg.png',
                  CandidateName: 'Karthik Raja S',
                  Jobrole: 'Augmented Reality (AR) Journey Builder‍',
                  color: white2, isWeb: isWeb, isTagNeeded: null, isTagName: ''),
            ),
          );
        },
      ),
    );
  }

  Widget ProfilePopup(BuildContext context) {
    return AlertDialog(
      surfaceTintColor: white1,
      content:SingleChildScrollView(
        child: Container(
          width: 400,
          height: MediaQuery.of(context).size.height,
          child: Recruiter_Candidate_Profile_WebView_Popup(isPdfNeeded: true, isCampus: false, TagContain: '', isBottomNeeded: true, isAppbarNeeded: true,),
          // child: Recruiter_Candidate_Profile_View(),
        ),
      ),
    );
  }
}

