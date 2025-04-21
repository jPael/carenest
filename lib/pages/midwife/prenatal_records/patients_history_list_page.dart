
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:smartguide_app/models/prenatal.dart';
import 'package:smartguide_app/models/user.dart';
import 'package:smartguide_app/pages/midwife/prenatal_records/prenatal_record_page.dart';
import 'package:smartguide_app/services/laravel/prenatal_services.dart';

class PatientsHistoryListPage extends StatefulWidget {
  const PatientsHistoryListPage({super.key, required this.id, required this.fullname});

  final int id;
  final String fullname;

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

    prenatals =
        await prenatalServices.fetchAllPrenatalByLaravelUserId(token: user.token!, id: widget.id);

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
        title: Text("${widget.fullname.split(" ").first}'s history"),
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
                  itemBuilder: (context, index) {
                    final Prenatal currPrenatal = prenatals[index];

                    return ListTile(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  PrenatalRecordPage(prenatal: prenatals[index]))),
                      title: Text(DateFormat("MMMM dd, yyyy").format(currPrenatal.createdAt!)),
                      subtitle: Text(currPrenatal.barangay),
                    );
                  }),
    );
  }
}
