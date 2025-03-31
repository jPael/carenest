import 'package:flutter/material.dart';
import 'package:smartguide_app/components/prenatal_records/after_care/after_care.dart';
import 'package:smartguide_app/components/prenatal_records/birth_plan/birth_plan.dart';
import 'package:smartguide_app/components/prenatal_records/care_and_tests/care_and_tests.dart';
import 'package:smartguide_app/components/prenatal_records/counseling/counseling.dart';

class SettingsPrenatalRecordsPage extends StatefulWidget {
  const SettingsPrenatalRecordsPage({super.key});

  @override
  State<SettingsPrenatalRecordsPage> createState() => _SettingsPrenatalRecordsPageState();
}

class _SettingsPrenatalRecordsPageState extends State<SettingsPrenatalRecordsPage>
    with TickerProviderStateMixin {
  final List<String> tabs = ["Care and Tests", "Birth Plan", "After Care", "Counseling"];

  final List<Widget> tabViews = [CareAndTests(), BirthPlan(), AfterCare(), Counseling()];

  late final TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: tabs.length, vsync: this);
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
            tabs: tabs.map((t) => Text(t)).toList(),
            isScrollable: true,
          ),
        ),
        body: TabBarView(
          controller: tabController,
          physics: RangeMaintainingScrollPhysics(),
          children: tabViews,
        ));
  }
}
