import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:getifyjobs/Models/RegistrationModel.dart';
import 'package:getifyjobs/Src/Common_Widgets/Common_Button.dart';
import 'package:getifyjobs/Src/Common_Widgets/Custom_App_Bar.dart';
import 'package:getifyjobs/Src/Common_Widgets/Image_Path.dart';
import 'package:getifyjobs/Src/Common_Widgets/Text_Form_Field.dart';
import 'package:getifyjobs/Src/Recruiter_Web_Screens/Recuiter_Login/Recuiter_Web_Login_Screen.dart';
import 'package:getifyjobs/Src/utilits/ApiService.dart';
import 'package:getifyjobs/Src/utilits/Common_Colors.dart';
import 'package:getifyjobs/Src/utilits/ConstantsApi.dart';
import 'package:getifyjobs/Src/utilits/Generic.dart';
import 'package:getifyjobs/Src/utilits/Text_Style.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

class Recruiter_Web_Create_Account extends ConsumerStatefulWidget {
  const Recruiter_Web_Create_Account({super.key});

  @override
  ConsumerState<Recruiter_Web_Create_Account> createState() =>
      _Recruiter_Web_Create_AccountState();
}

class _Recruiter_Web_Create_AccountState
    extends ConsumerState<Recruiter_Web_Create_Account> {
  TextEditingController _RecruiterName = TextEditingController();
  TextEditingController _dob = TextEditingController();
  TextEditingController _CompanyName = TextEditingController();
  TextEditingController _IndustryType = TextEditingController();
  TextEditingController _CompanyStartDate = TextEditingController();
  TextEditingController _AboutCompany = TextEditingController();
  TextEditingController _OfficialEmail = TextEditingController();
  TextEditingController _OfficialMobile = TextEditingController();
  TextEditingController _Address = TextEditingController();
  TextEditingController _OtherBranchName = TextEditingController();
  TextEditingController _PhoneNumber = TextEditingController();
  TextEditingController _CreatePassword = TextEditingController();
  TextEditingController _Refferal = TextEditingController();

  bool _isChecked = false;
  bool _isChecked1 = false;
  bool _isbranchNeed = false;
  Uint8List? _image;
  int? _value;

  final _formKey = GlobalKey<FormState>();

  int? Other_Branch;
  String? SelectOption;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white2,
      appBar: Custom_AppBar(
        isUsed: true,
        actions: null,
        isLogoUsed: true,
        isTitleUsed: true,
        title: "Create Account",
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
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Container(
                    decoration: BoxDecoration(
                        color: white1,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(20))),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 50),
                          decoration: BoxDecoration(color: white1),
                          child: Center(
                              child: Container(
                            width: MediaQuery.of(context).size.width * 0.35,
                            height: MediaQuery.of(context).size.height * 0.70,
                            color: white1,
                            child: Logo(context),
                          )),
                        ),
                        // Center(child: Padding(
                        //   padding: const EdgeInsets.only(left: 20,right: 20,bottom: 80),
                        //   child: Container(
                        //     color:white1,
                        //       child: ImgPathSvg('create.svg')),
                        // )),
                      ],
                    ),
                  ),
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
                          profile_Picker(),
                          //RECRUITER AND DOB
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      //Recruiter Name
                                      Title_Style2(
                                          Title: 'Recruiter Name',
                                          isStatus: true),
                                      Container(
                                        child: textFormField2(
                                          hintText: 'Recruiter Name',
                                          keyboardtype: TextInputType.text,
                                          inputFormatters: null,
                                          Controller: _RecruiterName,
                                          validating: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "Please Enter Recruiter Name";
                                            }
                                            if (value == null) {
                                              return "Please Enter Recruiter Name";
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
                                      Title_Style2(
                                          Title: 'Date of Birth',
                                          isStatus: true),
                                      Container(
                                        child: textFormField2(
                                          hintText: 'Date of birth',
                                          keyboardtype: TextInputType.number,
                                          inputFormatters: null,
                                          Controller: _dob,
                                          validating: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "Please Enter valid Dob";
                                            }
                                            if (value == null) {
                                              return "Please Enter Valid Dob";
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
                          //COMPANY NAME AND INDUSTRY TYPE
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      //Recruiter Name
                                      Title_Style2(
                                          Title: 'Company Name',
                                          isStatus: true),
                                      Container(
                                        child: textFormField2(
                                          hintText: 'Company Name',
                                          keyboardtype: TextInputType.text,
                                          inputFormatters: null,
                                          Controller: _CompanyName,
                                          validating: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "Please Enter Company Name";
                                            }
                                            if (value == null) {
                                              return "Please Enter Company Name ";
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
                                      Title_Style2(
                                          Title: 'Industry Type',
                                          isStatus: true),
                                      Container(
                                        child: textFormField2(
                                          hintText: 'Industry Type',
                                          keyboardtype: TextInputType.number,
                                          inputFormatters: null,
                                          Controller: _IndustryType,
                                          validating: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "Please Enter valid Industry Type";
                                            }
                                            if (value == null) {
                                              return "Please Enter Valid Industry Type";
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
                          //COMPANY START DATE
                          Title_Style2(
                              Title: 'Company Started Date', isStatus: true),
                          Container(
                            child: textFormField2(
                              hintText: 'Started Date',
                              keyboardtype: TextInputType.number,
                              inputFormatters: null,
                              Controller: _CompanyStartDate,
                              validating: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please Enter valid Started Date";
                                }
                                if (value == null) {
                                  return "Please Enter Valid Started Date";
                                }
                                return null;
                              },
                              onChanged: null,
                            ),
                          ),

                          //ABOUT COMPANY
                          Title_Style2(Title: 'About Company', isStatus: true),
                          Container(
                            child: textfieldDescription2(
                              Controller: _AboutCompany,
                              validating: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please Enter ${'About Company'}";
                                }
                                if (value == null) {
                                  return "Please Enter ${'About Company'}";
                                }
                                return null;
                              },
                              hint: 'Enter About Company',
                            ),
                          ),
                          //ENTER OFFICIAL EMAIL ADDRESS AND ENTER MOBILE NUMBER
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
                                          Title: 'Enter Official Email Address',
                                          isStatus: true),
                                      Container(
                                        child: textFormField2(
                                          hintText: 'Email Address',
                                          keyboardtype: TextInputType.text,
                                          inputFormatters: null,
                                          Controller: _OfficialEmail,
                                          validating: (value) {
                                            if (value!.isEmpty) {
                                              return "Please enter a Email Address";
                                            } else if (!RegExp(
                                                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                                .hasMatch(value)) {
                                              return "Please enter a valid Email Address";
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
                                      //YEAR OF EXPERIENCE
                                      Title_Style2(
                                          Title: 'Enter Official Mobile Number',
                                          isStatus: true),
                                      Container(
                                        child: textFormField2(
                                          hintText:
                                              'Enter Official Mobile Number',
                                          keyboardtype: TextInputType.text,
                                          inputFormatters: null,
                                          Controller: _OfficialMobile,
                                          validating: (value) {
                                            if (value!.isEmpty) {
                                              return "Please enter a mobile number";
                                            } else if (!RegExp(r"^[0-9]{10}$")
                                                .hasMatch(value)) {
                                              return "Please enter a valid 10-digit mobile number";
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
                          //LOCATION
                          Title_Style2(
                              Title: 'Enter Company Address', isStatus: true),
                          Container(
                            child: textfieldDescription2(
                              Controller: _Address,
                              validating: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please Enter ${'Address'}";
                                }
                                if (value == null) {
                                  return "Please Enter ${'Address'}";
                                }
                                return null;
                              },
                              hint: 'Enter Company Address',
                            ),
                          ),
                          //OTHER BRANCH AND BRANCH NAME
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
                                          Title:
                                              'Do you have any other Branch?',
                                          isStatus: true),
                                      Container(
                                        margin: EdgeInsets.only(bottom: 20),
                                        child: RadioButton(
                                          groupValue1: Other_Branch,
                                          groupValue2: Other_Branch,
                                          onChanged1: (value) {
                                            setState(() {
                                              _isbranchNeed = true;
                                              Other_Branch = value;
                                            });
                                          },
                                          onChanged2: (value) {
                                            setState(() {
                                              Other_Branch = value;
                                              _isbranchNeed = false;
                                            });
                                          },
                                          radioTxt1: 'Yes',
                                          radioTxt2: 'No',
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
                                      //Enter Branch Name
                                      _isbranchNeed == true
                                          ? Title_Style2(
                                              Title: 'Enter Branch Name',
                                              isStatus: true)
                                          : Container(),
                                      _isbranchNeed == true
                                          ? Container(
                                              child: textFormField2(
                                                hintText: 'Branch Name',
                                                keyboardtype:
                                                    TextInputType.text,
                                                inputFormatters: null,
                                                Controller: _OtherBranchName,
                                                validating: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return "Please Enter Branch Name";
                                                  }
                                                  if (value == null) {
                                                    return "Please Enter Branch Name";
                                                  }
                                                  return null;
                                                },
                                                onChanged: null,
                                              ),
                                            )
                                          : Container(),
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
                                          Title: 'Phone Number',
                                          isStatus: true),
                                      Container(
                                        child: textFormField2(
                                          hintText: 'Phone Number',
                                          keyboardtype: TextInputType.text,
                                          inputFormatters: null,
                                          Controller: _PhoneNumber,
                                          validating: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "Please Enter Valid Phone Number";
                                            }
                                            if (value == null) {
                                              return "Please Enter Valid Phone Number";
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
                                      //Statutory Benefit
                                      Title_Style2(
                                          Title: 'Create Password',
                                          isStatus: false),
                                      Container(
                                        child: textFormField2(
                                          hintText: 'Create Password',
                                          keyboardtype: TextInputType.text,
                                          inputFormatters: null,
                                          Controller: _CreatePassword,
                                          validating: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "Please Enter valid Password";
                                            }
                                            if (value == null) {
                                              return "Please Enter Valid Password";
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
                          //SOCIAL BENEFITS AND OTHER BENEFITS
                          Title_Style2(Title: 'Referral Code', isStatus: false),
                          Container(
                            child: textFormField2(
                              hintText: 'Referral Code',
                              keyboardtype: TextInputType.text,
                              inputFormatters: null,
                              Controller: _Refferal,
                              validating: null,
                              onChanged: null,
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          //CHECK BOX
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CheckBoxes(
                                  value: _isChecked,
                                  onChanged: (value) {
                                    setState(() {
                                      setState(() => _isChecked = !_isChecked);
                                    });
                                  },
                                  checkBoxText: ''),
                              InkWell(
                                  onTap: () async {
                                    await launch(
                                        'https://getifyjobs.com/terms-and-conditions');
                                  },
                                  child: Text(
                                    "Terms & Condition",
                                    style: refferalCountT,
                                  )),
                            ],
                          ),

                          CheckBoxes(
                              value: _isChecked1,
                              onChanged: (value) {
                                setState(() {
                                  setState(() => _isChecked1 = !_isChecked1);
                                });
                              },
                              checkBoxText:
                                  'Do you wish to receive updates, newsletter & marketing campaigns?'),
                          InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Recuiter_Web_Login_Screen()));
                              },
                              child: AlreadyAccount(
                                txt1: 'If you already have a account, click ',
                                txt2: 'Log In',
                              )),

                          //COMMON ELEVATED BUTTON
                          Container(
                              alignment: Alignment.center,
                              width: 350,
                              margin: EdgeInsets.only(
                                  left: 150, top: 25, bottom: 30),
                              child: CommonElevatedButton(context, 'Next',
                                  () async {
                                if (_formKey.currentState!.validate()) {
                                  print("object");
                                  registrationApiResponse();
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

  Future<void> registrationApiResponse() async {
    final registerApiService = ApiService(ref.read(dioProvider));

    var formData = FormData.fromMap({
      "name": _RecruiterName.text,
      "dob": _dob.text,
      "company_name": _CompanyName.text,
      "industry_type": _IndustryType.text,
      "company_start_date": _CompanyStartDate.text,
      "about_company": _AboutCompany.text,
      "email": _OfficialEmail.text,
      "phone": _OfficialMobile.text,
      "address": _Address.text,
      "other_branch": _value == 0 ? 'no' : "yes",
      "branch_name": _OtherBranchName.text,
      "personal_phone": _PhoneNumber.text,
      "password": _CreatePassword.text,
      "location": SingleTon().setLocation,
      "referral_code": _Refferal.text,
      "advertisement": _isChecked1,
      "device_token": "",
      "device_id": ""
    });
    print("LOCATION : ${SingleTon().setLocation}");

    formData.files.addAll([
      MapEntry('logo', MultipartFile.fromBytes(_image!)),
    ]);

    final recruiterResponse = await registerApiService.post<RegistrationModel>(
        context, ConstantApi.registrationUrl, formData);
    print('RECRUITER ID : ${recruiterResponse?.data?.recruiterId ?? ""}');

    if (recruiterResponse.status == true) {
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
                    onTap: () async {
                      FilePickerResult? result =
                          await FilePicker.platform.pickFiles(
                        type: FileType.image,
                        allowMultiple: false,
                      );
                      if (result != null) {
                        _loadImage(result);
                      }
                    },
                    child: CircleAvatar(
                        radius: 40,
                        backgroundColor: white4,
                        backgroundImage: _image != null
                            ? Image.memory(
                                _image!,
                                cacheWidth: 50,
                                cacheHeight: 50,
                              ).image
                            : null //FileImage(_image!) : null,
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

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        // _image = File(pickedFile.file.f);
      });
    }
    Navigator.pop(context); // Close the bottom sheet after selecting an image
  }

  Future<void> _loadImage(FilePickerResult result) async {
    if (result.files.isNotEmpty) {
      _image = result.files.first.bytes;
      setState(() {});
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
                  setState(() async {
                    // _pickImage(ImageSource.camera);
                    FilePickerResult? result =
                        await FilePicker.platform.pickFiles(
                      type: FileType.image,
                      allowMultiple: false,
                    );
                    if (result != null) {
                      _loadImage(result);
                    }
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
