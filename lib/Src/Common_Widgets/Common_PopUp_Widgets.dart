import 'package:flutter/material.dart';
import 'package:getifyjobs/Src/Common_Widgets/Image_Path.dart';
import 'package:getifyjobs/Src/Common_Widgets/Text_Form_Field.dart';
import 'package:getifyjobs/Src/Recruiter_Web_Screens/Recuiter_Login/WebRecutierProfileExperence.dart';
import 'package:getifyjobs/Src/utilits/Common_Colors.dart';
import 'package:getifyjobs/Src/utilits/Text_Style.dart';
import 'package:intl/intl.dart';
import 'Common_Button.dart';



class RequestCallPopup extends StatefulWidget {
  void Function()? onTapConfirm;
  RequestCallPopup({super.key,required this.onTapConfirm});

  @override
  State<RequestCallPopup> createState() => _RequestCallPopupState();
}

class _RequestCallPopupState extends State<RequestCallPopup> {
  @override
  Widget build(BuildContext context) {
    return _callConfirmationPopup(context);
  }
  //INTERVIEW CONFIRMATION POPUP
  Widget _callConfirmationPopup(BuildContext context) {
    return AlertDialog(
      surfaceTintColor: white1,
      content:Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                text: '',
                style: Wbalck1,
                children: <TextSpan>[
                  TextSpan(text: '1 Coin',
                    style: TextStyle(
                        color: Color.fromRGBO(254, 168, 50, 1),fontFamily: 'Inter', fontSize: 24,fontWeight: FontWeight.w700),
                  ),
                  TextSpan(text: ' will be deducted for call request',
                    style: Wbalck1,
                  ),
                ]
            ),
          ),
         const  SizedBox(height: 15,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                  width:MediaQuery.of(context).size.width/3.5,
                  child: CommonElevatedButton(context, "Cancel", () {
                    Navigator.pop(context);
                  })),
              Container(
                  width:MediaQuery.of(context).size.width/3.5,
                  child: CommonElevatedButton(context, "Confirm",widget.onTapConfirm)),
            ],
          ),
          const  SizedBox(height: 10,),
          Container(
            width: MediaQuery.of(context).size.width/1.5,
              child: Text('One coin will be deducted for multiple calls across the interview process',maxLines: 2,textAlign: TextAlign.center,))
        ],
      ),
    );
  }

  //INSUFFICIENT COIN POPUP
  Widget _insufficientCoinsPopup(BuildContext context) {
    return AlertDialog(
      content:Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ImgPathSvg("coin.svg"),
            Padding(
              padding: const EdgeInsets.only(top: 15,bottom: 15),
              child: Container(
                height: 40,
                color: red4,
                child: Center(child: Text("Insufficient Coins",style: logOutStyle,)),
              ),
            ),
            Container(
              width: 175,
                child: CommonElevatedButton(context, "Add Coin", () { }))
          ],
        ),
      ),
    );
  }
}


//RECRUITER RESPONSE POP UP
class Recruiter_Response_PopUp extends StatefulWidget {
  void Function()? selectedTap;
  void Function()? finalRoundTap;
  void Function()? callForInterviewTap;
   Recruiter_Response_PopUp(BuildContext context, {super.key,required this.selectedTap,required this.finalRoundTap,required this.callForInterviewTap});

  @override
  State<Recruiter_Response_PopUp> createState() => _Recruiter_Response_PopUpState();
}

