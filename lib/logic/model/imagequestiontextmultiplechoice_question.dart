import 'package:medtest/logic/model/imagemultiplechoice_question.dart';

class ImageQuestionTextMultipleChoiceQuestion
    extends ImageMultipleChoiceQuestion {
  ImageQuestionTextMultipleChoiceQuestion(
      int id,
      String category,
      String questionText,
      List<String> questionImages,
      List<String> choices,
      int answer)
      : super(id, category, questionText, questionImages, choices, answer) {
    // Check if answer index is within the range of the choices array
    if (answer < 0 || answer >= choices.length) {
      throw ArgumentError('Answer index is out of range');
    }
  }
}
