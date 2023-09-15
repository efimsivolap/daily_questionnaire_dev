import 'package:daily_questionnaire_test/domain/question_model.dart';
import 'package:daily_questionnaire_test/domain/quiestions_cubit.dart';
import 'package:daily_questionnaire_test/ui/widgets/rating_stars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ModalSheetWidget extends StatelessWidget {
  final QuestionModel question;
  final TextEditingController answerController;

  const ModalSheetWidget({
    required this.question,
    required this.answerController,
  });

  @override
  Widget build(BuildContext context) {
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
            RatingStars(
              maxStars: 8,
              existingStars: question.maxStars,
            ),
            const SizedBox(height: 16),
            Text(
              question.canWriteReview ? 'Write a review' : 'Review is disabled',
              style: TextStyle(
                color: question.canWriteReview
                    ? const Color(0xFF565656)
                    : const Color(0xFFC0C0C0),
                fontSize: 16,
                fontWeight: FontWeight.w500,
                height: 1,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: answerController,
              maxLines: 10,
              enabled: question.canWriteReview,
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
                onPressed: () {
                  if (question.canWriteReview) {
                    context.read<QuestionsCubit>().postAnswers();
                  }
                },
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
  }
}
