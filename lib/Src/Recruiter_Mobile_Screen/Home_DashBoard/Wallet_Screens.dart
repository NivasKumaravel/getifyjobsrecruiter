import 'package:dio/dio.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:getifyjobs/Models/InvoiceModel.dart';
import 'package:getifyjobs/Models/InvoiceRequestModel.dart';
import 'package:getifyjobs/Models/WalletHistoryModel.dart';
import 'package:getifyjobs/Src/Common_Widgets/Common_Button.dart';
import 'package:getifyjobs/Src/Common_Widgets/Custom_App_Bar.dart';
import 'package:getifyjobs/Src/Common_Widgets/Image_Path.dart';
import 'package:getifyjobs/Src/Recruiter_Mobile_Screen/Recharge_Ui/Recharge_Screen.dart';
import 'package:getifyjobs/Src/utilits/ApiService.dart';
import 'package:getifyjobs/Src/utilits/Common_Colors.dart';
import 'package:getifyjobs/Src/utilits/ConstantsApi.dart';
import 'package:getifyjobs/Src/utilits/Generic.dart';
import 'package:getifyjobs/Src/utilits/Text_Style.dart';

class Wallet_Coin_Screen extends ConsumerStatefulWidget {
  @override
  _Wallet_Coin_ScreenState createState() => _Wallet_Coin_ScreenState();
}

class _Wallet_Coin_ScreenState extends ConsumerState<Wallet_Coin_Screen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  WalletHistoryData? walletResponseData;
  InvoiceData? invoiceResponsedata;
  bool? isHistory;
  bool? isInvoice;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    WalletHistoryResponse();
    isHistory = true;
    isInvoice = true;
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
      appBar: Custom_AppBar(
        isUsed: true,
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return alertDialogBox(context, onPress: () {
                      Navigator.pop(context);
                    });
                  },
                );
              },
              icon: Icon(
                Icons.more_vert_outlined,
                size: 24,
              ))
        ],
        isLogoUsed: true,
        title: 'Coins',
        isTitleUsed: true,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            addCoin(context, CoinBalnce: walletResponseData?.coins ?? ""),
            applyContain(),
            Container(
              color: white1,
              width: MediaQuery.of(context).size.width,
              child: TabBar(
                controller: _tabController,
                labelColor: white1,
                labelStyle: TabT,
                indicator: BoxDecoration(color: blue1),
                indicatorColor: Colors.black,
                unselectedLabelColor: Colors.black,
                indicatorPadding: EdgeInsets.zero,
                indicatorSize: TabBarIndicatorSize.tab,
                onTap: (index)async{
                  if(index == 0){
                    WalletHistoryResponse();
                  }else{
                    InvoiceResponse();
                  }
                },
                tabs: [
                  Container(
                    width: MediaQuery.of(context).size.width /
                        2, // Equal width for each tab
                    child: Tab(
                      text: 'History',
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width /
                        2, // Equal width for each tab
                    child: Tab(
                      text: 'Invoice',
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(

                controller: _tabController,
                children: [
                  //HISTORY
                  isHistory == true
                      ? SingleChildScrollView(
                          child: Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 50),
                          child: HistoryList(walletResponseData),
                        ))
                      : Center(
                          child: NoDataMobileWidget(content: 'Unlock New Possibilities')),

                  //INVOICE
                  isInvoice == true
                      ? SingleChildScrollView(
                          child: Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 50),
                          child: InvoiceList(invoiceResponsedata),
                        ))
                      : Center(
                          child: NoDataMobileWidget(content: 'Unlock New Possibilities')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  // ADDING COIN
  Widget addCoin(context, {required String CoinBalnce}) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      child: Row(
        children: [
          Container(
            height: 75,
            width: MediaQuery.of(context).size.width / 1.7,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5), color: white1),
            child: Center(
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10, left: 15),
                    child: ImgPathSvg("coin.svg"),
                  ),
                  Text(
                    '${CoinBalnce} Coins',
                    style: walletT,
                  ),
                ],
              ),
            ),
          ),
          Spacer(),
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Recharge_Screen())).
              then((value){
                print("VALUE ${value}");
                if(value == true){
                  WalletHistoryResponse();
                }
              });
            },
            child: Container(
                margin: EdgeInsets.only(left: 20),
                height: 75,
                width: 75,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5), color: white1),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add,
                      size: 24,
                      color: blue1,
                    ),
                    Text(
                      'Add',
                      style: walletT,
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }

  //WALLET SCREEN RESPONSE
  WalletHistoryResponse() async {
    final walletHistoryApiService = ApiService(ref.read(dioProvider));
    var formData = FormData.fromMap({
      "recruiter_id": await getRecruiterId(),
    });
    final walletResponse =
        await walletHistoryApiService.post<WalletHistoryModel>(
            context, ConstantApi.walletHistoryUrl, formData);
    if (walletResponse?.status == true) {
      print("WALLET SUCESS");
      ShowToastMessage(walletResponse?.message ?? "");
      setState(() {
        walletResponseData = walletResponse?.data;
        isHistory = true;
      });
    } else {
      print("WALLET ERROR");
      setState(() {
        isHistory = false;
      });
      ShowToastMessage(walletResponse?.message ?? "");
    }
  }

  //INVOICE SCREEN RESPONSE
  InvoiceResponse() async {
    final invoiceHistoryApiServie = ApiService(ref.read(dioProvider));
    var formData = FormData.fromMap({
      "recruiter_id": await getRecruiterId(),
    });
    final invoiceResponse =
    await invoiceHistoryApiServie.post<InvoiceModel>(
        context, ConstantApi.invoiceUrl, formData);
    if (invoiceResponse?.status == true) {
      print("INVOICE  SUCCESS");
      ShowToastMessage(invoiceResponse?.message ?? "");
      setState(() {
        invoiceResponsedata = invoiceResponse?.data;
        isInvoice = true;
      });
    } else {
      print("INVOICE ERROR");
      setState(() {
        isInvoice = false;
      });
      ShowToastMessage(invoiceResponse?.message ?? "");
    }
  }

  InvoiceRequestResponse({required String invoiceId}) async {
    final invoicRequestApiServie = ApiService(ref.read(dioProvider));
    var formData = FormData.fromMap({
      "invoice_id": invoiceId,
    });
    final invoiceResponse =
    await invoicRequestApiServie.post<InvoiceRequestModel>(
        context, ConstantApi.invoiceUrl, formData);
    if (invoiceResponse?.status == true) {
      print("INVOICE REQUEST SUCCESS");
      ShowToastMessage(invoiceResponse?.message ?? "");
    } else {
      print("INVOICE REQUEST ERROR");
      ShowToastMessage(invoiceResponse?.message ?? "");
    }
  }
  //INVOICE LIST
  Widget InvoiceList(InvoiceData? invoiceResponsedata) {

    return ListView.builder(
      itemCount: invoiceResponsedata?.invoice?.length ?? 0,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5), color: white1),
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15,top: 10,bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: MediaQuery.sizeOf(context).width/1.5,
                        child: Text(
                          '${invoiceResponsedata?.invoice?[index].transactionId ?? ""}',
                          style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                          maxLines: 3,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        "+${invoiceResponsedata?.invoice?[index].amount ?? ""}",
                        style: debitedT,
                      )

                    ],
                  ),
                  const SizedBox(height: 5,),
                  Text(invoiceResponsedata?.invoice?[index].createdAt ?? "",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),
                  const SizedBox(height: 5,),
                  CommonElevatedButton_No_Elevation(context, "Get Invoice", () {
                    InvoiceRequestResponse(invoiceId: invoiceResponsedata?.invoice?[index].id ?? "");
                    showDialog(
                      context: context,
                      builder: (context) {
                        return alertDialogBoxGetInvoice(context);
                      },
                    );
                  }, blue1, ButtonT1),

                ],
              ),
            ),
          ),
        );
      },
    );
  }
}



