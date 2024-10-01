import 'package:flutter/material.dart';

import 'package:getifyjobs/Src/Common_Widgets/Common_Button.dart';
import 'package:getifyjobs/Src/Common_Widgets/Custom_App_Bar.dart';
import 'package:getifyjobs/Src/Common_Widgets/Image_Path.dart';
import 'package:getifyjobs/Src/Recruiter_Web_Screens/Recruiter_Web_Home_Screens/Recruiter_Web_Profile_Screen.dart';
import 'package:getifyjobs/Src/Recruiter_Web_Screens/Recruiter_Web_Home_Screens/Recuiter_Web_dashboard.dart';
import 'package:getifyjobs/Src/utilits/Common_Colors.dart';
import 'package:getifyjobs/Src/utilits/Text_Style.dart';
import 'package:flutter/foundation.dart';

import 'Recruiter_Web_Home_Screens/Recruiter_Web_Interview_Screen.dart';
import 'Recruiter_Job_Ui/Recruiter_Web_Job_Screen.dart';
import 'Recruiter_Web_Home_Screens/Recruiter_Web_Recent_Applies_Screen.dart';
import 'Recruiter_Web_Home_Screens/Recruiter_Web_Wallet_Screen.dart';

class Recruiter_Web_Home_Screen extends StatefulWidget {
  const Recruiter_Web_Home_Screen({super.key});

  @override
  State<Recruiter_Web_Home_Screen> createState() =>
      _Recruiter_Web_Home_ScreenState();
}

class _Recruiter_Web_Home_ScreenState extends State<Recruiter_Web_Home_Screen> {
  int? selectedIndex = 0;

  void setSelectedIndex(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Recruiter_Web_App_Bar(
        isUsed: false,
        actions: [
          buildClickableText(
            'Dashboard',
            0,
          ),
          buildClickableText(
            'Recent Applies',
            1,
          ),
          buildClickableText(
            'Jobs',
            2,
          ),
          buildClickableText(
            'Interview',
            3,
          ),
          //WALLET COINS
          wallet_Coin(4),
          //RECRUITER PROFILE
          recruiterProfile(5),
        ],
        isLogoUsed: false,
        isTitleUsed: true,
        title: '',
      ),
      body: selectedIndex == 0
          ? WebDashBoard()
      :selectedIndex == 1
          ? Recruiter_Web_Recent_Applies()
          : selectedIndex == 2
              ? Recruiter_Web_Job_screen()
              : selectedIndex == 3
                  ? Recruiter_Web_Interview_Screen()
                  : selectedIndex == 4
                      ? Recruiter_Web_Wallet_Screen()
                      : Recruiter_Web_Profile_Screen(),
    );
  }

  //App Bar navigation text
  Widget buildClickableText(
    String text,
    int index,
  ) {
    return InkWell(
      onTap: () {
        setSelectedIndex(index);
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 25),
        child: Text(
          text,
          style: selectedIndex == index ? appBarSelect : profileT,
        ),
      ),
    );
  }

  //WALLET COIN
  Widget wallet_Coin(int index) {
    return InkWell(
      onTap: () {
        setSelectedIndex(index);
      },
      child: Row(
        children: [
          Text(
            '12',
            style: TitleT,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20, left: 10),
            child: ImgPathSvg("coin.svg"),
          ),
        ],
      ),
    );
  }

  //RECRUITER PROFILE SCREEN
  Widget recruiterProfile(int index) {
    return InkWell(
      onTap: () {
        setSelectedIndex(index);
      },
      child: Container(
        height: 50,
        width: 50,
        margin: EdgeInsets.only(left: 40,right: 30),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            image: DecorationImage(
                image: AssetImage("lib/assets/recruiterImg.png"),
                fit: BoxFit.cover)),
      ),
    );
  }
}
