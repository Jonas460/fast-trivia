import 'package:flutter/material.dart';

import '../../common/models/database_helper.dart';
import '../../common/models/questionnaire_model.dart';
import '../details_screen/details_screen.dart';

class SavedResultsScreen extends StatefulWidget {
  @override
  _SavedResultsScreenState createState() => _SavedResultsScreenState();
}

class _SavedResultsScreenState extends State<SavedResultsScreen> {
  final DatabaseHelper dbHelper = DatabaseHelper();
  List<QuestionnaireModel> savedQuestionnaires = [];

  @override
  void initState() {
    super.initState();
    _loadSavedQuestionnaires();
  }

  Future<void> _loadSavedQuestionnaires() async {
    List<QuestionnaireModel> questionnaires =
        await dbHelper.getAllQuestionnaires();
    setState(() {
      savedQuestionnaires = questionnaires;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Resultados Salvos'), backgroundColor: Colors.orange),
      body: ListView.builder(
        itemCount: savedQuestionnaires.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(savedQuestionnaires[index].name),
            onTap: () async {
              List<int> userResponses = await dbHelper
                  .getUserResponses(savedQuestionnaires[index].id);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      DetailsScreen(savedQuestionnaires[index], userResponses),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
