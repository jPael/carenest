import 'package:flutter/material.dart';
import 'package:smartguide_app/components/input/custom_input.dart';

class MidwifePrenatalRecordsSearchBar extends StatelessWidget {
  MidwifePrenatalRecordsSearchBar({super.key});

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
