import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

import '../domain/question_model.dart';

class QuestionsRepository {
  const QuestionsRepository();

  Future<List<QuestionModel>> getQuestions() async {
    final String source = await rootBundle.loadString('assets/questions.json');
    final data = await json.decode(source) as List<Map<String, dynamic>>;
    return data.map(QuestionModel.fromJson).toList();
  }

  Future<void> postQuestions(List<QuestionModel> questions) async {}
}
