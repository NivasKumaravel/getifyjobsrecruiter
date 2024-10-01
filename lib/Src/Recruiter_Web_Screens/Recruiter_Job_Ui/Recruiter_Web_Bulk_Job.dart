import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:getifyjobs/Models/BulkJobModel.dart';
import 'package:getifyjobs/Models/CampusJobdetailModel.dart';
import 'package:getifyjobs/Models/QualificationModel.dart';
import 'package:getifyjobs/Src/Common_Widgets/Common_Button.dart';
import 'package:getifyjobs/Src/Common_Widgets/Custom_App_Bar.dart';
import 'package:getifyjobs/Src/Common_Widgets/Image_Path.dart';
import 'package:getifyjobs/Src/Common_Widgets/Text_Form_Field.dart';
import 'package:getifyjobs/Src/utilits/ApiService.dart';
import 'package:getifyjobs/Src/utilits/Common_Colors.dart';
import 'package:getifyjobs/Src/utilits/ConstantsApi.dart';
import 'package:getifyjobs/Src/utilits/Generic.dart';
import 'package:getifyjobs/Src/utilits/Text_Style.dart';

class Recruiter_Web_BulkJob extends ConsumerStatefulWidget {
  final bool? isEditBulk;
  final String? job_Id;
  final String? campus_Id;
  CampusJobDetailData? campusJobDetailResponseData;

  Recruiter_Web_BulkJob(
      {super.key,
      required this.campus_Id,
      required this.campusJobDetailResponseData,
      required this.job_Id,
      required this.isEditBulk});

  @override
  ConsumerState<Recruiter_Web_BulkJob> createState() =>
      _Recruiter_Web_BulkJobState();
}

