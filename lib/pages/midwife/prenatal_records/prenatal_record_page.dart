import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartguide_app/components/button/custom_button.dart';
import 'package:smartguide_app/components/prenatal_records/after_care/after_care.dart';
import 'package:smartguide_app/components/prenatal_records/birth_plan/birth_plan.dart';
import 'package:smartguide_app/components/prenatal_records/care_and_tests/care_and_tests.dart';
import 'package:smartguide_app/components/prenatal_records/counseling/counseling.dart';
import 'package:smartguide_app/models/after_care.dart' as af_model;
import 'package:smartguide_app/models/prenatal.dart';
import 'package:smartguide_app/models/user.dart';
import 'package:smartguide_app/pages/midwife/prenatal_records/patients_info_page.dart';
import 'package:smartguide_app/services/laravel/prenatal_services.dart';

class PrenatalRecordPage extends StatefulWidget {
  const PrenatalRecordPage({super.key, required this.prenatal});

  final Prenatal prenatal;
  @override
  State<PrenatalRecordPage> createState() => _PrenatalRecordPageState();
}

class _PrenatalRecordPageState extends State<PrenatalRecordPage> with TickerProviderStateMixin {
  bool isLoading = true;
  Map<String, dynamic>? data;

  final List<String> tabs = ["Care and Tests", "Birth Plan", "After Care", "Counseling"];

  late final List<Widget> tabViews;

  late final TabController tabController;

  Future<void> fetchPatientInformation() async {
    final User user = context.read<User>();
    final PrenatalServices prenatalServices = PrenatalServices();

    data = await prenatalServices.fetchPatientInformationById(
        token: user.token!,
        userId: widget.prenatal.laravelId,
        patientInformationId: widget.prenatal.id!);

    // log("sas: " + data.toString());
    initTabbar();
  }

  void initTabbar() {
    tabController = TabController(length: tabs.length, vsync: this);

    tabViews = [
      CareAndTests(
        trimesters: [data!['careAndTest']],
      ),
      BirthPlan(
        data: data?['birthPlan'],
      ),
      AfterCare(
        afterCare: af_model.AfterCare(
            immunzation: widget.prenatal.ttItems.map(
              (e) {
                log(e['created_at'].toString());

                return af_model.Immunization(
                    term: e['term'], date: DateTime.parse(e['created_at']));
              },
            ).toList(),
            ironSupplement: widget.prenatal.ironSuppItems
                .map(
                  (e) => af_model.IronSupplement(
                      tabs: e['no_tabs'], date: DateTime.parse(e['created_at'])),
                )
                .toList()),
      ),
      Counseling(
        counseling: data?['counseling'],
      )
    ];

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchPatientInformation();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: SizedBox.square(
                dimension: 8 * 5,
                child: CircularProgressIndicator(),
              ),
            )
          ],
        ),
      );
    }

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
