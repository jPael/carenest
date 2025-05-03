import 'package:smartguide_app/models/person.dart';

class BirthPlan {
  final String birthplace;
  final Person? assignedBy;
  final Person? accompaniedBy;

  BirthPlan({
    required this.birthplace,
    required this.assignedBy,
    required this.accompaniedBy,
  });
}
