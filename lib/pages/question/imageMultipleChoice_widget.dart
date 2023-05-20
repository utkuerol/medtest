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

    final questionImage = Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.asset(
          (widget.question as ImageMultipleChoiceQuestion).questionImages[0],
          fit: BoxFit.contain,
        ),
      ),
    );

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
          const Divider(),
          GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 5,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
            ),
            itemBuilder: (context, index) {
              if (index >= choices.length) {
                return Container();
              } else {
                final choice = choices[index];
                final isCorrect = choices.indexOf(choice) == _correctIndex;
                final isSelected = choices.indexOf(choice) == _selectedIndex;
                final borderColor = _isAnswered
                    ? isCorrect
                    ? Colors.green
                    : isSelected
                    ? Colors.red
                    : Colors.transparent
                    : isSelected
                    ? Colors.blue
                    : Colors.transparent;
                final borderWidth =
                _isAnswered ? 5.0 : isSelected ? 5.0 : 2.0;

                return GestureDetector(
                  onTap: _isAnswered
                      ? null
                      : () => _onAnswerSelected(choices.indexOf(choice)),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: borderColor,
                        width: borderWidth,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        choice,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                );
              }
            },
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
