import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:tekko/features/api/data/bloc/setting/setting_bloc.dart';
import 'package:tekko/features/core/utils/storage_utils.dart';
import 'package:tekko/styles/app_colors.dart';

class UpdatePinScreen extends StatefulWidget {
  const UpdatePinScreen({super.key});

  @override
  State<UpdatePinScreen> createState() => _UpdatePinScreenState();
}

class _UpdatePinScreenState extends State<UpdatePinScreen> {
  final TextEditingController _currentPinController = TextEditingController();
  final TextEditingController _newPinController = TextEditingController();
  final TextEditingController _confirmPinController = TextEditingController();

  bool _isLoading = false;
  bool _showCurrentPin = false;
  bool _showNewPin = false;
  bool _showConfirmPin = false;

  @override
  void dispose() {
    _currentPinController.dispose();
    _newPinController.dispose();
    _confirmPinController.dispose();
    super.dispose();
  }

  Future<void> _updatePin() async {
    if (_isLoading) return;

    // Validaciones básicas
    if (_currentPinController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor ingrese su PIN actual'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (_newPinController.text.isEmpty || _newPinController.text.length < 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('El nuevo PIN debe tener al menos 4 caracteres'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (_newPinController.text.length > 8) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('El PIN no puede exceder los 8 caracteres'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (_newPinController.text != _confirmPinController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Los PINs nuevos no coinciden'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final token = await StorageUtils.getString('token');

    setState(() => _isLoading = true);

    context.read<SettingBloc>().add(SettingUpdatePinTokenRequested(
          token: token!,
          pinToken: _confirmPinController.text,
          oldToken: _currentPinController.text,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SettingBloc, SettingState>(
        listener: (context, state) {
          if (state is SettingUpdatePinTokenSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(state.message), backgroundColor: Colors.green));
            Navigator.pop(context);
          } else if (state is SettingError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(state.message), backgroundColor: Colors.red));
            setState(() => _isLoading = false);
          }
        },
        child: Scaffold(
          backgroundColor: AppColors.softCream,
          appBar: AppBar(
            backgroundColor: AppColors.softCream,
            elevation: 0,
            title: FadeInRight(
              child: const Text(
                'Cambiar PIN',
                style: TextStyle(
                  color: AppColors.chocolateNewDark,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
            ),
            leading: IconButton(
              icon: FadeInLeft(
                child: const Icon(Icons.arrow_back,
                    color: AppColors.chocolateNewDark, size: 28),
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const SizedBox(height: 20),

                // Card para PIN actual
                FadeInUp(
                  child: Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                HugeIcons.strokeRoundedBlocked,
                                size: 28,
                                color: AppColors.chocolateNewDark,
                              ),
                              const SizedBox(width: 12),
                              const Text(
                                'PIN Actual',
                                style: TextStyle(
                                  color: AppColors.chocolateNewDark,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          TextField(
                            controller: _currentPinController,
                            obscureText: !_showCurrentPin,
                            keyboardType: TextInputType.text,
                            maxLength: 8,
                            decoration: InputDecoration(
                              hintText: 'Ingrese su PIN actual',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _showCurrentPin
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: AppColors.chocolateNewDark,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _showCurrentPin = !_showCurrentPin;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Card para Nuevo PIN
                FadeInUp(
                  delay: const Duration(milliseconds: 100),
                  child: Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                HugeIcons.strokeRoundedCircleLockCheck01,
                                size: 28,
                                color: AppColors.chocolateNewDark,
                              ),
                              const SizedBox(width: 12),
                              const Text(
                                'Nuevo PIN',
                                style: TextStyle(
                                  color: AppColors.chocolateNewDark,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          TextField(
                            controller: _newPinController,
                            obscureText: !_showNewPin,
                            keyboardType: TextInputType.text,
                            maxLength: 8,
                            decoration: InputDecoration(
                              hintText: 'Ingrese nuevo PIN (4-8 dígitos)',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _showNewPin
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: AppColors.chocolateNewDark,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _showNewPin = !_showNewPin;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Card para Confirmar nuevo PIN
                FadeInUp(
                  delay: const Duration(milliseconds: 200),
                  child: Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                HugeIcons.strokeRoundedCircleLockCheck01,
                                size: 28,
                                color: AppColors.chocolateNewDark,
                              ),
                              const SizedBox(width: 12),
                              const Text(
                                'Confirmar Nuevo PIN',
                                style: TextStyle(
                                  color: AppColors.chocolateNewDark,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          TextField(
                            controller: _confirmPinController,
                            obscureText: !_showConfirmPin,
                            keyboardType: TextInputType.text,
                            maxLength: 8,
                            decoration: InputDecoration(
                              hintText: 'Confirme su nuevo PIN',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _showConfirmPin
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: AppColors.chocolateNewDark,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _showConfirmPin = !_showConfirmPin;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                // Botón para actualizar
                FadeInUp(
                  delay: const Duration(milliseconds: 300),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _updatePin,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.chocolateNewDark,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: _isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                              'Actualizar PIN',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
