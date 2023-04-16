import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medtest/logic/model/category.dart';
import 'package:medtest/repository/mock_data.dart';
import 'package:medtest/pages/home.dart';
import 'package:medtest/pages/quiz.dart';
import 'package:medtest/repository/question_repository.dart';

class TrainingMenu extends StatelessWidget {
  const TrainingMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MedTest"),
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () => Get.off(Home()),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(
                "Kategorien",
                style: Theme.of(context).textTheme.headlineLarge,
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 2.5,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                padding: const EdgeInsets.all(16),
                children: Category.validCategories.map((category) {
                  return ElevatedButton(
                    onPressed: () => showDialog(
                      context: context,
                      builder: (context) {
                        return SimpleDialog(
                          title: const Text(
                              'Wie möchtest du diese Kategorie üben?'),
                          children: <Widget>[
                            SimpleDialogOption(
                              onPressed: () => Get.off(getSimulation(category)),
                              child: const Text('Simulation'),
                            ),
                            SimpleDialogOption(
                              onPressed: () => Get.off(getShuffle(category)),
                              child: const Text('Shuffle'),
                            ),
                            SimpleDialogOption(
                              onPressed: () => Get.off(getFailed(category)),
                              child: const Text('Zuletzt falsch'),
                            ),
                            SimpleDialogOption(
                              onPressed: () => Get.off(getFresh(category)),
                              child: const Text('Frisch'),
                            ),
                          ],
                        );
                      },
                    ),
                    child: Text(
                      category,
                      style: const TextStyle(fontSize: 16),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getSimulation(String category) {
    return QuizScreen(
      category: category,
      questions: QuestionRepository.getSimulationQuestions(category),
      isSimulation: true,
    );
  }

  Widget getShuffle(String category) {
    return QuizScreen(
      category: category,
      questions: QuestionRepository.getQuestions(
          category, QuestionRepository.trainingBatchSize),
      isSimulation: false,
    );
  }

  Widget getFresh(String category) {
    return QuizScreen(
      category: category,
      questions: QuestionRepository.getFreshQuestions(
          category, QuestionRepository.trainingBatchSize),
      isSimulation: false,
    );
  }

  Widget getFailed(String category) {
    return QuizScreen(
      category: category,
      questions: QuestionRepository.getFailedQuestions(
          category, QuestionRepository.trainingBatchSize),
      isSimulation: false,
    );
  }
}
