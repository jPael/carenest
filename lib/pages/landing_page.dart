import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auto_size_text/flutter_auto_size_text.dart';
import 'package:smartguide_app/components/alert/alert.dart';
import 'package:smartguide_app/components/button/custom_button.dart';
import 'package:smartguide_app/components/form/custom_form.dart';
import 'package:smartguide_app/components/input/custom_input.dart';
import 'package:smartguide_app/error/app_error.dart';
import 'package:smartguide_app/pages/auth/auth_page.dart';
import 'package:smartguide_app/pages/onboarding/user_type_selection_page.dart';
import 'package:smartguide_app/services/auth_services.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
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
      Alert.showErrorMessage(message: errorMessage(result["message"]));
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
  Widget build(BuildContext context) {
    precacheImage(const AssetImage("lib/assets/images/landingpage_bg.png"), context);
    precacheImage(const AssetImage("lib/assets/images/landingpage_choice_midwife.png"), context);
    precacheImage(const AssetImage("lib/assets/images/landingpage_choice_mother.png"), context);

    return Stack(
      children: [
        Image.asset(
          "lib/assets/images/landingpage_bg.png",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 8 * 8, right: 8 * 5),
                    padding: const EdgeInsets.symmetric(vertical: 8 * 8, horizontal: 8 * 8),
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(8 * 15),
                            bottomRight: Radius.circular(8 * 15))),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                            child: AutoSizeText(
                          textAlign: TextAlign.center,
                          "Welcome to MEDICARE!",
                          style: TextStyle(
                              fontSize: 4 * 10, color: Colors.white, fontWeight: FontWeight.w500),
                          softWrap: true,
                          maxLines: 2,
                        )),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 8 * 4,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8 * 5),
                    child: Form(
                      key: formKey,
                      child: CustomForm(
                        actionMainAxisAlignment: MainAxisAlignment.center,
                        actions: [
                          Expanded(
                            child: CustomButton(
                              label: "Sign in",
                              onPress: handleSignin,
                              isLoading: loggingIn,
                            ),
                          )
                        ],
                        children: [
                          CustomInput.text(
                            controller: emailController,
                            context: context,
                            label: "Email",
                            validator: (v) {
                              if (v == null || v.isEmpty) {
                                return "Email is required";
                              }

                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 8 * 2,
                          ),
                          CustomInput.password(
                              controller: passwordController,
                              context: context,
                              label: "Password",
                              validator: (v) {
                                if (v == null || v.isEmpty) {
                                  return "Password is required";
                                }
                                return null;
                              }),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 8 * 15,
                  ),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account?",
                        style: TextStyle(
                          fontSize: 4 * 4,
                        ),
                      ),
                      const SizedBox(
                        width: 4 * 4,
                      ),
                      CustomButton(
                        label: "Create an account",
                        onPress: () => Navigator.push(context,
                            MaterialPageRoute(builder: (context) => const UserTypeSelectionPage())),
                        buttonStyle: ButtonStyle(
                            elevation: WidgetStateProperty.all(loggingIn ? 0 : null),
                            iconColor: WidgetStateProperty.all(Colors.white),
                            shape: WidgetStateProperty.all(RoundedRectangleBorder(
                                side: const BorderSide(width: 4, color: Colors.white),
                                borderRadius: BorderRadius.circular(8.0 * 3))),
                            padding: WidgetStateProperty.all(
                                const EdgeInsets.symmetric(horizontal: 8.0 * 4, vertical: 8.0 * 2)),
                            backgroundColor: WidgetStateProperty.all(
                                HSLColor.fromColor(Theme.of(context).colorScheme.primary)
                                    .withSaturation(loggingIn ? 0.5 : 1)
                                    .toColor())),
                      )
                    ],
                  )
                  // Text(
                  //   "Please select your role to get Started",
                  //   style: TextStyle(
                  //       fontSize: 8 * 2.5, fontWeight: FontWeight.w500),
                  // ),
                  // const SizedBox(
                  //   height: 8 * 4,
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     CustomButton.image(
                  //         context: context,
                  //         content: Image.asset(
                  //           "lib/assets/images/landingpage_choice_midwife.png",
                  //           scale: 2,
                  //         ),
                  //         label: "Midwife",
                  //         onPressed: () => Navigator.push(
                  //             context,
                  //             MaterialPageRoute(
                  //                 builder: (context) =>
                  //                     midwife.WelcomePage()))),
                  //     const SizedBox(
                  //       width: 8 * 2,
                  //     ),
                  //     CustomButton.image(
                  //         context: context,
                  //         content: Image.asset(
                  //           "lib/assets/images/landingpage_choice_mother.png",
                  //           scale: 2,
                  //         ),
                  //         label: "Mother",
                  //         onPressed: () => Navigator.push(
                  //             context,
                  //             MaterialPageRoute(
                  //                 builder: (context) => mother.WelcomePage())))
                  //   ],
                  // )
                ],
              ),
            ))
      ],
    );
  }
}
