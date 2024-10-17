import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:getifyjobs/Models/AddBranchModel.dart';
import 'package:getifyjobs/Models/BranchDetailModel.dart';
import 'package:getifyjobs/Src/Common_Widgets/Custom_App_Bar.dart';
import 'package:getifyjobs/Src/Recruiter_Mobile_Screen/Add_Branch_Ui/Add_Branch_Screen.dart';
import 'package:getifyjobs/Src/utilits/ApiService.dart';
import 'package:getifyjobs/Src/utilits/Common_Colors.dart';
import 'package:getifyjobs/Src/utilits/ConstantsApi.dart';
import 'package:getifyjobs/Src/utilits/Generic.dart';
import 'package:getifyjobs/Src/utilits/Text_Style.dart';

class Branch_Detail_Screen extends ConsumerStatefulWidget {
  String? branchId;

  Branch_Detail_Screen({super.key, required this.branchId});

  @override
  ConsumerState<Branch_Detail_Screen> createState() =>
      _Branch_Detail_ScreenState();
}

class _Branch_Detail_ScreenState extends ConsumerState<Branch_Detail_Screen> {
  BranchDetailData? branchResponseData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BranchDetailResponse();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white2,
      appBar: Custom_AppBar(
        isUsed: true,
        actions: [
          PopupMenuButton(
              surfaceTintColor: white1,
              icon: Icon(Icons.more_vert_outlined),
              itemBuilder: (BuildContext context) => [
                    PopupMenuItem(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Add_Branch_Screen(
                                        isEdit: true,
                                        branchData: branchResponseData,
                                      ))).then((value) => ref.refresh(BranchDetailResponse()));
                        },
                        child: Text('Edit')),
                PopupMenuItem(
                    onTap: () {
                      DeleteBranchResponse();
                    },
                    child: Text('Delete')),
                  ]),
        ],
        isLogoUsed: true,
        isTitleUsed: true,
        title: "Branch",
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5), color: white1),
                margin: EdgeInsets.only(top: 25, left: 20, right: 20),
                child: Container(
                  margin: EdgeInsets.only(left: 15, top: 15),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.cabin_rounded,
                              size: 25,
                              color: blue1,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                                width: MediaQuery.of(context).size.width / 1.5,
                                child: Text(
                                  branchResponseData?.branchName ?? "",
                                  style: stxt,
                                  maxLines: 2,
                                ))
                          ],
                        ),
                      ),
                      Branch_Details_Card(context,
                          ContactLogo: 'phone.svg',
                          Details: branchResponseData?.branchPhone ?? ""),
                      Branch_Details_Card(context,
                          ContactLogo: 'email.svg',
                          Details: branchResponseData?.branchEmail ?? ""),
                      Branch_Details_Card(context,
                          ContactLogo: 'mapblue.svg',
                          Details: branchResponseData?.branchAddress ?? ""),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }

   BranchDetailResponse() async {
    final branchDetailApiService = ApiService(ref.read(dioProvider));
    var formData = FormData.fromMap({"branch_id": widget.branchId});
    final branchDetailResponse = await branchDetailApiService
        .post<BranchDetailModel>(context,ConstantApi.branchDetailUrl, formData);
    if (branchDetailResponse.status == true) {
      setState(() {
        branchResponseData = branchDetailResponse.data;
      });
      print("SUCESS");
    } else {
      ShowToastMessage(branchDetailResponse.message ?? "");
      print('ERROR');
    }
  }

  //DELETE BRANCH
  Future<void> DeleteBranchResponse() async {
    final addBranchApiService = ApiService(ref.read(dioProvider));
    var formData = FormData.fromMap({
      "branch_id": branchResponseData?.branchId ?? ""
    });
    final addBrachApiResponse = await addBranchApiService.post<AddBranchModel>(
        context, ConstantApi.deleteBranchUrl, formData);
    if (addBrachApiResponse.status == true) {
      print("SUCESS");
    } else {
      ShowToastMessage(addBrachApiResponse.message ?? "");
      print('ERROR');
    }
  }
}
