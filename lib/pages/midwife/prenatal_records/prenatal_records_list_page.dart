import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartguide_app/components/midwife/prenatal_records/midwife_prenatal_records_items.dart';
import 'package:smartguide_app/components/section/custom_section.dart';
import 'package:smartguide_app/models/prenatal.dart';
import 'package:smartguide_app/models/user.dart';
import 'package:smartguide_app/services/laravel/prenatal_services.dart';

class PrenatalRecordsListPage extends StatefulWidget {
  const PrenatalRecordsListPage({super.key});

  @override
  State<PrenatalRecordsListPage> createState() => _PrenatalRecordsListPageState();
}

class _PrenatalRecordsListPageState extends State<PrenatalRecordsListPage> {
  bool isLoading = false;
  late final List<Prenatal> prenatals;

  Future<void> fetchAllPrenatals() async {
    setState(() {
      isLoading = true;
    });
    final User user = context.read<User>();

    final PrenatalServices prenatalServices = PrenatalServices();

    prenatals = await prenatalServices.fetchAllPrenatalByLaravelUserId(
        token: user.token!, id: user.laravelId!);

    setState(() {
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
        title: const Text("Prenatal Record List"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0 * 2),
          child: CustomSection(
            // description: MidwifePrenatalRecordsSearchBar(),
            emptyChildrenContent: const Text("No records found."),
            isLoading: isLoading,
            isLoadingWidget: const MidwifePrenatalRecordsItems(),

            children: [
              if (!isLoading)
                ...prenatals.map((p) => MidwifePrenatalRecordsItems(
                      prenatal: p,
                    ))

              // MidwifePrenatalRecordsItems(
              //   user: "Marry",
              //   lastVisit: DateTime.now(),
              //   onTap: () => Navigator.push(
              //       context, MaterialPageRoute(builder: (context) => PatientsHistoryListPage())),
              // ),
              // MidwifePrenatalRecordsItems(
              //   user: "Rose",
              //   lastVisit: DateTime.now(),
              //   onTap: () => Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //           builder: (context) => const PrenatalRecordPage(
              //                 user: "Rose",
              //               ))),
              // ),
              // MidwifePrenatalRecordsItems(
              //   user: "Ann",
              //   lastVisit: DateTime.now(),
              //   onTap: () => Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //           builder: (context) => const PrenatalRecordPage(
              //                 user: "Ann",
              //               ))),
              // ),
              // MidwifePrenatalRecordsItems(
              //   user: "Lady",
              //   lastVisit: DateTime.now(),
              //   onTap: () => Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //           builder: (context) => const PrenatalRecordPage(
              //                 user: "Lady",
              //               ))),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
