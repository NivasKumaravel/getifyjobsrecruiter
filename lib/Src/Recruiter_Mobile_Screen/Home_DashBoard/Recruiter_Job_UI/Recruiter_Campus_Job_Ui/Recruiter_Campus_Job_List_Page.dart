import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:getifyjobs/Models/CampusJobListModel.dart';
import 'package:getifyjobs/Src/Common_Widgets/Common_Button.dart';
import 'package:getifyjobs/Src/Common_Widgets/Common_List.dart';
import 'package:getifyjobs/Src/Common_Widgets/Custom_App_Bar.dart';
import 'package:getifyjobs/Src/Common_Widgets/Image_Path.dart';
import 'package:getifyjobs/Src/Recruiter_Mobile_Screen/Home_DashBoard/Recruiter_Job_UI/Bulk_Job.dart';
import 'package:getifyjobs/Src/Recruiter_Mobile_Screen/Home_DashBoard/Recruiter_Job_UI/Recruiter_Campus_Job_Ui/Recruiter_Campus_Job_Detail_Screen.dart';
import 'package:getifyjobs/Src/Recruiter_Mobile_Screen/Home_DashBoard/Recruiter_Job_UI/Recruiter_Campus_Job_Ui/Recruiter_College_Detail_Screen.dart';
import 'package:getifyjobs/Src/utilits/ApiService.dart';
import 'package:getifyjobs/Src/utilits/Common_Colors.dart';
import 'package:getifyjobs/Src/utilits/ConstantsApi.dart';
import 'package:getifyjobs/Src/utilits/Generic.dart';
import 'package:getifyjobs/Src/utilits/Text_Style.dart';

class Recuiter_Campus_Job_List_Screen extends ConsumerStatefulWidget {
  String? campusId;

  Recuiter_Campus_Job_List_Screen({super.key, required this.campusId});

  @override
  ConsumerState<Recuiter_Campus_Job_List_Screen> createState() =>
      _Recuiter_Campus_Job_List_ScreenState();
}

class _Recuiter_Campus_Job_List_ScreenState
    extends ConsumerState<Recuiter_Campus_Job_List_Screen> {
  CampusJobListData? CampusJobListResponseData;
  int totalCount = 0;
  bool isLoading = false;
  bool? campusJobList;
  int page = 1;
  ScrollController _listControler = ScrollController();
  List<Jobs>? listJobList;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _listControler.addListener(listScrollListener);
    CampusJobListResponse();
    campusJobList = true;
  }

  listScrollListener() {
    print("object");
    if (_listControler.offset >= _listControler.position.maxScrollExtent &&
        !_listControler.position.outOfRange &&
        totalCount != listJobList?.length) {
      // reached the bottom
      SingleTon().isLoading = false;
      page += 1;
      CampusJobListResponse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white2,
      appBar: Custom_AppBar(
        isUsed: false,
        actions: [],
        isLogoUsed: true,
        title: '',
        isTitleUsed: true,
      ),
      floatingActionButton: Floating_Button(context, onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BulkJobs(
                      job_Id: "",
                      campus_Id: widget.campusId,
                      campusJobDetailResponseData: null,
                      isEditBulk: false,
                    ))).then((value) => ref.refresh(CampusJobListResponse()));
      }),
      body:
          //campusJobList == true ?
          Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _campusList(context, CampusJobListResponseData,
              campusid: widget.campusId),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Text(
              "Campus Drive Date: 09:00 AM, ${CampusJobListResponseData?.items?.recruitmentDate ?? ""}",
              style: dateT,
            ),
          ),
          campusJobList == false
              ? Padding(
                  padding: const EdgeInsets.only(top: 70),
                  child: Center(
                      child: NoDataWidget(content: "Post your first job")),
                )
              : _jobsList(CampusJobListResponseData),
        ],
      ),
      //: Center(child: NoDataWidget(content: "Post your first job"))
    );
  }

  //RESPONSE
  CampusJobListResponse() async {
    final campusJobListApiService = ApiService(ref.read(dioProvider));
    var formData = FormData.fromMap({
      'recruiter_id': await getRecruiterId(),
      'campus_id': widget.campusId,
      'no_of_records': '10',
      'page_no': page
    });
    final campusJobListApiResponse =
        await campusJobListApiService.post<CampusJobListModel>(
            context, ConstantApi.campusJobListUrl, formData);
    if (campusJobListApiResponse?.status == true) {
      print("SUCESS");
      setState(() {
        // listJobList?.addAll(CampusJobListResponseData?.items?.jobs ?? []);
        // totalCount = CampusJobListResponseData?.totalItems ?? 0;
        campusJobList = true;
        CampusJobListResponseData = campusJobListApiResponse.data;
      });
      print(
          'DATE : ${CampusJobListResponseData?.items?.recruitmentDate ?? ""}');
    } else {
      print("ERROR");
      setState(() {
        campusJobList = false;
      });
    }
  }

  Widget _jobsList(CampusJobListData? campusJobListResponseData) {
    return ListView.builder(
        itemCount: campusJobListResponseData?.items?.jobs?.length ?? 0,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        // physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Recruiter_Campus_Job_Detail_Screen(
                            jobId: campusJobListResponseData
                                    ?.items?.jobs?[index].jobId ??
                                "",
                            campusId:
                                campusJobListResponseData?.items?.campusId ??
                                    "",
                          ))).then(
                  (value) => ref.refresh(CampusJobListResponse()));
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: NoOfCandidatesSection(context,
                  jobName:
                      campusJobListResponseData?.items?.jobs?[index].jobTitle ??
                          "",
                  noOfCandidates:
                      "${campusJobListResponseData?.items?.jobs?[index].appliedCandidate ?? 0}",
                  postedDate: campusJobListResponseData
                          ?.items?.jobs?[index].createdDate ??
                      "",
                  isWeb: false,
                  status: "Active"),
            ),
          );
        });
  }
}

Widget _campusList(context, CampusJobListData? campusJobListResponseData,
    {required campusid}) {
  return Column(children: [
    InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Recruiter_College_Detail_Screen(
                    campusId: campusid,
                    isEdit: true,
                    Status: '',
                  )),
        );
      },
      child: Container(
        child: CampusList(
            iscampTag: 'Assigned',
            collegeName: campusJobListResponseData?.items?.name ?? "",
            collegeLogo: campusJobListResponseData?.items?.logo ?? "",
            collegeLocation: campusJobListResponseData?.items?.location ?? ""),
      ),
    )
  ]);
}
