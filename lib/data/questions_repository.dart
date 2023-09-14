import 'dart:convert';

import 'package:daily_questionnaire_test/domain/question_model.dart';
import 'package:flutter/services.dart' show rootBundle;

abstract interface class QuestionsRepository<T> {
  Future<T> getQuestions();
  Future<void> postQuestions(T questions);
}

class QuestionsRepositoryImpl
    implements QuestionsRepository<List<QuestionModel>> {
  const QuestionsRepositoryImpl();

  @override
  Future<List<QuestionModel>> getQuestions() async {
    // имитируем задержку, словно получаем данные из сети
    await Future.delayed(const Duration(seconds: 1));

    final String source = await rootBundle.loadString('assets/questions.json');
    final decoded =
        (await json.decode(source) as List).cast<Map<String, dynamic>>();

    final questions = decoded.map(QuestionModel.fromJson).toList();

    if (questions.any(
      (element) => element.maxStars > 8 || element.maxStars < 3,
    )) {
      throw Exception(
          'Invalid JSON configuration: maxStars should be between 3 and 8 for each question');
    } else {
      return questions;
    }
  }

  @override
  Future<void> postQuestions(List<QuestionModel> questions) async {
    // имитируем отправку, просто выводя в консоль
    await Future.delayed(const Duration(seconds: 1));
    // ignore: avoid_print
    print(questions);
  }
}
