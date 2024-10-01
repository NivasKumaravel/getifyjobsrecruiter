
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../utilits/Common_Colors.dart';
import 'Custom_App_Bar.dart';

class QRCodeScannerApp extends StatefulWidget {
  @override
  _QRCodeScannerAppState createState() => _QRCodeScannerAppState();
}

class _QRCodeScannerAppState extends State<QRCodeScannerApp> {
  final GlobalKey _qrKey = GlobalKey();
  QRViewController? _controller;
  bool _showScanner = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white2,
      appBar: Custom_AppBar(
        isUsed: false,
        actions: null,
        isLogoUsed: true,
        isTitleUsed: false,
        title: 'QR Code Scanner',
      ),
      body: Center(
        child: _showScanner ? _buildScannerView() : _buildSuccessView(),
      ),
    );
  }

  Widget _buildScannerView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.6,
            height: MediaQuery.of(context).size.height * 0.3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
            ),
            child: QRView(
              key: _qrKey,
              onQRViewCreated: _onQRViewCreated,
              overlay: QrScannerOverlayShape(
                borderColor: blue1, // Customize the overlay color
                borderRadius: 10, // Customize the border radius
                borderLength: 20, // Customize the border length
                borderWidth: 5, // Customize the border width
                cutOutSize: 200,
              ),
            ),
          ),
        ),
        SizedBox(height: 20),
        Text(
          'Scan the QR Code',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  Widget _buildSuccessView() {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: Text(
              'Scan Successful!',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 20),
          // Text(
          //   'Scanned Data:',
          //   style: TextStyle(fontSize: 16),
          // ),
          // SizedBox(height: 10),
          // Text(
          //   '$_controller',
          //   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          // ),


        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      _controller = controller;
    });

    controller.scannedDataStream.listen((scanData) {
      // Handle the scanned data here (scanData).
      setState(() {
        _showScanner = false;
      });
    });
  }



  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}