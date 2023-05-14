class Category {
  static const String categoryA = "Muster zuordnen";
  static const String categoryB = "Med.-naturwiss. Grundverständnis";
  static const String categoryC = "Schlauchfiguren";
  static const String categoryD = "Quantitative und formale Probleme";
  static const String categoryE = "Figuren/Fakten";
  static const String categoryE1 = "Figuren";
  static const String categoryE2 = "Fakten";
  static const String categoryF = "Textverständnis";
  static const String categoryG = "Diagramme und Tabellen";
  static const String categoryH = "Konzentration und sorgfältiges Arbeiten";
  static const String categoryH1 = "numerisch";
  static const String categoryH2 = "alphabetisch";

  static const List<String> validCategories = [
    categoryA,
    categoryB,
    categoryC,
    categoryD,
    categoryE,
    categoryF,
    categoryG,
    categoryH,
  ];

  static const List<String> textMultipleChoiceCategories = [
    categoryB,
    categoryD
  ];

  static const List<String> imageMultipleChoiceCategories = [
    categoryA,
  ];

  static const List<String> imageQuestionTextMultipleChoiceCategories = [
    categoryC,
    categoryG
  ];

  static const List<String> longTextMultipleChoiceCategories = [
    categoryF,
  ];

  static const List<String> concentrationMatrix = [
    categoryH,
    categoryH1,
    categoryH2
  ];
}
