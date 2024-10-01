import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:getifyjobs/Models/CampusCandidateProfileModel.dart';
import 'package:getifyjobs/Models/UpdateCandidateJobStatusModel.dart';
import 'package:getifyjobs/Src/Common_Widgets/Common_Button.dart';
import 'package:getifyjobs/Src/Common_Widgets/Common_PopUp_Widgets.dart';
import 'package:getifyjobs/Src/Common_Widgets/Custom_App_Bar.dart';
import 'package:getifyjobs/Src/Common_Widgets/Image_Path.dart';
import 'package:getifyjobs/Src/utilits/ApiService.dart';
import 'package:getifyjobs/Src/utilits/Common_Colors.dart';
import 'package:getifyjobs/Src/utilits/ConstantsApi.dart';
import 'package:getifyjobs/Src/utilits/Generic.dart';
import 'package:getifyjobs/Src/utilits/Text_Style.dart';

class Recruiter_Web_Campus_Candidate_Profile extends ConsumerStatefulWidget {

  String? TagContain ;
  String? Round;
  String? candidate_Id;
  String? Job_Id;
  String? Campus_Id;

  Recruiter_Web_Campus_Candidate_Profile({super.key,
    required this.TagContain,
    required this.Campus_Id,
    required this.Round,
    required this.candidate_Id,
    required this.Job_Id,
  });

  @override
  ConsumerState<Recruiter_Web_Campus_Candidate_Profile> createState() =>Recruiter_Web_Campus_Candidate_ProfileState();
}

