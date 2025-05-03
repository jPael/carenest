import 'package:flutter/material.dart';
import 'package:flutter_auto_size_text/flutter_auto_size_text.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:smartguide_app/models/clinic_visit.dart';
import 'package:smartguide_app/models/prenatal.dart';
import 'package:smartguide_app/models/trimester.dart';
import 'package:smartguide_app/models/user.dart';
import 'package:smartguide_app/pages/midwife/prenatal_records/add_clinic_visit_form_page.dart';
import 'package:smartguide_app/pages/midwife/prenatal_records/clinic_visit_view_page.dart';
import 'package:smartguide_app/services/laravel/prenatal_services.dart';

class ClinicVisitPage extends StatefulWidget {
  const ClinicVisitPage({super.key, required this.prenatal});

  final Prenatal prenatal;

  @override
  State<ClinicVisitPage> createState() => _ClinicVisitPageState();
}

class _ClinicVisitPageState extends State<ClinicVisitPage> {
  bool isLoading = true;
  late List<ClinicVisit> clinicVisits;

  Future<void> fetchClinicVisit() async {
    final PrenatalServices prenatalServices = PrenatalServices();
    final User user = context.read<User>();

    final List<ClinicVisit> _cv = await prenatalServices.fetchClinicVisitByPrenatalId(
        prenatalId: widget.prenatal.id!, token: user.token!);

    setState(() {
      clinicVisits = _cv;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchClinicVisit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Clinic Visits"),
            AutoSizeText(
              DateFormat("EEE MMMM dd, yyyyy").format(widget.prenatal.createdAt!),
              style: const TextStyle(fontSize: 4 * 3),
              maxLines: 1,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddClinicVisitFormPage(
                      prenatal: widget.prenatal,
                    ))),
        label: const Text("Add clinic visit"),
        icon: const Icon(Icons.note_add_rounded),
      ),
      body: isLoading
          ? const Column(
              children: [
                SizedBox.square(
                  dimension: 8 * 3,
                  child: CircularProgressIndicator(),
                )
              ],
            )
          : ListView.builder(
              itemCount: clinicVisits.length,
              padding: const EdgeInsets.symmetric(vertical: 8 * 2, horizontal: 8 * 3),
              itemBuilder: (BuildContext context, int index) {
                final ClinicVisit curr = clinicVisits[index];

                return Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                      border: Border.all(), borderRadius: BorderRadius.circular(8 * 2)),
                  margin: const EdgeInsets.all(8),
                  child: InkWell(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (contex) => ClinicVisitViewPage(clinicVisit: curr))),
                    child: Padding(
                      padding: const EdgeInsets.all(8 * 2),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                  child: AutoSizeText(
                                curr.trimester.label,
                              )),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
    );
  }
}