class _Recruiter_Web_BulkJobState extends ConsumerState<Recruiter_Web_BulkJob> {
  String? selectedOption;
  String? selectExpVal;
  String? noOfRoundsOption;
  List<String>? qualificationOption;
  List<String>? specilizationOption;
  final focus2 = FocusNode();
  final focus3 = FocusNode();
  List<QualificationData> qualificationVal = [];
  List<QualificationData> specilizationVal = [];
  final _formKey = GlobalKey<FormState>();
  TextEditingController _Location = TextEditingController();
  TextEditingController _vacancies = TextEditingController();
  TextEditingController _jobDescriptionController = TextEditingController();
  TextEditingController _requriedPercentage = TextEditingController();
  TextEditingController _currentArrear = TextEditingController();
  TextEditingController _historyOfArrear = TextEditingController();
  TextEditingController _specialization = TextEditingController();
  TextEditingController _statutoryBenefitController = TextEditingController();
  TextEditingController _socialBenefitController = TextEditingController();
  TextEditingController _otherBenefitsController = TextEditingController();
  TextEditingController _jobtitle = TextEditingController();
  TextEditingController _salaryFrom = TextEditingController();
  TextEditingController _salaryTo = TextEditingController();
  List<String> noOfRounds = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
  ];

  EditBulkJob() async {
    _jobtitle.text = widget.campusJobDetailResponseData?.jobTitle ?? "";
    _jobDescriptionController.text =
        widget.campusJobDetailResponseData?.jobDescription ?? "";
    // qualificationOption= widget.campusJobDetailResponseData?.qualification ?? "";
    _specialization.text =
        widget.campusJobDetailResponseData?.specialization ?? "";
    _currentArrear.text =
        widget.campusJobDetailResponseData?.currentArrears ?? "";
    _historyOfArrear.text =
        widget.campusJobDetailResponseData?.historyOfArrears ?? "";
    _requriedPercentage.text =
        widget.campusJobDetailResponseData?.requiredPercentage ?? "";
    _Location.text = widget.campusJobDetailResponseData?.location ?? "";
    _salaryFrom.text = widget.campusJobDetailResponseData?.salaryFrom ?? "";
    _salaryTo.text = widget.campusJobDetailResponseData?.salaryTo ?? "";
    _statutoryBenefitController.text =
        widget.campusJobDetailResponseData?.statutoryBenefits ?? "";
    _socialBenefitController.text =
        widget.campusJobDetailResponseData?.socialBenefits ?? "";
    _otherBenefitsController.text =
        widget.campusJobDetailResponseData?.otherBenefits ?? "";
    _vacancies.text = widget.campusJobDetailResponseData?.vacancies ?? "";
    noOfRoundsOption = widget.campusJobDetailResponseData?.rounds ?? "";
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadApicalls();
    });
    widget.isEditBulk == true ? EditBulkJob() : null;
  }

  loadApicalls() async {
    await loadQualificationOptions();
    await loadSpecilizationOptions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: white2,
        appBar: Custom_AppBar(
          isUsed: true,
          actions: null,
          isLogoUsed: true,
          isTitleUsed: true,
          title: "Create Bulk Job",
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(top: 20),
                      height: MediaQuery.of(context).size.height / 1.2,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                          color: white1),
                      child: Center(
                          child: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: ImgPathSvg('create.svg'),
                      )),
                    ),
                  ),
                  Form(
                    key: _formKey, // Associate the form with the GlobalKey
                    child: Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 20, top: 0, right: 20),
                        child: SingleChildScrollView(
                          child: Column(children: [
                            //JOB TITLE
                            Title_Style2(Title: 'Job Title', isStatus: true),
                            textFormField2(
                              hintText: 'Job Title',
                              keyboardtype: TextInputType.text,
                              inputFormatters: null,
                              Controller: _jobtitle,
                              validating: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please Enter Valid ${'Job Title'}";
                                }
                                if (value == null) {
                                  return "Please Enter Valid ${'Job Title'}";
                                }
                                return null;
                              },
                              onChanged: null,
                            ),
                            //JOB DESCRIPTION
                            Title_Style2(
                                Title: 'Job Description', isStatus: true),
                            textfieldDescription2(
                              Controller: _jobDescriptionController,
                              validating: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please Enter ${'Job Description'}";
                                }
                                if (value == null) {
                                  return "Please Enter ${'Job Description'}";
                                }
                                return null;
                              },
                              hint: 'Description',
                            ),
                            //LOCATION AND VACANCIES
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        //Location
                                        Title_Style2(
                                            Title: 'Job  Location',
                                            isStatus: true),
                                        Container(
                                          child: textFormField2(
                                            hintText: 'Location',
                                            keyboardtype: TextInputType.text,
                                            inputFormatters: null,
                                            Controller: _Location,
                                            validating: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return "Please Enter Valid ${'Location'}";
                                              }
                                              if (value == null) {
                                                return "Please Enter Valid ${'Location'}";
                                              }
                                              return null;
                                            },
                                            onChanged: null,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        //No Of Vacancies
                                        Title_Style2(
                                            Title: 'No Of Vacancies',
                                            isStatus: true),
                                        textFormField2(
                                          hintText: 'Vacancy Details',
                                          keyboardtype: TextInputType.number,
                                          inputFormatters: null,
                                          Controller: _vacancies,
                                          validating: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "Please Enter Vacancy Details";
                                            }
                                            if (value == null) {
                                              return "Please Enter Vacancy Details";
                                            }
                                            return null;
                                          },
                                          onChanged: null,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            //SPECIALIZATION AND QUALIFICATION
                            Row(
                              children: [
                                Expanded(
                                    child: Column(
                                  children: [
                                    //Specilatiztion
                                    Title_Style2(
                                        Title: 'Specialization',
                                        isStatus: true),
                                    tagSearchField2(
                                      hintText: "Specialization",
                                      focus: focus3,
                                      listValue: specilizationVal,
                                      focusTagEnabled: false,
                                      values: specilizationOption ?? [],
                                      onPressed: (p0) {
                                        print(p0);

                                        setState(() {
                                          specilizationOption = p0;
                                        });
                                      },
                                    ),
                                  ],
                                )),
                                const SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                    child: Column(
                                  children: [
                                    //Qualification
                                    Title_Style2(
                                        Title: 'Qualification', isStatus: true),
                                    tagSearchField2(
                                      hintText: "Qualification",
                                      focus: focus2,
                                      listValue: qualificationVal,
                                      focusTagEnabled: false,
                                      values: qualificationOption ?? [],
                                      onPressed: (p0) {
                                        print(p0);

                                        setState(() {
                                          qualificationOption = p0;
                                        });
                                      },
                                    ),
                                  ],
                                )),
                              ],
                            ),

                            //HISTORY AND CURRENT ARREARS
                            Row(
                              children: [
                                Expanded(
                                    child: Column(
                                  children: [
                                    //Current Arrears
                                    Title_Style2(
                                        Title: 'Current Arrears',
                                        isStatus: false),
                                    textFormField2(
                                      hintText: 'Current Arrears',
                                      keyboardtype: TextInputType.text,
                                      inputFormatters: null,
                                      Controller: _currentArrear,
                                      validating: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Please Enter Current of Arrears";
                                        }
                                        if (value == null) {
                                          return "Please Enter Valid Current of Arrears";
                                        }
                                        return null;
                                      },
                                      onChanged: null,
                                    ),
                                  ],
                                )),
                                const SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                    child: Column(
                                  children: [
                                    //History of Arrears
                                    Title_Style2(
                                        Title: 'History of Arrears',
                                        isStatus: false),
                                    textFormField2(
                                      hintText: 'History of Arrears',
                                      keyboardtype: TextInputType.text,
                                      inputFormatters: null,
                                      Controller: _historyOfArrear,
                                      validating: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Please Enter History of Arrears";
                                        }
                                        if (value == null) {
                                          return "Please Enter Valid History of Arrears";
                                        }
                                        return null;
                                      },
                                      onChanged: null,
                                    ),
                                  ],
                                ))
                              ],
                            ),

                            //SALARY RANGE PER ANNUM AND REQUIRED PERCENTAGE
                            Row(
                              children: [
                                Expanded(
                                    child: Column(
                                  children: [
                                    Title_Style2(
                                        Title: 'Salary Range (Per Annum)',
                                        isStatus: false),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              textFormField2(
                                                hintText: 'From',
                                                keyboardtype:
                                                    TextInputType.number,
                                                inputFormatters: null,
                                                Controller: _salaryFrom,
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              textFormField2(
                                                hintText: 'To',
                                                keyboardtype:
                                                    TextInputType.name,
                                                inputFormatters: null,
                                                Controller: _salaryTo,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                                const SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                    child: Column(
                                  children: [
                                    //Required Percentage
                                    Title_Style2(
                                        Title: 'Required Percentage/CGPA',
                                        isStatus: false),
                                    textFormField2(
                                      hintText: 'Required Percentage',
                                      keyboardtype: TextInputType.text,
                                      inputFormatters: null,
                                      Controller: _requriedPercentage,
                                      validating: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Please Enter Specialization";
                                        }
                                        if (value == null) {
                                          return "Please Enter Valid Specialization";
                                        }
                                        return null;
                                      },
                                      onChanged: null,
                                    ),
                                  ],
                                )),
                              ],
                            ),

                            //NO OF ROUNDS AND STATUTORY BENEFITS
                            Row(
                              children: [
                                Expanded(
                                    child: Column(
                                  children: [
                                    //Rounds
                                    Title_Style2(
                                        Title: 'Number of Rounds',
                                        isStatus: true),
                                    dropDownField2(
                                      context,
                                      value: noOfRoundsOption,
                                      listValue: noOfRounds,
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          noOfRoundsOption = newValue;
                                        });
                                      },
                                    ),
                                  ],
                                )),
                                const SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                    child: Column(
                                  children: [
                                    Title_Style2(
                                        Title: 'Statutory Benefits',
                                        isStatus: false),
                                    textFormField2(
                                      hintText: 'Statutory Benefits',
                                      keyboardtype: TextInputType.text,
                                      inputFormatters: null,
                                      Controller: _statutoryBenefitController,
                                      validating: null,
                                      onChanged: null,
                                    ),
                                  ],
                                )),
                              ],
                            ),

                            //SOCIAL AMD OTHER BENEFITS
                            Row(
                              children: [
                                Expanded(
                                    child: Column(
                                  children: [
                                    Title_Style2(
                                        Title: 'Social Benefits',
                                        isStatus: false),
                                    textFormField2(
                                      hintText: 'Social Benefits',
                                      keyboardtype: TextInputType.text,
                                      inputFormatters: null,
                                      Controller: _socialBenefitController,
                                      validating: null,
                                      onChanged: null,
                                    ),
                                  ],
                                )),
                                const SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                    child: Column(
                                  children: [
                                    Title_Style2(
                                        Title: 'Other Benefits',
                                        isStatus: false),
                                    textFormField2(
                                      hintText: 'Other Benefits',
                                      keyboardtype: TextInputType.text,
                                      inputFormatters: null,
                                      Controller: _otherBenefitsController,
                                      validating: null,
                                      onChanged: null,
                                    ),
                                  ],
                                )),
                              ],
                            ),

                            //DEAD LINE
                            Title_Style2(Title: 'Deadline:', isStatus: false),
                            Container(
                              // margin: EdgeInsets.only(right:200),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                  "The job will expire in 30 days from the date of job post"),
                            ),
                            Container(
                                alignment: Alignment.center,
                                width: 350,
                                margin: EdgeInsets.only(top: 45, bottom: 30),
                                child: CommonElevatedButton(
                                    context, 'CreateJob', () {
                                  if (_formKey.currentState!.validate()) {
                                    widget.isEditBulk == true
                                        ? EditBulkJobApiResponse()
                                        : BulkJobApiResponse();
                                  }
                                }))
                          ]),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  Future<void> BulkJobApiResponse() async {
    if (_formKey.currentState!.validate()) {
      var qualifiationArrayValue = [];
      var specializaArrayValue = [];

      for (var obj in qualificationOption!) {
        QualificationData? result = qualificationVal.firstWhere(
            (value) => value.qualification == obj,
            orElse: () => QualificationData(
                id: obj, qualification: "", qualification_id: ""));
        qualifiationArrayValue.add(result.id);
      }

      for (var obj in specilizationOption!) {
        QualificationData? result = specilizationVal.firstWhere(
            (value) => value.qualification == obj,
            orElse: () => QualificationData(
                id: obj, qualification: "", qualification_id: ""));
        specializaArrayValue.add(result.id);
      }

      final bulkJobApiService = ApiService(ref.read(dioProvider));
      var formData = FormData.fromMap({
        "job_title": _jobtitle.text,
        "recruiter_id": await getRecruiterId(),
        "job_description": _jobDescriptionController.text,
        "qualification": qualifiationArrayValue.join(","),
        "specialization": specializaArrayValue.join(","),
        "current_arrears": _currentArrear.text,
        "history_of_arrears": _historyOfArrear.text,
        "required_percentage": _requriedPercentage,
        "location": _Location.text,
        "salary_from": _salaryFrom.text,
        "salary_to": _salaryTo.text,
        "statutory_benefits": _statutoryBenefitController.text,
        "social_benefits": _socialBenefitController.text,
        "other_benefits": _otherBenefitsController.text,
        "vacancies": _vacancies.text,
        "rounds": noOfRoundsOption,
        "campus_id": widget.campus_Id,
      });
      final bulkJobApiResponse = await bulkJobApiService.post<BulkJobModel>(
          context, ConstantApi.bulkJobUrl, formData);

      if (bulkJobApiResponse.status == true) {
        Navigator.pop(context);
        print("Sucess");
      } else {
        print("Error");
        ShowToastMessage(bulkJobApiResponse.message ?? "");
      }
    }
  }

  Future<void> EditBulkJobApiResponse() async {
    if (_formKey.currentState!.validate()) {
      var qualifiationArrayValue = [];
      var specializaArrayValue = [];

      for (var obj in qualificationOption!) {
        QualificationData? result = qualificationVal.firstWhere(
            (value) => value.qualification == obj,
            orElse: () => QualificationData(
                id: obj, qualification: "", qualification_id: ""));
        qualifiationArrayValue.add(result.id);
      }

      for (var obj in specilizationOption!) {
        QualificationData? result = specilizationVal.firstWhere(
            (value) => value.qualification == obj,
            orElse: () => QualificationData(
                id: obj, qualification: "", qualification_id: ""));
        specializaArrayValue.add(result.id);
      }

      final bulkJobApiService = ApiService(ref.read(dioProvider));
      var formData = FormData.fromMap({
        "job_title": _jobtitle.text,
        "recruiter_id": await getRecruiterId(),
        "job_description": _jobDescriptionController.text,
        "qualification": qualifiationArrayValue.join(","),
        "specialization": specializaArrayValue.join(","),
        "current_arrears": _currentArrear.text,
        "history_of_arrears": _historyOfArrear.text,
        "required_percentage": _requriedPercentage,
        "location": _Location.text,
        "salary_from": _salaryFrom.text,
        "salary_to": _salaryTo.text,
        "statutory_benefits": _statutoryBenefitController.text,
        "social_benefits": _socialBenefitController.text,
        "other_benefits": _otherBenefitsController.text,
        "vacancies": _vacancies.text,
        "rounds": noOfRoundsOption,
        "campus_id": widget.campus_Id,
        "job_id": widget.job_Id,
      });
      final bulkJobApiResponse = await bulkJobApiService.post<BulkJobModel>(
          context, ConstantApi.editbulkJobUrl, formData);

      if (bulkJobApiResponse.status == true) {
        Navigator.pop(context);
        print("Sucess");
      } else {
        print("Error");
        ShowToastMessage(bulkJobApiResponse.message ?? "");
      }
    }
  }

  //SPECIALIZATION RESPONSE
  Future<void> loadSpecilizationOptions() async {
    final apiService = ApiService(ref.read(dioProvider));

    try {
      print(ConstantApi.specilizationUrl);

      final response = await apiService.get<QualificationModel>(
          context, ConstantApi.specilizationUrl);

      setState(() {
        specilizationVal = response.data ?? []; // Assuming data is a List<Data>
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  //QUALIFICATION RESPONSE
  Future<void> loadQualificationOptions() async {
    final apiService = ApiService(ref.read(dioProvider));

    try {
      print(ConstantApi.qualificationUrl);
      final response = await apiService.get<QualificationModel>(
          context, ConstantApi.qualificationUrl);

      setState(() {
        qualificationVal = response.data ?? []; // Assuming data is a List<Data>
      });
    } catch (e) {
      print('Error: $e');
    }
  }
}
