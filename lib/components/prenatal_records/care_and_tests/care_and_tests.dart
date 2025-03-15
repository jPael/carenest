import 'package:flutter/material.dart';
import 'package:smartguide_app/components/prenatal_records/care_and_tests/care_and_tests_group.dart';

class CareAndTests extends StatefulWidget {
  const CareAndTests({super.key});

  @override
  State<CareAndTests> createState() => _CareAndTestsState();
}

class _CareAndTestsState extends State<CareAndTests> with TickerProviderStateMixin {
  final tabs = [
    "First Trimester",
    "Second Trimester",
    "Third Trimester",
  ];

  late final TabController tabController;

  @override
  void initState() {
    super.initState();
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
            children: tabs.map((t) => CareAndTestsGroup(title: t)).toList()),
      ),
    );
  }
}