class _Recruiter_Response_PopUpState extends State<Recruiter_Response_PopUp> {
  bool _isTimeSelected = false;
  void _validateTime() {
    if (_isTimeSelected) {
      _formKey.currentState?.validate();
      // Add your logic to proceed with the button action
    }
  }
  bool? isPdfNeeded;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _interviewDate = TextEditingController();
  TextEditingController _location = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Recruiter_Response_POP(context);
  }
  //REQUEST CALL BUTTON FUNCTIONS
  Widget Recruiter_Response_POP(BuildContext context) {
    return AlertDialog(
      surfaceTintColor: white1,
      titlePadding: EdgeInsets.all(0),
      title: Container(alignment:Alignment.topRight,child: IconButton(onPressed: (){
        Navigator.pop(context);
      }, icon: ImgPathSvg("xcancel.svg"))),
      content:Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Text("Do you want to ?",style: TitleT,),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20,bottom: 20),
            child: CommonElevatedButton(context, "Selected",
               widget.selectedTap),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: CommonElevatedButton(context, "Call for Interview", () {
              Navigator.pop(context);
              showDialog(
                context: context,
                builder: (BuildContext context) => InterviewSchedulePopup(context,widget.callForInterviewTap),
              );

            }),
          ),
        ],
      ),
    );
  }

//INTERVIEW SCHEDULE POPUP
  Widget InterviewSchedulePopup(BuildContext context,void Function()? onTap) {
    return AlertDialog(
      surfaceTintColor: white1,
      content:Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Please Select the date & time for the Interview",style: Wbalck1,textAlign: TextAlign.center,),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child:MyDatePickerForm(),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15,bottom: 15),
            child: TimePickerFormField(onValidate: (value) {_isTimeSelected = true;  },),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10,top: 50),
            child:   textfieldDescription1(
              Controller: _location,
              validating: (value) {
                if (value == null || value.isEmpty) {
                  return "Please Enter ${'Address*'}";
                }
                if (value == null) {
                  return "Please Enter ${'Address*'}";
                }
                return null;
              }, hintT: '',
            ),
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
                        builder: (BuildContext context) => InterviewConfirmationPopup(context,onTap: onTap),
                      );
                    })),
              ],
            ),
          ),
        ],
      ),
    );
  }

//INTERVIEW CONFIRMATION POPUP
  Widget InterviewConfirmationPopup(BuildContext context,{void Function()? onTap}) {
    return AlertDialog(
      surfaceTintColor: white1,
      content:Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RichText(
            text: TextSpan(
                text: '',
                style: Wbalck1,
                children: <TextSpan>[
                  TextSpan(text: '3 Coins',
                    style: TextStyle(
                        color: Color.fromRGBO(254, 168, 50, 1),fontFamily: 'Inter', fontSize: 24,fontWeight: FontWeight.w700),
                  ),
                  TextSpan(text: ' well be deducted for scheduling an interview',
                    style: Wbalck1,
                  ),
                ]
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 15,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                  width:MediaQuery.of(context).size.width/3.5,
                  child: CommonElevatedButton(context, "Cancel", () {})),
              Container(
                  width:MediaQuery.of(context).size.width/3.5,
                  child: CommonElevatedButton(context, "Confirm", onTap)),
            ],
          ),
        ],
      ),
    );
  }
}


//RECRUITER RESPONSE POP UP WEB
class Recruiter_Response_PopUp_Web extends StatefulWidget {
  void Function()? selectedTap;
  void Function()? finalRoundTap;
  void Function()? callForInterviewTap;
  Recruiter_Response_PopUp_Web(BuildContext context, {super.key,required this.selectedTap,required this.finalRoundTap,required this.callForInterviewTap});

  @override
  State<Recruiter_Response_PopUp_Web> createState() => _Recruiter_Response_PopUp_WebState();
}

class _Recruiter_Response_PopUp_WebState extends State<Recruiter_Response_PopUp_Web> {
  bool _isTimeSelected = false;
  void _validateTime() {
    if (_isTimeSelected) {
      _formKey.currentState?.validate();
      // Add your logic to proceed with the button action
    }
  }
  bool? isPdfNeeded;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _interviewDate = TextEditingController();
  TextEditingController _location = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Recruiter_Response_POP(context);
  }
  //REQUEST CALL BUTTON FUNCTIONS
  Widget Recruiter_Response_POP(BuildContext context) {
    return AlertDialog(
      surfaceTintColor: white1,
      titlePadding: EdgeInsets.all(0),
      title: Container(alignment:Alignment.topRight,child: IconButton(onPressed: (){
        Navigator.pop(context);
      }, icon: ImgPathSvg("xcancel.svg"))),
      content:Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Text("Do You want to",style: TitleT,),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20,bottom: 20),
            child: CommonElevatedButton(context, "Selected",
                widget.selectedTap),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: CommonElevatedButton(context, "Call for Interview", () {
              Navigator.pop(context);
              showDialog(
                context: context,
                builder: (BuildContext context) => InterviewSchedulePopup(context,widget.callForInterviewTap),
              );

            }),
          ),
        ],
      ),
    );
  }

