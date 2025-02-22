import 'package:flutter/material.dart';
import 'package:tekko/styles/app_colors.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.softCream,
      appBar: AppBar(
        title: const Text("Modo Padres - Administrador"),
      ),
      body: const Center(
        child: Text(
          "Bienvenido al Modo Padres",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.chocolateNewDark,
          ),
        ),
      ),
    );
  }
}
