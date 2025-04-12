import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tekko/features/api/data/bloc/security_pin/security_pin_bloc.dart';
import 'package:tekko/features/api/data/models/security_model.dart';
import 'package:tekko/features/core/utils/storage_utils.dart';
import 'package:tekko/styles/app_colors.dart';

class ParentPinScreen extends StatefulWidget {
  const ParentPinScreen({super.key});

  @override
  State<ParentPinScreen> createState() => _ParentPinScreenState();
}

class _ParentPinScreenState extends State<ParentPinScreen> {
  final TextEditingController _pinController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  Future<void> _accessParent() async {
    if (_isLoading) return;

    setState(() => _isLoading = true);

    final parentId = await StorageUtils.getInt('parentId') ?? 0;

    final accessParent =
        SecurityModel(pin: _pinController.text, parentId: parentId);
    context
        .read<SecurityPinBloc>()
        .add(SecurityPinRequested(securityModel: accessParent));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SecurityPinBloc, SecurityPinState>(
      listener: (context, state) {
        if (state is SecurityPinSuccess) {
          if (mounted) {
            context.goNamed('adminHome');
          }
        } else if (state is SecurityPinError) {
          setState(() => _isLoading = false);
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.softCream,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Ingrese el PIN para activar el Modo Padres",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.chocolateNewDark,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _pinController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "PIN",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  keyboardType: TextInputType.text,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _accessParent,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.chocolateNewDark,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 12.0),
                  ),
                  child: Text(
                    _isLoading ? 'Ingresando...' : 'Ingresar',
                    style: TextStyle(
                      color: AppColors.textColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
