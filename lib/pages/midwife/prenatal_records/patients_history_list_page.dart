import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smartguide_app/models/barangay.dart';
import 'package:smartguide_app/pages/midwife/prenatal_records/prenatal_record_page.dart';
import 'package:smartguide_app/services/laravel/barangay_services.dart';

class PatientsHistoryListPage extends StatefulWidget {
  const PatientsHistoryListPage({super.key});

  @override
  State<PatientsHistoryListPage> createState() => _PatientsHistoryListPageState();
}

class _PatientsHistoryListPageState extends State<PatientsHistoryListPage> {
  List<Barangay> barangays = [];

  final BarangayServices barangayServices = BarangayServices();

  Future<void> fetchAllBarangays() async {
    final List<Barangay> b = await barangayServices.fetchALlBarangays();

    setState(() {
      barangays = b;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchAllBarangays();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mary's history"),
      ),
      body: ListView.builder(
          itemCount: 20,
          itemBuilder: (context, index) {
            final List<Map<String, dynamic>> dates = List.generate(20, (index) {
              final int selectedBarangay = Random().nextInt(barangays.length);

              return {
                "id": index,
                "barangay": barangays[selectedBarangay].name,
                "date": DateTime.now().subtract(Duration(days: index * 30)),
              };
            });

            return ListTile(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PrenatalRecordPage(
                            user: "Mary",
                          ))),
              title: Text(DateFormat("MMMM dd, yyyy").format(dates[index]["date"])),
              subtitle: Text(dates[index]["barangay"]),
            );
          }),
    );
  }
}
