import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:getifyjobs/Models/AddOfferModel.dart';
import 'package:getifyjobs/Models/BranchListModel.dart';
import 'package:getifyjobs/Models/CampusCandidateProfileModel.dart';
import 'package:getifyjobs/Models/DirectDetailsModel.dart';
import 'package:getifyjobs/Models/RequestCallModel.dart';
import 'package:getifyjobs/Models/UpdateCandidateJobStatusModel.dart';
import 'package:getifyjobs/Src/Common_Widgets/Common_Button.dart';
import 'package:getifyjobs/Src/Common_Widgets/Common_PopUp_Widgets.dart';
import 'package:getifyjobs/Src/Common_Widgets/Custom_App_Bar.dart';
import 'package:getifyjobs/Src/Common_Widgets/Image_Path.dart';
import 'package:getifyjobs/Src/Recruiter_Web_Screens/Recuiter_Login/WebRecutierProfileExperence.dart';
import 'package:getifyjobs/Src/utilits/ApiService.dart';
import 'package:getifyjobs/Src/utilits/Common_Colors.dart';
import 'package:getifyjobs/Src/utilits/ConstantsApi.dart';
import 'package:getifyjobs/Src/utilits/Generic.dart';
import 'package:getifyjobs/Src/utilits/Text_Style.dart';
import 'Pdf_Picker.dart';
import 'Text_Form_Field.dart';

class Direct_Candidate_Profile_Screen extends ConsumerStatefulWidget {

   String? TagContain ;
   String? candidate_Id;
   String? job_Id;

   Direct_Candidate_Profile_Screen({super.key,

     required this.TagContain,
     required this.candidate_Id,
   required this.job_Id});

  @override
  ConsumerState<Direct_Candidate_Profile_Screen> createState() =>Direct_Candidate_Profile_ScreenState();
}

class Direct_Candidate_Profile_ScreenState extends ConsumerState<Direct_Candidate_Profile_Screen> {
  Color? containColor;
  Text? TagText;


  CandidateCampusProfileData? candiateProfileData;


  DateTime selectedDate = DateTime.now();
  TextEditingController dateController = TextEditingController();
  List<BranchListData>? branchResponseList;

