import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:getifyjobs/Models/ProfileModel.dart';
import 'package:getifyjobs/Src/Common_Widgets/Common_Button.dart';
import 'package:getifyjobs/Src/Common_Widgets/Custom_App_Bar.dart';
import 'package:getifyjobs/Src/Common_Widgets/Refferal_Card.dart';
import 'package:getifyjobs/Src/Recruiter_Mobile_Screen/Add_Branch_Ui/Add_Branch_Screen.dart';
import 'package:getifyjobs/Src/Recruiter_Mobile_Screen/Branch_Detail_Ui/Branch_Detail_Screen.dart';
import 'package:getifyjobs/Src/Recruiter_Mobile_Screen/Qr_ProfileCode_Ui/Qr_ProfileCode_Screen.dart';
import 'package:getifyjobs/Src/Recruiter_Mobile_Screen/Recruiter_Create_Account_Ui/Recruiter_Create_Account.dart';
import 'package:getifyjobs/Src/utilits/ApiService.dart';
import 'package:getifyjobs/Src/utilits/ConstantsApi.dart';
import 'package:getifyjobs/Src/utilits/Generic.dart';

import '../../Common_Widgets/Image_Path.dart';
import '../../utilits/Common_Colors.dart';
import '../../utilits/Text_Style.dart';

class Recuiter_Profile_Screen extends ConsumerStatefulWidget {
  const Recuiter_Profile_Screen({super.key});

  @override
  ConsumerState<Recuiter_Profile_Screen> createState() =>
      _RecuiterProfileState();
}

