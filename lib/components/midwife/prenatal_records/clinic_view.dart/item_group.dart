import 'package:flutter/material.dart';

class ItemGroup extends StatelessWidget {
  const ItemGroup({super.key, required this.title, required this.data, this.description});

  final String title;
  final List<String> data;
  final List<String>? description;

  @override
  Widget build(BuildContext context) {
    List<List<String?>> combinedData = [];

    // log(title);
    // log(description.toString());
    // log((description == null).toString());
    for (int i = 0; i < data.length; i++) {
      try {
        if (description == null) {
          combinedData.add([data[i], null]);
          continue;
        }
        combinedData.add([data[i], description![i]]);
      } catch (_) {
        combinedData.add([data[i], null]);
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        Text(
          "$title: ",
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 4 * 5),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            spacing: 4,
            children: combinedData.isEmpty
                ? [
                    const Row(
                      children: [
                        Text("None"),
                      ],
                    )
                  ]
                : combinedData
                    .map((l) => Column(
                          children: [
                            Row(
                              spacing: 8,
                              children: [
                                const Icon(
                                  Icons.circle,
                                  size: 4 * 2,
                                ),
                                Flexible(
                                  child: Text(
                                    l[0]!,
                                    style: const TextStyle(
                                        fontSize: 4 * 4, fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                            if (l[1] != null && l[1]!.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(left: 4 * 4),
                                child: Row(
                                  children: [
                                    Flexible(
                                      child: Text(
                                        l[1]!,
                                        style: const TextStyle(fontSize: 4 * 4),
                                      ),
                                    )
                                  ],
                                ),
                              )
                          ],
                        ))
                    .toList(),
          ),
        )
      ],
    );
  }
}
