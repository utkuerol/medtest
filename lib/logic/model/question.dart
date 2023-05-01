import 'package:medtest/logic/model/category.dart';
import 'package:medtest/logic/model/question_type.dart';

class Question {
  int id;
  String category;
  late QuestionType type;

  Question(this.id, this.category) {
    if (!Category.validCategories.contains(category)) {
      throw ArgumentError('Invalid category');
    }

    if (Category.textMultipleChoiceCategories.contains(category)) {
      type = QuestionType.textMultipleChoice;
    } else if (Category.imageMultipleChoiceCategories.contains(category)) {
      type = QuestionType.imageMultipleChoice;
    } else {
      throw ArgumentError('Invalid category');
    }
  }
}
