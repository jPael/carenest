import 'package:flutter/material.dart';
import 'package:smartguide_app/models/person.dart';
import 'package:smartguide_app/services/laravel/mother_services.dart';

class MotherSelector extends StatefulWidget {
  const MotherSelector({super.key, required this.onChange});

  final Function(int? value) onChange;

  @override
  MotherSelectorState createState() => MotherSelectorState();
}

class MotherSelectorState extends State<MotherSelector> {
  int? defaultValue;
  bool fetchingMothers = false;
  List<Person> persons = [];

  Future<void> _fetchPersons() async {
    setState(() {
      fetchingMothers = true;
    });

    // await Future.delayed(Duration(seconds: 3));
    final List<Person> mothers = await fetchAllMothers();
    // final _barangays = await BarangayServices().fetchALlBarangays();

    setState(() {
      defaultValue = mothers.first.id!;
      widget.onChange(defaultValue);
      persons = mothers;
    });

    setState(() {
      fetchingMothers = false;
    });
  }

  @override
  void initState() {
    super.initState();

    _fetchPersons();
  }

  @override
  Widget build(BuildContext context) {
    return fetchingMothers
        ? const Row(
            spacing: 4 * 2,
            children: [
              SizedBox.square(
                dimension: 4 * 6,
                child: CircularProgressIndicator(),
              ),
              Text("Fetching mothers...")
            ],
          )
        : DropdownButtonFormField(
            menuMaxHeight: MediaQuery.of(context).size.height * 0.6,
            decoration: InputDecoration(
              labelText: "Mother",
              hintText: "Select your mother",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8 * 2),
              ),
            ),
            value: defaultValue,
            onChanged: (value) {
              widget.onChange(value as int);
              setState(() {
                defaultValue = value;
              });
            },
            items: persons.map((b) => DropdownMenuItem(value: b.id, child: Text(b.name!))).toList(),
            validator: (value) {
              if (value == null) {
                return "Please select your mother";
              }
              return null;
            },
          );
  }
}
