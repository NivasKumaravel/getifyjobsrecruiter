import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:getifyjobs/Models/RequestCallListModel.dart';
import 'package:getifyjobs/Src/Common_Widgets/Common_List.dart';
import 'package:getifyjobs/Src/Common_Widgets/Custom_App_Bar.dart';
import 'package:getifyjobs/Src/Recruiter_Mobile_Screen/Call_Histroy_Ui/Call_History_Screen.dart';
import 'package:getifyjobs/Src/utilits/ApiService.dart';
import 'package:getifyjobs/Src/utilits/Common_Colors.dart';
import 'package:getifyjobs/Src/utilits/ConstantsApi.dart';
import 'package:getifyjobs/Src/utilits/Generic.dart';
import 'package:getifyjobs/Src/utilits/Text_Style.dart';


class Recruiter_Request_Call_Screen extends ConsumerStatefulWidget {
  @override
  _Recruiter_Request_Call_ScreenState createState() => _Recruiter_Request_Call_ScreenState();
}

class _Recruiter_Request_Call_ScreenState extends ConsumerState<Recruiter_Request_Call_Screen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  RequestCallListData? requestResponseData;


  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    RequestedCallResponse();
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
        isLogoUsed: true,title: 'Request Call', isTitleUsed: true,),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Container(
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
                    width: MediaQuery.of(context).size.width / 2, // Equal width for each tab
                    child: Tab(
                      text: 'Call Requested',
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 2, // Equal width for each tab
                    child: Tab(
                      text: 'Call Completed',
                    ),
                  ),

                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: SingleChildScrollView(child: shortlistedCandidatesList(requestResponseData)),
                  ),
                  SingleChildScrollView(child: RequestCallCompleted()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  //REQUESTED CALL RESPONSE
  RequestedCallResponse() async{
    final requestedCallApiService = ApiService(ref.read(dioProvider));
    var formData = FormData.fromMap({
      "recruiter_id": await getRecruiterId(),
      "no_of_records":10,
      "page_no":1,
    });
    final requestCallResponse = await requestedCallApiService.post<RequestCallListModel>
      (context, ConstantApi.requestCallListUrl, formData);
    if(requestCallResponse?.status == true){
      print("REQUESTED LIST SUCESS");
      setState(() {
        requestResponseData = requestCallResponse?.data;
      });
      ShowToastMessage(requestCallResponse?.message ?? "");
    }else{
      print("REQUESTED LIST ERROR");
      ShowToastMessage(requestCallResponse?.message ?? "");
    }
  }
}

Widget shortlistedCandidatesList(RequestCallListData? requestResponseData) {
  return ListView.builder(
    shrinkWrap: true,
    scrollDirection: Axis.vertical,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: requestResponseData?.items?.length ?? 0,
    itemBuilder: (BuildContext context, int index) {
      return Padding(
        padding:
        const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
        child: InkWell(
          onTap: () {
          },
          child: AppliesList(context,
              CandidateImg: requestResponseData?.items?[index].profilePic ?? "",
              CandidateName:requestResponseData?.items?[index].name ?? "",
              Jobrole: requestResponseData?.items?[index].jobTitle ?? "",
              color: white1,
              isWeb: false, isTagNeeded: false, isTagName: ''),
        ),
      );
    },
  );
}
Widget RequestCallCompleted() {
  return ListView.builder(
    shrinkWrap: true,
    scrollDirection: Axis.vertical,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: 5,
    itemBuilder: (BuildContext context, int index) {
      return Padding(
        padding:
        const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
        child: InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Call_History_Screen()));
          },
          child: AppliesList(context,
              CandidateImg:'',
              CandidateName:"Arun",
              Jobrole:"Flutter Developer",
              color: white1,
              isWeb: false, isTagNeeded: false, isTagName: ''),
        ),
      );
    },
  );
}