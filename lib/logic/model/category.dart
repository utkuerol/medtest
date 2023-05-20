class Category {
  static const String categoryA = "Muster zuordnen";
  static const String categoryB = "Med.-naturwiss. Grundverständnis";
  static const String categoryC = "Schlauchfiguren";
  static const String categoryD = "Quantitative und formale Probleme";
  static const String categoryE = "Figuren";
  static const String categoryF = "Fakten";
  static const String categoryG = "Textverständnis";
  static const String categoryH = "Diagramme und Tabellen";
  static const String categoryI = "Konzentration und sorgfältiges Arbeiten";
  static const String categoryI1 = "numerisch";
  static const String categoryI2 = "alphabetisch";

  static const List<String> validCategories = [
    categoryA,
    categoryB,
    categoryC,
    categoryD,
    categoryE,
    categoryF,
    categoryG,
    categoryH,
    categoryI
  ];

  static const List<String> textMultipleChoiceCategories = [
    categoryB,
    categoryD,
  ];

  static const List<String> imageMultipleChoiceCategories = [
    categoryA,
  ];

  static const List<String> imageQuestionTextMultipleChoiceCategories = [
    categoryC,
    categoryH,
  ];

  static const List<String> longTextMultipleChoiceCategories = [
    categoryG,
  ];

  static const List<String> concentrationMatrix = [
    categoryI,
    categoryI1,
    categoryI2
  ];

  // TODO decide if necessary
  static const List<String> introAndReproduceCategories = [
    categoryE,
    categoryF,
    categoryG
  ];
}
