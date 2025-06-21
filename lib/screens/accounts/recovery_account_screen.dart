import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tekko/components/button_intro.dart';
import 'package:tekko/components/input_account.dart';
import 'package:tekko/features/api/data/bloc/recovery/recovery_bloc.dart';
import 'package:tekko/screens/accounts/login_account_screen.dart';
import 'package:tekko/styles/app_colors.dart';

class RecoveryAccount extends StatefulWidget {
  const RecoveryAccount({super.key});

  @override
  State<RecoveryAccount> createState() => _RecoveryAccountState();
}

class _RecoveryAccountState extends State<RecoveryAccount> {
  final TextEditingController _emailController = TextEditingController();

  bool _isLoading = false;

  Future<void> _recoveryAccount() async {
    if (_isLoading || _emailController.text.isEmpty) return;

    setState(() => _isLoading = true);

    context
        .read<RecoveryBloc>()
        .add(RecoveryRequested(email: _emailController.text));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocListener<RecoveryBloc, RecoveryState>(
      listener: (context, state) {
        if (state is RecoverySuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.green[600],
              content: Row(
                children: [
                  Icon(Icons.check_circle_outline, color: Colors.white),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      state.message,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              behavior: SnackBarBehavior.floating,
              duration: const Duration(seconds: 4),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              margin: const EdgeInsets.all(16),
            ),
          );
          if (mounted) {
            context.goNamed('login');
          }
        } else if (state is RecoveryError) {
          setState(() => _isLoading = false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
          );
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
                  FadeInDown(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            image: const DecorationImage(
                                image:
                                    AssetImage('assets/images/shibaIcon.png'),
                                fit: BoxFit.fill),
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Text('TEKKO',
                            style: TextStyle(
                              fontSize: 45,
                              fontWeight: FontWeight.bold,
                              color: AppColors.cardMaskSoft,
                            )),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  FadeInDown(
                    delay: Duration(milliseconds: 200),
                    child: Text(
                      'Recuperar Cuenta',
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: AppColors.softCream,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                  const SizedBox(height: 80),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        FadeInLeft(
                          delay: Duration(milliseconds: 300),
                          child: InputAccount(
                            hintText: "Ingresar Correo Electrónico",
                            inputController: _emailController,
                            isPass: false,
                            inputType: TextInputType.emailAddress,
                          ),
                        ),
                        const SizedBox(height: 40),
                        FadeInUp(
                          delay: Duration(milliseconds: 400),
                          child: ButtonIntro(
                            onNext: _recoveryAccount,
                            textButton:
                                _isLoading ? 'Enviando al email...' : 'Enviar',
                            isParent: true,
                          ),
                        ),
                        const SizedBox(height: 15),
                        FadeInUp(
                          delay: Duration(milliseconds: 450),
                          child: ButtonIntro(
                            onNext: () => context.goNamed('login'),
                            textButton: 'Cancelar',
                            isParent: false,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
