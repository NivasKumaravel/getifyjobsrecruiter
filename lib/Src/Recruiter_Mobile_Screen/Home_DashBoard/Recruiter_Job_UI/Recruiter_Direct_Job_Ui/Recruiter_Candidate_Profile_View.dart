import 'package:flutter/material.dart';
import 'package:getifyjobs/Src/Common_Widgets/Common_Button.dart';
import 'package:getifyjobs/Src/Common_Widgets/Common_Candidate_Profile.dart';
import 'package:getifyjobs/Src/Common_Widgets/Common_List.dart';
import 'package:getifyjobs/Src/Common_Widgets/Common_PopUp_Widgets.dart';
import 'package:getifyjobs/Src/Common_Widgets/Custom_App_Bar.dart';
import 'package:getifyjobs/Src/Common_Widgets/Text_Form_Field.dart';
import 'package:getifyjobs/Src/utilits/Common_Colors.dart';
import 'package:getifyjobs/Src/utilits/Text_Style.dart';
import 'package:intl/intl.dart';
class Recruiter_Candidate_Profile_View extends StatefulWidget {
  const Recruiter_Candidate_Profile_View({super.key});

  @override
  State<Recruiter_Candidate_Profile_View> createState() => _Recruiter_Candidate_Profile_ViewState();
}

class _Recruiter_Candidate_Profile_ViewState extends State<Recruiter_Candidate_Profile_View> {
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white2,
      appBar: Custom_AppBar(
        isUsed: true,
        actions: null,
        isLogoUsed: true,
        isTitleUsed: true,
        title: "Profile",
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                height: MediaQuery.of(context).size.height,
                child: Direct_Candidate_Profile_Screen( TagContain: '', candidate_Id: '', job_Id: '',)),
            // SizedBox(height: 100,)
          ],
        ),
      ),
    );
  }


}
