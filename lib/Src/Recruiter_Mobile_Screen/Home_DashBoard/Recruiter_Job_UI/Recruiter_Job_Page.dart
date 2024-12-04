import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:getifyjobs/Models/CampusListModel.dart';
import 'package:getifyjobs/Models/DirectListModel.dart';
import 'package:getifyjobs/Src/Common_Widgets/Common_Button.dart';
import 'package:getifyjobs/Src/Common_Widgets/Common_List.dart';
import 'package:getifyjobs/Src/Common_Widgets/Custom_App_Bar.dart';
import 'package:getifyjobs/Src/Common_Widgets/Image_Path.dart';
import 'package:getifyjobs/Src/Common_Widgets/Text_Form_Field.dart';
import 'package:getifyjobs/Src/Recruiter_Mobile_Screen/Home_DashBoard/Notification_Page.dart';
import 'package:getifyjobs/Src/Recruiter_Mobile_Screen/Home_DashBoard/Recruiter_Job_UI/Recruiter_Campus_Job_Ui/Recruiter_College_Detail_Screen.dart';
import 'package:getifyjobs/Src/Recruiter_Mobile_Screen/Recruiter_Request_Call%20_Ui/Recruiter_Request_Call_Screen.dart';
import 'package:getifyjobs/Src/utilits/ApiService.dart';
import 'package:getifyjobs/Src/utilits/Common_Colors.dart';
import 'package:getifyjobs/Src/utilits/ConstantsApi.dart';
import 'package:getifyjobs/Src/utilits/Generic.dart';
import 'package:getifyjobs/Src/utilits/Text_Style.dart';
import 'package:intl/intl.dart';

import 'Recruiter_Campus_Job_Ui/Recruiter_Campus_Job_List_Page.dart';
import 'Recruiter_Create_Job.dart';
import 'Recruiter_Direct_Job_Ui/Recuiter_JobDetail_Page.dart';

class Recuiter_Jobs_Screen extends ConsumerStatefulWidget {
  const Recuiter_Jobs_Screen({super.key});

  @override
  ConsumerState<Recuiter_Jobs_Screen> createState() => _RecuiterJobsState();
}

