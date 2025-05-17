import 'package:flutter/material.dart';
import 'package:smartguide_app/components/input/custom_input.dart';

class MultiDataInput extends StatelessWidget {
  const MultiDataInput(
      {super.key,
      required this.context,
      required this.title,
      required this.controllers,
      required this.handleAddController,
      required this.handleRemoveController});

  final BuildContext context;
  final String title;
  final List<Map<String, TextEditingController>> controllers;
  final VoidCallback handleAddController;
  final Function(int i) handleRemoveController;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8 * 2),
          border: Border.all(color: Colors.black.withValues(alpha: controllers.isEmpty ? 0 : 0.3))),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 4 * 4,
                ),
              ),
              IconButton(
                  onPressed: handleAddController,
                  icon: Icon(
                    Icons.add_rounded,
                    color: Colors.black.withValues(alpha: 0.5),
                  ))
            ],
          ),
          ...controllers.toList().asMap().entries.map((entry) {
            final index = entry.key; // Current index
            final l = entry.value; // Current lab controller

            return Column(
              spacing: 8,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: CustomInput.text(
                        context: context,
                        label: "Name",
                        hint: "(N/A) if none",
                        controller: l['name'],
                        validator: (p0) {
                          if (p0 == null || p0.isEmpty) return "This is required!";
                          return null;
                        },
                      ),
                    ),
                    IconButton(
                      onPressed: () => handleRemoveController(index),
                      icon: Icon(
                        Icons.remove_rounded,
                        color: Colors.black.withValues(alpha: 0.5),
                      ),
                    ),
                  ],
                ),
                if (l['description'] != null)
                  CustomInput.text(
                    context: context,
                    label: "Description",
                    hint: "(N/A) if none",
                    maxLines: 3,
                    controller: l['description'],
                    textInputType: TextInputType.multiline,
                  ),
                SizedBox(
                  height: controllers.isEmpty ? 0 : 8,
                ),
              ],
            );
          }),
        ],
      ),
    );
  }
}
