import 'package:flutter/material.dart';
import 'package:getifyjobs/Src/Common_Widgets/Common_List.dart';
import 'package:getifyjobs/Src/Common_Widgets/Custom_App_Bar.dart';
import 'package:getifyjobs/Src/Recruiter_Web_Screens/Recruiter_Candidate_Profile_WebView_Popup.dart';
import 'package:getifyjobs/Src/utilits/Common_Colors.dart';
import 'package:getifyjobs/Src/utilits/Text_Style.dart';


class Recruiter_Web_Direct_List_Candidate extends StatefulWidget {
  @override
  _Recruiter_Web_Direct_List_CandidateState createState() =>
      _Recruiter_Web_Direct_List_CandidateState();
}

class _Recruiter_Web_Direct_List_CandidateState
    extends State<Recruiter_Web_Direct_List_Candidate>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
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
        actions: null,
        isLogoUsed: true,
        title: 'List of Candidates',
        isTitleUsed: true,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20,right: 20),
              child: NoOfCandidatesSection(
                  context,
                  jobName: "Flutter Developer",
                  noOfCandidates: "3 Candidates",
                  postedDate: "Posted: 23 Sep 2023", isWeb: true, status: ''
              ),
            ),
            SizedBox(height: 15,),
            Container(
              color: white1,
              width: MediaQuery.of(context).size.width,
              child: TabBar(
                controller: _tabController,
                labelColor: white1,
                labelStyle: TabT,
                indicator: BoxDecoration(color: blue1),
                indicatorColor: grey4,
                unselectedLabelColor: grey4,
                indicatorPadding: EdgeInsets.zero,
                indicatorSize: TabBarIndicatorSize.tab,
                tabs: [
                  Container(
                    child: Tab(
                      text: 'All',
                    ),
                  ),
                  Container(
                    child: Tab(
                      text: 'Shortlisted',
                    ),
                  ),
                  Container(
                    child: Tab(
                      text: 'Scheduled',
                    ),
                  ),
                  Container(
                    child: Tab(
                      text: 'Reject',
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: SingleChildScrollView(child: allList()),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: SingleChildScrollView(child: shortListedList()),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: SingleChildScrollView(child: scheduledList()),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: SingleChildScrollView(child: rejectedList()),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget allList() {
    return ListView.builder(
      itemCount: 10,
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
            onTap: (){
              showDialog(
                context: context,
                builder: (BuildContext context) => ProfilePopup(context),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 15, right: 20, left: 20),
              child: AppliesList(context,
                  CandidateImg: 'candidateImg.png',
                  CandidateName: 'Karthik Raja S',
                  Jobrole: 'Augmented Reality (AR) Journey Builder‍',
                  color: white1,
                  isWeb: true, isTagNeeded: null, isTagName: ''),
            ));
      },
    );
  }

  Widget shortListedList() {
    return ListView.builder(
      itemCount: 10,
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
            onTap: (){
              showDialog(
                context: context,
                builder: (BuildContext context) => ProfilePopup(context),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 15, right: 20, left: 20),
              child: AppliesList(context,
                  CandidateImg: 'candidateImg.png',
                  CandidateName: 'Karthik Raja S',
                  Jobrole: 'Augmented Reality (AR) Journey Builder‍',
                  color: white1,
                  isWeb: true, isTagNeeded: null, isTagName: ''),
            ));
      },
    );
  }

  Widget scheduledList() {
    return ListView.builder(
      itemCount: 10,
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
            onTap: (){
              showDialog(
                context: context,
                builder: (BuildContext context) => ProfilePopup(context),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 15, right: 20, left: 20),
              child: AppliesList(context,
                  CandidateImg: 'candidateImg.png',
                  CandidateName: 'Karthik Raja S',
                  Jobrole: 'Augmented Reality (AR) Journey Builder‍',
                  color: white1,
                  isWeb: true, isTagNeeded: null, isTagName: ''),
            ));
      },
    );
  }

  Widget rejectedList() {
    return ListView.builder(
      itemCount: 10,
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
            onTap: (){
              showDialog(
                context: context,
                builder: (BuildContext context) => ProfilePopup(context),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 15, right: 20, left: 20),
              child: AppliesList(context,
                  CandidateImg: 'candidateImg.png',
                  CandidateName: 'Karthik Raja S',
                  Jobrole: 'Augmented Reality (AR) Journey Builder‍',
                  color: white1,
                  isWeb: true, isTagNeeded: null, isTagName: ''),
            ));
      },
    );
  }
  Widget ProfilePopup(BuildContext context) {
    return AlertDialog(
      surfaceTintColor: white1,
      content:SingleChildScrollView(
        child: Container(
          width: 400,
          height: MediaQuery.of(context).size.height,
          child: Recruiter_Candidate_Profile_WebView_Popup(isPdfNeeded: true, isCampus: false, TagContain: '', isBottomNeeded: true, isAppbarNeeded: true,),
          // child: Recruiter_Candidate_Profile_View(),
        ),
      ),
    );
  }
}
