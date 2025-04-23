import 'package:smartguide_app/models/trimester.dart';

class CareAndTest {
  final TrimesterEnum trimester;
  final bool consultWht;
  final bool introducedBirthPlann;
  final String fundicHeight;
  final bool isFundicNormal;
  final String bloodPressure;
  final bool isBloodPressureNormal;
  final List<String> advices;
  final List<String> services;

  CareAndTest({
    required this.trimester,
    required this.consultWht,
    required this.introducedBirthPlann,
    required this.fundicHeight,
    required this.isFundicNormal,
    required this.bloodPressure,
    required this.isBloodPressureNormal,
    required this.advices,
    required this.services,
  });
}
