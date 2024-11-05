import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:getifyjobs/Models/BranchListModel.dart';
import 'package:getifyjobs/Models/CampusCandidateProfileModel.dart';
import 'package:getifyjobs/Models/UpdateCandidateJobStatusModel.dart';
import 'package:getifyjobs/Src/Common_Widgets/Common_Button.dart';
import 'package:getifyjobs/Src/Common_Widgets/Common_Candidate_Profile.dart';
import 'package:getifyjobs/Src/Common_Widgets/Common_PopUp_Widgets.dart';
import 'package:getifyjobs/Src/Common_Widgets/Custom_App_Bar.dart';
import 'package:getifyjobs/Src/Common_Widgets/Image_Path.dart';
import 'package:getifyjobs/Src/Common_Widgets/Text_Form_Field.dart';
import 'package:getifyjobs/Src/utilits/ApiService.dart';
import 'package:getifyjobs/Src/utilits/Common_Colors.dart';
import 'package:getifyjobs/Src/utilits/ConstantsApi.dart';
import 'package:getifyjobs/Src/utilits/Generic.dart';
import 'package:getifyjobs/Src/utilits/Text_Style.dart';

class Recruiter_Campus_Peofile_Interview_Screen extends ConsumerStatefulWidget {
  String? TagContain ;
  String? Round;
  String? candidate_Id;
  String? Job_Id;
  String? Campus_Id;
  String? time;
  String? interviewDate;
   Recruiter_Campus_Peofile_Interview_Screen({super.key,
     required this.TagContain,
     required this.candidate_Id,
     required this.Job_Id,
     required this.Campus_Id,
     required this.Round,
     required this.time,
     required this.interviewDate
   });

  @override
  ConsumerState<Recruiter_Campus_Peofile_Interview_Screen> createState() => _Recruiter_Campus_Peofile_Interview_ScreenState();
}

class _Recruiter_Campus_Peofile_Interview_ScreenState extends ConsumerState<Recruiter_Campus_Peofile_Interview_Screen> {
  Color? containColor;
  Text? TagText;
  CandidateCampusProfileData? candiateProfileData;

  DateTime selectedDate = DateTime.now();
  TextEditingController dateController = TextEditingController();
  TextEditingController _Description = TextEditingController();

