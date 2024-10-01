import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:getifyjobs/Models/AddBranchModel.dart';
import 'package:getifyjobs/Models/BranchDetailModel.dart';
import 'package:getifyjobs/Models/ProfileModel.dart';
import 'package:getifyjobs/Src/Common_Widgets/Common_Button.dart';
import 'package:getifyjobs/Src/Common_Widgets/Custom_App_Bar.dart';
import 'package:getifyjobs/Src/Common_Widgets/Image_Path.dart';
import 'package:getifyjobs/Src/Common_Widgets/Text_Form_Field.dart';
import 'package:getifyjobs/Src/utilits/ApiService.dart';
import 'package:getifyjobs/Src/utilits/Common_Colors.dart';
import 'package:getifyjobs/Src/utilits/ConstantsApi.dart';
import 'package:getifyjobs/Src/utilits/Generic.dart';
import 'package:getifyjobs/Src/utilits/Text_Style.dart';

class Recruiter_Web_Add_Branch_Screen extends ConsumerStatefulWidget {
  bool? isEdit;
  String? branch_id;

  Recruiter_Web_Add_Branch_Screen({super.key,required this.branch_id,required this.isEdit});

  @override
  ConsumerState<Recruiter_Web_Add_Branch_Screen> createState() => _Recruiter_Web_Add_Branch_ScreenState();
}

class _Recruiter_Web_Add_Branch_ScreenState extends ConsumerState<Recruiter_Web_Add_Branch_Screen> {
  BranchDetailData? branchResponseData;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    BranchDetailResponse();
  }
  TextEditingController _branchName = TextEditingController();
  TextEditingController _branchPhoneNumber = TextEditingController();
  TextEditingController _branchMailAddress = TextEditingController();
  TextEditingController _branchAddress = TextEditingController();



  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white2,
      appBar: Custom_AppBar(
        isUsed: true,
        actions: null,
        isLogoUsed: true,
        isTitleUsed: true,
        title:widget.isEdit == true?"Edit Branch": "Add Branch",),
      body: Padding(
        padding: const EdgeInsets.only(
            top: 20, bottom: 20, left: 20, right: 20),
        child: Container(
          width: MediaQuery
              .of(context)
              .size
              .width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height / 1.2,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: white1
                  ),
                  child: Center(child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: ImgPathSvg('create.svg'),
                  )),
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
                            //Name
                            Title_Style2(Title: "Branch Name", isStatus: true),
                            textFormField2(
                              hintText: 'Enter Branch Name',
                              keyboardtype: TextInputType.text,
                              inputFormatters: null,
                              Controller: _branchName,
                              validating: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please Enter Valid ${'Branch Name'}";
                                }
                                if (value == null) {
                                  return "Please Enter Valid ${'Branch Name'}";
                                }
                                return null;
                              },
                              onChanged: null,
                            ),

                            //PHONE NUMBER
                            Title_Style2(
                                Title: 'Branch Phone Number', isStatus: true),
                            textFormField2(
                              hintText: 'Enter Branch Phone Number',
                              keyboardtype: TextInputType.number,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(10)
                              ],
                              Controller: _branchPhoneNumber,
                              validating: (value) {
                                if (value!.isEmpty) {
                                  return "Please enter a mobile number";
                                } else if (!RegExp(r"^[0-9]{10}$").hasMatch(value)) {
                                  return "Please enter a valid 10-digit mobile number";
                                }
                                return null;
                              },
                              onChanged: null,
                            ),

                            //EMAIL ADDRESS
                            Title_Style2(
                                Title: 'Branch Email Address', isStatus: true),
                            textFormField2(
                              hintText: 'Enter Branch Email Address',
                              keyboardtype: TextInputType.text,
                              inputFormatters: null,
                              Controller: _branchMailAddress,
                              validating: (value) {
                                if (value!.isEmpty) {
                                  return "Please enter a Email Address";
                                } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                    .hasMatch(value)) {
                                  return "Please enter a valid email address";
                                }
                                return null;
                              },
                              onChanged: null,
                            ),

                            //BRANCH ADDRESS
                            Title_Style2(
                                Title: 'Branch Address', isStatus: true),
                            textFormField2(
                              hintText: 'Enter Branch Address',
                              keyboardtype: TextInputType.text,
                              inputFormatters: null,
                              Controller: _branchAddress,
                              validating: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please Enter Valid ${'Enter Branch Address'}";
                                }
                                if (value == null) {
                                  return "Please Enter Valid ${'Enter Branch Address'}";
                                }
                                return null;
                              },
                              onChanged: null,
                            ),
                            SizedBox(height: 75,),
                            Container(
                                alignment: Alignment.center,
                                width: 350,
                                margin: EdgeInsets.only(
                                    left: 150, top: 25, bottom: 30),
                                child: CommonElevatedButton(
                                    context, 'Submit', () {
                                  if (_formKey.currentState!.validate()) {
                                    widget.isEdit == true? EditBranchResponse():AddBranchResponse();
                                  }
                                })),

                          ]
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  //ADD BRANCH
  Future<void> AddBranchResponse()async{
    final addBranchApiService = ApiService(ref.read(dioProvider));
    var formData = FormData.fromMap({
      "branch_name":_branchName.text,
      "branch_phone":_branchPhoneNumber.text,
      "branch_email":_branchMailAddress.text,
      "branch_address":_branchAddress.text,
      "recruiter_id":await getRecruiterId()
    });
    final addBrachApiResponse = await addBranchApiService.post<AddBranchModel>(context,ConstantApi.addBranchUrl, formData);
    if(addBrachApiResponse.status == true){
      print("SUCESS");
      Navigator.pop(context);
    }else{
      ShowToastMessage(addBrachApiResponse.message ?? "");
      print('ERROR');
    }
  }
  //BRANCH DETAIL
  BranchDetailResponse() async {
    final branchDetailApiService = ApiService(ref.read(dioProvider));
    var formData = FormData.fromMap({"branch_id": widget.branch_id});
    final branchDetailResponse = await branchDetailApiService
        .post<BranchDetailModel>(context,ConstantApi.branchDetailUrl, formData);
    if (branchDetailResponse.status == true) {
      setState(() {
        branchResponseData = branchDetailResponse.data;
        _branchName.text = branchResponseData?.branchName ?? "";
        _branchMailAddress.text=branchResponseData?.branchEmail ?? "";
        _branchAddress.text=branchResponseData?.branchAddress ?? "";
        _branchPhoneNumber.text=branchResponseData?.branchPhone ?? "";
      });
      print("SUCESS");
    } else {
      ShowToastMessage(branchDetailResponse.message ?? "");
      print('ERROR');
    }
  }
  //EDIT BRANCH
  Future<void> EditBranchResponse()async{
    final addBranchApiService = ApiService(ref.read(dioProvider));
    var formData = FormData.fromMap({
      "branch_name":_branchName.text,
      "branch_phone":_branchPhoneNumber.text,
      "branch_email":_branchMailAddress.text,
      "branch_address":_branchAddress.text,
      "branch_id":widget.branch_id,
    });
    final addBrachApiResponse = await addBranchApiService.post<AddBranchModel>(context,ConstantApi.editBranchUrl, formData);
    if(addBrachApiResponse.status == true){
      print("SUCESS");
      Navigator.pop(context);
    }else{
      ShowToastMessage(addBrachApiResponse.message ?? "");
      print('ERROR');
    }
  }

}
