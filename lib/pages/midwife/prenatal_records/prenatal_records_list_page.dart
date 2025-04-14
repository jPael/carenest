import 'package:flutter/material.dart';
import 'package:smartguide_app/components/midwife/prenatal_records/midwife_prenatal_records_items.dart';
import 'package:smartguide_app/components/midwife/prenatal_records/midwife_prenatal_records_search_bar.dart';
import 'package:smartguide_app/components/section/custom_section.dart';
import 'package:smartguide_app/pages/midwife/prenatal_records/patients_history_list_page.dart';
import 'package:smartguide_app/pages/midwife/prenatal_records/prenatal_record_page.dart';

class PrenatalRecordsListPage extends StatelessWidget {
  const PrenatalRecordsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Prenatal Record List"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0 * 2),
          child: CustomSection(
            description: MidwifePrenatalRecordsSearchBar(),
            emptyChildrenContent: const Text("No records found."),
            children: [
              MidwifePrenatalRecordsItems(
                user: "Marry",
                lastVisit: DateTime.now(),
                onTap: () => Navigator.push(
                    context, MaterialPageRoute(builder: (context) => PatientsHistoryListPage())),
              ),
              MidwifePrenatalRecordsItems(
                user: "Rose",
                lastVisit: DateTime.now(),
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PrenatalRecordPage(
                              user: "Rose",
                            ))),
              ),
              MidwifePrenatalRecordsItems(
                user: "Ann",
                lastVisit: DateTime.now(),
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PrenatalRecordPage(
                              user: "Ann",
                            ))),
              ),
              MidwifePrenatalRecordsItems(
                user: "Lady",
                lastVisit: DateTime.now(),
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PrenatalRecordPage(
                              user: "Lady",
                            ))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
