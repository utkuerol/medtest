import 'package:medtest/logic/model/question.dart';
import 'package:medtest/logic/model/textmultiplechoice_question.dart';

class LongTextMultipleChoiceQuestion extends Question {
  final String text;
  final List<TextMultipleChoiceQuestion> questions;

  LongTextMultipleChoiceQuestion(
      int id, String category, this.text, this.questions)
      : super(id, category) {
    // Check if answer index is within the range of the choices array
    for (TextMultipleChoiceQuestion q in questions) {
      if (q.answer < 0 || q.answer >= q.choices.length) {
        throw ArgumentError('Answer index is out of range');
      }
    }
  }
}
