import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/colors.dart';
import '../../../core/widgets/wood_button.dart';
import '../../../core/widgets/wood_text_field.dart';
import '../../../core/widgets/tropical_background.dart';
import '../../../core/widgets/youme_logo_3d.dart';
import '../../../core/router/app_router.dart';
import '../bloc/auth_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  late AnimationController _entryController;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

  final _startTime = DateTime.now();
  int? _arithmeticAnswer;
  final _arithmeticCtrl = TextEditingController();
  late int _num1, _num2;

  @override
  void initState() {
    super.initState();
    _entryController = AnimationController(vsync: this, duration: const Duration(milliseconds: 700));
    _fadeAnim = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _entryController, curve: Curves.easeOut));
    _slideAnim = Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero).animate(CurvedAnimation(parent: _entryController, curve: Curves.easeOutExpo));
    _entryController.forward();
    _num1 = 3 + DateTime.now().millisecond % 10;
    _num2 = 2 + DateTime.now().second % 8;
    _arithmeticAnswer = _num1 + _num2;
  }

  @override
  void dispose() {
    _entryController.dispose();
    _emailCtrl.dispose();
    _passCtrl.dispose();
    _arithmeticCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    final fillTime = DateTime.now().difference(_startTime).inSeconds;
    if (fillTime < 3) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Veuillez compléter le formulaire plus lentement.')));
      return;
    }
    final answer = int.tryParse(_arithmeticCtrl.text.trim());
    if (answer != _arithmeticAnswer) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Réponse au calcul incorrecte.')));
      return;
    }
    context.read<AuthBloc>().add(AuthSignInRequested(_emailCtrl.text.trim(), _passCtrl.text));
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticated) context.go(AppRoutes.home);
        if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: AppColors.error,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },
      child: Scaffold(
        body: TropicalBackground(
          showSunset: false,
          child: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: FadeTransition(
                opacity: _fadeAnim,
                child: SlideTransition(
                  position: _slideAnim,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 20),
                      YouMeLogo3D(
                        scale: 1.1,
                        isDarkTheme: isDark,
                      ),
                      const SizedBox(height: 32),
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(28),
                          color: isDark
                              ? AppColors.glassSurfaceDark
                              : Colors.white.withOpacity(0.88),
                          border: Border.all(
                            color: isDark
                                ? AppColors.glassBorderDark
                                : AppColors.glassBorderLight,
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.35),
                              blurRadius: 25,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Text(
                                'Connexion',
                                style: TextStyle(
                                  fontFamily: 'Playfair',
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: isDark ? AppColors.mintSubtle : AppColors.emeraldPrimary,
                                ),
                              ),
                              const SizedBox(height: 20),
                              WoodTextField(
                                label: 'Adresse email',
                                controller: _emailCtrl,
                                keyboardType: TextInputType.emailAddress,
                                prefixIcon: Icons.email_outlined,
                                textInputAction: TextInputAction.next,
                                validator: (v) {
                                  if (v == null || v.isEmpty) return 'Email requis';
                                  if (!v.contains('@')) return 'Email invalide';
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16),
                              WoodTextField(
                                label: 'Mot de passe',
                                controller: _passCtrl,
                                obscureText: true,
                                prefixIcon: Icons.lock_outline,
                                textInputAction: TextInputAction.next,
                                validator: (v) {
                                  if (v == null || v.isEmpty) return 'Mot de passe requis';
                                  if (v.length < 6) return 'Au moins 6 caractères';
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16),
                              WoodTextField(
                                label: 'Combien font $_num1 + $_num2 ?',
                                controller: _arithmeticCtrl,
                                keyboardType: TextInputType.number,
                                prefixIcon: Icons.calculate_outlined,
                                textInputAction: TextInputAction.done,
                                onSubmitted: (_) => _submit(),
                                validator: (v) => v == null || v.isEmpty ? 'Répondez au calcul' : null,
                              ),
                              const SizedBox(height: 8),
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: () => context.push(AppRoutes.forgotPassword),
                                  child: Text(
                                    'Mot de passe oublié ?',
                                    style: TextStyle(
                                      color: isDark ? AppColors.appleGreen : AppColors.emeraldPrimary,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              BlocBuilder<AuthBloc, AuthState>(
                                builder: (context, state) => WoodButton(
                                  label: 'Se connecter',
                                  isLoading: state is AuthLoading,
                                  icon: Icons.login_rounded,
                                  width: double.infinity,
                                  onPressed: _submit,
                                ),
                              ),
                              const SizedBox(height: 18),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Pas encore de compte ?',
                                    style: TextStyle(
                                      color: isDark ? AppColors.textPrimary.withOpacity(0.7) : AppColors.textDark.withOpacity(0.7),
                                      fontSize: 13,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () => context.push(AppRoutes.register),
                                    child: Text(
                                      "S'inscrire",
                                      style: TextStyle(
                                        color: isDark ? AppColors.appleGreen : AppColors.emeraldPrimary,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
