import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

import '../domain/question_model.dart';

class QuestionsRepository {
  const QuestionsRepository();

  Future<List<QuestionModel>> getQuestions() async {
    final String source = await rootBundle.loadString('assets/questions.json');
    final List<Map<String, dynamic>> data =
        List<Map<String, dynamic>>.from(json.decode(source));
    print(data);
    return data.map((e) => QuestionModel.fromJson(e)).toList();
  }

  Future<void> postQuestions(List<QuestionModel> questions) async {}
}
