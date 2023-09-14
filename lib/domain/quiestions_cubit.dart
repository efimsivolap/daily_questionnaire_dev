import 'package:daily_questionnaire_test/data/questions_repository.dart';
import 'package:daily_questionnaire_test/domain/question_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

sealed class QuestionsState {
  const QuestionsState();
}

class QuestionsData extends QuestionsState {
  const QuestionsData(this.data);

  final List<QuestionModel> data;
}

class QuestionsLoading extends QuestionsState {
  const QuestionsLoading();
}

class QuestionsError extends QuestionsState {
  const QuestionsError(this.message);

  final String message;
}

class QuestionsCubit extends Cubit<QuestionsState> {
  QuestionsCubit({
    required QuestionsRepository<List<QuestionModel>> questionsRepository,
  })  : _questionsRepository = questionsRepository,
        super(const QuestionsLoading()) {
    init();
  }

  final QuestionsRepository<List<QuestionModel>> _questionsRepository;

  Future<void> init() async {
    try {
      final questions = await _questionsRepository.getQuestions();
      emit(QuestionsData(questions));
    } catch (e, _) {
      emit(QuestionsError(e.toString()));
    }
  }

  Future<void> postQuestions(List<QuestionModel> questions) async {
    emit(const QuestionsLoading());
    try {
      await _questionsRepository.postQuestions(questions);

      emit(const QuestionsData([]));
    } catch (e, _) {
      emit(QuestionsError(e.toString()));
    }
  }
}
