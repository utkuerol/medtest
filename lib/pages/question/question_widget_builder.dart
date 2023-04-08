import 'package:flutter/material.dart';
import 'package:medtest/logic/model/question.dart';
import 'package:medtest/logic/model/question_type.dart';
import 'package:medtest/logic/model/textmultiplechoice_question.dart';
import 'package:medtest/pages/question/textmultiplechoice_widget.dart';

class QuestionWidgetBuilder {
  static Widget build(Question question,
      {required Function(bool isCorrect) onNextQuestion}) {
    switch (question.type) {
      case QuestionType.textMultipleChoice:
        final textQuestion = question as TextMultipleChoiceQuestion;
        return TextMultipleChoiceQuestionWidget(
          question: textQuestion,
          onNextQuestion: onNextQuestion,
        );
      case QuestionType.imageMultipleChoice:
        // TODO: Implement ImageMultipleChoiceQuestionWidget
        return Placeholder();
      case QuestionType.concentrationMatrix:
        // TODO: Implement ConcentrationMatrixQuestionWidget
        return Placeholder();
      default:
        throw ArgumentError('Invalid question type');
    }
  }
}
