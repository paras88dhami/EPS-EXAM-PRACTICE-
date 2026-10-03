import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/entities/exam_set.dart';
import '../../domain/repositories/exam_repository.dart';

class SupabaseExamRepository implements ExamRepository {
  SupabaseExamRepository(this._client);
  final SupabaseClient _client;
  @override
  Future<List<ExamSet>> getPublishedSets() async {
    final rows = await _client.from('exam_sets').select('id,title,set_number,is_free,is_published').eq('is_published', true).order('set_number');
    return rows.map((row) => ExamSet(
      id: row['id'] as String,
      title: row['title'] as String,
      setNumber: row['set_number'] as int,
      isFree: row['is_free'] as bool,
      isPublished: row['is_published'] as bool,
    )).toList();
  }
}
