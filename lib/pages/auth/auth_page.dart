import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartguide_app/fields/user_fields.dart';
import 'package:smartguide_app/models/new_user.dart';
import 'package:smartguide_app/models/user.dart' as current_user;
import 'package:smartguide_app/pages/landing_page.dart';
import 'package:smartguide_app/pages/midwife/home/home_layout_page.dart' as midwife;
import 'package:smartguide_app/pages/mother/home/home_layout_page.dart' as mother;
import 'package:smartguide_app/pages/onboarding/waiting_verification_page.dart';
import 'package:smartguide_app/services/user_services.dart';
import 'package:smartguide_app/utils/utils.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        final user = snapshot.data;

        if (user == null) {
          return const LandingPage();
        }

        return FutureBuilder<Map<String, dynamic>?>(
          future: getUserByUID(user.uid),
          builder: (context, userSnapshot) {
            if (userSnapshot.connectionState == ConnectionState.waiting) {
              return _loadingScreen();
            } else if (userSnapshot.hasError) {
              return Center(
                child: Text("Error: ${userSnapshot.error}"),
              );
            } else if (userSnapshot.hasData) {
              final data = userSnapshot.data!;

              if (data[UserFields.isVerified]) {
                // log(data.toString());
                final UserTypeEnum role = getUserEnumFromUserTypeString(data[UserFields.userType]);
                log(data[UserFields.token].toString());

                WidgetsBinding.instance.addPostFrameCallback((_) {
                  context.read<current_user.User>().setUser(data);
                });

                return role == UserTypeEnum.mother
                    ? const mother.HomeLayoutPage()
                    : const midwife.HomeLayoutPage();
              } else {
                return WaitingVerificationPage(
                    fullname: "${data[UserFields.firstname]} ${data[UserFields.lastname]}");
              }
            } else {
              return const LandingPage();
            }
          },
        );
      },
    );
  }

  Widget _loadingScreen() {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "CareNest",
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            Text(
              "Please wait...",
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 8),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
