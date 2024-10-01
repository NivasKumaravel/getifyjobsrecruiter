import 'package:flutter/material.dart';

import '../utilits/Common_Colors.dart';
import '../utilits/Text_Style.dart';
import 'Image_Path.dart';
import 'Text_Form_Field.dart';

  class Common_Direct_Job_Detail_Section extends StatefulWidget {
    final bool? isPostedBy;
    String? jobName;
    String? companylogo;
    String? companyName;
    String? postedDate;
    String? deadlineDate;
    String? yearsOfExperince;
    String? jobLocation;
    String? salaryPackage;
    String? jobDescription;
    String? skillSet;
    String? qualification;
    String? specialization;
    String? currentArrears;
    String? historyOfArrears;
    String? requriedPercentage;
    String? workType;
    String? shiftDetails;
    String? statutoryBenifits;
    String? socialBenefits;
    String? otherBenifits;
    String? postedBy;

    Common_Direct_Job_Detail_Section({super.key,
      required this.jobName,
      required this.companylogo,
      required this.companyName,
      required this.postedDate,
      required this.deadlineDate,
      required this.yearsOfExperince,
      required this.jobLocation,
      required this.salaryPackage,
      required this.jobDescription,
      required this.skillSet,
      required this.qualification,
      required this.specialization,
      required this.currentArrears,
      required this.historyOfArrears,
      required this.requriedPercentage,
      required this.workType,
      required this.shiftDetails,
      required this.statutoryBenifits,
      required this.socialBenefits,
      required this.otherBenifits,
      required this.postedBy,
      required this.isPostedBy,
    });

  @override
  State<Common_Direct_Job_Detail_Section> createState() => _Common_Direct_Job_Detail_SectionState();
}