  List<String>BranchListOption = [];
  String BranchListVal = "";
  String? _selectedTime;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        dateController.text = "${selectedDate.toLocal()}".split(' ')[0];
      });
  }


  bool _isTimeSelected = false;
  void _validateTime() {
    if (_isTimeSelected) {
      _formKey.currentState?.validate();
      // Add your logic to proceed with the button action
    }
  }
  bool? isPdfNeeded;
  bool? isRecReschedule;
  bool? isSecheduleAccepted;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _location = TextEditingController();
  TextEditingController _feedBack = TextEditingController();
  TextEditingController _Description = TextEditingController();
  TextEditingController rescheduleDate = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      print("JOB STATUS : ${widget.TagContain}");
      CandidateCampusProfileResponse();
      BranchListResponse();
    });
    isRecReschedule = false;
    isSecheduleAccepted = false;
  }
  @override
  Widget build(BuildContext context) {
    switch (widget.TagContain){
      case "Shortlisted":
        containColor=green3;
        TagText =Text('Shortlisted',style: green12,) ;
        break;
      case "Schedule Rejected":
        TagText =Text('Schedule Rejected',style: red12,) ;
        containColor=red4;
        break;
      case "Rejected":
        TagText =Text('Rejected',style: red12,) ;
        containColor=red4;
        break;
      case "Selected":
        containColor=green3;
        TagText =Text('Selected',style: green12,) ;
        break;
      case "Schedule Accepted":
        containColor=green3;
        TagText =Text('Schedule Accepted',style: green12,) ;
        break;
      case "Wait List":
        containColor=orange3;
        TagText =Text('Wait List',style: Yellow,) ;
        break;
      case "Schedule Requested":
        containColor=orange3;
        TagText =Text('Scheduled Direct Interview',style: Yellow,) ;
        break;
      case "Scheduled Video Interview":
        containColor=orange3;
        TagText =Text('Scheduled Video Interview',style: Yellow,) ;
        break;
      case "Candidate Reschedule":
        containColor=orange3;
        TagText =Text('Rescheduled Requested Interview On',style: Yellow,) ;
        break;
      case "Recruiter Reschedule":
        containColor=orange3;
        TagText =Text('Recruiter Rescheduled Interview On',style: Yellow,) ;
        break;
      case "Interview Reschedule":
        containColor=orange3;
        TagText =Text('Recruiter Reschedule Interview On',style: Yellow,) ;
        break;
      case "Rescheduled Video Interview":
        containColor=orange3;
        TagText =Text('Rescheduled Video Interview',style: Yellow,) ;
        break;
      case "Request a Call":
        containColor=orange3;
        TagText =Text('Request a Call',style: Yellow,) ;
        break;
      default:
        TagText =Text('ROUND 1',style: green12,) ;
        containColor = green3;
        break;
    }
    return Scaffold(
      bottomNavigationBar: widget.TagContain == "Schedule Requested"?null:
      widget.TagContain == "Schedule Accepted"?null:
      widget.TagContain == "Candidate Reschedule"?null:
      widget.TagContain == "Schedule Rejected"?null:
      widget.TagContain == "Rejected"?null:
      widget.TagContain == "Interview Reschedule"?null:
      Container(
        height: 75,
        color: white1,
        child: Row(
          mainAxisAlignment: widget.TagContain == 'Selected'
              ? MainAxisAlignment.center
              : MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 140,
              child: CommonElevatedButton(context, "Reject", () {
                InterviewRejectedResponse();
              }),
            ),
            widget.TagContain == 'Selected' ? const SizedBox.shrink() :
            Container(
              width: 140,
              child: CommonElevatedButton(
                context,
                widget.TagContain == "Wait List" ? "Select" : "Shortlist",
                    () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => widget.TagContain == "Wait List"
                        ? waitListPop(context)
                        : BuildPopupDialog(context),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      appBar: Custom_AppBar(isUsed: true, actions: [
        widget.TagContain == "Rejected"? Container():
        widget.TagContain == "Applied"? Container():
        widget.TagContain == "Shortlisted"? Container():
        widget.TagContain == "Selected"? Container():
        widget.TagContain == "Request a Call"? Container():
        widget.TagContain == "Wait List"? Container():
        PopupMenuButton(
            surfaceTintColor: white1,
            icon:
            Icon(Icons.more_vert_outlined),
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                  child:
                  InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => InterviewRescheduleConfirmationPop(context, typeT: 'cancel',
                            onPress: () {
                              ScheduleCanceledResponse();
                            },),
                        );
                      },
                      child: Text(
                        'Schedule Cancel',
                        style: refferalCountT,
                      ))),
            ]),
      ], isLogoUsed: true, isTitleUsed: true,title: 'Profile',),
      backgroundColor: white2,
      body: Form(
        key: _formKey,
        child:
        SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //INTERVIEW  TAG
              Column(
                children: [
                  widget.TagContain==""?Container():
                      widget.TagContain == 'Applied'?Container():
                  Container(
                    width: MediaQuery.of(context).size.width,
                    color: containColor,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20,bottom: 20),
                      child: Center(child: TagText),
                    ),
                  ),

                  widget.TagContain=="Schedule Requested"?
                  Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: Column(
                      children: [
                        Center(child: Text('Call for Direct Interview on',style: attacht1,)),
                        Center(child: Text('${candiateProfileData?.scheduleRequested?.interviewTime == null?SingleTon().setTime:
                        candiateProfileData?.scheduleRequested?.interviewTime ?? "" }, '
                            '${candiateProfileData?.scheduleRequested?.interviewDate == null?
                        dateController.text:candiateProfileData?.scheduleRequested?.interviewDate ?? ""}',style: Wbalck4,)),
                      ],
                    ),
                  ):widget.TagContain=="Scheduled Video Interview"?
                  Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: Column(
                      children: [
                        Center(child: Text('Call for Direct Interview on',style: attacht1,)),
                        Center(child: Text('9.00 AM, 02 Oct 2023',style: Wbalck4,)),
                      ],
                    ),
                  ):widget.TagContain=="Rescheduled Video Interview"?
                  Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: Column(
                      children: [
                        Center(child: Text('Call for Direct Interview on',style: attacht1,)),
                        Center(child: Text('9.00 AM, 02 Oct 2023',style: Wbalck4,)),
                      ],
                    ),
                  ):widget.TagContain=="Candidate Reschedule"?
                  Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: Column(
                      children: [
                        //SCHEDULE REQUEST
                        Center(child: Text('Call for Direct Interview on',style: attacht1,)),
                        Center(child: Text('${candiateProfileData?.scheduleRequested?.interviewTime ?? ""}, ${candiateProfileData?.scheduleRequested?.interviewDate ?? ""}',style: Wbalck4,)),
                        //RESCHEDULE REQUEST
                        const SizedBox(height: 15,),
                        Center(child: Text('Requested for Reschedule Interview on',style: attacht1,)),
                        Center(child: Text('${candiateProfileData?.candidateReschedule?.interviewTime ?? ""}, ${candiateProfileData?.candidateReschedule?.interviewDate ?? ""}',style: Wbalck4,)),
                        const SizedBox(height: 10,),
                        //RESCHEDULE BUTTON
                        isRecReschedule == false? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: 80,
                              child: CommonElevatedButton(context, "Yes", () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) => RescheduleConfirmationPop(context, typeT: 'accept',
                                    onPress: () {
                                      ScheduleAcceptedResponse();
                                    },),
                                );
                              }),
                            ),
                            Container(
                              width: MediaQuery.sizeOf(context).width/2.7,
                              child: CommonElevatedButton(context, "Reschedule", () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) => RescheduleDatePop(context, onPress: () {
                                    _validateTime();
                                    RescheduleDateResponse();
                                  }),
                                );
                              }),
                            ),
                            Container(
                              width: 80,
                              child: CommonElevatedButton(context, "No", () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) => RescheduleConfirmationPop(context,
                                      typeT: 'reject',
                                      onPress: () {
                                        ScheduleRejectedResponse();
                                      }),
                                );
                              }),
                            ),
                          ],
                        ):
                        Column(
                          children: [
                            Center(child: Text('Recruiter Requested for Reschedule Interview on',style: attacht1,)),
                            Center(child: Text('${candiateProfileData?.recruiterReschedule?.interviewTime == null?SingleTon().setTime:
                            candiateProfileData?.recruiterReschedule?.interviewTime ?? "" }, '
                                '${candiateProfileData?.recruiterReschedule?.interviewDate == null?
                            dateController.text:candiateProfileData?.recruiterReschedule?.interviewDate ?? ""}',style: Wbalck4,)),
                            const SizedBox(height: 15,)
                          ],
                        ),
                      ],
                    ),
                  ):widget.TagContain == "Recruiter Reschedule"?
                  Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: Column(
                      children: [
                        //SCHEDULE REQUEST
                        Center(child: Text('Call for Direct Interview on',style: attacht1,)),
                        Center(child: Text('${candiateProfileData?.scheduleRequested?.interviewTime ?? ""}, ${candiateProfileData?.scheduleRequested?.interviewDate ?? ""}',style: Wbalck4,)),
                        //RESCHEDULE REQUEST
                        const SizedBox(height: 15,),
                        Center(child: Text('Requested for Reschedule Interview on',style: attacht1,)),
                        Center(child: Text('${candiateProfileData?.candidateReschedule?.interviewTime ?? ""}, ${candiateProfileData?.candidateReschedule?.interviewDate ?? ""}',style: Wbalck4,)),
                        const SizedBox(height: 10,),
                       Center(child: Text('Recruiter Requested for Reschedule Interview on',style: attacht1,)),
                       Center(child: Text('${candiateProfileData?.recruiterReschedule?.interviewTime == null?SingleTon().setTime:
                       candiateProfileData?.recruiterReschedule?.interviewTime}, ${candiateProfileData?.recruiterReschedule?.interviewDate == null?dateController.text:candiateProfileData?.recruiterReschedule?.interviewDate ?? ""}',style: Wbalck4,)),
                       const SizedBox(height: 15,)
                      ],
                    ),
                  )
                      :widget.TagContain=="Schedule Accepted"?
                  Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: Column(
                      children: [
                        Center(child: Text('Call for Direct Interview on',style: attacht1,)),
                        Center(child: Text('${
                            candiateProfileData?.scheduleAccepted?.interviewTime == null?candiateProfileData?.candidateReschedule?.interviewTime ?? "":
                        candiateProfileData?.scheduleAccepted?.interviewTime ?? "" }, ${candiateProfileData?.scheduleAccepted?.interviewDate == null?
                        dateController.text:candiateProfileData?.scheduleAccepted?.interviewDate ?? ""}',style: Wbalck4,)),
                        //ARE YOU WANT RESCHEDULE
                        Padding(
                          padding: const EdgeInsets.only(top: 10,bottom: 10),
                          child: Center(child: Text('Do you want to reschedule the interview date?',style: attacht1,)),
                        ),
                        Container(
                          width: MediaQuery.sizeOf(context).width/2.7,
                          child: CommonElevatedButton(context, "Reschedule", () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) => RescheduleDatePop(context, onPress: () {
                                setState(() {
                                  InterviewRescheduleResponse();
                                });
                              }),
                            );
                          }),
                        ),
                      ],
                    ),
                  ):
                      widget.TagContain == "Interview Reschedule"?
                      Padding(
                        padding: const EdgeInsets.only(top: 25),
                        child: Column(
                          children: [
                            Center(child: Text('Reschedule Direct Interview on',style: attacht1,)),
                            Center(child: Text('${candiateProfileData?.interviewReschedule?.interviewTime == null?SingleTon().setTime:
                            candiateProfileData?.interviewReschedule?.interviewTime ?? "" }, '
                            '${candiateProfileData?.interviewReschedule?.interviewDate == null?
                            dateController.text:candiateProfileData?.interviewReschedule?.interviewDate ?? ""}',style: Wbalck4,)),
                          ],
                        ),
                      ):
                  Container(),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20,right: 20),
                child: Column(
                  children: [
                    profileImg(ProfileImg:candiateProfileData?.profilePic ?? "" ),
                    Center(child: Text(candiateProfileData?.name ?? "",style: TitleT,)),
                    // widget.TagContain!="Scheduled Direct Interview"?Container(
                    //   height: 75,
                    //     child: pdfViewer(optionalTXT: '',)):Container(),

                    widget.TagContain == "Schedule Requested"?Container():
                    widget.TagContain == "Schedule Accepted"?Container():
                    widget.TagContain == "Candidate Reschedule"?Container():
                    widget.TagContain == "Schedule Rejected"?Container():
                    widget.TagContain == "Rejected"?Container():
                    widget.TagContain == "Wait List"? Container():
                    widget.TagContain == "Interview Reschedule"? Container():
                    _requestCallButton(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) => RequestCallPopup(
                              onTapConfirm: () {
                                RequestCallResponse();
                                setState(() {
                                  widget.TagContain = "Request a Call";
                                });
                                },),
                          );
                        }
                    ),
                    contactDetails(context,ContactLogo: 'mapblue.svg', Details: candiateProfileData?.address ?? ""),
                    _detailInfo(),
                    _personalDetailsSection(
                        DOB: candiateProfileData?.dob ?? "",
                        Nationality: candiateProfileData?.nationality ?? "",
                        LanguagesKnown: "LanguagesKnown",
                        MaritalStatus: candiateProfileData?.maritalStatus ?? "",
                        StringDifferentlyAbled: candiateProfileData?.differentlyAbled ?? "",
                        Doyouhavepassport: candiateProfileData?.passport ?? "",
                        CareerBreak: candiateProfileData?.careerBreak ?? ""),
                    candiateProfileData?.employment == []? Container(): Padding(
                      padding: const EdgeInsets.only(top: 24 ),
                      child: Text("Employment History",style: TitleT,),
                    ),
                    //EMPLOYEEMENT HISTORY
                    candiateProfileData?.employment == []? Container(): _employeement_List(),
                    //EDUCATION LIST
                    _education_List(),
                    SizedBox(height: 50,),
                  ],
                ),
              ),
              SizedBox(height: 50,)
            ],
          ),
        ),
      ),
    );
  }

  //DETAIL INFO CONTAINER
  Widget _detailInfo(){
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(top: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: white1
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 15,),
          _profileInformation(title: 'Designation', data: candiateProfileData?.designation ?? ""),
          candiateProfileData?.experience == null?Container(): _profileInformation(title: 'Experience', data: candiateProfileData?.experience ?? ""),
          _profileInformation(title: 'Skill Set', data: candiateProfileData?.skill ?? ""),
          _profileInformation(title: 'Qualification', data: candiateProfileData?.qualification ?? ""),
          _profileInformation(title: 'Specialization', data: candiateProfileData?.specialization ?? ""),
          _profileInformation(title: 'Preferred Location', data: candiateProfileData?.preferredLocation ?? ""),
          candiateProfileData?.currentSalary == null?Container():_profileInformation(title: 'Current Salary', data: candiateProfileData?.currentSalary ?? ""),
          _profileInformation(title: 'Expected Salary', data: candiateProfileData?.expectedSalary ?? ""),
        ],
      ),
    );
  }

  //CONTENT
  Widget _profileInformation({required String? title,required String? data}){
    return Padding(
      padding: const EdgeInsets.only(left: 15,right: 15),
      child: Column(
        children: [
          Container(
              alignment: Alignment.topLeft,
              child: Text(title.toString(),style: infoT,)),
          Container(
              margin: EdgeInsets.only(bottom: 15),
              alignment: Alignment.topLeft,
              child: Text(data.toString(),style: stxt,))
        ],
      ),
    );
  }

  //PDF SECTION
  Widget PdfContainer(){
    return Container(
      height: 75,
      margin: EdgeInsets.only(top: 25,bottom: 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: white1
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10,right: 15),
            child: ImgPathSvg("pdf.svg"),
          ),
          Container(
              width: MediaQuery.of(context).size.width/2,
              child: Text("Resume",style: pdfT,overflow: TextOverflow.ellipsis,maxLines: 2,)),
        ],
      ),
    );
  }

  //CANDIDATE CAMPUS PROFILE RESPONSE
  CandidateCampusProfileResponse() async{
    final candidateCampusProfileApiService = ApiService(ref.read(dioProvider));
    var formData = FormData.fromMap({
      "candidate_id": widget.candidate_Id,
      "job_id": widget.job_Id,
      "recruiter_id": await getRecruiterId(),
    });
    final candidateCampusProfileResponse = await
    candidateCampusProfileApiService.post<CandidateCampusProfileModel>(context, ConstantApi.campusCandidateProfileUrl, formData);
    if(candidateCampusProfileResponse?.status == true){
      print("SUCESS");
      setState(() {
        candiateProfileData = candidateCampusProfileResponse?.data;
      });
      ShowToastMessage(candidateCampusProfileResponse.message ?? "");

    }else{
      print("ERROR");
      ShowToastMessage(candidateCampusProfileResponse.message ?? "");

    }
  }

  //REQUEST CALL RESPONSE
  RequestCallResponse() async{
    final requestCallApiService = ApiService(ref.read(dioProvider));
    var formData =FormData.fromMap({
      "job_id":widget.job_Id,
      "candidate_id": widget.candidate_Id,
      "recruiter_id": await getRecruiterId(),
    });
    final requestCallResponse = await requestCallApiService.post<RequestCallModel>(context, ConstantApi.requestCallUrl, formData);
    if(requestCallResponse?.status == true){
      print("REQUESTED CALL SUCESS");
      Navigator.pop(context);
      ShowToastMessage(requestCallResponse.message ?? "");
    }else{
      print("REQUESTED CALL ERROR");
      ShowToastMessage(requestCallResponse.message ?? "");
    }
  }

  //SHORTLISTED RESPONSE
  ShortlistedResponse()  async{
    final shortListedApiService = ApiService(ref.read(dioProvider));
    var formData = FormData.fromMap({
      "job_id":widget.job_Id,
      "candidate_id":widget.candidate_Id,
      "recruiter_id":await getRecruiterId(),
      "status":2
    });
    final shortlistedApiResponse = await shortListedApiService.post<UpdateCandidateJobSatusModel>(
        context, ConstantApi.updateDirectJobStatusUrl, formData);
    if(shortlistedApiResponse?.status == true){
      print("SHORTLISTED SUCESS");
      Navigator.pop(context);
      setState(() {
        widget.TagContain = "Shortlisted";
      });
      ShowToastMessage(shortlistedApiResponse.message ?? "");
    }else{
      print("SHORTLISTED ERROR");
      ShowToastMessage(shortlistedApiResponse.message ?? "");
    }
  }
  //SCHEDULE ACCEPTED
  ScheduleAcceptedResponse()  async{
    final shortListedApiService = ApiService(ref.read(dioProvider));
    var formData = FormData.fromMap({
      "job_id":widget.job_Id,
      "candidate_id":widget.candidate_Id,
      "recruiter_id":await getRecruiterId(),
      "status":5
    });
    final shortlistedApiResponse = await shortListedApiService.post<UpdateCandidateJobSatusModel>(
        context, ConstantApi.updateDirectJobStatusUrl, formData);
    if(shortlistedApiResponse?.status == true){
      print("SCHEDULE ACCEPTED SUCESS");
      Navigator.pop(context);
      setState(() {
        widget.TagContain = "Schedule Accepted";
      });
      ShowToastMessage(shortlistedApiResponse.message ?? "");
    }else{
      print("SCHEDULE ACCEPTED ERROR");
      ShowToastMessage(shortlistedApiResponse.message ?? "");
    }
  }
  //SCHEDULE REJECTED
  ScheduleRejectedResponse()  async{
    final shortListedApiService = ApiService(ref.read(dioProvider));
    var formData = FormData.fromMap({
      "job_id":widget.job_Id,
      "candidate_id":widget.candidate_Id,
      "recruiter_id":await getRecruiterId(),
      "status":7
    });
    final shortlistedApiResponse = await shortListedApiService.post<UpdateCandidateJobSatusModel>(
        context, ConstantApi.updateDirectJobStatusUrl, formData);
    if(shortlistedApiResponse?.status == true){
      print("SCHEDULE REJECTED SUCESS");
      // Navigator.pop(context);
      setState(() {
        widget.TagContain = "Schedule Rejected";
      });
      ShowToastMessage(shortlistedApiResponse.message ?? "");
    }else{
      print("SCHEDULE REJECTED ERROR");
      ShowToastMessage(shortlistedApiResponse.message ?? "");
    }
  }

  //SCHEDULE CANCELED
  ScheduleCanceledResponse()  async{
    final shortListedApiService = ApiService(ref.read(dioProvider));
    var formData = FormData.fromMap({
      "job_id":widget.job_Id,
      "candidate_id":widget.candidate_Id,
      "recruiter_id":await getRecruiterId(),
      "status":1
    });
    final shortlistedApiResponse = await shortListedApiService.post<UpdateCandidateJobSatusModel>(
        context, ConstantApi.updateDirectJobStatusUrl, formData);
    if(shortlistedApiResponse?.status == true){
      print("SCHEDULE CANCELED SUCCESS");
      Navigator.pop(context);
      ShowToastMessage(shortlistedApiResponse.message ?? "");
    }else{
      print("SCHEDULE CANCELED ERROR");
      ShowToastMessage(shortlistedApiResponse.message ?? "");
    }
  }
  //INTERVIEW REJECTED
  InterviewRejectedResponse()  async{
    final shortListedApiService = ApiService(ref.read(dioProvider));
    var formData = FormData.fromMap({
      "job_id":widget.job_Id,
      "candidate_id":widget.candidate_Id,
      "recruiter_id":await getRecruiterId(),
      "status":4
    });
    final shortlistedApiResponse = await shortListedApiService.post<UpdateCandidateJobSatusModel>(
        context, ConstantApi.updateDirectJobStatusUrl, formData);
    if(shortlistedApiResponse?.status == true){
      print("INTERVIEW REJECTED SUCESS");
      // Navigator.pop(context);
      setState(() {
        widget.TagContain = "Rejected";
      });
      ShowToastMessage(shortlistedApiResponse.message ?? "");
    }else{
      print("INTERVIEW REJECTED ERROR");
      ShowToastMessage(shortlistedApiResponse.message ?? "");
    }
  }

  //SCHEDULED RESPONSE
  ScheduledResponse()async{
    final ScheduleApiService = ApiService(ref.read(dioProvider));
    var formData =FormData.fromMap({
      "job_id":widget.job_Id,
      "candidate_id":widget.candidate_Id,
      "recruiter_id":await getRecruiterId(),
      "status":3,
      "branch":branchResponseList?.length == null?_location.text:BranchListVal,
      "interview_date":dateController.text,
      "interview_time":SingleTon().setTime,
    });
    print("TIME :::: ${SingleTon().setTime}");
    print("BRANCH LIST VAL  :::: ${BranchListVal}");
    final scheduleApiResponse = await ScheduleApiService.post<UpdateCandidateJobSatusModel>(context,
        ConstantApi.updateDirectJobStatusUrl, formData);
    if(scheduleApiResponse?.status == true){
      print("Schedule SUCESS");
      Navigator.pop(context);
      setState(() {
        widget.TagContain = "Schedule Requested";
      });
    }else{
      print("Schedule ERROR");
    }
  }

  //BRANCH LIST RESPONSE
  BranchListResponse() async{
    final branchListApiService = ApiService(ref.read(dioProvider));
    var formData =FormData.fromMap({
      "recruiter_id":await getRecruiterId(),
    });
    final branchListResponse = await branchListApiService.post<BranchListModel>(context, ConstantApi.branchListUrl, formData);
    if(branchListResponse?.status == true){
      print("BRANCH LISTED SUCESSFULLY");
      setState(() {
        branchResponseList = branchListResponse?.data;

        BranchListOption = branchListResponse!.data!.map((e) => e.branchName ?? "").toList();

         BranchListVal = BranchListOption[0];

        print(BranchListOption);

      });
    }else{
      print("BRANCH LISTED ERROR");
    }
  }

  //ADD OFFER RESPONSE
 AddOfferResponse()async{
    final AddOfferApiService = ApiService(ref.read(dioProvider));
    var formData = FormData.fromMap({
      "candidate_id": widget.candidate_Id,
      "job_id": widget.job_Id,
      "feedback": _feedBack.text,
    });

    if (SingleTon().setPdf != null) {
      formData.files.addAll([
        MapEntry(
            'offer_letter', await MultipartFile.fromFile(SingleTon().setPdf!.path)),
      ]);
    }

    final AddOfferApiResponse = await AddOfferApiService.post<AddOfferModel>
      (context, ConstantApi.addOfferUrl, formData);
    if(AddOfferApiResponse?.status == true){
      print("ADD OFFER SUCCESS");
      setState(() {
        widget.TagContain = "Selected";
      });

      Navigator.pop(context);

      ShowToastMessage(AddOfferApiResponse.message ?? "");

    }else{
      print("ADD OFFER ERROR");
      ShowToastMessage(AddOfferApiResponse.message ?? "");
    }
  }

  //RESCHEDULE DATE RESPONSE
  RescheduleDateResponse() async{
    final rescheduleDateApiService = ApiService(ref.read(dioProvider));
    var formData = FormData.fromMap({
      "job_id": widget.job_Id,
      "candidate_id": widget.candidate_Id,
      "recruiter_id": await getRecruiterId(),
      "interview_date":dateController.text,
      "interview_time":SingleTon().setTime,
      "reschedule_by":"recruiter",
    });
    final rescheduleApiResponse = await rescheduleDateApiService.post<RequestCallModel>
      (context, ConstantApi.rescheduleDateUrl, formData);
    if(rescheduleApiResponse?.status == true){
      print("RESCHEDULE SUCCESS");
      Navigator.pop(context);
      setState(() {
        isRecReschedule = true;
        widget.TagContain = 'Recruiter Reschedule';
      });
      ShowToastMessage(rescheduleApiResponse.message ?? "");

    }else{
      print("RESCHEDULE ERROR");
      setState(() {
        isRecReschedule = false;
      });
      ShowToastMessage(rescheduleApiResponse.message ?? "");
    }
  }

  //INTERVIEW RESCHEDULE
  InterviewRescheduleResponse() async{
    final rescheduleDateApiService = ApiService(ref.read(dioProvider));
    var formData = FormData.fromMap({
      "job_id": widget.job_Id,
      "candidate_id": widget.candidate_Id,
      "recruiter_id": await getRecruiterId(),
      "interview_date":dateController.text,
      "interview_time":SingleTon().setTime,
      "status":11,
      "reschedule_by":"recruiter",
    });
    final rescheduleApiResponse = await rescheduleDateApiService.post<RequestCallModel>
      (context, ConstantApi.updateDirectJobStatusUrl, formData);
    if(rescheduleApiResponse?.status == true){
      print("INTERVIEW RESCHEDULE SUCCESS");
      Navigator.pop(context);
      setState(() {
        isRecReschedule = true;
        widget.TagContain = 'Interview Reschedule';
      });
      ShowToastMessage(rescheduleApiResponse.message ?? "");

    }else{
      print("INTERVIEW RESCHEDULE ERROR");
      setState(() {
        isRecReschedule = false;
      });
      ShowToastMessage(rescheduleApiResponse.message ?? "");
    }
  }
  //EMPLOYEEMENT LIST
  Widget _employeement_List(){
    return ListView.builder(
      itemCount: candiateProfileData?.employment?.length ?? 0,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemBuilder: (BuildContext context, int index) {
        return  _experienceList(
            expdesignation: candiateProfileData?.employment?[index].jobRole ?? "",
            expcompany: candiateProfileData?.employment?[index].companyName ?? "",
            expworktype: candiateProfileData?.employment?[index].jobType ?? "",
            expduration: "Duration: ${candiateProfileData?.employment?[index].startDate ?? ""} - ${candiateProfileData?.employment?[index].endDate ?? ""}",
            expnoticeperiod: candiateProfileData?.employment?[index].noticePeriod ?? "");
      },);
  }
  //EDUCATION LIST
  Widget _education_List(){
    return ListView.builder(
      itemCount: candiateProfileData?.education?.length ?? 0,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemBuilder: (BuildContext context, int index) {
        return  _educationList(
            course: candiateProfileData?.education?[index].qualification ?? "",
            institution: candiateProfileData?.education?[index].institute ?? "",
            duration: "Duration: ${candiateProfileData?.education?[index].startDate ?? ""} - ${candiateProfileData?.education?[index].endDate ?? ""}");
      },);
  }

  //REQUEST CALL BUTTON FUNCTIONS
  Widget BuildPopupDialog(BuildContext context) {
    return AlertDialog(
      surfaceTintColor: white1,
      content:Container(
        width: 350,
        color: white1,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Spacer(),
                InkWell(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Container(
                      height: 25,
                      width: 25,
                      child: ImgPathSvg("xcancel.svg")),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: Text("Do you want to ?",style: TitleT,),
            ),
           widget.TagContain == "Shortlisted"?Container(): CommonElevatedButton(context, "ShortList", (){
              ShortlistedResponse();
            }),
            Padding(
              padding: const EdgeInsets.only(top: 15,bottom: 15),
              child: CommonElevatedButton(context, "Call for Interview", () {
                Navigator.pop(context);
                showDialog(
                  context: context,
                  builder: (BuildContext context) => InterviewSchedulePopupWeb(context),
                );

              }),
            ),
            CommonElevatedButton(context, "Video Interview", () {
              Navigator.pop(context);
              showDialog(
                context: context,
                builder: (BuildContext context) => InterviewSchedulePopupWeb(context),
              );
            }),
          ],
        ),
      ),
    );
  }


