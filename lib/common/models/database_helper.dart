import 'dart:convert';

import 'package:fast_trivia/common/models/questionnaire_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String path = await getDatabasesPath();

    return openDatabase(
      join(path, 'questionnaires.db'),
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE questionnaires(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT,
      data TEXT,
      userResponses TEXT
    )
  ''');
  }

  Future<void> insertQuestionnaire(QuestionnaireModel questionnaire) async {
    final db = await database;
    await db.insert(
      'questionnaires',
      questionnaire.toMapWithoutId(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  Future<List<QuestionnaireModel>> getAllQuestionnaires() async {
    try {
      final db = await database;
      final List<Map<String, dynamic>> maps = await db.query('questionnaires');

      List<QuestionnaireModel> questionnaires = [];

      for (final map in maps) {
        final List<int> userResponses =
            List<int>.from(jsonDecode(map['userResponses']));

        questionnaires.add(
          QuestionnaireModel(
            id: map['id'],
            name: map['name'],
            data: jsonDecode(map['data']),
            userResponses: userResponses,
          ),
        );
      }

      return questionnaires;
    } catch (e) {
      print('Erro ao obter questionários: $e');
      return [];
    }
  }

  Future<List<int>> getUserResponses(int? questionnaireId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'questionnaires',
      where: 'id = ?',
      whereArgs: [questionnaireId],
    );

    if (maps.isNotEmpty) {
      final data = jsonDecode(maps[0]['data']);
      if (data.containsKey('userResponses')) {
        return data['userResponses'].cast<int>();
      }
    }

    return [];
  }
}
