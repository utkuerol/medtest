import 'package:flutter/material.dart';
import 'package:medtest/pages/question/question_widget.dart';
import 'package:medtest/logic/model/textmultiplechoice_question.dart';

class TextMultipleChoiceQuestionWidget extends QuestionWidget {
  final int? selectedIndex;
  final bool isSimulation;

  const TextMultipleChoiceQuestionWidget({
    Key? key,
    required TextMultipleChoiceQuestion question,
    this.selectedIndex,
    required this.isSimulation,
    required Function(int answerIndex, bool isCorrect) onNextQuestion,
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
            child: Text(
              question,
              style: const TextStyle(fontSize: 15.0),
            ),
          ),
          const Divider(
            thickness: 3,
          ),
          SizedBox(
              height: 500,
              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
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
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: widget.isSimulation
                          ? getSimulationButton()
                          : getTrainingButton())
                ],
              )),
        ],
      ),
    );
  }

  Widget getSimulationButton() {
    return ElevatedButton(
      onPressed: () {
        widget.onNextQuestion(_selectedIndex!, _isCorrect);
        setState(() {
          _selectedIndex = null;
          _isAnswered = false;
          _isCorrect = false;
        });
      },
      child: const Text('Senden'),
    );
  }

  Widget getTrainingButton() {
    return !_isAnswered
        ? ElevatedButton(
            onPressed:
                _selectedIndex == null || _isAnswered ? null : _onAnswered,
            child: const Text('Antwort prüfen'),
          )
        : ElevatedButton(
            onPressed: () {
              widget.onNextQuestion(_selectedIndex!, _isCorrect);
              setState(() {
                _selectedIndex = null;
                _isAnswered = false;
                _isCorrect = false;
              });
            },
            child: const Text('Nächste Frage'),
          );
  }

  bool checkAnswer() {
    return _selectedIndex ==
        (widget.question as TextMultipleChoiceQuestion).answer;
  }
}
