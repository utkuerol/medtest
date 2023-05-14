import 'package:flutter/material.dart';
import 'package:medtest/logic/model/imagemultiplechoice_question.dart';
import 'package:medtest/logic/model/question.dart';
import 'package:medtest/logic/model/question_type.dart';
import 'package:medtest/logic/model/textmultiplechoice_question.dart';
import 'package:medtest/pages/question/imageMultipleChoice_widget.dart';
import 'package:medtest/pages/question/textmultiplechoice_widget.dart';

class QuestionWidgetBuilder {
  static Widget build(Question question, bool isSimulation,
      {required Function(int answerIndex, bool isCorrect) onNextQuestion}) {
    switch (question.type) {
      case QuestionType.textMultipleChoice:
        final textQuestion = question as TextMultipleChoiceQuestion;
        return TextMultipleChoiceQuestionWidget(
          question: textQuestion,
          onNextQuestion: onNextQuestion,
          isSimulation: isSimulation,
        );
      case QuestionType.imageMultipleChoice:
        final imageQuestion = question as ImageMultipleChoiceQuestion;
        return ImageMultipleChoiceQuestionWidget(
          question: imageQuestion,
          onNextQuestion: onNextQuestion,
          isSimulation: isSimulation,
        );
      case QuestionType.longTextMultipleChoice:
        final textQuestion = question as TextMultipleChoiceQuestion;
        return TextMultipleChoiceQuestionWidget(
          question: textQuestion,
          onNextQuestion: onNextQuestion,
          isSimulation: isSimulation,
        );
      case QuestionType.concentrationMatrix:
        return const Placeholder();
      default:
        throw ArgumentError('Invalid question type');
    }
  }
}
