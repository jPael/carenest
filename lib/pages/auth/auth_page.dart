import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartguide_app/fields/user_fields.dart';
import 'package:smartguide_app/models/new_user.dart';
import 'package:smartguide_app/pages/landing_page.dart';
import 'package:smartguide_app/pages/mother/home/home_layout_page.dart' as mother;
import 'package:smartguide_app/pages/midwife/home/home_layout_page.dart' as midwife;
import 'package:smartguide_app/services/user_services.dart';
import 'package:smartguide_app/utils/utils.dart';
import 'package:smartguide_app/models/user.dart' as currentUser;

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
        if (snapshot.hasData) {
          final String email = snapshot.data!.email!;

          return FutureBuilder(
              future: getUserByEmail(email),
              builder: (context, userSnapshot) {
                if (userSnapshot.hasData) {
                  final data = userSnapshot.data;
                  final UserType role = getEnumUserType(data![UserFields.userType]);

                  context.read<currentUser.User>().setUser(data);

                  switch (role) {
                    case UserType.mother:
                      return mother.HomeLayoutPage();

                    case UserType.midwife:
                      return midwife.HomeLayoutPage();
                  }
                } else if (userSnapshot.hasError) {
                  return Center(
                    child: Text("Error: ${userSnapshot.error}"),
                  );
                } else {
                  return LandingPage();
                }
              });
        } else {
          return const LandingPage();
        }
      },
    );
  }
}
