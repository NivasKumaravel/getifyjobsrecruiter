import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:getifyjobs/Models/AddCoinsModel.dart';
import 'package:getifyjobs/Models/AddWalletModel.dart';
import 'package:getifyjobs/Src/Common_Widgets/Custom_App_Bar.dart';
import 'package:getifyjobs/Src/Common_Widgets/Text_Form_Field.dart';
import 'package:getifyjobs/Src/utilits/ApiService.dart';
import 'package:getifyjobs/Src/utilits/Common_Colors.dart';
import 'package:getifyjobs/Src/utilits/ConstantsApi.dart';
import 'package:getifyjobs/Src/utilits/Generic.dart';
import 'package:getifyjobs/Src/utilits/Text_Style.dart';

class Recharge_Screen extends ConsumerStatefulWidget {
  const Recharge_Screen({super.key});

  @override
  ConsumerState<Recharge_Screen> createState() => _Recharge_ScreenState();
}

class _Recharge_ScreenState extends ConsumerState<Recharge_Screen> {
  final _formKey = GlobalKey<FormState>();
  int? selectedIndex;
  String? SelectedMessage;
  String? selectedAmount;
  String? selectedCoin;
  List<AddWalletData>? addWalletResponseData;


  TextEditingController _Amount = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AddWalletResponse();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white2,
      appBar: Custom_AppBar(
        isUsed: true,
        actions: null,
        isLogoUsed: true,title: 'Recharge Coins', isTitleUsed: true,),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Profile_Header(),
          ],
        ),
      ),
    );
  }
  //PROFILE HEADER
  Widget _Profile_Header(){
    return   //PROFILE HEADER
      Container(
        height: 400,
        child: Stack(
          children: [
            Container(
              height: 350,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(80),
                    bottomLeft: Radius.circular(80),
                  ),
                  color: white1
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 20,right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 15,),
                   Text('Total Payment',style: totalT,),
                    Container(
                      margin: EdgeInsets.only(top: 10,bottom: 25),
                      width: 110,
                      child: textFormField(
                        hintText: '₹ 00',
                        keyboardtype: TextInputType.phone,
                        inputFormatters: null,
                        Controller: _Amount,
                        validating: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please Enter Valid${'Amount'}";
                          }
                          if (value == null) {
                            return "Please Enter Valid${'Amount'}";
                          }
                          return null;
                        },
                        onChanged: null,
                      ),
                    ),
                    Container(
                      height: 50,
                        margin: EdgeInsets.only(left: 20,right: 20),
                        child: _Amount_List()),
                    const SizedBox(height: 15,),
                    selectedCoin == null?Container():  RichText(
                      text: TextSpan(
                          text: '',
                          style: Wbalck1,
                          children: <TextSpan>[
                            TextSpan(text: '${selectedCoin} Coins',
                              style: TextStyle(
                                  color: Color.fromRGBO(254, 168, 50, 1),fontFamily: 'Inter', fontSize: 24,fontWeight: FontWeight.w700),
                            ),
                            TextSpan(text: ' ${SelectedMessage}',
                              style: Wbalck1,
                            ),
                          ]
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 320,
              left: 80,
              right: 80,
              child: InkWell(
                onTap: (){
                  if(_formKey.currentState!.validate()){
                    AddCoinsResponse();
                  }
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: blue1
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 15,bottom: 15
                    ),
                    child: Center(child: Text("Pay Money",style: ButtonT,)),
                  ),
                ),
              ),

            )
          ],
        ),
      );
  }

  //AMOUNT LIST
 Widget _Amount_List(){
    return ListView.builder(
      itemCount: addWalletResponseData?.length ?? 0,
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.only(right: 15),
          child: InkWell(
            onTap: (){
             setState(() {

               if (index == selectedIndex)
                 {
                   selectedIndex = null;
                 }
               else
                 {
                   selectedIndex = index;
                 }

               SelectedMessage = addWalletResponseData?[index].message ?? "";
               selectedAmount = addWalletResponseData?[index].amount ?? "";
               selectedCoin = addWalletResponseData?[index].coin ?? "";
               _Amount.text = selectedAmount ?? "";
             });
            },
              child: Amount_Card(Amount: addWalletResponseData?[index].amount ?? "", color: selectedIndex == index?blue2:white2)),
        );
      },);
 }

 //ADD WALLET RESPONSE
AddWalletResponse() async{
    final addWalletApiService = ApiService(ref.read(dioProvider));
  final addWalletResponse = await addWalletApiService.get<AddWalletModel>(context, ConstantApi.addWalletUrl);
  if(addWalletResponse?.status == true){
    print("ADD WALLET LISTED SUCCESS");
    setState(() {
      addWalletResponseData = addWalletResponse?.data;
    });
  }else{
    print("ADD WALLET LISTED ERROR");
  }
  }

  //ADD COINS RESPONSE
 AddCoinsResponse() async{
    final addCoinsApiService = ApiService(ref.read(dioProvider));
    var formData = FormData.fromMap({
      "recruiter_id": await getRecruiterId(),
      "coins":selectedCoin,
      "amount":_Amount.text,
    });
    final addCoinsApiResponse = await addCoinsApiService.post<AddCoinsModel>(context, ConstantApi.addCoinsUrl, formData);
    if(addCoinsApiResponse?.status == true){
      print("ADD COINS SUCCESS");
      ShowToastMessage(addCoinsApiResponse?.message ?? "");
    }else{
      print("ADD COINS ERROR");
      ShowToastMessage(addCoinsApiResponse?.message ?? "");
    }

 }
}


//AMOUNT CARD
Widget Amount_Card({required String Amount,required Color? color}){
  return Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: color
    ),
    child: Padding(
      padding: const EdgeInsets.only(left: 15,right: 15,top: 5,bottom: 5),
      child: Center(child: Text('₹ ${Amount}',style: amountT,)),
    ),
  );
}