//INTERVIEW SCHEDULE POPUP
  Widget InterviewSchedulePopup(BuildContext context,void Function()? onTap,) {
    return AlertDialog(
      surfaceTintColor: white1,
      content:Container(
        width: 300,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Please Select the date & time for the Interview",style: Wbalck1,textAlign: TextAlign.center,),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child:MyDatePickerForm(),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15,bottom: 15),
              child: TimePickerFormField(onValidate: (value) {_isTimeSelected = true;  },),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10,top: 5),
              child:   textfieldDescription1(
                Controller: _location,
                validating: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please Enter ${'Address*'}";
                  }
                  if (value == null) {
                    return "Please Enter ${'Address*'}";
                  }
                  return null;
                }, hintT: '',
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                      width:MediaQuery.of(context).size.width/12.5,
                      child: CommonElevatedButton(context, "Cancel", () {
                        Navigator.pop(context);
                      })),
                  Container(
                      width:MediaQuery.of(context).size.width/12.5,
                      child: CommonElevatedButton(context, "Okay", () {
                        _validateTime();
                        Navigator.pop(context);
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => InterviewConfirmationPopup(context,onTap: onTap),
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

//INTERVIEW CONFIRMATION POPUP
  Widget InterviewConfirmationPopup(BuildContext context,{void Function()? onTap}) {
    return AlertDialog(
      surfaceTintColor: white1,
      content:Container(
        width: 300,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RichText(
              text: TextSpan(
                  text: '',
                  style: Wbalck1,
                  children: <TextSpan>[
                    TextSpan(text: '3 Coins',
                      style: TextStyle(
                          color: Color.fromRGBO(254, 168, 50, 1),fontFamily: 'Inter', fontSize: 24,fontWeight: FontWeight.w700),
                    ),
                    TextSpan(text: ' will be deducted for scheduling an interview',
                      style: Wbalck1,
                    ),
                  ]
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    width:MediaQuery.of(context).size.width/3.5,
                    child: CommonElevatedButton(context, "Cancel", () {})),
                Container(
                    width:MediaQuery.of(context).size.width/3.5,
                    child: CommonElevatedButton(context, "Confirm", onTap)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

//NEXT ROUND
Widget Next_Round_Pop(BuildContext context,{void Function()? onTap,void Function()? finalRoundTap}) {
  return AlertDialog(
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
            child: Text("Are you sure want to select for next round ?",style: TitleT,textAlign: TextAlign.center,),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  width:MediaQuery.of(context).size.width/3.5,
                  child: CommonElevatedButton(context, "Cancel", () {
                    Navigator.pop(context);
                  })),
              Container(
                  width:MediaQuery.of(context).size.width/3.5,
                  child: CommonElevatedButton(context, "Confirm", onTap)),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10,bottom: 10),
            child: Text("(OR)"),
          ),
          Container(
              width: 260,
              child: CommonElevatedButton(context, "Shortlist for Final Round", finalRoundTap))
        ],
      ),
    ),
  );
}
//NEXT ROUND
Widget Next_Round_Pop_Web(BuildContext context,{void Function()? onTap,void Function()? finalRoundTap}) {
  return AlertDialog(
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
            child: Text("Are you sure want to select for next round ?",style: TitleT,textAlign: TextAlign.center,),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  width:MediaQuery.of(context).size.width/12.5,
                  child: CommonElevatedButton(context, "Cancel", () {
                    Navigator.pop(context);
                  })),
              Container(
                  width:MediaQuery.of(context).size.width/12.5,
                  child: CommonElevatedButton(context, "Confirm", onTap)),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10,bottom: 10),
            child: Text("(OR)"),
          ),
          Container(
              width: 260,
              child: CommonElevatedButton(context, "Shortlist for Final Round", finalRoundTap))
        ],
      ),
    ),
  );
}

