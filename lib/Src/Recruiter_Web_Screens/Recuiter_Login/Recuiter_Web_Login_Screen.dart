import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:getifyjobs/Models/LoginModel.dart';
import 'package:getifyjobs/Src/Common_Widgets/Bottom_Navigation_Bar.dart';
import 'package:getifyjobs/Src/Common_Widgets/Common_Button.dart';
import 'package:getifyjobs/Src/Common_Widgets/Image_Path.dart';
import 'package:getifyjobs/Src/Common_Widgets/Text_Form_Field.dart';
import 'package:getifyjobs/Src/Recruiter_Web_Screens/Recruiter_Web_AppNavigationBar_Screen.dart';
import 'package:getifyjobs/Src/Recruiter_Web_Screens/Recuiter_Login/Recuiter_Create_Account.dart';
import 'package:getifyjobs/Src/utilits/ApiService.dart';
import 'package:getifyjobs/Src/utilits/Common_Colors.dart';
import 'package:getifyjobs/Src/utilits/ConstantsApi.dart';
import 'package:getifyjobs/Src/utilits/Generic.dart';
import 'package:getifyjobs/Src/utilits/Text_Style.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Common_Widgets/Common_Tab_Bars.dart';
import 'Recuiter_Web_Otp_Screen.dart';

class Recuiter_Web_Login_Screen extends ConsumerStatefulWidget {
  const Recuiter_Web_Login_Screen({super.key});

  @override
  ConsumerState<Recuiter_Web_Login_Screen> createState() =>
      _Recuiter_Web_Login_ScreenState();
}

class _Recuiter_Web_Login_ScreenState
    extends ConsumerState<Recuiter_Web_Login_Screen> {
  String? selectedOption;
  String? selectExpVal;
  String? qualificationOption;

  TextEditingController _mobileController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _mobileNumber = '';
  String _password = "";
  bool _obscurePassword = true; // Initially hide the password

  //BUTTON VALIDATION
  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      print('Mobile Number: $_mobileNumber');
      print('Password: $_password');
      final loginApiService = ApiService(ref.read(dioProvider));
      var formData =
          FormData.fromMap({"phone": "9876543211", "password": "123456"});
      final loginApiResponse = await loginApiService.post<LoginModel>(
          context, ConstantApi.loginUrl, formData);
      print('RECRUITER ID : ${loginApiResponse?.data?.recruiterId ?? ""}');
      if (loginApiResponse?.status == true) {
        print("SUCESS");
        ShowToastMessage(loginApiResponse.message ?? "");
        String Boolvalue = "true";
        Routes(Boolvalue);
        RecruiterId(loginApiResponse?.data?.recruiterId ?? "");
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Recruiter_Web_Home_Screen()));
      } else {
        print("SUCESS");
        ShowToastMessage(loginApiResponse.message ?? "");
      }
    }
  }

  //PASSWORD VISIBILITY FUNCTION
  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: white2,
        body: Padding(
            padding:
                const EdgeInsets.only(top: 20, bottom: 20, left: 20, right: 20),
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
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
                                height: MediaQuery.of(context).size.height / 2,
                                color: white1,
                                child: Logo(context),
                              )),
                            ),
                            // footer(),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Form(
                    key: _formKey, // Associate the form with the GlobalKey
                    child: Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 20, top: 25, right: 20),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              loginContainer(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )));
  }

  //LOGIN CONTAINER
  Widget loginContainer() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 30, top: 35),
      child: Container(
        width: 400,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Log in",
                style: logintxt,
              ),
              //MOBILE NUMBER
              mobilenumberFiled(),
              //PASSWORD
              passwordField(),
              Row(
                children: [
                  Spacer(),
                  InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    Recuiter_Web_Otp_Screen()));
                      },
                      child: Text(
                        "Forget password",
                        style: fPassword,
                      )),
                ],
              ),
              SizedBox(
                height: 25,
              ),
              //CREATE ACCOUNT TEXT
              createAccountText(),
              //Login button
              loginButton(),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                      onTap: () async {
                        await launch(
                            'https://getifyjobs.com/terms-and-conditions');
                      },
                      child: Text(
                        "Terms & Conditions",
                        style: ButtonT2,
                      )),
                  const SizedBox(
                    width: 20,
                  ),
                  InkWell(
                      onTap: () async {
                        await launch('https://getifyjobs.com/privacy-policy');
                      },
                      child: Text(
                        "Privacy Policy",
                        style: ButtonT2,
                      )),
                  const SizedBox(
                    width: 20,
                  ),
                  InkWell(
                      onTap: () async {
                        await launch('https://getifyjobs.com/refund-policy');
                      },
                      child: Text(
                        "Refund Policy",
                        style: ButtonT2,
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  //MOBILE NUMBER
  Widget mobilenumberFiled() {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 15),
      child: textFormField2(
          // isEnabled: false,
          hintText: "Mobile No",
          keyboardtype: TextInputType.phone,
          Controller: _mobileController,
          inputFormatters: [
            LengthLimitingTextInputFormatter(10),
            FilteringTextInputFormatter.digitsOnly
          ],
          onChanged: (value) {
            _mobileNumber = value!;
          },
          validating: (value) {
            if (value!.isEmpty) {
              return 'Please enter a mobile number';
            } else if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
              return 'Please enter a valid 10-digit mobile number';
            }
            return null;
          }),
    );
  }

  //PASSWORD
  Widget passwordField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25),
      child: textFieldPassword2(
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
            return 'Please enter a password';
          } else if (value.length < 6) {
            return 'Password must be at least 6 characters long';
          }
          return null;
        },
      ),
    );
  }

  //CREATE ACCOUNT TEXT
  Widget createAccountText() {
    return Center(
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Recruiter_Web_Create_Account()));
        },
        child: RichText(
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                text: 'If you don’t Have a Account, Click  ,',
                style: richtext1,
              ),
              TextSpan(
                text: 'Create Account',
                style: richtext2,
              ),
            ],
          ),
        ),
      ),
    );
  }

  //LOGIN BUTTON
  Widget loginButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 25, left: 50, bottom: 80, right: 50),
      child: Center(
        child: CommonElevatedButton(
          context,
          "Login",
          () {
            _submitForm();
          },
        ),
      ),
    );
  }

  Widget footer() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'GETIFY BUSINESS SERVICE PRIVATE LIMITED',
                style: bluetxt,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15, bottom: 10),
                child: Text(
                  'Get In Touch',
                  style: log2,
                ),
              ),
              Text(
                '9789729394\ngetifyindia@gmail.com',
                style: logT,
              ),
            ],
          ),
          const SizedBox(
            width: 30,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 45,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Text(
                  'Adress',
                  style: log2,
                ),
              ),
              Text(
                "First Floor, No.1/2,\nGain Towers, SND Layout,\n4th Street, Tatabad,\nCoimbatore,Tamin Nadu,\nPincode: 641012",
                style: appliesT,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
