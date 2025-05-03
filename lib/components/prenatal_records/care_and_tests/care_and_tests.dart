import 'package:flutter/material.dart';
import 'package:smartguide_app/components/prenatal_records/care_and_tests/care_and_tests_group.dart';
import 'package:smartguide_app/models/care_and_test.dart';
import 'package:smartguide_app/models/trimester.dart';

class CareAndTests extends StatefulWidget {
  const CareAndTests({super.key, required this.trimesters});

  // final List<Map<String,dynamic>
  final List<CareAndTest> trimesters;

  @override
  State<CareAndTests> createState() => _CareAndTestsState();
}

class _CareAndTestsState extends State<CareAndTests> with TickerProviderStateMixin {
  late final List<String> tabs;

  late final TabController tabController;

  @override
  void initState() {
    super.initState();
    tabs = widget.trimesters
        .map(
          (e) => e.trimester?.label ?? "NA",
        )
        .toList();
    tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: TabBar(
            tabs: tabs.map((t) => Text(t)).toList(),
            tabAlignment: TabAlignment.start,
            isScrollable: true,
            controller: tabController,
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2 * 8.0),
            child: TabBarView(
              controller: tabController,
              children: tabs.asMap().entries.map((entry) {
                final index = entry.key;
                final tabTitle = entry.value;
                return CareAndTestsGroup(
                    title: tabTitle,
                    trimester: widget.trimesters[index] // Or your actual trimester logic
                    );
              }).toList(),
            )));
  }
}
