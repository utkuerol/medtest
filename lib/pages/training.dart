import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuestionCard extends StatelessWidget {
  String demoQuestion =
      "random question afjkhakjfh akjghakjf aksjfhakjfh qwrkjhaf akfjhakfj quiryaf kjahsfkjhaf askfjhajk?";
  String demoOption1 =
      "option 1 asfjkhkaf akfjhakjf akjfhajkfha fkjahfjkahfjka";
  String demoOption2 = "option 2 asfjhajkfhjkafh ajkfhjkafhaj fhakjh";
  String demoOption3 = "option 3 askfjhajkfh hfakjshfjk hquiw hfiquwhf ahj fa";
  String demoOption4 = "option 4 askfhakjfh jkqhfkqui asfkjhajkfh akjqiurwy ";
  String demoOption5 = "option 5 asjkfhkjah fquiwryuiqyr ajkfhajk fholk jkl ";

  @override
  Widget build(context) => Scaffold(
      appBar: AppBar(
        title: const Text("MedTest"),
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {},
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
                "Question X:",
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Column(
                children: [
                  Text(
                    demoQuestion,
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: ListView(
                  children: [
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          demoOption1,
                          style: TextStyle(fontSize: 20),
                        )),
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          demoOption2,
                          style: TextStyle(fontSize: 20),
                        )),
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          demoOption3,
                          style: TextStyle(fontSize: 20),
                        )),
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          demoOption4,
                          style: TextStyle(fontSize: 20),
                        )),
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          demoOption5,
                          style: TextStyle(fontSize: 20),
                        )),
                  ],
                ),
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
                        'Überspringen',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Text(
                        'Senden',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ));
}
