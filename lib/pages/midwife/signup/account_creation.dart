import 'package:flutter/material.dart';
import 'package:smartguide_app/components/alert/alert.dart';
import 'package:smartguide_app/components/button/custom_button.dart';
import 'package:smartguide_app/components/form/custom_form.dart';
import 'package:smartguide_app/components/input/custom_input.dart';
import 'package:smartguide_app/components/password_strength_checklist/password_strength_checklist.dart';
import 'package:smartguide_app/error/app_error.dart';
import 'package:smartguide_app/models/new_user.dart';
import 'package:smartguide_app/pages/auth/auth_page.dart';

class AccountCreation extends StatefulWidget {
  const AccountCreation(
      {super.key,
      required this.firstname,
      required this.lastname,
      required this.phoneNumber,
      required this.address,
      required this.dateOfBirth});

  final String firstname;
  final String lastname;
  final String phoneNumber;
  final String address;
  final DateTime dateOfBirth;

  @override
  AccountCreationState createState() => AccountCreationState();
}

class AccountCreationState extends State<AccountCreation> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  bool isLoading = false;
  bool isPasswordStrongEnough = false;

  void createAccount() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      // await Future.delayed(const Duration(seconds: 3));

      final NewUser user = NewUser(
          type: UserType.midwife,
          firstname: widget.firstname,
          lastname: widget.lastname,
          address: widget.address,
          phoneNumber: widget.phoneNumber,
          dateOfBirth: widget.dateOfBirth,
          email: emailController.text,
          password: passwordController.text);

      Map<String, String> result = await user.createAccount();

      if (result["error"] != null) {
        if (mounted) {
          showErrorMessage(context: context, message: errorMessage(result["error"]!));
        }

        setState(() {
          isLoading = false;
        });
        return;
      }

      if (!mounted) return;
      showSuccessMessage(context: context, message: errorMessage(result["success"]!));
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => AuthPage()),
        (route) => false,
      );

      setState(() {
        isLoading = false;
      });
    }
  }

  void handlePasswordChecker(bool b) {
    setState(() {
      isPasswordStrongEnough = b;
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
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                        child: Text(
                      "Create your account",
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
                  label: "Account information",
                  actions: [
                    CustomButton(
                        label: "Create account",
                        icon: Icon(Icons.arrow_forward_outlined),
                        isLoading: isLoading,
                        onPress: createAccount)
                  ],
                  children: [
                    CustomInput.text(
                        context: context,
                        validator: (v) {
                          if (v == null || v.isEmpty) {
                            return "Please enter your email";
                          }
                          final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                          if (!emailRegex.hasMatch(v)) {
                            return "Please enter a valid email address";
                          }
                          return null;
                        },
                        controller: emailController,
                        startIcon: Icon(Icons.email_outlined),
                        label: "Email",
                        hint: "e.g. example@email.com"),
                    const SizedBox(
                      height: 8 * 2,
                    ),
                    CustomInput.password(
                        context: context,
                        validator: (v) {
                          if (v == null || v.isEmpty) {
                            return "Please enter your password";
                          }

                          if (!isPasswordStrongEnough) {
                            return "Please ensure your password meets the required strength criteria";
                          }

                          return null;
                        },
                        controller: passwordController,
                        startIcon: Icon(Icons.password_outlined),
                        label: "Password",
                        hint: "******"),
                    const SizedBox(
                      height: 8 * 2,
                    ),
                    CustomInput.password(
                        context: context,
                        validator: (v) {
                          if (v == null || v.isEmpty) {
                            return "Please confirm your password";
                          }
                          if (!isPasswordStrongEnough) {
                            return "Please ensure your password meets the required strength criteria";
                          }
                          return null;
                        },
                        controller: confirmPasswordController,
                        startIcon: Icon(Icons.password_outlined),
                        label: "Confirm password",
                        hint: "******"),
                    const SizedBox(
                      height: 8 * 2,
                    ),
                    PasswordStrengthChecklist(
                        password: passwordController,
                        confirmPassword: confirmPasswordController,
                        onChange: handlePasswordChecker)
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
