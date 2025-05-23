import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartguide_app/components/alert/alert.dart';
import 'package:smartguide_app/components/button/custom_button.dart';
import 'package:smartguide_app/components/form/custom_form.dart';
import 'package:smartguide_app/components/prenatal_records/form/patient_information_form.dart';
import 'package:smartguide_app/models/patient_information.dart';
import 'package:smartguide_app/models/user.dart';

class MotherPrenatalInfoForm extends StatefulWidget {
  const MotherPrenatalInfoForm({super.key});

  @override
  MotherPrenatalInfoFormState createState() => MotherPrenatalInfoFormState();
}

class MotherPrenatalInfoFormState extends State<MotherPrenatalInfoForm> {
  bool isFetchingData = true;
  bool isSubmittingData = false;

  // patient info
  final TextEditingController fullnameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController obStatusController = TextEditingController();
  final TextEditingController barangayController = TextEditingController();
  // final TextEditingController donorFullnameController = TextEditingController();
  // final TextEditingController donorContactController = TextEditingController();

  DateTime? birthday;
  DateTime? lmp;
  DateTime? edc;

  final TextEditingController philhealthController = TextEditingController();
  final TextEditingController nhtsController = TextEditingController();
  // bool donorTyped = false;
  // patient info

  // Future<void>

  Future<void> handleSubmit() async {
    final User user = context.read<User>();

    setState(() {
      isSubmittingData = true;
    });

    final PatientInformation pi = PatientInformation(
      philhealth: philhealthController.text,
      userId: user.laravelId!,
      nhts: nhtsController.text,
      lmp: lmp!,
      birthday: DateTime.parse(user.dateOfBirth!),
      edc: edc!,
      obStatus: obStatusController.text,
    );

    final Map<String, dynamic> res =
        await pi.storeRecord(userId: user.laravelId!, token: user.token!);

    if (res['success']) {
      Alert.showSuccessMessage(message: "Patient information saved successfully");
    } else {
      Alert.showSuccessMessage(message: res['message']);
    }

    setState(() {
      isSubmittingData = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(4 * 2),
        child: isFetchingData
            ? const Center(
                child: SizedBox.square(
                  dimension: 8 * 4,
                  child: CircularProgressIndicator(),
                ),
              )
            : CustomForm(actions: [
                // if (!widget.readonly)
                CustomButton(
                  onPress: handleSubmit,
                  label: "Submit",
                  isLoading: isSubmittingData,
                  verticalPadding: 2,
                  horizontalPadding: 5,
                )
              ], children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0 * 2),
                    child: PatientInformationForm(
                      isReadonly: false,
                      birthday: birthday,
                      edc: edc,
                      lmp: lmp,
                      // data: prenatalData?['patientInformation'],
                      data: null,
                      ageController: ageController,
                      fullnameController: fullnameController,
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
                      philhealthController: philhealthController,
                      nhtsController: nhtsController,
                    ),
                  ),
                ),
              ]),
      ),
    );
  }
}
