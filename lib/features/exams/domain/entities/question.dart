class ExamQuestion {
  const ExamQuestion({
    required this.id,
    required this.examSetId,
    required this.number,
    required this.section,
    required this.options,
    required this.correctAnswer,
    this.text,
    this.imagePath,
    this.audioPath,
  });
  final String id;
  final String examSetId;
  final int number;
  final String section;
  final String? text;
  final String? imagePath;
  final String? audioPath;
  final List<String> options;
  final int correctAnswer;

  factory ExamQuestion.fromMap(Map<String, dynamic> row) => ExamQuestion(
    id: row['id'] as String,
    examSetId: row['exam_set_id'] as String,
    number: row['question_number'] as int,
    section: row['section'] as String,
    text: row['question_text'] as String?,
    imagePath: row['image_path'] as String?,
    audioPath: row['audio_path'] as String?,
    options: List<String>.from(row['options'] as List),
    correctAnswer: row['correct_answer'] as int,
  );
}
