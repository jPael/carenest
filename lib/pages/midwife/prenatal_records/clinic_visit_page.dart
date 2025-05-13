import 'package:flutter/material.dart';
import 'package:flutter_auto_size_text/flutter_auto_size_text.dart';
import 'package:intl/intl.dart';
import 'package:smartguide_app/components/section/custom_section.dart';
import 'package:smartguide_app/models/revamp/clinic_history.dart';
import 'package:smartguide_app/models/revamp/first_trimester.dart';
import 'package:smartguide_app/models/revamp/second_trimester.dart';
import 'package:smartguide_app/models/revamp/third_trimester.dart';
import 'package:smartguide_app/pages/midwife/prenatal_records/first_trimester_view_page.dart';
import 'package:smartguide_app/pages/midwife/prenatal_records/first_trimester_visit_create_page.dart';
import 'package:smartguide_app/pages/midwife/prenatal_records/second_trimester_view_page.dart';
import 'package:smartguide_app/pages/midwife/prenatal_records/second_trimester_visit_create_page.dart';
import 'package:smartguide_app/pages/midwife/prenatal_records/third_trimester_view.dart';
import 'package:smartguide_app/pages/midwife/prenatal_records/third_trimester_visit_create_page.dart';

class ClinicVisitPage extends StatefulWidget {
  const ClinicVisitPage({super.key, required this.clinicHistory});

  final ClinicHistory clinicHistory;

  @override
  State<ClinicVisitPage> createState() => _ClinicVisitPageState();
}

class _ClinicVisitPageState extends State<ClinicVisitPage> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final List<FirstTrimester> firstTrimesterClinicVisit = widget.clinicHistory.firstTrimesters;
    final List<SecondTrimester> secondTrimesterClinicVisit = widget.clinicHistory.secondTrimesters;
    final List<ThirdTrimester> thirdTrimesterClinicVisit = widget.clinicHistory.thirdTrimesters;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Clinic Visits"),
            AutoSizeText(
              DateFormat("EEEE MMMM dd, yyyy").format(widget.clinicHistory.createdAt),
              style: const TextStyle(fontSize: 4 * 3),
              maxLines: 1,
            )
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () => Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //           builder: (context) => AddClinicVisitFormPage(
      //                 clinicHistory: widget.clinicHistory,
      //               ))),
      //   label: const Text("Add clinic visit"),
      //   icon: const Icon(Icons.note_add_rounded),
      // ),
      body: isLoading
          ? const Padding(
              padding: EdgeInsets.all(8 * 5.0),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox.square(
                      dimension: 8 * 3,
                      child: CircularProgressIndicator(),
                    )
                  ],
                ),
              ),
            )
          : ListView(
              padding: const EdgeInsets.symmetric(horizontal: 8 * 1),
              children: [
                Card(
                  margin: const EdgeInsets.all(8),
                  child: Padding(
                      padding: const EdgeInsets.all(8 * 2),
                      child: CustomSection(
                        title: "First Trimester",
                        action: IconButton.filled(
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => FirstTrimesterVisitCreatePage(
                                        clinicHistory: widget.clinicHistory,
                                      ))),
                          icon: const Icon(Icons.add_rounded),
                          tooltip: "Add check-up",
                        ),
                        headerSpacing: 1,
                        alignment: CrossAxisAlignment.start,
                        children: firstTrimesterClinicVisit
                            .asMap()
                            .entries
                            .map((c) => InkWell(
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (contex) => FirstTrimesterViewPage(
                                              trimesters: firstTrimesterClinicVisit,
                                              defaultSelected: c.key,
                                            ))),
                                child: trimesterClinicVisitItem(
                                    label: c.value.checkUp.label, date: c.value.createdAt)))
                            .toList(),
                      )),
                ),
                Card(
                  margin: const EdgeInsets.all(8),
                  child: Padding(
                      padding: const EdgeInsets.all(8 * 2),
                      child: CustomSection(
                        title: "Second Trimester",
                        headerSpacing: 1,
                        action: IconButton.filled(
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => SecondTrimesterVisitCreatePage(
                                        clinicHistory: widget.clinicHistory,
                                      ))),
                          icon: const Icon(Icons.add_rounded),
                          tooltip: "Add check-up",
                        ),
                        alignment: CrossAxisAlignment.start,
                        children: secondTrimesterClinicVisit
                            .asMap()
                            .entries
                            .map((c) => InkWell(
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (contex) => SecondTrimesterViewPage(
                                              trimesters: secondTrimesterClinicVisit,
                                              defaultSelected: c.key,
                                            ))),
                                child: trimesterClinicVisitItem(
                                    label: c.value.checkUp.label, date: c.value.createdAt)))
                            .toList(),
                      )),
                ),
                Card(
                  margin: const EdgeInsets.all(8),
                  child: Padding(
                      padding: const EdgeInsets.all(8 * 2),
                      child: CustomSection(
                        title: "Third Trimester",
                        headerSpacing: 1,
                        action: IconButton.filled(
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ThirdTrimesterVisitCreatePage(
                                        clinicHistory: widget.clinicHistory,
                                      ))),
                          icon: const Icon(Icons.add_rounded),
                          tooltip: "Add check-up",
                        ),
                        alignment: CrossAxisAlignment.start,
                        children: thirdTrimesterClinicVisit
                            .asMap()
                            .entries
                            .map((c) => InkWell(
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (contex) => ThirdTrimesterView(
                                              trimesters: thirdTrimesterClinicVisit,
                                              defaultSelected: c.key,
                                            ))),
                                child: trimesterClinicVisitItem(
                                    label: c.value.checkUp.label, date: c.value.createdAt)))
                            .toList(),
                      )),
                ),
              ],
            ),
    );
  }

  Container trimesterClinicVisitItem({required String label, required DateTime date}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black.withValues(alpha: 0.0)),
          borderRadius: BorderRadius.circular(8)),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 4 * 4, fontWeight: FontWeight.bold),
          ),
          AutoSizeText(
            DateFormat("EEEE dd MMMM yyyy").format(date),
            minFontSize: 4 * 3,
            maxFontSize: 4 * 3,
            maxLines: 1,
          ),
          const SizedBox(
            height: 8 * 2,
          ),
        ],
      ),
    );
  }
}