class Recruiter_Web_Campus_Candidate_ProfileState extends ConsumerState<Recruiter_Web_Campus_Candidate_Profile> {
  TextEditingController _interviewDate = TextEditingController();
  Color? containColor;
  Text? TagText;
  CandidateCampusProfileData? candiateProfileData;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      CandidateCampusProfileResponse();
    });
  }
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    switch (widget.TagContain){
      case "Shortlisted for Round":
        containColor=green3;
        TagText =Text('Shortlisted for Round${widget.Round}',style: green12,) ;
        break;
      case "Rejected the Candidate":
        TagText =Text('Rejected the Candidate',style: red12,) ;
        containColor=red4;
        break;
      case "Selected":
        containColor=green3;
        TagText =Text('Selected',style: green12,) ;
        break;
      case "Shortlisted for Final Round":
        containColor=green3;
        TagText =Text("Shortlisted for Final Round",style: green12,) ;
        break;
      case "Call for Interview":
        containColor=orange3;
        TagText =Text('Call for Interview',style: Yellow,) ;
        break;
      default:
        TagText =Text('Shortlisted for Round',style: green12,) ;
        containColor = green3;
        break;
    }
    return Scaffold(
      appBar:Custom_AppBar(
        isUsed: false,
        actions: [
          InkWell(
              onTap: (){
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 20),
                child: ImgPathSvg("xcancel.svg"),
              )),
        ],
        isLogoUsed: false,
        isTitleUsed: false,
        title: "Profile",
      ),
      bottomNavigationBar:Container  (
        height: 90,
        color: white1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                width: 155,
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
                            width: 300,
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
                width: 155  ,
                child: CommonElevatedButton(context, "Next Round", () {
                  // Navigator.pop(context);
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => Next_Round_Pop_Web(context,onTap: (){
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
                                width: 300,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 20),
                                      child: Text("Are you sure want to select the candidate for next round ?",style: TitleT,),
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.only(top: 20,bottom: 20),
                                        child:Container(
                                            width: 200,
                                            child: CommonElevatedButton(context, "Okay", () {
                                              setState(() {
                                                ShortlistedCandidateResponse();
                                                widget.TagContain = "You are shortlisted for Next Round1";
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
                    },
                        finalRoundTap: (){
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
                                          child: Text("Are you sure want to select the candidate for final round ?",style: TitleT,),
                                        ),
                                        Padding(
                                            padding: const EdgeInsets.only(top: 20,bottom: 20),
                                            child:Container(
                                                width: 200,
                                                child: CommonElevatedButton(context, "Okay", () {
                                                  setState(() {
                                                    FinalRoundCandidateResponse();
                                                    widget.TagContain = "Shortlisted for Final Round";
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
                        }),
                  );
                })),
          ],
        ),
      ),
      backgroundColor: white2,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             Column(
                children: [
                  widget.TagContain==""?Container(): Container(
                    width: MediaQuery.of(context).size.width,
                    color: containColor,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20,bottom: 20),
                      child: Center(child: TagText),
                    ),
                  ),
                  widget.TagContain=="Call for Interview"?Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: Column(
                      children: [
                        Center(child: Text('Call for Direct Interview on',style: attacht1,)),
                        Center(child: Text('9.00 AM, 02 Oct 2023',style: Wbalck4,)),
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

                    _recruiterResponse(context,onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => Recruiter_Response_PopUp_Web(context,
                          selectedTap: () {
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
                                            child: Text("Are you sure want to select  the candidate ?",style: TitleT,),
                                          ),
                                          Padding(
                                              padding: const EdgeInsets.only(top: 20,bottom: 20),
                                              child:Container(
                                                  width: 200,
                                                  child: CommonElevatedButton(context, "Okay", () {
                                                    setState(() {
                                                      SelectCandidateResponse();
                                                      widget.TagContain="Selected";
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
                          },
                          callForInterviewTap: () {
                            setState(() {
                              widget.TagContain="Call for Interview";
                            });
                          }, finalRoundTap: () {  },),
                      );
                    }),
                    contactDetails(context,ContactLogo: 'mapblue.svg', Details: candiateProfileData?.location ?? ""),
                    _detailInfo(),
                    _personalDetailsSection(
                        DOB: "DOB",
                        Nationality: "Nationality",
                        LanguagesKnown: "LanguagesKnown",
                        MaritalStatus: "MaritalStatus",
                        StringDifferentlyAbled: "StringDifferentlyAbled",
                        Doyouhavepassport: "Doyouhavepassport",
                        CareerBreak: "CareerBreak"),

                    _educationList(
                        course: "course",
                        institution: candiateProfileData?.collegeName ?? "",
                        duration: "${candiateProfileData?.startYear ?? ""} - ${candiateProfileData?.endYear ?? ""}"),
                    SizedBox(height: 50,),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  //CANDIDATE CAMPUS PROFILE RESPONSE
  CandidateCampusProfileResponse() async{
    final candidateCampusProfileApiService = ApiService(ref.read(dioProvider));
    var formData = FormData.fromMap({
      "candidate_id": widget.candidate_Id,
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
      "status":0,
      "final_round":1
    });
    final updateCandidateJobResponse  = await updateCandidateJobApiService.post<UpdateCandidateJobSatusModel>
      (context, ConstantApi.updateCandidateCampusJobSatusUrl, formData);
    if(updateCandidateJobResponse.status == true){
      print("FINAL ROUND  SUCESSFULLY");
    }else{
      ShowToastMessage(updateCandidateJobResponse.message ?? "");
      print("FINAL ROUND  ERROR");
    }
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
          _profileInformation(title: 'Email Id', data: candiateProfileData?.email ?? ""),
          _profileInformation(title: 'Phone Number', data: candiateProfileData?.phone ?? ""),
          _profileInformation(title: 'Address', data: candiateProfileData?.address ?? ""),
          _profileInformation(title: 'Gender', data: candiateProfileData?.gender ?? ""),
          _profileInformation(title: 'Qualification', data: candiateProfileData?.qualification ?? ""),
          _profileInformation(title: 'Specialization', data: candiateProfileData?.specialization ?? ""),
          _profileInformation(title: 'Current Arrears', data: candiateProfileData?.currentArrears ?? ""),
          _profileInformation(title: 'History of Arrears', data: candiateProfileData?.historyOfArrears ?? ""),
          _profileInformation(title: 'Current Percentage/CGPA', data: candiateProfileData?.currentPercentage ?? ""),
          _profileInformation(title: 'Expected Salary', data: candiateProfileData?.expectedSalary ?? ""),

          _profileInformation(title: 'Preferred Location', data: candiateProfileData?.preferredLocation ?? ""),
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
      width: 400,
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
            // width: MediaQuery.of(context).size.width/2,
              child: Text("Resume",style: pdfT,overflow: TextOverflow.ellipsis,maxLines: 2,)),
        ],
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
            _profileInformation(title: 'DOB', data: DOB),
            _profileInformation(title: 'Nationality', data: Nationality),
            _profileInformation(title: 'Languages Known', data: LanguagesKnown),
            _profileInformation(title: 'Marital Status', data: MaritalStatus),
            _profileInformation(title: 'Differently Abled', data: StringDifferentlyAbled),
            _profileInformation(title: 'Do you have passport', data: Doyouhavepassport),
            _profileInformation(title: 'Career Break', data: CareerBreak),
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
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true, // Add this line to limit the height
                itemCount: 2,
                itemBuilder: (context, index){
                  return Padding(
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
                  );
                },
              ),
            ],
          ),
        )
    ),
  );
}




