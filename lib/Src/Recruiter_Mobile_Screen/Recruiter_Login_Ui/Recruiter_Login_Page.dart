import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:getifyjobs/Models/LoginModel.dart';
import 'package:getifyjobs/Src/Common_Widgets/Bottom_Navigation_Bar.dart';
import 'package:getifyjobs/Src/Common_Widgets/Common_Button.dart';
import 'package:getifyjobs/Src/Common_Widgets/Image_Path.dart';
import 'package:getifyjobs/Src/Common_Widgets/Text_Form_Field.dart';
import 'package:getifyjobs/Src/Recruiter_Mobile_Screen/Recruiter_Create_Account_Ui/Recruiter_Create_Account.dart';
import 'package:getifyjobs/Src/Recruiter_Mobile_Screen/Recruiter_Forget_Password_Ui/Recruiter_Forget_Mobile_Screen.dart';
import 'package:getifyjobs/Src/Recruiter_Mobile_Screen/Recruiter_Otp_Verification_Ui/Recruiter_Otp_Verification_Screen.dart';
import 'package:getifyjobs/Src/utilits/ApiService.dart';
import 'package:getifyjobs/Src/utilits/Common_Colors.dart';
import 'package:getifyjobs/Src/utilits/ConstantsApi.dart';
import 'package:getifyjobs/Src/utilits/Generic.dart';
import 'package:getifyjobs/Src/utilits/Text_Style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Recruiter_Login_Page extends ConsumerStatefulWidget {
  const Recruiter_Login_Page({super.key});

  @override
  ConsumerState<Recruiter_Login_Page> createState() =>
      _Recruiter_Login_PageState();
}

class _Recruiter_Login_PageState extends ConsumerState<Recruiter_Login_Page> {
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  RegExp passwordSpecial =
      RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$])(?=.*[0-9]).*$');
  RegExp passwordLength =
      RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$])(?=.*[0-9]).{8,15}$');

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _mobileNumber = '';
  String _password = "";
  bool _obscurePassword = true; // Initially hide the password

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
      body: SingleChildScrollView(child: _Mainbody()),
    );
  }

  //MAIN BODY
  Widget _Mainbody() {
    return Form(
      key: _formKey,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            //GETIFY LOGO
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Logo(context),
            ),
            //LOGIN SCREEN IMAGE
            Container(child: LoginScreenImage(context)),
            const Spacer(),
            //LOGIN CONTAINER
            loginContainer(),
          ],
        ),
      ),
    );
  }

  //LOGIN CONTAINER
  Widget loginContainer() {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      decoration: BoxDecoration(
        color: white1,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Text(
                "Log in",
                style: logintxt,
              ),
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
                                  Recruiter_Forget_Mobile_Screen()));
                    },
                    child: Text(
                      "Forgot password",
                      style: fPassword,
                    )),
              ],
            ),
            //CREATE ACCOUNT TEXT
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: createAccountText(),
            ),
            //Login button

            loginButton(),
          ],
        ),
      ),
    );
  }

  //MOBILE NUMBER
  Widget mobilenumberFiled() {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 15),
      child: textFormField(
          // isEnabled: false,
          hintText: "Mobile Number",
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
              return 'Please Enter a official Mobile Number';
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
      padding: const EdgeInsets.only(bottom: 15),
      child: textFieldPassword(
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
          } else if (!passwordLength.hasMatch(value)) {
            return "Password should be with minimum 8 and maximum 15 characters";
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
                  builder: (context) => Recruiter_Create_Account_Screen(
                        isEdit: false,
                        editResponse: null,
                      )));
        },
        child: RichText(
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                text: 'If you Don’t Have an Account, Click  ',
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
      padding: const EdgeInsets.only(top: 20, left: 50, bottom: 0, right: 50),
      child: Center(
        child: CommonElevatedButton(
          context,
          "Login",
          () => LoginResponse(),
        ),
      ),
    );
  }

  Future<void> LoginResponse() async {
    if (_formKey.currentState!.validate()) {
      final LoginApiService = ApiService(ref.read(dioProvider));
      var formData = FormData.fromMap({
        "phone": _mobileController.text,
        "password": _passwordController.text
      });
      final LoginResponse = await LoginApiService.post<LoginModel>(
          context, ConstantApi.loginUrl, formData);
      print("LOGIN RESPONSE : ${LoginResponse.data?.recruiterId ?? ""}");

      //SHAREDPREFERENCE
      final SharedPreferences setLoginData =
          await SharedPreferences.getInstance();
      setLoginData.setString(
          'recruiter_id', LoginResponse.data?.recruiterId ?? "");

      if (LoginResponse.status == true) {
        ShowToastMessage(LoginResponse.message ?? "");
        String Boolvalue = "true";
        Routes(Boolvalue);
        RecruiterId(LoginResponse?.data?.recruiterId ?? "");
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Recruiter_Bottom_Navigation(select: 0)));
      } else {
        LoginResponse.data?.otp_verify_status == false
            ? Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Recruiter_Otp_Verification_Screen(
                          isForget: false,
                          mobileNumber: _mobileController.text,
                          recruiterId:
                              LoginResponse.data?.recruiterId.toString(),
                        )))
            : ShowToastMessage(LoginResponse.message ?? "");
      }

      print('Mobile Number: $_mobileNumber');
      print('Password: $_password');
    }
  }
}
