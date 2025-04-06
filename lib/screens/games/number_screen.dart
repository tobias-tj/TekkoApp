import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:tekko/styles/app_colors.dart';
import 'number_game.dart';

class NumberScreen extends StatefulWidget {
  const NumberScreen({super.key});

  @override
  State<NumberScreen> createState() => _NumberScreenState();
}

class _NumberScreenState extends State<NumberScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Suma Basica'),
        backgroundColor: AppColors.softCreamDark,
      ),
      body: SafeArea(
        child: NumberGame(),
      ),
      // Aquí agregamos el botón flotante
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushReplacement('/home');
        },
        backgroundColor: AppColors.chocolateBg,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            HugeIcon(
              icon: HugeIcons.strokeRoundedHome01,
              color: AppColors.chocolateNewDark,
              size: 30.0,
            ),
            const Text(
              'Inicio',
              style: TextStyle(
                fontSize: 15,
                color: AppColors.chocolateNewDark,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
