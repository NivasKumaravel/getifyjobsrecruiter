import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:getifyjobs/Models/ForgotMobileModel.dart';
import 'package:getifyjobs/Src/Common_Widgets/Common_Button.dart';
import 'package:getifyjobs/Src/Common_Widgets/Custom_App_Bar.dart';
import 'package:getifyjobs/Src/Common_Widgets/Image_Path.dart';
import 'package:getifyjobs/Src/Common_Widgets/Text_Form_Field.dart';
import 'package:getifyjobs/Src/Recruiter_Mobile_Screen/Recruiter_Otp_Verification_Ui/Recruiter_Otp_Verification_Screen.dart';
import 'package:getifyjobs/Src/utilits/ApiService.dart';
import 'package:getifyjobs/Src/utilits/Common_Colors.dart';
import 'package:getifyjobs/Src/utilits/ConstantsApi.dart';
import 'package:getifyjobs/Src/utilits/Generic.dart';
import 'package:getifyjobs/Src/utilits/Text_Style.dart';
class Recruiter_Forget_Mobile_Screen extends ConsumerStatefulWidget {
  const Recruiter_Forget_Mobile_Screen({super.key});

  @override
  ConsumerState<Recruiter_Forget_Mobile_Screen> createState() => _Recruiter_Forget_Mobile_ScreenState();
}

class _Recruiter_Forget_Mobile_ScreenState extends ConsumerState<Recruiter_Forget_Mobile_Screen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _mobileNumber = '';
  TextEditingController _mobileController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: white2,
        appBar: Custom_AppBar(
          isUsed: true,
          isLogoUsed: true,
          title: "",
          isTitleUsed: true,
          actions: [],
        ),
        body: SingleChildScrollView(child: _mainbody())
    );
  }

  Widget _mainbody(){
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Form(
        key: _formKey,
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Logo(context)),
              Container(
                width: MediaQuery.of(context).size.width,
                //height: MediaQuery.of(context).size.height/1.5,
                margin: EdgeInsets.only(top: 40),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(25),
                    topLeft: Radius.circular(25),
                  ),
                  color: white1,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 20, top: 35),
                      child: Center(
                        child: Text(
                          "OTP Verification",
                          style: TitleT,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20, top: 15),
                      child: Text(
                        "Phone Number",
                        style: inboxcompany,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          left: 20, top: 20, right: 20, bottom: 150),
                      child:  textFormField(
                        // isEnabled: false,
                          hintText: "Enter Mobile Number",
                          keyboardtype: TextInputType.phone,
                          Controller: _mobileController,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(10),
                            FilteringTextInputFormatter.digitsOnly],
                          onChanged: (value) {
                            _mobileNumber = value!;
                          },
                          validating:(value){
                            if (value!.isEmpty) {
                              return 'Please Enter a Mobile Number';
                            } else if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                              return 'Please enter a valid 10-digit mobile number';
                            }
                            return null;
                          }
                      ),
                    ),
                    Padding(
                      padding:
                      const EdgeInsets.only(left: 40, right: 40, top: 15),
                      child: Center(
                        child: Column(
                          children: [
                            RichText(
                              text: TextSpan(
                                  text: 'If you Already Have an Account, Click ',
                                  style: richtext1,
                                  children: <TextSpan>[
                                    TextSpan(text: 'Log in',
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
                              padding: const EdgeInsets.only(top: 16,bottom: 80),
                              child: Container(
                                  width: 260,
                                  child:CommonElevatedButton(context, "Verify", () {
                                    if (_formKey.currentState!.validate()) {
                                      ForgotMobileResponse();
                                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>Recruiter_Otp_Verification_Screen(isForget: false, mobileNumber: _mobileController.text, recruiterId: '',)));
                                    }
                                  })),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //FORGOT MOBILE RESPONSE
  ForgotMobileResponse()async{
    final forgotMobileApiService = ApiService(ref.read(dioProvider));
    var formData = FormData.fromMap({
      "phone":_mobileController.text,
    });
    final forgotMobileApiResponse = await forgotMobileApiService.post<ForgotMobileModel>
      (context, ConstantApi.forgotMobileUrl, formData);

    if(forgotMobileApiResponse.status == true){
      ShowToastMessage(forgotMobileApiResponse.message ?? "");
      Navigator.push(context, MaterialPageRoute(builder: (context)=>Recruiter_Otp_Verification_Screen(isForget: true,
        mobileNumber: _mobileController.text,
        recruiterId: "${forgotMobileApiResponse?.data?.updateRecruiter ?? 0}",)));
    }else{
      ShowToastMessage(forgotMobileApiResponse.message ?? "");
    }
  }
}
