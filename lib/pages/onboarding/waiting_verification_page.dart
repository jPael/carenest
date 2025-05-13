import 'package:flutter/material.dart';

class WaitingVerificationPage extends StatelessWidget {
  const WaitingVerificationPage({super.key, required this.fullname});

  final String fullname;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10 * 8.0, horizontal: 5 * 8.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "MEDICARE",
                style: TextStyle(fontSize: 8 * 4, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 8 * 4,
              ),
              Image.asset("lib/assets/images/waiting_for_verification.png"),
              const Text(
                textAlign: TextAlign.center,
                "Waiting for verification",
                style: TextStyle(fontSize: 8 * 4),
              ),
              const SizedBox(
                height: 8 * 4,
              ),
              Text(
                textAlign: TextAlign.center,
                "Hi $fullname, please wait while we verify your account. Come back again for a few hours",
                style: const TextStyle(fontSize: 4 * 6),
              ),
              const Spacer(),
              Card(
                color:
                    HSLColor.fromColor(Colors.red).withSaturation(0.3).withLightness(0.9).toColor(),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8 * 2),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.info,
                        color: Colors.red,
                      ),
                      Flexible(
                        child: Text(
                          textAlign: TextAlign.center,
                          "If it takes longer than it should you can come back to the clinic to report the problem",
                          style: TextStyle(fontSize: 4 * 4),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
