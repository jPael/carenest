import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:smartguide_app/models/person.dart';
import 'package:smartguide_app/models/user.dart';
import 'package:smartguide_app/pages/midwife/prenatal_records/patients_history_list_page.dart';

class MidwifePrenatalRecordsItems extends StatelessWidget {
  const MidwifePrenatalRecordsItems({
    super.key,
    this.mother,
  });

  final Person? mother;

  final double profileImageSize = 60.0;
  @override
  Widget build(BuildContext context) {
    final User user = context.read<User>();

    String fullname = "Default name";
    DateTime date = DateTime.now();

    if (mother != null) {
      fullname = mother!.name!;
    }

    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PatientsHistoryListPage(
                    person: mother!,
                  ))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  // spacing: MediaQuery.of(context).size.width / 4,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      fullname,
                      style: const TextStyle(fontSize: 8 * 3, fontWeight: FontWeight.w500),
                    ),
                    Text(mother?.address ?? user.address ?? "")
                  ],
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
            ),
          )
        ],
      ),
    );
  }
}
