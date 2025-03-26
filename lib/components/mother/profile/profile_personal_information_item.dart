import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartguide_app/components/alert/alert.dart';
import 'package:smartguide_app/components/barangay/barangay_selector.dart';
import 'package:smartguide_app/components/button/custom_button.dart';
import 'package:smartguide_app/components/input/custom_input.dart';
import 'package:smartguide_app/components/mother/profile/profile_menu_item.dart';
import 'package:smartguide_app/models/user.dart' as current_user;

class ProfilePersonalInformationItem extends StatefulWidget {
  const ProfilePersonalInformationItem(
      {super.key,
      this.firstname,
      this.lastname,
      this.dateOfBirth,
      this.phoneNumber,
      this.address,
      required this.id,
      required this.idOpened,
      required this.setIdOpened});

  final int id;
  final int? idOpened;
  final Function(int? i) setIdOpened;
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
  // final TextEditingController addressController = TextEditingController();
  String selectedBarangay = "";

  late User? user;

  void handleDateOfBirthChange(DateTime date) {
    setState(() {
      dateOfBirth = date;
    });
  }

  void handleBarangaySelection(String? value) {
    setState(() {
      selectedBarangay = value ?? "";
    });
  }

  bool isLoading = false;

  Future<void> handleSave() async {
    try {
      setState(() {
        isLoading = true;
      });

      await Future.delayed(Duration(seconds: 3));

      if (!mounted) {
        return;
      }

      final String result = await context.read<current_user.User>().setPersonalInformation(
          firstnameController.text,
          lastnameController.text,
          selectedBarangay,
          phoneNumberController.text,
          dateOfBirth);

      if (!mounted) {
        return;
      }

      showSuccessMessage(context: context, message: result, duration: const Duration(seconds: 5));
    } catch (e, stackTrace) {
      if (!mounted) {
        return;
      }
      showErrorMessage(
          context: context, message: e.toString(), duration: const Duration(seconds: 5));

      log(e.toString());
      log(stackTrace.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void setOpen() {
    if (widget.idOpened == null || widget.idOpened != widget.id) {
      widget.setIdOpened(widget.id);
    } else if (widget.id == widget.idOpened) {
      widget.setIdOpened(null);
    }
  }

  bool isOpen() => widget.idOpened == null || widget.idOpened != widget.id ? false : true;

  @override
  void initState() {
    super.initState();
    firstnameController.text = widget.firstname ?? "";
    lastnameController.text = widget.lastname ?? "";
    phoneNumberController.text = widget.phoneNumber ?? "";
    selectedBarangay = widget.address ?? "";
    dateOfBirth = DateTime.parse(widget.dateOfBirth!);
  }

  @override
  void dispose() {
    super.dispose();
    firstnameController.dispose();
    lastnameController.dispose();
    phoneNumberController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ProfileMenuItem(
      onTap: setOpen,
      isOpen: isOpen(),
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
          // CustomInput.text(
          //     context: context,
          //     controller: addressController,
          //     label: "Address",
          //     hint: "e.g., 123 Rizal St., Brgy. San Isidro, Makati City, Metro Manila, 1230"),
          BarangaySelector(onChange: handleBarangaySelection, value: selectedBarangay),
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            CustomButton(
              onPress: () async {
                await handleSave();
              },
              isLoading: isLoading,
              radius: 3,
              label: "Save",
            ),
          ])
        ],
      ),
    );
  }
}
