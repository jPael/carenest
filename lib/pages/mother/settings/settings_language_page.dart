import 'package:flutter/material.dart';
import 'package:smartguide_app/components/section/custom_section.dart';
import 'package:smartguide_app/components/settings/settings_item.dart';

class SettingsLanguagePage extends StatefulWidget {
  const SettingsLanguagePage({super.key});

  @override
  State<SettingsLanguagePage> createState() => _SettingsLanguagePageState();
}

class _SettingsLanguagePageState extends State<SettingsLanguagePage> {
  int selected = 2;

  void handleSelectedLanguage(int i) {
    setState(() {
      selected = i;
    });
  }

  Future<void> showAlert(String language, int id) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: Text("Change language to $language?"),
              actions: [
                TextButton(onPressed: () => Navigator.pop(context), child: const Text("No")),
                TextButton(
                    onPressed: () async {
                      if (!mounted) return;
                      handleSelectedLanguage(id);
                      Navigator.pop(context);
                    },
                    child: const Text("Yes"))
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Change Language"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0 * 2),
        child: CustomSection(
          children: [
            SettingsItem(
                isSelected: selected == 1,
                title: "Filipino",
                onTap: () => showAlert("Filipino", 1)),
            SettingsItem(
                isSelected: selected == 2, title: "English", onTap: () => showAlert("English", 2)),
          ],
        ),
      ),
    );
  }
}