//SELECT CAMPUS POP UP
Widget select_Campus_Pop(BuildContext context,{void Function()? onTap}) {
  return AlertDialog(
    surfaceTintColor: white1,
    titlePadding: EdgeInsets.all(0),
    title: Container(alignment:Alignment.topRight,child: IconButton(onPressed: (){
      Navigator.pop(context);
    }, icon: ImgPathSvg("xcancel.svg"))),
    content:Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Text("Are you sure to select him/her for an interview ?",style: TitleT,textAlign: TextAlign.center,),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                width:MediaQuery.of(context).size.width/3.5,
                child: CommonElevatedButton(context, "Cancel", () {
                  Navigator.pop(context);
                })),
            Container(
                width:MediaQuery.of(context).size.width/3.5,
                child: CommonElevatedButton(context, "Confirm", onTap)),
          ],
        ),
      ],
    ),
  );
}


//DOWNLOAD
Widget downloadPop(context,{required void Function()? onPress,required String line1,required String line2}){
  return  AlertDialog(
    surfaceTintColor: white1,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
    titlePadding: EdgeInsets.all(0),
    title: Container(alignment:Alignment.topRight,child: IconButton(onPressed: (){
      Navigator.pop(context);
    }, icon: ImgPathSvg("xcancel.svg"))),
    contentPadding: EdgeInsets.only(right: 20,left: 20,bottom: 0),
    content: Container(
      height: 150,
      width: 350,
      child: Column(
        children: [
          Text("${line1} ",style: walletT,),
          Text(
          line2,style: profileTitle,),
          const SizedBox(height: 15,),
          CommonElevatedButton(context, "Download",onPress)
        ],
      ),
    ),
  );
}

//INTERVIEW CONFIRMATION POPUP
Widget InterviewConfirmationPopupWeb(BuildContext context,{required void Function()? onPress}) {
  return AlertDialog(
    surfaceTintColor: white1,
    content:Container(
      color: white1,
      width: 350,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                text: '',
                style: Wbalck1,
                children: <TextSpan>[
                  TextSpan(text: ' 3 Coins',
                    style: TextStyle(
                        color: Color.fromRGBO(254, 168, 50, 1),fontFamily: 'Inter', fontSize: 24,fontWeight: FontWeight.w700),
                  ),
                  TextSpan(text: ' will be deducted for scheduling an interview',
                    style: Wbalck1,
                  ),
                ]
            ),
          ),
          SizedBox(height: 15,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                  width:MediaQuery.of(context).size.width/3.5,
                  child: CommonElevatedButton(context, "Cancel", () {
                    Navigator.pop(context);
                  })),
              Container(
                  width:MediaQuery.of(context).size.width/3.5,
                  child: CommonElevatedButton(context, "Confirm", onPress)),

            ],
          ),
        ],
      ),
    ),
  );
}
//CAMPUS
Widget CampusCallInterview(BuildContext context,{required void Function()? onPress}) {
  return AlertDialog(
    surfaceTintColor: white1,
    content:Container(
      color: white1,
      width: 350,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Are you sure you want to call this candidate for an interview?",style: Wbalck1,textAlign: TextAlign.center,),

          SizedBox(height: 15,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                  width:MediaQuery.of(context).size.width/3.5,
                  child: CommonElevatedButton(context, "Cancel", () {
                    Navigator.pop(context);
                  })),
              Container(
                  width:MediaQuery.of(context).size.width/3.5,
                  child: CommonElevatedButton(context, "Confirm", onPress)),

            ],
          ),
        ],
      ),
    ),
  );
}

