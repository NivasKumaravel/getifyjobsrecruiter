import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:getifyjobs/Models/OtpModel.dart';
import 'package:getifyjobs/Src/Common_Widgets/Bottom_Navigation_Bar.dart';
import 'package:getifyjobs/Src/Common_Widgets/Common_Button.dart';
import 'package:getifyjobs/Src/Common_Widgets/Custom_App_Bar.dart';
import 'package:getifyjobs/Src/Common_Widgets/Image_Path.dart';
import 'package:getifyjobs/Src/Recruiter_Mobile_Screen/Recruiter_Forget_Password_Ui/Recruiter_Forget_Password_Screen.dart';
import 'package:getifyjobs/Src/Recruiter_Mobile_Screen/Recruiter_Login_Ui/Recruiter_Login_Page.dart';
import 'package:getifyjobs/Src/utilits/Common_Colors.dart';
import 'package:getifyjobs/Src/utilits/ConstantsApi.dart';
import 'package:getifyjobs/Src/utilits/Generic.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utilits/ApiService.dart';
import '../../utilits/Text_Style.dart';

class Recruiter_Otp_Verification_Screen extends ConsumerStatefulWidget {
  final bool? isForget;
  final String? mobileNumber;
  final String? recruiterId;
  Recruiter_Otp_Verification_Screen({super.key,required this.isForget,required this.mobileNumber,required this.recruiterId});

  @override
  ConsumerState<Recruiter_Otp_Verification_Screen> createState() => _Otp_Verification_PageState();
}

class _Otp_Verification_PageState extends ConsumerState<Recruiter_Otp_Verification_Screen> {

  int _timeLeft = 30; // Timer duration in seconds
  bool _isTimerActive = false;
  // Timer callback function
  void _tick() {
    if (_timeLeft == 0) {
      setState(() {
        _isTimerActive = false;
      });
    } else {
      setState(() {
        _timeLeft--;
      });
    }
  }

