import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:getifyjobs/Models/BranchDetailModel.dart';
import 'package:getifyjobs/Models/ProfileModel.dart';
import 'package:getifyjobs/Src/Common_Widgets/Common_Button.dart';
import 'package:getifyjobs/Src/Common_Widgets/Image_Path.dart';
import 'package:getifyjobs/Src/Common_Widgets/Image_Widget.dart';
import 'package:getifyjobs/Src/Common_Widgets/Refferal_Card.dart';
import 'package:getifyjobs/Src/Common_Widgets/Text_Form_Field.dart';
import 'package:getifyjobs/Src/Recruiter_Web_Screens/Recuiter_Login/Recruiter_Web_Add_Branch_Screen.dart';
import 'package:getifyjobs/Src/Recruiter_Web_Screens/Recuiter_Login/Recuiter_Web_Login_Screen.dart';
import 'package:getifyjobs/Src/utilits/ApiService.dart';
import 'package:getifyjobs/Src/utilits/Common_Colors.dart';
import 'package:getifyjobs/Src/utilits/ConstantsApi.dart';
import 'package:getifyjobs/Src/utilits/Generic.dart';
import 'package:getifyjobs/Src/utilits/Text_Style.dart';

class Recruiter_Web_Profile_Screen extends ConsumerStatefulWidget {
  const Recruiter_Web_Profile_Screen({super.key});

  @override
  ConsumerState<Recruiter_Web_Profile_Screen> createState() =>
      _Recruiter_Web_Profile_ScreenState();
}