class _RecuiterJobsState extends ConsumerState<Recuiter_Jobs_Screen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  ScrollController _scrollController = ScrollController();
  ScrollController _campusController = ScrollController();
  int totalCount = 0;
  int campustotalCount = 0;
  int page = 1;
  int campuspage = 1;
  bool isLoading = false;
  bool? isDirectList;
  bool? isCampusList;
  String? experienceVal;
  List<String> experienceOtion = [
    "Fresher",
    "Experienced",
  ];
  var formData = FormData();

  @override
  void initState() {
    super.initState();
    isDirectList = false;
    isCampusList = false;
    _scrollController.addListener(_scrollListener);
    _campusController.addListener(_campusScrollListener);

    _tabController = TabController(length: 2, vsync: this);

    getRecruiter_Id();
  }

  getRecruiter_Id() async {
    formData = FormData.fromMap({
      'recruiter_id': await getRecruiterId(),
      "no_of_records": "10",
      "page_no": page,
    });

    DirectResponse(true);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  _scrollListener() {
    print("object");
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange &&
        totalCount != tempDirectItemList?.length) {
      // reached the bottom
      SingleTon().isLoading = false;
      page += 1;
      DirectResponse(false);
    }
  }

  _campusScrollListener() {
    print("object");
    if (_campusController.offset >=
            _campusController.position.maxScrollExtent &&
        !_campusController.position.outOfRange &&
        campustotalCount != tempCampusResponseData?.length) {
      // reached the bottom
      SingleTon().isLoading = false;
      campuspage += 1;
      CampusResponse();
    }
  }

  List<DirectListItems>? directItemList = [];
  List<CampusListItems>? campusResponseData = [];

  List<DirectListItems>? tempDirectItemList = [];
  List<CampusListItems>? tempCampusResponseData = [];

  bool isSearching = false;

  int switchIndex = 0;

  RegExp onlyText = RegExp(r'^[a-zA-Z ]+$');
  TextEditingController _From = TextEditingController();
  TextEditingController _salary = TextEditingController();
  TextEditingController _location = TextEditingController();
  TextEditingController _jobTitle = TextEditingController();
  TextEditingController _To = TextEditingController();
  TextEditingController _Collegegname = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white2,
      appBar: Custom_AppBar(
        isUsed: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Recruiter_Request_Call_Screen()));
              },
              icon: Icon(
                Icons.call_outlined,
                size: 25,
              )),
          Padding(
            padding: const EdgeInsets.only(right: 20, left: 15),
            child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NotificationScreen()),
                  );
                },
                child: ImgPathSvg("bellalert.svg")),
          ),
        ],
        isLogoUsed: false,
        title: '',
        isTitleUsed: true,
      ),
      floatingActionButton: switchIndex == 1
          ? null
          : Floating_Button(context, onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CreateJob(
                            isEdit: false,
                            Job_Id: '',
                            DirectJobDetailResponseData: null,
                            isClone: false,
                          ))).then((value) {
                directItemList = [];
                tempDirectItemList = [];
                campusResponseData = [];
                tempCampusResponseData = [];
                ref.refresh(DirectResponse(true));
              });
            }),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  right: 20, left: 20, top: 20, bottom: 20),
              child: textFormFieldSearchBar(
                  MultifilteronTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                          InterviewSchedulePopup(context),
                    );
                  },
                  keyboardtype: TextInputType.text,
                  hintText: "Search ...",
                  Controller: null,
                  validating: null,
                  onChanged: (value) {
                    setState(() {
                      if (switchIndex == 0) {
                        if (value != "" && tempDirectItemList != []) {
                          isSearching = true;
                          directItemList = tempDirectItemList!
                              .where((job) =>
                                  job.jobTitle!.toLowerCase().contains(value))
                              .toList();
                        } else {
                          directItemList = tempDirectItemList;
                          isSearching = false;
                        }
                      } else {
                        if (value != "" && tempCampusResponseData != []) {
                          isSearching = true;
                          campusResponseData = tempCampusResponseData!
                              .where((job) =>
                                  job.name!.toLowerCase().contains(value))
                              .toList();
                        } else {
                          campusResponseData = tempCampusResponseData;
                          isSearching = false;
                        }
                      }
                    });
                  }),
            ),
            Container(
              color: white1,
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: TabBar(
                onTap: (index) async {
                  if (index == 0) {
                    switchIndex = index;
                    formData = FormData.fromMap({
                      'recruiter_id': await getRecruiterId(),
                      "no_of_records": "10",
                      "page_no": 1,
                    });
                    DirectResponse(true);
                  } else if (index == 1) {
                    switchIndex = index;
                    campusResponseData = [];
                    tempCampusResponseData = [];
                    formData = FormData.fromMap({
                      'recruiter_id': await getRecruiterId(),
                      "no_of_records": "10",
                      "page_no": 1,
                    });
                    CampusResponse();
                  } else if (index == 2) {}
                },
                controller: _tabController,
                labelColor: white1,
                labelStyle: TabT,
                indicator: BoxDecoration(color: blue1),
                indicatorColor: grey4,
                unselectedLabelColor: grey4,
                indicatorPadding: EdgeInsets.zero,
                indicatorSize: TabBarIndicatorSize.tab,
                tabs: [
                  Container(
                    width: MediaQuery.of(context).size.width /
                        2, // Equal width for each tab
                    child: Tab(
                      text: 'Direct',
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width /
                        2, // Equal width for each tab
                    child: Tab(
                      text: 'Campus',
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  //DIRECT
                  isDirectList == true
                      ? Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: _jobsList(
                              _scrollController, directItemList, totalCount,
                              onValue: (value) =>
                                  ref.refresh(DirectResponse(true))),
                        )
                      : Center(
                          child: NoDataMobileWidget(
                              content: "Unlock New Possibilities")),

                  //CAMPUS
                  isCampusList == true
                      ? SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 50, top: 10),
                            child: Consumer(
                              builder: (BuildContext context, WidgetRef ref,
                                  Widget? child) {
                                return _campusList(
                                    _campusController, campustotalCount);
                              },
                            ),
                          ),
                        )
                      : Center(
                          child: NoDataMobileWidget(
                              content: "Unlock New Possibilities")),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

//CAMPUS LIST
  CampusResponse() async {
    final campusListApiService = ApiService(ref.read(dioProvider));

    final campusListResponse = await campusListApiService.post<CampusListModel>(
        context, ConstantApi.campusListUrl, formData);
    if (campusListResponse.status == true) {
      setState(() {
        isCampusList = true;
        campusResponseData?.addAll(campusListResponse.data?.items ?? []);
        tempCampusResponseData?.addAll(campusListResponse.data?.items ?? []);
        // campusResponseData = campusListResponse.data;
        campustotalCount = campusListResponse?.data?.items?.length ?? 0;
        SingleTon().isLoading = true;
      });
      print(
          'CAMPUS ID  : ${campusListResponse.data?.items?[0].campusId ?? ""}');
    } else {
      ShowToastMessage(campusListResponse.message ?? "");
      print("ERROR");
      setState(() {
        isCampusList = false;
      });
    }
  }

  Widget _campusList(ScrollController _campusController, int campustotalCount) {
    return ListView.builder(
        controller: _campusController,
        itemCount: campusResponseData?.length ?? 0,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          if (index <= (tempCampusResponseData?.length ?? 0)) {
            return InkWell(
                onTap: () {
                  campusResponseData?[index].status == "Assigned"
                      ? Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Recuiter_Campus_Job_List_Screen(
                                    campusId:
                                        campusResponseData?[index].campusId ??
                                            "",
                                  ))).then((value) {
                          campusResponseData = [];
                          tempCampusResponseData = [];
                          ref.refresh(CampusResponse());
                        })
                      : Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Recruiter_College_Detail_Screen(
                                    campusId:
                                        campusResponseData?[index].campusId ??
                                            "",
                                    isEdit: false, Status:campusResponseData?[index].status,
                                  ))).then((value) {
                          campusResponseData = [];
                          tempCampusResponseData = [];
                          ref.refresh(CampusResponse());
                        });
                },
                child: CampusList(
                    iscampTag: campusResponseData?[index].status ?? "",
                    collegeName: campusResponseData?[index].name ?? "",
                    collegeLogo: campusResponseData?[index].logo ?? "",
                    collegeLocation:
                        campusResponseData?[index].location ?? ""));
          } else {
            if ((tempCampusResponseData?.length ?? 0) != 0 &&
                campustotalCount != (tempCampusResponseData?.length ?? 0)) {
              return buildLoadingIndicator();
            }
          }
        });
  }