  // Start the timer
  void _startTimer() {
    setState(() {
      _timeLeft = 30;
      _isTimerActive = true;
    });

    Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (_isTimerActive) {
        _tick();
      } else {
        timer.cancel();
      }
    });
  }



  String _formatNumber(String number) {
    if (number.length < 6) {
      return number;
    }
    String formattedNumber = number.substring(0, 6);
    for (int i = 6; i < number.length; i++) {
      formattedNumber += 'x';
    }
    return formattedNumber;
  }

  // var controllers;
  var output;
  TextEditingController _OTP1 = TextEditingController();
  TextEditingController _OTP2 = TextEditingController();
  TextEditingController _OTP3 = TextEditingController();
  TextEditingController _OTP4 = TextEditingController();
  TextEditingController _OTP5 = TextEditingController();
  TextEditingController _OTP6 = TextEditingController();
  Widget _textFieldOTP({bool? first, bool? last, controllers}) {
    return Container(
      height: 45,
      width: 45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: white2,
      ),

      // margin: EdgeInsets.only(left: 10),
      child: TextField(
        controller: controllers,
        autofocus: true,
        maxLength: 1,
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          } if (value.length == 0) {
            setState(() {
              FocusScope.of(context).previousFocus();
            });
          }
        },
        showCursor: true,
        textAlign: TextAlign.center,
        // style: OtpTextfield_Style,
        keyboardType: TextInputType.number,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly
        ],
        decoration: InputDecoration(
          counter: Offstage(),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: white2),
              borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: white2),
              borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white2,
      appBar: Custom_AppBar(
        title: "",
        isUsed: true,
        actions: [],
        isLogoUsed: true,
        isTitleUsed: true,
      ),
      body: SingleChildScrollView(child: _Mainbody()),
    );
  }
  
  Widget _Mainbody (){
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Column(
        children: [
          Center(child: Logo(context)),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Container(
              //height:  MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,

              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topRight: Radius.circular(25),topLeft: Radius.circular(25)),
                color: white1,
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 20,right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start  ,
                  children: [
                    Container(
                        margin: EdgeInsets.only(top: 35,bottom: 25),
                        alignment: Alignment.center,
                        child: Text(widget.isForget==true?"Forgot Password":"OTP Verification",style: TitleT,)),
                    Center(child: Text("We have sent a verification code to",style: inboxcompany,)),
                    Center(child: Padding(
                      padding: const EdgeInsets.only(bottom: 25),
                      child: Text(_formatNumber(widget.mobileNumber ?? ""),style: TBlack,),
                    )),
                    Container(
                      // color: Colors.green,
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.centerLeft,
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          _textFieldOTP(first: true, last: true, controllers: _OTP1),
                          _textFieldOTP(first: true, last: true, controllers: _OTP2),
                          _textFieldOTP(first: true, last: true, controllers: _OTP3),
                          _textFieldOTP(first: true, last: true, controllers: _OTP4),
                          _textFieldOTP(first: true, last: true, controllers: _OTP5),
                          _textFieldOTP(first: true, last: true, controllers: _OTP6),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20,left: 20),
                      child: Row(
                        children: [
                          InkWell(
                            onTap:
                            // _isTimerActive ? null:
                                () {
                              _startTimer();
                              // if(ResendOut?.status=="success"){
                              //   _startTimer();
                              //   var response = ResendApi(context);
                              //   print(" final Responses ${response}");
                              // }else{
                              //   return null;
                              // }

                            },
                            child: Container(
                              alignment: Alignment.topRight,
                              child: Text(
                                  _isTimerActive? "00:$_timeLeft":
                                  "",
                                  // style: changeT,
                                  style:TextStyle(color: red1)
                              ),
                            ),
                          ),
                          Spacer(),
                          Container(
                            alignment: Alignment.topLeft,
                            child: InkWell(
                              onTap: (){
                                _startTimer();
                                _OTP1.clear();
                                _OTP2.clear();
                                _OTP3.clear();
                                _OTP4.clear();
                                _OTP5.clear();
                                _OTP6.clear();
                              },
                              child: Text(
                                _isTimerActive
                                    ? 'Resend OTP'
                                    : 'Resend OTP',
                                style: TextStyle(
                                    color: _isTimerActive
                                        ?  red1
                                        : Color.fromRGBO(34, 152, 255, 1),
                                    fontFamily: 'Inter', fontSize: 14, fontWeight: FontWeight.w400
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 100,),
                    Padding(
                      padding:
                      const EdgeInsets.only(left: 40, right: 40, top: 15, bottom: 15),
                      child: Center(
                        child: Column(
                          children: [
                            RichText(
                              text: TextSpan(
                                  text: 'If you Already Have an Account, Click ',
                                  style: richtext1,
                                  children: <TextSpan>[
                                    TextSpan(text: 'Log In',
                                        style: richtext2,
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            // navigate to desired screen
                                            print("object");
                                          }
                                    )
                                  ]
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 16,bottom: 40),
                              child: Container(
                                width: 260,
                                child: CommonElevatedButton(
                                    context,
                                    "Verify",
                                        () {
                                      // Validate OTP fields before proceeding
                                      if (_OTP1.text.isEmpty || _OTP2.text.isEmpty || _OTP3.text.isEmpty ||
                                          _OTP4.text.isEmpty || _OTP5.text.isEmpty || _OTP6.text.isEmpty) {
                                        // Show error message if any OTP field is empty
                                        ShowToastMessage("Please Enter the OTP");
                                      } else {
                                        // If OTP is valid, proceed with the appropriate API call
                                        widget.isForget == true
                                            ? ForgotOtpVerificationResponse()
                                            : Otp_Verification_Response();
                                      }
                                    }
                                ),
                              )

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
        ],
      ),
    );
  }
  Future<void> Otp_Verification_Response() async{

    final apiService = ApiService(ref.read(dioProvider));
    final postData = FormData.fromMap({
      "otp":"${_OTP1.text+_OTP2.text+_OTP3.text+_OTP4.text+_OTP5.text+_OTP6.text}",
      "recruiter_id":widget.recruiterId
    });
    final postResponse = await apiService.post<RecruiterOtpVerificationModel>(context,ConstantApi.otpVerification, postData);
    print("RECRUITER ID: ${postResponse.data?.recruiterId ?? ""}");
    final SharedPreferences setLoginData =
    await SharedPreferences.getInstance();
    if(postResponse.status == true){
      print("SUCESS");
      setLoginData.setString('recruiter_id', postResponse.data?.recruiterId ?? "");
      RecruiterId(postResponse?.data?.recruiterId ?? "");
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Recruiter_Bottom_Navigation(select: 0)), (route) => false);
    }else{
      ShowToastMessage(postResponse.message ?? "");
      print('Error');
    }
  }
  ForgotOtpVerificationResponse() async{
   final forgotOtpApiService = ApiService(ref.read(dioProvider));
   final formData = FormData.fromMap({
     "phone":widget.mobileNumber,
     "recruiter_id":widget.recruiterId,
     "otp":"${_OTP1.text+_OTP2.text+_OTP3.text+_OTP4.text+_OTP5.text+_OTP6.text}",
   });
   final forgotOtpApiResponse = await forgotOtpApiService.post<RecruiterOtpVerificationModel>
     (context, ConstantApi.forgotOtpUrl, formData);
   if(forgotOtpApiResponse.status == true){
     ShowToastMessage(forgotOtpApiResponse.message ?? "");
     Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Recruiter_Forget_Password_Screen(recruiter_Id: forgotOtpApiResponse?.data?.recruiterId ?? "",)), (route) => false);
   }else{
     ShowToastMessage(forgotOtpApiResponse.message ?? "");
   }
  }
}
