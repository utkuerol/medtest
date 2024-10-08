import 'package:medtest/logic/model/question.dart';

class ImageMultipleChoiceQuestion extends Question {
  final String questionText;
  final List<String> questionImages;
  final List<String> choices;
  final int answer;

  ImageMultipleChoiceQuestion(int id, String category, this.questionText,
      this.questionImages, this.choices, this.answer)
      : super(id, category) {
    // Check if answer index is within the range of the choices array
    if (answer < 0 || answer >= choices.length) {
      throw ArgumentError('Answer index is out of range');
    }
  }
}
