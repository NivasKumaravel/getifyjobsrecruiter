import 'package:flutter/material.dart';
import 'package:getifyjobs/Src/Common_Widgets/Common_Button.dart';
import 'package:getifyjobs/Src/Common_Widgets/Common_List.dart';
import 'package:getifyjobs/Src/Common_Widgets/Image_Path.dart';
import 'package:getifyjobs/Src/Common_Widgets/Text_Form_Field.dart';
import 'package:getifyjobs/Src/utilits/Common_Colors.dart';
import 'package:getifyjobs/Src/utilits/Text_Style.dart';
class Recruiter_Web_Dashboard_Joblist extends StatefulWidget {
  const Recruiter_Web_Dashboard_Joblist({super.key});

  @override
  State<Recruiter_Web_Dashboard_Joblist> createState() => _Recruiter_Web_Dashboard_JoblistState();
}

class _Recruiter_Web_Dashboard_JoblistState extends State<Recruiter_Web_Dashboard_Joblist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white2,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20,bottom: 20,left: 20,right: 20),
              child: Row(
                children: [
                  InkWell(
                      onTap:(){
                        Navigator.pop(context);
                      },
                      child: ImgPathSvg("arrowback.svg")),
                  SizedBox(width: 5,),
                  Text("Select a Job for Overview",style: pdfT,),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 15,left: 20,right: 20),
              child: textFormFieldSearchBar(hintText: "Search", keyboardtype: TextInputType.text),
            ),
            _jobsList(),
            Padding(
              padding: const EdgeInsets.only(bottom: 15,top: 50),
              child: Center(
                child: Container(
                    width: 300,
                    child: CommonElevatedButton(context, "Okay", () { })),
              ),
            )
          ],
        ),
      ),
    );
  }
  //DIRECT JOB LIST SCREEN
  Widget _jobsList(){
    return ListView.builder(
        itemCount: 10,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index){
          return InkWell(
            onTap:(){
              // Navigator.push(context, MaterialPageRoute(builder: (context)=>  Recruiter_Web_Campus_JobDetail_Page()));
            },
            child: NoOfCandidatesSection(
                context,
                jobName: "Augmented Reality (AR) Journey Builder‍",
                noOfCandidates: "3 Candidates",
                postedDate: "Posted: 23 Sep 2023", isWeb: true, status: ''),
          );
        });
  }
}
