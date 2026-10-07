import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/exams/domain/entities/exam_result.dart';
import '../../features/exams/presentation/pages/exam_instructions_page.dart';
import '../../features/exams/presentation/pages/exam_page.dart';
import '../../features/exams/presentation/pages/exam_sets_page.dart';
import '../../features/exams/presentation/pages/result_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/splash/presentation/pages/splash_page.dart';

final appRouterProvider = Provider<GoRouter>((ref) => GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(path: '/splash', builder: (_, __) => const SplashPage()),
    GoRoute(path: '/home', builder: (_, __) => const HomePage()),
    GoRoute(path: '/login', builder: (_, __) => const LoginPage()),
    GoRoute(path: '/sets', builder: (_, __) => const ExamSetsPage()),
    GoRoute(path: '/instructions/:id', builder: (_, state) => ExamInstructionsPage(setId: state.pathParameters['id']!)),
    GoRoute(path: '/exam/:id', builder: (_, state) => ExamPage(setId: state.pathParameters['id']!)),
    GoRoute(path: '/result', builder: (_, state) => ResultPage(result: state.extra! as ExamResult)),
  ],
));
