import 'package:flutter/material.dart';
import 'package:flutter_auto_size_text/flutter_auto_size_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:smartguide_app/models/person.dart';
import 'package:smartguide_app/models/revamp/clinic_history.dart';
import 'package:smartguide_app/models/revamp/person_history.dart';
import 'package:smartguide_app/models/user.dart';
import 'package:smartguide_app/pages/midwife/prenatal_records/clinic_visit_page.dart';
import 'package:smartguide_app/pages/midwife/prenatal_records/create_new_prenatal_page.dart';
import 'package:smartguide_app/services/laravel/prenatal_services.dart';

class PatientsHistoryListPage extends StatefulWidget {
  const PatientsHistoryListPage({super.key, required this.person});

  final Person person;

  @override
  State<PatientsHistoryListPage> createState() => _PatientsHistoryListPageState();
}

class _PatientsHistoryListPageState extends State<PatientsHistoryListPage> {
  final PrenatalServices prenatalServices = PrenatalServices();

  PersonHistory? prenatals;
  bool isLoading = false;

  Future<void> fetchPrenatals() async {
    setState(() {
      isLoading = true;
    });

    final User user = context.read<User>();

    prenatals = await prenatalServices.fetchAllClinicHistoryByUserId(
        token: user.token!, id: widget.person.id!);

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
        onPressed: prenatals == null
            ? () {}
            : () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => CreateNewPrenatalPage(person: prenatals!))),
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
          : prenatals == null || prenatals!.clinicVisits.isEmpty
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
                  itemCount: prenatals!.clinicVisits.length,
                  padding: const EdgeInsets.all(8 * 3),
                  itemBuilder: (context, index) {
                    final ClinicHistory currPrenatal = prenatals!.clinicVisits[index];

                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black.withValues(alpha: 0.3)),
                          borderRadius: BorderRadius.circular(8 * 2)),
                      child: InkWell(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ClinicVisitPage(clinicHistory: currPrenatal))),
                        child: Padding(
                          padding: const EdgeInsets.all(8 * 2),
                          child: Column(
                            spacing: 4 * 2,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Expanded(
                                      child: AutoSizeText(
                                    "Clinic visit",
                                    style: TextStyle(
                                      fontSize: 4 * 3,
                                    ),
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
                                    DateFormat("EEEE MMMM dd, yyyy - hh:mm aa")
                                        .format(currPrenatal.createdAt),
                                    style: const TextStyle(
                                        fontSize: 4 * 3, fontWeight: FontWeight.bold),
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
