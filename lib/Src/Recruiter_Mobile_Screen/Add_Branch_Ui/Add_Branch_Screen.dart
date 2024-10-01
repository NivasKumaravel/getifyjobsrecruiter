import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:getifyjobs/Models/AddBranchModel.dart';
import 'package:getifyjobs/Models/BranchDetailModel.dart';
import 'package:getifyjobs/Src/Common_Widgets/Common_Button.dart';
import 'package:getifyjobs/Src/Common_Widgets/Custom_App_Bar.dart';
import 'package:getifyjobs/Src/Common_Widgets/Text_Form_Field.dart';
import 'package:getifyjobs/Src/utilits/ApiService.dart';
import 'package:getifyjobs/Src/utilits/Common_Colors.dart';
import 'package:getifyjobs/Src/utilits/ConstantsApi.dart';
import 'package:getifyjobs/Src/utilits/Generic.dart';
import 'package:getifyjobs/Src/utilits/Text_Style.dart';

class Add_Branch_Screen extends ConsumerStatefulWidget {
  bool? isEdit;
  BranchDetailData? branchData;

  Add_Branch_Screen(
      {super.key, required this.isEdit, required this.branchData});

  @override
  ConsumerState<Add_Branch_Screen> createState() => _Add_Branch_ScreenState();
}

class _Add_Branch_ScreenState extends ConsumerState<Add_Branch_Screen> {
  TextEditingController _branchName = TextEditingController();
  TextEditingController _phoneNumber = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _branchAddress = TextEditingController();
  EditBranchData() async {
    _branchName.text = widget.branchData?.branchName ?? "";
    _phoneNumber.text = widget.branchData?.branchPhone ?? "";
    _email.text = widget.branchData?.branchEmail ?? "";
    _branchAddress.text = widget.branchData?.branchAddress ?? "";
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    EditBranchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white2,
      appBar: Custom_AppBar(
        isUsed: true,
        actions: null,
        isLogoUsed: true,
        isTitleUsed: true,
        title: widget.isEdit == true ? "Edit Branch" : "Add Branch",
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //RECRUITER NAME
                Title_Style(Title: 'Branch Name', isStatus: true),
                textFormField2(
                  hintText: 'Enter Branch Name',
                  keyboardtype: TextInputType.text,
                  inputFormatters: null,
                  Controller: _branchName,
                  validating: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter ${'Branch Name'}";
                    }
                    if (value == null) {
                      return "Please Enter Valid ${'Branch Name'}";
                    }
                    return null;
                  },
                  onChanged: null,
                ),

                //Phone Number*
                Title_Style(Title: 'Branch Phone Number', isStatus: true),
                textFormField2(
                  hintText: 'Enter Branch Phone Number',
                  keyboardtype: TextInputType.phone,
                  inputFormatters: [LengthLimitingTextInputFormatter(10)],
                  Controller: _phoneNumber,
                  validating: (value) {
                    if (value!.isEmpty) {
                      return "Please enter Branch Phone Number";
                    } else if (!RegExp(r"^[0-9]{10}$").hasMatch(value)) {
                      return "Please enter Branch Phone Number";
                    }
                    return null;
                  },
                  onChanged: null,
                ),

                //Enter Official Email Address*
                Title_Style(Title: 'Branch Email Address', isStatus: true),
                textFormField2(
                  hintText: 'Enter Branch Email Address',
                  keyboardtype: TextInputType.text,
                  inputFormatters: null,
                  Controller: _email,
                  validating: (value) {
                    if (value!.isEmpty) {
                      return "Please enter Branch Email Address";
                    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                        .hasMatch(value)) {
                      return "Please enter Branch Email Address";
                    }
                    return null;
                  },
                  onChanged: null,
                ),
                //Branch ADDRESS
                Title_Style(Title: 'Enter Branch Address', isStatus: true),
                textfieldDescription2(
                  Controller: _branchAddress,
                  validating: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter ${'Branch Address'}";
                    }
                    if (value == null) {
                      return "Please Enter ${'Branch Address'}";
                    }
                    return null;
                  },
                  hint: 'Branch Address',
                ),

                //BUTTON
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30, top: 50),
                  child: CommonElevatedButton(
                      context,
                      "Submit",
                      () => widget.isEdit == true
                          ? EditBranchResponse()
                          : AddBranchResponse()),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //ADD BRANCH
  Future<void> AddBranchResponse() async {
    final addBranchApiService = ApiService(ref.read(dioProvider));
    var formData = FormData.fromMap({
      "branch_name": _branchName.text,
      "branch_phone": _phoneNumber.text,
      "branch_email": _email.text,
      "branch_address": _branchAddress.text,
      "recruiter_id": await getRecruiterId()
    });
    final addBrachApiResponse = await addBranchApiService.post<AddBranchModel>(
        context, ConstantApi.addBranchUrl, formData);
    if (addBrachApiResponse.status == true) {
      print("SUCESS");
      // Navigator.push(context, MaterialPageRoute(builder: (context)=>Recruiter_Bottom_Navigation(select: 3)));
      Navigator.pop(context, true);
    } else {
      ShowToastMessage(addBrachApiResponse.message ?? "");
      print('ERROR');
    }
  }

  //EDIT BRANCH
  Future<void> EditBranchResponse() async {
    final addBranchApiService = ApiService(ref.read(dioProvider));
    var formData = FormData.fromMap({
      "branch_name": _branchName.text,
      "branch_phone": _phoneNumber.text,
      "branch_email": _email.text,
      "branch_address": _branchAddress.text,
      "branch_id": widget.branchData?.branchId ?? ""
    });
    final addBrachApiResponse = await addBranchApiService.post<AddBranchModel>(
        context, ConstantApi.editBranchUrl, formData);
    if (addBrachApiResponse.status == true) {
      print("SUCESS");
      Navigator.pop(context);
    } else {
      ShowToastMessage(addBrachApiResponse.message ?? "");
      print('ERROR');
    }
  }
}
