import 'package:flutter/material.dart';
import 'package:smartguide_app/components/button/custom_button.dart';
import 'package:smartguide_app/components/input/custom_input.dart';
import 'package:smartguide_app/pages/midwife/home/home_layout_page.dart';

class MidwifeSigninPage extends StatelessWidget {
  MidwifeSigninPage({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
                Text(
                  "Welcome back!",
                  style: TextStyle(fontSize: 8 * 6),
                ),
                const SizedBox(
                  height: 8 * 2,
                ),
                Image.asset(
                  "lib/assets/images/midwife_signin_hero.png",
                  scale: 1.8,
                ),
                const SizedBox(
                  height: 8 * 3,
                ),
                CustomInput.text(
                    context: context,
                    controller: emailController,
                    label: "Email",
                    startIcon: Icon(Icons.email_outlined)),
                const SizedBox(
                  height: 8 * 2,
                ),
                CustomInput.password(
                    context: context,
                    controller: passwordController,
                    label: "Password",
                    startIcon: Icon(Icons.password_outlined)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomButton.link(context: context, label: "Forgot password", onPressed: () {}),
                    const SizedBox(
                      height: 8 * 2,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8 * 3,
                ),
                CustomButton.large(
                    context: context,
                    label: "Sign in",
                    onPressed: () => Navigator.push(
                        context, MaterialPageRoute(builder: (context) => HomeLayoutPage()))),
                const SizedBox(
                  height: 8 * 2,
                ),
                CustomButton.social(
                  context: context,
                  label: "Sign in with Google",
                  onPressed: () {},
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
