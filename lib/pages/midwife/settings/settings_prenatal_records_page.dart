import 'package:flutter/material.dart';
import 'package:smartguide_app/components/settings/settings_prenatal_records/settings_prenatal_records_Immunization_supplements_tab_view.dart';
import 'package:smartguide_app/components/settings/settings_prenatal_records/settings_prenatal_records_birth_plan_tab_view.dart';
import 'package:smartguide_app/components/settings/settings_prenatal_records/settings_prenatal_records_counseling_topics_tab_view.dart';
import 'package:smartguide_app/components/settings/settings_prenatal_records/settings_prenatal_records_examination_findings_tab_view.dart';
import 'package:smartguide_app/components/settings/settings_prenatal_records/settings_prenatal_records_health_center_visits_tab_view.dart';
import 'package:smartguide_app/components/settings/settings_prenatal_records/settings_prenatal_records_medical_personnel_tab_view.dart';
import 'package:smartguide_app/components/settings/settings_prenatal_records/settings_prenatal_records_personal_information_tab_view.dart';
import 'package:smartguide_app/components/settings/settings_prenatal_records/settings_prenatal_records_prenatal_care_tab_view.dart';

class SettingsPrenatalRecordsPage extends StatefulWidget {
  const SettingsPrenatalRecordsPage({super.key});

  @override
  State<SettingsPrenatalRecordsPage> createState() => _SettingsPrenatalRecordsPageState();
}

class _SettingsPrenatalRecordsPageState extends State<SettingsPrenatalRecordsPage>
    with TickerProviderStateMixin {
  final tabs = [
    Text("Personal information"),
    Text("Pre-natal Care"),
    Text("Health Center Visits"),
    Text("Examination Findings"),
    Text("Birth Plan"),
    Text("Immunization & Supplements"),
    Text("Counseling Topics"),
    Text("Medical Personnel"),
  ];

  final tabViews = [
    SettingsPrenatalRecordsPersonalInformationTabView(),
    SettingsPrenatalRecordsPrenatalCareTabView(),
    SettingsPrenatalRecordsHealthCenterVisitsTabView(),
    SettingsPrenatalRecordsExaminationFindingsTabView(),
    SettingsPrenatalRecordsBirthPlanTabView(),
    SettingsPrenatalRecordsImmunizationSupplementsTabView(),
    SettingsPrenatalRecordsCounselingTopicsTabView(),
    SettingsPrenatalRecordsMedicalPersonnelTabView(),
  ];

  late final TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: tabs.length, vsync: this, initialIndex: 2);
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
          title: Text("Prenatal Record"),
          centerTitle: true,
          bottom: TabBar(
            labelPadding: const EdgeInsets.all(8),
            labelStyle: TextStyle(fontSize: 8 * 2),
            controller: tabController,
            tabs: tabs,
            isScrollable: true,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8 * 3),
          child: TabBarView(controller: tabController, children: tabViews),
        ));
  }
}
