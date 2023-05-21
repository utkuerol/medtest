import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medtest/logic/model/category.dart';
import 'package:medtest/logic/model/question.dart';
import 'package:medtest/logic/model/textmultiplechoice_question.dart';
import 'package:medtest/pages/question/question_widget_builder.dart';
import 'package:medtest/pages/results.dart';

import '../logic/model/imagemultiplechoice_question.dart';

class QuizScreen extends StatefulWidget {
  final List<Question> questions;
  final String category;
  final String? intro;
  final bool isSimulation;

  const QuizScreen({
    Key? key,
    required this.questions,
    required this.category,
    this.intro,
    required this.isSimulation,
  }) : super(key: key);

  @override
  QuizScreenState createState() => QuizScreenState();
}

class QuizScreenState extends State<QuizScreen> {
  int _currentIndex = 0;
  bool _isQuizComplete = false;
  late List<int?> _userAnswers;
  late int _remainingTime;

  @override
  void initState() {
    super.initState();
    _userAnswers = List.filled(widget.questions.length, null);
    if (widget.isSimulation) {
      _remainingTime = getTimeLimitInSeconds();
      startTimer();
    } else {
      _remainingTime = double.maxFinite.toInt();
    }
    if (widget.intro != null) {
      _currentIndex = -1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getNavbarTitle()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _isQuizComplete
            ? _buildQuizCompleteScreen()
            : _buildQuestionScreen(),
      ),
    );
  }

  void _handleNextQuestion(int answerIndex, bool isCorrect) {
    _userAnswers[_currentIndex] = answerIndex;
    if (_currentIndex < widget.questions.length - 1) {
      setState(() {
        _currentIndex++;
      });
    } else {
      setState(() {
        _isQuizComplete = true;
      });

      _onQuizComplete();
    }
  }

  void _handleReset() {
    setState(() {
      _currentIndex = 0;
      _isQuizComplete = false;
    });
  }

  Widget _buildIntro() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        widget.intro!,
        style: const TextStyle(fontSize: 18.0),
      ),
    );
  }

  Widget _buildQuestionScreen() {
    if (widget.intro != null && _currentIndex == -1) {
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (widget.isSimulation) buildTimer(),
            _buildIntro(),
            const Divider(),
            ElevatedButton(
              onPressed: () => setState(() {
                _currentIndex = 0; // Move to the first question
              }),
              child: const Text('Continue'),
            ),
          ],
        ),
      );
    }
    final currentQuestion = widget.questions[_currentIndex];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (widget.isSimulation) buildTimer(),
        Expanded(
          child: QuestionWidgetBuilder.build(
            currentQuestion,
            widget.isSimulation,
            onNextQuestion: _handleNextQuestion,
          ),
        ),
      ],
    );
  }

  Widget _buildQuizCompleteScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Quiz complete!'),
          ElevatedButton(
            onPressed: () {
              _handleReset();
              Navigator.of(context).pop();
            },
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget buildTimer() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      color: Colors.blueGrey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.hourglass_empty_outlined,
            size: 30,
            color: Colors.black,
          ),
          const SizedBox(width: 8.0),
          Text(
            formatTimeLimit(_remainingTime),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          )
        ],
      ),
    );
  }

  void _onQuizComplete() {
    if (widget.isSimulation) {
      int score = calculateScore();
      Get.off(QuizCompleteScreen(
        score: score,
        totalQuestions: widget.questions.length,
      ));
    } else {
      Get.off(TrainingCompleteScreen(
          totalQuestions: widget.questions.length, category: widget.category));
    }
  }

  int calculateScore() {
    int correctAnswers = 0;
    for (int i = 0; i < widget.questions.length; i++) {
      if (widget.questions[i] is TextMultipleChoiceQuestion) {
        final question = widget.questions[i] as TextMultipleChoiceQuestion;
        if (_userAnswers[i] == question.answer) {
          correctAnswers++;
        }
      } else if (widget.questions[i] is ImageMultipleChoiceQuestion) {
        final question = widget.questions[i] as ImageMultipleChoiceQuestion;
        if (_userAnswers[i] == question.answer) {
          correctAnswers++;
        }
      }
    }
    return correctAnswers;
  }

  String getNavbarTitle() {
    return '${widget.category} - Aufgabe ${_currentIndex + 1}/${widget.questions.length}';
  }

  int getTimeLimitInSeconds() {
    const min = 60;
    // TODO add real time limits for each category
    switch (widget.category) {
      case Category.categoryA:
        return 10 * min;
      case Category.categoryB:
        return 20 * min;
      case Category.categoryC:
        return 15 * min;
      default:
        return 10 * min;
    }
  }

  void startTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          if (_isQuizComplete) {
            timer.cancel();
          }
          if (_remainingTime > 0) {
            _remainingTime--;
          } else {
            // quiz time's up, show QuizCompleteScreen
            timer.cancel();
            Get.off(QuizCompleteScreen(
              score: calculateScore(),
              totalQuestions: widget.questions.length,
            ));
          }
        });
      }
    });
  }

  String formatTimeLimit(int seconds) {
    final Duration duration = Duration(seconds: seconds);
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${duration.inHours}:$twoDigitMinutes:$twoDigitSeconds";
  }
}
