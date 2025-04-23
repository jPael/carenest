class Counseling {
  final bool breastFeeding;
  final bool familyPlanning;
  final bool? properNutrition;
  final bool childProperNutrition;
  final bool selfProperNutrition;

  Counseling({
    required this.breastFeeding,
    required this.familyPlanning,
    this.properNutrition,
    required this.childProperNutrition,
    required this.selfProperNutrition,
  });
}
