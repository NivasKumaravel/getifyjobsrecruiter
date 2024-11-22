import 'package:flutter/material.dart';
import 'package:getifyjobs/Src/utilits/Common_Colors.dart';

import '../utilits/Text_Style.dart';
import 'Image_Path.dart';
import 'Image_Widget.dart';
import 'Text_Form_Field.dart';

//DIRECT LIST
Widget DirectList(context,
    {required bool? isApplied,
    required String jobName,
    required String companyName,
    required String location,
    required String companyLogo,
    required String YOP,
    required String ExpSalary,
    required String postedDate,
    required String collegeName,
    required String appliedDate}) {
  return Container(
    width: MediaQuery.of(context).size.width,
    margin: EdgeInsets.only(top: 15, left: 20, right: 20),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: Colors.white, // Set the color here
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            margin: EdgeInsets.only(left: 20, right: 20, top: 10),
            child: Text(
              jobName,
              style: TitleT,
            )),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 5),
          child: buildCompanyInfoRow(companyLogo, companyName, TBlack, 50, 50,
              isMapLogo: false),
        ),
        Container(
            margin: EdgeInsets.only(left: 20, top: 10, right: 20),
            child: collegeRowTitle(
                "map-pin (1).png", location, Homegrey2, 20, 20,
                isOtherLogo: true)),
        Container(
            margin: EdgeInsets.only(left: 20, top: 10, right: 20),
            child: collegeRowTitle("bagpng.png", YOP, Homegrey2, 20, 20,
                isOtherLogo: true)),
        Container(
            margin: EdgeInsets.only(left: 20, top: 10, right: 20),
            child: collegeRowTitle(
                "walletpng.png", ExpSalary, Homegrey2, 20, 20,
                isOtherLogo: true)),
        isApplied == true
            ? Container()
            : Container(
                margin: EdgeInsets.only(left: 20, top: 10, right: 20),
                child: Row(
                  children: [
                    Text(
                      "Applied Date : ${appliedDate}",
                      style: Homegrey2,
                    ),
                  ],
                )),
        Container(
          margin: EdgeInsets.only(left: 20, top: 15, right: 20, bottom: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              isApplied == true
                  ? Text(postedDate, style: decpgrey2)
                  : Container(
                      height: 20,
                      width: 55,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: blue2,
                      ),
                      child: Center(
                          child: Text(
                        'Applied',
                        style: appliedT,
                      )),
                    ),
              Container(
                  margin: EdgeInsets.only(right: 15),
                  child: ImgPathSvg("tag.svg")),
            ],
          ),
        ),
        isApplied == true
            ? Container()
            : Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: Divider(
                  height: 0,
                  thickness: 2,
                  color: white2,
                ),
              ),
        isApplied == true
            ? Container()
            : Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
                child: buildCompanyInfoRow(
                    companyLogo, collegeName, TBlack, 50, 50,
                    isMapLogo: false),
              ),
        isApplied == true
            ? Container()
            : Container(
                margin:
                    EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 15),
                child: collegeRowTitle(
                    "map-pin (1).png", location, Homegrey2, 20, 20,
                    isOtherLogo: true)),
      ],
    ),
  );
}

