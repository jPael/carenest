import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:smartguide_app/models/user.dart';
import 'package:smartguide_app/pages/auth/auth_page.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await dotenv.load(fileName: ".env");

  runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => User())], child: const MyApp()));
}

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  final Color primaryColor = const Color(0xFF235ee8);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CareNest',
      theme: ThemeData(
        primaryColor: primaryColor,
        colorScheme: ColorScheme.light(
            primary: primaryColor, secondary: primaryColor.withValues(alpha: 0.8)),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const AuthPage(),
      navigatorKey: navigatorKey,
    );
  }
}
