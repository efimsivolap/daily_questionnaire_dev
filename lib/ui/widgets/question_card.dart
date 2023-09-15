import 'package:daily_questionnaire_test/domain/question_model.dart';
import 'package:daily_questionnaire_test/domain/quiestions_cubit.dart';
import 'package:daily_questionnaire_test/ui/widgets/modal_sheet.dart';
import 'package:daily_questionnaire_test/ui/widgets/rating_stars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuestionCard extends StatefulWidget {
  const QuestionCard({
    Key? key,
    required this.question,
    required this.questionNumber,
  }) : super(key: key);

  final QuestionModel question;
  final int questionNumber;

  @override
  State<QuestionCard> createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  late final TextEditingController answerController;

  @override
  void initState() {
    super.initState();

    answerController = TextEditingController();
    answerController.addListener(() {
      context
          .read<QuestionsCubit>()
          .changeAnswer(widget.questionNumber, answerController.text);
    });
  }

  @override
  void dispose() {
    answerController.dispose();
    super.dispose();
  }

  void _showModalSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ModalSheetWidget(
          question: widget.question,
          answerController: answerController,
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
                    widget.questionNumber.toString(),
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
                        widget.question.title,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          height: 1,
                        ),
                      ),
                      const SizedBox(height: 9),
                      if (widget.question.subtitle != null)
                        Text(
                          widget.question.subtitle!,
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
            RatingStars(maxStars: 8, existingStars: widget.question.maxStars),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.bottomRight,
              child: GestureDetector(
                onTap: () {
                  if (widget.question.canWriteReview) {
                    _showModalSheet(context);
                  }
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.question.canWriteReview
                          ? 'Write a review'
                          : 'Review is disabled',
                      style: TextStyle(
                        color: widget.question.canWriteReview
                            ? const Color(0xFF565656)
                            : const Color(0xFFC0C0C0),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        height: 1,
                      ),
                    ),
                    const SizedBox(width: 10),
                    widget.question.canWriteReview
                        ? const IconTheme(
                            data: IconThemeData(
                              size: 16,
                              color: Color(0xFF565656),
                            ),
                            child: Icon(Icons.arrow_forward_ios),
                          )
                        : const SizedBox(),
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
