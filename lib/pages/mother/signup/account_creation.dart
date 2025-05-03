import 'package:flutter/material.dart';
import 'package:flutter_auto_size_text/flutter_auto_size_text.dart';
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
      required this.barangayId,
      required this.dateOfBirth,
      required this.firebaseAddress});

  final String firstname;
  final String lastname;
  final String phoneNumber;
  final String barangayId;
  final String firebaseAddress;
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
          type: UserTypeEnum.mother,
          firstname: widget.firstname,
          lastname: widget.lastname,
          barangayId: widget.barangayId,
          firebaseBarangay: widget.firebaseAddress,
          phoneNumber: widget.phoneNumber,
          dateOfBirth: widget.dateOfBirth,
          email: emailController.text,
          password: passwordController.text);

      Map<String, String> result = await user.createAccount();

      if (result["error"] != null) {
        if (mounted) {
          Alert.showErrorMessage(message: errorMessage(result["error"]!));
        }

        setState(() {
          isLoading = false;
        });
        return;
      }

      if (!mounted) return;
      Alert.showSuccessMessage(message: errorMessage(result["success"]!));
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const AuthPage()),
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
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    precacheImage(const AssetImage("lib/assets/images/mothers_registration_hero.png"), context);
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
                        child: AutoSizeText(
                      "Create your account",
                      style: TextStyle(fontSize: 8 * 5, fontWeight: FontWeight.w500),
                      softWrap: true,
                      maxLines: 2,
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
                        icon: const Icon(Icons.arrow_forward_outlined),
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
                        startIcon: const Icon(Icons.email_outlined),
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
                        startIcon: const Icon(Icons.password_outlined),
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
                        startIcon: const Icon(Icons.password_outlined),
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