  List<BranchListData>? branchResponseList;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  List<String>BranchListOption = [];
  String BranchListVal = "";

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
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


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CandidateCampusProfileResponse();
    BranchListResponse();
    print("CAMPUS ID : ${widget.Campus_Id}");
    print("JOB ID :${widget.Job_Id}");
  }
  @override
  Widget build(BuildContext context) {
    switch (widget.TagContain){
      case "Shortlisted for Next Round":
        containColor=green3;
        TagText =Text('Shortlisted for Next Round',style: green12,) ;
        break;
      case "Rejected the Candidate":
        TagText =Text('Rejected the Candidate',style: red12,) ;
        containColor=red4;
        break;
      case "Selected":
        containColor=green3;
        TagText =Text('Selected',style: green12,) ;
        break;
      case "Final Round":
        containColor=green3;
        TagText =Text("Shortlisted for Final Round",style: green12,) ;
        break;
      case "Call For Interview":
        containColor=orange3;
        TagText =Text('Call For Interview',style: Yellow,) ;
        break;
      default:
        TagText =Text('Shortlisted for Round ${widget.TagContain}',style: green12,) ;
        containColor = green3;
        break;
    }
    return Scaffold(
      backgroundColor: white2,
      bottomNavigationBar:
      //widget.TagContain == "Applied"?null:
      Container  (
        height: 90,
        color: white1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                width: MediaQuery.of(context).size.width/2.3,
                child: CommonElevatedButton(context, "Reject", () {
                  setState(() {
                    showDialog(
                        context: context,
                        builder:(BuildContext context)=>AlertDialog(
                          surfaceTintColor: white1,
                          titlePadding: EdgeInsets.all(0),
                          title: Container(alignment:Alignment.topRight,child: IconButton(onPressed: (){
                            Navigator.pop(context);
                          }, icon: ImgPathSvg("xcancel.svg"))),
                          content:Container(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: Text("Are you sure want to reject  the candidate ?",style: TitleT,),
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(top: 20,bottom: 20),
                                    child:Container(
                                        width: 200,
                                        child: CommonElevatedButton(context, "Okay", () {
                                          setState(() {
                                            RejectedCandidateResponse();
                                            widget.TagContain = "Rejected the Candidate";
                                            Navigator.pop(context);
                                          });
                                        }))
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(bottom: 20),
                                    child: Container(
                                        width: 200,
                                        child: CommonElevatedButton(context, "Cancel", () {Navigator.pop(context); }))
                                ),
                              ],
                            ),
                          ),)
                    );

                  });
                })),
            Container(
                width: MediaQuery.of(context).size.width/2.3,
                child: CommonElevatedButton(context, "Next Round", () {
                  // Navigator.pop(context);
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => Next_Round_Pop(context,onTap: (){
                      setState(() {
                        Navigator.pop(context);
                        showDialog(
                            context: context,
                            builder:(BuildContext context)=>AlertDialog(
                              surfaceTintColor: white1,
                              titlePadding: EdgeInsets.all(0),
                              title: Container(alignment:Alignment.topRight,child: IconButton(onPressed: (){
                                Navigator.pop(context);
                              }, icon: ImgPathSvg("xcancel.svg"))),
                              content:Container(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 20),
                                      child: Text("Are you sure want to select the candidate for next round ?",style: TitleT,textAlign: TextAlign.center,),
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.only(top: 20,bottom: 20),
                                        child:Container(
                                            width: 200,
                                            child: CommonElevatedButton(context, "Okay", () {
                                              setState(() {
                                                ShortlistedCandidateResponse();

                                                Navigator.pop(context);

                                              });
                                            }))
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.only(bottom: 20),
                                        child: Container(
                                            width: 200,
                                            child: CommonElevatedButton(context, "Cancel", () {Navigator.pop(context); }))
                                    ),
                                  ],
                                ),
                              ),)
                        );

                      }
                      );
                    },
                        finalRoundTap: (){
                          setState(() {
                            showDialog(
                                context: context,
                                builder:(BuildContext context)=>AlertDialog(
                                  surfaceTintColor: white1,
                                  titlePadding: EdgeInsets.all(0),
                                  title: Container(alignment:Alignment.topRight,child: IconButton(onPressed: (){
                                    Navigator.pop(context);
                                  }, icon: ImgPathSvg("xcancel.svg"))),
                                  content:Container(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 20),
                                          child: Text("Are you sure want to select the candidate for final round ?",style: TitleT,textAlign: TextAlign.center,),
                                        ),
                                        Padding(
                                            padding: const EdgeInsets.only(top: 20,bottom: 20),
                                            child:Container(
                                                width: 200,
                                                child: CommonElevatedButton(context, "Okay", () {
                                                  setState(() {
                                                    FinalRoundCandidateResponse();
                                                  });
                                                }))
                                        ),
                                        Padding(
                                            padding: const EdgeInsets.only(bottom: 20),
                                            child: Container(
                                                width: 200,
                                                child: CommonElevatedButton(context, "Cancel", () {Navigator.pop(context); }))
                                        ),
                                      ],
                                    ),
                                  ),)
                            );
                          });
                        }

                    ),
                  );
                })),
          ],
        ),
      ),
      appBar: Custom_AppBar(isUsed: true, actions: null, isLogoUsed: true, isTitleUsed: true,title: "Profile",),
      body:         SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Column(
              children: [
                widget.TagContain==""?Container(): widget.TagContain=="Applied"?Container():Container(
                  width: MediaQuery.of(context).size.width,
                  color: containColor,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20,bottom: 20),
                    child: Center(child: TagText),
                  ),
                ),
                widget.TagContain=="Call For Interview"?Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: Column(
                    children: [
                      Center(child: Text('Call for Direct Interview on',style: attacht1,)),
                      Center(child: Text('${widget.time == ""?SingleTon().setTime:widget.time}, ${widget.interviewDate==""?dateController.text:widget.interviewDate}',style: Wbalck4,)),
                    ],
                  ),
                ):Container(),
              ],
            ),

            Padding(
              padding: const EdgeInsets.only(left: 20,right: 20),
              child: Column(
                children: [
                  profileImg(ProfileImg: candiateProfileData?.profilePic ?? ""),
                  Center(child: Text(candiateProfileData?.name ?? "",style: TitleT,)),
                PdfContainer(),
                  widget.TagContain == "Applied"?Container():   _recruiterResponse(context,onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                      BuildPopupDialog(context),
                    );
                  }),

                  contactDetails(context,ContactLogo: 'mapblue.svg', Details: candiateProfileData?.location ?? ""),
                  _detailInfo(),
                  _personalDetailsSection(candiateProfileData),
                  //EDUCATION HISTORY
                  candiateProfileData?.education == []? Container():  _educationList(candiateProfileData),
                  //EMPLOYEEMENT HISTORY
                  candiateProfileData?.education == []?Container():_employeementHistory(candiateProfileData),
                ],
              ),
            ),
            SizedBox(height: 50,)
          ],
        ),
      ),
    );
  }
  //CANDIDATE CAMPUS PROFILE RESPONSE
  CandidateCampusProfileResponse() async{
    final candidateCampusProfileApiService = ApiService(ref.read(dioProvider));
    var formData = FormData.fromMap({
      "candidate_id": widget.candidate_Id,
      "recruiter_id": await getRecruiterId(),
      "job_id": widget.Job_Id,
    });
    final candidateCampusProfileResponse = await
    candidateCampusProfileApiService.post<CandidateCampusProfileModel>(context, ConstantApi.campusCandidateProfileUrl, formData);
    if(candidateCampusProfileResponse?.status == true){
      print("SUCESS");
      setState(() {
        candiateProfileData = candidateCampusProfileResponse?.data;
      });
    }else{
      print("ERROR");
      ShowToastMessage(candidateCampusProfileResponse.message ?? "");

    }
  }
  //SELECTED CANDIDTE JOB STATUS RESPONSE
  SelectCandidateResponse ()async{
    final updateCandidateJobApiService = ApiService(ref.read(dioProvider));
    var formData = FormData.fromMap({
      "job_id":widget.Job_Id,
      "candidate_id":widget.candidate_Id,
      "recruiter_id":await getRecruiterId(),
      "campus_id":widget.Campus_Id,
      "status":4,
      "final_round":0
    });
    final updateCandidateJobResponse  = await updateCandidateJobApiService.post<UpdateCandidateJobSatusModel>
      (context, ConstantApi.updateCandidateCampusJobSatusUrl, formData);
    if(updateCandidateJobResponse.status == true){
      print("SELECTED SUCESSFULLY");
      setState(() {
        widget.TagContain ="Selected";
      });
      ShowToastMessage(updateCandidateJobResponse.message ?? "");
      Navigator.pop(context);
    }else{
      print("SELECTED ERROR");
      ShowToastMessage(updateCandidateJobResponse.message ?? "");

    }
  }
  //SHORTLISTED CANDIDATE RESPONSE
  ShortlistedCandidateResponse ()async{
    final updateCandidateJobApiService = ApiService(ref.read(dioProvider));
    var formData = FormData.fromMap({
      "job_id":widget.Job_Id,
      "candidate_id":widget.candidate_Id,
      "recruiter_id":await getRecruiterId(),
      "campus_id":widget.Campus_Id,
      "status":3,
      "final_round":0
    });
    final updateCandidateJobResponse  = await updateCandidateJobApiService.post<UpdateCandidateJobSatusModel>
      (context, ConstantApi.updateCandidateCampusJobSatusUrl, formData);
    if(updateCandidateJobResponse.status == true){
      print("SHORTLISTED SUCESSFULLY");
      setState(() {
        setState(() {
          widget.TagContain = "Shortlisted for Next Round";
        });
      });
    }else{
      ShowToastMessage(updateCandidateJobResponse.message ?? "");

      print("SHORTLISTED ERROR");
    }
  }
  //REJECTED CANDIDATE RESPONSE
  RejectedCandidateResponse ()async{
    final updateCandidateJobApiService = ApiService(ref.read(dioProvider));
    var formData = FormData.fromMap({
      "job_id":widget.Job_Id,
      "candidate_id":widget.candidate_Id,
      "recruiter_id":await getRecruiterId(),
      "campus_id":widget.Campus_Id,
      "status":5,
      "final_round":0
    });
    final updateCandidateJobResponse  = await updateCandidateJobApiService.post<UpdateCandidateJobSatusModel>
      (context, ConstantApi.updateCandidateCampusJobSatusUrl, formData);
    if(updateCandidateJobResponse.status == true){
      print("REJECTED ROUND  SUCESSFULLY");
    }else{
      ShowToastMessage(updateCandidateJobResponse.message ?? "");

      print("REJECTED ROUND  ERROR");
    }
  }
  //FINAL ROUND RESPONSE
  FinalRoundCandidateResponse ()async{
    final updateCandidateJobApiService = ApiService(ref.read(dioProvider));
    var formData = FormData.fromMap({
      "job_id":widget.Job_Id,
      "candidate_id":widget.candidate_Id,
      "recruiter_id":await getRecruiterId(),
      "campus_id":widget.Campus_Id,
      "status":3,
      "final_round":1
    });
    final updateCandidateJobResponse  = await updateCandidateJobApiService.post<UpdateCandidateJobSatusModel>
      (context, ConstantApi.updateCandidateCampusJobSatusUrl, formData);
    if(updateCandidateJobResponse.status == true){
      print("FINAL ROUND  SUCESSFULLY");
      setState(() {
        widget.TagContain = "Final Round";
        Navigator.pop(context);
        Navigator.pop(context);
      });
      ShowToastMessage(updateCandidateJobResponse.message ?? "");

    }else{
      ShowToastMessage(updateCandidateJobResponse.message ?? "");
      print("FINAL ROUND  ERROR");
    }
  }
  //CALL FOR INTERVIEW
  CallForInterviewResponse ()async{
    final callForInterviewApiService = ApiService(ref.read(dioProvider));
    var formData = FormData.fromMap({
      "job_id":widget.Job_Id,
      "candidate_id":widget.candidate_Id,
      "recruiter_id":await getRecruiterId(),
      "campus_id":widget.Campus_Id,
      "status":6,
      "final_round":0,
      "branch":branchResponseList?.length == null?_Description.text:BranchListVal,
      "interview_date":dateController.text,
      "interview_time":SingleTon().setTime,
    });
    final callForInterviewResponse  = await callForInterviewApiService.post<UpdateCandidateJobSatusModel>
      (context, ConstantApi.updateCandidateCampusJobSatusUrl, formData);
    if(callForInterviewResponse.status == true){
      print("CALL FOR INTERVIEW SUCESSFULLY");
      setState(() {
        widget.TagContain = "Call For Interview";
        Navigator.pop(context);
      });
      ShowToastMessage(callForInterviewResponse.message ?? "");
    }else{
      ShowToastMessage(callForInterviewResponse.message ?? "");
      print("CALL FOR INTERVIEW ERROR");
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
  //DETAIL INFO CONTAINER
  Widget _detailInfo(){
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(top: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: white1
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 20,right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 15,),
            //_profileInformation(title: 'Designation', data: candiateProfileData?.designation ?? ""),
            _profileInformation(title: 'Email Id', data: candiateProfileData?.email ?? ""),
            _profileInformation(title: 'Phone Number', data: candiateProfileData?.phone ?? ""),
            _profileInformation(title: 'Address', data: candiateProfileData?.address ?? ""),
            _profileInformation(title: 'Gender', data: candiateProfileData?.gender ?? ""),
            _profileInformation(title: 'Qualification', data: candiateProfileData?.qualification ?? ""),
            _profileInformation(title: 'Specialization', data: candiateProfileData?.specialization ?? ""),
            _profileInformation(title: 'Current Arrears', data: candiateProfileData?.currentArrears ?? ""),
            _profileInformation(title: 'History of Arrears', data: candiateProfileData?.historyOfArrears ?? ""),
            _profileInformation(title: 'Current Percentage/CGPA', data: candiateProfileData?.currentPercentage ?? ""),
            candiateProfileData?.expectedSalary == "" ? Container() :
            _profileInformation(title: 'Expected Salary', data: candiateProfileData?.expectedSalary ?? ""),
            _profileInformation(title: 'Preferred Location', data: candiateProfileData?.preferredLocation ?? ""),
          ],
        ),
      ),
    );
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
              child: Text("Are you sure want to ?",style: TitleT,textAlign: TextAlign.center,),
            ),
            CommonElevatedButton(context, "Select", (){
              SelectCandidateResponse();
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
              TimePickerFormField(onValidate: (value) {},),
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
                        _validateTime();
                        Navigator.pop(context);
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => CampusCallInterview(context, onPress: () {
                            CallForInterviewResponse();
                          }),
                        );
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



//RECRUITER RESPONSE
Widget _recruiterResponse(context,{required void Function()? onTap}){
  return InkWell(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.only(top: 15,bottom: 15),
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color:blue1
        ),
        child: Center(child: Text("Recruiter Response",style: Homewhite2,)),),
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
Widget _personalDetailsSection(CandidateCampusProfileData? candiateProfileData){
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
            candiateProfileData?.dob == "" ? Container() :
            _profileInformation(title: 'Date of Birth', data: candiateProfileData?.dob ?? ""),

            candiateProfileData?.nationality == "" ? Container() :
            _profileInformation(title: 'Nationality', data: candiateProfileData?.nationality ?? ""),

            // _profileInformation(title: 'Languages Known', data: candiateProfileData?. ?? ""),

            candiateProfileData?.maritalStatus == "" ? Container() :
            _profileInformation(title: 'Marital Status', data: candiateProfileData?.maritalStatus ?? ""),

            candiateProfileData?.differentlyAbled == "" ? Container() :
            _profileInformation(title: 'Differently Abled', data: candiateProfileData?.differentlyAbled ?? ""),

            candiateProfileData?.passport == "" ? Container() :
            _profileInformation(title: 'Passport Details', data: candiateProfileData?.passport ?? ""),

            candiateProfileData?.careerBreak == "" ? Container() :
            _profileInformation(title: 'Career Break', data: candiateProfileData?.careerBreak ?? ""),
          ],
        ),
      ),
    ),
  );
}

