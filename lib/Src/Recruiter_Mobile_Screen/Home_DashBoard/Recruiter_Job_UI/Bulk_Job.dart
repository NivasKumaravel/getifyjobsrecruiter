import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:getifyjobs/Models/BulkJobModel.dart';
import 'package:getifyjobs/Models/CampusJobdetailModel.dart';
import 'package:getifyjobs/Models/QualificationModel.dart';
import 'package:getifyjobs/Models/StatutoryBenefitsModel.dart';
import 'package:getifyjobs/Src/Common_Widgets/Common_Button.dart';
import 'package:getifyjobs/Src/Common_Widgets/Custom_App_Bar.dart';
import 'package:getifyjobs/Src/Common_Widgets/SearchLocation.dart';
import 'package:getifyjobs/Src/Common_Widgets/Text_Form_Field.dart';
import 'package:getifyjobs/Src/utilits/ApiService.dart';
import 'package:getifyjobs/Src/utilits/ConstantsApi.dart';
import 'package:getifyjobs/Src/utilits/Generic.dart';
import 'package:getifyjobs/Src/utilits/Text_Style.dart';

class BulkJobs extends ConsumerStatefulWidget {
  final bool? isEditBulk;
  final String? job_Id;
  final String? campus_Id;
  CampusJobDetailData? campusJobDetailResponseData;
  BulkJobs(
      {super.key,
      required this.job_Id,
      required this.campus_Id,
      required this.campusJobDetailResponseData,
      required this.isEditBulk});

  @override
  ConsumerState<BulkJobs> createState() => _BulkJobsState();
}

class _BulkJobsState extends ConsumerState<BulkJobs> {
  String? noOfRoundsOption;
  String? statutoryVal;
  String? socialVal;
  String? otherVal;


  List<String>? qualificationOption;
  List<String>? specilizationOption;
  List<String> preferredlocationOption = [];

  final focus2 = FocusNode();
  final focus3 = FocusNode();
  final focus5 = FocusNode();
  final focus6 = FocusNode();
  final focus7 = FocusNode();

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
  List<StatutoryBenefitsData> statutoryData = [];
  List<StatutoryBenefitsData> socialData = [];
  List<StatutoryBenefitsData> otherData = [];

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

  EditBulkJob() async {
    _jobTitleController.text =
        widget.campusJobDetailResponseData?.jobTitle ?? "";
    _jobDescriptionController.text =
        widget.campusJobDetailResponseData?.jobDescription ?? "";
    qualificationOption=(widget.campusJobDetailResponseData?.qualification ?? "").split(",").map((e) => e.trim()).toList();
    specilizationOption=(widget.campusJobDetailResponseData?.specialization ?? "").split(",").map((e) => e.trim()).toList();
    preferredlocationOption=(widget.campusJobDetailResponseData?.location ?? "").split(",").map((e) => e.trim()).toList();

    _currentArrear.text =
        widget.campusJobDetailResponseData?.currentArrears ?? "";
    _historyOfArrear.text =
        widget.campusJobDetailResponseData?.historyOfArrears ?? "";
    _requriedPercentage.text =
        widget.campusJobDetailResponseData?.requiredPercentage ?? "";
    _Location.text = widget.campusJobDetailResponseData?.location ?? "";
    _salaryFrom.text = widget.campusJobDetailResponseData?.salaryFrom ?? "";
    _salaryTo.text = widget.campusJobDetailResponseData?.salaryTo ?? "";
    statutoryVal =
        widget.campusJobDetailResponseData?.statutoryBenefits ?? "";
    socialVal =
        widget.campusJobDetailResponseData?.socialBenefits ?? "";
    otherVal =
        widget.campusJobDetailResponseData?.otherBenefits ?? "";
    _vacancies.text = widget.campusJobDetailResponseData?.vacancies ?? "";
    noOfRoundsOption = widget.campusJobDetailResponseData?.rounds ?? "";
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.isEditBulk == true ? EditBulkJob() : null;
    loadQualificationOptions();
    loadSpecilizationOptions();
     StatutoryBenifitsResponse();
     SocialBenifitsResponse();
     OtherBenifitsResponse();
    _jobTitleController.addListener(_JobTitleFormat);
    _jobDescriptionController.addListener(_JobDescriptionFormat);
  }