//CANDIDATE MY APPLIES lIST
Widget Candidate_MyApplies_List(context,
    {required bool? isApplied,
    required String jobName,
    required String companyName,
    required String location,
    required String companyLogo,
    required String YOP,
    required String ExpSalary,
    required String postedDate,
    required String collegeName,
    required String appliedDate}) {
  return Container(
    width: MediaQuery.of(context).size.width,
    margin: EdgeInsets.only(top: 15, left: 20, right: 20),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: Colors.white, // Set the color here
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            margin: EdgeInsets.only(left: 20, right: 20, top: 10),
            child: Text(
              jobName,
              style: TitleT,
            )),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 5),
          child: buildCompanyInfoRow(companyLogo, companyName, TBlack, 50, 50,
              isMapLogo: false),
        ),
        Container(
            margin: EdgeInsets.only(left: 20, top: 10, right: 20),
            child: collegeRowTitle(
                "map-pin (1).png", location, Homegrey2, 20, 20,
                isOtherLogo: true)),
        Container(
            margin: EdgeInsets.only(left: 20, top: 10, right: 20),
            child: collegeRowTitle("bagpng.png", YOP, Homegrey2, 20, 20,
                isOtherLogo: true)),
        Container(
            margin: EdgeInsets.only(left: 20, top: 10, right: 20),
            child: collegeRowTitle(
                "walletpng.png", ExpSalary, Homegrey2, 20, 20,
                isOtherLogo: true)),
        Container(
            margin: EdgeInsets.only(left: 20, top: 10, right: 20),
            child: Row(
              children: [
                Text(
                  "Applied Date : ${appliedDate}",
                  style: Homegrey2,
                ),
              ],
            )),
        Container(
          margin: EdgeInsets.only(left: 20, top: 15, right: 20, bottom: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              isApplied == true
                  ? Text(postedDate, style: decpgrey2)
                  : Container(
                      height: 20,
                      width: 55,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: blue2,
                      ),
                      child: Center(
                          child: Text(
                        'Applied',
                        style: appliedT,
                      )),
                    ),
              Container(
                  margin: EdgeInsets.only(right: 15),
                  child: ImgPathSvg("tag.svg")),
            ],
          ),
        ),
      ],
    ),
  );
}

//CAMPUS LIST
Widget CampusList({
  required String? iscampTag,
  required String collegeName,
  required String collegeLogo,
  required String collegeLocation,
}) {
  Color? containerColor;
  TextStyle? statusStyle;
  switch (iscampTag) {
    case "Applied":
      containerColor = blue2;
      statusStyle = appliedT;
      break;
    case "Assigned":
      containerColor = green3;
      statusStyle = shortlistedT;
      break;
    case "Pending":
      containerColor = yellow2;
      statusStyle = prndingT;
      break;
    default:
      containerColor = Colors.white;
      break;
  }
  return Container(
      margin: EdgeInsets.only(top: 15, left: 20, right: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white, // Set the color here
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                child: collegeRowTitle(collegeLogo, collegeName, TBlack, 50, 50,
                    isOtherLogo: false),
              ),
              Container(
                  margin:
                      EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 15),
                  child: buildCompanyInfoRow(
                      "map-pin (1).png", collegeLocation, Homegrey2, 22, 22,
                      isMapLogo: true)),
              iscampTag == "Not Applied"
                  ? Container()
                  : Container(
                      width: 100,
                      margin: EdgeInsets.only(left: 20, bottom: 15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          color: containerColor),
                      child: Center(
                          child: Padding(
                        padding: const EdgeInsets.only(
                            left: 5, right: 5, top: 5, bottom: 5),
                        child: Text(
                          iscampTag ?? "",
                          style: statusStyle,
                        ),
                      )),
                    ),
            ],
          )
        ],
      ));
}



Widget cards(
    {required String countTxt,
    required String txt,
    required Color Ccolor,
    required TextStyle txtStyle}) {
  return Container(
    height: 90,
    width: 165,
    decoration:
        BoxDecoration(borderRadius: BorderRadius.circular(10), color: white1),
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 15, bottom: 7),
          child: Text(
            countTxt,
            style: count,
          ),
        ),
        Container(
          height: 23,
          width: 165,
          color: Ccolor,
          child: Center(
              child: Text(
            txt,
            style: txtStyle,
          )),
        ),
      ],
    ),
  );
}

