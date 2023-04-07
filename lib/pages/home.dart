import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medtest/pages/training_menu.dart';
import 'package:percent_indicator/percent_indicator.dart';

class Home extends StatelessWidget {
  @override
  Widget build(context) => Scaffold(
        appBar: AppBar(title: const Text("MedTest")),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  "EMS Trainer",
                  style: Theme.of(context).textTheme.headlineLarge,
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CircularPercentIndicator(
                      radius: 60,
                      lineWidth: 10,
                      percent: 0.5,
                      center: new Text("Geübt %"),
                      progressColor: Colors.green,
                    ),
                    CircularPercentIndicator(
                      radius: 60,
                      lineWidth: 10,
                      percent: 0.8,
                      center: new Text("Korrektheit %"),
                      progressColor: Colors.green,
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
                padding: const EdgeInsets.all(15),
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      'Prüfungssimulation',
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: ElevatedButton(
                  onPressed: () => Get.off(TrainingMenu()),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      'Training',
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      'Statistik',
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
