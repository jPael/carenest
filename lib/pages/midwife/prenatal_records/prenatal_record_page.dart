import 'package:flutter/material.dart';
import 'package:smartguide_app/components/button/custom_button.dart';
import 'package:smartguide_app/components/prenatal_records/after_care/after_care.dart';
import 'package:smartguide_app/components/prenatal_records/birth_plan/birth_plan.dart';
import 'package:smartguide_app/components/prenatal_records/care_and_tests/care_and_tests.dart';
import 'package:smartguide_app/components/prenatal_records/counseling/counseling.dart';
import 'package:smartguide_app/models/after_care.dart' as af_model;
import 'package:smartguide_app/models/prenatal.dart';
import 'package:smartguide_app/models/trimester.dart';
import 'package:smartguide_app/pages/midwife/prenatal_records/patients_info_page.dart';

class PrenatalRecordPage extends StatefulWidget {
  const PrenatalRecordPage({super.key, required this.prenatal});

  final Prenatal prenatal;
  @override
  State<PrenatalRecordPage> createState() => _PrenatalRecordPageState();
}

class _PrenatalRecordPageState extends State<PrenatalRecordPage> with TickerProviderStateMixin {
  final List<String> tabs = ["Care and Tests", "Birth Plan", "After Care", "Counseling"];

  late final List<Widget> tabViews;

  late final TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: tabs.length, vsync: this);

    tabViews = [
      CareAndTests(
        trimesters: [
          Trimester(
              whtPersonnel: widget.prenatal.patientInformation.accompaniedBy!.name!,
              trimester: widget.prenatal.selectedTrimester,
              dateOfVisit: widget.prenatal.createdAt!,
              consultWht: widget.prenatal.consultWht,
              introducedBirthPlan: widget.prenatal.introducedBirthPlan,
              fundicHeight: widget.prenatal.fundicHeight,
              isFundicNormal: widget.prenatal.fundicNormal,
              bloodPressure: widget.prenatal.bloodPressure,
              isBloodPressureNormal: widget.prenatal.bloodPressureNormal,
              advices: widget.prenatal.advices,
              services: widget.prenatal.services)
        ],
      ),
      const BirthPlan(),
      AfterCare(
        afterCare: af_model.AfterCare(
            immunzation: widget.prenatal.ttItems.map(
              (e) {
                return af_model.Immunization(term: e['term']);
              },
            ).toList(),
            ironSupplement: widget.prenatal.ironSuppItems
                .map(
                  (e) => af_model.IronSupplement(tabs: e['no_tabs']),
                )
                .toList()),
      ),
      const Counseling()
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
          actionsPadding: const EdgeInsets.only(right: 8 * 2),
          actions: [
            CustomButton(
                radius: 5,
                verticalPadding: 1,
                horizontalPadding: 2,
                onPress: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PatientsInfoPage(
                              prenatalId: widget.prenatal.id,
                            ))),
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