//APPLIES LIST
Widget AppliesList(
  context, {
  required String CandidateImg,
  required String CandidateName,
  required String Jobrole,
  required Color? color,
  required bool? isWeb,
  required bool? isTagNeeded,
  required String isTagName,
}) {
  Color campTagColor;
  TextStyle campTagTextStyle;
  switch (isTagName) {
    case "Schedule Requested": // Added case for "Applied"
      campTagColor = blue2; // Assuming appliedColor is defined
      campTagTextStyle = appliedT; // Assuming appliedT is defined
      break;
    case "Shortlisted": // Added case for "Applied"
      campTagColor = yellow2; // Assuming appliedColor is defined
      campTagTextStyle = RecYellow; // Assuming appliedT is defined
      break;
    case "Rejected": // Added case for "Applied"
      campTagColor = red4; // Assuming appliedColor is defined
      campTagTextStyle = red; // Assuming appliedT is defined
      break;
    case "Schedule Rejected":
      campTagColor = pink3;
      campTagTextStyle = red; // Assuming appliedT is defined
      break;
    case "Candidate Rescheduled":
      campTagColor = grey4;
      campTagTextStyle = grey; // Assuming appliedT is defined
      break;
      case "Interview Rescheduled":
      campTagColor = grey4;
      campTagTextStyle = grey; // Assuming appliedT is defined
      break;
    case "Recruiter Rescheduled":
      campTagColor = grey4;
      campTagTextStyle = grey; // Assuming appliedT is defined
      break;
    case "Not Attended":
      campTagColor = grey4;
      campTagTextStyle = grey; // Assuming appliedT is defined
      break;
    case "Schedule Accepted":
      campTagColor = green3;
      campTagTextStyle = green; // Assuming appliedT is defined
      break;
    case "Selected":
      campTagColor = green3;
      campTagTextStyle = green; // Assuming appliedT is defined
      break;
    case "Final Round":
      campTagColor = green3;
      campTagTextStyle = green; // Assuming appliedT is defined
      break;
    case "Wait List":
      campTagColor = orange3;
      campTagTextStyle = orange; // Assuming appliedT is defined
      break;
    case "Call for Interview":
      campTagColor = orange3;
      campTagTextStyle = orange; // Assuming appliedT is defined
      break;

    default:
      campTagColor = green3;
      campTagTextStyle = green;
      break;
  }
  return Container(
    decoration:
        BoxDecoration(borderRadius: BorderRadius.circular(15), color: color),
    child: Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
      child: Row(
        children: [
          Candidate_Img(ImgPath: CandidateImg),
          isWeb == true
              ? Row(
                  children: [
                    Container(
                        margin: EdgeInsets.only(left: 15, right: 10),
                        // width: MediaQuery.of(context).size.width/1.5,
                        child: Text(
                          CandidateName,
                          style: appliesT,
                        )),
                    Container(
                        // width: MediaQuery.of(context).size.width/1.5,
                        child: Text(
                      "($Jobrole)",
                      style: positionT1,
                      maxLines: 2,
                    )),
                  ],
                )
              : Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width / 2.5,
                          child: Text(
                            CandidateName,
                            style: appliesT,
                            maxLines: 2,
                          )),
                      isTagNeeded == true
                          ? Container(
                              margin: EdgeInsets.only(top: 10, bottom: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                color: campTagColor,
                              ),
                              child: Center(
                                child: Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Text(
                                      isTagName ?? "",
                                      style: campTagTextStyle,
                                    )),
                              ),
                            )
                          : Container(),
                      Container(
                          width: MediaQuery.of(context).size.width / 2,
                          child: Text(
                            Jobrole,
                            style: positionT,
                            maxLines: 2,
                          )),
                    ],
                  ),
                ),
        ],
      ),
    ),
  );
}

