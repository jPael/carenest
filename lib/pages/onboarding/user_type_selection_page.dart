import 'package:flutter/material.dart';
import 'package:smartguide_app/components/button/custom_button.dart';
import 'package:smartguide_app/pages/midwife/signup/midwife_registration.dart' as midwife;
import 'package:smartguide_app/pages/mother/signup/mother_registration.dart' as mother;

class UserTypeSelectionPage extends StatelessWidget {
  const UserTypeSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    precacheImage(const AssetImage("lib/assets/images/landingpage_choice_midwife.png"), context);
    precacheImage(const AssetImage("lib/assets/images/landingpage_choice_mother.png"), context);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          forceMaterialTransparency: true,
        ),
        body: Padding(
          padding: const EdgeInsets.only(bottom: 8.0 * 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Let's get started by selecting your role",
                style: TextStyle(fontSize: 8 * 2.5, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 8 * 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton.image(
                      context: context,
                      content: Image.asset(
                        "lib/assets/images/landingpage_choice_midwife.png",
                        scale: 2,
                      ),
                      label: "Midwife",
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const midwife.MidwifeRegistration())),
                      textStyle: const TextStyle(fontSize: 8 * 3, fontWeight: FontWeight.w500)),
                  const SizedBox(
                    width: 8 * 2,
                  ),
                  CustomButton.image(
                      context: context,
                      content: Image.asset(
                        "lib/assets/images/landingpage_choice_mother.png",
                        scale: 2,
                      ),
                      label: "Mother",
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const mother.MotherRegistration())),
                      textStyle: const TextStyle(
                        fontSize: 8 * 3,
                        fontWeight: FontWeight.w500,
                      ))
                ],
              )
            ],
          ),
        ));
  }
}
