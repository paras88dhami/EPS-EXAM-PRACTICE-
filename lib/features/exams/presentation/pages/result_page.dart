import 'package:flutter/material.dart';
import '../../domain/entities/exam_result.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({required this.result, super.key});
  final ExamResult result;
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Result')),
    body: Padding(padding: const EdgeInsets.all(24), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(result.percentage.toStringAsFixed(0) + '%', style: Theme.of(context).textTheme.displayMedium),
      const SizedBox(height: 20),
      Text('Correct: ' + result.correct.toString()),
      Text('Wrong: ' + result.wrong.toString()),
      Text('Reading correct: ' + result.readingCorrect.toString()),
      Text('Listening correct: ' + result.listeningCorrect.toString()),
    ])),
  );
}
