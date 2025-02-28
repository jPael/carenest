import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MidwifePrenatalRecordsItems extends StatelessWidget {
  const MidwifePrenatalRecordsItems(
      {super.key, required this.user, required this.lastVisit, required this.onTap});

  final String user;
  final DateTime lastVisit;
  final VoidCallback onTap;

  final double profileImageSize = 60.0;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: profileImageSize,
            width: profileImageSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
            clipBehavior: Clip.antiAlias,
            child: OverflowBox(
              child: Image.asset("lib/assets/images/profile_fallback.png"),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user,
                style: TextStyle(fontSize: 8 * 3, fontWeight: FontWeight.w500),
              ),
              Row(
                children: [
                  Text(
                    "Last visit: ",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  Text(DateFormat("MMMM dd, yyyy").format(lastVisit)),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
