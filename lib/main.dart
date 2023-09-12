import 'package:daily_questionnaire_test/ui/questions_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/questions_repository.dart';
import 'domain/quiestions_cubit.dart';

void main() {
  runApp(
    BlocProvider<QuestionsCubit>(
      create: (BuildContext context) => QuestionsCubit(
        questionsRepository: const QuestionsRepository(),
      ),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: QuestionsPage(),
    );
  }
}
