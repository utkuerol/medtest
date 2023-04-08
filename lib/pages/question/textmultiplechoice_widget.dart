import 'package:flutter/material.dart';
import 'package:medtest/pages/question/question_widget.dart';
import 'package:medtest/logic/model/textmultiplechoice_question.dart';

class TextMultipleChoiceQuestionWidget extends QuestionWidget {
  final int? selectedIndex;

  const TextMultipleChoiceQuestionWidget({
    Key? key,
    required TextMultipleChoiceQuestion question,
    this.selectedIndex,
    required Function(bool isCorrect) onNextQuestion,
  }) : super(key: key, question: question, onNextQuestion: onNextQuestion);

  @override
  TextMultipleChoiceQuestionWidgetState createState() =>
      TextMultipleChoiceQuestionWidgetState();
}

class TextMultipleChoiceQuestionWidgetState
    extends State<TextMultipleChoiceQuestionWidget> {
  int? _selectedIndex;
  bool _isAnswered = false;
  bool _isCorrect = false;
  int? _correctIndex;

  void _onAnswerSelected(int? index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onAnswered() {
    final isCorrect = checkAnswer();
    setState(() {
      _isAnswered = true;
      _isCorrect = isCorrect;
      _correctIndex = (widget.question as TextMultipleChoiceQuestion).answer;
    });
  }

  @override
  Widget build(BuildContext context) {
    final choices = (widget.question as TextMultipleChoiceQuestion).choices;
    final question = (widget.question as TextMultipleChoiceQuestion).question;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: SingleChildScrollView(
              child: Text(
                question,
                style: const TextStyle(fontSize: 18.0),
              ),
            ),
          ),
          Divider(),
          SizedBox(
            height: 300,
            child: ListView.builder(
              itemCount: choices.length,
              itemBuilder: (BuildContext context, int index) {
                final choice = choices[index];
                final isCorrect = index == _correctIndex;
                final isSelected = _selectedIndex == index;
                final color = _isAnswered
                    ? isCorrect
                        ? Colors.green
                        : isSelected
                            ? Colors.red
                            : null
                    : isSelected
                        ? Colors.blue
                        : null;

                return RadioListTile<int>(
                  value: index,
                  groupValue: _selectedIndex,
                  onChanged: _isAnswered ? null : _onAnswerSelected,
                  title: Text(
                    choice,
                    style: TextStyle(
                      color: color,
                      fontWeight: isSelected ? FontWeight.bold : null,
                    ),
                  ),
                  activeColor: color ?? Colors.blue,
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: !_isAnswered
                ? ElevatedButton(
                    onPressed: _selectedIndex == null || _isAnswered
                        ? null
                        : _onAnswered,
                    child: const Text('Antwort prüfen'),
                  )
                : ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _selectedIndex = null;
                        _isAnswered = false;
                        _isCorrect = false;
                      });
                      widget.onNextQuestion(_isCorrect);
                    },
                    child: const Text('Nächste Frage'),
                  ),
          ),
        ],
      ),
    );
  }

  bool checkAnswer() {
    return _selectedIndex ==
        (widget.question as TextMultipleChoiceQuestion).answer;
  }
}
