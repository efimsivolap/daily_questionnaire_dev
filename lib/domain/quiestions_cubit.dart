import 'package:daily_questionnaire_test/data/questions_repository.dart';
import 'package:daily_questionnaire_test/domain/question_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// todo состояние должно быть на sealed классах
class QuestionsCubit extends Cubit<List<QuestionModel>> {
  QuestionsCubit({
    required QuestionsRepository questionsRepository,
  })  : _questionsRepository = questionsRepository,
        super([]) {
    init();
  }

  final QuestionsRepository _questionsRepository;

  Future<void> init() async {
    emit(await _questionsRepository.getQuestions());
  }
}
