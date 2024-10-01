import 'package:flutter/material.dart';
import 'package:getifyjobs/Src/Common_Widgets/Custom_App_Bar.dart';
import 'package:getifyjobs/Src/Common_Widgets/Image_Widget.dart';
import 'package:getifyjobs/Src/utilits/Common_Colors.dart';
import 'package:getifyjobs/Src/utilits/Text_Style.dart';
import 'package:qr_flutter/qr_flutter.dart';

class Qr_ProfileCode_Screen extends StatefulWidget {
  final String? qrCode;
  final String? qrImage;

   Qr_ProfileCode_Screen({super.key,required this.qrCode,required this.qrImage});

  @override
  State<Qr_ProfileCode_Screen> createState() => _Qr_ProfileCode_ScreenState();
}

class _Qr_ProfileCode_ScreenState extends State<Qr_ProfileCode_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white2,
      appBar: Custom_AppBar(
        title: "Recruiter Code",
        isUsed: true,
        actions: [
        ],
        isLogoUsed: true,
        isTitleUsed: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20,right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: blue2
              ),
              child:
              Column(
                children: [
                  const SizedBox(height: 20,),
                  Container(
                    height: 400,
                    width: MediaQuery.sizeOf(context).width,
                    child: buildImage(widget.qrImage ?? "",
                        border: const Radius.circular(50), fit: BoxFit.cover),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15,bottom: 25),
                    child: Text(widget.qrCode ?? "",style: TitleT,),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