//APPLIES LIST
Widget AppliesListWithTag(
  context, {
  required String CandidateImg,
  required String CandidateName,
  required String Jobrole,
  required String round,
  required Color? color,
}) {
  return Container(
    decoration:
        BoxDecoration(borderRadius: BorderRadius.circular(15), color: color),
    child: Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
      child: Row(
        children: [
          Candidate_Img(ImgPath: CandidateImg),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    // width: MediaQuery.of(context).size.width/1.5,
                    child: Text(
                  CandidateName,
                  style: appliesT,
                )),
                Row(
                  children: [
                    Container(
                        width: 130,
                        child: Text(
                          Jobrole,
                          style: positionT,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        )),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      width: MediaQuery.sizeOf(context).width/5,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5), color: grey8),
                      child: Center(
                          child: Padding(
                        padding: const EdgeInsets.only(left: 5,right: 5,top: 3,bottom: 3),
                        child: Text(
                          round,
                          style: positionT,
                          maxLines: 2,
                        ),
                      )),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
}

Widget customListItem(context,
    {required String badgeText,
    required String appliedRole,
    required String interviewTime,
    required String status,
    required TextStyle badgeTextStyle,
    required TextStyle countTextStyle,
    required TextStyle interviewTimeTextStyle,
    required Color statusColor,
    required bool isWeb,
    required String profileImg}) {
  Color containerColor; // Define a variable to hold the container color

  switch (status) {
    case "Schedule Rejected":
      containerColor = pink3;
      break;
    case "Rejected":
      containerColor = pink3;
      break;
    case "Schedule Requested":
      containerColor = blue2;
      break;
    case "Candidate Rescheduled":
      containerColor = grey4;
      break;
    case "Recruiter Rescheduled":
      containerColor = grey4;
      break;
    case "Interview Rescheduled":
      containerColor = grey4;
      break;
    case "Not Attended":
      containerColor = grey4;
      break;
    case "Schedule Accepted":
      containerColor = green3;
      break;
    case "Selected":
      containerColor = green3;
      break;
    case "Wait List":
      containerColor = orange3;
      break;
    default:
      containerColor = Colors.transparent;
      break;
  }

  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: white1, // Use the variable to set the color
    ),
    margin: EdgeInsets.only(top: 15, bottom: 15),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: 15, bottom: 15, left: 10, right: 10),
          child: Row(
            children: [
              Container(
                height: 50,
                width: 50,
                child: buildImage(profileImg,
                    border: const Radius.circular(50), fit: BoxFit.cover),
              ),
              isWeb == true
                  ? Row(
                      children: [
                        //NAME
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 5),
                          child: Text(badgeText, style: badgeTextStyle),
                        ),
                        //JOB ROLE
                        Container(
                          child: Text("($appliedRole)", style: positionT1),
                        ),
                      ],
                    )
                  : Container(
                      margin: EdgeInsets.only(left: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //NAME
                          Text(badgeText, style: badgeTextStyle),
                          //JOB ROLE
                          Container(
                            margin: EdgeInsets.only(top: 5),
                            child: Text(appliedRole, style: blue),
                          ),
                        ],
                      ),
                    ),
            ],
          ),
        ),
        Divider(
          color: white2,
          height: 0,
          thickness: 2,
        ),
        isWeb == true
            ? Padding(
                padding: const EdgeInsets.only(
                    bottom: 10, top: 10, right: 15, left: 15),
                child: Row(
                  children: [
                    Container(
                      child: Text("Interview Scheduled on: ", style: Wbalck1),
                    ),
                    Container(
                      child: Text(interviewTime, style: Wbalck0),
                    ),
                    const Spacer(),
                    Container(
                      //width: MediaQuery.of(context).size.width / 5,
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(color: containerColor),
                      child: Center(
                          child: Text(
                        status,
                        style: getStatusTextStyle(status), maxLines: 1,
                      )),
                    ),
                  ],
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 10, top: 10, right: 10),
                    child: Text("Interview Scheduled on: ",
                        style: interviewTimeTextStyle),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 0, top: 2, bottom: 10),
                          child: Text(interviewTime, style: Wbalck),
                        ),
                        Spacer(),
                        Container(
                          // padding: EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(color: containerColor),
                          margin: EdgeInsets.only(right: 5, bottom: 10),
                          child: Container(
                              width: MediaQuery.of(context).size.width / 2.9,
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Center(
                                    child: Text(status,
                                        style: getStatusTextStyle(status))),
                              )),
                        ),
                      ],
                    ),
                  ),
                ],
              )
      ],
    ),
  );
}

TextStyle getStatusTextStyle(String status) {
  switch (status) {
    case "Schedule Rejected":
      return TextStyle(
          fontFamily: 'Inter',
          fontSize: 12,
          color: Color.fromRGBO(255, 0, 13, 1),
          fontWeight: FontWeight.w500);
    case "Rejected":
      return TextStyle(
          fontFamily: 'Inter',
          fontSize: 12,
          color: Color.fromRGBO(255, 0, 13, 1),
          fontWeight: FontWeight.w500);
    case "Schedule Requested":
      return TextStyle(
          fontFamily: 'Inter',
          fontSize: 12,
          color: Color.fromRGBO(0, 160, 226, 1),
          fontWeight: FontWeight.w500);
    case "Candidate Rescheduled":
      return TextStyle(
          fontFamily: 'Inter',
          fontSize: 12,
          color: Color.fromRGBO(245, 245, 245, 1),
          fontWeight: FontWeight.w500);
    case "Recruiter Rescheduled":
      return TextStyle(
          fontFamily: 'Inter',
          fontSize: 12,
          color: Color.fromRGBO(245, 245, 245, 1),
          fontWeight: FontWeight.w500);
    case "Interview Rescheduled":
      return TextStyle(
          fontFamily: 'Inter',
          fontSize: 12,
          color: Color.fromRGBO(245, 245, 245, 1),
          fontWeight: FontWeight.w500);
    case "Not Attended":
      return TextStyle(
          fontFamily: 'Inter',
          fontSize: 12,
          color: Color.fromRGBO(245, 245, 245, 1),
          fontWeight: FontWeight.w500);
    case "Schedule Accepted":
      return TextStyle(
          fontFamily: 'Inter',
          fontSize: 12,
          color: Color.fromRGBO(61, 186, 40, 1),
          fontWeight: FontWeight.w500);
    case "Selected":
      return TextStyle(
          fontFamily: 'Inter',
          fontSize: 12,
          color: Color.fromRGBO(61, 186, 40, 1),
          fontWeight: FontWeight.w500);
    case "Wait List":
      return TextStyle(
          fontFamily: 'Inter',
          fontSize: 12,
          color: orange4,
          fontWeight: FontWeight.w500);
    default:
      return TextStyle(color: Colors.black);
  }
}

