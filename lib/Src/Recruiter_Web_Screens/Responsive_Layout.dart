import 'package:flutter/material.dart';

class Responsive_Layout extends StatelessWidget {
  final Widget mobileBody;
  final Widget webBody;
   Responsive_Layout({super.key,required this.mobileBody,required this.webBody});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if(constraints.maxWidth<600){
          return mobileBody;
        }else{
          return webBody;
        }
      },);
  }
}