  String? selectedOption;
  String? selectExpVal;
  final _formKey = GlobalKey<FormState>();

  TextEditingController _jobTitleController = TextEditingController();
  TextEditingController _Location = TextEditingController();
  TextEditingController _currentArrear = TextEditingController();
  TextEditingController _historyOfArrear = TextEditingController();
  TextEditingController _requriedPercentage = TextEditingController();
  TextEditingController _jobDescriptionController = TextEditingController();
  TextEditingController _vacancies = TextEditingController();
  TextEditingController _salaryFrom = TextEditingController();
  TextEditingController _salaryTo = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Custom_AppBar(
          isUsed: false,
          actions: [],
          isLogoUsed: true,
          title: "Bulk Job",
          isTitleUsed: true,
        ),
        body: Form(
            key: _formKey, // Associate the form with the GlobalKey
            child: Container(
              margin: EdgeInsets.only(left: 20, top: 25, right: 20),
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                      Title_Style(Title: 'Job Description', isStatus: true),
                      textfieldDescription(
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
                        hintT: 'Job Description',
                      ),
                      Title_Style(Title: 'Job Location', isStatus: true),
                      InkWell(
                        onTap: () {
                          focus2.unfocus();
                          focus3.unfocus();

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

                      //No Of Vacancies
                      Title_Style(Title: 'No of Vacancies', isStatus: true),
                      textFormField(
                        hintText: 'Vacancy Details',
                        keyboardtype: TextInputType.number,
                        inputFormatters: null,
                        Controller: _vacancies,
                        validating: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please Enter Vacancy Details";
                          }
                          if (value == null) {
                            return "Please Enter Vacancy Details";
                          }
                          return null;
                        },
                        onChanged: null,
                      ),

                      //Qualification
                      Title_Style(Title: 'Qualification', isStatus: true),
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

                      //Specilatiztion
                      Title_Style(Title: 'Specialization', isStatus: true),
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
                      // SpecializationdropDownSearchField(
                      //   context,
                      //   listValue: specilizationVal,
                      //   onChanged: ((x) {
                      //     focus3.unfocus();

                      //     setState(() {
                      //       SpecializationData result =
                      //           specilizationVal.firstWhere((value) =>
                      //               value.specialization == x.searchKey);

                      //       // Print the result
                      //       print(result.id);

                      //       specilizationOption = result.id;
                      //     });
                      //   }),
                      //   focus: focus3,
                      //   validator: (x) {
                      //     if (x!.isEmpty) {
                      //       return 'Please Select Specialization';
                      //     }
                      //     return null;
                      //   },
                      //   hintText: 'Specialization',
                      // ),
                      //Current Arrears
                      Title_Style(Title: 'Current Arrears', isStatus: false),
                      textFormField(
                        hintText: 'Current Arrear',
                        keyboardtype: TextInputType.number,
                        inputFormatters: null,
                        Controller: _currentArrear,
                        validating: null,
                        onChanged: null,
                      ),
                      //History of Arrears
                      Title_Style(Title: 'History of Arrears', isStatus: false),
                      textFormField(
                        hintText: 'History of Arrears',
                        keyboardtype: TextInputType.number,
                        inputFormatters: null,
                        Controller: _historyOfArrear,
                        validating: null,
                        onChanged: null,
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
                      //Salary Range
                      Title_Style(
                          Title: "Salary Range (Per Annum)", isStatus: true),
                      Row(
                        children: [
                          Container(
                            width: 150,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "From",
                                  style: durationT,
                                ),
                                textFormField(
                                  hintText: '',
                                  keyboardtype: TextInputType.number,
                                  inputFormatters: null,
                                  Controller: _salaryFrom,
                                  validating: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please Enter Valid Numbers";
                                    }
                                    if (value == null) {
                                      return "Please Enter Valid Numbers";
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
                            width: 150,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "To",
                                  style: durationT,
                                ),
                                textFormField(
                                  hintText: '',
                                  keyboardtype: TextInputType.number,
                                  inputFormatters: null,
                                  Controller: _salaryTo,
                                  validating: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please Enter Valid Numbers";
                                    }
                                    if (value == null) {
                                      return "Please Enter Valid Numbers";
                                    }
                                    return null;
                                  },
                                  onChanged: null,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ), //Rounds
                      Title_Style(Title: 'Number Of Rounds', isStatus: true),
                      dropDownField(
                        context,
                        value: noOfRoundsOption,
                        listValue: noOfRounds,
                        onChanged: (String? newValue) {
                          setState(() {
                            noOfRoundsOption = newValue;
                          });
                        },
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
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 60, bottom: 25),
                          child: Container(
                            height: 45,
                            width: 200,
                            child: CommonElevatedButton(context,
                                widget.isEditBulk == true ?"Update Job": "Create Job",
                                    () => widget.isEditBulk == true
                                    ? EditBulkJobApiResponse()
                                    : BulkJobApiResponse()),
                          ),
                        ),
                      ),
                    ]),
              ),
            )));
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
        "job_title": _jobTitleController.text,
        "recruiter_id": await getRecruiterId(),
        "job_description": _jobDescriptionController.text,
        "qualification": qualifiationArrayValue.join(","),
        "specialization": specializaArrayValue.join(","),
        "current_arrears": _currentArrear.text,
        "history_of_arrears": _historyOfArrear.text,
        "required_percentage": _requriedPercentage.text,
        "location": "Coimbatore", //_Location.text,
        "salary_from": _salaryFrom.text,
        "salary_to": _salaryTo.text,
        "statutory_benefits": statutoryVal,
        "social_benefits": socialVal,
        "other_benefits": otherVal,
        "vacancies": _vacancies.text,
        "rounds": noOfRoundsOption,
        "campus_id": widget.campus_Id,
      });
      final bulkJobApiResponse = await bulkJobApiService.post<BulkJobModel>(
          context, ConstantApi.bulkJobUrl, formData);

      if (bulkJobApiResponse.status == true) {
        Navigator.pop(context);
        print("BULK POSTED SUCCESS");
        ShowToastMessage(bulkJobApiResponse?.message ?? "");
      } else {
        print("BULK POSTED ERROR");
        ShowToastMessage(bulkJobApiResponse?.message ?? "");
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
        "job_title": _jobTitleController.text,
        "recruiter_id": await getRecruiterId(),
        "job_description": _jobDescriptionController.text,
        "qualification": qualifiationArrayValue.join(","),
        "specialization": specializaArrayValue.join(","),
        "current_arrears": _currentArrear.text,
        "history_of_arrears": _historyOfArrear.text,
        "required_percentage": _requriedPercentage,
        "location": preferredlocationOption,
        "salary_from": _salaryFrom.text,
        "salary_to": _salaryTo.text,
        "statutory_benefits": statutoryVal,
        "social_benefits": socialVal,
        "other_benefits": otherVal,
        "vacancies": _vacancies.text,
        "rounds": noOfRoundsOption,
        "campus_id": widget.campus_Id,
        "job_id": widget.job_Id,
      });
      final bulkJobApiResponse = await bulkJobApiService.post<BulkJobModel>(
          context, ConstantApi.editbulkJobUrl, formData);

      if (bulkJobApiResponse.status == true) {
        Navigator.pop(context);
        print("EDIT BULK JOB SUCCESS");
        ShowToastMessage(bulkJobApiResponse.message ?? "");
      } else {
        print("EDIT BULK JOB ERROR");
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