//APPLY CONTAIN
Widget applyContain() {
  return Padding(
    padding: const EdgeInsets.only(left: 20, right: 30, top: 20, bottom: 20),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        DottedBorder(
            borderType: BorderType.RRect,
            radius: Radius.circular(5),
            dashPattern: [5, 5],
            strokeWidth: 2,
            child: Container(
              height: 45,
              child: Padding(
                padding: const EdgeInsets.only(left: 10,right: 10),
                child: Center(
                    child: Text(
                  'QR32JND2099',
                  style: walletT,
                )),
              ),
            )),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            "Apply",
            style: walletT,
          ),
        )
      ],
    ),
  );
}

//ALERT DIALOG BOX
Widget alertDialogBox(context, {void Function()? onPress}) {
  return AlertDialog(
    surfaceTintColor: white1,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10))),
    titlePadding: EdgeInsets.all(0),
    title: Container(
        alignment: Alignment.topRight,
        child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: ImgPathSvg("xcancel.svg"))),
    contentPadding: EdgeInsets.only(right: 20, left: 20, bottom: 0),
    content: Container(
      height: 150,
      width: 350,
      child: Column(
        children: [
          Text(
            "Click to download the ",
            style: walletT,
          ),
          Text(
            "Spending history",
            style: profileTitle,
          ),
          const SizedBox(
            height: 15,
          ),
          CommonElevatedButton(context, "Download", onPress)
        ],
      ),
    ),
  );
}

Widget alertDialogBoxGetInvoice(context) {
  return AlertDialog(
    surfaceTintColor: white1,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10))),
    titlePadding: EdgeInsets.all(0),
    title: Container(
        alignment: Alignment.topRight,
        child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: ImgPathSvg("xcancel.svg"))),
    contentPadding: EdgeInsets.only(right: 20, left: 20, bottom: 0),
    content: Container(
      height: 150,
      width: 350,
      child: Column(
        children: [
          ImgPathSvg("gmail.svg"),
          Text(
            "You will Get Invoice through your Mail",
            style: walletT,
            textAlign: TextAlign.center,
          )
        ],
      ),
    ),
  );
}

//HISTORY LIST
Widget HistoryList(WalletHistoryData? walletResponseData) {
  return ListView.builder(
    itemCount: walletResponseData?.history?.length ?? 0,
    physics: const NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    scrollDirection: Axis.vertical,
    itemBuilder: (BuildContext context, int index) {
      return Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5), color: white1),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20,top: 10,bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: MediaQuery.sizeOf(context).width/1.5,
                        child: Text(
                          walletResponseData?.history?[index].message ?? "",
                          style: walletContent,
                          maxLines: 3,
                        ),
                      ),
                      const Spacer(),
                      walletResponseData?.history?[index].transactionType ==
                              "credit"
                          ? Text(
                              "+${walletResponseData?.history?[index].coins ?? ""}",
                              style: debitedT,
                            )
                          : Text(
                              "-${walletResponseData?.history?[index].coins ?? ""}",
                              style: debitedRT,
                            ),
                    ],
                  ),
                  const SizedBox(height: 5,),
                  Text(walletResponseData?.history?[index].createdAt ?? "",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}