//EDUCATIONAL LIST
Widget _educationList(CandidateCampusProfileData? candiateProfileData){
  return Padding(
    padding: const EdgeInsets.only(top: 10),
    child:  Container(
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color:white1),
        child:ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: candiateProfileData?.education?.length ?? 0,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.only(left: 10,right: 10,),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15 ),
                    child: Text("Education",style: TitleT,),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(candiateProfileData?.education?[index].institute ?? "",style: empHistoryT,),
                      Text(candiateProfileData?.education?[index].qualification ?? "",style: coursetxt,),
                      Text(candiateProfileData?.education?[index].specialization ?? "",style: coursetxt,),
                      Text(candiateProfileData?.education?[index].cgpa ?? "",style: coursetxt,),
                      Text("${candiateProfileData?.education?[index].startDate ?? ""} - ${candiateProfileData?.education?[index].endDate ?? ""}",style: durationT,),
                    ],
                  ),
                ],
              ),
            );
          },)

    ),
  );
}

//EMPLOYEEMENT HISTORY
Widget _employeementHistory(CandidateCampusProfileData? candiateProfileData){
  return Padding(
    padding: const EdgeInsets.only(top: 10),
    child:  Container(
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color:white1),
        child:ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: candiateProfileData?.education?.length ?? 0,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.only(left: 10,right: 10,),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15 ),
                    child: Text("Employment History",style: TitleT,),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(candiateProfileData?.employment?[index].companyName ?? "",style: empHistoryT,),
                      Text(candiateProfileData?.employment?[index].jobType ?? "",style: empHistoryT,),
                      Text(candiateProfileData?.employment?[index].jobRole ?? "",style: empHistoryT,),
                      Text(candiateProfileData?.employment?[index].description ?? "",style: durationT,),
                      Text(candiateProfileData?.employment?[index].noticePeriod ?? "",style: durationT,),

                      Text("${candiateProfileData?.employment?[index].startDate ?? ""} - ${candiateProfileData?.employment?[index].endDate ?? ""}",style: durationT,),
                    ],
                  ),
                ],
              ),
            );
          },)

    ),
  );
}