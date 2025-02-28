import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class PrenatalCareItem extends StatelessWidget {
  const PrenatalCareItem({super.key, required this.description, required this.checked});

  final String description;
  final bool checked;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.black.withValues(alpha: 0.1)))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                description,
                softWrap: true,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.3,
              child: Row(
                children: [
                  Expanded(
                      child: Container(
                    decoration: BoxDecoration(
                        border: Border(
                      right: BorderSide(color: Colors.black.withValues(alpha: 0.1)),
                    )),
                    child: Icon(
                      Ionicons.checkmark_circle,
                      color: Colors.green.withValues(alpha: checked ? 1.0 : 0.0),
                    ),
                  )),
                  Expanded(
                      child: Container(
                          decoration: BoxDecoration(
                              border: Border(
                            left: BorderSide(color: Colors.black.withValues(alpha: 0.1)),
                          )),
                          child: Icon(
                            Ionicons.close_circle,
                            color: Colors.red.withValues(alpha: checked ? 0.0 : 1.0),
                          )))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
