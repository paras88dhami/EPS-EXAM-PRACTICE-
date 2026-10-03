import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../shared/widgets/primary_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppConstants.appName)),
      body: SafeArea(child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Prepare for EPS-TOPIK', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text('Practice reading and listening exams. New published sets can be loaded from Supabase without releasing a new app version.'),
          const SizedBox(height: 24),
          PrimaryButton(label: 'Browse Practice Sets', onPressed: () => context.push('/sets')),
          const SizedBox(height: 12),
          OutlinedButton(onPressed: () => context.push('/login'), child: const Text('Sign in / Create account')),
        ]),
      )),
    );
  }
}
