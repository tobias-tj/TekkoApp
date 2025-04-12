import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tekko/components/button_intro.dart';
import 'package:tekko/features/api/data/models/auth_model.dart';
import 'package:tekko/features/api/data/bloc/auth_bloc.dart';
import 'package:tekko/features/core/utils/storage_utils.dart';
import 'package:tekko/styles/app_colors.dart';
import 'package:tekko/components/input_account.dart';

class RegisterAccount extends StatefulWidget {
  const RegisterAccount({super.key});

  @override
  State<RegisterAccount> createState() => _RegisterAccountState();
}

class _RegisterAccountState extends State<RegisterAccount> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;

  void _goToLogin() {
    // Lógica para redirigir al Login
    context.goNamed('login');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (_isLoading) return;

    setState(() => _isLoading = true);

    if (_passwordController.text.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('La contraseña debe tener al menos 6 caracteres'),
        ),
      );
      setState(() => _isLoading = false);
      return;
    }
    try {
      final nameKid = await StorageUtils.getString('userName') ?? '';
      final ageKid = await StorageUtils.getInt('userAge') ?? 0;

      final authModel = AuthModel(
          fullNameParent: _nameController.text,
          email: _emailController.text,
          password: _passwordController.text,
          nameKid: nameKid,
          ageKid: ageKid);
      context.read<AuthBloc>().add(RegisterRequested(authModel: authModel));
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            StorageUtils.setInt('parentId', state.parentId ?? 0);
            StorageUtils.setInt('childrenId', state.childrenId ?? 0);

            // await showSuccessAnimation();

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
                              image: AssetImage("assets/images/shibaIcon.png"),
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
                      'Register',
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
                            hintText: "Nombre Completo",
                            inputController: _nameController,
                            isPass: false,
                            inputType: TextInputType.name,
                          ),
                          const SizedBox(height: 20),
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
                          const SizedBox(height: 30),
                          ButtonIntro(
                            onNext: _register,
                            textButton: _isLoading
                                ? 'Creando cuenta...'
                                : 'Crear Cuenta',
                            isParent: true,
                          ),
                          const SizedBox(height: 20),
                          TextButton(
                            onPressed: _goToLogin,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Ya Tienes Una Cuenta?',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: AppColors.chocolateDark,
                                  ),
                                ),
                                SizedBox(width: 8),
                                const Text(
                                  'Sign In',
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
          ),
        ));
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
