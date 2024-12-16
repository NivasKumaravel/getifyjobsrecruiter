import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:getifyjobs/Models/AddCoinsModel.dart';
import 'package:getifyjobs/Models/AddWalletModel.dart';
import 'package:getifyjobs/Models/GetPaymentIdModel.dart';
import 'package:getifyjobs/Models/PaymentModel.dart';
import 'package:getifyjobs/Models/ProfileModel.dart';
import 'package:getifyjobs/Src/Common_Widgets/Custom_App_Bar.dart';
import 'package:getifyjobs/Src/Common_Widgets/Text_Form_Field.dart';
import 'package:getifyjobs/Src/utilits/ApiService.dart';
import 'package:getifyjobs/Src/utilits/Common_Colors.dart';
import 'package:getifyjobs/Src/utilits/ConstantsApi.dart';
import 'package:getifyjobs/Src/utilits/Generic.dart';
import 'package:getifyjobs/Src/utilits/Text_Style.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class Recharge_Screen extends ConsumerStatefulWidget {
  const  Recharge_Screen({super.key});

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
  GetPaymentData? getPaymentResponseData;
  ProfileData? profileDataResponse;


  TextEditingController _Amount = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AddWalletResponse();
      GetPaymentResponse();
      ProfileResponse();
    });
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
                    int amountInRupees = int.tryParse(_Amount.text) ?? 0;
                    int amountInPaisa = amountInRupees * 100;
                    Razorpay razorpay = Razorpay();
                    var options = {
                      'key':"${getPaymentResponseData?.keySecret ?? ''}",
                      'amount': amountInPaisa,
                      'name': "Getify Jobs",
                      'description': 'To schedule for interview and request for call need to add coins',
                      'retry': {'enabled': true, 'max_count': 1},
                      'send_sms_hash': true,
                      'prefill': {
                        'contact': "+91 ${profileDataResponse?.phone}",
                        'email': "${profileDataResponse?.email ?? ""}"
                      },
                      'external': {
                        'wallets': ['paytm']
                      }
                    };

                    print('PAYMENT REQUEST ${options}');
                    razorpay.on(
                        Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
                    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
                        handlePaymentSuccessResponse);
                    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET,
                        handleExternalWalletSelected);
                    razorpay.open(options);

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
      Navigator.pop(context,true);
    }else{
      print("ADD COINS ERROR");
      ShowToastMessage(addCoinsApiResponse?.message ?? "");
    }

 }

  GetPaymentResponse() async {
    final paymentApiService = ApiService(ref.read(dioProvider));
    var formData = FormData.fromMap({
      "key": '7O2ho2MrvgFODp3j18BMSBt1BJWETW1t',
    });
    final paymentApiResponse =
    await paymentApiService.post<GetPaymentIdModel>(
        context, ConstantApi.getPaymentUrl, formData);
    if (paymentApiResponse.status == true) {

      setState(() {
        getPaymentResponseData = paymentApiResponse?.data;
      });
      print('GET PAYMENT SUCCESS');
    } else {
      ShowToastMessage(paymentApiResponse.message ?? "");
      print('GET PAYMENT ERROR');
    }
  }

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

  PaymentSucessResponse({required String transactionId,required String Data}) async{
    final paymentResponse = ApiService(ref.read(dioProvider));
    var formData = FormData.fromMap({
      "recruiter_id": await getRecruiterId(),
      'amount':_Amount.text,
      "transaction_id":transactionId,
      "payment_data":Data,
    });
    final paymentApiResponse = await paymentResponse.post<PaymentModel>(context, ConstantApi.recruiterPaymentUrl, formData);
    if(paymentApiResponse?.status == true){
      print("PAYMENT DONE");
      AddCoinsResponse();
      ShowToastMessage(paymentApiResponse.message ?? "");
    }else{
      print("PAYMENT NOT DONE");
      ShowToastMessage(paymentApiResponse.message ?? "");
    }
  }

  void handlePaymentErrorResponse(PaymentFailureResponse response) {
    /*
    * PaymentFailureResponse contains three values:
    * 1. Error Code
    * 2. Error Description
    * 3. Metadata
    * */
    showAlertDialog(context, "Payment Failed",
        "Code: ${response.code}\nDescription: ${response.message}\nMetadata:${response.error.toString()}");
  }

  void handlePaymentSuccessResponse(PaymentSuccessResponse response) {
    /*
    * Payment Success Response contains three values:
    * 1. Order ID
    * 2. Payment ID
    * 3. Signature
    * */
    print("PAYMENT RESPONSE ::: ${response.data.toString()}");

    PaymentSucessResponse(transactionId: response?.paymentId ?? "", Data: response.data.toString(),);
    // showAlertDialog(
    //     context, "Payment Successful", "Payment ID: ${response.paymentId}");
  }

  void handleExternalWalletSelected(ExternalWalletResponse response) {
    showAlertDialog(
        context, "External Wallet Selected", "${response.walletName}");
  }

  void showAlertDialog(BuildContext context, String title, String message) {
    // set up the buttons

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
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