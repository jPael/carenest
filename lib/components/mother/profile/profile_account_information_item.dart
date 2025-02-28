import 'package:flutter/material.dart';
import 'package:smartguide_app/components/button/custom_button.dart';
import 'package:smartguide_app/components/input/custom_input.dart';
import 'package:smartguide_app/components/mother/profile/profile_menu_item.dart';
import 'package:smartguide_app/components/password_strength_checklist/password_strength_checklist.dart';

class ProfileAccountInformationItem extends StatelessWidget {
  ProfileAccountInformationItem({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ProfileMenuItem(
      startIcon: Icon(Icons.security),
      title: "Account Information",
      form: Column(
        spacing: 8,
        children: [
          CustomInput.text(
              context: context,
              controller: emailController,
              label: "Email",
              hint: "e.g. example@email.com"),
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
          PasswordStrengthChecklist(
              password: passwordController,
              confirmPassword: confirmPasswordController,
              onChange: (_) {}),
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
    ;
  }
}
