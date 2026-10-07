import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/config/supabase_config.dart';
import '../../../../shared/widgets/primary_button.dart';
import '../providers/auth_providers.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});
  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _loading = false;

  @override
  void dispose() { _email.dispose(); _password.dispose(); super.dispose(); }

  Future<void> _submit({required bool createAccount}) async {
    final repository = ref.read(authRepositoryProvider);
    if (repository == null) return;
    setState(() => _loading = true);
    try {
      if (createAccount) {
        await repository.signUp(email: _email.text.trim(), password: _password.text);
      } else {
        await repository.signIn(email: _email.text.trim(), password: _password.text);
      }
    } catch (error) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.toString())));
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!SupabaseConfig.isConfigured) {
      return const Scaffold(body: Center(child: Padding(
        padding: EdgeInsets.all(24),
        child: Text('Supabase is not configured yet. Add SUPABASE_URL and SUPABASE_ANON_KEY with --dart-define.', textAlign: TextAlign.center),
      )));
    }
    return Scaffold(
      appBar: AppBar(title: const Text('Sign in')),
      body: ListView(padding: const EdgeInsets.all(24), children: [
        TextField(controller: _email, keyboardType: TextInputType.emailAddress, decoration: const InputDecoration(labelText: 'Email')),
        const SizedBox(height: 12),
        TextField(controller: _password, obscureText: true, decoration: const InputDecoration(labelText: 'Password')),
        const SizedBox(height: 24),
        PrimaryButton(label: _loading ? 'Please wait...' : 'Sign in', onPressed: _loading ? null : () => _submit(createAccount: false)),
        TextButton(onPressed: _loading ? null : () => _submit(createAccount: true), child: const Text('Create account')),
      ]),
    );
  }
}
