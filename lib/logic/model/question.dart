import 'package:medtest/logic/model/category.dart';
import 'package:medtest/logic/model/question_type.dart';

class Question {
  final int id;
  final String category;
  final QuestionType type;

  Question(this.id, this.category, this.type) {
    // Check if category is valid
    if (!Category.validCategories.contains(category)) {
      throw ArgumentError('Invalid category');
    }

    // Check if type is valid
    if (!QuestionType.values.contains(type)) {
      throw ArgumentError('Invalid type');
    }
  }
}
