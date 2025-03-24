import 'package:flutter/material.dart';
import 'package:smartguide_app/components/button/custom_button.dart';
import 'package:smartguide_app/pages/mother/welcome_page.dart' as mother;
import 'package:smartguide_app/pages/midwife/welcome_page.dart' as midwife;

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
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
            body: SafeArea(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 8 * 8, right: 8 * 5),
                    padding: const EdgeInsets.symmetric(vertical: 8 * 8, horizontal: 8 * 8),
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(8 * 15),
                            bottomRight: Radius.circular(8 * 15))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Text(
                            textAlign: TextAlign.center,
                            "Welcome to CareNest!",
                            style: TextStyle(
                                fontSize: 8 * 6, color: Colors.white, fontWeight: FontWeight.w500),
                            softWrap: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 8 * 4,
                  ),
                  Text(
                    "Please select your role to get Started",
                    style: TextStyle(fontSize: 8 * 2.5, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 8 * 4,
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
                          onPressed: () => Navigator.push(context,
                              MaterialPageRoute(builder: (context) => midwife.WelcomePage()))),
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
                          onPressed: () => Navigator.push(context,
                              MaterialPageRoute(builder: (context) => mother.WelcomePage())))
                    ],
                  )
                ],
              ),
            ))
      ],
    );
  }
}
