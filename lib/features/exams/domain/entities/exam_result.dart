class ExamResult {
  const ExamResult({required this.total, required this.correct, required this.readingCorrect, required this.listeningCorrect});
  final int total;
  final int correct;
  final int readingCorrect;
  final int listeningCorrect;
  int get wrong => total - correct;
  double get percentage => total == 0 ? 0 : (correct / total) * 100;
}
