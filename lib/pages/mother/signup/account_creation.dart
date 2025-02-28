import 'package:flutter/material.dart';
import 'package:smartguide_app/components/button/custom_button.dart';
import 'package:smartguide_app/components/input/custom_input.dart';
import 'package:smartguide_app/components/form/custom_form.dart';
import 'package:smartguide_app/components/password_strength_checklist/password_strength_checklist.dart';
import 'package:smartguide_app/pages/mother/signin/mother_signin_page.dart';

class AccountCreation extends StatefulWidget {
  const AccountCreation({super.key});

  @override
  AccountCreationState createState() => AccountCreationState();
}

class AccountCreationState extends State<AccountCreation> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

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
                    onPress: () => Navigator.push(
                        context, MaterialPageRoute(builder: (context) => MotherSigninPage())),
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
                      controller: emailController,
                      startIcon: Icon(Icons.email_outlined),
                      label: "Email",
                      hint: "e.g. example@email.com"),
                  const SizedBox(
                    height: 8 * 2,
                  ),
                  CustomInput.password(
                      context: context,
                      controller: passwordController,
                      startIcon: Icon(Icons.password_outlined),
                      label: "Password",
                      hint: "******"),
                  const SizedBox(
                    height: 8 * 2,
                  ),
                  CustomInput.password(
                      context: context,
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
                      onChange: (bool something) {})
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
