import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tekko/components/button_intro.dart';
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

  void _goToRegister() {
    // Lógica para redirigir al Register
    context.goNamed('register');
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (_isLoading) return;

    setState(() => _isLoading = true);

    final loginModel = LoginModel(
        email: _emailController.text, password: _passwordController.text);
    context.read<AuthBloc>().add(LoginRequested(loginModel: loginModel));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            StorageUtils.setString('token', state.token);

            if (mounted) {
              context.goNamed('home');
            }
          } else if (state is AuthFailure) {
            setState(() => _isLoading = false);
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        child: Scaffold(
            backgroundColor: AppColors.cardBackgroundSoft,
            body: Stack(
              children: [
                Container(
                  width: size.width,
                  height: size.height,
                  color: AppColors.softCream,
                ),
                const CustomBackground(),
                Positioned(
                  top: 80,
                  left: 0,
                  right: 0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              image: const DecorationImage(
                                image:
                                    AssetImage("assets/images/shibaIcon.png"),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          const SizedBox(width: 6),
                          const Text(
                            'TEKKO',
                            style: TextStyle(
                              fontSize: 45,
                              fontWeight: FontWeight.bold,
                              color: AppColors.cardMaskSoft,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      const Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: AppColors.softCream,
                          letterSpacing: 1,
                        ),
                      ),
                      const SizedBox(height: 80),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            InputAccount(
                              hintText: "Ingresar Correo Electrónico",
                              inputController: _emailController,
                              isPass: false,
                              inputType: TextInputType.emailAddress,
                            ),
                            const SizedBox(height: 20),
                            InputAccount(
                              hintText: "Ingresar Contraseña",
                              inputController: _passwordController,
                              isPass: true,
                              inputType: TextInputType.text,
                            ),
                            const SizedBox(height: 10),
                            TextButton(
                              onPressed: () => {},
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Olvidaste tu Contraseña?',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: AppColors.chocolateDark,
                                    ),
                                  ),
                                  SizedBox(width: 4),
                                  const Text(
                                    'Recuperar Cuenta',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: AppColors.chocolateNewDark,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                            ButtonIntro(
                              onNext: _login,
                              textButton:
                                  _isLoading ? 'Ingresando...' : 'Ingresar',
                              isParent: true,
                            ),
                            const SizedBox(height: 20),
                            TextButton(
                              onPressed: _goToRegister,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'No Tienes Una Cuenta?',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: AppColors.chocolateDark,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  const Text(
                                    'Register Now',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: AppColors.chocolateNewDark,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )));
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
