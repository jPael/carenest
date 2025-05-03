import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartguide_app/components/alert/alert.dart';
import 'package:smartguide_app/components/button/custom_button.dart';
import 'package:smartguide_app/components/form/custom_form.dart';
import 'package:smartguide_app/components/prenatal_records/form/patient_information_form.dart';
import 'package:smartguide_app/models/donor.dart';
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
  final TextEditingController donorFullnameController = TextEditingController();
  final TextEditingController donorContactController = TextEditingController();

  DateTime? birthday;
  DateTime? lmp;
  DateTime? edc;

  bool philhealth = false;
  bool nhts = false;
  bool donorTyped = false;
  // patient info

  // Future<void>

  Future<void> handleSubmit() async {
    final User user = context.read<User>();

    setState(() {
      isSubmittingData = true;
    });

    final PatientInformation pi = PatientInformation(
        philhealth: philhealth,
        userId: user.laravelId!,
        nhts: nhts,
        lmp: lmp!,
        edc: edc!,
        obStatus: obStatusController.text,
        bloodDonor: Donor(
            fullname: donorFullnameController.text,
            contactNumber: donorContactController.text,
            bloodTyped: donorTyped));

    final Map<String, dynamic> res = await pi.storeRecord(token: user.token!);

    if (res['success']) {
      Alert.showSuccessMessage(message: "Patient information saved successfully");
    } else {
      Alert.showSuccessMessage(message: res['message']);
    }
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
                      philhealth: philhealth,
                      onPhilhealthChange: (bool v) {
                        setState(() {
                          philhealth = v;
                        });
                      },
                      nhts: nhts,
                      onNhtsChange: (bool v) {
                        setState(() {
                          nhts = v;
                        });
                      },
                      donorFullnameController: donorFullnameController,
                      donorContactController: donorContactController,
                      donorBloodTyped: donorTyped,
                      onDonorBloodTypeChange: (bool v) {
                        setState(() {
                          donorTyped = v;
                        });
                      },
                    ),
                  ),
                ),
              ]),
      ),
    );
  }
}
