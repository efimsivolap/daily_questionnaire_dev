import 'package:daily_questionnaire_test/domain/question_model.dart';
import 'package:daily_questionnaire_test/domain/quiestions_cubit.dart';
import 'package:daily_questionnaire_test/utils/data_time.dart';
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

class QuestionCard extends StatelessWidget {
  QuestionCard({
    Key? key,
    required this.question,
    required this.questionNumber,
  }) : super(key: key);

  final QuestionModel question;
  final int questionNumber;
  final TextEditingController answerController = TextEditingController();

  void _showModalSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 2,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.close,
                        size: 24,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                Text(
                  question.title,
                  maxLines: 2,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                if (question.subtitle != null)
                  Text(
                    question.subtitle!,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      height: 1.43,
                    ),
                  ),
                const SizedBox(height: 16),
                RatingStars(maxStars: 8, existingStars: question.maxStars),
                const SizedBox(height: 16),
                const Text(
                  'Write a review',
                  style: TextStyle(
                    color: Color(0xFFC0C0C0),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    height: 1,
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: answerController,
                  maxLines: 10,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14.0),
                      borderSide: const BorderSide(
                        color: Color(0xFFDBDBDB),
                        width: 0.25,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        color: Colors.blue,
                        width: 1,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 230),
                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(0, 186, 244, 1),
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    child: const Text(
                      'Confirm',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        height: 1,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        border: Border.all(
          color: const Color(0xFFDBDBDB),
          width: 0.50,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundColor: const Color.fromRGBO(0, 186, 244, 1),
                  child: Text(
                    questionNumber.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        question.title,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          height: 1,
                        ),
                      ),
                      const SizedBox(height: 9),
                      if (question.subtitle != null)
                        Text(
                          question.subtitle!,
                          style: const TextStyle(
                            color: Color(0xFFC0C0C0),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            height: 1,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            RatingStars(maxStars: 8, existingStars: question.maxStars),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.bottomRight,
              child: GestureDetector(
                onTap: () => _showModalSheet(context),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Write a review',
                      style: const TextStyle(
                        color: Color(0xFF565656),
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        height: 1,
                      ),
                    ),
                    const SizedBox(width: 10),
                    IconTheme(
                      data: IconThemeData(
                        size: 16,
                        color: const Color(0xFF565656),
                      ),
                      child: Icon(Icons.arrow_forward_ios),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RatingStars extends StatelessWidget {
  const RatingStars({
    Key? key,
    required this.maxStars,
    required this.existingStars,
  }) : super(key: key);

  final int maxStars;
  final int existingStars;

  @override
  Widget build(BuildContext context) {
    final List<Widget> stars = [];
    for (int i = 1; i <= maxStars; i++) {
      if (i <= existingStars) {
        stars.add(
          const Icon(
            Icons.star,
            color: Color.fromRGBO(0, 186, 244, 1),
            size: 38,
          ),
        );
      } else {
        stars.add(
          const Icon(
            Icons.star,
            color: Color(0xFFEDEDED),
            size: 38,
          ),
        );
      }
    }
    return Row(children: stars);
  }
}
