import 'package:eps_exam_practice/app/app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('app starts on splash screen', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: EpsExamApp()));
    expect(find.text('EPS Exam Practice'), findsOneWidget);
  });
}
