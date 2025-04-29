import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:smartguide_app/components/midwife/prenatal_records/midwife_prenatal_records_items.dart';
import 'package:smartguide_app/components/midwife/prenatal_records/midwife_prenatal_records_search_bar.dart';
import 'package:smartguide_app/components/section/custom_section.dart';
import 'package:smartguide_app/models/person.dart';
import 'package:smartguide_app/services/laravel/mother_services.dart';

class PrenatalRecordsListPage extends StatefulWidget {
  const PrenatalRecordsListPage({super.key});

  @override
  State<PrenatalRecordsListPage> createState() => _PrenatalRecordsListPageState();
}

class _PrenatalRecordsListPageState extends State<PrenatalRecordsListPage> {
  bool isLoading = false;
  List<Person> originMothers = [];

  List<Person> mothers = [];

  void onMothersChange(List<Person> values) {
    log("called ${values.length}");

    setState(() {
      mothers = values;
    });
  }

  Future<void> fetchAllPrenatals() async {
    setState(() {
      isLoading = true;
    });
    // final User user = context.read<User>();

    // final PrenatalServices prenatalServices = PrenatalServices();
    // final M m = M();

    originMothers = await fetchAllMothers();

    setState(() {
      mothers = originMothers;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchAllPrenatals();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Prenatal Records"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0 * 2),
          child: CustomSection(
            description: MidwifePrenatalRecordsSearchBar(
              onMothersChange: onMothersChange,
              mothers: originMothers,
            ),
            emptyChildrenContent: const Text("No records found."),
            isLoading: isLoading,
            isLoadingWidget: const MidwifePrenatalRecordsItems(),
            children: [
              if (!isLoading)
                ...mothers.map((p) => MidwifePrenatalRecordsItems(
                      mother: p,
                    ))

              
            ],
          ),
        ),
      ),
    );
  }
}
