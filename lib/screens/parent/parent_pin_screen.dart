import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:animate_do/animate_do.dart';
import 'package:tekko/features/api/data/bloc/security_pin/security_pin_bloc.dart';
import 'package:tekko/features/api/data/models/security_model.dart';
import 'package:tekko/features/core/utils/storage_utils.dart';
import 'package:tekko/styles/app_colors.dart';

class ParentPinScreen extends StatefulWidget {
  final String email;
  const ParentPinScreen({super.key, required this.email});

  @override
  State<ParentPinScreen> createState() => _ParentPinScreenState();
}

class _ParentPinScreenState extends State<ParentPinScreen> {
  final TextEditingController _pinController = TextEditingController();
  bool _isLoading = false;
  bool _isResending = false;

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  Future<void> _accessParent() async {
    if (_isLoading) return;
    setState(() => _isLoading = true);

    if (_pinController.text.isEmpty) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('⚠️ Por favor complete el campo PIN.'),
          backgroundColor: Colors.orange,
          duration: Duration(seconds: 1),
        ),
      );
      return;
    }

    final token = await StorageUtils.getString('token');
    final accessParent = SecurityModel(pin: _pinController.text, token: token!);

    context
        .read<SecurityPinBloc>()
        .add(SecurityPinRequested(securityModel: accessParent));
  }

  Future<void> _resendPin() async {
    if (_isResending) return;
    setState(() => _isResending = true);

    try {
      final token = await StorageUtils.getString('token');
      if (token == null) throw Exception('Token no encontrado');

      context
          .read<SecurityPinBloc>()
          .add(SendSecurityPinRequested(token: token, email: widget.email));

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Se ha reenviado tu PIN al correo registrado."),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red[600],
          content: Row(
            children: [
              const Icon(Icons.error_outline, color: Colors.white),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  "No se ha podido reenviar el PIN: ${e.toString()}",
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          margin: const EdgeInsets.all(16),
        ),
      );
    } finally {
      setState(() => _isResending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SecurityPinBloc, SecurityPinState>(
      listener: (context, state) {
        if (state is SecurityPinSuccess) {
          if (mounted) context.goNamed('adminHome');
        } else if (state is SecurityPinError) {
          setState(() => _isLoading = false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red[600],
              content: Row(
                children: [
                  const Icon(Icons.error_outline, color: Colors.white),
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
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              margin: const EdgeInsets.all(16),
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.softCream,
        body: Stack(
          children: [
            Positioned(
              top: 40,
              right: 20,
              child: GestureDetector(
                onTap: () => context.pop(),
                child: const Icon(Icons.close,
                    size: 28, color: AppColors.chocolateNewDark),
              ),
            ),
            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FadeInDown(
                      duration: const Duration(milliseconds: 800),
                      child: const Text(
                        "🔑 Modo Padres",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: AppColors.chocolateNewDark,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElasticIn(
                      duration: const Duration(milliseconds: 700),
                      child: TextField(
                        controller: _pinController,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "PIN",
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        keyboardType: TextInputType.text,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 30),

                    /// 🔥 Reemplazo del card por contenedor animado y moderno
                    FadeInUp(
                      duration: const Duration(milliseconds: 900),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFFFFEFD5), // tono crema suave
                              Color(0xFFFFDAB9), // durazno claro
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Pulse(
                              duration: const Duration(seconds: 2),
                              infinite: true,
                              child: const Icon(Icons.info_outline,
                                  color: AppColors.chocolateNewDark, size: 28),
                            ),
                            const SizedBox(width: 12),
                            const Expanded(
                              child: Text(
                                '🔒 ¿Es tu primer ingreso?\nRevisá tu correo electrónico asociado. Tu PIN fue enviado cuando se creó tu cuenta.',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: AppColors.chocolateNewDark,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),
                    FadeInUp(
                      delay: const Duration(milliseconds: 500),
                      child: TextButton(
                        onPressed: _isResending ? null : _resendPin,
                        child: Text(
                          _isResending
                              ? 'Reenviando PIN...'
                              : '¿Olvidaste tu PIN? Reenviar',
                          style: const TextStyle(
                            color: AppColors.chocolateNewDark,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),

                    /// Botón animado
                    ZoomIn(
                      duration: const Duration(milliseconds: 600),
                      child: ElevatedButton(
                        key: ValueKey(_isLoading),
                        onPressed: _accessParent,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.chocolateNewDark,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14.0),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 60, vertical: 14.0),
                          elevation: 4,
                        ),
                        child: Text(
                          _isLoading ? 'Ingresando...' : 'Ingresar',
                          style: const TextStyle(
                            color: AppColors.textColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
