import 'package:flutter/material.dart';
import 'package:getifyjobs/Src/Common_Widgets/Common_List.dart';
import 'package:getifyjobs/Src/Common_Widgets/Custom_App_Bar.dart';
import 'package:getifyjobs/Src/utilits/Text_Style.dart';
class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Custom_AppBar(
        isUsed: false,
        actions: [],
        isLogoUsed: true,
        title: 'Notification',
        isTitleUsed: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 20,left: 20,top: 5),
            child: Container(
              width: MediaQuery.of(context).size.width,
              child:buildCompanyInfoRowNotifacation(
                  context,
                  pathSVG: "personimg.svg",
                  jobName: "Augmented Reality (AR) Journey Builder‍aaaaaaa",
                  name: "Karthik Raja S",
                  imageWidth: 50,
                  imageHeight: 50)
              // Text("data")
            ),
          )
        ],
      ),
    );
  }
}

