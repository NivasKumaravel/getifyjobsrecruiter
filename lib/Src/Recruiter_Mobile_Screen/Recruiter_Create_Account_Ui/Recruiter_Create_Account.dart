import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:getifyjobs/Models/IndustryModel.dart';
import 'package:getifyjobs/Models/LoginModel.dart';
import 'package:getifyjobs/Models/ProfileModel.dart';
import 'package:getifyjobs/Models/RegistrationModel.dart';
import 'package:getifyjobs/Src/Common_Widgets/Custom_App_Bar.dart';
import 'package:getifyjobs/Src/Common_Widgets/Image_Path.dart';
import 'package:getifyjobs/Src/Recruiter_Mobile_Screen/Recruiter_Login_Ui/Recruiter_Login_Page.dart';
import 'package:getifyjobs/Src/Recruiter_Mobile_Screen/Recruiter_Otp_Verification_Ui/Recruiter_Otp_Verification_Screen.dart';
import 'package:getifyjobs/Src/utilits/ApiService.dart';
import 'package:getifyjobs/Src/utilits/ConstantsApi.dart';
import 'package:getifyjobs/Src/utilits/Generic.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Common_Widgets/Common_Button.dart';
import '../../Common_Widgets/Common_Map_Picker.dart';
import '../../Common_Widgets/Text_Form_Field.dart';
import '../../utilits/Common_Colors.dart';
import '../../utilits/Text_Style.dart';

class Recruiter_Create_Account_Screen extends ConsumerStatefulWidget {
  bool? isEdit;
  ProfileData? editResponse;
  Recruiter_Create_Account_Screen(
      {super.key, required this.isEdit, required this.editResponse});

  @override
  ConsumerState<Recruiter_Create_Account_Screen> createState() =>
      _Recruiter_Create_Account_ScreenState();
}

