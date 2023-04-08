import 'package:flutter/material.dart';
import 'package:medtest/logic/model/question.dart';
import 'package:medtest/pages/question/question_widget_builder.dart';

class QuizScreen extends StatefulWidget {
  final List<Question> questions;
  final String category;
  final Duration? timeLimit;
  final String? intro;
  final bool isSimulation;

  const QuizScreen({
    Key? key,
    required this.questions,
    required this.category,
    this.timeLimit,
    this.intro,
    required this.isSimulation,
  }) : super(key: key);

  @override
  QuizScreenState createState() => QuizScreenState();
}

class QuizScreenState extends State<QuizScreen> {
  int _currentIndex = 0;
  bool _isQuizComplete = false;

  void _handleNextQuestion(bool isCorrect) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            '${widget.category} - Aufgabe ${_currentIndex + 1}/${widget.questions.length}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _isQuizComplete
            ? _buildQuizCompleteScreen()
            : _buildQuestionScreen(),
      ),
    );
  }

  Widget _buildQuestionScreen() {
    final currentQuestion = widget.questions[_currentIndex];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (widget.intro != null && _currentIndex == 0) ...[
          _buildIntro(),
          Divider(),
        ],
        Expanded(
          child: QuestionWidgetBuilder.build(
            currentQuestion,
            onNextQuestion: _handleNextQuestion,
          ),
        ),
      ],
    );
  }

  Widget _buildIntro() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        widget.intro!,
        style: TextStyle(fontSize: 18.0),
      ),
    );
  }

  Widget _buildQuizCompleteScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Quiz complete!'),
          ElevatedButton(
            onPressed: () {
              _handleReset();
              Navigator.of(context).pop();
            },
            child: Text('Close'),
          ),
        ],
      ),
    );
  }

  void _onQuizComplete() {}
}
