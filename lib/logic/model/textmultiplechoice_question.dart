import 'package:medtest/logic/model/question.dart';

class TextMultipleChoiceQuestion extends Question {
  final String question;
  final List<String> choices;
  final int answer;

  TextMultipleChoiceQuestion(
      int id, String category, this.question, this.choices, this.answer)
      : super(id, category) {
    // Check if answer index is within the range of the choices array
    if (answer < 0 || answer >= choices.length) {
      throw ArgumentError('Answer index is out of range');
    }
  }
}
