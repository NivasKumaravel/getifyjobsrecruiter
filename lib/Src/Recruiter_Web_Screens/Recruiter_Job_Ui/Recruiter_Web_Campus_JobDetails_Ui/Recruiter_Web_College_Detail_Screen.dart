import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:getifyjobs/Models/ApplyModel.dart';
import 'package:getifyjobs/Models/CampusDetailModel.dart';
import 'package:getifyjobs/Src/Common_Widgets/Common_Button.dart';
import 'package:getifyjobs/Src/Common_Widgets/Custom_App_Bar.dart';
import 'package:getifyjobs/Src/Common_Widgets/Text_Form_Field.dart';
import 'package:getifyjobs/Src/Recruiter_Web_Screens/Recruiter_Job_Ui/Recruiter_Web_Campus_JobDetails_Ui/Recruiter_Web_Campus_JobDetail_Page.dart';
import 'package:getifyjobs/Src/Recruiter_Web_Screens/Recruiter_Job_Ui/Recruiter_Web_Campus_JobDetails_Ui/Recruiter_Web_Campus_JobList_Page.dart';
import 'package:getifyjobs/Src/utilits/ApiService.dart';
import 'package:getifyjobs/Src/utilits/Common_Colors.dart';
import 'package:getifyjobs/Src/utilits/ConstantsApi.dart';
import 'package:getifyjobs/Src/utilits/Generic.dart';
import 'package:getifyjobs/Src/utilits/Text_Style.dart';

class Recruiter_Web_College_Detail_Screen extends ConsumerStatefulWidget {
  String? campus_id;

  Recruiter_Web_College_Detail_Screen({super.key, required this.campus_id});

  @override
  ConsumerState<Recruiter_Web_College_Detail_Screen> createState() =>
      _Recruiter_Web_College_Detail_ScreenState();
}

class _Recruiter_Web_College_Detail_ScreenState
    extends ConsumerState<Recruiter_Web_College_Detail_Screen> {
  void initState() {
    // TODO: implement initState
    super.initState();
    CampusDetailResponse();
    print("CAMPUS NAME ${campusResponseData?.name ?? ''}");
  }

  CampusData? campusResponseData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white2,
      appBar: Custom_AppBar(
        title: "",
        isUsed: true,
        actions: [],
        isLogoUsed: true,
        isTitleUsed: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: 150, right: 150),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: white1,
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, bottom: 10, top: 10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildCompanyInfoRow(campusResponseData?.logo ?? "",
                          campusResponseData?.name ?? "", pdfT, 39, 39, isMapLogo: false),
                      buildCompanyInfoRow(
                          "map-pin (1).png", campusResponseData?.location ?? "", posttxt,
                          16, 16, isMapLogo: true),
                    ]
                ),
              ),
            ),
            Container(
              margin:
              EdgeInsets.only(top: 25, left: 150, right: 150),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), color: white1),
              child: Padding(
                padding: const EdgeInsets.only(
                    right: 20, left: 20, top: 10, bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    textWithheader(headertxt: "About",
                        subtxt: campusResponseData?.about ?? ""),
                    textWithheader(headertxt: "Campus Drive Date",
                        subtxt:campusResponseData?.recruitmentDate ?? ""),
                    textWithheader(
                        headertxt: "Eligible industries", subtxt: campusResponseData?.industries ?? ""),
                    textWithheader(headertxt: "Department’s prefered",
                        subtxt: campusResponseData?.preferedDepartment ?? ""),
                    textWithheader(
                        headertxt: "Food facility for off campus students",
                        subtxt: campusResponseData?.foodFacility ?? ""),
                    textWithheader(headertxt: "Volunteers allocated by college",
                        subtxt: "Staffs: ${campusResponseData?.volunteerStaffs ?? ""}\nStudents: ${campusResponseData?.volunteerStudents ?? ""}"),
                    textWithheader(headertxt: "Campus Held at",
                        subtxt: campusResponseData?.campusHeldAt ?? ''),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(bottom: 50, top: 100),
              child: Center(
                child: Container(
                  width: 350,
                  child: CommonElevatedButton(context, "Apply", () {
                    print("object");
                    showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                          confirmationPopup(context),
                    );
                  }),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  CampusDetailResponse() async {
    final campusDetailApiService = ApiService(ref.read(dioProvider));
    var formData = FormData.fromMap({
      "campus_id": widget.campus_id
    });

    final campusDetailResponse = await campusDetailApiService.post<
        CampusDetailModel>(context, ConstantApi.campusDetailUrl, formData);
    if (campusDetailResponse.status == true) {
      setState(() {
        campusResponseData = campusDetailResponse.data;
      });
    } else {
      print("ERROR");
    }
    print("Campus DETAIL ID : ${campusResponseData?.campusId ?? ""}");
    print("Campus ID : ${widget.campus_id}");
  }

  Widget confirmationPopup(BuildContext context) {
    return AlertDialog(
      surfaceTintColor: white1,
      content: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildCompanyInfoRow(
                campusResponseData?.logo ?? "",
                campusResponseData?.name ?? "",
                dateT,
                40, 40, isMapLogo: false),
            buildCompanyInfoRow(
                "map-pin (1).png",
                campusResponseData?.location ?? "",
                Wgrey,
                16, 16, isMapLogo: true),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Are you sure you want to Apply for Campus?", style: companyT,),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                      width: 260,
                      child: CommonElevatedButton(context, "Yes", () async{
                        final applyCampusApiService = ApiService(ref.read(dioProvider));
                        var formData = FormData.fromMap({
                          "campus_id":widget.campus_id,
                          "recruiter_id":await getRecruiterId(),
                        });
                        final ApplyCampusResponse = await applyCampusApiService.post<ApplyModel>(context,ConstantApi.applyCampusUrl, formData);
                        if(ApplyCampusResponse.status == true){
                          ShowToastMessage(ApplyCampusResponse?.message ?? "");
                          Navigator.pop(context);
                        }else{
                          ShowToastMessage(ApplyCampusResponse?.message ?? "");
                          print("ERROR");
                        }
                      })),
                  SizedBox(width: 25,),
                  Container(
                      width: 260,
                      child: CommonElevatedButton(context, "No", () {
                        Navigator.pop(context);
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
