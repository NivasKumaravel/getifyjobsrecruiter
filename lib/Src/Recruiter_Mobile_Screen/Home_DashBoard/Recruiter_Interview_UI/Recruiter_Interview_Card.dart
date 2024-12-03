import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:getifyjobs/Models/InterviewModel.dart';
import 'package:getifyjobs/Src/Common_Widgets/Common_Button.dart';
import 'package:getifyjobs/Src/Common_Widgets/Common_Candidate_Profile.dart';
import 'package:getifyjobs/Src/Common_Widgets/Common_List.dart';
import 'package:getifyjobs/Src/Common_Widgets/Custom_App_Bar.dart';
import 'package:getifyjobs/Src/Common_Widgets/Image_Path.dart';
import 'package:getifyjobs/Src/Common_Widgets/Text_Form_Field.dart';
import 'package:getifyjobs/Src/utilits/ApiService.dart';
import 'package:getifyjobs/Src/utilits/Common_Colors.dart';
import 'package:getifyjobs/Src/utilits/ConstantsApi.dart';
import 'package:getifyjobs/Src/utilits/Generic.dart';
import 'package:getifyjobs/Src/utilits/Text_Style.dart';
import 'package:intl/intl.dart';

class Recruiter_Interview_Card extends ConsumerStatefulWidget {
  final String? CardType;
  Recruiter_Interview_Card({super.key, required this.CardType});

  @override
  ConsumerState<Recruiter_Interview_Card> createState() =>
      _Recruiter_Interview_CardState();
}

