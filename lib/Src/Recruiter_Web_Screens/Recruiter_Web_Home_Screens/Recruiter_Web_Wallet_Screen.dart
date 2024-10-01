import 'package:flutter/material.dart';
import 'package:getifyjobs/Src/Common_Widgets/Common_Button.dart';
import 'package:getifyjobs/Src/Common_Widgets/Custom_App_Bar.dart';
import 'package:getifyjobs/Src/Common_Widgets/Image_Path.dart';
import 'package:getifyjobs/Src/Recruiter_Mobile_Screen/Home_DashBoard/Wallet_Screens.dart';
import 'package:getifyjobs/Src/utilits/Common_Colors.dart';
import 'package:getifyjobs/Src/utilits/Text_Style.dart';

class Recruiter_Web_Wallet_Screen extends StatefulWidget {
  @override
  _Recruiter_Web_Wallet_ScreenState createState() => _Recruiter_Web_Wallet_ScreenState();
}

class _Recruiter_Web_Wallet_ScreenState extends State<Recruiter_Web_Wallet_Screen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white2,
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            _downLoad(onTap: (){
              showDialog(
                context: context,
                builder: (context) {
                  return
                    alertDialogBox(context,onPress: (){
                      Navigator.pop(context);
                    });
                },
              );
            }),
            _addCoin(context),
            Padding(
              padding: const EdgeInsets.only(left: 130,right: 120),
              child: applyContain(),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 150,right: 150),
              child: Container(
                color: white1,
                width: MediaQuery.of(context).size.width,
                child: TabBar(
                  controller: _tabController,
                  labelColor: white1,
                  labelStyle: TabT,
                  indicator: BoxDecoration(
                      color: blue1
                  ),
                  indicatorColor: grey4,
                  unselectedLabelColor: grey4,
                  indicatorPadding: EdgeInsets.zero,
                  indicatorSize: TabBarIndicatorSize.tab,
                  tabs: [
                    Container(
                      width: MediaQuery.of(context).size.width / 2, // Equal width for each tab
                      child: Tab(
                        text: 'History',
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 2, // Equal width for each tab
                      child: Tab(
                        text: 'Invoice',
                      ),
                    ),

                  ],
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  //HISTORY
                  SingleChildScrollView(child: Padding(
                    padding: const EdgeInsets.only(top: 10,bottom: 50,left: 130,right: 130),
                    child: HistoryList(null),
                  )),
                  //INVOICE
                  SingleChildScrollView(child:
                  Padding(
                    padding: const EdgeInsets.only(top: 10,bottom: 50),
                    child: _InvoiceList(),
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}

//COINS AND DOWNLOAD
Widget _downLoad({void Function()? onTap}){
  return  Padding(
    padding: const EdgeInsets.only(left: 150,right: 150,top: 25,bottom: 15),
    child: Row(
      children: [
        Text("Coins",style: TitleT,),
        const Spacer(),
        InkWell(
          onTap:onTap,
          child: Row(children: [
            ImgPathSvg("download.svg"),
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Text("Download",style: interviewLocationT,),
            ),
          ],),
        ),
      ],
    ),
  );

}

//WALLET COINS
// ADDING COIN
Widget _addCoin(context){
  return  Padding(
    padding: const EdgeInsets.only(left: 150,right: 150,),
    child: Row(
      children: [
        Container(
          height: 75,
          width: MediaQuery.of(context).size.width/1.5,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: white1
          ),
          child: Center(
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10, left: 15),
                  child: ImgPathSvg("coin.svg"),
                ),
                Text(
                  '12 Coins',
                  style: walletT,
                ),

              ],
            ),
          ),
        ),
        const Spacer(),
        Container(
            margin: EdgeInsets.only(left: 20),
            height: 75,
            width: 75,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: white1
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add,size: 24,color: blue1,),
                Text(
                  'Add',
                  style: walletT,
                ),
              ],
            )
        ),
      ],
    ),
  );
}

//INVOICE LIST
//INVOICE LIST
Widget _InvoiceList(){
  return  ListView.builder(
    itemCount: 10,
    physics: const NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    scrollDirection: Axis.vertical,
    itemBuilder: (BuildContext context, int index) {
      return Padding(
        padding: const EdgeInsets.only(left: 150,right: 150,top: 15),
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: white1
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 15,right: 15),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10,bottom: 10),
                  child: Row(
                    children: [
                      Text("07 Feb 2023",style: dateT,),
                      const Spacer(),
                      Text("+₹150",style: debitedT,),
                      Container(
                        width: 150,
                        height: 40,
                        margin: EdgeInsets.only(left: 15),
                        child: CommonElevatedButton_No_Elevation(context,"Get Invoice",(){
                          showDialog(
                            context: context,
                            builder: (context) {
                              return
                                alertDialogBoxGetInvoice(context);
                            },
                          );
                        },
                            white2,addLanguageT
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
    },);

}