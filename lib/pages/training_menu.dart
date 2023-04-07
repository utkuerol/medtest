import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medtest/pages/home.dart';
import 'package:medtest/pages/training.dart';

class TrainingMenu extends StatelessWidget {
  @override
  Widget build(context) => Scaffold(
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
                  "Einzelne Fragen",
                  style: Theme.of(context).textTheme.headlineLarge,
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Text(
                          'Shuffle',
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Text(
                          'Zuletzt falsch',
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Text(
                          'Frisch',
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Divider(
                  height: 5,
                  thickness: 5,
                ),
              ),
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
                  children: [
                    ElevatedButton(
                      onPressed: () => showDialog(
                          context: context,
                          builder: (context) {
                            return SimpleDialog(
                              title: const Text(
                                  'Wie möchtest du diese Kategorie üben?'),
                              children: <Widget>[
                                SimpleDialogOption(
                                  onPressed: () => Get.off(QuestionCard()),
                                  child: const Text('Simulation'),
                                ),
                                SimpleDialogOption(
                                  onPressed: () {},
                                  child: const Text('Shuffle'),
                                ),
                                SimpleDialogOption(
                                  onPressed: () {},
                                  child: const Text('Zuletzt falsch'),
                                ),
                                SimpleDialogOption(
                                  onPressed: () {},
                                  child: const Text('Frisch'),
                                ),
                              ],
                            );
                          }),
                      child: const Text(
                        'Muster zuordnen',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text(
                        'Med.-naturwiss. Grundverständnis',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text(
                        'Schlauchfiguren',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text(
                        'Quantitative und formale Probleme',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text(
                        'Figuren/Fakten',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text(
                        'Textverständnis',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text(
                        'Reproduktionsphase',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text(
                        'Diagramme und Tabellen',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text(
                        'Konzentration und sorgfältiges Arbeiten',
                        style: TextStyle(fontSize: 16),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
