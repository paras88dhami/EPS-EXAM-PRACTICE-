import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/config/supabase_config.dart';
import '../../../../core/services/supabase_provider.dart';
import '../../data/repositories/supabase_auth_repository.dart';
import '../../domain/entities/app_user.dart';
import '../../domain/repositories/auth_repository.dart';

final authRepositoryProvider = Provider<AuthRepository?>((ref) {
  if (!SupabaseConfig.isConfigured) return null;
  return SupabaseAuthRepository(ref.watch(supabaseClientProvider));
});
final authStateProvider = StreamProvider<AppUser?>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return repository == null ? Stream<AppUser?>.value(null) : repository.authStateChanges;
});
