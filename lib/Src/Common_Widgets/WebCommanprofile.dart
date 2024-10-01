import 'package:flutter/material.dart';
import 'package:getifyjobs/Src/Common_Widgets/Common_Button.dart';
import 'package:getifyjobs/Src/Common_Widgets/Common_PopUp_Widgets.dart';
import 'package:getifyjobs/Src/Common_Widgets/Image_Path.dart';
import 'package:getifyjobs/Src/utilits/Common_Colors.dart';
import 'package:getifyjobs/Src/utilits/Text_Style.dart';

class WebCommon_Candidate_Profile_Screen extends StatefulWidget {
  bool? isPdfNeeded;
  bool? isCampus;
  String? TagContain ;

  WebCommon_Candidate_Profile_Screen({super.key, required this.isPdfNeeded,required this.isCampus,required this.TagContain});

  @override
  State<WebCommon_Candidate_Profile_Screen> createState() =>WebCommon_Candidate_Profile_ScreenState();
}

class WebCommon_Candidate_Profile_ScreenState extends State<WebCommon_Candidate_Profile_Screen> {
  Color? containColor;
  Text? TagText;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      widget.isPdfNeeded=true;
    });
  }
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    switch (widget.TagContain){
      case "You Selected for Next Round1":
        containColor=green3;
        TagText =Text('You Selected for Next Round1',style: green12,) ;
        break;
      case "You Rejected the Candidate":
        TagText =Text('You Rejected the Candidate',style: red12,) ;
        containColor=red4;
        break;
      case "Selected":
        containColor=green3;
        TagText =Text('Selected',style: green12,) ;
        break;
      case "You selected for Final Round":
        containColor=green3;
        TagText =Text('You selected for Final Round',style: green12,) ;
        break;
      case "Call for Interview":
        containColor=orange3;
        TagText =Text('Call for Interview',style: Yellow,) ;
        break;
      default:
        TagText =Text('ROUND 1',style: green12,) ;
        containColor = green3;
        break;
    }
    return Scaffold(
      bottomNavigationBar: Container(
        height: 90,
        color: white1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(

                width: MediaQuery.of(context).size.width *0.1,
                child: CommonElevatedButton(context, "Reject", () {
                  setState(() {
                    widget.TagContain = "You Rejected the Candidate";
                  });
                })),
            SizedBox(width: 5,),
            Container(
                width: MediaQuery.of(context).size.width*0.1,
                child: CommonElevatedButton(context, "Next Round", () {
                  // Navigator.pop(context);
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => Next_Round_Pop_Web(context,
                        onTap: (){
                      setState(() {
                        widget.TagContain = "You Selected for Next Round1";
                        Navigator.pop(context);

                      });
                    },
                        finalRoundTap:(){
                      setState(() {
                      widget.TagContain = 'You selected for Final Round';
                      Navigator.pop(context);
                      });
                      }, ),
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
              widget.isCampus==true?Column(
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
              ):Container(),

              Padding(
                padding: const EdgeInsets.only(left: 20,right: 20),
                child: Column(
                  children: [
                    profileImg(ProfileImg: 'avatar.jpg'),
                    Center(child: Text("Oliver Twist",style: TitleT,)),
                    widget.isPdfNeeded==true?PdfContainer():Container(),
                    widget.isCampus==true?
                    _recruiterResponse(context,onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => Recruiter_Response_PopUp_Web(context,
                          selectedTap: () {
                            setState(() {
                              widget.TagContain="Selected";
                              Navigator.pop(context);
                            });
                          },
                          finalRoundTap: () {
                            setState(() {
                              widget.TagContain='You selected for Final Round';
                              Navigator.pop(context);
                            });
                          },
                          callForInterviewTap: () {
                            setState(() {
                              widget.TagContain="Call for Interview";
                            });
                          },),
                      );
                    }):
                    _requestCallButton(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) => RequestCallPopupWeb(onPress: () {  },),
                          );
                        }
                    ),
                    contactDetails(context,ContactLogo: 'mapblue.svg', Details: 'Coimbatore, Tamil Nadu'),
                    _detailInfo(),
                    _personalDetailsSection(
                        DOB: "DOB",
                        Nationality: "Nationality",
                        LanguagesKnown: "LanguagesKnown",
                        MaritalStatus: "MaritalStatus",
                        StringDifferentlyAbled: "StringDifferentlyAbled",
                        Doyouhavepassport: "Doyouhavepassport",
                        CareerBreak: "CareerBreak"),
                    Padding(
                      padding: const EdgeInsets.only(top: 24 ),
                      child: Text("Employment History",style: TitleT,),
                    ),
                    _experienceList(
                        expdesignation: "expdesignation",
                        expcompany: "expcompany",
                        expworktype: "expworktype",
                        expduration: "expduration",
                        expnoticeperiod: "expnoticeperiod"),
                    _educationList(
                        course: "course",
                        institution: "institution",
                        duration: "duration"),
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
          _profileInformation(title: 'Designation', data: 'UI Designer'),
          _profileInformation(title: 'Experience', data: '3Years 2Months'),
          _profileInformation(title: 'Skill Set', data: 'Photoshop, Illustrator, Figma, Premier Pro'),
          _profileInformation(title: 'Qualification', data: 'B.Sc Computer Technology'),
          _profileInformation(title: 'Specialization', data: 'Macroeconomics'),
          _profileInformation(title: 'Preferred Location', data: 'Coimbatore'),
          _profileInformation(title: 'Current Salary', data: '4,00,000'),
          _profileInformation(title: 'Expected Salary', data: '6,00,000'),
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
            Text("Request Call",style: Homewhite2,),
          ],
        ),
      ),
    ),
  );
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

//EXPERIENCE LIST
Widget _experienceList({required String expdesignation,required String expcompany,required String expworktype,
  required String expduration, required String expnoticeperiod}){
  return ListView.builder(
    physics: const NeverScrollableScrollPhysics(),
    shrinkWrap: true, // Add this line to limit the height
    itemCount: 2,
    itemBuilder: (context, index){
      return Padding(
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
    },
  );
}


