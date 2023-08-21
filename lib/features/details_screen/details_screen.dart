import 'package:flutter/material.dart';

import '../../common/models/questionnaire_model.dart';

class DetailsScreen extends StatelessWidget {
  final QuestionnaireModel questionnaire;
  final List<int> userResponses;

  DetailsScreen(this.questionnaire, this.userResponses);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do Questionário'),
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Nome do Questionário: ${questionnaire.name}'),
            const SizedBox(height: 20),
            const Text('Respostas Certas:'),
            for (var question in questionnaire.data['questionario']['questoes'])
              Text(
                '${question['id']} - Resposta: ${question['gabarito']}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            const SizedBox(height: 20),
            const Text(
              'Respostas do Usuário:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            for (int i = 0;
                i < questionnaire.data['questionario']['questoes'].length;
                i++)
              Text(
                '${questionnaire.data['questionario']['questoes'][i]['id']} - Resposta: ${questionnaire.userResponses[i]}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: questionnaire.userResponses[i] ==
                          questionnaire.data['questionario']['questoes'][i]
                              ['gabarito']
                      ? Colors.green
                      : Colors.red,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
