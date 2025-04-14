import 'package:flutter/material.dart';
import 'package:smartguide_app/components/barangay/barangay_selector.dart';
import 'package:smartguide_app/components/button/custom_button.dart';
import 'package:smartguide_app/components/form/custom_form.dart';
import 'package:smartguide_app/components/input/custom_input.dart';
import 'package:smartguide_app/pages/midwife/signup/account_creation.dart';

class MidwifeRegistration extends StatefulWidget {
  const MidwifeRegistration({super.key});

  @override
  State<MidwifeRegistration> createState() => _MidwifeRegistrationState();
}

class _MidwifeRegistrationState extends State<MidwifeRegistration> {
  final formKey = GlobalKey<FormState>(); // Add this key

  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  // final TextEditingController addressController = TextEditingController();

  DateTime? dateOfBirth;

  void handleDateOfBirthChange(DateTime date) {
    setState(() {
      dateOfBirth = date;
    });
  }

  void handleNext() {
    if (formKey.currentState!.validate()) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AccountCreation(
                    firstname: firstnameController.text,
                    lastname: lastnameController.text,
                    phoneNumber: phoneNumberController.text,
                    address: selectedBarangay,
                    dateOfBirth: dateOfBirth!,
                  )));
    }
  }

  String selectedBarangay = "";
  void handleBarangaySelection(String? value) {
    setState(() {
      selectedBarangay = value ?? "";
    });
  }

  @override
  void dispose() {
    firstnameController.dispose();
    lastnameController.dispose();
    phoneNumberController.dispose();
    // addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    precacheImage(const AssetImage("lib/assets/images/midwife_signin_hero.png"), context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        forceMaterialTransparency: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8 * 3),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Flexible(
                        child: Text(
                      "Midwife registration",
                      style: TextStyle(fontSize: 8 * 6, fontWeight: FontWeight.w500),
                      softWrap: true,
                    )),
                    Hero(
                      tag: "Midwife",
                      child: Image.asset(
                        "lib/assets/images/midwife_signin_hero.png",
                        scale: 2.5,
                      ),
                    )
                  ],
                ),
                CustomForm(
                  label: "Personal Information",
                  actions: [
                    CustomButton(
                      label: "Next",
                      icon: const Icon(Icons.arrow_forward_outlined),
                      onPress: handleNext,
                    )
                  ],
                  children: [
                    CustomInput.text(
                        validator: (v) {
                          if (v == null || v.isEmpty) {
                            return "Please enter your first name";
                          }

                          return null;
                        },
                        context: context,
                        controller: firstnameController,
                        label: "Firstname",
                        hint: "e.g. Maria"),
                    const SizedBox(
                      height: 8 * 2,
                    ),
                    CustomInput.text(
                        validator: (v) {
                          if (v == null || v.isEmpty) {
                            return "Please enter your last name";
                          }
                          return null;
                        },
                        context: context,
                        controller: lastnameController,
                        label: "Lastname",
                        hint: "e.g. Dela Cruz"),
                    const SizedBox(
                      height: 8 * 2,
                    ),
                    CustomInput.datepicker(
                        validator: (v) {
                          if (v == null || v.isEmpty || dateOfBirth == null) {
                            return "Please enter your birthday";
                          }
                          return null;
                        },
                        context: context,
                        selectedDate: dateOfBirth,
                        onChange: handleDateOfBirthChange),
                    const SizedBox(
                      height: 8 * 2,
                    ),
                    CustomInput.text(
                        context: context,
                        validator: (v) {
                          if (v == null || v.isEmpty) {
                            return "Please enter your phone number";
                          }
                          return null;
                        },
                        controller: phoneNumberController,
                        label: "Phone number",
                        hint: "e.g. 09XXXXXXXXX"),
                    const SizedBox(
                      height: 8 * 2,
                    ),
                    BarangaySelector(
                      onChange: handleBarangaySelection,
                    )
                    // CustomInput.text(
                    //     context: context,
                    //     validator: (v) {
                    //       if (v == null || v.isEmpty) {
                    //         return "Please enter your address";
                    //       }
                    //       return null;
                    //     },
                    //     controller: addressController,
                    //     label: "Address",
                    //     hint: "(Barangray, City)"),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
