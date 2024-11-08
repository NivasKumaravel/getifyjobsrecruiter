import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:getifyjobs/Models/CollegeProfileModel.dart';
import 'package:getifyjobs/Models/DirectDetailsModel.dart';
import 'package:getifyjobs/Models/JobModel.dart';
import 'package:getifyjobs/Models/QualificationModel.dart';
import 'package:getifyjobs/Models/SkillSetModel.dart';
import 'package:getifyjobs/Models/SpecializationModel.dart';
import 'package:getifyjobs/Models/StatutoryBenefitsModel.dart';
import 'package:getifyjobs/Src/Common_Widgets/Bottom_Navigation_Bar.dart';
import 'package:getifyjobs/Src/Common_Widgets/Common_Button.dart';
import 'package:getifyjobs/Src/Common_Widgets/Custom_App_Bar.dart';
import 'package:getifyjobs/Src/Common_Widgets/SearchLocation.dart';
import 'package:getifyjobs/Src/Common_Widgets/Text_Form_Field.dart';
import 'package:getifyjobs/Src/utilits/ApiService.dart';
import 'package:getifyjobs/Src/utilits/Common_Colors.dart';
import 'package:getifyjobs/Src/utilits/ConstantsApi.dart';
import 'package:getifyjobs/Src/utilits/Generic.dart';
import 'package:getifyjobs/Src/utilits/Text_Style.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:searchfield/searchfield.dart';

class CreateJob extends ConsumerStatefulWidget {
  bool? isEdit;
  String? Job_Id;
  DirectDetailsData? DirectJobDetailResponseData;
  CreateJob(
      {super.key,
      required this.isEdit,
      required this.Job_Id,
      required this.DirectJobDetailResponseData});

  @override
  ConsumerState<CreateJob> createState() => _CreateJobState();
}

class _CreateJobState extends ConsumerState<CreateJob> {
  int selectedFromExperience = 0;
  int selectedToExperience = 1;



  List<int> experienceList = List.generate(21, (index) => index);
  int? _value;
  List<String>? qualificationOption;
  List<String>? specilizationOption;
  List<String>? specilizationOption_ID;
  List<String>? industry_Id;

  List<String>? skillSetOption;
  String? shiftDetailVal;
  String? workTypeOption;
  String? experienceVal;
  String? statutoryVal;
  String? socialVal;
  String? otherVal;
  final _formKey = GlobalKey<FormState>();
  String? noOfRoundsOption;
  final focus2 = FocusNode();
  final focus3 = FocusNode();
  final focus4 = FocusNode();
  final focus5 = FocusNode();
  final focus6 = FocusNode();
  final focus7 = FocusNode();
  final focus8 = FocusNode();
  final focus9 = FocusNode();
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
  List<StatutoryBenefitsData> statutoryData = [];
  List<StatutoryBenefitsData> socialData = [];
  List<StatutoryBenefitsData> otherData = [];
  List<String> shiftDetailOption = [
    "Day shift",
    "Night shift",
    "Noon shift",
  ];
  List<String> experienceOtion = [
    "Fresher",
    "Experienced",
  ];

  List<String> workTypeVal = [
    "Please Select",
    "Apprenticeship",
    "Trainee",
    "Employment on commission",
    "WFH/Remote",
    "Internship"
  ];
  TextEditingController _jobTitleController = TextEditingController();
  TextEditingController _jobDescriptionController = TextEditingController();
  TextEditingController _skillSetController = TextEditingController();
  TextEditingController _specialization = TextEditingController();
  TextEditingController _currentArrear = TextEditingController();
  TextEditingController _historyOfArrear = TextEditingController();
  TextEditingController _requriedPercentage = TextEditingController();

  TextEditingController _location = TextEditingController();
  TextEditingController _salaryFrom = TextEditingController();
  TextEditingController _salaryTo = TextEditingController();

  List<String> preferredlocationOption = [];

