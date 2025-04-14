import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartguide_app/components/alert/alert.dart';
import 'package:smartguide_app/components/button/custom_button.dart';
import 'package:smartguide_app/components/input/custom_input.dart';
import 'package:smartguide_app/components/mother/profile/profile_menu_item.dart';
import 'package:smartguide_app/components/password_strength_checklist/password_strength_checklist.dart';
import 'package:smartguide_app/models/user.dart' as current_user;

class ProfileAccountInformationItem extends StatefulWidget {
  const ProfileAccountInformationItem(
      {super.key, this.email, required this.id, this.idOpened, required this.setIdOpened});

  final int id;
  final int? idOpened;
  final Function(int? i) setIdOpened;
  final String? email;

  @override
  State<ProfileAccountInformationItem> createState() => _ProfileAccountInformationItemState();
}

class _ProfileAccountInformationItemState extends State<ProfileAccountInformationItem> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  late User? user;

  void setOpen() {
    if (widget.idOpened == null || widget.idOpened != widget.id) {
      widget.setIdOpened(widget.id);
    } else if (widget.id == widget.idOpened) {
      widget.setIdOpened(null);
    }
  }

  bool isOpen() => widget.idOpened == null || widget.idOpened != widget.id ? false : true;

  bool isLoading = false;

  void handleSave() async {
    try {
      setState(() {
        isLoading = true;
      });

      await Future.delayed(const Duration(seconds: 5));

      if (!mounted) return;

      String result = await context
          .read<current_user.User>()
          .setAccountInformation(emailController.text, passwordController.text);

      if (!mounted) return;

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

  @override
  void initState() {
    super.initState();
    emailController.text = widget.email ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return ProfileMenuItem(
      onTap: setOpen,
      isOpen: isOpen(),
      startIcon: const Icon(Icons.security),
      title: "Account Information",
      form: Column(
        spacing: 8,
        children: [
          CustomInput.text(context: context, controller: emailController, label: "Email", hint: "e.g. example@email.com"),
          CustomInput.text(
            context: context,
            controller: passwordController,
            label: "Password",
          ),
          CustomInput.text(
            context: context,
            controller: confirmPasswordController,
            label: "Password",
          ),
          PasswordStrengthChecklist(password: passwordController, confirmPassword: confirmPasswordController, onChange: (_) {}),
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            CustomButton(
              onPress: handleSave,
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
