import 'package:flutter/material.dart';

import '../result_screen/result_screen.dart';

class QuestionScreen extends StatefulWidget {
  final Map<String, dynamic> questionnaire;

  QuestionScreen(this.questionnaire);

  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  int currentQuestionIndex = 0;
  List<int> userResponses = [];

  void answerQuestion(int selectedOption) {
    setState(() {
      userResponses.add(selectedOption);
      if (currentQuestionIndex <
          widget.questionnaire['questionario']['questoes'].length - 1) {
        currentQuestionIndex++;
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  ResultScreen(userResponses, widget.questionnaire)),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion =
        widget.questionnaire['questionario']['questoes'][currentQuestionIndex];
    final totalQuestions =
        widget.questionnaire['questionario']['questoes'].length;

    return Scaffold(
      appBar: AppBar(
          title: const Text('Questionário'), backgroundColor: Colors.orange),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Text(
                    "Pergunta ${currentQuestionIndex + 1} de $totalQuestions"),
              ),
              Text(
                'Pergunta: ${currentQuestion['pergunta']}',
                style: TextStyle(fontSize: 20),
              ),
              for (var option in currentQuestion['alternativas'])
                ElevatedButton(
                  onPressed: () {
                    answerQuestion(option['id']);
                  },
                  child: Text(option['titulo']),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    minimumSize: Size(double.infinity, 48),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
