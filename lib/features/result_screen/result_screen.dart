import 'package:flutter/material.dart';

import '../../common/models/database_helper.dart';
import '../../common/models/questionnaire_model.dart';
import '../home/home.dart';

class ResultScreen extends StatefulWidget {
  final List<int> userResponses;
  final Map<String, dynamic> questionnaire;

  ResultScreen(this.userResponses, this.questionnaire);

  int calculateScore() {
    int score = 0;
    for (int i = 0; i < userResponses.length; i++) {
      if (userResponses[i] ==
          questionnaire['questionario']['questoes'][i]['gabarito']) {
        score++;
      }
    }
    return score;
  }

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  TextEditingController _nameController = TextEditingController();
  final DatabaseHelper dbHelper = DatabaseHelper();

  int calculateScore(
      Map<String, dynamic> questionnaire, List<int> userResponses) {
    int score = 0;

    for (int i = 0; i < userResponses.length; i++) {
      int userResponse = userResponses[i];
      int correctAnswer =
          questionnaire['questionario']['questoes'][i]['gabarito'];

      if (userResponse == correctAnswer) {
        score++;
      }
    }

    return score;
  }

  @override
  Widget build(BuildContext context) {
    int totalScore = calculateScore(widget.questionnaire, widget.userResponses);

    return Scaffold(
      appBar: AppBar(
        title: Text('Resultado'),
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Total de questões acertadas: $totalScore'),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Nome',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange, width: 2.0),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange, width: 2.0),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  labelStyle: TextStyle(color: Colors.orange),
                  hintStyle: TextStyle(color: Colors.black),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                QuestionnaireModel questionnaireModel = QuestionnaireModel(
                  name: _nameController.text,
                  data: widget.questionnaire,
                  id: 1,
                  userResponses: widget.userResponses,
                );
                await dbHelper.insertQuestionnaire(questionnaireModel);

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                  (route) => false,
                );
              },
              child: Text('Salvar'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(20),
                backgroundColor: Colors.orange,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
