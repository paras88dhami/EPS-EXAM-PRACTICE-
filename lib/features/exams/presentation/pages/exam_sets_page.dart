import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/widgets/test_banner_ad.dart';
import '../providers/exam_providers.dart';

class ExamSetsPage extends ConsumerWidget {
  const ExamSetsPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sets = ref.watch(examSetsProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Practice Sets')),
      bottomNavigationBar: const SafeArea(child: Center(child: TestBannerAd())),
      body: sets.when(
        data: (items) {
          if (items.isEmpty) return const Center(child: Text('No published sets yet.'));
          return RefreshIndicator(
            onRefresh: () => ref.refresh(examSetsProvider.future),
            child: ListView.separated(
              padding: const EdgeInsets.all(16), itemCount: items.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final examSet = items[index];
                return Card(child: ListTile(
                  onTap: () => context.push('/instructions/' + examSet.id),
                  title: Text(examSet.title),
                  subtitle: Text('Set ' + examSet.setNumber.toString()),
                  trailing: Chip(label: Text(examSet.isFree ? 'FREE' : 'PREMIUM')),
                ));
              },
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Unable to load sets: ' + error.toString())),
      ),
    );
  }
}
