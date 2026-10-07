import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/config/supabase_config.dart';
import '../../../../core/services/supabase_provider.dart';
import '../../data/repositories/supabase_exam_repository.dart';
import '../../domain/entities/exam_set.dart';
import '../../domain/repositories/exam_repository.dart';

final examRepositoryProvider = Provider<ExamRepository?>((ref) {
  if (!SupabaseConfig.isConfigured) return null;
  return SupabaseExamRepository(ref.watch(supabaseClientProvider));
});
final examSetsProvider = FutureProvider<List<ExamSet>>((ref) async {
  final repository = ref.watch(examRepositoryProvider);
  return repository == null ? const [] : repository.getPublishedSets();
});
