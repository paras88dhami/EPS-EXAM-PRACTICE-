import '../entities/exam_set.dart';
abstract interface class ExamRepository {
  Future<List<ExamSet>> getPublishedSets();
}
