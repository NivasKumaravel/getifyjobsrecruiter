import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:getifyjobs/Models/ApplyModel.dart';
import 'package:getifyjobs/Models/CampusDetailModel.dart';
import 'package:getifyjobs/Src/Common_Widgets/Common_Button.dart';
import 'package:getifyjobs/Src/Common_Widgets/Custom_App_Bar.dart';
import 'package:getifyjobs/Src/Common_Widgets/Image_Path.dart';
import 'package:getifyjobs/Src/Common_Widgets/Text_Form_Field.dart';
import 'package:getifyjobs/Src/Recruiter_Mobile_Screen/Home_DashBoard/Recruiter_Job_UI/Recruiter_Campus_Job_Ui/Recruiter_Campus_Job_List_Page.dart';
import 'package:getifyjobs/Src/utilits/ApiService.dart';
import 'package:getifyjobs/Src/utilits/Common_Colors.dart';
import 'package:getifyjobs/Src/utilits/ConstantsApi.dart';
import 'package:getifyjobs/Src/utilits/Generic.dart';
import 'package:getifyjobs/Src/utilits/Text_Style.dart';

class Recruiter_College_Detail_Screen extends ConsumerStatefulWidget {
  String? campusId;

  Recruiter_College_Detail_Screen({super.key, required this.campusId});

  @override
  ConsumerState<Recruiter_College_Detail_Screen> createState() =>
      _Recruiter_College_Detail_ScreenState();
}

class _Recruiter_College_Detail_ScreenState
    extends ConsumerState<Recruiter_College_Detail_Screen> {
  void initState() {
    // TODO: implement initState
    super.initState();
    CampusDetailResponse();
    print("CAMPUS NAME ${campusResponseData?.name ?? ''}");
    campusDetail = true;
  }
  CampusData? campusResponseData;
  bool? campusDetail;

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
      body:
      campusDetail == true?
      SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              buildCompanyInfoRow(campusResponseData?.logo ?? "",
                  campusResponseData?.name ?? "", pdfT, 39, 39, isMapLogo: false),

              const SizedBox(height: 12),

              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: buildCompanyInfoRow(
                    "map-pin (1).png", campusResponseData?.location ?? "", posttxt, 16, 16, isMapLogo: true),
              ),
              SizedBox(
                height: 30,
              ),
              textWithheader(
                  headertxt: "About",
                  subtxt:
                      campusResponseData?.about ?? ""),
              textWithheader(
                  headertxt: "Preferred Campus drive",
                  subtxt:
                  campusResponseData?.campusDrive ?? ""),
              textWithheader(
                  headertxt: "Total Companies Allowed",
                  subtxt:
                  campusResponseData?.totalCompanies ?? ""),
              textWithheader(
                  headertxt: "Campus Drive Date", subtxt: campusResponseData?.recruitmentDate ?? ""),
              textWithheader(
                  headertxt: "Eligible industries", subtxt: campusResponseData?.industries ?? ""),
              campusResponseData?.preferedDepartment == null?Container(): textWithheader(
                  headertxt: "Department’s prefered", subtxt: campusResponseData?.preferedDepartment ?? ""),
              textWithheader(
                  headertxt: "Food facility for off campus students",
                  subtxt: campusResponseData?.foodFacility ?? ""),
              textWithheader(
                  headertxt: "Volunteers allocated by college",
                  subtxt: "Staffs: ${campusResponseData?.volunteerStaffs ?? ""}\nStudents: ${campusResponseData?.volunteerStudents ?? ""}"),
              textWithheader(
                  headertxt: "Campus Held at", subtxt: campusResponseData?.campusHeldAt ?? ''),


              Padding(
                padding: const EdgeInsets.only(bottom: 20, top: 20),
                child: Center(
                  child: Container(
                    width: 250,
                    child: CommonElevatedButton(context, "Apply", () {
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
      ):NoDataMobileWidget(content: "Unlock New Possibilities"),
    );
  }

  Widget confirmationPopup(BuildContext context) {
    return AlertDialog(
      surfaceTintColor: white1,
      content: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            buildCompanyInfoRow(campusResponseData?.logo ?? '',
                campusResponseData?.name ?? '', dateT, 40, 40, isMapLogo: false),
            buildCompanyInfoRow(
                "map-pin (1).png", campusResponseData?.location ?? "", Wgrey, 19, 19, isMapLogo: true),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Are you sure you want to Apply for Campus?",
                style: companyT,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width / 3.5,
                      child: CommonElevatedButton(context, "Yes", () async{
                        final applyCampusApiService = ApiService(ref.read(dioProvider));
                        var formData = FormData.fromMap({
                          "campus_id":widget.campusId,
                          "recruiter_id":await getRecruiterId(),
                        });
                        final ApplyCampusResponse = await applyCampusApiService.post<ApplyModel>(context,ConstantApi.applyCampusUrl, formData);
                        if(ApplyCampusResponse.status == true){
                          Navigator.pop(context);
                          ShowToastMessage(ApplyCampusResponse?.message ?? "");
                        }else{
                          ShowToastMessage(ApplyCampusResponse?.message ?? "");
                          print("ERROR");
                        }
                      })),
                  Container(
                      width: MediaQuery.of(context).size.width / 3.5,
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

  CampusDetailResponse() async{
    final campusDetailApiService = ApiService(ref.read(dioProvider));
    var formData = FormData.fromMap({
      "campus_id":widget.campusId
    });

    final campusDetailResponse = await campusDetailApiService.post<CampusDetailModel>(context,ConstantApi.campusDetailUrl, formData);
   if(campusDetailResponse.status==true){
     setState(() {
       campusDetail=true;
       campusResponseData = campusDetailResponse.data;
     });
   }else{
     print("ERROR");
   }
    print("Campus DETAIL ID : ${campusResponseData?.campusId ?? ""}");
    print("Campus ID : ${widget.campusId}");
  }
}
