import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

import '../domain/question_model.dart';

class QuestionsRepository {
  const QuestionsRepository();

  Future<List<QuestionModel>> getQuestions() async {
    final String source = await rootBundle.loadString('assets/questions.json');
    final decoded =
        (await json.decode(source) as List).cast<Map<String, dynamic>>();
    return decoded.map(QuestionModel.fromJson).toList();
  }

  Future<void> postQuestions(List<QuestionModel> questions) async {}
}
