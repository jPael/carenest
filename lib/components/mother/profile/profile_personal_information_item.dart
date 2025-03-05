import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smartguide_app/components/button/custom_button.dart';
import 'package:smartguide_app/components/input/custom_input.dart';
import 'package:smartguide_app/components/mother/profile/profile_menu_item.dart';

class ProfilePersonalInformationItem extends StatefulWidget {
  const ProfilePersonalInformationItem(
      {super.key, this.firstname, this.lastname, this.dateOfBirth, this.phoneNumber, this.address});

  final String? firstname;
  final String? lastname;
  final String? dateOfBirth;
  final String? phoneNumber;
  final String? address;

  @override
  State<ProfilePersonalInformationItem> createState() => _ProfilePersonalInformationItemState();
}

class _ProfilePersonalInformationItemState extends State<ProfilePersonalInformationItem> {
  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  late DateTime dateOfBirth;
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  late User? user;

  void handleDateOfBirthChange(DateTime date) {
    setState(() {
      dateOfBirth = date;
    });
  }

  void handleSave(data) {}

  @override
  void initState() {
    super.initState();
    firstnameController.text = widget.firstname ?? "";
    lastnameController.text = widget.lastname ?? "";
    phoneNumberController.text = widget.phoneNumber ?? "";
    addressController.text = widget.address ?? "";
    dateOfBirth = DateTime.parse(widget.dateOfBirth!);
  }

  @override
  Widget build(BuildContext context) {
    return ProfileMenuItem(
      startIcon: Icon(Icons.person),
      title: "Personal Information",
      form: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 8,
        children: [
          CustomInput.text(
              context: context,
              controller: firstnameController,
              label: "First name",
              hint: "e.g. Juan"),
          CustomInput.text(
              context: context,
              controller: lastnameController,
              label: "Last name",
              hint: "e.g. Dela Cruz"),
          CustomInput.datepicker(
              context: context,
              onChange: (date) => handleDateOfBirthChange(date),
              selectedDate: dateOfBirth,
              label: "Date of birth"),
          CustomInput.text(
              context: context,
              controller: phoneNumberController,
              label: "Phone number",
              hint: "09 (xx-xxx-xxxx)"),
          CustomInput.text(
              context: context,
              controller: addressController,
              label: "Address",
              hint: "e.g., 123 Rizal St., Brgy. San Isidro, Makati City, Metro Manila, 1230"),
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            CustomButton(
              onPress: () {},
              radius: 3,
              label: "Save",
            ),
          ])
        ],
      ),
    );
  }
}
