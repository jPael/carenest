import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smartguide_app/models/prenatal.dart';
import 'package:smartguide_app/pages/midwife/prenatal_records/patients_history_list_page.dart';

class MidwifePrenatalRecordsItems extends StatelessWidget {
  const MidwifePrenatalRecordsItems({
    super.key,
    this.prenatal,
  });

  final Prenatal? prenatal;

  final double profileImageSize = 60.0;
  @override
  Widget build(BuildContext context) {
    String fullname = "Default name";
    DateTime date = DateTime.now();

    if (prenatal != null) {
      fullname = prenatal!.fullname;
      date = prenatal!.createdAt!;
    }

    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PatientsHistoryListPage(
                    fullname: fullname,
                    id: prenatal!.laravelId,
                  ))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: profileImageSize,
            width: profileImageSize,
            decoration: const BoxDecoration(
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
                fullname,
                style: const TextStyle(fontSize: 8 * 3, fontWeight: FontWeight.w500),
              ),
              Row(
                children: [
                  const Text(
                    "Last visit: ",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  Text(DateFormat("MMMM dd, yyyy").format(date)),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
