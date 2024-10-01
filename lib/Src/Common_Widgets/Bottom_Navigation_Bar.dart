import 'package:flutter/material.dart';

import 'package:getifyjobs/Src/Recruiter_Mobile_Screen/Home_DashBoard/Recruiter_Home_Screen.dart';
import 'package:getifyjobs/Src/Recruiter_Mobile_Screen/Home_DashBoard/Recruiter_Interview_UI/Recruiter_Interview_Screen.dart';
import 'package:getifyjobs/Src/Recruiter_Mobile_Screen/Home_DashBoard/Recruiter_Job_UI/Recruiter_Job_Page.dart';
import 'package:getifyjobs/Src/Recruiter_Mobile_Screen/Home_DashBoard/Recruiter_Profile_Screen.dart';
import 'package:getifyjobs/Src/utilits/Common_Colors.dart';
import 'Image_Path.dart';




//RECRUITER BOTTOM NAVIGATION BAR
class Recruiter_Bottom_Navigation extends StatefulWidget {
  int select;
  Recruiter_Bottom_Navigation({Key? key,required this.select}) : super(key: key);

  @override
  State<Recruiter_Bottom_Navigation> createState() => _Recruiter_Bottom_NavigationState();
}

class _Recruiter_Bottom_NavigationState extends State<Recruiter_Bottom_Navigation> {

  final pages = [
    Recruiter_Home_Screen(),
    Recuiter_Jobs_Screen(),
    Recuiter_Interview_Screen(),
    Recuiter_Profile_Screen(),
  ];

  void b(index) {
    setState(() {
      widget.select = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: pages[widget.select],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: BottomNavigationBar(
            backgroundColor: white1,
            selectedItemColor: blue1,
            selectedLabelStyle: TextStyle(color: blue1),
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                icon: _IconImg("home.svg"),
                activeIcon: _IconImg("homeactive.svg"),
                label: "Home",
              ),
              BottomNavigationBarItem(
                  activeIcon: _IconImg("jobActive.svg"),
                  icon: _IconImg("job.svg"),
                  label: "Jobs"),
              BottomNavigationBarItem(
                  activeIcon: _IconImg("interviewActive.svg"),
                  icon: _IconImg("interview.svg"),
                  label: "Interview"),
              BottomNavigationBarItem(
                  activeIcon: _IconImg("useractive.svg"),
                  icon: _IconImg("user.svg"),
                  label: "Profile"),
              // BottomNavigationBarItem(
              //     activeIcon: _IconImg("package2.svg"),
              //     icon: _IconImg("package1.svg"),
              //     label: "Products"),
            ],
            currentIndex: widget.select,
            onTap: b,
          ),
        ),
      ),
    );
  }

  Widget _IconImg(String Img) {
    return Container(height: 20, width: 20, child: ImgPathSvg(Img));
  }
}