//INTERVIEW SCHEDULE POPUP
  Widget InterviewSchedulePopupWeb(BuildContext context) {
    return AlertDialog(
      surfaceTintColor: white1,
      content:Container(
        color: white1,
        width: 350,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //DATE PICKER
            Text("Please Select the date & time for the Interview",style: Wbalck1,textAlign: TextAlign.center,),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          readOnly: true,
          keyboardType: TextInputType.number,
          maxLength: 15,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: white2),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: white2),
            ),
            counterText: "",
            hintText: 'DD / MM / YYYY',
            helperStyle: phoneHT,
            suffixIcon: Icon(
              Icons.keyboard_arrow_down_sharp,
              color: Colors.black,
              size: 35,
            ),
            prefixIcon: Icon(
              Icons.calendar_today_outlined,
              color: grey4,
              size: 24,
            ),
            hintStyle: const TextStyle(
              fontFamily: "Inter",
              fontWeight: FontWeight.w400,
              fontSize: 12.0,
              color: Colors.grey,
            ),
            errorMaxLines: 1,
            contentPadding: const EdgeInsets.only(
                top: 8.0, bottom: 8.0, left: 16.0, right: 16.0),
            fillColor: white2,
            filled: true,
          ),
          textInputAction: TextInputAction.next,
          style: const TextStyle(
            fontFamily: "Inter",
            fontWeight: FontWeight.w400,
            fontSize: 14.0,
            color: Colors.black,
          ),
          controller: dateController,
          onTap: () => _selectDate(context),
        ),
          //TIME PICKER
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child:
            TimePickerFormField(onValidate: (value) {
              _selectedTime = value;
            },),
          ),
            branchResponseList?.length == 0? Padding(
              padding: const EdgeInsets.only(bottom: 10,top: 5),
              child:   textfieldDescription1(
                Controller: _Description,
                validating: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please Enter ${'Address'}";
                  }
                  if (value == null) {
                    return "Please Enter ${'Address'}";
                  }
                  return null;
                }, hintT: 'Please Enter Interview Address',
              ),
            ):
            dropDownField(
                context,
                value: BranchListVal,
                listValue: BranchListOption ?? [],
                onChanged: (String? newValue) {

                 }
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                      width:MediaQuery.of(context).size.width/3.5,
                      child: CommonElevatedButton(context, "Cancel", () {
                        Navigator.pop(context);
                      })),
                  Container(
                      width:MediaQuery.of(context).size.width/3.5,
                      child: CommonElevatedButton(context, "Okay", () {
                        if (branchResponseList?.length == 0){
                          print('Length False');
                          if (_selectedTime == null || dateController.text.isEmpty || _Description.text.isEmpty){
                            ShowToastMessage("Please Enter Interview Date & Time");
                          }else{
                            _validateTime();
                            Navigator.pop(context);
                            showDialog(
                              context: context,
                              builder: (BuildContext context) => InterviewConfirmationPopupWeb(context, onPress: () {
                                ScheduledResponse();
                              }),
                            );
                          }
                        }else {
                          print("Length true");
                          if (_selectedTime == null || dateController.text.isEmpty){
                            ShowToastMessage("Please Enter Interview Date & Time");
                          }else {
                            _validateTime();
                            Navigator.pop(context);
                            showDialog(
                              context: context,
                              builder: (BuildContext context) => InterviewConfirmationPopupWeb(context, onPress: () {
                                ScheduledResponse();
                              }),
                            );
                          }
                        }
                      })),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  //WAITING LIST
  Widget waitListPop(BuildContext context) {
    return AlertDialog(
      surfaceTintColor: white1,
      content:Container(
        color: white1,
        width: 350,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //DATE PICKER
            Text("Are you sure want to select the candidate",style: Wbalck1,textAlign: TextAlign.center,),

          Padding(
              padding: const EdgeInsets.only(bottom: 10,top: 5),
              child:   textfieldDescription1(
                Controller: _feedBack,
                validating: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please Enter ${'Description'}";
                  }
                  if (value == null) {
                    return "Please Enter ${'Description'}";
                  }
                  return null;
                }, hintT: 'Please Enter Short Description About Candidate',
              ),
            ),
            Container(
              height: 100,
                child: PdfPickerExample(optionalTXT: 'Attach Offer',)),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                      width:MediaQuery.of(context).size.width/3.5,
                      child: CommonElevatedButton(context, "Cancel", () {
                        Navigator.pop(context);
                      })),
                  Container(
                      width:MediaQuery.of(context).size.width/3.5,
                      child: CommonElevatedButton(context, "Okay", () {
                        _validateTime();
                        AddOfferResponse();
                        // Navigator.pop(context);
                        // showDialog (
                        //   context: context,
                        //   builder: (BuildContext context) => AddOfferResponse(),
                        // );
                      })),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // RESCHEDULE DATE POPUP
  Widget RescheduleDatePop(BuildContext context,{required void Function()? onPress}) {
    return AlertDialog(
      surfaceTintColor: white1,
      content:Container(
        color: white1,
        width: 350,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //DATE PICKER
            Text("Please select the reschedule date & time for the Interview",style: Wbalck1,textAlign: TextAlign.center,),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              readOnly: true,
              keyboardType: TextInputType.number,
              maxLength: 15,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: white2),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: white2),
                ),
                counterText: "",
                hintText: 'DD / MM / YYYY',
                helperStyle: phoneHT,
                suffixIcon: Icon(
                  Icons.keyboard_arrow_down_sharp,
                  color: Colors.black,
                  size: 35,
                ),
                prefixIcon: Icon(
                  Icons.calendar_today_outlined,
                  color: grey4,
                  size: 24,
                ),
                hintStyle: const TextStyle(
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w400,
                  fontSize: 12.0,
                  color: Colors.grey,
                ),
                errorMaxLines: 1,
                contentPadding: const EdgeInsets.only(
                    top: 8.0, bottom: 8.0, left: 16.0, right: 16.0),
                fillColor: white2,
                filled: true,
              ),
              textInputAction: TextInputAction.next,
              style: const TextStyle(
                fontFamily: "Inter",
                fontWeight: FontWeight.w400,
                fontSize: 14.0,
                color: Colors.black,
              ),
              controller: dateController,
              onTap: () => _selectDate(context),
            ),
            //TIME PICKER
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child:
              TimePickerFormField(onValidate: (value) {},),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                      width:MediaQuery.of(context).size.width/3.5,
                      child: CommonElevatedButton(context, "Cancel", () {
                        Navigator.pop(context);
                      })),
                  Container(
                      width:MediaQuery.of(context).size.width/3.5,
                      child: CommonElevatedButton(context, "Okay", onPress)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


}