//DIRECT LIST
  DirectResponse(bool dataReset) async {
    if (dataReset == true) {
      directItemList = [];
      tempDirectItemList = [];
    }

    final directListApiService = ApiService(ref.read(dioProvider));

    final directListResponse = await directListApiService.post<DirectListModel>(
        context, ConstantApi.directListUrl, formData);
    if (directListResponse.status == true) {
      setState(() {
        isDirectList = true;
        directItemList?.addAll(directListResponse.data?.items ?? []);
        tempDirectItemList?.addAll(directListResponse.data?.items ?? []);

        totalCount = directListResponse.data?.totalItems ?? 0;
        print("DIRECT LIST RESPONSE ${directItemList?[0].jobId ?? ""}");
        SingleTon().isLoading = true;
      });
    } else {
      ShowToastMessage(directListResponse.message ?? "");
      print("ERROR");
      setState(() {
        isDirectList = false;
      });
    }
  }

  Widget _jobsList(ScrollController _scrollController,
      List<DirectListItems>? directResponseData, int totalCount,
      {required Function(dynamic) onValue}) {
    return ListView.builder(
        controller: _scrollController,
        itemCount: isSearching == true
            ? (directResponseData?.length ?? 0)
            : ((directResponseData?.length ?? 0) + 1),
        shrinkWrap: true,
        // scrollDirection: Axis.vertical,
        physics: const AlwaysScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          if (index <= ((tempDirectItemList?.length ?? 0) - 1)) {
            return InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Recruiter_JobDetail_Page(
                              job_Id: directResponseData?[index].jobId ?? "",
                              appliedCount:
                                  directResponseData?[index].appliedCandidate ??
                                      0,
                              current_status:
                                  directResponseData?[index].current_status ??
                                      "",
                            ))).then(onValue);
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: NoOfCandidatesSection(context,
                    jobName: directResponseData?[index].jobTitle ?? "",
                    noOfCandidates:
                        "${directResponseData?[index].appliedCandidate ?? 0}",
                    postedDate: directResponseData?[index].createdDate ?? "",
                    isWeb: false,
                    status: directResponseData?[index].job_status ?? ""),
              ),
            );
          } else {
            if ((tempDirectItemList?.length ?? 0) != 0 &&
                totalCount != (tempDirectItemList?.length ?? 0)) {
              return buildLoadingIndicator();
            }
          }
          return null;
        });
  }

  Widget InterviewSchedulePopup(
    BuildContext context,
  ) {
    return Container(
      child: AlertDialog(
        surfaceTintColor: white1,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            switchIndex == 1
                ? Text(
                    "Multiple selection of ${"College Name, Location, Date etc"}",
                    style: Wbalck1,
                    textAlign: TextAlign.center,
                  )
                : Text(
                    "Multiple selection of ${"Job Title, Location, Date, Expected Salary etc"}",
                    style: Wbalck1,
                    textAlign: TextAlign.center,
                  ),

            switchIndex == 0
                ? Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                    ),
                    child: textFormField(
                      hintText: 'Job Title',
                      keyboardtype: TextInputType.text,
                      inputFormatters: null,
                      Controller: _jobTitle,
                      focusNode: null,
                      validating: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please Enter Job Title";
                        } else if (!onlyText.hasMatch(value)) {
                          return "(Special Characters are Not Allowed)";
                        }
                        return null;
                      },
                      onChanged: null,
                    ),
                  )
                : Container(),

            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: textFormField(
                hintText: 'Location',
                keyboardtype: TextInputType.text,
                inputFormatters: null,
                Controller: _location,
                focusNode: null,
                validating: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please Enter Location";
                  } else if (!onlyText.hasMatch(value)) {
                    return "(Special Characters are Not Allowed)";
                  }
                  return null;
                },
                onChanged: null,
              ),
            ),

            switchIndex == 0
                ? Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      children: [
                        Container(
                          width: MediaQuery.sizeOf(context).width / 3.2,
                          child: TextFieldDatePicker(
                              Controller: _From,
                              onChanged: (value) {},
                              validating: (value) {
                                if (value!.isEmpty) {
                                  return 'Please select  Date';
                                } else {
                                  return null;
                                }
                              },
                              onTap: () async {
                                FocusScope.of(context).unfocus();
                                DateTime? pickdate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1980),
                                    lastDate: DateTime(2050));
                                if (pickdate != null) {
                                  String formatdate = DateFormat("yyyy-MM-dd")
                                      .format(pickdate!);
                                  if (mounted) {
                                    setState(() {
                                      _From.text = formatdate;
                                      print(_From.text);
                                    });
                                  }
                                }
                              },
                              hintText: 'Form',
                              isDownArrow: false),
                        ),
                        const Spacer(),
                        Container(
                          width: MediaQuery.sizeOf(context).width / 3.2,
                          child: TextFieldDatePicker(
                              Controller: _To,
                              onChanged: (value) {},
                              validating: (value) {
                                if (value!.isEmpty) {
                                  return 'Please select  Date';
                                } else {
                                  return null;
                                }
                              },
                              onTap: () async {
                                FocusScope.of(context).unfocus();
                                DateTime? pickdate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1980),
                                    lastDate: DateTime(2050));
                                if (pickdate != null) {
                                  String formatdate = DateFormat("yyyy-MM-dd")
                                      .format(pickdate!);
                                  if (mounted) {
                                    setState(() {
                                      _To.text = formatdate;
                                      print(_To.text);
                                    });
                                  }
                                }
                              },
                              hintText: 'To',
                              isDownArrow: false),
                        ),
                      ],
                    ),
                  )
                : Container(),

            switchIndex == 0
                ? Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: textFormField(
                      hintText: 'Expected Salary',
                      keyboardtype: TextInputType.text,
                      inputFormatters: null,
                      Controller: _salary,
                      focusNode: null,
                      validating: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please Enter Expected Salary";
                        } else if (!onlyText.hasMatch(value)) {
                          return "(Special Characters are Not Allowed)";
                        }
                        return null;
                      },
                      onChanged: null,
                    ),
                  )
                : Container(),

            switchIndex == 1
                ? Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: textFormField(
                      hintText: 'College Name',
                      keyboardtype: TextInputType.text,
                      inputFormatters: null,
                      Controller: _Collegegname,
                      focusNode: null,
                      validating: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please Enter College Name";
                        } else if (!onlyText.hasMatch(value)) {
                          return "(Special Characters are Not Allowed)";
                        }
                        return null;
                      },
                      onChanged: null,
                    ),
                  )
                : Container(),

            switchIndex == 1
                ? Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Container(
                      child: TextFieldDatePicker(
                          Controller: _From,
                          onChanged: (value) {},
                          validating: (value) {
                            if (value!.isEmpty) {
                              return 'Please select  Date';
                            } else {
                              return null;
                            }
                          },
                          onTap: () async {
                            FocusScope.of(context).unfocus();
                            DateTime? pickdate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1980),
                                lastDate: DateTime(2050));
                            if (pickdate != null) {
                              String formatdate =
                                  DateFormat("yyyy-MM-dd").format(pickdate!);
                              if (mounted) {
                                setState(() {
                                  _From.text = formatdate;
                                  print(_From.text);
                                });
                              }
                            }
                          },
                          hintText: 'Form',
                          isDownArrow: false),
                    ),
                  )
                : Container(),

            switchIndex == 0
                ? Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: dropDownField(context,
                        hintText: "Select your Preference",
                        value: experienceVal,
                        listValue: experienceOtion,
                        onChanged: (String? newValue) {
                      setState(() {
                        experienceVal = newValue;
                      });
                    }, validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please Add Experience Type";
                      }
                      if (value == null) {
                        return "Please Add Experience Type";
                      }
                      return null;
                    }),
                  )
                : Container(),

            // Padding(
            //   padding: const EdgeInsets.only(top: 10),
            //   child: Container(
            //     width: MediaQuery.sizeOf(context).width,
            //     child: TextFieldDatePicker(
            //         Controller: _From,
            //         onChanged: (value) {},
            //         validating: (value) {
            //           if (value!.isEmpty) {
            //             return 'Please select  Date';
            //           } else {
            //             return null;
            //           }
            //         },
            //         onTap: () async {
            //           FocusScope.of(context).unfocus();
            //           DateTime? pickdate = await showDatePicker(
            //               context: context,
            //               initialDate: DateTime.now(),
            //               firstDate: DateTime(1980),
            //               lastDate: DateTime(2050));
            //           if (pickdate != null) {
            //             String formatdate =
            //             DateFormat("yyyy-MM-dd").format(pickdate!);
            //             if (mounted) {
            //               setState(() {
            //                 _From.text = formatdate;
            //                 print(_From.text);
            //               });
            //             }
            //           }
            //         },
            //         hintText: 'Form',
            //         isDownArrow: false),
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width / 3.5,
                      child: PopButton(context, "Cancel", () {
                        Navigator.pop(context);
                      })),
                  Container(
                      width: MediaQuery.of(context).size.width / 3.5,
                      child: PopButton(context, "Okay", () async {
                        if (switchIndex == 0) {
                          formData = FormData.fromMap({
                            'recruiter_id': await getRecruiterId(),
                            "no_of_records": "10",
                            "page_no": 1,
                            "job_title": _jobTitle.text,
                            "location": _location.text,
                            "from_date": _From.text,
                            "to_date": _To.text,
                            "experience": experienceVal,
                            "salary_from": _salary.text
                          });

                          DirectResponse(true);
                        } else if (switchIndex == 1) {
                          campusResponseData = [];
                          tempCampusResponseData = [];
                          formData = FormData.fromMap({
                            'recruiter_id': await getRecruiterId(),
                            "no_of_records": "10",
                            "page_no": 1,
                            "name": _Collegegname.text,
                            "location": _location.text,
                            "recruitment_date": _From.text,
                          });
                          CampusResponse();
                        }
                        Navigator.pop(context);

                        // directItemList = [];
                        // tempDirectItemList = [];
                        //_visibleItemCount = 0;

                        // directJobListResponse(
                        //     JobT: _jobTitle.text,
                        //     location: _location.text,
                        //     Fdate: _From.text,
                        //     Tdate: _To.text,
                        //     ExpT: _careerStatus.text,
                        //     CompanyT: _CompanyName.text,
                        //     isFilter: true,
                        //     SalaryT: _SalaryRange.text);
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
