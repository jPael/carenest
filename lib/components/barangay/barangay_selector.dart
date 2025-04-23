import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:smartguide_app/models/barangay.dart';
import 'package:smartguide_app/services/laravel/barangay_services.dart';

class BarangaySelector extends StatefulWidget {
  const BarangaySelector({
    super.key,
    required this.onChange,
    this.barangayName,
  });

  final Function(String? address, String? id) onChange;
  final String? barangayName;

  @override
  BarangaySelectorState createState() => BarangaySelectorState();
}

class BarangaySelectorState extends State<BarangaySelector> {
  Barangay? defaultValue;
  bool fetchingBarangay = false;
  List<Barangay> barangays = [];

  Future<void> _fetchBarangay() async {
    setState(() {
      fetchingBarangay = true;
    });

    // await Future.delayed(Duration(seconds: 3));
    List<Barangay> _barangays = [];
    try {
      _barangays = await BarangayServices().fetchALlBarangays();
    } catch (e, stackTrace) {
      log(e.toString(), stackTrace: stackTrace);
    }
    setState(() {
      if (widget.barangayName == null) {
        defaultValue = _barangays.first;
      } else {
        for (var b in _barangays) {
          if (b.name == widget.barangayName) {
            defaultValue = b;
            break;
          }
        }
      }

      // if (defaultValue?.id == null && defaultValue?.name == null) return;

      widget.onChange(defaultValue?.id, defaultValue?.name);
      barangays = _barangays;
      fetchingBarangay = false;
    });
  }

  @override
  void initState() {
    super.initState();

    _fetchBarangay();
  }

  @override
  Widget build(BuildContext context) {
    return fetchingBarangay
        ? const Row(
            spacing: 4 * 2,
            children: [
              SizedBox.square(
                dimension: 4 * 6,
                child: CircularProgressIndicator(),
              ),
              Text("Fetching barangay")
            ],
          )
        : DropdownButtonFormField(
            menuMaxHeight: MediaQuery.of(context).size.height * 0.6,
            decoration: InputDecoration(
              labelText: "Barangay",
              hintText: "Select your barangay",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8 * 2),
              ),
            ),
            value: defaultValue,
            onChanged: (value) {
              if (value == null) return;
              widget.onChange(value.name, value.id);
              setState(() {
                defaultValue = value;
              });
            },
            items: barangays.map((b) => DropdownMenuItem(value: b, child: Text(b.name))).toList(),
            validator: (value) {
              if (value == null) {
                return "Please select your barangay";
              }
              return null;
            },
          );
  }
}
