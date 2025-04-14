import 'package:flutter/material.dart';
import 'package:smartguide_app/components/button/custom_button.dart';
import 'package:smartguide_app/components/prenatal_records/after_care/after_care.dart';
import 'package:smartguide_app/components/prenatal_records/birth_plan/birth_plan.dart';
import 'package:smartguide_app/components/prenatal_records/care_and_tests/care_and_tests.dart';
import 'package:smartguide_app/components/prenatal_records/counseling/counseling.dart';
import 'package:smartguide_app/pages/midwife/prenatal_records/patients_info_page.dart';

class PrenatalRecordPage extends StatefulWidget {
  const PrenatalRecordPage({super.key, required this.user});

  final String user;

  @override
  State<PrenatalRecordPage> createState() => _PrenatalRecordPageState();
}

class _PrenatalRecordPageState extends State<PrenatalRecordPage> with TickerProviderStateMixin {
  final List<String> tabs = ["Care and Tests", "Birth Plan", "After Care", "Counseling"];

  final List<Widget> tabViews = [const CareAndTests(), const BirthPlan(), const AfterCare(), const Counseling()];

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
          actionsPadding: const EdgeInsets.only(right: 8 * 2),
          actions: [
            CustomButton(
                radius: 5,
                verticalPadding: 1,
                horizontalPadding: 2,
                onPress: () => Navigator.push(
                    context, MaterialPageRoute(builder: (context) => PatientsInfoPage())),
                label: "Patient's info")
          ],
          title: const Text("Prenatal Record"),
          bottom: TabBar(
              controller: tabController,
              isScrollable: true,
              tabs: tabs
                  .map((e) => Tab(
                        text: e,
                      ))
                  .toList()),
        ),
        body: TabBarView(
          controller: tabController,
          children: tabViews,
        ));
  }
}