class _Recruiter_Create_Account_ScreenState
    extends ConsumerState<Recruiter_Create_Account_Screen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    EditeResponse();
    industryLoadListResponse();
    _RecruiterName.addListener(_RecruiterNameFormat);
    _CompanyName.addListener(_CompanyNameFormat);
    _Address.addListener(_AddressFormat);
    _AboutCompany.addListener(_AboutCompanyFormat);
    _EnterBranchName.addListener(_BranchFormat);
  }

  final _formKey = GlobalKey<FormState>();
  File? _image;
  String? Location;
  int? _value;
  bool _isChecked = false;
  bool _isChecked1 = false;
  bool _isbranchNeed = false;
  String? _password;
  bool _obscurePassword = true; // Initially hide the password

  FocusNode _focusNode = FocusNode();
  FocusNode _focusNode1 = FocusNode();
  FocusNode _focusNode3 = FocusNode();


  @override
  void dispose() {
    _focusNode.dispose();
    _focusNode1.dispose();
    _focusNode3.dispose();
    focusind.dispose();
    super.dispose();
  }


  //PASSWORD VISIBILITY FUNCTION
  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Alert"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                _Dob.text = "";
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }
  void _RecruiterNameFormat() {
    final text = _RecruiterName.text;
    final formattedText = _toTitleCase(text);
    if (text != formattedText) {
      _RecruiterName.value = TextEditingValue(
        text: formattedText,
        selection: TextSelection.collapsed(offset: formattedText.length),
      );
    }
  }
  void _CompanyNameFormat() {
    final text = _CompanyName.text;
    final formattedText = _toTitleCase(text);
    if (text != formattedText) {
      _CompanyName.value = TextEditingValue(
        text: formattedText,
        selection: TextSelection.collapsed(offset: formattedText.length),
      );
    }
  }
  void _AddressFormat() {
    final text = _Address.text;
    final formattedText = _toTitleCase(text);
    if (text != formattedText) {
      _Address.value = TextEditingValue(
        text: formattedText,
        selection: TextSelection.collapsed(offset: formattedText.length),
      );
    }
  }
  void _AboutCompanyFormat() {
    final text = _AboutCompany.text;
    final formattedText = _toTitleCase(text);
    if (text != formattedText) {
      _AboutCompany.value = TextEditingValue(
        text: formattedText,
        selection: TextSelection.collapsed(offset: formattedText.length),
      );
    }
  }
  void _BranchFormat() {
    final text = _EnterBranchName.text;
    final formattedText = _toTitleCase(text);
    if (text != formattedText) {
      _EnterBranchName.value = TextEditingValue(
        text: formattedText,
        selection: TextSelection.collapsed(offset: formattedText.length),
      );
    }
  }


  String _toTitleCase(String text) {
    if (text.isEmpty) return '';

    return text.toLowerCase().split(' ').map((word) {
      if (word.isNotEmpty) {
        return word[0].toUpperCase() + word.substring(1);
      }
      return '';
    }).join(' ');
  }

  String? _validateTerms(bool? value) {
    if (value != true) {
      return 'Please click on the terms and conditions box.';
    }
    return null;
  }



  bool isSameAsOfficial = false;
  TextEditingController _RecruiterName = TextEditingController();
  TextEditingController _Dob = TextEditingController();
  TextEditingController _CompanyName = TextEditingController();
  TextEditingController _IndustryType = TextEditingController();
  TextEditingController _CompanyStartedDate = TextEditingController();
  TextEditingController _AboutCompany = TextEditingController();
  String _isLimitExceeded = '';
  TextEditingController _EnterOfficialEmail = TextEditingController();
  TextEditingController _EnterOfficialMobile = TextEditingController();
  TextEditingController _Address = TextEditingController();
  TextEditingController _EnterBranchName = TextEditingController();
  TextEditingController _Phonenumber = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _referralCodeController = TextEditingController();

  List<IndustryData> IndustryVal = [];
  List<String>? industryOption;

  final focusind = FocusNode();

  //VALIDATOR
  RegExp passwordSpecial = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$])(?=.*[0-9]).*$');
  RegExp passwordLength = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$])(?=.*[0-9]).{8,15}$');
  RegExp onlyText = RegExp(r'^[a-zA-Z ]+$');



  EditeResponse() {
    if (widget.editResponse != null) {
      _RecruiterName.text = widget.editResponse?.name ?? "";
      _Dob.text = widget.editResponse?.dob ?? "";
      _CompanyName.text = widget.editResponse?.companyName ?? "";
      _CompanyStartedDate.text = widget.editResponse?.companyStartDate ?? "";
      _AboutCompany.text = widget.editResponse?.aboutCompany ?? "";
      industryOption = (widget.editResponse?.industry ?? "").split(',').map((item) => item.trim()).toList();
      _EnterOfficialEmail.text = widget.editResponse?.email ?? "";
      _EnterOfficialMobile.text = widget.editResponse?.phone ?? "";
      _Address.text = widget.editResponse?.address ?? "";
      _Phonenumber.text = widget.editResponse?.personalPhone ?? "";
      Location = widget.editResponse?.location ?? "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white2,
      appBar: widget.isEdit == true
          ? Custom_AppBar(
              isUsed: true,
              actions: null,
              isLogoUsed: true,
              isTitleUsed: true,
              title: "Edit Profile",
            )
          : null,
      body: GestureDetector(
        onTap: (){
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: widget.isEdit == true ? 20 : 50, bottom: 20),
                  child: Logo(context),
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                      color: white1),
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 35, bottom: 5),
                          child: widget.isEdit == true ? Title_Heading("Edit Profile")
                              : Title_Heading("Create Account"),
                        ),
                        profile_Picker(),

                        //RECRUITER NAME
                        Title_Style(Title: 'Recruiter Name', isStatus: true),
                        textFormField(
                          hintText: 'Recruiter Name',
                          keyboardtype: TextInputType.text,
                          inputFormatters: null,
                          Controller: _RecruiterName,
                          focusNode: _focusNode,
                          validating: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please Enter Your ${'Name'}";
                            }
                            if (!onlyText.hasMatch(value)) {
                              return "Special characters are Not Allowed";
                            }
                            return null;
                          },
                          onChanged: null,
                        ),

                        //DATE OF BIRTH
                        Title_Style(Title: 'Date of Birth', isStatus: true),
                        TextFieldDatePicker(
                          Controller: _Dob,
                          onChanged: null,
                          hintText: 'dd/MM/yyyy',
                          onTap: () async {
                            FocusScope.of(context).unfocus();
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1950),
                              lastDate: DateTime.now(),
                            );
                            if (pickedDate != null) {
                              String formattedDate =
                                  DateFormat("dd/MM/yyyy").format(pickedDate);
                              if (mounted) {
                                setState(() {
                                  _Dob.text = formattedDate;
                                });
                              }
                              DateTime currentDate = DateTime.now();
                              int age = currentDate.year - pickedDate.year;
                              if (age < 18) {
                                _showErrorDialog(
                                    "You must be at least 18 years old to register.");
                              }
                            }
                          },
                          validating: (value) {
                            if (value!.isEmpty) {
                              return 'Please Select Date of Birth';
                            } else {
                              DateTime selectedDate =
                                  DateFormat("dd/MM/yyyy").parse(value);
                              DateTime currentDate = DateTime.now();
                              int age = currentDate.year - selectedDate.year;
                              if (age < 18) {
                                return 'You must be at least 18 years old to register.';
                              } else {
                                return null;
                              }
                            }
                          }, isDownArrow: false,
                        ),

                        //COMPANY NAME
                        Title_Style(Title: 'Company Name', isStatus: true),
                        textFormField(
                          hintText: 'Company Name',
                          keyboardtype: TextInputType.text,
                          inputFormatters: null,
                          Controller: _CompanyName,
                          focusNode: _focusNode1,
                          validating: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please Enter Valid ${'Company Name'}";
                            }
                            if (value == null) {
                              return "Please Enter Valid ${'Company Name'}";
                            }
                            return null;
                          },
                          onChanged: null,
                        ),

                        //INDUSTRY TYPE
                        Title_Style(Title: 'Industry Type', isStatus: true),
                    IndustryTypeField(
                      hintText: "Please Select Industry Type",
                      focus: focusind,
                      listValue: IndustryVal,
                      focusTagEnabled: false,
                      values: industryOption ?? [],
                      onPressed: (p0) {
                        print(p0);
                        setState(() {
                          industryOption = p0;
                        });
                      },
                    ),

                        //COMPANY STARTED DATE
                        Title_Style(
                            Title: 'Company Started Date', isStatus: true),
                        TextFieldDatePicker(
                            Controller: _CompanyStartedDate,
                            onChanged: null,
                            validating: (value) {
                              if (value!.isEmpty) {
                                return 'Please Select Your Company Started Date';
                              } else {
                                return null;
                              }
                            },
                            onTap: () async {
                              FocusScope.of(context).unfocus();
                              DateTime? pickdate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1950),
                                  lastDate: DateTime.now());
                              if (pickdate != null) {
                                String formatdate =
                                    DateFormat("dd/MM/yyyy").format(pickdate!);
                                if (mounted) {
                                  setState(() {
                                    _CompanyStartedDate.text = formatdate;
                                    print(_CompanyStartedDate.text);
                                  });
                                }
                              }
                            },
                            hintText: 'dd/MM/yyyy', isDownArrow: false),

                        //ABOUT COMPANY
                        Title_Style(Title: 'About Company', isStatus: true),
                        textfieldDescription(
                          Controller: _AboutCompany,
                          maxLength: 500,
                          focusNode: _focusNode3,
                          validating: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please Enter ${'About Company'}";
                            }
                            if (value == null) {
                              return "Please Enter ${'About Company'}";
                            }
                            return null;
                          },
                          hintT: 'Description',
                        ),


                        //Enter Official Email Address*
                        Title_Style(
                            Title: 'Enter Official Email Address',
                            isStatus: true),
                        textFormField(
                          hintText: 'Email Address',
                          keyboardtype: TextInputType.text,
                          inputFormatters: null,
                          Controller: _EnterOfficialEmail,
                          validating: (value) {
                            if (value!.isEmpty) {
                              return "Please Enter Your Official Email Address";
                            } else if (!RegExp(
                                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                .hasMatch(value)) {
                              return "Please Enter a Valid Email Address";
                            }
                            return null;
                          },
                          onChanged: null,
                        ),

                        //Enter Official Mobile Number*
                        widget.isEdit == true? Container(): Title_Style(
                            Title: 'Enter Official Mobile Number',
                            isStatus: true),
                        widget.isEdit == true? Container(): textFormField(
                          hintText: 'Official Mobile Number',
                          keyboardtype: TextInputType.phone,
                          inputFormatters: [LengthLimitingTextInputFormatter(10)],
                          Controller: _EnterOfficialMobile,
                          validating: (value) {
                            if (value!.isEmpty) {
                              return "Please Enter a Mobile Number";
                            } else if (!RegExp(r"^[0-9]{10}$").hasMatch(value)) {
                              return "Please enter a valid 10-digit mobile number";
                            }
                            return null;
                          },
                          onChanged: null,
                        ),

                        //ADDRESS
                        Title_Style(
                            Title: 'Enter Company Address', isStatus: true),
                        textfieldDescription(
                          Controller: _Address,
                          validating: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please Enter ${'Company Address'}";
                            }
                            if (value == null) {
                              return "Please Enter ${'Company Address'}";
                            }
                            return null;
                          },
                          hintT: 'Company Address',
                        ),

                        //DO YOU HAVE ANY OTHER BRANCH
                        Title_Style(
                            Title: 'Do you have any other Branch?',
                            isStatus: true),
                        _RadioButton(),

                        //Enter Branch Name*
                        _isbranchNeed == true
                            ? Title_Style(
                                Title: 'Enter Branch Name', isStatus: true)
                            : Container(),
                        _isbranchNeed == true
                            ? textfieldDescription(
                                Controller: _EnterBranchName,
                                validating: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please Enter ${'Branch Name'}";
                                  }
                                  if (value == null) {
                                    return "Please Enter ${'Branch Name'}";
                                  }
                                  return null;
                                },
                                hintT: 'Branch Name',
                              )
                            : Container(),

                        _isbranchNeed == true
                            ? SubText(
                                "If you have multiple Branches Add with Commas")
                            : Container(),

                        //Enter Phone Number*
                        widget.isEdit == true? Container():  Title_Style_NoSp(
                            Title: 'Enter Personal Mobile Number',
                            isStatus: true),
                        widget.isEdit == true? Container():   Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                width: MediaQuery.sizeOf(context).width/1.5,
                                child: Text(
                                    'Is your personal mobile number is same as the official mobile number ?',maxLines: 2,)),
                            const Spacer(),
                            Checkbox(
                              value: isSameAsOfficial,
                              onChanged: (value) {
                                setState(() {
                                  isSameAsOfficial = value!;
                                  if (isSameAsOfficial) {
                                    _Phonenumber.text = _EnterOfficialMobile.text;
                                  }
                                  else {
                                    _Phonenumber.clear();
                                  }
                                });
                              },
                            ),
                          ],
                        ),
                        widget.isEdit == true? Container():    SizedBox(
                          height: 10,
                        ),
                        widget.isEdit == true? Container():  textFormField(
                          hintText: 'Personal Mobile Number',
                          keyboardtype: TextInputType.phone,
                          inputFormatters: [LengthLimitingTextInputFormatter(10)],
                          Controller: _Phonenumber,
                          validating: (value) {
                            if (value!.isEmpty) {
                              return "Please Enter a Personal Mobile Number";
                            } else if (!RegExp(r"^[0-9]{10}$").hasMatch(value)) {
                              return "Please enter a valid 10-digit mobile number";
                            }
                            return null;
                          },
                          onChanged: null,
                        ),

                        //Create Password
                        widget.isEdit == true
                            ? Container()
                            : Title_Style(
                                Title: 'Create Password', isStatus: true),
                        widget.isEdit == true
                            ? Container()
                            : textFieldPassword(
                                Controller: _passwordController,
                                obscure: _obscurePassword,
                                onPressed: _togglePasswordVisibility,
                                hintText: "Password",
                                keyboardtype: TextInputType.text,
                                onChanged: (value) {
                                  setState(() {
                                    _password = value;
                                  });
                                },
                                validating: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please Enter a Password';
                                  } else if (!passwordSpecial.hasMatch(value)) {
                                    return 'Password should be with the combination of Aa@#1';
                                  }else if(!passwordLength.hasMatch(value)){
                                    return "Password should be with minimum 8 and maximum 15 characters";
                                  }
                                  return null;
                                },
                              ),

                        //Referral Code
                        widget.isEdit == true
                            ? Container()
                            : Title_Style(
                                Title: 'Referral Code', isStatus: false),
                        widget.isEdit == true
                            ? Container()
                            : textFormField(
                                hintText: 'Referral Code',
                                keyboardtype: TextInputType.text,
                                inputFormatters: null,
                                Controller: _referralCodeController,
                                validating: null,
                                onChanged: null,
                              ),
                        //MAP
                        // Padding(
                        //   padding: const EdgeInsets.only(bottom: 20),
                        //   child: Container(
                        //     height: 105,
                        //     child: Common_Map(),
                        //   ),
                        // ),
                        const SizedBox(height: 20,),

                        //CHECK BOX
                        widget.isEdit == true
                            ? Container()
                            : CheckBoxes(
                                value: _isChecked,
                                onChanged: (value) {
                                  setState(() {
                                    setState(() => _isChecked = !_isChecked);
                                  });
                                },
                            onTap: ()async{
                              final url = "https://getifyjobs.com/terms-and-conditions";
                              await launch(url,
                                forceSafariVC: true,
                                forceWebView: true,
                                enableJavaScript: true,
                              );
                            },
                                checkBoxText: 'Terms & Conditions'),

                        widget.isEdit == true
                            ? Container()
                            : CheckBoxes(
                                value: _isChecked1,
                                onChanged: (value) {
                                  setState(() {
                                    setState(() => _isChecked1 = !_isChecked1);
                                  });
                                },
                                checkBoxText:
                                    'Do you wish to receive updates, \nnewsletters & marketing campaigns?'),
                        widget.isEdit == true
                            ? Container()
                            : InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Recruiter_Login_Page()));
                                },
                                child: AlreadyAccount(
                                  txt1: 'If you Already Have an Account, Click ',
                                  txt2: 'Log In',
                                )),
                        Padding(
                          padding: const EdgeInsets.only(top: 15, bottom: 50),
                          child: CommonElevatedButton(context,
                              widget.isEdit == true ? "Submit" : "Register", () {
                                FocusManager.instance.primaryFocus?.unfocus();
                                if (_formKey.currentState!.validate()) {

                                 if(widget.isEdit == true){
                                   print("EDIT1");
                                   if (_value == null) {
                                     print("EDIT2");
                                     ScaffoldMessenger.of(context).showSnackBar(
                                       SnackBar(
                                         content: Text('Branch Selection is Required'),
                                       ),
                                     );
                                   }
                                   else if (industryOption == null || industryOption!.isEmpty) {
                                     print("EDIT3");
                                     ScaffoldMessenger.of(context).showSnackBar(
                                       SnackBar(
                                         content: Text("Please Select Valid Industry Type"),
                                       ),
                                     );
                                   }

                                   else {
                                     print("EDIT4");
                                     editProfileApiResponse();

                                   }
                                 }else{
                                   if (_value == null) {
                                     ScaffoldMessenger.of(context).showSnackBar(
                                       SnackBar(
                                         content: Text('Branch Selection is Required'),
                                       ),
                                     );
                                   }
                                   else if (_isChecked == false){
                                     ScaffoldMessenger.of(context).showSnackBar(
                                       SnackBar(
                                         content: Text('Please Read and Agree to Our T&C'),
                                       ),
                                     );
                                   }
                                   else if (industryOption == null || industryOption!.isEmpty) {
                                     ScaffoldMessenger.of(context).showSnackBar(
                                       SnackBar(
                                         content: Text("Please Select Valid Industry Type"),
                                       ),
                                     );
                                   }

                                   else if (_validateTerms(_isChecked) == null) {
                                      registrationApiResponse();
                                   }
                                 }
                                }
                              }),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

//REGISTRATION
  Future<void> registrationApiResponse() async {
    var industryArrayVal = [];

    for (var obj in industryOption!) {
      IndustryData? result = IndustryVal.firstWhere(
              (value) => value.industry == obj,
          orElse: () => IndustryData(
              id: obj, industry: "", ));
      industryArrayVal.add(result.id);
    }
    final registerApiService = ApiService(ref.read(dioProvider));

    var formData = FormData.fromMap({
      "name": _RecruiterName.text,
      "dob": _Dob.text,
      "company_name": _CompanyName.text,
      "industry_type": industryArrayVal.join(','),
      "company_start_date": _CompanyStartedDate.text,
      "about_company": _AboutCompany.text,
      "email": _EnterOfficialEmail.text,
      "phone": _EnterOfficialMobile.text,
      "address": _Address.text,
      "other_branch": _value == 0 ? 'yes' : "no",
      "branch_name": _EnterBranchName.text,
      "personal_phone": _Phonenumber.text,
      "password": _passwordController.text,
      "location": '',
      "referral_code": _referralCodeController.text,
      "advertisement": _isChecked1,
      "device_token": "",
      "device_id": "",
      "latitude":'',
      "longitude":'',
    });
    print("LOCATION : ${SingleTon().setLocation}");

    if (_image != null) {
      List<int> compressedImage = await compressImage(_image!);

      formData.files.addAll([
        MapEntry(
            'logo',
            MultipartFile.fromBytes(
              compressedImage,
              filename: 'compressed_image.jpg',
            )),
      ]);
    }

//await MultipartFile.fromFile(_image!.path)
    // MultipartFile.fromBytes(
    //     compressedImage,
    //     filename: 'compressed_image.jpg',
    //   )

    final recruiterResponse = await registerApiService.post<RegistrationModel>(
        context, ConstantApi.registrationUrl, formData);
    print('RECRUITER ID : ${recruiterResponse?.data?.recruiterId ?? ""}');

    if (recruiterResponse?.status == true) {

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Recruiter_Otp_Verification_Screen(
                    isForget: false,
                    mobileNumber: _Phonenumber.text,
                    recruiterId:
                        recruiterResponse?.data?.recruiterId.toString(),
                  )));
      OfficeAddress(_Address.text);
    } else {
      ShowToastMessage(recruiterResponse.message ?? "");
      print('ERROR');
    }
  }

  //EDIT PROFILE
  Future<void> editProfileApiResponse() async {
    var industryArrayVal = [];

    for (var obj in industryOption!) {
      IndustryData? result = IndustryVal.firstWhere(
              (value) => value.industry == obj,
          orElse: () => IndustryData(
            id: obj, industry: "", ));
      industryArrayVal.add(result.id);
    }
    final registerApiService = ApiService(ref.read(dioProvider));

    var formData = FormData.fromMap({
      "recruiter_id": await getRecruiterId(),
      "name": _RecruiterName.text,
      "dob": _Dob.text,
      "company_name": _CompanyName.text,
      "industry_type": industryArrayVal.join(','),
      "company_start_date": _CompanyStartedDate.text,
      "about_company": _AboutCompany.text,
      "email": _EnterOfficialEmail.text,
      "phone": _EnterOfficialMobile.text,
      "address": _Address.text,
      "other_branch": _value == 0 ? 'yes' : "no",
      "branch_name": _EnterBranchName.text,
      "personal_phone": _Phonenumber.text,
      "password": _passwordController.text,
      "location": 'dummy',
      "referral_code": _referralCodeController.text,
      "advertisement": _isChecked1,
      "device_token": "",
      "device_id": ""
    });
    print("LOCATION : ${SingleTon().setLocation}");
    if (_image != null) {
      List<int> compressedImage = await compressImage(_image!);

      formData.files.addAll([
        MapEntry(
            'logo',
            MultipartFile.fromBytes(
              compressedImage,
              filename: 'compressed_image.jpg',
            )),
      ]);
    }

    final recruiterResponse = await registerApiService.post<RegistrationModel>(
        context, ConstantApi.editProfileUrl, formData);
    print('RECRUITER ID : ${recruiterResponse?.data?.recruiterId ?? ""}');

    if (recruiterResponse?.status == true) {
      Navigator.pop(context);
      OfficeAddress(_Address.text);
    } else {
      ShowToastMessage(recruiterResponse.message ?? "");
      print('ERROR');
    }
  }

  //Profile Picker
  Widget profile_Picker() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Container(
              height: 80,
              width: 80,
              child: Stack(
                children: [
                  InkWell(
                    onTap: _showImagePickerBottomSheet,
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor: white4,
                      backgroundImage:
                          _image != null ? FileImage(_image!) : Image.network(widget.editResponse?.logo ?? "").image,
                    ),
                  ),
                  Positioned(top: 55, child: ImgPathSvg("profilepic.svg")),
                  Positioned(
                      top: 60, left: 32, child: ImgPathSvg("camera.svg")),
                ],
              ),
            ),
          ),
          Title_Style(Title: "Business Logo", isStatus: false),
        ],
      ),
    );
  }

  Widget _RadioButton() {
    return RadioButton(
        groupValue1: _value,
        onChanged1: (value1) {
          setState(() {
            _value = value1;
            _isbranchNeed = true;
            print("Yes");
          });
        },
        radioTxt1: "Yes",
        groupValue2: _value,
        onChanged2: (value2) {
          setState(() {
            _value = value2;
            _isbranchNeed = false;
            print("No");
          });
        },
        radioTxt2: 'No');
  }

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
    Navigator.pop(context); // Close the bottom sheet after selecting an image
  }

  //INDUSTRY RESPONSE
  //QUALIFICATION RESPONSE
  Future<void> industryLoadListResponse() async {
    final apiService = ApiService(ref.read(dioProvider));

    try {
      print(ConstantApi.industryUrl);
      final response = await apiService.get<IndustryModel>(
          context, ConstantApi.industryUrl);

      setState(() {
        IndustryVal = response.data ?? []; // Assuming data is a List<Data>
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  void _showImagePickerBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.camera),
                title: Text('Take Photo'),
                onTap: () {
                  setState(() {
                    _pickImage(ImageSource.camera);
                  });
                },
              ),
              ListTile(
                leading: Icon(Icons.photo),
                title: Text('Choose from Gallery'),
                onTap: () {
                  setState(() {
                    _pickImage(ImageSource.gallery);
                  });
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
