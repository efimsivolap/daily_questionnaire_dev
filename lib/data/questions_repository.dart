import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

import '../domain/question_model.dart';

class QuestionsRepository {
  const QuestionsRepository();

  Future<List<QuestionModel>> getQuestions() async {
    // имитируем задержку, словно получаем данные из сети
    Future.delayed(const Duration(seconds: 1));

    final String source = await rootBundle.loadString('assets/questions.json');
    final decoded =
        (await json.decode(source) as List).cast<Map<String, dynamic>>();

    for (final questionData in decoded) {
      final maxStars = questionData['maxStars'] as int;

      if (maxStars > 8 || maxStars < 3) {
        throw Exception(
            'Invalid JSON configuration: maxStars should be between 3 and 8 for each question');
      }
    }

    return decoded.map(QuestionModel.fromJson).toList();
  }

  Future<void> postQuestions(List<QuestionModel> questions) async {}
}
