import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:getifyjobs/Models/NewPasswordModel.dart';
import 'package:getifyjobs/Src/Common_Widgets/Common_Button.dart';
import 'package:getifyjobs/Src/Common_Widgets/Custom_App_Bar.dart';
import 'package:getifyjobs/Src/Common_Widgets/Image_Path.dart';
import 'package:getifyjobs/Src/Common_Widgets/Text_Form_Field.dart';
import 'package:getifyjobs/Src/Recruiter_Mobile_Screen/Home_DashBoard/Recruiter_Home_Screen.dart';
import 'package:getifyjobs/Src/Recruiter_Mobile_Screen/Recruiter_Login_Ui/Recruiter_Login_Page.dart';
import 'package:getifyjobs/Src/utilits/ApiService.dart';
import 'package:getifyjobs/Src/utilits/Common_Colors.dart';
import 'package:getifyjobs/Src/utilits/ConstantsApi.dart';
import 'package:getifyjobs/Src/utilits/Generic.dart';
import 'package:getifyjobs/Src/utilits/Text_Style.dart';

class Recruiter_Forget_Password_Screen extends ConsumerStatefulWidget {
  final String recruiter_Id;
   Recruiter_Forget_Password_Screen({super.key,required this.recruiter_Id});

  @override
  ConsumerState<Recruiter_Forget_Password_Screen> createState() => _Recruiter_Forget_Password_ScreenState();
}

class _Recruiter_Forget_Password_ScreenState extends ConsumerState<Recruiter_Forget_Password_Screen> {
  String NewPassword = '';
  String ReEnterPassword = '';
  final _formKey = GlobalKey<FormState>();
  TextEditingController newPasword = TextEditingController();
  TextEditingController reEnterPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white2,
      appBar: Custom_AppBar(isUsed: false, actions: null, isLogoUsed: true, isTitleUsed: false,title: '',),
      body:Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              //LOGO
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 35),
                child: Logo(context),
              ),

              //CONTAINER
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                    color: white1
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20,right: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //FORGET PASSWORD
                      Padding(
                        padding: const EdgeInsets.only(top: 35,bottom: 25),
                        child: Text("Forgot Password",style: TitleT,),
                      ),

                      //ENTER NEW PASSWORD
                      Title_Style(Title: 'Enter New Password', isStatus: true),
                      textFormField(
                        hintText: 'Enter New Password',
                        keyboardtype: TextInputType.text,
                        inputFormatters: null,
                        Controller: newPasword,
                        validating: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please Enter Valid ${'Password'}";
                          }
                          if (value == null) {
                            return "Please Enter Valid ${'Password'}";
                          }
                          return null;
                        },
                        onChanged: (value){
                          NewPassword= value;
                        },
                      ),

                      //Re-Enter New Password
                      Title_Style(Title: 'Re-Enter New Password', isStatus: true),
                      textFormField(
                        hintText: 'Re-Enter New Password',
                        keyboardtype: TextInputType.text,
                        inputFormatters: null,
                        Controller: reEnterPassword,
                        validating: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please Enter Valid ${'Password'}";
                          }
                          if (value != NewPassword) {
                            return "Password does not match with new password";
                          }
                          return null;
                        },
                        onChanged: (value){
                          ReEnterPassword = value;
                        },
                      ),


                      //ELEVATED BUTTON
                      Padding(
                        padding: const EdgeInsets.only(top: 150,bottom: 50,left: 50,right: 50),
                        child: CommonElevatedButton(context, "Verify", () {
                          if(_formKey.currentState!.validate()){
                            print('Validate');
                            NewPasswordResponse();
                          }
                        }),
                      )

                    ],
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
  NewPasswordResponse() async{
    final newPasswordApiService = ApiService(ref.read(dioProvider));
    var formData = FormData.fromMap({
      "password":reEnterPassword.text,
      "recruiter_id":widget.recruiter_Id,
    });
    final newPasswordResponse = await newPasswordApiService.post<NewPasswordModel>(context, ConstantApi.newPasswordUrl, formData);
    if(newPasswordResponse.status == true){
      print("NEW PASSWORD CHANGED SUCESS");
      ShowToastMessage(newPasswordResponse?.message ?? "");
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Recruiter_Login_Page()), (route) => false);

    }else{
      print("NEW PASSWORD CHANGED ERROR");
      ShowToastMessage(newPasswordResponse?.message ?? "");
    }
  }
}
