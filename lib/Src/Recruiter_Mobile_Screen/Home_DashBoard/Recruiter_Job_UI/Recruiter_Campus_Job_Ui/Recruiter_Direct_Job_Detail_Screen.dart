import 'package:flutter/material.dart';
import 'package:getifyjobs/Src/Common_Widgets/Common_JodDetails.dart';
import 'package:getifyjobs/Src/Common_Widgets/Common_List.dart';
import 'package:getifyjobs/Src/Common_Widgets/Custom_App_Bar.dart';
import 'package:getifyjobs/Src/Recruiter_Mobile_Screen/Home_DashBoard/Recruiter_Job_UI/Recruiter_Direct_Job_Ui/List_Of_Candidates_Page.dart';
import 'package:getifyjobs/Src/utilits/Common_Colors.dart';
import 'package:getifyjobs/Src/utilits/Text_Style.dart';
class Recruiter_Direct_Job_Detail_Screen extends StatefulWidget {
  const Recruiter_Direct_Job_Detail_Screen({super.key});

  @override
  State<Recruiter_Direct_Job_Detail_Screen> createState() => _Recruiter_Direct_Job_Detail_ScreenState();
}

class _Recruiter_Direct_Job_Detail_ScreenState extends State<Recruiter_Direct_Job_Detail_Screen>
    with SingleTickerProviderStateMixin{
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
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
        title: "",
        isUsed: true,
        actions: [],
        isLogoUsed: true,
        isTitleUsed: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Common_Direct_Job_Detail_Section(
              jobName: "Augmented Reality (AR) Journey Builder‍",
              companylogo: "companyLogo.png",
              companyName: "Innova new Technology",
              postedDate: " 23 Sep 2023",
              deadlineDate: " 23 Sep 2023",
              yearsOfExperince: "3-5 Years Experience",
              jobLocation: "Coimbatore, TamilNadu",
              salaryPackage: "₹ 3.5 - 5 LPA",
              jobDescription:
              "A user-experience (UX) designer basically understands the business requirements and technical limitations.They also design the overall functionality of the product, and in order to ensure a great user experience, iterate upon it in accord",
              skillSet: "Photoshop, Illustrator, Figma, Premier Pro",
              shiftDetails: "Day",
              statutoryBenifits: "Health Insurance",
              socialBenefits: "Health Insurance",
              otherBenifits: "Health Insurance",
              postedBy: "Isabella Anderson", isPostedBy: false,
              qualification: 'Any degree',
              specialization: 'IT',
              currentArrears: 'No',
              historyOfArrears: 'Not Disclosed',
              requriedPercentage: 'Above 60%',
              workType: 'Full Time',
            ),
            Padding(
              padding: const EdgeInsets.only(top:5,bottom: 15,left: 20,right: 20),
              child: Text("List of Candidates",style: pdfT,),
            ),
            Container(
              color: white1,
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: TabBar(
                controller: _tabController,
                labelColor: white1,
                labelStyle: TabT,
                indicator: BoxDecoration(
                    color: blue1
                ),
                indicatorColor: grey4,
                unselectedLabelColor: grey4,
                indicatorPadding: EdgeInsets.zero,
                isScrollable: true,
                indicatorSize: TabBarIndicatorSize.tab,
                tabs: [
                  Container(
                    width: MediaQuery.of(context).size.width / 4, // Equal width for each tab
                    child: Tab(
                      text: 'ROUND 1',
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 4, // Equal width for each tab
                    child: Tab(
                      text: 'ROUND 2',
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 4, // Equal width for each tab
                    child: Tab(
                      text: 'Shortlisted',
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 4, // Equal width for each tab
                    child: Tab(
                      text: 'Selected',
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 4, // Equal width for each tab
                    child: Tab(
                      text: 'Rejected',
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 300,
              // color: Colors.cyan,
              child: TabBarView(
                controller: _tabController,
                children: [
                  allList(),
                  allList(),
                  shortListedList(),
                  scheduledList(),
                  rejectedList(),              ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20,top: 15,bottom: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(onPressed: (){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => List_Of_Candidates_Page(job_Id: '', job_Name: '', posted_Date: '',)));
                  },
                      child: Text("View all",style: noOfCandidatesStyle,)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
Widget allList(){
  return ListView.builder(
    itemCount: 3,
    physics: const NeverScrollableScrollPhysics(),
    scrollDirection: Axis.vertical,
    shrinkWrap: true,
    itemBuilder: (BuildContext context, int index) {
      return InkWell(
          onTap: (){
            // Navigator.push(context, MaterialPageRoute(builder: (context)=>Job_Details()));
          },
          child: Padding(
            padding: const EdgeInsets.only(top:15,right: 20,left: 20),
            child: AppliesList(
                context,
                CandidateImg: "candidateImg.png",
                CandidateName: "Karthik Raja S",
                Jobrole: "Augmented Reality (AR) Journey Builder‍",
                color: white1, isWeb: false, isTagNeeded: null, isTagName: ''),
          ));
    },);
}
Widget shortListedList(){
  return ListView.builder(
    itemCount: 3,
    physics: const NeverScrollableScrollPhysics(),
    scrollDirection: Axis.vertical,
    shrinkWrap: true,
    itemBuilder: (BuildContext context, int index) {
      return InkWell(
          onTap: (){
            // Navigator.push(context, MaterialPageRoute(builder: (context)=>Job_Details()));
          },
          child: Padding(
            padding: const EdgeInsets.only(top:15,right: 20,left: 20),
            child: AppliesList(
                context,
                CandidateImg: "candidateImg.png",
                CandidateName: "Karthik Raja S",
                Jobrole: "Augmented Reality (AR) Journey Builder‍",
                color: white1, isWeb: false, isTagNeeded: null, isTagName: ''),
          ));
    },);
}
Widget scheduledList(){
  return ListView.builder(
    itemCount: 3,
    physics: const NeverScrollableScrollPhysics(),
    scrollDirection: Axis.vertical,
    shrinkWrap: true,
    itemBuilder: (BuildContext context, int index) {
      return InkWell(
          onTap: (){
            // Navigator.push(context, MaterialPageRoute(builder: (context)=>Job_Details()));
          },
          child: Padding(
            padding: const EdgeInsets.only(top:15,right: 20,left: 20),
            child: AppliesList(
                context,
                CandidateImg: "candidateImg.png",
                CandidateName: "Karthik Raja S",
                Jobrole: "Augmented Reality (AR) Journey Builder‍",
                color: white1, isWeb: false, isTagNeeded: null, isTagName: ''),
          ));
    },);
}
Widget rejectedList(){
  return ListView.builder(
    itemCount: 10,
    physics: const NeverScrollableScrollPhysics(),
    scrollDirection: Axis.vertical,
    shrinkWrap: true,
    itemBuilder: (BuildContext context, int index) {
      return InkWell(
          onTap: (){
            // Navigator.push(context, MaterialPageRoute(builder: (context)=>Job_Details()));
          },
          child: Padding(
            padding: const EdgeInsets.only(top:15,right: 20,left: 20),
            child: AppliesList(
                context,
                CandidateImg: "candidateImg.png",
                CandidateName: "Karthik Raja S",
                Jobrole: "Augmented Reality (AR) Journey Builder‍",
                color: white1, isWeb: false, isTagNeeded: null, isTagName: ''),
          ));
    },);
}