class _Recruiter_Web_Profile_ScreenState
    extends ConsumerState<Recruiter_Web_Profile_Screen> {
  bool isBranchAvailable = true;
  final List<String> branches = [
    'Branch 1',
    'Branch 2',
    'Branch 3',
    'Branch 4',
  ];
  ProfileData? profileDataResponse;
  BranchDetailData? branchResponseData;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ProfileResponse();
    // BranchDetailResponse();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: white2,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 100, right: 100),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: white1,
                  ),
                  margin: EdgeInsets.only(top: 20),
                  width: MediaQuery.of(context).size.width,
                  // 20% of screen width
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 15),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            left: 10, right: 10, top: 10, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //RECRUITER PROFILE IMAGE
                            Container(
                              height: 100,
                              width: 100,
                              child: buildImage(profileDataResponse?.logo ?? "",
                                  border: const Radius.circular(50),
                                  fit: BoxFit.cover),
                            ),
                            //RECRUITER NAME AND DESCRIPTION
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      alignment: Alignment.topLeft,
                                      margin: EdgeInsets.only(left: 10),
                                      child: Text(
                                        profileDataResponse?.companyName ?? "",
                                        style: TitleT,
                                      )),
                                  Container(
                                      width: MediaQuery.of(context).size.width /
                                          1.5,
                                      margin: EdgeInsets.only(left: 10),
                                      child: Text(
                                        profileDataResponse?.aboutCompany ?? "",
                                        style: typeT,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      )),
                                ],
                              ),
                            ),
                            const Spacer(),
                            //MORE ICON
                            PopupMenuButton(
                                surfaceTintColor: white1,
                                icon: Icon(Icons.more_vert_outlined),
                                itemBuilder: (BuildContext context) => [
                                      PopupMenuItem(
                                          child: Text(
                                        'Edit',
                                        style: refferalCountT,
                                      )),
                                      PopupMenuItem(
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return alertDialogBox(context,
                                                    onPress: () {
                                                  Navigator.pop(context);
                                                });
                                              },
                                            );
                                          },
                                          child: Text(
                                            'Download',
                                            style: refferalCountT,
                                          )),
                                      PopupMenuItem(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Recuiter_Web_Login_Screen()));
                                          },
                                          child: Text(
                                            'Log out',
                                            style: logOutRed,
                                          )),
                                    ]),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                color: white1,
                child: IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 15, bottom: 15, left: 25),
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2.5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              contactDetails(
                                  context,
                                  ContactLogo: 'phone.svg',
                                  Details: profileDataResponse?.phone ?? ''),
                              contactDetails(
                                  context,
                                  ContactLogo: 'email.svg',
                                  Details: profileDataResponse?.email ?? ""),
                              contactDetails(
                                  context,
                                  ContactLogo: 'mapblue.svg',
                                  Details: profileDataResponse?.location ?? ""),
                            ],
                          ),
                        ),
                      ),
                      VerticalDivider(
                        color: white2,
                        thickness: 2,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10, bottom: 10, left: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            cardTitle(cardTitleT: 'Industry Type'),
                            Text(
                             "${ profileDataResponse?.industry ?? ""}",
                              style: stxt,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            cardTitle(cardTitleT: 'Company Started Date'),
                            Text(
                              profileDataResponse?.companyStartDate ?? "",
                              style: stxt,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              IntrinsicHeight(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  color: white1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 15, bottom: 15, left: 25),
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2.5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Recruiter Name",
                                style: bluetxt,
                              ),
                              Container(
                                  child: Text(
                                profileDataResponse?.name ?? "",
                                style: attachT1,
                              )),
                            ],
                          ),
                        ),
                      ),
                      VerticalDivider(
                        color: white2,
                        thickness: 2,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 15, bottom: 15, left: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            cardTitle(cardTitleT: 'Date of Birth'),
                            Text(
                              profileDataResponse?.dob ?? "",
                              style: stxt,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              IntrinsicHeight(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  // height: 100,
                  color: white1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 15, bottom: 15, left: 25),
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2.5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ReferalCardWeb(context,
                                  isRefferal: false,
                                  RefferEarn: 'Refer & Earn 12 Coins',
                                  refferalCode: 'ABR47645'),
                            ],
                          ),
                        ),
                      ),
                      VerticalDivider(
                        color: white2,
                        thickness: 2,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 15, bottom: 15, left: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            referralCountWeb(context,
                                totalReferal: '12', pending: '2'),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              IntrinsicHeight(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  // height: 100,
                  color: white1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width / 2.58,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: white1,
                          ),
                          margin: EdgeInsets.only(top: 15, right: 20,left: 20),
                          child: Container(
                            margin: EdgeInsets.only(bottom: 15),
                            child: Text(
                              "Branches",
                              style: bluetxt,
                            ),
                          )),
                      VerticalDivider(
                        color: white2,
                        thickness: 2,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 3,
                        height: 200,
                       color: white1,
                        margin: EdgeInsets.only(top: 10,bottom: 10,left: 20,right: 10),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
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
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return profileDataResponse?.branch?[index].branchAddress == null
                                                  ? AlertDialog(
                                                      surfaceTintColor: white1,
                                                      title: Center(
                                                          child: Text(
                                                        'Add Branch Details',
                                                        style: TitleT,
                                                      )),
                                                      actions: [
                                                        CommonElevatedButton(
                                                            context, "Add", () {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                         Recruiter_Web_Add_Branch_Screen(branch_id: '', isEdit: false,)),
                                                          );
                                                        })
                                                      ],
                                                    )
                                                  : AlertDialog(
                                                      surfaceTintColor: white1,
                                                      title: Center(
                                                          child: Row(
                                                            children: [
                                                              Text('Branch', style: TitleT,),
                                                              const Spacer(),
                                                              InkWell(
                                                                onTap: (){
                                                                  Navigator.pop(context);
                                                                  Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                                                      Recruiter_Web_Add_Branch_Screen(branch_id: profileDataResponse?.branch?[index].branchId ?? "", isEdit: true,)),
                                                                  ).then((value) => ref.read(ProfileResponse()));
                                                                  },
                                                                  child: Icon(Icons.edit_outlined,size: 25,color: blue1,))
                                                            ],
                                                          )),
                                                      
                                                      // content: Text(""),
                                                      actions: [
                                                        Container(
                                                          child: Column(
                                                            children: [
                                                              contactDetails(
                                                                  context,
                                                                  ContactLogo:
                                                                      'homeactive.svg',
                                                                  Details:
                                                                  profileDataResponse?.branch?[index].branchName ?? ""),
                                                              contactDetails(
                                                                  context,
                                                                  ContactLogo:
                                                                      'phone.svg',
                                                                  Details:
                                                                  profileDataResponse?.branch?[index].branchPhone ?? ""),
                                                              contactDetails(
                                                                  context,
                                                                  ContactLogo:
                                                                      'email.svg',
                                                                  Details:
                                                                  profileDataResponse?.branch?[index].branchEmail ?? ""),
                                                              contactDetails(
                                                                  context,
                                                                  ContactLogo:
                                                                      'mapblue.svg',
                                                                  Details:
                                                                  profileDataResponse?.branch?[index].branchAddress ?? ""),
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    );
                                            },
                                          );
                                        },
                                        child: Icon(
                                          Icons.keyboard_arrow_right_sharp,
                                          size: 25,
                                        ))
                                  ],
                                ));
                          },
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(top: 10,right: 20),
                        child: InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) =>
                             Recruiter_Web_Add_Branch_Screen(branch_id: '', isEdit: false,)),
                            ).then((value) => ref.read(ProfileResponse()));
                          },
                            child: Icon(Icons.add_business_rounded,size: 25,color: blue1,)),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ]),
          ),
        ));
  }

  //PROFILE RESPONSE
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
 //BRANCH DETAIL RESPONSE

}

//ALERT DIALOG BOX
Widget alertDialogBox(context, {void Function()? onPress}) {
  return AlertDialog(
    backgroundColor: white1,
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
      height: 150,
      width: 350,
      child: Column(
        children: [
          Text(
            "Click to download the History of your ",
            style: walletT,
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
