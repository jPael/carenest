import 'package:flutter/material.dart';
import 'package:smartguide_app/components/button/custom_button.dart';
import 'package:smartguide_app/components/form/custom_form.dart';
import 'package:smartguide_app/components/input/custom_input.dart';
import 'package:smartguide_app/pages/mother/signup/account_creation.dart';

class MotherRegistration extends StatefulWidget {
  const MotherRegistration({super.key});

  @override
  State<MotherRegistration> createState() => _MotherRegistrationState();
}

class _MotherRegistrationState extends State<MotherRegistration> {
  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  DateTime dateOfBirth = DateTime.now();

  void handleDateOfBirthChange(DateTime date) {
    setState(() {
      dateOfBirth = date;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        forceMaterialTransparency: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8 * 3),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                      child: Text(
                    "Mother registration",
                    style: TextStyle(fontSize: 8 * 6, fontWeight: FontWeight.w500),
                    softWrap: true,
                  )),
                  Image.asset(
                    "lib/assets/images/mothers_registration_hero.png",
                    scale: 1.8,
                  )
                ],
              ),
              CustomForm(
                label: "Personal Information",
                actions: [
                  CustomButton(
                    label: "Next",
                    icon: Icon(Icons.arrow_forward_outlined),
                    onPress: () => Navigator.push(
                        context, MaterialPageRoute(builder: (context) => AccountCreation())),
                  )
                ],
                socials: [
                  CustomButton.social(
                      context: context,
                      label: "Or sign up with Google",
                      buttonType: SocialButtonType.google,
                      onPressed: () {})
                ],
                children: [
                  CustomInput.text(
                      context: context,
                      controller: firstnameController,
                      label: "Firstname",
                      hint: "e.g. Maria"),
                  const SizedBox(
                    height: 8 * 2,
                  ),
                  CustomInput.text(
                      context: context,
                      controller: lastnameController,
                      label: "Lastname",
                      hint: "e.g. Dela Cruz"),
                  const SizedBox(
                    height: 8 * 2,
                  ),
                  CustomInput.datepicker(
                      context: context,
                      selectedDate: dateOfBirth,
                      onChange: handleDateOfBirthChange),
                  const SizedBox(
                    height: 8 * 2,
                  ),
                  CustomInput.text(
                      context: context,
                      controller: phoneNumberController,
                      label: "Phone number",
                      hint: "e.g. 09XXXXXXXXX"),
                  const SizedBox(
                    height: 8 * 2,
                  ),
                  CustomInput.text(
                      context: context,
                      controller: addressController,
                      label: "Address",
                      hint: "(Barangray, City)"),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
