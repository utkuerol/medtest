import 'package:flutter/services.dart';
import 'package:medtest/logic/model/category.dart';
import 'package:medtest/logic/model/imagemultiplechoice_question.dart';
import 'package:medtest/logic/model/imagequestiontextmultiplechoice_question.dart';
import 'package:medtest/logic/model/longtextmultiplechoice_question.dart';
import 'package:medtest/logic/model/question.dart';
import 'package:medtest/logic/model/textmultiplechoice_question.dart';
import 'dart:convert';

class QuestionRepository {
  static const int trainingBatchSize = 10;
  static const int simulationCategoryABatchSize = 5;
  static const int simulationCategoryBBatchSize = 5;
  static const int simulationCategoryCBatchSize = 5;
  static const int simulationCategoryDBatchSize = 5;
  static const int simulationCategoryEBatchSize = 5;
  static const int simulationCategoryFBatchSize = 1;
  static const int simulationCategoryGBatchSize = 5;
  static const int simulationCategoryHBatchSize = 5;
  static const int simulationCategoryIBatchSize = 5;

  // gets simulation question catalog for category
  static Future<List<Question>> getSimulationQuestions(String category) async {
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
      default:
    }
    questions = await getQuestions(category, batchSize);
    return questions;
  }

  // gets n questions randomly from the given category
  static Future<List<Question>> getQuestions(String category, int n) async {
    final String jsonString =
        await rootBundle.loadString('assets/data/$category.json');
    final jsonData = json.decode(jsonString);
    if (jsonData.length < n) {
      n = jsonData.length;
    }
    jsonData.shuffle();
    List<dynamic> randomQuestions = jsonData.sublist(0, n);
    final List<Question> questions = _createQuestionsFromJsonData(
      randomQuestions,
      category,
    );
    return questions;
  }

  // gets n unseen questions randomly from the given category
  static Future<List<Question>> getFreshQuestions(
      String category, int n) async {
    final String jsonString =
        await rootBundle.loadString('assets/data/$category.json');
    var jsonData = json.decode(jsonString);
    jsonData.shuffle();
    jsonData = jsonData.where((json) => json['trained'] == false);
    if (jsonData.length < n) {
      n = jsonData.length;
    }
    final List<dynamic> randomQuestions = jsonData.sublist(0, n);

    final List<Question> questions = _createQuestionsFromJsonData(
      randomQuestions,
      category,
    );

    return questions;
  }

  // gets n previously failed questions randomly from the given category
  static Future<List<Question>> getFailedQuestions(
      String category, int n) async {
    final String jsonString =
        await rootBundle.loadString('assets/data/$category.json');
    var jsonData = json.decode(jsonString);
    jsonData.shuffle();
    jsonData = jsonData.where((json) => json['answeredCorrectly'] == false);
    if (jsonData.length < n) {
      n = jsonData.length;
    }
    final List<dynamic> randomQuestions = jsonData.sublist(0, n);

    final List<Question> questions = _createQuestionsFromJsonData(
      randomQuestions,
      category,
    );

    return questions;
  }

  static List<Question> _createQuestionsFromJsonData(
    List<dynamic> jsonData,
    String category,
  ) {
    final List<Question> questions = [];
    if (Category.textMultipleChoiceCategories.contains(category)) {
      for (var questionData in jsonData) {
        final int id = questionData['id'];
        final String questionText = questionData['question'];
        final List<String> choices = List<String>.from(questionData['choices']);
        final int correctAnswerIndex = questionData['answer'];
        final question = TextMultipleChoiceQuestion(
          id,
          category,
          questionText,
          choices,
          correctAnswerIndex,
        );
        questions.add(question);
      }
    } else if (Category.imageMultipleChoiceCategories.contains(category) ||
        Category.imageQuestionTextMultipleChoiceCategories.contains(category)) {
      for (var questionData in jsonData) {
        final int id = questionData['id'];
        final String questionText = questionData['question_text'];
        final List<String> questionImages =
            List<String>.from(questionData['question_images']);
        final List<String> choices = List<String>.from(questionData['choices']);
        final int correctAnswerIndex = questionData['answer'];
        Question question;
        if (Category.imageMultipleChoiceCategories.contains(category)) {
          question = ImageMultipleChoiceQuestion(id, category, questionText,
              questionImages, choices, correctAnswerIndex);
        } else {
          question = ImageQuestionTextMultipleChoiceQuestion(id, category,
              questionText, questionImages, choices, correctAnswerIndex);
        }
        questions.add(question);
      }
    } else if (Category.longTextMultipleChoiceCategories.contains(category)) {
      for (var questionData in jsonData) {
        final int id = questionData['id'];
        final String text = questionData['text'];
        final List<TextMultipleChoiceQuestion> subquestions = [];
        for (var q in questionData['questions']) {
          final String questionText = q['question'];
          final List<String> choices = List<String>.from(q['choices']);
          final int correctAnswerIndex = q['answer'];
          final subquestion = TextMultipleChoiceQuestion(
            -1, // TODO
            category,
            questionText,
            choices,
            correctAnswerIndex,
          );
          subquestions.add(subquestion);
        }
        final question =
            LongTextMultipleChoiceQuestion(id, category, text, subquestions);
        questions.add(question);
      }
    }
    return questions;
  }
}