String getStatusText(String status) {
  switch (status) {
    case "Schedule Rejected":
      return "Schedule Rejected";
    case "Rejected":
      return "Rejected";
    case "Schedule Requested":
      return "Schedule Requested";
    case "Selected":
      return "Selected";
    case "Not Attended":
      return "Not Attended";
    case "Candidate Reschedule":
      return "Candidate Reschedule";
    case "Schedule Accepted":
      return "Schedule Accepted";
    case "Wait List":
      return "Wait List";
    default:
      return "Default Status";
  }
}

Widget DirectList1(context,
    {required bool? isApplied,
    required String jobName,
    required String companyName,
    required String location,
    required String companyLogo,
    required String collegeName,
    required String collegeLogo,
    required String collegeLoaction,
    required String posteddate}) {
  return Container(
    width: MediaQuery.of(context).size.width,
    margin: EdgeInsets.only(top: 15, left: 20, right: 20),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: Colors.white, // Set the color here
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            margin: EdgeInsets.only(left: 20, right: 20, top: 10),
            child: Text(
              jobName,
              style: TitleT,
            )),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 5),
          child: buildCompanyInfoRow(companyLogo, companyName, TBlack, 50, 50,
              isMapLogo: false),
        ),
        isApplied == false
            ? Container(
                margin: EdgeInsets.only(left: 20, top: 10, right: 20),
                child: collegeRowTitle(
                    "map-pin (1).png", location, Homegrey2, 20, 20,
                    isOtherLogo: true))
            : Container(
                margin: EdgeInsets.only(left: 20),
                height: 20,
                width: 55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  color: yellow3,
                ),
                child: Center(
                    child: Text(
                  'Pending',
                  style: RecYellow,
                )),
              ),
        Container(
          margin: EdgeInsets.only(left: 20, top: 15, right: 20, bottom: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              isApplied == true
                  ? Text("Posted: 23 Sep 2023", style: decpgrey2)
                  : Container(
                      height: 20,
                      width: 55,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: blue2,
                      ),
                      child: Center(
                          child: Text(
                        'Pending',
                        style: appliedT,
                      )),
                    ),
            ],
          ),
        ),
        isApplied == true
            ? Container()
            : Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: Divider(
                  height: 0,
                  thickness: 2,
                  color: white2,
                ),
              ),
        isApplied == true
            ? Container()
            : Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
                child: buildCompanyInfoRow(
                    collegeLogo, collegeName, TBlack, 50, 50,
                    isMapLogo: false),
              ),
        isApplied == true
            ? Container()
            : Container(
                margin:
                    EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 15),
                child: collegeRowTitle(
                    "Pin.svg", collegeLoaction, Homegrey2, 20, 20,
                    isOtherLogo: true)),
      ],
    ),
  );
}

