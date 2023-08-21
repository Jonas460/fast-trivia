import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../quiz/question_screen.dart';
import '../view_quiz_screen/view_quiz_screen.dart';

class HomeScreen extends StatelessWidget {
  Future<Map<String, dynamic>> loadMockData() async {
    final String jsonData =
        await rootBundle.loadString('lib/assets/mock_data.json');
    return json.decode(jsonData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Fast Trivia')),
        backgroundColor: Colors.orange,
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(
            'lib/assets/logo.jpg',
            width: 240,
            height: 240,
          ),
          ElevatedButton(
            onPressed: () async {
              final mockData = await loadMockData();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => QuestionScreen(mockData),
                ),
              );
            },
            child: Text(
              'Iniciar Questionário',
              style: TextStyle(fontSize: 30),
            ),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(20),
              backgroundColor: Colors.orange,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SavedResultsScreen()),
              );
            },
            child: Text(
              'Questionários respondidos',
              style: TextStyle(fontSize: 25),
            ),
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10)),
          ),
        ],
      )),
    );
  }
}
