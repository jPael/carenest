import 'package:flutter/material.dart';
import 'package:smartguide_app/components/button/custom_button.dart';
import 'package:smartguide_app/pages/mother/signin/mother_signin_page.dart';
import 'package:smartguide_app/pages/mother/signup/mother_registration.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        forceMaterialTransparency: true,
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "Welcome!",
                style: TextStyle(fontSize: 8 * 6),
              ),
              const SizedBox(
                height: 8 * 4,
              ),
              Image.asset(
                "lib/assets/images/mother_welcome_hero.png",
                scale: 1.5,
              ),
              const SizedBox(
                height: 8 * 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8 * 6),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomButton.large(
                        context: context,
                        label: "Get started",
                        onPressed: () => Navigator.push(
                            context, MaterialPageRoute(builder: (context) => MotherSigninPage())),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 8 * 4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "No account yet?",
                    style: TextStyle(fontSize: 8 * 3),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  CustomButton.link(
                      context: context,
                      label: "Sign up",
                      onPressed: () => Navigator.push(context,
                          MaterialPageRoute(builder: (context) => const MotherRegistration())),
                      fontSize: 8 * 3)
                ],
              ),
              const SizedBox(
                height: 8 * 2,
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Expanded(
              //       child: Container(
              //         decoration: BoxDecoration(
              //           border: Border(
              //             bottom: BorderSide(
              //               color: Colors.grey,
              //               width: 1.0,
              //             ),
              //           ),
              //         ),
              //       ),
              //     ),
              //     Padding(
              //       padding: const EdgeInsets.symmetric(horizontal: 8.0),
              //       child: Text("Or"),
              //     ),
              //     Expanded(
              //       child: Container(
              //         decoration: BoxDecoration(
              //           border: Border(
              //             bottom: BorderSide(
              //               color: Colors.grey,
              //               width: 1.0,
              //             ),
              //           ),
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              // const SizedBox(
              //   height: 8 * 2,
              // ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 8.0 * 3),
              //   child: CustomButton.social(
              //       context: context,
              //       label: "Continue with Google",
              //       onPressed: () {},
              //       buttonType: SocialButtonType.google),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