class _Recruiter_Interview_CardState
    extends ConsumerState<Recruiter_Interview_Card> {
  InterviewModel? interviewResponsemodel;
  InterviewModel? acceptedResponseData;
  bool? requestedList;
  String? cardTitle(String cardTit) {
    switch (widget.CardType) {
      case "Schedule Accepted":
        return "Schedule Accepted";
      case "Schedule Requested":
        return "Schedule Requested";
      case "Reschedule Requested":
        return "Reschedule Requested";
      case "Schedule Rejected":
        return "Schedule Rejected";
      default:
        return "Default Card";
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    initialApicall();
  }

  initialApicall(){

    switch (widget.CardType) {
      case "Schedule Accepted":
        ScheduleListResponse("5");

      case "Schedule Requested":
        ScheduleListResponse("3");

      case "Reschedule Requested":
        ScheduleListResponse("6");
      case "Schedule Rejected":
        ScheduleListResponse("7");
      default:
        break;
    }
    // ScheduleAcceptedListResponse();
    requestedList = false;
  }

  RegExp onlyText = RegExp(r'^[a-zA-Z ]+$');
  TextEditingController _From = TextEditingController();
  TextEditingController _location = TextEditingController();
  TextEditingController _jobTitle = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white2,
      appBar: Custom_AppBar(
        isUsed: false,
        actions: [
          // Padding(
          //   padding: EdgeInsets.only(right: 20),
          //   child: InkWell(
          //     onTap: () {
          //       showDialog(
          //         context: context,
          //         builder: (BuildContext context) =>
          //             InterviewSchedulePopup(context),
          //       );
          //     },
          //     child: ImgPathSvg("filter.svg"),
          //   ),
          // )
        ],
        isLogoUsed: true,
        title: cardTitle(widget.CardType ?? ""),
        isTitleUsed: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            requestedList == true? ScheduleList(context):
          Center(child: NoDataMobileWidget(content: "Unlock New Possibilities")),
          ],
        ),
      ),
    );

  }



  //RESCHEDULE LIST
  Widget ScheduleList(context) {
    return ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: interviewResponsemodel?.data?.items?.length ?? 0,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Direct_Candidate_Profile_Screen(
                        TagContain:interviewResponsemodel?.data?.items?[index].jobStatus ?? "",
                        candidate_Id:interviewResponsemodel?.data?.items?[index].candidateId ?? "" ,
                        job_Id: interviewResponsemodel?.data?.items?[index].jobId ?? ""))).then((value) => ref.refresh(initialApicall()));
                  },
                  child: customListItem(context,
                      badgeText:
                          interviewResponsemodel?.data?.items?[index].name ?? "",
                      appliedRole:
                          interviewResponsemodel?.data?.items?[index].jobTitle ??
                              "",
                      interviewTime:
                      "${interviewResponsemodel?.data?.items?[index].scheduleData?.interviewDate ?? ""}, ${interviewResponsemodel?.data?.items?[index].scheduleData?.interviewTime ?? ""}",
                      status: interviewResponsemodel
                              ?.data?.items?[index].jobStatus ??
                          "",
                      badgeTextStyle: ProfileT,
                      countTextStyle: W1grey,
                      interviewTimeTextStyle: Wgrey,
                      statusColor: grey1,
                      isWeb: false,
                      profileImg: interviewResponsemodel
                              ?.data?.items?[index].profilePic ??
                          ""),
                ),
              );
            },
          );

  }

  //ACCEPTED LIST
  // Widget ScheduleAcceptedList(context) {
  //   return requestedList == true
  //       ? ListView.builder(
  //           shrinkWrap: true,
  //           scrollDirection: Axis.vertical,
  //           physics: const NeverScrollableScrollPhysics(),
  //           itemCount: acceptedResponseData?.data?.items?.length ?? 0,
  //           itemBuilder: (BuildContext context, int index) {
  //             return Padding(
  //               padding: const EdgeInsets.only(left: 20, right: 20),
  //               child: customListItem(context,
  //                   badgeText:
  //                       acceptedResponseData?.data?.items?[index].name ?? "",
  //                   appliedRole:
  //                       acceptedResponseData?.data?.items?[index].jobTitle ??
  //                           "",
  //                   interviewTime: acceptedResponseData
  //                           ?.data?.items?[index].scheduleData?.interviewTime ??
  //                       "",
  //                   status: acceptedResponseData
  //                           ?.data?.items?[index].scheduleData?.jobStatus ??
  //                       "",
  //                   badgeTextStyle: ProfileT,
  //                   countTextStyle: W1grey,
  //                   interviewTimeTextStyle: Wgrey,
  //                   statusColor: grey1,
  //                   isWeb: false,
  //                   profileImg:
  //                       acceptedResponseData?.data?.items?[index].profilePic ??
  //                           ""),
  //             );
  //           },
  //         )
  //       : NoDataWidget(content: "No Data Available");
  // }

  ScheduleListResponse(String status) async {
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

  // ScheduleAcceptedListResponse() async {
  //   final ApplyListApiService = ApiService(ref.read(dioProvider));
  //   var formData = FormData.fromMap({
  //     'recruiter_id': await getRecruiterId(),
  //     "no_of_records": '20',
  //     "page_no": "1",
  //     "status": "5"
  //   });
  //   final interviewApiResponse = await ApplyListApiService.post<InterviewModel>(
  //       context, ConstantApi.allinterviewjobstatus, formData);
  //   print("JOB ID : ${interviewApiResponse.data?.items?[0].jobId ?? ''}");
  //   if (interviewApiResponse.status == true) {
  //     print('ACCEPETD LIST SUCESS');
  //     setState(() {
  //       acceptedResponseData = interviewApiResponse;
  //     });
  //   } else {
  //     ShowToastMessage(interviewApiResponse.message ?? "");
  //     print('ACCEPETD LIST ERROR');
  //   }
  // }
  Widget InterviewSchedulePopup(
      BuildContext context,
      ) {
    return Container(
      child: AlertDialog(
        surfaceTintColor: white1,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Multiple selection of ${"Job title, Location, Salary etc"}",
              style: Wbalck1,
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 10,
              ),
              child: textFormField(
                hintText: 'Job Title',
                keyboardtype: TextInputType.text,
                inputFormatters: null,
                Controller: _jobTitle,
                focusNode: null,
                validating: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please Enter Job Title";
                  } else if (!onlyText.hasMatch(value)) {
                    return "(Special Characters are Not Allowed)";
                  }
                  return null;
                },
                onChanged: null,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: textFormField(
                hintText: 'Name',
                keyboardtype: TextInputType.text,
                inputFormatters: null,
                Controller: _location,
                focusNode: null,
                validating: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please Enter Name";
                  } else if (!onlyText.hasMatch(value)) {
                    return "(Special Characters are Not Allowed)";
                  }
                  return null;
                },
                onChanged: null,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Container(
                width: MediaQuery.sizeOf(context).width,
                child: TextFieldDatePicker(
                    Controller: _From,
                    onChanged: (value) {},
                    validating: (value) {
                      if (value!.isEmpty) {
                        return 'Please select  Date';
                      } else {
                        return null;
                      }
                    },
                    onTap: () async {
                      FocusScope.of(context).unfocus();
                      DateTime? pickdate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1980),
                          lastDate: DateTime(2050));
                      if (pickdate != null) {
                        String formatdate =
                        DateFormat("yyyy-MM-dd").format(pickdate!);
                        if (mounted) {
                          setState(() {
                            _From.text = formatdate;
                            print(_From.text);
                          });
                        }
                      }
                    },
                    hintText: 'Form',
                    isDownArrow: false),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width / 3.5,
                      child: PopButton(context, "Cancel", () {
                        Navigator.pop(context);
                      })),
                  Container(
                      width: MediaQuery.of(context).size.width / 3.5,
                      child: PopButton(context, "Okay", () {
                        //jobLists = [];
                        //tempjobLists = [];
                        //_visibleItemCount = 0;

                        // directJobListResponse(
                        //     JobT: _jobTitle.text,
                        //     location: _location.text,
                        //     Fdate: _From.text,
                        //     Tdate: _To.text,
                        //     ExpT: _careerStatus.text,
                        //     CompanyT: _CompanyName.text,
                        //     isFilter: true,
                        //     SalaryT: _SalaryRange.text);
                      })),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//CARD INTERVIEW LIST
// Widget InterviewCardList(context,
//     {required String CandidateName,
//     required String AppliedRole,
//     required String InterviewTime,
//     required String Status}) {
//   return ListView.builder(
//     shrinkWrap: true,
//     scrollDirection: Axis.vertical,
//     physics: const NeverScrollableScrollPhysics(),
//     itemCount: 4,
//     itemBuilder: (BuildContext context, int index) {
//       return customListItem(context,
//           badgeText: CandidateName,
//           appliedRole: AppliedRole,
//           interviewTime: InterviewTime,
//           status: Status,
//           badgeTextStyle: ProfileT,
//           countTextStyle: W1grey,
//           interviewTimeTextStyle: Wgrey,
//           statusColor: grey1,
//           isWeb: false,
//           profileImg: '');
//     },
//   );
// }
