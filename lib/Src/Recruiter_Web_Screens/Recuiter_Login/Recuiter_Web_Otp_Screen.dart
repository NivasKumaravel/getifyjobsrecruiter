import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:getifyjobs/Src/Common_Widgets/Common_Button.dart';
import 'package:getifyjobs/Src/Common_Widgets/Image_Path.dart';
import 'package:getifyjobs/Src/Common_Widgets/Text_Form_Field.dart';
import 'package:getifyjobs/Src/utilits/Common_Colors.dart';
import 'package:getifyjobs/Src/utilits/Text_Style.dart';

import 'Recuiter_Web_Otp_Verification.dart';

class Recuiter_Web_Otp_Screen extends StatefulWidget {
  const Recuiter_Web_Otp_Screen({super.key});

  @override
  State<Recuiter_Web_Otp_Screen> createState() =>
      _Recuiter_Web_Otp_ScreenState();
}

class _Recuiter_Web_Otp_ScreenState extends State<Recuiter_Web_Otp_Screen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _mobileController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: white2,
        body: Row(
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
                            child: Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Container(
                              color: white1,
                              width: MediaQuery.of(context).size.width * 0.35,
                              height: MediaQuery.of(context).size.height * 0.70,
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
                    child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 25),
                              child: Text(
                                "OTP Verification",
                                style: TitleT,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 20),
                              child: Text(
                                "Phone Number",
                                style: inboxcompany,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  left: 20, top: 20, right: 20, bottom: 40),
                              child: textFormField2(
                                  // isEnabled: false,
                                  hintText: "Mobile No",
                                  keyboardtype: TextInputType.phone,
                                  Controller: _mobileController,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(10),
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  onChanged: null,
                                  validating: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter a mobile number';
                                    } else if (!RegExp(r'^[0-9]{10}$')
                                        .hasMatch(value)) {
                                      return 'Please enter a valid 10-digit mobile number';
                                    }
                                    return null;
                                  }),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 40, right: 40, top: 15, bottom: 15),
                              child: Center(
                                child: Column(
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                          text:
                                              'If you already have a account, click ',
                                          style: richtext1,
                                          children: <TextSpan>[
                                            TextSpan(
                                                text: 'Log In',
                                                style: richtext2,
                                                recognizer:
                                                    TapGestureRecognizer()
                                                      ..onTap = () {
                                                        // navigate to desired screen
                                                        print("object");
                                                      })
                                          ]),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 16, bottom: 10),
                                      child: Container(
                                          width: 260,
                                          child: CommonElevatedButton(
                                              context, "Verify", () {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Recuiter_Web_Otp_Verification(
                                                              isForget: false,
                                                              mobileNumber:
                                                                  _mobileController
                                                                      .text)));
                                            }
                                          })),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
