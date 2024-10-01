import 'package:flutter/material.dart';
import 'package:getifyjobs/Src/Recruiter_Mobile_Screen/Home_DashBoard/Recruiter_Home_Screen.dart';
import 'package:getifyjobs/Src/Recruiter_Mobile_Screen/Recruiter_Login_Ui/Recruiter_Login_Page.dart';
import 'package:getifyjobs/Src/Recruiter_Web_Screens/Recruiter_Job_Ui/Recruiter_Web_Create_Job.dart';
import 'package:getifyjobs/Src/Recruiter_Web_Screens/Recuiter_Login/Recuiter_Web_Login_Screen.dart';

import 'Recruiter_Web_AppNavigationBar_Screen.dart';
import 'Responsive_Layout.dart';
import 'package:flutter/foundation.dart';

class Responsive_Home_Screen extends StatefulWidget {
  const Responsive_Home_Screen({super.key});

  @override
  State<Responsive_Home_Screen> createState() => _Responsive_Home_ScreenState();
}

class _Responsive_Home_ScreenState extends State<Responsive_Home_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Responsive_Layout(
        mobileBody: Recruiter_Login_Page(),
        webBody: Recuiter_Web_Login_Screen(),),
    );
  }
}
