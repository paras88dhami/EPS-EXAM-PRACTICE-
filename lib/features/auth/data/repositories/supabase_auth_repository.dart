import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/entities/app_user.dart';
import '../../domain/repositories/auth_repository.dart';

class SupabaseAuthRepository implements AuthRepository {
  SupabaseAuthRepository(this._client);
  final SupabaseClient _client;
  AppUser? _mapUser(User? user) => user == null ? null : AppUser(id: user.id, email: user.email);
  @override
  Stream<AppUser?> get authStateChanges => _client.auth.onAuthStateChange.map((e) => _mapUser(e.session?.user));
  @override
  AppUser? get currentUser => _mapUser(_client.auth.currentUser);
  @override
  Future<void> signIn({required String email, required String password}) async =>
      _client.auth.signInWithPassword(email: email, password: password);
  @override
  Future<void> signUp({required String email, required String password}) async =>
      _client.auth.signUp(email: email, password: password);
  @override
  Future<void> signOut() => _client.auth.signOut();
}
