class Trimester {
  final TrimesterEnum trimester;
  final DateTime dateOfVisit;
  final bool consultWht;
  final bool introducedBirthPlan;
  final String fundicHeight;
  final bool isFundicNormal;
  final String bloodPressure;
  final bool isBloodPressureNormal;
  final List<String> advices;
  final List<String> services;
  final String whtPersonnel;

  Trimester({
    required this.whtPersonnel,
    required this.trimester,
    required this.dateOfVisit,
    required this.consultWht,
    required this.introducedBirthPlan,
    required this.fundicHeight,
    required this.isFundicNormal,
    required this.bloodPressure,
    required this.isBloodPressureNormal,
    required this.advices,
    required this.services,
  });

  // static Trimester fromJson(Map<String, dynamic> json) => Trimester(
  //     whtPersonnel: json[PatientInformationFields.],
  //     trimester: trimester,
  //     dateOfVisit: dateOfVisit,
  //     consultWht: consultWht,
  //     introducedBirthPlan: introducedBirthPlan,
  //     fundicHeight: fundicHeight,
  //     isFundicNormal: isFundicNormal,
  //     bloodPressure: bloodPressure,
  //     isBloodPressureNormal: isBloodPressureNormal,
  //     advices: advices,
  //     services: services);
}

enum TrimesterEnum { first, second, third }

extension TrimesterEnumExtenion on TrimesterEnum {
  String get label {
    switch (this) {
      case TrimesterEnum.first:
        return "First Trimester";
      case TrimesterEnum.second:
        return "Second Trimester";
      case TrimesterEnum.third:
        return "Third Trimester";
    }
  }

  String get laravelValue {
    switch (this) {
      case TrimesterEnum.first:
        return "1ST_TRIMESTER";
      case TrimesterEnum.second:
        return "2ND_TRIMESTER";
      case TrimesterEnum.third:
        return "3RD_TRIMESTER";
    }
  }

  int get value {
    switch (this) {
      case TrimesterEnum.first:
        return 1;
      case TrimesterEnum.second:
        return 2;
      case TrimesterEnum.third:
        return 3;
    }
  }
}
