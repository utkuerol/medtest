import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medtest/pages/home.dart';
import 'package:medtest/pages/quiz.dart';
import 'package:medtest/repository/question_repository.dart';

class QuizCompleteScreen extends StatelessWidget {
  final int score;
  final int totalQuestions;

  const QuizCompleteScreen({
    Key? key,
    required this.score,
    required this.totalQuestions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Results'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'You scored $score out of $totalQuestions!',
              style: const TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Get.off(Home()),
              child: const Text('Close'),
            ),
          ],
        ),
      ),
    );
  }
}

class TrainingCompleteScreen extends StatelessWidget {
  final int totalQuestions;
  final String category;

  const TrainingCompleteScreen({
    Key? key,
    required this.totalQuestions,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Training'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'You finished training $totalQuestions questions!',
              style: const TextStyle(fontSize: 30),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Get.off(Home()),
              child: const Text('Return to home'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Get.off(QuizScreen(
                  questions: QuestionRepository.getQuestions(
                      category, QuestionRepository.trainingBatchSize),
                  category: category,
                  isSimulation: false)),
              child: const Text('Continue with shuffle'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Get.off(QuizScreen(
                  questions: QuestionRepository.getFreshQuestions(
                      category, QuestionRepository.trainingBatchSize),
                  category: category,
                  isSimulation: false)),
              child: const Text('Continue with fresh'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Get.off(QuizScreen(
                  questions: QuestionRepository.getFailedQuestions(
                      category, QuestionRepository.trainingBatchSize),
                  category: category,
                  isSimulation: false)),
              child: const Text('Continue with failed'),
            ),
          ],
        ),
      ),
    );
  }
}
