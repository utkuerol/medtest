import 'package:medtest/logic/model/category.dart';
import 'package:medtest/logic/model/question.dart';
import 'package:medtest/repository/mock_data.dart';

class QuestionRepository {
  static const int trainingBatchSize = 10;
  static const int simulationCategoryABatchSize = 5;
  static const int simulationCategoryBBatchSize = 5;
  static const int simulationCategoryCBatchSize = 5;
  static const int simulationCategoryDBatchSize = 5;
  static const int simulationCategoryEBatchSize = 5;
  static const int simulationCategoryFBatchSize = 5;
  static const int simulationCategoryGBatchSize = 5;
  static const int simulationCategoryHBatchSize = 5;
  static const int simulationCategoryIBatchSize = 5;

  // gets simulation question catalog for category
  static List<Question> getSimulationQuestions(String category) {
    List<Question> questions = [];
    int batchSize = 0;
    switch (category) {
      case Category.categoryA:
        batchSize = simulationCategoryABatchSize;
        break;
      case Category.categoryB:
        batchSize = simulationCategoryBBatchSize;
        break;
      case Category.categoryC:
        batchSize = simulationCategoryCBatchSize;
        break;
      case Category.categoryD:
        batchSize = simulationCategoryDBatchSize;
        break;
      case Category.categoryE:
        batchSize = simulationCategoryEBatchSize;
        break;
      case Category.categoryF:
        batchSize = simulationCategoryFBatchSize;
        break;
      case Category.categoryG:
        batchSize = simulationCategoryGBatchSize;
        break;
      case Category.categoryH:
        batchSize = simulationCategoryHBatchSize;
        break;
      case Category.categoryI:
        batchSize = simulationCategoryIBatchSize;
        break;
      default:
    }
    for (int i = 0; i < batchSize; i++) {
      questions.add(MockData.textMultipleChoiceQuestion);
    }
    return questions;
  }

  // gets n questions randomly from the given category
  static List<Question> getQuestions(String category, int n) {
    List<Question> questions = [];
    for (int i = 0; i < trainingBatchSize; i++) {
      questions.add(MockData.textMultipleChoiceQuestion);
    }
    return questions;
  }

  // gets n unseen questions randomly from the given category
  static List<Question> getFreshQuestions(String category, int n) {
    List<Question> questions = [];
    for (int i = 0; i < trainingBatchSize; i++) {
      questions.add(MockData.textMultipleChoiceQuestion);
    }
    return questions;
  }

  // gets n previously failed questions randomly from the given category
  static List<Question> getFailedQuestions(String category, int n) {
    List<Question> questions = [];
    for (int i = 0; i < trainingBatchSize; i++) {
      questions.add(MockData.textMultipleChoiceQuestion);
    }
    return questions;
  }
}
