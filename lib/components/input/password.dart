import 'package:flutter/material.dart';

class Password extends StatefulWidget {
  const Password({
    super.key,
    required this.controller,
    this.label = "",
    this.hint = "",
    this.startIcon,
  });

  final TextEditingController controller;
  final String label;
  final String hint;
  final Icon? startIcon;

  @override
  PasswordState createState() => PasswordState();
}

class PasswordState extends State<Password> {
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: !showPassword,
      decoration: InputDecoration(
          label: Text(widget.label),
          hintText: widget.hint,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8 * 2)),
          prefixIcon: widget.startIcon,
          suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  showPassword = !showPassword;
                });
              },
              icon:
                  Icon(showPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined))),
    );
  }
}
