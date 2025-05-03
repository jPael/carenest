import 'package:flutter/material.dart';
import 'package:flutter_auto_size_text/flutter_auto_size_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:smartguide_app/models/person.dart';
import 'package:smartguide_app/models/prenatal.dart';
import 'package:smartguide_app/models/user.dart';
import 'package:smartguide_app/pages/midwife/prenatal_records/clinic_visit_page.dart';
import 'package:smartguide_app/pages/midwife/prenatal_records/patients_prenatal_info_form.dart';
import 'package:smartguide_app/services/laravel/prenatal_services.dart';

class PatientsHistoryListPage extends StatefulWidget {
  const PatientsHistoryListPage({super.key, required this.person});

  final Person person;

  @override
  State<PatientsHistoryListPage> createState() => _PatientsHistoryListPageState();
}

class _PatientsHistoryListPageState extends State<PatientsHistoryListPage> {
  final PrenatalServices prenatalServices = PrenatalServices();

  late final List<Prenatal> prenatals;
  bool isLoading = false;

  Future<void> fetchPrenatals() async {
    setState(() {
      isLoading = true;
    });

    final User user = context.read<User>();

    prenatals = await prenatalServices.fetchAllPrenatalByLaravelUserId(
        token: user.token!, id: widget.person.id!)
      ..sort(
        (a, b) => b.createdAt!.compareTo(a.createdAt!),
      );

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchPrenatals();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.person.name!.split(" ").first}'s history"),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PatientsPrenatalInfoForm(
                      patient: widget.person,
                      isCreating: true,
                    ))),
        label: const Text("Create"),
        icon: const Icon(Icons.edit_rounded),
      ),
      body: isLoading
          ? const Padding(
              padding: EdgeInsets.symmetric(vertical: 10 * 8.0),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox.square(
                      dimension: 8 * 5,
                      child: CircularProgressIndicator(),
                    ),
                    SizedBox(
                      height: 4 * 4,
                    ),
                    Text("Loading...")
                  ],
                ),
              ),
            )
          : prenatals.isEmpty
              ? const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10 * 8.0),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [Text("No records found")],
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: prenatals.length,
                  padding: const EdgeInsets.all(8 * 3),
                  itemBuilder: (context, index) {
                    final Prenatal currPrenatal = prenatals[index];

                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                          border: Border.all(), borderRadius: BorderRadius.circular(8 * 2)),
                      child: InkWell(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ClinicVisitPage(prenatal: currPrenatal))),
                        child: Padding(
                          padding: const EdgeInsets.all(8 * 2),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  const Expanded(
                                      child: AutoSizeText(
                                    "Clinic visit",
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  )),
                                  if (index == 0)
                                    Container(
                                        padding:
                                            const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8),
                                            color: Theme.of(context).colorScheme.primary),
                                        child: const Text(
                                          "Latest",
                                          style: TextStyle(color: Colors.white),
                                        )),
                                ],
                              ),
                              Row(
                                // mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  AutoSizeText(
                                    DateFormat("EE MMMM dd, yyyy | hh:MM aa")
                                        .format(currPrenatal.createdAt!),
                                    style: const TextStyle(fontSize: 4 * 3),
                                  ),
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
