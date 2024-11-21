import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:getifyjobs/Src/Recruiter_Mobile_Screen/Recruiter_Login_Ui/Recruiter_Login_Page.dart';
import 'package:getifyjobs/Src/utilits/Generic.dart';

import '../utilits/Common_Colors.dart';
import '../utilits/Text_Style.dart';

// LOGOUT BUTTON
Widget LogOutButton(BuildContext context) {
  return Container(
      padding: EdgeInsets.all(8), // Add padding to all sides

      decoration: BoxDecoration(
        color: Colors.red, // Change the color as needed
        borderRadius:
            BorderRadius.circular(10), // Customize the border radius as needed
      ),
      child: InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) => LogOutPopup(context),
          );
        },
        child: Text(
          "Log Out",
          style: TextStyle(
            color: Colors.white, // Change the text color as needed
            fontSize: 16, // Customize the font size as needed
          ),
        ),
      ));

  // return InkWell(
  //   onTap: (){
  //     showDialog(
  //       context: context,
  //       builder: (BuildContext context) => LogOutPopup(context),
  //     );
  //   },
  //   child: Container(
  //     child: Text(
  //       "Log Out",style: logOutStyle,
  //     ),
  //   ),
  // );
}

//LOGOUT POPUP
Widget LogOutPopup(BuildContext context) {
  return AlertDialog(
    surfaceTintColor: white1,
    content: Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Logout Account",
            style: Wbalck3,
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            "Are you sure want to logout ?",
            style: companyT,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Cancel",
                    style: Wbalck3,
                  )),
              InkWell(
                onTap: () {
                  RecruiterId("");
                  Routes("false");
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Recruiter_Login_Page()));
                },
                child: Text(
                  "Confirm",
                  style: logOutStyle,
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

// ELEVATED BUTTON
Widget CommonElevatedButton(
  BuildContext context,
  String titleName,
  void Function()? onPress,
) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: blue1,
      minimumSize: Size(double.infinity, 50),
      elevation: 9,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
    onPressed: onPress,
    child: Text(
      titleName,
      style: ButtonT,
    ),
  );
}

Widget CommonElevatedButton2(
  BuildContext context,
  String titleName,
  void Function()? onPress,
) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: blue1,
      minimumSize: Size(double.infinity, 50),
      elevation: 9,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
    onPressed: onPress,
    child: Text(
      titleName,
      style: ButtonT1,
    ),
  );
}

Widget CommonElevatedButton_No_Elevation(BuildContext context, String titleName,
    void Function()? onPress, Color btcolor, TextStyle? style) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: btcolor,
      minimumSize: Size(double.infinity, 35),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
    onPressed: onPress,
    child: Text(
      titleName,
      style: style,
    ),
  );
}

Widget CommonElevatedButton1(BuildContext context, String titleName,
    void Function()? onPress, Color btcolor) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: btcolor,
      minimumSize: Size(double.infinity, 50),
      elevation: 9,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(33)),
    ),
    onPressed: onPress,
    child: Text(
      titleName,
      style: ButtonT,
    ),
  );
}
// FLOATING BUTTON

Widget Floating_Button(context, {required Function() onTap}) {
  return SpeedDial(
    curve: Curves.bounceInOut,
    //  animatedIcon: AnimatedIcons.event_add,
    icon: Icons.add,
    onPress: onTap,
    iconTheme: IconThemeData(color: Colors.white),
    // animatedIconTheme: IconThemeData(color: Colors.white),
    backgroundColor: blue1,
    shape: CircleBorder(),
  );
}

Widget Floating_Button_Campus(context, {required Function()? onTap}) {
  return SpeedDial(
    curve: Curves.bounceInOut,
    //  animatedIcon: AnimatedIcons.event_add,
    icon: Icons.add,
    iconTheme: IconThemeData(color: Colors.white),
    // animatedIconTheme: IconThemeData(color: Colors.white),
    backgroundColor: blue1,
    shape: CircleBorder(),
    children: [
      SpeedDialChild(
          // shape: CircleBorder(),
          // child: Icon(Icons.group_add),
          onTap: onTap,
          label: "Bulk Job"),
    ],
  );
}

// CHECK BOX
Widget CheckBoxes(
    {required bool? value,
    required void Function(bool?)? onChanged,
    required String checkBoxText,
    void Function()? onTap}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Checkbox(
          value: value,
          activeColor: blue1,
          onChanged: onChanged,
          visualDensity: VisualDensity(horizontal: -4, vertical: -4),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        InkWell(onTap: onTap, child: RadioText(checkBoxText)),
      ],
    ),
  );
}

//RADIO BUTTON
Widget RadioButton(
    {required int? groupValue1,
    required int? groupValue2,
    required void Function(int?)? onChanged1,
    required void Function(int?)? onChanged2,
    required String radioTxt1,
    required String radioTxt2}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Radio(
        value: 0,
        groupValue: groupValue1,
        activeColor: blue1,
        onChanged: onChanged1,
        visualDensity: VisualDensity(horizontal: -4, vertical: -4),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      RadioText(radioTxt1),
      const SizedBox(
        width: 40,
      ),
      Radio(
        value: 1,
        activeColor: blue1,
        groupValue: groupValue2,
        onChanged: onChanged2,
        visualDensity: VisualDensity(horizontal: -4, vertical: -4),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      RadioText(radioTxt2),
    ],
  );
}

//MULTIPLE RADIO BUTTON
Widget MultiRadioButton(
    {required int? groupValue1,
    required int? groupValue2,
    required int? groupValue3,
    required void Function(int?)? onChanged1,
    required void Function(int?)? onChanged2,
    required void Function(int?)? onChanged3,
    required String radioTxt1,
    required String radioTxt2,
    required String radioTxt3}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Radio(
        value: 0,
        groupValue: groupValue1,
        activeColor: blue1,
        onChanged: onChanged1,
        visualDensity: VisualDensity(horizontal: -4, vertical: -4),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      RadioText(radioTxt1),
      Spacer(),
      Radio(
        value: 1,
        activeColor: blue1,
        groupValue: groupValue2,
        onChanged: onChanged1,
        visualDensity: VisualDensity(horizontal: -4, vertical: -4),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      RadioText(radioTxt2),
      Spacer(),
      Radio(
        value: 2,
        activeColor: blue1,
        groupValue: groupValue3,
        onChanged: onChanged3,
        visualDensity: VisualDensity(horizontal: -4, vertical: -4),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      RadioText(radioTxt3),
    ],
  );
}

//ELEVATED BOTTON
Widget AppliedButton(BuildContext context, String titleName,
    {required void Function()? onPress, required Color? backgroundColor}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: backgroundColor,
      minimumSize: Size(double.infinity, 50),
      // elevation: 9,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
    onPressed: onPress,
    child: Text(
      titleName,
      style: ButtonT,
    ),
  );
}
