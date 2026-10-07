import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/services/ad_service.dart';
import '../providers/exam_session_provider.dart';

class ExamPage extends ConsumerStatefulWidget {
  const ExamPage({required this.setId, super.key});
  final String setId;
  @override
  ConsumerState<ExamPage> createState() => _ExamPageState();
}
class _ExamPageState extends ConsumerState<ExamPage> {
  @override
  void initState() { super.initState(); Future.microtask(() => ref.read(examSessionProvider.notifier).start()); }

  Future<void> finish(List questions) async {
    final result = ref.read(examSessionProvider.notifier).result(questions.cast());
    await AdService.showResultInterstitial();
    if (!mounted) return;
    context.go('/result', extra: result);
  }

  @override
  Widget build(BuildContext context) {
    final asyncQuestions = ref.watch(questionsProvider(widget.setId));
    final session = ref.watch(examSessionProvider);
    return asyncQuestions.when(
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, _) => Scaffold(body: Center(child: Text('Unable to load exam: ' + e.toString()))),
      data: (questions) {
        if (questions.isEmpty) return const Scaffold(body: Center(child: Text('This set has no questions yet.')));
        final q = questions[session.index];
        final min = session.remainingSeconds ~/ 60;
        final sec = session.remainingSeconds % 60;
        if (session.remainingSeconds == 0) Future.microtask(() => finish(questions));
        return Scaffold(
          appBar: AppBar(title: Text('Question ' + q.number.toString() + '/' + questions.length.toString()), actions: [
            Padding(padding: const EdgeInsets.all(16), child: Text(min.toString().padLeft(2, '0') + ':' + sec.toString().padLeft(2, '0'))),
          ]),
          body: ListView(padding: const EdgeInsets.all(20), children: [
            Chip(label: Text(q.section.toUpperCase())),
            if (q.text != null) Padding(padding: const EdgeInsets.symmetric(vertical: 16), child: Text(q.text!, style: Theme.of(context).textTheme.titleLarge)),
            if (q.imagePath != null) Padding(padding: const EdgeInsets.only(bottom: 16), child: Image.network(q.imagePath!)),
            if (q.audioPath != null) const Card(child: ListTile(leading: Icon(Icons.volume_up), title: Text('Listening audio available'))),
            ...List.generate(q.options.length, (i) => RadioListTile<int>(
              value: i, groupValue: session.answers[q.id],
              onChanged: (v) { if (v != null) ref.read(examSessionProvider.notifier).select(q.id, v); },
              title: Text(q.options[i]),
            )),
          ]),
          bottomNavigationBar: SafeArea(child: Padding(padding: const EdgeInsets.all(16), child: Row(children: [
            Expanded(child: OutlinedButton(onPressed: session.index == 0 ? null : () => ref.read(examSessionProvider.notifier).previous(), child: const Text('Previous'))),
            const SizedBox(width: 12),
            Expanded(child: FilledButton(
              onPressed: session.index == questions.length - 1 ? () => finish(questions) : () => ref.read(examSessionProvider.notifier).next(questions.length),
              child: Text(session.index == questions.length - 1 ? 'Submit' : 'Next'),
            )),
          ]))),
        );
      },
    );
  }
}
