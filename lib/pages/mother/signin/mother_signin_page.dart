import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:smartguide_app/components/alert/alert.dart';
import 'package:smartguide_app/components/button/custom_button.dart';
import 'package:smartguide_app/components/form/custom_form.dart';
import 'package:smartguide_app/components/input/custom_input.dart';
import 'package:smartguide_app/pages/auth/auth_page.dart';
import 'package:smartguide_app/services/auth_services.dart';

class MotherSigninPage extends StatefulWidget {
  const MotherSigninPage({super.key});

  @override
  State<MotherSigninPage> createState() => _MotherSigninPageState();
}

class _MotherSigninPageState extends State<MotherSigninPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthServices _auth = AuthServices();

  bool loggingIn = false;

  void handleSignin() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      loggingIn = true;
    });

    final Map<String, dynamic> result =
        await _auth.signIn(emailController.text, passwordController.text);

    if (result['status'] == false) {
      if (kDebugMode) {
        print(result);
      }

      if (!mounted) return;
      showErrorMessage(context: context, message: result["message"]);
    } else {
      if (!mounted) return;
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const AuthPage()),
        (route) => false,
      );
    }

    setState(() {
      loggingIn = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8 * 5),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Welcome back!",
                  style: TextStyle(fontSize: 8 * 6),
                ),
                const SizedBox(
                  height: 8 * 2,
                ),
                Image.asset(
                  "lib/assets/images/mother_signin_hero.png",
                  scale: 1.8,
                ),
                const SizedBox(
                  height: 8 * 3,
                ),
                Form(
                    key: formKey,
                    child: CustomForm(
                      actionMainAxisAlignment: MainAxisAlignment.center,
                      actions: [
                        Expanded(
                            child: CustomButton.large(
                                isLoading: loggingIn,
                                context: context,
                                label: "Sign in",
                                onPressed: handleSignin)),
                      ],
                      children: [
                        CustomInput.text(
                            context: context,
                            controller: emailController,
                            label: "Email",
                            validator: (v) {
                              if (v == null || v.isEmpty) {
                                return "Email is required";
                              }

                              return null;
                            },
                            startIcon: const Icon(Icons.email_outlined)),
                        const SizedBox(
                          height: 8 * 2,
                        ),
                        CustomInput.password(
                          context: context,
                          controller: passwordController,
                          label: "Password",
                          startIcon: const Icon(Icons.password_outlined),
                          validator: (v) {
                            if (v == null || v.isEmpty) {
                              return "Password is required";
                            }
                            return null;
                          },
                        ),
                      ],
                    )),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.end,
                //   children: [
                //     CustomButton.link(context: context, label: "Forgot password", onPressed: () {}),
                //     const SizedBox(
                //       height: 8 * 2,
                //     ),
                //   ],
                // ),
                const SizedBox(
                  height: 8 * 3,
                ),
                const SizedBox(
                  height: 8 * 2,
                ),
                // CustomButton.social(
                //   context: context,
                //   label: "Sign in with Google",
                //   onPressed: () {},
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
