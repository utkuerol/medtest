import 'package:flutter/material.dart';
import 'package:medtest/logic/model/question.dart';

abstract class QuestionWidget extends StatefulWidget {
  final Question question;
  final void Function(int answerIndex, bool isCorrect) onNextQuestion;

  const QuestionWidget(
      {Key? key, required this.question, required this.onNextQuestion})
      : super(key: key);
}