class _Common_Direct_Job_Detail_SectionState extends State<Common_Direct_Job_Detail_Section> {
    bool? isPostedBy;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _Common_job_Deatil_Section()
      ],
    );
  }
  Widget _Common_job_Deatil_Section(){
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20,right: 20),
          child:
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //JOB TITLE
              Text(widget.jobName.toString(),style: TitleT,),
              //COMPANY LOGO AND NAME
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: buildCompanyInfoRow(
                    widget.companylogo.toString(),
                    widget.companyName.toString(),
                    TBlack,
                    50, 50, isMapLogo: false),
              ),
              //POSTED DATE
              Padding(
                padding: const EdgeInsets.only(top: 12,bottom: 8),
                child: Text("Posted on:"+ "${widget.postedDate.toString()}",style: posttxt,),
              ),
              //POSTED DATE
              Text("Deadline:"+"${widget.deadlineDate.toString()}",style: deadtxt,),
              SizedBox(height: 5,),
              //JOB DESCRIPTIONS
              _JobDescriptionContainer()
            ],
          ),
        ),
        SizedBox(height: 10,),
        //POSTED BY SECTION
      widget.isPostedBy==true? _PostedByContainer():Container()
      ],
    );

  }


  Widget _JobDescriptionContainer(){
    return Container(
      color: white1,
      child: Padding(
        padding: const EdgeInsets.only(left: 15,right: 15,top: 15,bottom: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _JobDescriptionSection1(),
            //JOB DESCRIPTION CONTENT
            Text("Job Description",style: TitleT,),
            Text(widget.jobDescription.toString(),style:desctxt ,),
            SizedBox(height: 20,),
            textWithheader(headertxt: "Skill Set", subtxt: widget.skillSet.toString()),
            textWithheader(headertxt: "Qualification", subtxt: widget.qualification.toString()),
            textWithheader(headertxt: "Specialization", subtxt: widget.specialization.toString()),
            textWithheader(headertxt: "Current Arrears", subtxt: widget.currentArrears.toString()),
            textWithheader(headertxt: "History of Arrears", subtxt: widget.historyOfArrears.toString()),
            textWithheader(headertxt: "Required Percentage/CGPA", subtxt: widget.requriedPercentage.toString()),
            textWithheader(headertxt: "Work Type", subtxt: widget.workType.toString()),
            textWithheader(headertxt: "Shift Details", subtxt: widget.shiftDetails.toString()),
            textWithheader(headertxt: "Statutory Benefits", subtxt:widget.statutoryBenifits.toString()),
            textWithheader(headertxt: "Social Benefits", subtxt:widget.socialBenefits.toString()),
            textWithheader(headertxt: "Other Benefits", subtxt: widget.otherBenifits.toString()),
          ],
        ),
      ),
    );
  }

  Widget _JobDescriptionSection1(){
    return Column(
      children: [
        SizedBox(height: 5,),
        _IconWithText(iconimg: "bag.svg", icontext: widget.yearsOfExperince.toString()),
        //LOCATION
        _IconWithText(iconimg: "map-pin.svg", icontext: widget.jobLocation.toString()),
        //SALARY
        _IconWithText(iconimg: "wallet.svg", icontext: widget.salaryPackage.toString())
      ],
    );
  }

  Widget _IconWithText({required String iconimg,required String icontext}){
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          ImgPathSvg(iconimg),
          SizedBox(width: 5,),
          Expanded(child: Text(icontext,style: posttxt))
        ],
      ),
    );
  }

  Widget _PostedByContainer(){
    return Container(
      height: 95,
      width: MediaQuery.of(context).size.width,
      color: white1,
      child: Padding(
        padding: const EdgeInsets.only(right: 20,left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20,),
            Text("Posted by",style: bluetxt,),
            Text(widget.postedBy.toString(),style: stxt,),
            SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }
}

class Common_Direct_BulkJob_Detail_Section extends StatefulWidget {
  final bool? isPostedBy;
  String? jobName;
  String? companylogo;
  String? companyName;
  String? postedDate;
  String? deadlineDate;
  String? yearsOfExperince;
  String? jobLocation;
  String? salaryPackage;
  String? jobDescription;
  String? skillSet;
  String? noOfRounds;
  String? noOfVacancies;
  String? workType;
  String? shiftDetails;
  String? specialization;
  String? qualification;
  String? historyOfArrears;
  String? currentArrears;
  String? requiredPercentage;
  String? statutoryBenifits;
  String? socialBenefits;
  String? otherBenifits;
  String? postedBy;

  Common_Direct_BulkJob_Detail_Section({super.key,
    required this.jobName,
    required this.companylogo,
    required this.companyName,
    required this.postedDate,
    required this.deadlineDate,
    required this.yearsOfExperince,
    required this.jobLocation,
    required this.salaryPackage,
    required this.jobDescription,
    required this.skillSet,
    required this.noOfRounds,
    required this.noOfVacancies,
    required this.workType,
    required this.shiftDetails,
    required this.specialization,
    required this.qualification,
    required this.historyOfArrears,
    required this.currentArrears,
    required this.requiredPercentage,
    required this.statutoryBenifits,
    required this.socialBenefits,
    required this.otherBenifits,
    required this.postedBy,
    required this.isPostedBy,

  });

  @override
  State<Common_Direct_BulkJob_Detail_Section> createState() => _Common_Direct_BulkJob_Detail_SectionState();
}

class _Common_Direct_BulkJob_Detail_SectionState extends State<Common_Direct_BulkJob_Detail_Section> {
  bool? isPostedBy;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _Common_job_Deatil_Section()
      ],
    );
  }
  Widget _Common_job_Deatil_Section(){
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20,right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //JOB TITLE
              Text(widget.jobName.toString(),style: TitleT,),
              //COMPANY LOGO AND NAME
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: buildCompanyInfoRow(
                    widget.companylogo.toString(),
                    widget.companyName.toString(),
                    TBlack,
                    50, 50, isMapLogo: false),
              ),
              //POSTED DATE
              Padding(
                padding: const EdgeInsets.only(top: 12,bottom: 8),
                child: Text("Posted on:"+ "${widget.postedDate.toString()}",style: posttxt,),
              ),
              //POSTED DATE
              Text("Deadline:"+"${widget.deadlineDate.toString()}",style: deadtxt,),
              SizedBox(height: 5,),
              //JOB DESCRIPTIONS
              _JobDescriptionContainer()
            ],
          ),
        ),
        SizedBox(height: 10,),
        //POSTED BY SECTION
        widget.isPostedBy==true? _PostedByContainer():Container()
      ],
    );

  }


  Widget _JobDescriptionContainer(){
    return Container(
      color: white1,
      child: Padding(
        padding: const EdgeInsets.only(left: 15,right: 15,top: 15,bottom: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _JobDescriptionSection1(),
            //JOB DESCRIPTION CONTENT
            Text("Job Description",style: TitleT,),
            Text(widget.jobDescription.toString(),style:desctxt ,),
            SizedBox(height: 20,),
            textWithheader(headertxt: "No Of Vacancies", subtxt: widget.noOfVacancies.toString()),
            textWithheader(headertxt: "Qualification", subtxt: widget.qualification.toString()),
            textWithheader(headertxt: "Specialization", subtxt: widget.specialization.toString()),
            textWithheader(headertxt: "Current Arrears", subtxt: widget.currentArrears.toString()),
            textWithheader(headertxt: "History of Arrears", subtxt: widget.historyOfArrears.toString()),
            textWithheader(headertxt: "Required Percentage/CGPA", subtxt: widget.requiredPercentage.toString()),
            textWithheader(headertxt: "No Of Rounds", subtxt: widget.noOfRounds.toString()),
            textWithheader(headertxt: "Statutory Benefits", subtxt:widget.statutoryBenifits.toString()),
            textWithheader(headertxt: "Social Benefits", subtxt:widget.socialBenefits.toString()),
            textWithheader(headertxt: "Other Benefits", subtxt: widget.otherBenifits.toString()),
          ],
        ),
      ),
    );
  }

  Widget _JobDescriptionSection1(){
    return Column(
      children: [
        SizedBox(height: 5,),
        _IconWithText(iconimg: "bag.svg", icontext: widget.yearsOfExperince.toString()),
        //LOCATION
        _IconWithText(iconimg: "map-pin.svg", icontext: widget.jobLocation.toString()),
        //SALARY
        _IconWithText(iconimg: "wallet.svg", icontext: widget.salaryPackage.toString())
      ],
    );
  }

  Widget _IconWithText({required String iconimg,required String icontext}){
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          ImgPathSvg(iconimg),
          SizedBox(width: 5,),
          Expanded(child: Text(icontext,style: posttxt))
        ],
      ),
    );
  }

  Widget _PostedByContainer(){
    return Container(
      height: 95,
      width: MediaQuery.of(context).size.width,
      color: white1,
      child: Padding(
        padding: const EdgeInsets.only(right: 20,left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20,),
            Text("Posted by",style: bluetxt,),
            Text(widget.postedBy.toString(),style: stxt,),
            SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }
}



