import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:getifyjobs/Models/InterviewModel.dart';
import 'package:getifyjobs/Src/Common_Widgets/Common_List.dart';
import 'package:getifyjobs/Src/Common_Widgets/Custom_App_Bar.dart';
import 'package:getifyjobs/Src/Common_Widgets/Image_Path.dart';
import 'package:getifyjobs/Src/utilits/ApiService.dart';
import 'package:getifyjobs/Src/utilits/Common_Colors.dart';
import 'package:getifyjobs/Src/utilits/ConstantsApi.dart';
import 'package:getifyjobs/Src/utilits/Generic.dart';
import 'package:getifyjobs/Src/utilits/Text_Style.dart';

class Recruiter_Schedule_Cancelled extends ConsumerStatefulWidget {
  @override
  _Recruiter_Schedule_CancelledState createState() =>
      _Recruiter_Schedule_CancelledState();
}

class _Recruiter_Schedule_CancelledState
    extends ConsumerState<Recruiter_Schedule_Cancelled>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  InterviewModel? interviewResponsemodel;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    ScheduleListResponse();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  ScheduleListResponse() async {
    final ApplyListApiService = ApiService(ref.read(dioProvider));
    var formData = FormData.fromMap({
      'recruiter_id': await getRecruiterId(),
      "no_of_records": '20',
      "page_no": "1",
      "status": "7"
    });
    final interviewApiResponse = await ApplyListApiService.post<InterviewModel>(
        context, ConstantApi.allinterviewjobstatus, formData);
    print("JOB ID : ${interviewApiResponse.data?.items?[0].jobId ?? ''}");
    if (interviewApiResponse.status == true) {
      print('SUCESS');
      setState(() {
        interviewResponsemodel = interviewApiResponse;

        // interviewResponsemodel =
        //   interviewApiResponse
        //   .data!.items!.where((item) => item.scheduleData?.action_by == "targetStatus") as InterviewModel?;
      });
    } else {
      setState(() {});
      ShowToastMessage(interviewApiResponse.message ?? "");
      print('ERROR');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white2,
      appBar: Custom_AppBar(
        isUsed: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: ImgPathSvg("filter.svg"),
          ),
        ],
        isLogoUsed: true,
        isTitleUsed: true,
        title: 'Schedule Cancelled',
      ),
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
                      text: 'By You',
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width /
                        2, // Equal width for each tab
                    child: Tab(
                      text: 'By Candidate',
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  //BY YOU
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 50),
                      child: _byYouList(
                        context,
                        CandidateName: 'Praveen M',
                        AppliedRole: 'Augmented Reality (AR) Journey Builder‍',
                        InterviewTime: '09:00AM, 24 Oct 2023',
                        Status: 'Schedule Cancelled',
                      ),
                    ),
                  ),
                  //BY
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 50),
                      child: _byCandidateList(
                        context,
                        CandidateName: 'Praveen M',
                        AppliedRole: 'Augmented Reality (AR) Journey Builder‍',
                        InterviewTime: '09:00AM, 24 Oct 2023',
                        Status: 'Schedule Cancelled',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//BY YOU LIST
Widget _byYouList(context,
    {required String CandidateName,
    required String AppliedRole,
    required String InterviewTime,
    required String Status}) {
  return ListView.builder(
    shrinkWrap: true,
    scrollDirection: Axis.vertical,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: 6,
    itemBuilder: (BuildContext context, int index) {
      return customListItem(context,
          badgeText: CandidateName,
          appliedRole: AppliedRole,
          interviewTime: InterviewTime,
          status: Status,
          badgeTextStyle: ProfileT,
          countTextStyle: W1grey,
          interviewTimeTextStyle: Wgrey,
          statusColor: grey1,
          isWeb: false,
          profileImg: '');
    },
  );
}

//BY CANDIDATE LIST
Widget _byCandidateList(context,
    {required String CandidateName,
    required String AppliedRole,
    required String InterviewTime,
    required String Status}) {
  return ListView.builder(
    shrinkWrap: true,
    scrollDirection: Axis.vertical,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: 6,
    itemBuilder: (BuildContext context, int index) {
      return customListItem(context,
          badgeText: CandidateName,
          appliedRole: AppliedRole,
          interviewTime: InterviewTime,
          status: Status,
          badgeTextStyle: ProfileT,
          countTextStyle: W1grey,
          interviewTimeTextStyle: Wgrey,
          statusColor: grey1,
          isWeb: false,
          profileImg: '');
    },
  );
}
