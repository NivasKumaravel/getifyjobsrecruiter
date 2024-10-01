import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:getifyjobs/Src/utilits/Text_Style.dart';

import 'Image_Widget.dart';

// PNG IMAGE PATH
Widget ImgPathPng(String pathPNG){
  return  Image(image: AssetImage("lib/assets/${pathPNG}"));
}


// SVG IMAGE PATH

Widget ImgPathSvg(String pathSVG){
  return  SvgPicture.asset("lib/assets/${pathSVG}");
}

// Logo Image
 Widget LoginScreenImage(context){
  return Container(
    height: MediaQuery.sizeOf(context).height/4,
    width: MediaQuery.sizeOf(context).width/1.2,
      child: ImgPathSvg("LoginscreenImg.svg"));
 }
Widget Logo(context){
  return Container(
    height: MediaQuery.sizeOf(context).height/5,
      width: MediaQuery.sizeOf(context).width/1.2,
      child: ImgPathSvg("logo.svg"));
}


//CANDIDATE IMAGE

Widget Candidate_Img({required String ImgPath}){
  return  Container(
    height: 50,
    width: 50,
   child: buildImage(
       ImgPath,
       border: const Radius.circular(25),
       fit: BoxFit.cover),
  );
}

// PROFILE IMG
Widget profileImg({required String ProfileImg}){
  return Center(
    child: Container(
      margin: EdgeInsets.only(top: 20,bottom: 11),
      height: 100,
      width: 100,
      child:buildImage(
          ProfileImg,
          border: const Radius.circular(50),
          fit: BoxFit.cover),
    ),
  );
}

//NO DATA WIDGET
Widget NoDataWidget({required String content}){
  return Container(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(child: ImgPathSvg('nodataimage.svg')),
        Center(child: Text(content,style: TitleT,))
      ],
    ),
  );
}

//NO DATA MOBILE
Widget NoDataMobileWidget({required String content}){
  return Container(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
       Container(
         height: 150,
           width: 150,
           child: ImgPathSvg('nodataimage.svg')),
        Center(child: Text(content,style: TitleT1,))
      ],
    ),
  );
}