import 'package:flutter/material.dart';

class TestItem extends StatelessWidget {
  const TestItem({super.key, required this.label, this.value, this.unit, this.description});

  final String label;
  final String? value;
  final String? unit;
  final String? description;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Flexible(
              child: RichText(
                textAlign: TextAlign.start,
                text: TextSpan(
                  style: const TextStyle(color: Colors.black, fontSize: 4 * 4, height: 1.5),
                  children: [
                    TextSpan(
                      text: "$label: ",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: "${value ?? "None"} ${unit ?? ""}",
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        if (description != null)
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 4.0),
            child: Text(
              description!,
              style: const TextStyle(fontSize: 4 * 4),
              textAlign: TextAlign.start,
            ),
          ),
      ],
    );
  }
}