  String _toTitleCase(String text) {
    if (text.isEmpty) return '';

    return text.toLowerCase().split(' ').map((word) {
      if (word.isNotEmpty) {
        return word[0].toUpperCase() + word.substring(1);
      }
      return '';
    }).join(' ');
  }

  void _JobTitleFormat() {
    final text = _jobTitleController.text;
    final formattedText = _toTitleCase(text);
    if (text != formattedText) {
      _jobTitleController.value = TextEditingValue(
        text: formattedText,
        selection: TextSelection.collapsed(offset: formattedText.length),
      );
    }
  }


  void _JobDescriptionFormat() {
    final text = _jobDescriptionController.text;
    final formattedText = _toTitleCase(text);
    if (text != formattedText) {
      _jobDescriptionController.value = TextEditingValue(
        text: formattedText,
        selection: TextSelection.collapsed(offset: formattedText.length),
      );
    }
  }



  EditSingleJob() async {
    _jobTitleController.text =
        widget.DirectJobDetailResponseData?.jobTitle ?? "";
    _jobDescriptionController.text =
        widget.DirectJobDetailResponseData?.jobDescription ?? "";
    _skillSetController.text = widget.DirectJobDetailResponseData?.skills ?? "";

    _currentArrear.text =
        widget.DirectJobDetailResponseData?.currentArrears ?? "";
    _historyOfArrear.text =
        widget.DirectJobDetailResponseData?.historyOfArrears ?? "";
    _requriedPercentage.text =
        widget.DirectJobDetailResponseData?.requiredPercentage ?? "";
    qualificationOption = (widget.DirectJobDetailResponseData?.qualification ?? "").split(',').map((item) => item.trim()).toList();
    specilizationOption = (widget.DirectJobDetailResponseData?.specialization ?? "").split(",").map((e) => e.trim()).toList();
    skillSetOption = (widget.DirectJobDetailResponseData?.skills ?? "").split(",").map((e) => e.trim()).toList();

    _location.text = widget.DirectJobDetailResponseData?.location ?? "";
    _salaryFrom.text = widget.DirectJobDetailResponseData?.salaryFrom ?? "";
    _salaryTo.text = widget.DirectJobDetailResponseData?.salaryTo ?? "";
    statutoryVal =
        widget.DirectJobDetailResponseData?.statutoryBenefits ?? "";
    socialVal=
        widget.DirectJobDetailResponseData?.socialBenefits ?? "";
    otherVal =
        widget.DirectJobDetailResponseData?.otherBenefits ?? "";
    shiftDetailVal = widget.DirectJobDetailResponseData?.shiftDetails ?? "";
    _value = widget.DirectJobDetailResponseData?.workType == "Full Time"
        ? 0
        : widget.DirectJobDetailResponseData?.workType == "Part Time"
            ? 1
            : 2;
    workTypeOption = widget.DirectJobDetailResponseData?.workMode ?? "";
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadApicalls();
    });
    widget.isEdit == true ? EditSingleJob() : null;
    _jobTitleController.addListener(_JobTitleFormat);
    _jobDescriptionController.addListener(_JobDescriptionFormat);
  }

  loadApicalls() async {
    await loadQualificationOptions();
    await loadSpecilizationOptions();
    await loadSkillSetOptions();
    await StatutoryBenifitsResponse();
    await SocialBenifitsResponse();
    await OtherBenifitsResponse();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Custom_AppBar(
          isUsed: false,
          actions: [],
          isLogoUsed: true,
          title: "Single job",
          isTitleUsed: true,
        ),
        body: GestureDetector(
          onTap: (){
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Form(
            key: _formKey, // Associate the form with the GlobalKey
            child: Container(
              margin: EdgeInsets.only(left: 20, top: 25, right: 20),
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      //JOB TITLE
                      Title_Style(Title: 'Job Title', isStatus: true),
                      textFormField(
                        hintText: 'Job Title',
                        keyboardtype: TextInputType.text,
                        inputFormatters: null,
                        Controller: _jobTitleController,

                        validating: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please Enter Valid ${'Title'}";
                          }
                          if (value == null) {
                            return "Please Enter Valid ${'Title'}";
                          }
                          return null;
                        },
                        onChanged: null,
                      ),

                      //JOB DESCRIPTION
                      Title_Style(Title: 'Job Description', isStatus: true),
                      textfieldDescription(
                        maxLength: 5000,
                        Controller: _jobDescriptionController,
                        validating: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please Enter your Job Description";
                          }
                          if (value == null) {
                            return "Please Enter your Job Description";
                          }
                          if (value.length < 500) {
                            return "Job Description must be at least 500 characters";
                          }
                          return null;
                        },
                        hintT: 'Job Description',
                      ),

                      //SKILL SETS
                      Title_Style(Title: 'Skill Sets', isStatus: true),
                      tagSearchField(
                        hintText: " Skill Sets",
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


                      // QUALIFICATION
                      Title_Style(Title: 'Qualification', isStatus: true),

                      tagSearchField(
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


                      //Specilatiztion
                      Title_Style(Title: 'Specialization', isStatus: true),

                      tagSearchField(
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

                      //Experience
                      Title_Style(Title: 'Experience Type', isStatus: true),
                      dropDownField(
                          context,
                          hintText: "Select your Preference",
                          value: experienceVal,
                          listValue: experienceOtion,
                          onChanged: (String? newValue) {
                            setState(() {
                              experienceVal = newValue;
                            });
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please Add Experience Type";
                            }
                            if (value == null) {
                              return "Please Add Experience Type";
                            }
                            return null;
                          }
                      ),


                      //Current Arrears
                      experienceVal == 'Experienced' ? Container() :
                      Title_Style(Title: 'Current Arrears', isStatus: false),
                      experienceVal == 'Experienced' ? Container() :
                      textFormField(
                        hintText: 'Current Arrears',
                        keyboardtype: TextInputType.number,
                        inputFormatters: null,
                        Controller: _currentArrear,
                        // validating: (value) {
                        //   if (value == null || value.isEmpty) {
                        //     return "Please Enter Current Arrears";
                        //   }
                        //   if (value == null) {
                        //     return "Please Enter Current Arrears";
                        //   }
                        //   return null;
                        // },
                        // onChanged: null,
                      ),

                      //History of Arrears
                      experienceVal == 'Experienced' ? Container() :
                      Title_Style(Title: 'History of Arrears', isStatus: false),
                      experienceVal == 'Experienced' ? Container() :
                      textFormField(
                        hintText: 'History of Arrears',
                        keyboardtype: TextInputType.number,
                        inputFormatters: null,
                        Controller: _historyOfArrear,
                        // validating: (value) {
                        //   if (value == null || value.isEmpty) {
                        //     return "Please Enter History of Arrears";
                        //   }
                        //   if (value == null) {
                        //     return "Please Enter History of Arrears";
                        //   }
                        //   return null;
                        // },
                        // onChanged: null,
                      ),
                      //Required Percentage
                      Title_Style(
                          Title: 'Required Percentage/CGPA', isStatus: false),
                      textFormField(
                        hintText: 'Required Percentage',
                        keyboardtype: TextInputType.number,
                        inputFormatters: null,
                        Controller: _requriedPercentage,
                        validating: null,
                        onChanged: null,
                      ),

                      //Location
                      Title_Style(Title: 'Job Location', isStatus: true),
                      InkWell(
                        onTap: () {
                          focus8.unfocus();
                          focus9.unfocus();

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SearchLocation()))
                              .then((value) {
                            if (value != null) {
                              setState(() {
                                preferredlocationOption.add(value);
                              });
                            }
                          });
                        },
                        child: tagSearchFieldPreferredLoc(
                          hintText: "Preferred Job Location",
                          listValue: [],
                          focusTagEnabled: false,
                          values: preferredlocationOption,
                          onPressed: (p0) {
                            print(p0);

                            setState(() {
                              preferredlocationOption = p0;
                            });
                          },
                        ),
                      ),

                      //Years of Experience
                      experienceVal == 'Fresher' ? Container() :
                      Title_Style(Title: 'Years of Experience', isStatus: true),
                      experienceVal == 'Fresher' ? Container() :
                      _ExperienceSection(),

                      //Work type
                      Title_Style(Title: 'Work Type', isStatus: true),
                      _RadioButton(),
                      SizedBox(
                        height: 15,
                      ),
                      dropDownField(
                        context,
                        hintText: 'Work Mode',
                        value: workTypeOption,
                        listValue: workTypeVal,
                        onChanged: (String? newValue) {
                          setState(() {
                            workTypeOption = newValue;
                          });
                        },
                      ),

                      //Shift Details
                      Title_Style(Title: 'Shift Details', isStatus: true),
                      dropDownField(
                        context,
                        hintText: 'Select your Preference',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please Add Shift Details";
                          }
                          return null;
                        },
                        value: shiftDetailVal,
                        listValue: shiftDetailOption,
                        onChanged: (String? newValue) {
                          setState(() {
                            shiftDetailVal = newValue;
                          });
                        },
                      ),

                      //Salary Range
                      Title_Style(
                          Title: "Salary Range (Per Annum)", isStatus: true),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 160,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "From",
                                  style: durationT,
                                ),
                                textFormField(
                                  hintText: 'Enter the Salary',
                                  keyboardtype: TextInputType.number,
                                  inputFormatters: null,
                                  Controller: _salaryFrom,
                                  validating:  (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please Enter From Salary';
                                    }
                                    if (double.tryParse(value) == null) {
                                      return 'Please Enter a valid number';
                                    }
                                    if (_salaryTo.text.isNotEmpty &&
                                        double.parse(value) >= double.parse(_salaryTo.text)) {
                                      return 'From Salary must be lower than To Salary';
                                    }
                                    return null;
                                  },
                                  onChanged: null,
                                ),
                              ],
                            ),
                          ),
                          Spacer(),
                          Container(
                            width: 160,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "To",
                                  style: durationT,
                                ),
                                textFormField(
                                  hintText: 'Enter the Salary',
                                  keyboardtype: TextInputType.number,
                                  inputFormatters: null,
                                  Controller: _salaryTo,
                                  validating: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please Enter To Salary';
                                    }
                                    if (double.tryParse(value) == null) {
                                      return 'Please Enter a valid number';
                                    }
                                    if (_salaryFrom.text.isNotEmpty &&
                                        double.parse(value) <= double.parse(_salaryFrom.text)) {
                                      return 'To Salary must be greater than From Salary';
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

                      //Statutory Benefits
                      Title_Style(Title: 'Statutory Benefits', isStatus: false),
                      statutoryField(
                        context,
                        listValue: statutoryData,
                        onChanged: ((x) {
                          focus5.unfocus();

                          setState(() {
                            StatutoryBenefitsData result = statutoryData
                                .firstWhere((value) => value.benefits == x.searchKey);

                            // Print the result
                            print(result.id);

                            statutoryVal = result.benefits;


                            // specializationOption = "";
                            // specializationonVal = [];
                            // SetSpecializrion();
                          });
                        }),
                        focus: focus5,
                        validator: null,

                        searchText: (SearchValue) {
                          statutoryVal = SearchValue;
                        },
                        hintT: 'Statutory Benefits',
                      ),

                      //Social Benefits
                      Title_Style(Title: 'Social Benefits', isStatus: false),
                      statutoryField(
                        context,
                        listValue: socialData,
                        onChanged: ((x) {
                          focus6.unfocus();

                          setState(() {
                            StatutoryBenefitsData result = socialData
                                .firstWhere((value) => value.benefits == x.searchKey);

                            // Print the result
                            print(result.id);

                            socialVal = result.benefits;


                            // specializationOption = "";
                            // specializationonVal = [];
                            // SetSpecializrion();
                          });
                        }),
                        focus: focus6,
                        validator: null,

                        searchText: (SearchValue) {
                          socialVal = SearchValue;
                        },
                        hintT: 'Social Benefits',
                      ),

                      //Other Benefits
                      Title_Style(Title: 'Other Benefits', isStatus: false),
                      statutoryField(
                        context,
                        listValue: otherData,
                        onChanged: ((x) {
                          focus7.unfocus();

                          setState(() {
                            StatutoryBenefitsData result = otherData
                                .firstWhere((value) => value.benefits == x.searchKey);

                            // Print the result
                            print(result.id);

                            otherVal = result.benefits;


                            // specializationOption = "";
                            // specializationonVal = [];
                            // SetSpecializrion();
                          });
                        }),
                        focus: focus7,
                        validator: null,

                        searchText: (SearchValue) {
                          otherVal = SearchValue;
                        },
                        hintT: 'Other Benefits',
                      ),
                      Title_Style(Title: 'Deadline:', isStatus: false),
                      Text(
                          "The job will expire in 30 days from the date of job post"),
                      // SizedBox(height: 60),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 60, bottom: 25),
                          child: Container(
                            height: 45,
                            width: 200,
                            child: CommonElevatedButton(context,widget.isEdit ==true?"Update Job": "Create Job",
                                () async {
                              if (_formKey.currentState!.validate()) {
                                widget.isEdit == true
                                    ? editSingleJob()
                                    : AddJobResposne();
                              }
                            }),
                          ),
                        ),
                      ),
                    ]),
              ),
            ),
          ),
        ));
  }

  // ADD SINGLE JOB
  Future<void> AddJobResposne() async {
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
      "job_title": _jobTitleController.text,
      "recruiter_id": await getRecruiterId(),
      "job_description": _jobDescriptionController.text,
      "skills": skillsArrayValue.join(","),
      "qualification": qualifiationArrayValue.join(","),
      "specialization": specializaArrayValue.join(','),
      "current_arrears": _currentArrear.text,
      "history_of_arrears": _historyOfArrear.text,
      "required_percentage": _requriedPercentage.text,
      "location": preferredlocationOption,
      "experience": experienceVal,
      "work_mode": workTypeOption,
      "work_type": _value == 0
          ? "Full Time"
          : _value == 1
              ? "Part Time"
              : "Contract",
      "shift_details": shiftDetailVal,
      "salary_from": _salaryFrom.text,
      "salary_to": _salaryTo.text,
      "statutory_benefits": statutoryVal,
      "social_benefits": socialVal,
      "other_benefits": otherVal,
      "years_of_experience": "${selectedFromExperience} - ${selectedToExperience}"
    });
    final singleJobResponse = await singleJobApiService.post<JobModel>(
        context, ConstantApi.singleJobUrl, formData);

    print(
        "WORK TYPE = ${_value == 0 ? "Full Time" : _value == 1 ? "Part Time" : "Contract"}");
    print("QUALIFICATION = ${qualificationOption}");
    print("SHIFT DETAIL = ${shiftDetailVal}");

    print("JOB ID : ${singleJobResponse.data?.jobId ?? ""}");
    if (singleJobResponse.status == true) {
      setState(() {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Recruiter_Bottom_Navigation(select: 1)), (route) => false);
      });
      print("SUCESS");
    } else {
      ShowToastMessage(singleJobResponse.message ?? "");
      print("ERROR");
    }
  }

  // EDIT SINGE JOB
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
      "job_title": _jobTitleController.text,
      "recruiter_id": await getRecruiterId(),
      "job_description": _jobDescriptionController.text,
      "skills": skillsArrayValue.join(","),
      "qualification": qualifiationArrayValue.join(","),
      "specialization": specializaArrayValue.join(','),
      "current_arrears": _currentArrear.text,
      "history_of_arrears": _historyOfArrear.text,
      "required_percentage": _requriedPercentage.text,
      "location": preferredlocationOption,
      "experience": experienceVal,
      "work_type": _value == 0
          ? "Full Time"
          : _value == 1
              ? "Part Time"
              : "Contract",
      "work_mode": workTypeOption,
      "shift_details": shiftDetailVal,
      "salary_from": _salaryFrom.text,
      "salary_to": _salaryTo.text,
      "statutory_benefits": statutoryVal,
      "social_benefits": socialVal,
      "other_benefits": otherVal
    });
    final singleJobResponse = await singleJobApiService.post<JobModel>(
        context, ConstantApi.editsingleJobUrl, formData);

    print(
        "WORK TYPE = ${_value == 0 ? "Full Time" : _value == 1 ? "Part Time" : "Contract"}");

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

  //SPECILIZATION
  Widget _RadioButton() {
    return MultiRadioButton(
        groupValue1: _value,
        onChanged1: (value) {
          print('RADIO VALUE: ${_value}');
          setState(() {
            _value = value;
          });
        },
        radioTxt1: "Full Time",
        groupValue2: _value,
        onChanged2: (value) {
          setState(() {
            _value = value;
          });
        },
        radioTxt2: "Part Time",
        groupValue3: _value,
        onChanged3: (value) {
          setState(() {
            _value = value;
          });
        },
        radioTxt3: "Contract");
  }

  Widget _ExperienceSection() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              margin: EdgeInsets.only(bottom: 5),
              child: Text(
                'From',
                style: TextField_Title,
              )),
          Container(
            height: 50,
            width: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: white2,
            ),
            child: DropdownButtonFormField<int>(
              isExpanded: true,
              decoration: InputDecoration(border: InputBorder.none,hintStyle: phoneHT,hintText: 'From'),
              validator: (value) {
                if (value == null ) {
                  return "Please Add Experience Year";
                }
                if (value == null) {
                  return "Please Add Experience Year";
                }
                return null;
              },
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
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              margin: EdgeInsets.only(bottom: 5),
              child: Text(
                'To',
                style: TextField_Title,
              )),
          Container(
            height: 50,
            width: 150,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: white2),
            child: DropdownButtonFormField<int>(
              isExpanded: true,
              decoration: InputDecoration(border: InputBorder.none,hintText: 'To',hintStyle: phoneHT),
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

  //STATUTORY BENEFITS
 StatutoryBenifitsResponse() async{
    final statutoryApiService = ApiService(ref.read(dioProvider));
    var formData = FormData.fromMap({
      "type":"Statutory Benefits",
    });
    final statutoryResponse = await statutoryApiService.post<StatutoryBenefitsModel>(context, ConstantApi.benefitsUrl, formData);
    if(statutoryResponse?.status == true){
      print("STATUTORY BENEFITS SUCCESS");
     setState(() {
       statutoryData = statutoryResponse?.data ?? [];
     });
    }else{
      print("STATUTORY BENEFITS ERROR");
    }
 }

 SocialBenifitsResponse() async{
    final statutoryApiService = ApiService(ref.read(dioProvider));
    var formData = FormData.fromMap({
      "type":"Social Benefits",
    });
    final statutoryResponse = await statutoryApiService.post<StatutoryBenefitsModel>(context, ConstantApi.benefitsUrl, formData);
    if(statutoryResponse?.status == true){
      print("SOCIAL BENEFITS SUCCESS");
     setState(() {
       socialData = statutoryResponse?.data ?? [];
     });
    }else{
      print("SOCIAL BENEFITS ERROR");
    }
 }
 OtherBenifitsResponse() async{
    final statutoryApiService = ApiService(ref.read(dioProvider));
    var formData = FormData.fromMap({
      "type":"Other Benefits",
    });
    final statutoryResponse = await statutoryApiService.post<StatutoryBenefitsModel>(context, ConstantApi.benefitsUrl, formData);
    if(statutoryResponse?.status == true){
      print("Other BENEFITS SUCCESS");
     setState(() {
       otherData = statutoryResponse?.data ?? [];
     });
    }else{
      print("Other BENEFITS ERROR");
    }
 }
}
