import 'package:flutter/material.dart';
import 'package:medtest/logic/model/imagemultiplechoice_question.dart';
import 'package:medtest/pages/question/question_widget.dart';

class ImageMultipleChoiceQuestionWidget extends QuestionWidget {
  final int? selectedIndex;
  final bool isSimulation;

  const ImageMultipleChoiceQuestionWidget({
    Key? key,
    required ImageMultipleChoiceQuestion question,
    this.selectedIndex,
    required this.isSimulation,
    required Function(int answerIndex, bool isCorrect) onNextQuestion,
  }) : super(key: key, question: question, onNextQuestion: onNextQuestion);

  @override
  ImageMultipleChoiceQuestionWidgetState createState() =>
      ImageMultipleChoiceQuestionWidgetState();
}

class ImageMultipleChoiceQuestionWidgetState
    extends State<ImageMultipleChoiceQuestionWidget> {
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
      _correctIndex = (widget.question as ImageMultipleChoiceQuestion).answer;
    });
  }

  @override
  Widget build(BuildContext context) {
    final choices = (widget.question as ImageMultipleChoiceQuestion).choices;
    final questionImage = ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Image.asset(
            (widget.question as ImageMultipleChoiceQuestion).questionImages[0],
            fit: BoxFit.fill,
          ),
        ));

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: SizedBox(
              width: double.infinity,
              height: 300,
              child: questionImage,
            ),
          ),
          const Divider(
            thickness: 3,
          ),
          Center(
            child: Wrap(
              runSpacing: 8.0,
              alignment: WrapAlignment.center,
              children: choices.map((choice) {
                final index = choices.indexOf(choice);
                final isCorrect = index == _correctIndex;
                final isSelected = _selectedIndex == index;
                final borderColor = _isAnswered
                    ? isCorrect
                        ? Colors.green
                        : isSelected
                            ? Colors.red
                            : Colors.transparent
                    : isSelected
                        ? Colors.blue
                        : Colors.transparent;
                final borderWidth = _isAnswered
                    ? 5.0
                    : isSelected
                        ? 5.0
                        : 2.0;
                return Container(
                  width: MediaQuery.of(context).size.width / 2.2,
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: _isAnswered ? null : () => _onAnswerSelected(index),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: borderColor,
                          width: borderWidth,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            width: 5.0,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            choice,
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: widget.isSimulation
                ? getSimulationButton()
                : getTrainingButton(),
          ),
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
        (widget.question as ImageMultipleChoiceQuestion).answer;
  }
}
