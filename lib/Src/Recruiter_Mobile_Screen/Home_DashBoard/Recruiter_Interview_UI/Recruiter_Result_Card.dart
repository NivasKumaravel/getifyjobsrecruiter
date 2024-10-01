import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:getifyjobs/Models/InterviewModel.dart';
import 'package:getifyjobs/Src/Common_Widgets/Common_Candidate_Profile.dart';
import 'package:getifyjobs/Src/Common_Widgets/Common_List.dart';
import 'package:getifyjobs/Src/Common_Widgets/Custom_App_Bar.dart';
import 'package:getifyjobs/Src/Common_Widgets/Image_Path.dart';
import 'package:getifyjobs/Src/utilits/ApiService.dart';
import 'package:getifyjobs/Src/utilits/Common_Colors.dart';
import 'package:getifyjobs/Src/utilits/ConstantsApi.dart';
import 'package:getifyjobs/Src/utilits/Generic.dart';
import 'package:getifyjobs/Src/utilits/Text_Style.dart';

class Recruiter_Result_Card extends ConsumerStatefulWidget {
  final String? CardType;
  Recruiter_Result_Card({super.key, required this.CardType});

  @override
  ConsumerState<Recruiter_Result_Card> createState() =>
      _Recruiter_Result_CardState();
}

class _Recruiter_Result_CardState extends ConsumerState<Recruiter_Result_Card> {
  InterviewModel? interviewResponsemodel;
  bool? requestedList;

  String? cardTitle(String cardTit) {
    switch (widget.CardType) {
      case "Wait List":
        return "Wait List";
      case "Selected":
        return "Selected";
      case "Not Attended":
        return "Not Attended";
      case "Rejected":
        return "Rejected";
      default:
        return "Default Card";
    }
  }

  ResultsResponse(String status) async {
    final ApplyListApiService = ApiService(ref.read(dioProvider));
    var formData = FormData.fromMap({
      'recruiter_id': await getRecruiterId(),
      "no_of_records": '20',
      "page_no": "1",
      "status": status
    });
    final interviewApiResponse = await ApplyListApiService.post<InterviewModel>(
        context, ConstantApi.allinterviewjobstatus, formData);
    print("JOB ID : ${interviewApiResponse.data?.items?[0].jobId ?? ''}");
    if (interviewApiResponse.status == true) {
      print('SUCESS');
      setState(() {
        interviewResponsemodel = interviewApiResponse;
        requestedList = true;
      });
    } else {
      setState(() {
        requestedList = false;
      });
      ShowToastMessage(interviewApiResponse.message ?? "");
      print('ERROR');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    switch (widget.CardType) {
      case "Wait List":
        ResultsResponse("8");

      case "Selected":
        ResultsResponse("9");

      case "Not Attended":
        ResultsResponse("not_attend");
      case "Rejected":
        ResultsResponse("10");

      default:
        break;
    }
    requestedList = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white2,
      appBar: Custom_AppBar(
        isUsed: false,
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 20),
              child: ImgPathSvg("filter.svg"))
        ],
        isLogoUsed: true,
        title: cardTitle(widget.CardType ?? ""),
        isTitleUsed: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.sizeOf(context).width,
          child: Padding(
            padding: const EdgeInsets.only(left: 20,right: 20),
            child: Column(
              children: [_ResultCardList()],
            ),
          ),
        ),
      ),
    );
  }

//RESULT CARD LIST
  Widget _ResultCardList() {
    return requestedList == true
        ? ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: interviewResponsemodel?.data?.items?.length ?? 0,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Direct_Candidate_Profile_Screen(
                      TagContain: widget.CardType,
                      candidate_Id:interviewResponsemodel?.data?.items?[index].candidateId ?? "" ,
                      job_Id: interviewResponsemodel?.data?.items?[index].jobId ?? ""))).then((value) => ref.refresh(ResultsResponse(widget.CardType ?? "")));
                },
                child: customListItem(context,
                    badgeText:
                        interviewResponsemodel?.data?.items?[index].name ?? "",
                    appliedRole:
                        interviewResponsemodel?.data?.items?[index].jobTitle ??
                            "",
                    interviewTime: interviewResponsemodel
                            ?.data?.items?[index].scheduleData?.interviewTime ??
                        "",
                    status: "${widget.CardType}",
                    badgeTextStyle: ProfileT,
                    countTextStyle: W1grey,
                    interviewTimeTextStyle: Wgrey,
                    statusColor: grey1,
                    isWeb: false,
                    profileImg: interviewResponsemodel?.data?.items?[index].profilePic ?? ""),
              );
            },
          )
        : Center(child: NoDataMobileWidget(content: "No Data Available"));
  }
}
