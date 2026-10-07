import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/services/supabase_provider.dart';
import '../../domain/entities/exam_result.dart';
import '../../domain/entities/question.dart';

final questionsProvider = FutureProvider.family<List<ExamQuestion>, String>((ref, setId) async {
  final SupabaseClient client = ref.watch(supabaseClientProvider);
  final rows = await client.from('questions').select().eq('exam_set_id', setId).order('question_number');
  return rows.map((row) => ExamQuestion.fromMap(row)).toList();
});

class ExamSessionState {
  const ExamSessionState({this.index = 0, this.answers = const {}, this.remainingSeconds = 3000});
  final int index;
  final Map<String, int> answers;
  final int remainingSeconds;
  ExamSessionState copyWith({int? index, Map<String, int>? answers, int? remainingSeconds}) =>
      ExamSessionState(index: index ?? this.index, answers: answers ?? this.answers, remainingSeconds: remainingSeconds ?? this.remainingSeconds);
}

class ExamSessionNotifier extends StateNotifier<ExamSessionState> {
  ExamSessionNotifier() : super(const ExamSessionState());
  Timer? _timer;
  void start() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (state.remainingSeconds > 0) state = state.copyWith(remainingSeconds: state.remainingSeconds - 1);
    });
  }
  void select(String id, int option) => state = state.copyWith(answers: {...state.answers, id: option});
  void next(int total) { if (state.index < total - 1) state = state.copyWith(index: state.index + 1); }
  void previous() { if (state.index > 0) state = state.copyWith(index: state.index - 1); }
  ExamResult result(List<ExamQuestion> questions) {
    var correct = 0, reading = 0, listening = 0;
    for (final q in questions) {
      if (state.answers[q.id] == q.correctAnswer) {
        correct++;
        if (q.section == 'reading') reading++; else listening++;
      }
    }
    return ExamResult(total: questions.length, correct: correct, readingCorrect: reading, listeningCorrect: listening);
  }
  @override
  void dispose() { _timer?.cancel(); super.dispose(); }
}
final examSessionProvider = StateNotifierProvider.autoDispose<ExamSessionNotifier, ExamSessionState>((ref) => ExamSessionNotifier());
