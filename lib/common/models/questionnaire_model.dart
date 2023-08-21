import 'dart:convert';

class QuestionnaireModel {
  int? id;
  String name;
  Map<String, dynamic> data;
  List<int> userResponses;

  QuestionnaireModel(
      {required this.id,
      required this.name,
      required this.data,
      required this.userResponses});

  QuestionnaireModel.withoutId(
      {required this.name, required this.data, required this.userResponses});

  Map<String, dynamic> toMapWithoutId() {
    return {
      'name': name,
      'data': jsonEncode(data),
      'userResponses': jsonEncode(userResponses),
    };
  }
}
