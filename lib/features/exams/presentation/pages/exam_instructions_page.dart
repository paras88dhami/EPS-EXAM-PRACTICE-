import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/services/ad_service.dart';
import '../../../../shared/widgets/primary_button.dart';

class ExamInstructionsPage extends StatefulWidget {
  const ExamInstructionsPage({required this.setId, super.key});
  final String setId;
  @override
  State<ExamInstructionsPage> createState() => _ExamInstructionsPageState();
}
class _ExamInstructionsPageState extends State<ExamInstructionsPage> {
  bool loading = false;
  Future<void> start() async {
    setState(() => loading = true);
    final earned = await AdService.showStartRewarded();
    if (!mounted) return;
    setState(() => loading = false);
    if (earned) context.go('/exam/' + widget.setId);
    else ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Watch the complete test ad to start this free practice test.')));
  }
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Exam Instructions')),
    body: Padding(padding: const EdgeInsets.all(24), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('EPS Practice Test', style: Theme.of(context).textTheme.headlineMedium),
      const SizedBox(height: 16),
      const Text('40 questions • Reading + Listening • 50 minutes'),
      const SizedBox(height: 8),
      const Text('Your selected answers are kept during this session. The timer starts after the start ad is completed.'),
      const Spacer(),
      PrimaryButton(label: loading ? 'Loading test ad...' : 'Watch Ad & Start', onPressed: loading ? null : start),
    ])),
  );
}
