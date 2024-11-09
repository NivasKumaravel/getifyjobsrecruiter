import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:getifyjobs/Src/Common_Widgets/Common_Button.dart';
import 'package:getifyjobs/Src/Common_Widgets/Custom_App_Bar.dart';
import 'package:getifyjobs/Src/Common_Widgets/Image_Path.dart';
import 'package:getifyjobs/Src/utilits/Common_Colors.dart';

import '../../utilits/Text_Style.dart';

class Recuiter_Web_Otp_Verification extends StatefulWidget {
  final bool? isForget;
  final String? mobileNumber;
  Recuiter_Web_Otp_Verification({super.key,required this.isForget,required this.mobileNumber});

  @override
  State<Recuiter_Web_Otp_Verification> createState() => _Recuiter_Web_Otp_VerificationState();
}

class _Recuiter_Web_Otp_VerificationState extends State<Recuiter_Web_Otp_Verification> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
        color: white1,
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
        keyboardType: TextInputType.number,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly
        ],
        decoration: InputDecoration(
          counter: Offstage(),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: white1),
              borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: white1),
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

      body: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 10,bottom: 10),
              child: Container(
                decoration: BoxDecoration(
                    color: white1,
                    borderRadius: BorderRadius.only(topRight: Radius.circular(20),bottomRight: Radius.circular(20))
                ),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 50),
                      decoration: BoxDecoration(
                          color: white1
                      ),
                      child: Center(child: Padding(
                        padding: const EdgeInsets.only(left: 20,right: 20),
                        child: Container(
                            width: MediaQuery.of(context).size.width *0.35,
                            height: MediaQuery.of(context).size.height *0.70,
                            color: white1,
                            child: Logo(context)),
                      )),
                    ),

                  ],
                ),
              ),
            ),
          ),
          Form(
            key: _formKey, // Associate the form with the GlobalKey
            child: Expanded(
              child: Center(
                child: Container(
                  height: 400,
                  width: 400,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center  ,
                      children: [
                        Container(
                            margin: EdgeInsets.only(top: 35,bottom: 10),
                            alignment: Alignment.center,
                            child: Text(widget.isForget==true?"OTP Verification":"Forgot Password",style: TitleT,)),
                        Center(child: Text("We sent a verification code to ",style: inboxcompany,)),
                        Center(child: Padding(
                          padding: const EdgeInsets.only(bottom: 25),
                          child: Text(widget.mobileNumber ?? "",style: TextField_Title1
                            ,),
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
                          padding: const EdgeInsets.only(),
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
                        // SizedBox(height: 200,),
                        Padding(
                          padding:
                          const EdgeInsets.only(top: 15, bottom: 15),
                          child: Center(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 16,bottom: 10),
                                  child: Container(
                                      // width: 260,
                                      child:CommonElevatedButton(context, "Verify", () {

                                      })),
                                ),
                                RichText(
                                  text: TextSpan(
                                      text: 'If you already have a account, click ',
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
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}
