import 'package:flutter/material.dart';
import 'package:smartguide_app/components/input/custom_input.dart';
import 'package:smartguide_app/models/person.dart';
import 'package:smartguide_app/pages/mother/signup/mother_registration.dart';

class MidwifePrenatalRecordsSearchBar extends StatefulWidget {
  const MidwifePrenatalRecordsSearchBar(
      {super.key, required this.mothers, required this.onMothersChange});
  final List<Person> mothers;
  final Function(List<Person>) onMothersChange;
  @override
  State<MidwifePrenatalRecordsSearchBar> createState() => _MidwifePrenatalRecordsSearchBarState();
}

class _MidwifePrenatalRecordsSearchBarState extends State<MidwifePrenatalRecordsSearchBar> {
  final TextEditingController searchController = TextEditingController();

  void handleSearchFilter() {
    if (searchController.text.isEmpty) {
      widget.onMothersChange(widget.mothers);
    }

    final String text = searchController.text;

    final List<Person> filtered = widget.mothers.where((p) {
      return p.name!.toLowerCase().contains(text.toLowerCase());
    }).toList();

    widget.onMothersChange(filtered);
  }

  @override
  void initState() {
    super.initState();
    searchController.addListener(handleSearchFilter);
  }

  @override
  void dispose() {
    super.dispose();
    searchController.removeListener(handleSearchFilter);
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: CustomInput.text(
              context: context,
              maxLines: 1,
              minLines: 1,
              controller: searchController,
              label: "Search",
              startIcon: const Icon(Icons.search_rounded),
            ),
          ),
          // IconButton(
          //     onPressed: () {},
          //     icon: Icon(
          //       Icons.more_vert_rounded,
          //       size: 8 * 4,
          //     ))
        ],
      ),
    );
  }
}
