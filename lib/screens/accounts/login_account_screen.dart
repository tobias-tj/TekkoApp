import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tekko/components/button_intro.dart';
import 'package:tekko/components/google_button.dart';
import 'package:tekko/components/input_account.dart';
import 'package:tekko/features/api/data/bloc/auth_bloc.dart';
import 'package:tekko/features/api/data/models/login_model.dart';
import 'package:tekko/features/core/utils/storage_utils.dart';
import 'package:tekko/styles/app_colors.dart';

class LoginAccount extends StatefulWidget {
  const LoginAccount({super.key});

  @override
  State<LoginAccount> createState() => _LoginAccountState();
}

class _LoginAccountState extends State<LoginAccount> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;

  String? _emailError;
  String? _passwordError;

  void _goToRegister() => context.goNamed('register');
  void _goToRecoveryAccount() => context.goNamed('recovery');

  bool _isValidEmail(String email) {
    final regex = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');
    return regex.hasMatch(email);
  }

  Future<void> _login() async {
    if (_isLoading) return;

    setState(() {
      _emailError = _emailController.text.isEmpty
          ? 'El correo es obligatorio'
          : !_isValidEmail(_emailController.text)
              ? 'Correo inválido'
              : null;

      _passwordError = _passwordController.text.isEmpty
          ? 'La contraseña es obligatoria'
          : _passwordController.text.length < 6
              ? 'Debe tener al menos 6 caracteres'
              : null;
    });

    // Si hay errores, no continúa
    if (_emailError != null || _passwordError != null) return;

    setState(() => _isLoading = true);

    try {
      final loginModel = LoginModel(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      context.read<AuthBloc>().add(LoginRequested(loginModel: loginModel));
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
    }
  }

  Future<void> _loginWithGoogle() async {
    try {
      setState(() => _isLoading = true);

      const scopes = [
        'https://www.googleapis.com/auth/userinfo.email',
        'https://www.googleapis.com/auth/userinfo.profile',
        'openid',
      ];
      final googleSignIn = GoogleSignIn.instance;
      await googleSignIn.initialize(
        serverClientId:
            '746910990367-lmf3ajat3u3lmmkh52bqfptub12luc09.apps.googleusercontent.com',
      );

      final googleUser = await googleSignIn.authenticate(scopeHint: scopes);

      final googleAuthentication = googleUser.authentication;

      final idToken = googleAuthentication.idToken;

      if (idToken == null) {
        throw Exception("Google no devolvió idToken");
      }

      context.read<AuthBloc>().add(
            LoginWithGoogleRequested(idToken: idToken),
          );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          StorageUtils.setString('token', state.token);
          if (mounted) context.goNamed('home');
        } else if (state is AuthFailure) {
          setState(() => _isLoading = false);
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.error)));
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: AppColors.cardBackgroundSoft,
        body: Stack(
          children: [
            const CustomBackground(),
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  const _Header(),
                  const SizedBox(height: 60),

                  // Email
                  InputAccount(
                    hintText: "Ingresar Correo Electrónico",
                    inputController: _emailController,
                    isPass: false,
                    inputType: TextInputType.emailAddress,
                    errorText: _emailError,
                  ),
                  const SizedBox(height: 20),

                  // Password
                  InputAccount(
                    hintText: "Ingresar Contraseña",
                    inputController: _passwordController,
                    isPass: true,
                    inputType: TextInputType.text,
                    errorText: _passwordError,
                  ),
                  const SizedBox(height: 10),

                  GestureDetector(
                    onTap: _goToRecoveryAccount,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 14, horizontal: 25),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: AppColors.chocolateNewDark.withOpacity(0.1),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            '¿Olvidaste tu contraseña?',
                            style: TextStyle(
                              fontSize: 13,
                              color: AppColors.chocolateDark,
                            ),
                          ),
                          SizedBox(width: 4),
                          Text(
                            'Recuperar cuenta',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.chocolateNewDark,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Botón de login
                  ButtonIntro(
                    onNext: _login,
                    textButton: _isLoading ? 'Ingresando...' : 'Ingresar',
                    isParent: true,
                  ),

                  const SizedBox(height: 15),

                  GoogleButton(
                    onPressed: _loginWithGoogle,
                    loading: _isLoading,
                  ),
                  const SizedBox(height: 20),

                  // Botón de registro
                  GestureDetector(
                    onTap: _goToRegister,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 14, horizontal: 25),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: AppColors.chocolateNewDark.withOpacity(0.1),
                      ),
                      child: const Text(
                        '¿No tienes una cuenta?  Regístrate',
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.chocolateDark,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomBackground extends StatelessWidget {
  const CustomBackground({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.4,
      child: Image.asset(
        'assets/images/topTitleAccount.png',
        width: size.width,
        height: size.height,
        fit: BoxFit.cover,
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset("assets/images/shibaIcon.png", width: 70),
        const SizedBox(height: 10),
        const Text(
          'TEKKO',
          style: TextStyle(
            fontSize: 42,
            fontWeight: FontWeight.bold,
            color: AppColors.cardMaskSoft,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 5),
        const Text(
          'Ingresar a la Cuenta',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: AppColors.softCreamDark,
          ),
        ),
      ],
    );
  }
}
