import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:getifyjobs/Src/utilits/Common_Colors.dart';
import 'package:getifyjobs/Src/utilits/Generic.dart';
import 'package:getifyjobs/Src/utilits/Text_Style.dart';
import 'package:share_plus/share_plus.dart';

import 'Image_Path.dart';

//REFERAL CONTAINER
Widget ReferalCard(context,
    {required bool isRefferal,
    required String RefferEarn,
    required String refferalCode}) {
  return Container(
    width: MediaQuery.of(context).size.width,
    decoration:
        BoxDecoration(borderRadius: BorderRadius.circular(5), color: white1),
    child: Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Column(
        children: [
          isRefferal == true
              ? Container(
                  margin: EdgeInsets.only(top: 15),
                  alignment: Alignment.topLeft,
                  child: Text(
                    RefferEarn,
                    style: refferalE,
                  ))
              : Container(),
          //REFERRAL CODE
          Container(
            height: 40,
            margin: EdgeInsets.only(top: 15, bottom: 15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5), color: white2),
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    refferalCode,
                    style: pdfT,
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Text(
                      "Tap to copy",
                      style: attachT2,
                    ),
                  ),
                  InkWell(
                      onTap: () {
                        _copyTextToClipboard(refferalCode);
                        ShowToastMessage("Referal Code Copied");
                      },
                      child: ImgPathSvg('copy.svg')),
                ],
              ),
            ),
          ),

          //SHARE BUTTON
          Container(
            height: 40,
            margin: EdgeInsets.only(bottom: 15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5), color: grey6),
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Share.share("https://play.google.com/store/apps/details?id=com.getifyjobs.recuriter");
                    },
                    child: Text(
                      "Refer Now",
                      style: ButtonT,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

void _copyTextToClipboard(String text) {
  Clipboard.setData(ClipboardData(text: text));
}

//REFFERALCOUNT
Widget referralCount(context,
    {required String totalReferal, required String pending}) {
  return Container(
    margin: EdgeInsets.only(top: 15, bottom: 50),
    width: MediaQuery.of(context).size.width,
    decoration:
        BoxDecoration(borderRadius: BorderRadius.circular(5), color: white1),
    child: Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Total Referrals",
                style: refferalCountT,
              ),
              Text(
                totalReferal,
                style: dateT,
              ),
              Text(
                "Pending",
                style: refferalCountT,
              ),
              Text(
                pending,
                style: dateT,
              ),
            ],
          ),
          const Spacer(),
          ImgPathSvg("referralgroup.svg")
        ],
      ),
    ),
  );
}

//REFERAL CARD WEB

//REFERAL CONTAINER
Widget ReferalCardWeb(context,
    {required bool isRefferal,
    required String RefferEarn,
    required String refferalCode}) {
  return Container(
    width: MediaQuery.of(context).size.width / 4,
    child: Padding(
      padding: const EdgeInsets.only(right: 15),
      child: Column(
        children: [
          Container(
              alignment: Alignment.topLeft,
              child: Text(
                'Refer & Earn 12 Coins',
                style: appliesT,
              )),

          isRefferal == true
              ? Container(
                  margin: EdgeInsets.only(top: 15),
                  alignment: Alignment.topLeft,
                  child: Text(
                    RefferEarn,
                    style: refferalE,
                  ))
              : Container(),
          //REFERRAL CODE
          Container(
            height: 40,
            margin: EdgeInsets.only(top: 15, bottom: 15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5), color: white2),
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    refferalCode,
                    style: pdfT,
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Text(
                      "Tap to copy",
                      style: attachT2,
                    ),
                  ),
                  ImgPathSvg('copy.svg'),
                ],
              ),
            ),
          ),

          //SHARE BUTTON
          Container(
            height: 40,
            margin: EdgeInsets.only(bottom: 15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5), color: grey6),
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Refer Now",
                    style: ButtonT,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

//REFFERALCOUNT
Widget referralCountWeb(context,
    {required String totalReferal, required String pending}) {
  return Container(
    margin: EdgeInsets.only(bottom: 0),
    width: MediaQuery.of(context).size.width / 4,
    child: Padding(
      padding: const EdgeInsets.only(left: 0, right: 15, top: 0, bottom: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Total Referrals",
                style: refferalCountT,
              ),
              Text(
                totalReferal,
                style: dateT,
              ),
              Text(
                "Pending",
                style: refferalCountT,
              ),
              Text(
                pending,
                style: dateT,
              ),
            ],
          ),
          const Spacer(),
          Container(
              height: 120, width: 120, child: ImgPathSvg("referralgroup.svg"))
        ],
      ),
    ),
  );
}
