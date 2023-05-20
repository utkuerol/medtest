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
    } else if (Category.longTextMultipleChoiceCategories.contains(category)) {
      type = QuestionType.longTextMultipleChoice;
    } else if (Category.imageQuestionTextMultipleChoiceCategories
        .contains(category)) {
      type = QuestionType.imageQuestionTextMultipleChoice;
    } else {
      throw ArgumentError('Invalid category');
    }
  }
}
