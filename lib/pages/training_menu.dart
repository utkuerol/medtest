import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medtest/logic/model/category.dart';
import 'package:medtest/logic/model/question.dart';
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
        padding: const EdgeInsets.all(0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Text(
                "Kategorien",
                style: Theme.of(context).textTheme.headlineLarge,
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(36),
                children: Category.validCategories.map((category) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ElevatedButton(
                      onPressed: () => showDialog(
                        context: context,
                        builder: (context) {
                          return SimpleDialog(
                            title: Text(
                              'Wie möchtest du diese Kategorie üben?',
                              style: TextStyle(color: Colors.blue[800]),
                            ),
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
                        style: GoogleFonts.roboto(fontSize: 20, color: Colors.white),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue[800]),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                      ),
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
    return FutureBuilder<List<Question>>(
      future: QuestionRepository.getSimulationQuestions(category),
      builder: (BuildContext context, AsyncSnapshot<List<Question>> snapshot) {
        if (snapshot.hasData) {
          return QuizScreen(
            category: category,
            questions: snapshot.data!,
            isSimulation: true,
          );
        } else if (snapshot.hasError) {
          return const Text('Error loading simulation questions.');
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  static Widget getShuffle(String category) {
    return FutureBuilder<List<Question>>(
      future: QuestionRepository.getQuestions(
          category, QuestionRepository.trainingBatchSize),
      builder: (BuildContext context, AsyncSnapshot<List<Question>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (snapshot.hasData) {
          return QuizScreen(
            category: category,
            questions: snapshot.data!,
            isSimulation: false,
          );
        }
        return Center(child: Text('No data available'));
      },
    );
  }

  static Widget getFresh(String category) {
    return FutureBuilder<List<Question>>(
      future: QuestionRepository.getFreshQuestions(
          category, QuestionRepository.trainingBatchSize),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return QuizScreen(
            category: category,
            questions: snapshot.data!,
            isSimulation: false,
          );
        } else if (snapshot.hasError) {
          return Center(child: Text("Error loading questions."));
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  static Widget getFailed(String category) {
    return FutureBuilder<List<Question>>(
      future: QuestionRepository.getFailedQuestions(
        category,
        QuestionRepository.trainingBatchSize,
      ),
      builder: (BuildContext context, AsyncSnapshot<List<Question>> snapshot) {
        if (snapshot.hasData) {
          return QuizScreen(
            category: category,
            questions: snapshot.data!,
            isSimulation: false,
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
              'Error: ${snapshot.error}',
              style: TextStyle(fontSize: 20.0),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
