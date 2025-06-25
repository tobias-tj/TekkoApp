import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:tekko/features/api/data/bloc/send_pin/send_pin_bloc.dart';
import 'package:tekko/features/core/utils/storage_utils.dart';
import 'package:tekko/styles/app_colors.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  String statusMessage = 'Validando correo...';

  @override
  void initState() {
    super.initState();
    _sendPinByEmail();
  }

  Future<void> _sendPinByEmail() async {
    final token = await StorageUtils.getString('token');
    if (token != null) {
      context.read<SendPinBloc>().add(SendPinRequested(token: token));
    } else {
      _showError('No se encontró el token.');
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red[600],
        content: Row(
          children: [
            Icon(Icons.error_outline, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(
                child:
                    Text(message, style: const TextStyle(color: Colors.white))),
          ],
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  void _goNext() {
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) context.pushReplacement('/maps');
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final waveHeight = size.height * 0.3; // Calcula la altura del límite

    return Scaffold(
      backgroundColor: AppColors.softCream,
      body: BlocListener<SendPinBloc, SendPinState>(
        listener: (context, state) {
          if (state is SendPinLoading) {
            setState(() => statusMessage = 'Validando datos...');
          } else if (state is SendPinSuccess) {
            setState(() => statusMessage = 'Validación completada');

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.green[600],
                content: Row(
                  children: [
                    Icon(Icons.check_circle_outline, color: Colors.white),
                    const SizedBox(width: 12),
                    Expanded(
                        child: Text(state.message,
                            style: const TextStyle(color: Colors.white))),
                  ],
                ),
                behavior: SnackBarBehavior.floating,
                duration: const Duration(seconds: 4),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                margin: const EdgeInsets.all(16),
              ),
            );

            _goNext();
          } else if (state is SendPinError) {
            setState(() => statusMessage = 'Error al enviar PIN');
            _showError(state.error);
          }
        },
        child: Stack(
          children: [
            Container(
              width: size.width,
              height: size.height,
              color: AppColors.softCream,
            ),
            const CustomBackground(),
            Positioned(
              top: waveHeight,
              left: 0,
              right: 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Lottie.asset("assets/animations/dogChill.json",
                      width: 250, height: 250),
                  const SizedBox(height: 20),
                  const Text(
                    'TEKKO',
                    style: TextStyle(
                      fontSize: 38,
                      fontWeight: FontWeight.bold,
                      color: AppColors.softCreamDark,
                      letterSpacing: 2,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Lottie.asset("assets/animations/loadingFrame.json",
                      width: 100, height: 100),
                  const SizedBox(height: 5),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    transitionBuilder: (child, anim) =>
                        FadeTransition(opacity: anim, child: child),
                    child: Text(
                      statusMessage,
                      key: ValueKey<String>(statusMessage),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textColor,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
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
    return Image.asset(
      'assets/images/bgsplash.png',
      width: size.width,
      height: size.height,
      fit: BoxFit.cover,
    );
  }
}
