import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:getifyjobs/Models/CampusJobListModel.dart';
import 'package:getifyjobs/Src/Common_Widgets/Common_List.dart';
import 'package:getifyjobs/Src/Common_Widgets/Custom_App_Bar.dart';
import 'package:getifyjobs/Src/Common_Widgets/Image_Widget.dart';
import 'package:getifyjobs/Src/Recruiter_Web_Screens/Recruiter_Candidate_Profile_WebView_Popup.dart';
import 'package:getifyjobs/Src/Recruiter_Web_Screens/Recruiter_Job_Ui/Recruiter_Web_Bulk_Job.dart';
import 'package:getifyjobs/Src/Recruiter_Web_Screens/Recruiter_Job_Ui/Recruiter_Web_Campus_JobDetails_Ui/Recruiter_Web_Campus_JobDetail_Page.dart';
import 'package:getifyjobs/Src/Recruiter_Web_Screens/Recruiter_Job_Ui/Recruiter_Web_Create_Job.dart';
import 'package:getifyjobs/Src/Recruiter_Web_Screens/Recruiter_Web_Home_Screens/Recruiter_Web_Recent_Applies_Screen.dart';
import 'package:getifyjobs/Src/utilits/ApiService.dart';
import 'package:getifyjobs/Src/utilits/Common_Colors.dart';
import 'package:getifyjobs/Src/utilits/ConstantsApi.dart';
import 'package:getifyjobs/Src/utilits/Generic.dart';
import 'package:getifyjobs/Src/utilits/Text_Style.dart';

class Recruiter_Web_Campus_JobList_Page extends ConsumerStatefulWidget {
  String? campusId;

  Recruiter_Web_Campus_JobList_Page({super.key,required this.campusId});

  @override
  ConsumerState<Recruiter_Web_Campus_JobList_Page> createState() => _Recruiter_Web_Campus_JobList_PageState();
}

class _Recruiter_Web_Campus_JobList_PageState extends ConsumerState<Recruiter_Web_Campus_JobList_Page> {
  CampusJobListData? CampusJobListResponseData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CampusJobListResponse();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white2,
      appBar: Custom_AppBar(isUsed: true, actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: PopupMenuButton(
              surfaceTintColor: white1,
              itemBuilder: (BuildContext context)=>[
                PopupMenuItem(
                    onTap:(){
                      Navigator.push(context, 
                          MaterialPageRoute(builder: (context)=>
                              Recruiter_Web_BulkJob(campus_Id: CampusJobListResponseData?.items?.campusId ?? "", 
                                campusJobDetailResponseData: null, 
                                job_Id: '', 
                                isEditBulk: false,))).then((value) => ref.read(CampusJobListResponse()));
                    },
                    child: Text('Bulk Job',style: refferalCountT,)),
              ],
              child: Text("+Create Job",style: addMoreT,)),
        )
      ], isLogoUsed: true, isTitleUsed: true,title: '',),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // CAMPUS SCREEN
            _campusCollegeList(
              context, isTag: 'Assigned', iscampTag: 'Assigned',
            ),

            //DATE AND TIME
            Container(
              alignment: Alignment.topLeft,
                margin: EdgeInsets.only(top: 40,bottom: 0,left: 20),
                child: Text('Date: 09:00AM, ${CampusJobListResponseData?.items?.recruitmentDate ?? ""}',style: Wbalck4,)),

            //JOB LIST
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: _jobsList(CampusJobListResponseData),
            )
          ],
        ),
      ),
    );
  }
  //CAMPUS COLLEGE LIST WEB
  Widget _campusCollegeList(context,{required String? isTag,
    required String? iscampTag,}){
    return
      Container(
        margin: EdgeInsets.only(top: 15, left: 20, right: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white, // Set the color here
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 15,right: 15,top: 15,bottom: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //COMPANY LOGO
              Container(
                height: 50,width: 50,
                child: buildImage(
                    CampusJobListResponseData?.items?.logo ?? '',
                    border: const Radius.circular(25),
                    fit: BoxFit.cover),
              ),
              //COLLEGE NAME AND LOCATION
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        // width: MediaQuery.of(context).size.width/1.2,
                        child: Text( CampusJobListResponseData?.items?.name ?? '',style: TBlack,maxLines: 2,)),
                    Row(
                      children: [
                        Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              image: DecorationImage(image: AssetImage("lib/assets/map-pin (1).png"),
                                  fit: BoxFit.cover
                              )
                          ),
                        ),
                        Text( CampusJobListResponseData?.items?.location ?? '',style: Homegrey2,)
                      ],
                    ),
                  ],
                ),
              ),
              Spacer(),
              //TAG
              Container(
                // width: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color:  iscampTag == "Applied"
                        ? blue2
                        : iscampTag == "Assigned"
                        ? green3
                        : white1),
                child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, top: 5, bottom: 5),
                      child: Text(
                      iscampTag == "Applied"
                            ? 'Applied'
                            : iscampTag == "Assigned"
                            ? 'Assigned'
                            : '',
                        style: isTag == "Applied"
                            ? appliedT
                            : isTag == "Assigned"
                            ? shortlistedT
                            :  offCampusT,
                      ),
                    )),
              ),
            ],
          ),
        ),
      );
  }
  //RESPONSE
  CampusJobListResponse()async{
    final campusJobListApiService = ApiService(ref.read(dioProvider));
    var formData = FormData.fromMap({
      'recruiter_id':await getRecruiterId(),
      'campus_id':widget.campusId,
      'no_of_records':'1',
      'page_no':'1'
    });
    final campusJobListApiResponse = await campusJobListApiService.post<CampusJobListModel>(context, ConstantApi.campusJobListUrl, formData);
    if(campusJobListApiResponse?.status == true){
      print("SUCESS");
      setState(() {
        CampusJobListResponseData = campusJobListApiResponse.data;
      });
      print('DATE : ${      CampusJobListResponseData?.items?.recruitmentDate ?? ""}');
    }else{
      ShowToastMessage(campusJobListApiResponse.message ?? "");
      print("ERROR");
    }
  }
  //DIRECT JOB LIST SCREEN
  Widget _jobsList(CampusJobListData? campusJobListResponseData){
    return ListView.builder(
        itemCount:  campusJobListResponseData?.items?.jobs?.length ?? 0,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index){
          return InkWell(
            onTap:(){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>  Recruiter_Web_Campus_JobDetail_Page(jobId: campusJobListResponseData?.items?.jobs?[index].jobId ?? "", campusId: widget.campusId,)));
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 20,right: 20),
              child: NoOfCandidatesSection(
                  context,
                  jobName: campusJobListResponseData?.items?.jobs?[index].jobTitle ?? "",
                  noOfCandidates: "${campusJobListResponseData?.items?.jobs?[index].appliedCandidate ?? 0}",
                  postedDate: "Posted: ${campusJobListResponseData?.items?.jobs?[index].createdDate ?? ""}", isWeb: true, status: 'Active'),
            ),
          );
        });
  }

}

