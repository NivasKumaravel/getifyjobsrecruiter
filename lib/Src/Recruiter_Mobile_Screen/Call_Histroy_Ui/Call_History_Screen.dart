import 'package:flutter/material.dart';
import 'package:getifyjobs/Src/Common_Widgets/Custom_App_Bar.dart';
import 'package:getifyjobs/Src/utilits/Common_Colors.dart';
import 'package:getifyjobs/Src/utilits/Text_Style.dart';

class Call_History_Screen extends StatefulWidget {
  const Call_History_Screen({super.key});

  @override
  State<Call_History_Screen> createState() => _Call_History_ScreenState();
}

class _Call_History_ScreenState extends State<Call_History_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white2,
      appBar: Custom_AppBar(
        title: "Call History",

        isUsed: true,
        actions: [

        ],
        isLogoUsed: true,
        isTitleUsed: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20,right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.sizeOf(context).width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: white1
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 10,right: 10,top: 20,bottom: 5),
                child:callList()

              ),
            ),
          ],
        ),
      ),
    );
  }

}

Widget callList(){
  return ListView.builder(
    itemCount: 5,
    scrollDirection: Axis.vertical,
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemBuilder: (BuildContext context, int index) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.compare_arrows_sharp,color: blue1,),
                const SizedBox(width: 15,),
                Icon(Icons.call_outlined),
                const SizedBox(width: 5,),
                Text("Call Requested",style: TBlack,),
              ],
            ),
            Container(
                width: MediaQuery.sizeOf(context).width/1.5,
                margin: EdgeInsets.only(left: 40,top: 5),
                child: Text("Requested Call On 01-12-2024, 06:34PM",style: phoneHT1,maxLines: 2,)),
          ],
        ),
      );
    },);
}