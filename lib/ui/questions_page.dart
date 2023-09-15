import 'package:daily_questionnaire_test/domain/question_model.dart';
import 'package:daily_questionnaire_test/domain/quiestions_cubit.dart';
import 'package:daily_questionnaire_test/ui/widgets/question_card.dart';
import 'package:daily_questionnaire_test/utils/data_time_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuestionsPage extends StatelessWidget {
  const QuestionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<QuestionsCubit, QuestionsState>(
        builder: (context, questionsState) => switch (questionsState) {
          QuestionsData(data: final data) => QuestionsWidget(questions: data),
          QuestionsLoading() =>
            const Center(child: CircularProgressIndicator()),
          QuestionsError(message: final message) =>
            Center(child: Text(message)),
        },
      ),
    );
  }
}

class QuestionsWidget extends StatelessWidget {
  const QuestionsWidget({super.key, required this.questions});

  final List<QuestionModel> questions;

  @override
  Widget build(BuildContext context) {
    final todayDate = DateTime.now();
    final formattedDate =
        '${getMonthAbbreviation(todayDate)} ${getDayWithSuffix(todayDate)}, ${todayDate.year}, ${getWeekday(todayDate)}';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 70),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Daily Questionnaire',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 32,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  height: 0.62,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                formattedDate,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  height: 1.43,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: questions.length,
            itemBuilder: (context, index) {
              final question = questions[index];

              return QuestionCard(
                question: question,
                questionNumber: index + 1,
              );
            },
          ),
        ),
      ],
    );
  }
}