Widget CampusList2({
  required String? isTag,
  required String? iscampTag,
  required bool? isUsed,
  required bool isOnCampus,
  required String companyName,
  required String companyLogo,
  required String companyLocation,
}) {
  Color campTagColor;
  TextStyle campTagTextStyle;
  switch (iscampTag) {
    case "Applied": // Added case for "Applied"
      campTagColor = blue2; // Assuming appliedColor is defined
      campTagTextStyle = appliedT; // Assuming appliedT is defined
      break;
    case "Assigned": // Added case for "Applied"
      campTagColor = green3; // Assuming appliedColor is defined
      campTagTextStyle = shortlistedT; // Assuming appliedT is defined
      break;
    default:
      campTagColor = Colors.transparent;
      campTagTextStyle = TextStyle();
      break;
  }
  return Container(
    margin: EdgeInsets.only(right: 20, left: 20, top: 15),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.white,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isUsed == true)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                child: collegeRowTitle(companyLogo, companyName, TBlack, 50, 50,
                    isOtherLogo: false),
              ),
              Container(
                  margin:
                      EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 15),
                  child: buildCompanyInfoRow(
                      "map-pin (1).png", companyLocation, Homegrey2, 20, 20,
                      isMapLogo: true)),
              Container(
                width: 100,
                margin: EdgeInsets.only(left: 22, bottom: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  color: campTagColor,
                ),
                child: Center(
                  child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Text(
                        iscampTag ?? "",
                        style: campTagTextStyle,
                      )),
                ),
              ),
            ],
          )
        else
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ... (Your existing code)
              Container(
                width: 100,
                margin: EdgeInsets.only(left: 20, bottom: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  color: campTagColor,
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      isOnCampus ? 'On Campus' : 'Off Campus',
                      style: campTagTextStyle,
                    ),
                  ),
                ),
              ),
              isTag == "Applied"
                  ? Text(
                      'Applied',
                      style: appliedT,
                    )
                  : Container()
            ],
          )
      ],
    ),
  );
}

Widget buildCompanyInfoRowNotifacation(
  context, {
  required String pathSVG,
  required String jobName,
  required String name,
  required double imageWidth,
  required double imageHeight,
}) {
  return Padding(
    padding: const EdgeInsets.only(top: 5),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
            height: imageHeight, width: imageWidth, child: ImgPathSvg(pathSVG)),
        Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Container(
            // width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: appliesT,
                  maxLines: 2,
                  // overflow: TextOverflow.ellipsis,
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.5,
                  child: Text(
                    jobName,
                    style: Homegrey,
                    // You can use the same style as the company name or customize it as needed
                    maxLines: 2,
                    // overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

//CANDIDATE JOB List SCREEN
Widget NoOfCandidatesSection(
  BuildContext context, {
  required String jobName,
  required String noOfCandidates,
  required String postedDate,
  required bool isWeb,
  required String status,
}) {
  Color? containerColor;
  TextStyle? statusStyle;
  switch (status) {
    case "Pending":
      containerColor = orange3;
      statusStyle = orange;
      break;
    case "Active":
      containerColor = green3;
      statusStyle = shortlistedT;
      break;
    case "Expired":
      containerColor = pink3;
      statusStyle = red;
      break;
    default:
      containerColor = Colors.white;
      break;
  }
  return Padding(
    padding: const EdgeInsets.only(top: 15),
    child: Container(
      // height: 115,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: isWeb == true
              ? BorderRadius.circular(5)
              : BorderRadius.circular(10),
          color: white1),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 1.5,
              child: Text(
                jobName,
                style: bluetxt,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),

            isWeb == false
                ? Row(
                  children: [
                    Text(
                        postedDate,
                        style: Wgrey,
                      ),
                    const Spacer(),
                    status == "Pending"
                        ? Container(
                      height: 25,
                      width: 100,
                      // margin: EdgeInsets.only(top: 15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: containerColor),
                      child: Center(
                          child: Text(
                            status,
                            style: statusStyle,
                          )),
                    )
                        : status == "Expired"
                        ? Container(
                      height: 25,
                      width: 100,
                      // margin: EdgeInsets.only(top: 15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: containerColor),
                      child: Center(
                          child: Text(
                            status,
                            style: statusStyle,
                          )),
                    )
                        : status == "Active"
                        ? Padding(
                      padding: const EdgeInsets.only(top: 5,bottom: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.person,color: Colors.grey,),
                          Text(
                            noOfCandidates,
                            style: noOfCandidatesStyle,
                          ),
                        ],
                      ),
                    )
                        : Container(),
                  ],
                )
                : Container(),
          ],
        ),
      ),
    ),
  );
}