//RESCHEDULE CONFIRMATION POP UP
Widget RescheduleConfirmationPop(BuildContext context,{required String typeT,required void Function()? onPress}) {
  return AlertDialog(
    surfaceTintColor: white1,
    content:Container(
      color: white1,
      width: 350,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Are you sure want to ${typeT} the reschedule date and time',style: Wbalck1,textAlign: TextAlign.center,maxLines: 3,),
          SizedBox(height: 15,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                  width:MediaQuery.of(context).size.width/3.5,
                  child: CommonElevatedButton(context, "Cancel", () {
                    Navigator.pop(context);
                  })),
              Container(
                  width:MediaQuery.of(context).size.width/3.5,
                  child: CommonElevatedButton(context, "Confirm", onPress)),

            ],
          ),
        ],
      ),
    ),
  );
}

Widget InterviewRescheduleConfirmationPop(BuildContext context,{required String typeT,required void Function()? onPress}) {
  return AlertDialog(
    surfaceTintColor: white1,
    content:Container(
      color: white1,
      width: 350,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Are you sure want to ${typeT} the interview date and time',style: Wbalck1,textAlign: TextAlign.center,maxLines: 3,),
          SizedBox(height: 15,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                  width:MediaQuery.of(context).size.width/3.5,
                  child: CommonElevatedButton(context, "Cancel", () {
                    Navigator.pop(context);
                  })),
              Container(
                  width:MediaQuery.of(context).size.width/3.5,
                  child: CommonElevatedButton(context, "Confirm", onPress)),

            ],
          ),
        ],
      ),
    ),
  );
}



//COMMON POPUP WEB VIEW
class Common_PopUps_Web extends StatefulWidget {
  void Function()? onTapShortlist;
   Common_PopUps_Web({super.key,required this.onTapShortlist});

  @override
  State<Common_PopUps_Web> createState() => _Common_PopUps_WebState();
}

class _Common_PopUps_WebState extends State<Common_PopUps_Web> {
  bool _isTimeSelected = false;
  void _validateTime() {
    if (_isTimeSelected) {
      _formKey.currentState?.validate();
      // Add your logic to proceed with the button action
    }
  }
  bool? isPdfNeeded;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _interviewDate = TextEditingController();
  TextEditingController _location = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BuildPopupDialog(context);
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
            CommonElevatedButton(context, "ShortList", widget.onTapShortlist),
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
            Text("Please Select the date & time for the Interview",style: Wbalck1,textAlign: TextAlign.center,),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: MyDatePickerForm()
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15,bottom: 15),
              child: TimePickerFormField(onValidate: (value) {_isTimeSelected = true;  },),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10,top: 5),
              child:   textfieldDescription1(
                Controller: _location,
                validating: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please Enter ${'Address*'}";
                  }
                  if (value == null) {
                    return "Please Enter ${'Address*'}";
                  }
                  return null;
                }, hintT: '',
              ),
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
                          builder: (BuildContext context) => InterviewConfirmationPopupWeb(context),
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

//INTERVIEW CONFIRMATION POPUP
  Widget InterviewConfirmationPopupWeb(BuildContext context) {
    return AlertDialog(
      surfaceTintColor: white1,
      content:Container(
        color: white1,
        width: 350,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RichText(
              text: TextSpan(
                  text: '',
                  style: Wbalck1,
                  children: <TextSpan>[
                    TextSpan(text: ' 3 Coins',
                      style: TextStyle(
                          color: Color.fromRGBO(254, 168, 50, 1),fontFamily: 'Inter', fontSize: 24,fontWeight: FontWeight.w700),
                    ),
                    TextSpan(text: ' will be deducted for scheduling an interview',
                      style: Wbalck1,
                    ),
                  ]
              ),
            ),
            SizedBox(height: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    width:MediaQuery.of(context).size.width/12.5,
                    child: CommonElevatedButton(context, "Cancel", () {})),
                Container(
                    width:MediaQuery.of(context).size.width/12.5,
                    child: CommonElevatedButton(context, "Confirm", () {
                      // Navigator.pop(context);
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => WebRecuiterProfileExperence(),
                      );
                    })),

              ],
            ),
          ],
        ),
      ),
    );
  }
}

