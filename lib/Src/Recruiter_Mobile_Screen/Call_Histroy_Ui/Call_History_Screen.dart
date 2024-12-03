import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:getifyjobs/Models/CallCompletedLogHistoryModel.dart';
import 'package:getifyjobs/Src/Common_Widgets/Custom_App_Bar.dart';
import 'package:getifyjobs/Src/Common_Widgets/Image_Path.dart';
import 'package:getifyjobs/Src/utilits/ApiService.dart';
import 'package:getifyjobs/Src/utilits/Common_Colors.dart';
import 'package:getifyjobs/Src/utilits/ConstantsApi.dart';
import 'package:getifyjobs/Src/utilits/Generic.dart';
import 'package:getifyjobs/Src/utilits/Text_Style.dart';

class Call_History_Screen extends ConsumerStatefulWidget {
  final int CallId;
  const Call_History_Screen({super.key,required this.CallId});

  @override
  ConsumerState<Call_History_Screen> createState() => _Call_History_ScreenState();
}

class _Call_History_ScreenState extends ConsumerState<Call_History_Screen> {
  CallCompletedLogHistoryData? CallResponseData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    RequestedCallCompletedResponse();
  }
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
          mainAxisAlignment:CallResponseData?.items == null?MainAxisAlignment.center: MainAxisAlignment.start,
          crossAxisAlignment:CallResponseData?.items == null?CrossAxisAlignment.center: CrossAxisAlignment.start,
          children: [
            CallResponseData?.items == null?
                NoDataMobileWidget(content: "No history log available"):
            Container(
              width: MediaQuery.sizeOf(context).width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: white1
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 10,right: 10,top: 20,bottom: 5),
                child:callList(CallResponseData)

              ),
            ),
          ],
        ),
      ),
    );
  }

  RequestedCallCompletedResponse() async{
    final callCompletedLogApiService = ApiService(ref.read(dioProvider));
    var formData = FormData.fromMap({
      'call_id':widget.CallId,
    });
    final requestCallResponse = await callCompletedLogApiService.post<CallCompletedLogHistoryModel>
      (context, ConstantApi.completedCallLogHistoryUrl, formData);
    if(requestCallResponse?.status == true){
      print("COMPLETED HISTORY LIST SUCESS");
      setState(() {
        CallResponseData = requestCallResponse?.data;
      });
      ShowToastMessage(requestCallResponse?.message ?? "");
    }else{
      print("COMPLETED HISTORY LIST ERROR");
      ShowToastMessage(requestCallResponse?.message ?? "");
    }
  }

}

Widget callList(CallCompletedLogHistoryData? callResponseData){
  return ListView.builder(
    itemCount: callResponseData?.items?.length ?? 0,
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
                Text(callResponseData?.items?[index].message ?? "",style: TBlack,),
              ],
            ),
            Container(
                width: MediaQuery.sizeOf(context).width/1.5,
                margin: EdgeInsets.only(left: 40,top: 5),
                child: Text("Requested Call On ${callResponseData?.items?[index].date ?? ""}",style: phoneHT1,maxLines: 2,)),
          ],
        ),
      );
    },);
}