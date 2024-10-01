import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:getifyjobs/Models/DirectDetailsModel.dart';
import 'package:getifyjobs/Models/JobModel.dart';
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

class Recruiter_Web_CreateJob extends ConsumerStatefulWidget {
  bool? isEdit;
  String? Job_Id;
  DirectDetailsData? DirectJobDetailResponseData;

  Recruiter_Web_CreateJob(
      {super.key,
      required this.DirectJobDetailResponseData,
      required this.isEdit,
      required this.Job_Id});

  @override
  ConsumerState<Recruiter_Web_CreateJob> createState() =>
      _Recruiter_Web_CreateJobState();
}

class _Recruiter_Web_CreateJobState
    extends ConsumerState<Recruiter_Web_CreateJob> {
  TextEditingController _jobTitle = TextEditingController();
  TextEditingController _Description = TextEditingController();
  TextEditingController _currentArrear = TextEditingController();
  TextEditingController _historyOfArrear = TextEditingController();
  TextEditingController _requriedPercentage = TextEditingController();
  TextEditingController _Location = TextEditingController();
  TextEditingController _From = TextEditingController();
  TextEditingController _To = TextEditingController();
  TextEditingController _StatutoryBenefit = TextEditingController();
  TextEditingController _SocialBenefits = TextEditingController();
  TextEditingController _OtherBenefits = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  int selectedFromExperience = 0;
  int selectedToExperience = 1;
  String? shiftDetailVal;
  List<String>? qualificationOption;
  List<String>? specilizationOption;
  List<String>? skillSetOption;
  final focus2 = FocusNode();
  final focus3 = FocusNode();
  final focus4 = FocusNode();
  List<String> shiftDetailOption = [
    "Day shift",
    "Night shift",
    "Noon shift",
  ];
  List<String> noOfRounds = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
  ];
  List<QualificationData> qualificationVal = [];
  List<QualificationData> specilizationVal = [];
  List<QualificationData> skillsetVal = [];
  List<int> experienceList = List.generate(21, (index) => index);
  int? _workType;
  String? SelectOption;
  String? noOfRoundsOption;
  List<String> _WorkTypeCategory = [
    'Apprenticeship',
    'Trainee',
    'Employment on commission',
    "WFH/Remote",
    "Internship"
  ];
  EditSingleJob() async {
    _jobTitle.text = widget.DirectJobDetailResponseData?.jobTitle ?? "";
    _Description.text =
        widget.DirectJobDetailResponseData?.jobDescription ?? "";
    // _SkillSet.text = widget.DirectJobDetailResponseData?.skills ?? "";
    // _Qualification.text = widget.DirectJobDetailResponseData?.qualification ?? "";
    // _specialization.text = widget.DirectJobDetailResponseData?.specialization ?? "";
    _currentArrear.text =
        widget.DirectJobDetailResponseData?.currentArrears ?? "";
    _historyOfArrear.text =
        widget.DirectJobDetailResponseData?.historyOfArrears ?? "";
    _requriedPercentage.text =
        widget.DirectJobDetailResponseData?.requiredPercentage ?? "";
    _Location.text = widget.DirectJobDetailResponseData?.location ?? "";
    _From.text = widget.DirectJobDetailResponseData?.salaryFrom ?? "";
    _To.text = widget.DirectJobDetailResponseData?.salaryTo ?? "";
    _StatutoryBenefit.text =
        widget.DirectJobDetailResponseData?.statutoryBenefits ?? "";
    _SocialBenefits.text =
        widget.DirectJobDetailResponseData?.socialBenefits ?? "";
    _OtherBenefits.text =
        widget.DirectJobDetailResponseData?.otherBenefits ?? "";
    shiftDetailVal = widget.DirectJobDetailResponseData?.shiftDetails ?? "";
    _workType = widget.DirectJobDetailResponseData?.workType == "Full Time"
        ? 0
        : widget.DirectJobDetailResponseData?.workType == "Part Time"
            ? 1
            : 2;
    SelectOption = widget.DirectJobDetailResponseData?.workMode;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadApicalls();
    });
    widget.isEdit == true ? EditSingleJob() : null;
  }

  loadApicalls() async {
    await loadQualificationOptions();
    await loadSpecilizationOptions();
    await loadSkillSetOptions();
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
        title: "Single Job",
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 20, bottom: 20, left: 20, right: 20),
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  height: MediaQuery.of(context).size.height / 1.2,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20), color: white1),
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: ImgPathSvg('create.svg'),
                  )),
                ),
              ),
              Form(
                key: _formKey,
                child: Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 20, top: 0, right: 20),
                    height: 1160,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //JOB TITLE
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                // width: 135,
                                child: Text(
                                  "Job Title",
                                  style: TextField_Title1,
                                ),
                              ),
                              Text(
                                "*",
                                style: StarT,
                              )
                            ],
                          ),
                          Container(
                            child: textFormField2(
                              hintText: 'Job Title',
                              keyboardtype: TextInputType.text,
                              inputFormatters: null,
                              Controller: _jobTitle,
                              validating: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please Enter Valid ${'Job Title*'}";
                                }
                                if (value == null) {
                                  return "Please Enter Valid ${'Job Title*'}";
                                }
                                return null;
                              },
                              onChanged: null,
                            ),
                          ),

                          //DESCRIPTION
                          Title_Style2(
                              Title: 'Job Description', isStatus: true),
                          Container(
                            child: textfieldDescription2(
                              Controller: _Description,
                              validating: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please Enter ${'Something*'}";
                                }
                                if (value == null) {
                                  return "Please Enter ${'Something*'}";
                                }
                                return null;
                              },
                              hint: 'Description',
                            ),
                          ),

                          //SKILL SET
                          Title_Style2(Title: 'Skill Set', isStatus: true),
                          tagSearchField2(
                            hintText: "Skill Set",
                            focus: focus4,
                            listValue: skillsetVal,
                            focusTagEnabled: false,
                            values: skillSetOption ?? [],
                            onPressed: (p0) {
                              print(p0);

                              setState(() {
                                skillSetOption = p0;
                              });
                            },
                          ),
                          //QUALIFICATION AND Specialization
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      //QUALIFICATION
                                      Title_Style2(
                                          Title: 'Qualification',
                                          isStatus: true),
                                      Container(
                                        child: tagSearchField2(
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
                                  ),
                                ),
                              ],
                            ),
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

                          // REQUIRED PERCENTAGE AND EXPERIENCE
                          Row(
                            children: [
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
                              const SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                  child: Column(
                                children: [
                                  Title_Style2(
                                      Title: "Years of Experience",
                                      isStatus: true),
                                  _ExperienceSection()
                                ],
                              )),
                            ],
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
                              ],
                            ),
                          ),

                          //WORK TYPE AND SALARY RANGE
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      //WORK TYPE
                                      Title_Style2(
                                          Title: 'Work Type', isStatus: true),
                                      Container(
                                        margin: EdgeInsets.only(bottom: 5),
                                        child: MultiRadioButton(
                                            groupValue1: _workType,
                                            groupValue2: _workType,
                                            groupValue3: _workType,
                                            onChanged1: (value) {
                                              setState(() {
                                                _workType = value;
                                              });
                                            },
                                            onChanged2: (value) {
                                              setState(() {
                                                _workType = value;
                                              });
                                            },
                                            onChanged3: (value) {
                                              setState(() {
                                                _workType = value;
                                              });
                                            },
                                            radioTxt1: 'Full Time',
                                            radioTxt2: 'Part Time',
                                            radioTxt3: 'Contract'),
                                      ),
                                      Container(
                                        child: dropDownField2(
                                          context,
                                          value: SelectOption,
                                          listValue: _WorkTypeCategory,
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              SelectOption = newValue;
                                            });
                                          },
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
                                      //Salary Range (Per Annum)
                                      Title_Style2(
                                          Title: 'Salary Range (Per Annum)',
                                          isStatus: true),
                                      Container(
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                      margin: EdgeInsets.only(
                                                          bottom: 5),
                                                      child: Text(
                                                        'From',
                                                        style: TextField_Title,
                                                      )),
                                                  Container(
                                                    child: textFormField2(
                                                      hintText: 'From',
                                                      keyboardtype:
                                                          TextInputType.number,
                                                      inputFormatters: null,
                                                      Controller: _From,
                                                      validating: (value) {
                                                        if (value == null ||
                                                            value.isEmpty) {
                                                          return "Please Enter valid From";
                                                        }
                                                        if (value == null) {
                                                          return "Please Enter Valid From";
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
                                                  Container(
                                                      margin: EdgeInsets.only(
                                                          bottom: 5),
                                                      child: Text(
                                                        'To',
                                                        style: TextField_Title,
                                                      )),
                                                  Container(
                                                    child: textFormField2(
                                                      hintText: 'To',
                                                      keyboardtype:
                                                          TextInputType.number,
                                                      inputFormatters: null,
                                                      Controller: _To,
                                                      validating: (value) {
                                                        if (value == null ||
                                                            value.isEmpty) {
                                                          return "Please Enter valid To";
                                                        }
                                                        if (value == null) {
                                                          return "Please Enter Valid To";
                                                        }
                                                        return null;
                                                      },
                                                      onChanged: null,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          //SHIFT DETAILS AND Statutory Benefit
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      //Shift Details
                                      Title_Style2(
                                          Title: 'Shift Details',
                                          isStatus: true),
                                      dropDownField2(
                                        context,
                                        value: shiftDetailVal,
                                        listValue: shiftDetailOption,
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            shiftDetailVal = newValue;
                                          });
                                        },
                                      )
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
                                      //Statutory Benefit
                                      Title_Style2(
                                          Title: 'Statutory Benefits',
                                          isStatus: false),
                                      Container(
                                        child: textFormField2(
                                          hintText: 'Statutory Benefits',
                                          keyboardtype: TextInputType.text,
                                          inputFormatters: null,
                                          Controller: _StatutoryBenefit,
                                          validating: null,
                                          onChanged: null,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          //SOCIAL BENEFITS AND OTHER BENEFITS
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      //Social Benefits
                                      Title_Style2(
                                          Title: 'Social Benefits',
                                          isStatus: false),
                                      Container(
                                        child: textFormField2(
                                          hintText: 'Social Benefits',
                                          keyboardtype: TextInputType.text,
                                          inputFormatters: null,
                                          Controller: _SocialBenefits,
                                          validating: null,
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
                                      //Other Benefits
                                      Title_Style2(
                                          Title: 'Other Benefits',
                                          isStatus: false),
                                      Container(
                                        child: textFormField2(
                                          hintText: 'Other Benefits',
                                          keyboardtype: TextInputType.text,
                                          inputFormatters: null,
                                          Controller: _OtherBenefits,
                                          validating: null,
                                          onChanged: null,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          //DEADLINE
                          Title_Style2(Title: 'Deadline:', isStatus: false),
                          Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "The job will expire in 30 days from the date of job post",
                                style: deadlineT,
                              )),
                          //COMMON ELEVATED BUTTON
                          Container(
                              alignment: Alignment.center,
                              width: 350,
                              margin: EdgeInsets.only(
                                  left: 150, top: 25, bottom: 30),
                              child: CommonElevatedButton(context, 'Create Job',
                                  () {
                                if (_formKey.currentState!.validate()) {
                                  widget.isEdit == true
                                      ? editSingleJob()
                                      : CreateSingleJob();
                                }
                              }))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> CreateSingleJob() async {
    var skillsArrayValue = [];
    var qualifiationArrayValue = [];
    var specializaArrayValue = [];

    for (var obj in skillSetOption!) {
      QualificationData? result = skillsetVal.firstWhere(
          (value) => value.qualification == obj,
          orElse: () => QualificationData(
              id: obj, qualification: "", qualification_id: ""));
      skillsArrayValue.add(result.id);
    }

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

    final singleJobApiService = ApiService(ref.read(dioProvider));
    var formData = FormData.fromMap({
      "job_title": _jobTitle.text,
      "recruiter_id": "1",
      "job_description": _Description.text,
      "skills": skillsArrayValue.join(","),
      "qualification": qualifiationArrayValue.join(","),
      "specialization": specializaArrayValue.join(","),
      "current_arrears": _currentArrear.text,
      "history_of_arrears": _historyOfArrear.text,
      "required_percentage": _requriedPercentage.text,
      "location": _Location.text,
      "experience": "fresher",
      "work_type": _workType == 0
          ? "Full Time"
          : _workType == 1
              ? "Part Time"
              : "Contract",
      "work_mode": _WorkTypeCategory,
      "shift_details": shiftDetailVal,
      "salary_from": _From.text,
      "salary_to": _To.text,
      "social_benefits": _SocialBenefits.text,
      "other_benefits": _OtherBenefits.text
    });
    final singleJobResponse = await singleJobApiService.post<JobModel>(
        context, ConstantApi.singleJobUrl, formData);

    print(
        "WORK TYPE = ${_WorkTypeCategory == 0 ? "Full Time" : _workType == 1 ? "Part Time" : "Contract"}");

    print("SHIFT DETAIL = ${shiftDetailVal}");

    print("JOB ID : ${singleJobResponse.data?.jobId ?? ""}");
    if (singleJobResponse.status == true) {
      Navigator.pop(context);
      print("SUCESS");
    } else {
      ShowToastMessage(singleJobResponse.message ?? "");
      print("ERROR");
    }
  }

  Future<void> editSingleJob() async {
    var skillsArrayValue = [];
    var qualifiationArrayValue = [];
    var specializaArrayValue = [];

    for (var obj in skillSetOption!) {
      QualificationData? result = skillsetVal.firstWhere(
          (value) => value.qualification == obj,
          orElse: () => QualificationData(
              id: obj, qualification: "", qualification_id: ""));
      skillsArrayValue.add(result.id);
    }

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

    final singleJobApiService = ApiService(ref.read(dioProvider));
    var formData = FormData.fromMap({
      "job_id": widget.Job_Id,
      "job_title": _jobTitle.text,
      "recruiter_id": "1",
      "job_description": _Description.text,
      "skills": skillsArrayValue.join(","),
      "qualification": qualifiationArrayValue.join(","),
      "specialization": specializaArrayValue.join(","),
      "current_arrears": _currentArrear.text,
      "history_of_arrears": _historyOfArrear.text,
      "required_percentage": _requriedPercentage.text,
      "location": _Location.text,
      "experience": "fresher",
      "work_type": _workType == 0
          ? "Full Time"
          : _workType == 1
              ? "Part Time"
              : "Contract",
      "work_mode": _WorkTypeCategory,
      "shift_details": shiftDetailVal,
      "salary_from": _From.text,
      "salary_to": _To.text,
      "social_benefits": _SocialBenefits.text,
      "other_benefits": _OtherBenefits.text
    });
    final singleJobResponse = await singleJobApiService.post<JobModel>(
        context, ConstantApi.editsingleJobUrl, formData);

    print(
        "WORK TYPE = ${_WorkTypeCategory == 0 ? "Full Time" : _workType == 1 ? "Part Time" : "Contract"}");

    print("SHIFT DETAIL = ${shiftDetailVal}");

    print("JOB ID : ${singleJobResponse.data?.jobId ?? ""}");
    if (singleJobResponse.status == true) {
      Navigator.pop(context);
      print("SUCESS");
    } else {
      ShowToastMessage(singleJobResponse.message ?? "");
      print("ERROR");
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

  //SKILL SET RESPONSE
  Future<void> loadSkillSetOptions() async {
    final apiService = ApiService(ref.read(dioProvider));

    try {
      print(ConstantApi.skillSetUrl);
      final response = await apiService.get<QualificationModel>(
          context, ConstantApi.skillSetUrl);

      setState(() {
        skillsetVal = response.data ?? []; // Assuming data is a List<Data>
      });
    } catch (e) {
      print('Error: $e');
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

  Widget _ExperienceSection() {
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 50,
            width: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: white1,
            ),
            child: DropdownButtonFormField<int>(
              isExpanded: true,
              decoration: InputDecoration(border: InputBorder.none),
              icon: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Icon(
                  Icons.keyboard_arrow_down_sharp,
                  color: Colors.black,
                  size: 20,
                ),
              ),
              value: selectedFromExperience,
              onChanged: (int? newValue) {
                setState(() {
                  selectedFromExperience = newValue!;
                  // Ensure "to" is greater than "from"
                  if (selectedToExperience <= selectedFromExperience) {
                    selectedToExperience = selectedFromExperience + 1;
                  }
                });
              },
              items: experienceList.map((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text('  $value years'),
                );
              }).toList(),
            ),
          ),
        ],
      ),
      Spacer(),
      Text(
        'To',
        style: TextField_Title,
      ),
      Spacer(),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 50,
            width: 150,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: white1),
            child: DropdownButtonFormField<int>(
              isExpanded: true,
              decoration: InputDecoration(border: InputBorder.none),
              icon: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Icon(
                  Icons.keyboard_arrow_down_sharp,
                  color: Colors.black,
                  size: 20,
                ),
              ),
              value: selectedToExperience,
              onChanged: (int? newValue) {
                setState(() {
                  selectedToExperience = newValue!;
                });
              },
              items: experienceList
                  .where((value) => value > selectedFromExperience)
                  .map((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text('  $value years'),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    ]);
  }
}