//REQUEST CALL BUTTON
Widget _requestCallButton({required void Function()? onTap}){
  return InkWell(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.only(top: 15,bottom: 15),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color:blue1
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ImgPathSvg("phone-call.svg"),
            SizedBox(width: 15,),
            Text("Request a Call",style: Homewhite2,),
          ],
        ),
      ),
    ),
  );
}


//PROFILE INFORMATION
Widget _profileInformation({required String? title,required String? data}){
  return Column(
    children: [
      Container(
          alignment: Alignment.topLeft,
          child: Text(title.toString(),style: infoT,)),
      Container(
          margin: EdgeInsets.only(bottom: 15),
          alignment: Alignment.topLeft,
          child: Text(data.toString(),style: stxt,))
    ],
  );
}

//PERSONAL DETAILS
Widget _personalDetailsSection({required  String DOB,required  String Nationality,required  String LanguagesKnown,
  required  String MaritalStatus,required  StringDifferentlyAbled,required  String Doyouhavepassport,required  String CareerBreak,}){
  return Padding(
    padding: const EdgeInsets.only(top: 15),
    child: Container(
      // width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: white1
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 15,right: 15,top: 15,bottom: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 15,),
            if (DOB.isNotEmpty) _profileInformation(title: 'Date of Birth', data: DOB),
            if (Nationality.isNotEmpty) _profileInformation(title: 'Nationality', data: Nationality),
            if (LanguagesKnown.isNotEmpty) _profileInformation(title: 'Languages Known', data: LanguagesKnown),
            if (MaritalStatus.isNotEmpty) _profileInformation(title: 'Marital Status', data: MaritalStatus),
            if (StringDifferentlyAbled.isNotEmpty) _profileInformation(title: 'Differently Abled', data: StringDifferentlyAbled),
            if (Doyouhavepassport.isNotEmpty) _profileInformation(title: 'Passport Details', data: Doyouhavepassport),
            if (CareerBreak.isNotEmpty) _profileInformation(title: 'Career Break', data: CareerBreak),
          ],
        ),
      ),
    ),
  );
}

