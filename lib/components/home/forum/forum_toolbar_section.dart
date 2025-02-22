import 'package:flutter/material.dart';
import 'package:smartguide_app/components/input/custom_input.dart';

class ForumToolbarSection extends StatefulWidget {
  const ForumToolbarSection({super.key});

  @override
  State<ForumToolbarSection> createState() => _ForumToolbarSectionState();
}

class _ForumToolbarSectionState extends State<ForumToolbarSection> {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: CustomInput.text(
              context: context,
              controller: searchController,
              label: "Search",
              startIcon: Icon(Icons.search_rounded)),
        ),
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.more_vert_rounded,
              size: 8 * 4,
            ))
      ],
    );
  }
}