class _RecuiterProfileState extends ConsumerState<Recuiter_Profile_Screen> {
  ProfileData? profileDataResponse;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ProfileResponse();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white2,
      appBar: Custom_AppBar(
        isUsed: false,
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
                                      builder: (context) =>
                                          Recruiter_Create_Account_Screen(
                                            isEdit: true,
                                            editResponse: profileDataResponse,
                                          )))
                              .then((value) => ref.refresh(ProfileResponse()));
                        },
                        child: Text('Edit')),
                    PopupMenuItem(
                        child: InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return alertDialogBox(context, onPress: () {
                                    Navigator.pop(context);
                                  });
                                },
                              );
                            },
                            child: Text('Download'))),
                  ]),
        ],
        isLogoUsed: false,
        isTitleUsed: true,
        title: "",
      ),
      body: SingleChildScrollView(
        child: _Main_Body(),
      ),
    );
  }

  //MAIN BODY
  Widget _Main_Body() {
    return Column(
      children: [
        //RECRUITER IMAGE
        Center(
          child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Qr_ProfileCode_Screen(
                              qrCode: profileDataResponse?.qrCode ?? "",
                              qrImage: profileDataResponse?.qrImage ?? "",
                            )));
              },
              child: profileImg(ProfileImg: profileDataResponse?.logo ?? "")),
        ),
        //PROFILE NAME
        ProfileName(context,
            ProfileName: profileDataResponse?.companyName ?? ""),
        Container(
          width: MediaQuery.of(context).size.width / 1.2,
          margin: EdgeInsets.only(top: 10, right: 20, left: 20),
          child: Text(
            profileDataResponse?.aboutCompany ?? "",
            style: typeT,
            textAlign: TextAlign.justify,
          ),
        ),
        Container(
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5), color: white1),
            margin: EdgeInsets.only(top: 15, left: 20, right: 20),
            child: Container(
              margin: EdgeInsets.only(left: 15, top: 15),
              child: Column(
                children: [

                  profileDataResponse?.phone == profileDataResponse?.personalPhone ? Container() :
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.phone_android,color: Color.fromRGBO(0, 160, 226, 1),),
                        const SizedBox(width: 8),
                        Text('${profileDataResponse?.personalPhone ?? ''}',style: stxt,)
                      ],
                    ),
                  ),
                  contactDetails(context,
                      ContactLogo: 'phone.svg',
                      Details: profileDataResponse?.phone ?? ''),
                  contactDetails(context,
                      ContactLogo: 'email.svg',
                      Details: profileDataResponse?.email ?? ""),
                  contactDetails(context,
                      ContactLogo: 'mapblue.svg',
                      Details: profileDataResponse?.address ?? ""),
                ],
              ),
            )),
        Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: white1,
            ),
            margin: EdgeInsets.only(top: 15, left: 20, right: 20),
            child: Container(
              margin: EdgeInsets.only(top: 15, bottom: 15, left: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  cardTitle(cardTitleT: 'Industry Type'),
                  cardDetail(context,
                      cardDetails: "${profileDataResponse?.industry ?? ""}"),
                  const SizedBox(height: 15),
                  cardTitle(cardTitleT: 'Company Started Date'),
                  cardDetail(context,
                      cardDetails: profileDataResponse?.companyStartDate ?? ""),
                ],
              ),
            )),
        Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: white1,
            ),
            margin: EdgeInsets.only(top: 15, left: 20, right: 20),
            child: Container(
              margin: EdgeInsets.only(top: 20, bottom: 20, left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Recruiter Name",
                    style: bluetxt,
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width / 1.2,
                      child: Text(
                        profileDataResponse?.name ?? "",
                        style: attachT1,
                      )),
                  const SizedBox(height: 15),
                  cardTitle(cardTitleT: 'Date of Birth'),
                  cardDetail(context,
                      cardDetails: profileDataResponse?.dob ?? ""),
                ],
              ),
            )),
        //BRANCH LIST
        _Branch_List(profileDataResponse),
        //REFFERAL CARD

        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
          child: ReferalCard(context,
              isRefferal: true,
              RefferEarn: 'Refer & Earn 12 Coins',
              refferalCode: 'ABR47645'),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: referralCount(context, totalReferal: '12', pending: '2'),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: Center(child: LogOutButton(context)),
        ),
      ],
    );
  }

  //PROFILE API
  ProfileResponse() async {
    final profileApiService = ApiService(ref.read(dioProvider));

    var formData = FormData.fromMap({
      "recruiter_id": await getRecruiterId(),
    });
    final profileResponse = await profileApiService.post<ProfileModel>(
        context, ConstantApi.profileUrl, formData);
    if (profileResponse.status == true) {
      setState(() {
        profileDataResponse = profileResponse.data;
      });
    } else {
      print("ERROR");
      ShowToastMessage(profileResponse?.message ?? "");
    }
  }

  Widget _Branch_List(ProfileData? profileDataResponse) {
    return //BRANCHES
        Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: white1,
            ),
            margin: EdgeInsets.only(top: 15, left: 20, right: 20),
            child: Container(
              margin: EdgeInsets.only(top: 15, bottom: 15, left: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      cardTitle(cardTitleT: 'Branches'),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(right: 25),
                        child: InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  // Return the AlertDialog
                                  return AlertDialog(
                                    surfaceTintColor: white1,
                                    title: Center(
                                        child: Text(
                                      'Add Branch',
                                      style: TitleT,
                                    )),

                                    // content: Text(""),
                                    actions: [
                                      CommonElevatedButton(context, 'Add', () {
                                        Navigator.pop(context);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Add_Branch_Screen(
                                                      isEdit: false,
                                                      branchData: null,
                                                    ))).then((value) {
                                          if (value == true) {
                                            ref.refresh(ProfileResponse());
                                          }
                                        });
                                      })
                                    ],
                                  );
                                },
                              );
                            },
                            child: Icon(
                              Icons.add_business_rounded,
                              size: 25,
                              color: blue1,
                            )),
                      )
                    ],
                  ),
                  profileDataResponse?.branch?.length == 0
                      ? Text("No Branches")
                      : Container(
                          // height: totalHeight,
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: profileDataResponse?.branch?.length ?? 0,
                            itemBuilder: (context, index) {
                              return Padding(
                                  padding:
                                      const EdgeInsets.only(top: 5, bottom: 5),
                                  child: Row(
                                    children: [
                                      Text(
                                        profileDataResponse
                                                ?.branch?[index].branchName ??
                                            "",
                                        style: stxt,
                                      ),
                                      Spacer(),
                                      InkWell(
                                          onTap: () {
                                            // showDialog(
                                            //   context: context,
                                            //   builder: (BuildContext context) {
                                            //     // Return the AlertDialog
                                            //     return AlertDialog(
                                            //       surfaceTintColor: white1,
                                            //       title: Center(child: Text('Add Branch',style: TitleT,)),
                                            //
                                            //       // content: Text(""),
                                            //       actions: [
                                            //         CommonElevatedButton(context, 'Add', () {
                                            //           Navigator.push(context, MaterialPageRoute(builder: (context)=>Add_Branch_Screen(isEdit: false, branchData: null,)));
                                            //         })
                                            //       ],
                                            //     );
                                            //   },
                                            // ):
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Branch_Detail_Screen(
                                                          branchId:
                                                              profileDataResponse
                                                                      ?.branch?[
                                                                          index]
                                                                      ?.branchId ??
                                                                  "",
                                                        ))).then(
                                                (value) => ProfileResponse());
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(right: 25),
                                            child: Icon(
                                              Icons.keyboard_arrow_right_sharp,
                                              size: 25,
                                            ),
                                          ))
                                    ],
                                  ));
                            },
                          ),
                        ),
                ],
              ),
            ));
  }
}

Widget alertDialogBox(context, {void Function()? onPress}) {
  return AlertDialog(
    backgroundColor: white1,
    surfaceTintColor: white1,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10))),
    titlePadding: EdgeInsets.all(0),
    title: Container(
        alignment: Alignment.topRight,
        child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: ImgPathSvg("xcancel.svg"))),
    contentPadding: EdgeInsets.only(right: 20, left: 20, bottom: 0),
    content: Container(
      height: 180,
      width: 350,
      child: Column(
        children: [
          Text(
            "Click to download the History of your ",
            style: walletT,
            textAlign: TextAlign.center,
          ),
          Text(
            "Jobs and Candidate Status",
            style: profileTitle,
          ),
          const SizedBox(
            height: 15,
          ),
          CommonElevatedButton(context, "Download", onPress)
        ],
      ),
    ),
  );
}
