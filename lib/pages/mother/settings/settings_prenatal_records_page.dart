import 'package:flutter/material.dart';
import 'package:smartguide_app/components/prenatal_records/form/prenatal_info_form.dart';

class SettingsPrenatalRecordsPage extends StatefulWidget {
  const SettingsPrenatalRecordsPage({super.key});

  @override
  State<SettingsPrenatalRecordsPage> createState() => _SettingsPrenatalRecordsPageState();
}

class _SettingsPrenatalRecordsPageState extends State<SettingsPrenatalRecordsPage>
    with TickerProviderStateMixin {
  // final List<String> tabs = ["Care and Tests", "Birth Plan", "After Care", "Counseling"];

  // final List<Widget> tabViews = [CareAndTests(), BirthPlan(), AfterCare(), Counseling()];

  // late final TabController tabController;

  @override
  void initState() {
    super.initState();
    // tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  void dispose() {
    // tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Prenatal Record"),
          centerTitle: true,
        ),
        body: const PrenatalInfoForm(
          readonly: true,
        ));
  }
}
