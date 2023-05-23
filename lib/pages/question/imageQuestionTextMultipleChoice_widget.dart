import 'package:flutter/material.dart';
import 'package:medtest/logic/model/imagequestiontextmultiplechoice_question.dart';
import 'package:medtest/pages/question/question_widget.dart';

class ImageQuestionTextMultipleChoiceQuestionWidget extends QuestionWidget {
  final int? selectedIndex;
  final bool isSimulation;

  const ImageQuestionTextMultipleChoiceQuestionWidget({
    Key? key,
    required ImageQuestionTextMultipleChoiceQuestion question,
    this.selectedIndex,
    required this.isSimulation,
    required Function(int answerIndex, bool isCorrect) onNextQuestion,
  }) : super(key: key, question: question, onNextQuestion: onNextQuestion);

  @override
  ImageQuestionTextMultipleChoiceQuestionWidgetState createState() =>
      ImageQuestionTextMultipleChoiceQuestionWidgetState();
}

class ImageQuestionTextMultipleChoiceQuestionWidgetState
    extends State<ImageQuestionTextMultipleChoiceQuestionWidget> {
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
      _correctIndex =
          (widget.question as ImageQuestionTextMultipleChoiceQuestion).answer;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<String> choices =
        (widget.question as ImageQuestionTextMultipleChoiceQuestion).choices;
    final List<Widget> questionImages = loadQuestionImages();
    final String questionText =
        (widget.question as ImageQuestionTextMultipleChoiceQuestion)
            .questionText;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              for (Widget questionImage in questionImages) questionImage,
            ],
          ),
          questionText != ""
              ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: SingleChildScrollView(
                    child: Text(
                      questionText,
                      style: const TextStyle(fontSize: 12.0),
                    ),
                  ),
                )
              : const Padding(padding: EdgeInsets.all(0)),
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
            ),
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
        (widget.question as ImageQuestionTextMultipleChoiceQuestion).answer;
  }

  List<Widget> loadQuestionImages() {
    List<String> questionImages =
        (widget.question as ImageQuestionTextMultipleChoiceQuestion)
            .questionImages;

    List<Widget> imageWidgets = [];

    for (String imagePath in questionImages) {
      Widget imageWidget = InteractiveViewer(
        panEnabled: true,
        panAxis: PanAxis.free,
        boundaryMargin: const EdgeInsets.all(0),
        minScale: 1,
        maxScale: 5,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 1.0,
              ),
            ),
            child: ClipRRect(
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      );

      imageWidgets.add(imageWidget);
    }

    return imageWidgets;
  }
}
