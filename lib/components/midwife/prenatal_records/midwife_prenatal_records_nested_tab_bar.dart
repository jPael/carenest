import 'package:flutter/material.dart';
import 'package:smartguide_app/components/midwife/prenatal_records/tabs/midwife_prenatal_records_birth_plan_tab.dart';
import 'package:smartguide_app/components/midwife/prenatal_records/tabs/midwife_prenatal_records_counseling_topic_tab.dart';
import 'package:smartguide_app/components/midwife/prenatal_records/tabs/midwife_prenatal_records_exam_findings_tab.dart';
import 'package:smartguide_app/components/midwife/prenatal_records/tabs/midwife_prenatal_records_health_center_visits_tab.dart';
import 'package:smartguide_app/components/midwife/prenatal_records/tabs/midwife_prenatal_records_immunization_supplement_tab.dart';
import 'package:smartguide_app/components/midwife/prenatal_records/tabs/midwife_prenatal_records_medical_personnel_tab.dart';
import 'package:smartguide_app/components/midwife/prenatal_records/tabs/midwife_prenatal_records_prenatal_care_tab.dart';

class MidwifePrenatalRecrodsNestedTabBar extends StatefulWidget {
  const MidwifePrenatalRecrodsNestedTabBar({super.key, required this.user, required this.trimester});

  final String user;
  final String trimester;

  @override
  State<MidwifePrenatalRecrodsNestedTabBar> createState() => _MidwifePrenatalRecrodsNestedTabBarState();
}

class _MidwifePrenatalRecrodsNestedTabBarState extends State<MidwifePrenatalRecrodsNestedTabBar> with TickerProviderStateMixin {
  final tabs = [
    "Pre-natal Care",
    "Health Center Visits",
    "Examination Findings",
    "Birth Plan",
    "Immunization & Supplements",
    "Counseling Topics",
    "Medical Personnel",
  ];

  late final List<Widget> tabViews;

  late final TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: tabs.length, vsync: this);

    tabViews = [
      MidwifePrenatalRecordsPrenatalCareTab(
        trimester: widget.trimester,
      ),
      MidwifePrenatalRecordsHealthCenterVisitsTab(),
      MidwifePrenatalRecordsExamFindingsTab(),
      MidwifePrenatalRecordsBirthPlanTab(),
      MidwifePrenatalRecordsImmunizationSupplementTab(),
      MidwifePrenatalRecordsCounselingTopicTab(),
      MidwifePrenatalRecordsMedicalPersonnelTab()
    ];
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: TabBar(tabAlignment: TabAlignment.start, isScrollable: true, tabs: tabs.map((e) => Text(e)).toList(), controller: tabController),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2 * 8.0),
        child: TabBarView(controller: tabController, children: tabViews),
      ),
    );
  }
}