//EDUCATIONAL LIST
Widget _educationList({required String course,required String institution,required String duration}){
  return Padding(
    padding: const EdgeInsets.only(top: 10),
    child: Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color:white1),
      child:Padding(
        padding: const EdgeInsets.only(left: 10,right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15 ),
              child: Text("Education",style: TitleT,),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15,bottom: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(institution,style: empHistoryT,),
                  Padding(
                    padding: const EdgeInsets.only(top: 3,bottom: 3),
                    child: Text(course,style: coursetxt,),
                  ),
                  Text(duration,style: durationT,),
                ],
              ),
            ),
          ],
        ),
      )
    ),
  );
}

//EXPERIENCE LIST
Widget _experienceList({required String expdesignation,required String expcompany,required String expworktype,
  required String expduration, required String expnoticeperiod}){
  return  Padding(
    padding: const EdgeInsets.only(top: 10),
    child: Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: white1
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 10,left: 10,bottom: 10,right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(expdesignation,style: infoT,),
            Text(expcompany,style: stxt,),
            Text(expworktype,style: posttxt,),
            Text(expworktype,style: posttxt,),
            SizedBox(height: 15,),
            Text("Notice Period",style:infoT ,),
            Text(expnoticeperiod,style: stxt,),
          ],
        ),
      ),
    ),
  );
}


