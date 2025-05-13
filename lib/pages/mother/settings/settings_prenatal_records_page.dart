import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:smartguide_app/components/alert/alert.dart';
import 'package:smartguide_app/components/prenatal_records/form/patient_information_form.dart';
import 'package:smartguide_app/components/section/custom_section.dart';
import 'package:smartguide_app/models/patient_information.dart';
import 'package:smartguide_app/models/revamp/person_history.dart';
import 'package:smartguide_app/models/user.dart';
import 'package:smartguide_app/pages/midwife/prenatal_records/clinic_visit_page.dart';
import 'package:smartguide_app/services/laravel/prenatal_services.dart';
import 'package:smartguide_app/utils/date_utils.dart';

class SettingsPrenatalRecordsPage extends StatefulWidget {
  const SettingsPrenatalRecordsPage({super.key});

  @override
  State<SettingsPrenatalRecordsPage> createState() => _SettingsPrenatalRecordsPageState();
}

class _SettingsPrenatalRecordsPageState extends State<SettingsPrenatalRecordsPage> {
  final TextEditingController fullnameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController obStatusController = TextEditingController();
  final TextEditingController barangayController = TextEditingController();
  final TextEditingController donorFullnameController = TextEditingController();
  final TextEditingController donorContactController = TextEditingController();

  DateTime? birthday;
  DateTime? lmp;
  DateTime? edc;

  final TextEditingController philhealthController = TextEditingController();
  final TextEditingController nhtsController = TextEditingController();

  final formKey = GlobalKey<FormState>(); // Add this key

  late final PatientInformation? data;
  bool isLoading = true;

  Future<void> fetchPrenatalInfo() async {
    final PrenatalServices prenatalServices = PrenatalServices();
    final User user = context.read<User>();

    final PatientInformation? _data = await prenatalServices.fetchMotherPatientInformationById(
        id: user.laravelId!, token: user.token!);

    setState(() {
      data = _data;
      isLoading = false;
    });
  }

  void initData() {
    final User user = context.read<User>();

    setState(() {
      birthday = DateTime.parse(user.dateOfBirth!).toLocal();
      fullnameController.text = "${user.firstname} ${user.lastname}";
      ageController.text = calculateAge(DateTime.parse(user.dateOfBirth!).toLocal()).toString();
      obStatusController.text = data?.obStatus ?? "";
      lmp = data?.lmp;
      edc = data?.edc;
      philhealthController.text = data?.philhealth ?? "";
      nhtsController.text = data?.nhts ?? "";
    });
  }

  bool isSubmitting = false;
  Future<void> handleSave() async {
    final User user = context.read<User>();

    if (formKey.currentState!.validate()) {
      setState(() {
        isSubmitting = true;
      });

      final PatientInformation pi = PatientInformation(
          philhealth: philhealthController.text,
          birthday: DateTime.parse(user.dateOfBirth!),
          nhts: nhtsController.text,
          userId: user.laravelId!,
          lmp: lmp!,
          edc: edc!,
          obStatus: obStatusController.text);

      final Map<String, dynamic> res =
          await pi.storeRecord(userId: user.laravelId!, token: user.token!, create: (data == null));

      if (res['success']) {
        Alert.showSuccessMessage(message: "Patient information saved successfully");
      } else {
        Alert.showSuccessMessage(message: res['message']);
      }

      setState(() {
        isSubmitting = false;
      });
    }
  }

  late final PersonHistory prenatals;
  bool isHistoryLoading = false;

  Future<void> fetchPrenatals() async {
    final PrenatalServices prenatalServices = PrenatalServices();

    setState(() {
      isHistoryLoading = true;
    });

    final User user = context.read<User>();

    prenatals = await prenatalServices.fetchAllClinicHistoryByUserId(
        token: user.token!, id: user.laravelId!);

    setState(() {
      isHistoryLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchPrenatals();

    fetchPrenatalInfo().then(
      (value) {
        // log("reinit");
        initData();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Prenatal Record"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(4 * 6),
              child: isLoading
                  ? const Center(
                      child: SizedBox.square(
                        dimension: 8 * 4,
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : Column(children: [
                      PatientInformationForm(
                        handleSave: handleSave,
                        isSubmitting: isSubmitting,
                        isReadonly: false,
                        formKey: formKey,
                        data: data,
                        fullnameController: fullnameController,
                        ageController: ageController,
                        obStatusController: obStatusController,
                        onBarangayChange: (String? address, String? id) {
                          barangayController.text = address!;
                        },
                        onBirthdayChange: (DateTime d) {
                          setState(() {
                            birthday = d;
                          });
                        },
                        onLmpChange: (DateTime d) {
                          setState(() {
                            lmp = d;
                          });
                        },
                        onEdcChange: (DateTime d) {
                          setState(() {
                            edc = d;
                          });
                        },
                        lmp: lmp,
                        edc: edc,
                        philhealthController: philhealthController,
                        nhtsController: nhtsController,
                        birthday: birthday,
                      ),
                      const SizedBox(
                        height: 8 * 3,
                      ),
                      CustomSection(
                        title: "Clinic History",
                        children: [
                          if (isHistoryLoading)
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 80),
                              child: Center(
                                child: Column(
                                  children: [
                                    SizedBox(
                                      width: 40,
                                      height: 40,
                                      child: CircularProgressIndicator(),
                                    ),
                                    SizedBox(height: 16),
                                    Text("Loading..."),
                                  ],
                                ),
                              ),
                            )
                          else if (prenatals.clinicVisits.isEmpty)
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 80),
                              child: Center(child: Text("No records found")),
                            )
                          else
                            Column(
                              children: [
                                for (final currPrenatal in prenatals.clinicVisits)
                                  Card(
                                    margin: const EdgeInsets.only(bottom: 8),
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(12),
                                      onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ClinicVisitPage(
                                            clinicHistory: currPrenatal,
                                          ),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(16),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                const Expanded(
                                                  child: Text(
                                                    "Clinic visit",
                                                    style: TextStyle(fontSize: 16),
                                                  ),
                                                ),
                                                if (prenatals.clinicVisits.indexOf(currPrenatal) ==
                                                    0)
                                                  Container(
                                                    padding: const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 4,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: Theme.of(context).primaryColor,
                                                      borderRadius: BorderRadius.circular(8),
                                                    ),
                                                    child: const Text(
                                                      "Latest",
                                                      style: TextStyle(color: Colors.white),
                                                    ),
                                                  ),
                                              ],
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              DateFormat("EEEE MMMM dd, yyyy - hh:mm aa")
                                                  .format(currPrenatal.createdAt),
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            )
                        ],
                      )
                    ]))),
    );
  }
}