class RequestCallPopupWeb extends StatefulWidget {
   void Function()? onPress;
   RequestCallPopupWeb({super.key,required this.onPress});

  @override
  State<RequestCallPopupWeb> createState() => _RequestCallPopupWebState();
}

class _RequestCallPopupWebState extends State<RequestCallPopupWeb> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      surfaceTintColor: white1,
      content:Container(
        color: white1,
        width: 350,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RichText(
              text: TextSpan(
                  text: '',
                  style: Wbalck1,
                  children: <TextSpan>[
                    TextSpan(text: '1 Coin',
                      style: TextStyle(
                          color: Color.fromRGBO(254, 168, 50, 1),fontFamily: 'Inter', fontSize: 24,fontWeight: FontWeight.w700),
                    ),
                    TextSpan(text: ' will be deducted for a call request',
                      style: Wbalck1,
                    ),
                  ]
              ),
            ),
            SizedBox(height: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    width:MediaQuery.of(context).size.width/12.5,
                    child: CommonElevatedButton(context, "Cancel", () {
                      Navigator.pop(context);
                    })),
                Container(
                    width:MediaQuery.of(context).size.width/12.5,
                    child: CommonElevatedButton(context, "Confirm", widget.onPress)),
              ],
            ),
            const  SizedBox(height: 10,),
            Container(
                width: MediaQuery.of(context).size.width/1.5,
                child: Text('One coin will be deducted for multiple calls across the interview process',maxLines: 2,textAlign: TextAlign.center,))
          ],
        ),
      ),
    );
  }
  //INTERVIEW CONFIRMATION POPUP
  Widget _callConfirmationPopupWeb(BuildContext context,{required void Function()? onPress}) {
    return AlertDialog(
      surfaceTintColor: white1,
      content:Container(
        color: white1,
        width: 350,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RichText(
              text: TextSpan(
                  text: '',
                  style: Wbalck1,
                  children: <TextSpan>[
                    TextSpan(text: '1 Coin',
                      style: TextStyle(
                          color: Color.fromRGBO(254, 168, 50, 1),fontFamily: 'Inter', fontSize: 24,fontWeight: FontWeight.w700),
                    ),
                    TextSpan(text: ' will be deducted for a call request',
                      style: Wbalck1,
                    ),
                  ]
              ),
            ),
            SizedBox(height: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    width:MediaQuery.of(context).size.width/3.5,
                    child: CommonElevatedButton(context, "Cancel", () {
                      Navigator.pop(context);
                    })),
                Container(
                    width:MediaQuery.of(context).size.width/3.5,
                    child: CommonElevatedButton(context, "Confirm", onPress)),
              ],
            ),
            const  SizedBox(height: 10,),
            Container(
                width: MediaQuery.of(context).size.width/1.5,
                child: Text('One coin will be deducted for multiple calls across the interview process',maxLines: 2,textAlign: TextAlign.center,))
          ],
        ),
      ),
    );
  }

  //INSUFFICIENT COIN POPUP
  Widget _insufficientCoinsPopup(BuildContext context) {
    return AlertDialog(
      content:Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ImgPathSvg("coin.svg"),
            Padding(
              padding: const EdgeInsets.only(top: 15,bottom: 15),
              child: Container(
                height: 40,
                color: red4,
                child: Center(child: Text("Insufficient Coins",style: logOutStyle,)),
              ),
            ),
            Container(
                width: 175,
                child: CommonElevatedButton(context, "Add Coin", () { }))
          ],
        ),
      ),
    );
  }
}