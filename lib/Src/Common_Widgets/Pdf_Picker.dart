import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:getifyjobs/Src/Common_Widgets/Image_Path.dart';

import 'package:open_file/open_file.dart';

import '../utilits/Common_Colors.dart';
import '../utilits/Generic.dart';
import '../utilits/Text_Style.dart'; // Import open_file package



class PdfPickerExample extends StatefulWidget {
  String? optionalTXT ;
  PdfPickerExample({Key? key,required this.optionalTXT});

  @override
  _PdfPickerExampleState createState() => _PdfPickerExampleState();
}

class _PdfPickerExampleState extends State<PdfPickerExample> {
  File? _selectedFile;
  String? _fileName;

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'], // Limit to PDF files
    );

    if (result != null) {
      setState(() {
        _selectedFile = File(result.files.single.path!);
        _fileName = result.files.single.name;
        SingleTon singleton = SingleTon();
        singleton.setPdf = _selectedFile;

      });
    }
  }

  void _cancelSelection() {
    setState(() {
      _selectedFile = null;
      _fileName = null;
    });
  }

  void _viewPdfExternally() {
    if (_selectedFile != null) {
      OpenFile.open(_selectedFile!.path); // Open the PDF externally
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: _pickFile,
          child: Center(
            child: _selectedFile == null
                ? Attachment(optionalText: widget.optionalTXT.toString())
                : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: _viewPdfExternally,
                  child: Container(
                    height: 75,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: white1
                    ),
                    child: Row(
                      children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10,right: 15),
                        child: ImgPathSvg("pdf.svg"),
                      ),
                        Container(
                          width: MediaQuery.of(context).size.width/2,
                            child: Text("${_fileName}",style: pdfT,overflow: TextOverflow.ellipsis,maxLines: 2,)),
                        Spacer(),
                        InkWell(
                          onTap: _cancelSelection,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: Icon(Icons.cancel_outlined,color: grey1,),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget Attachment({required String optionalText}){
    return Padding(
      padding: const EdgeInsets.only(top: 25,bottom: 30),
      child: DottedBorder(
          color: grey5,
          borderType: BorderType.RRect,
          radius: Radius.circular(10),
          child: Container(
            height: 55,
            child: Center(child: AttachPdf(optional: optionalText)),
          )),
    );
  }
}

//PDF VIEW

class pdfViewer extends StatefulWidget {
  String? optionalTXT ;
  pdfViewer({Key? key,required this.optionalTXT});

  @override
  _pdfViewerState createState() => _pdfViewerState();
}

class _pdfViewerState extends State<pdfViewer> {
  File? _selectedFile;
  String? _fileName;

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'], // Limit to PDF files
    );

    if (result != null) {
      setState(() {
        _selectedFile = File(result.files.single.path!);
        _fileName = result.files.single.name;
      });
    }
  }

  void _cancelSelection() {
    setState(() {
      _selectedFile = null;
      _fileName = null;
    });
  }

  void _viewPdfExternally() {
    if (_selectedFile != null) {
      OpenFile.open(_selectedFile!.path); // Open the PDF externally
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: _pickFile,
          child: Center(
            child:  Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: _viewPdfExternally,
                  child: Container(
                    height: 75,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: white1
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10,right: 15),
                          child: ImgPathSvg("pdf.svg"),
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width/2,
                            child: Text("${_fileName}",style: pdfT,overflow: TextOverflow.ellipsis,maxLines: 2,)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}